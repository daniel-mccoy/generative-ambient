;------------------------------------------------------
; GEN-PULSE — Generative Pulse Drone
;
; Dual-oscillator drone with looping AD envelope (Osc A)
; and slow ADSR pad envelope (Osc B). Saw↔pulse waveform
; morphing driven by probabilistic pulsate gates.
; Osc B wanders through scale degrees via random walk.
; Separate filters: 12dB LP on A, membrane resonator on B.
;
; Modulation architecture (matches Meld tutorial):
;   LFO 1 (Pulsate 0.04 Hz) → Osc shape (41%)
;   LFO 1 FX (Gate+FadeIn)  → Filter A freq (55%)
;   LFO 2 (S&H quarter note)→ Amp Decay (30%)
;   Wander (compound sine)   → Osc B detune + filter cutoff
;
; Requires:
;   gi_scale       — ftable of scale intervals in semitones
;   ga_rvb_L/R     — reverb send bus (init 0)
;   ga_dly_L/R     — delay send bus (init 0)
;
; Note: ping-pong delay needs `a_tap_L/R init 0` before
; delayr/delayw block (WASM compiler requires forward declaration).
;
; p4 = base frequency (Hz)
; p5 = peak amplitude (0–1)
;------------------------------------------------------

instr gen_pulse

  i_base = p4
  i_amp  = p5
  i_att  = 0.001                       ; 1ms attack (matches Meld)

  ; ========== MODULATION SOURCES ==========

  ; "Wander" — two detuned sines for irregular motion
  ; Drives: osc B detune + filter cutoff (compound modulation)
  k_w1     lfo    1, 0.07, 0           ; sine ~14s
  k_w2     lfo    0.6, 0.031, 0        ; sine ~32s (irrational ratio)
  k_wander = (k_w1 + k_w2) / 1.6      ; roughly -1..1

  ; LFO 2: S&H at quarter-note rate (80 BPM → 1.33 Hz)
  ; Controls decay rate — Meld mod depth 30% on Amp Decay
  ; Base decay 4.01s, modulated ±30% → ~2.8–5.2s
  k_rnd    randh  1, 1.33              ; S&H, new value every quarter note
  k_dec    = 4.01 + k_rnd * 1.2       ; 2.8–5.2s (±30% of 4.01)

  ; LFO 1: Pulsate mode — 0.04 Hz (~25s period), Chance 63.5%
  ; Generates probabilistic gates: each "cycle" has 63.5% chance of firing
  ; Length 23.0 controls the on-portion of each gate
  k_phs    phasor 0.04                 ; 0.04 Hz = one cycle per ~25s
  k_trig1  trigger k_phs, 0.99, 1     ; trigger at top of each cycle
  ; On trigger: random chance test (63.5% probability)
  k_gate_on init 0
  if k_trig1 == 1 then
    k_roll random 0, 100
    k_gate_on = (k_roll < 63.5) ? 1 : 0
  endif
  ; Gate length: 23% of cycle period = ~5.75s of the ~25s cycle
  k_gate_len = 0.23
  k_lfo1   = (k_gate_on == 1 ? (k_phs < k_gate_len ? 1 : 0) : 0)
  k_lfo1   port   k_lfo1, 0.02        ; slight edge softening

  ; LFO 1 FX: Gate + Fade In — Time 32.5%, Ramp 34.1%
  ; Creates a slow fade-in envelope on each gate opening
  ; Time ~0.33 × 25s ≈ 8s ramp, smoothed with ~3.4s lag
  k_lfo1fx port   k_lfo1, 3.4         ; long fade-in (~3.4s rise time)

  ; ========== ENVELOPE A: Looping AD (breathing pulses) ==========
  ; Exponential decay (k^2) — fast initial drop, long gentle tail

  k_rate   = 1 / (i_att + k_dec)
  k_envA   loopseg k_rate, 0, 0,  0, i_att, 1, k_dec, 0
  k_envA   = k_envA * k_envA           ; exponential decay shape
  k_envA   port   k_envA, 0.01

  ; ========== ENVELOPE B: Slow ADSR (sustained pad bed) ==========
  ; A=4.47s, D=4.97s, S=-4.3dB(≈0.61), R=2.66s — not looping

  i_atkB   = 4.47
  i_decB   = 4.97
  i_susLvl = 0.61
  i_relB   = 2.66
  i_susT   = p3 - i_atkB - i_decB - i_relB
  i_susT   = (i_susT > 0.01) ? i_susT : 0.01
  k_envB   linseg 0, i_atkB, 1, i_decB, i_susLvl, i_susT, i_susLvl, i_relB, 0

  ; ========== OSCILLATOR A (root pitch) ==========

  ; LFO 1 → Osc Macro 1 (shape): 41%
  a_saw1   vco2   1, i_base, 0
  k_pw     = 0.5 + k_lfo1 * 0.15
  a_pls1   vco2   1, i_base, 2, k_pw
  k_shape  = k_lfo1 * 0.41
  a_osc1   = a_saw1 * (1 - k_shape) + a_pls1 * k_shape

  ; ========== OSCILLATOR B (scale-detuned) ==========

  ; Random walk: ±1 step every ~8s — intervals stay close (2-3 semitones)
  k_walk   init   2                     ; start mid-scale
  k_step   randh  1, 0.12
  k_trig   changed k_step
  if k_trig == 1 then
    k_dir  = (k_step > 0) ? 1 : -1
    k_walk = k_walk + k_dir
    k_walk limit k_walk, 0, 4
  endif
  k_semi   table  k_walk, gi_scale
  k_freq2  = i_base * semitone(k_semi)
  a_saw2   vco2   1, k_freq2, 0
  a_pls2   vco2   1, k_freq2, 2, k_pw
  a_osc2   = a_saw2 * (1 - k_shape * 0.3) + a_pls2 * (k_shape * 0.3)

  ; ========== FILTERS (separate per oscillator) ==========

  ; Filter A: SVF 12dB (butterlp) at 2.4 kHz on Osc A
  ; LFO 1 FX → Filter Freq: 55% (smoothed gate opens filter slowly)
  k_cutA   = 2400 + k_lfo1fx * 1300 + k_wander * 200
  k_cutA   limit  k_cutA, 1800, 4000
  a_filtA  butterlp a_osc1, k_cutA

  ; Filter B: Membrane resonator at 755 Hz, Q=21.9 on Osc B
  k_resF   = 755 + k_wander * 60
  a_filtB  mode a_osc2, k_resF, 22

  ; ========== OUTPUT ==========

  ; Apply separate envelopes: A pulses, B sustains
  a_outA   = a_filtA * k_envA * 0.55
  a_outB   = a_filtB * k_envB * 0.45

  ; Fade in (5s) and fade out (8s) — slow enough to be imperceptible
  k_fade   linseg 0, 5, 1, p3 - 13, 1, 8, 0
  a_out    = (a_outA + a_outB) * i_amp * k_fade
  outs     a_out * 0.6, a_out * 0.4

  ; Delay send
  ga_dly_L = ga_dly_L + a_out * 0.35
  ga_dly_R = ga_dly_R + a_out * 0.35
  ; Reverb send (more reverb for ambient wash)
  ga_rvb_L = ga_rvb_L + a_out * 0.45
  ga_rvb_R = ga_rvb_R + a_out * 0.45

endin
