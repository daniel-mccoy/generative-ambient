<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

;======================================================
; GEN PULSE — Generative Version
;
; Four layers: bass drone + drone pad + swarm pad + pluck
;
; Layer 1 (Bass Drone): Always-on sub-bass (3) at C1
; with resonant moogladder filter and wander LFO for
; slow organic movement. Mostly felt, not heard.
;
; Layer 2 (Drone Pad): Conductor (100) spawns overlapping
; gen_pulse voices (1) with looping AD envelopes,
; waveform morphing, and filter modulation. C2–C3.
;
; Layer 3 (Swarm Pad): Conductor (102) spawns swarm
; sine + shaped osc voices (4) with slow ADSR and
; glacial LFO evolution (0.01 Hz). C3–C4.
;
; Layer 4 (Pluck): Sequence conductor (101) fires
; probabilistic eighth-note plucks (2) with velocity-
; driven filter sweeps across C minor pentatonic.
;
; Signal chain:
;   conductors (100,101,102) → voices (1,2,3,4) →
;   ping-pong delay (98) → reverb (99)
;======================================================

sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

; C minor pentatonic (one octave): C, Eb, F, G, Bb
gi_scale ftgen 1, 0, -5, -2, 0, 3, 5, 7, 10

; Strong roots for C minor pentatonic (weighted): C, G, F, Eb
; Semitones from C: 0=C, 7=G, 5=F, 3=Eb
gi_roots ftgen 2, 0, 8, -2, 0, 7, 5, 3, 0, 7, 0, 5

; Send buses
ga_rvb_L init 0
ga_rvb_R init 0
ga_dly_L init 0
ga_dly_R init 0

; Per-instrument analysis accumulators (polyphonic → max across voices)
gk_pad_rms   init 0
gk_pad_pulse init 0
gk_swarm_rms init 0
gk_swarm_lfo init 0
gk_pluck_rms init 0

;------------------------------------------------------
; CONDUCTOR — spawns gen_pulse voices over time
;------------------------------------------------------
instr 100

  ; Slow density wave (~50s period): controls gap between events
  k_dens   lfo    1, 0.02, 0
  k_gap_lo = 8 - k_dens * 3             ; 5–11s
  k_gap_hi = 20 - k_dens * 6            ; 14–26s

  ; Timer: counts down, spawns voice at zero, resets
  k_timer  init   2                      ; first note after 2s
  k_timer  -= 1/kr

  if k_timer <= 0 then

    ; Limit to 3 simultaneous voices
    k_voices active 1
    if k_voices < 3 then

      ; --- Pitch selection ---
      ; Pick from weighted roots table (favors root + fifth)
      k_ridx   random 0, 7.99
      k_semi   table  int(k_ridx), 2    ; gi_roots

      ; Constrained to C2–C3 range (leave room for bass below)
      k_freq   = 65.41 * semitone(k_semi)            ; C2 base
      k_freq   limit k_freq, 65.41, 130.81           ; C2–C3

      ; Duration: 30–60s (longer voices = fewer audible transitions)
      k_dur    random 30, 60

      ; Amplitude: quieter voices when more are active
      k_amp    random 0.10, 0.18
      k_amp    = k_amp / (1 + k_voices * 0.3)

      ; Spawn
      event    "i", 1, 0, k_dur, k_freq, k_amp

    endif

    ; Reset timer with randomized gap
    k_timer  random k_gap_lo, k_gap_hi

  endif

endin

;------------------------------------------------------
; GENERATIVE PULSE
;------------------------------------------------------
instr 1

  i_base = p4
  i_amp  = p5
  i_att  = 0.001                       ; 1ms attack (matches Meld)

  ; ===== MODULATION SOURCES =====

  ; "Wander" — two detuned sines for irregular motion
  ; Drives: osc B detune + filter cutoff
  k_w1     lfo    1, 0.07, 0           ; sine ~14s
  k_w2     lfo    0.6, 0.031, 0        ; sine ~32s
  k_wander = (k_w1 + k_w2) / 1.6

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

  ; ===== ENVELOPE A: Looping AD (breathing pulses) =====
  ; Exponential decay (k^2) — fast initial drop, long gentle tail

  k_rate   = 1 / (i_att + k_dec)
  k_envA   loopseg k_rate, 0, 0,  0, i_att, 1, k_dec, 0
  k_envA   = k_envA * k_envA           ; exponential decay shape
  k_envA   port   k_envA, 0.01

  ; ===== ENVELOPE B: Slow ADSR (sustained pad bed) =====
  ; A=4.47s, D=4.97s, S=-4.3dB(≈0.61), R=2.66s — not looping

  i_atkB   = 4.47
  i_decB   = 4.97
  i_susLvl = 0.61
  i_relB   = 2.66
  i_susT   = p3 - i_atkB - i_decB - i_relB
  i_susT   = (i_susT > 0.01) ? i_susT : 0.01
  k_envB   linseg 0, i_atkB, 1, i_decB, i_susLvl, i_susT, i_susLvl, i_relB, 0

  ; ===== OSCILLATOR A (root pitch) =====

  ; LFO 1 → Osc Macro 1 (shape): 41%
  a_saw1   vco2   1, i_base, 0
  k_pw     = 0.5 + k_lfo1 * 0.15
  a_pls1   vco2   1, i_base, 2, k_pw
  k_shape  = k_lfo1 * 0.41
  a_osc1   = a_saw1 * (1 - k_shape) + a_pls1 * k_shape

  ; ===== OSCILLATOR B (scale-detuned) =====

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

  ; ===== FILTERS (separate per oscillator) =====

  ; Filter A: SVF 12dB (butterlp) at 2.4 kHz on Osc A
  ; LFO 1 FX → Filter Freq: 55% (smoothed pulse opens filter)
  k_cutA   = 2000 + k_lfo1fx * 800 + k_wander * 150
  k_cutA   limit  k_cutA, 1500, 3000
  a_filtA  butterlp a_osc1, k_cutA

  ; Filter B: Membrane resonator at 755 Hz, Q reduced to tame ringing
  k_resF   = 755 + k_wander * 60
  a_filtB  mode a_osc2, k_resF, 12

  ; ===== OUTPUT =====

  ; Apply separate envelopes: A pulses, B sustains
  a_outA   = a_filtA * k_envA * 0.55
  a_outB   = a_filtB * k_envB * 0.45

  ; Fade in (5s) and fade out (8s) — slow enough to be imperceptible
  k_fade   linseg 0, 5, 1, p3 - 13, 1, 8, 0
  a_out    = (a_outA + a_outB) * i_amp * k_fade
  outs     a_out * 0.6, a_out * 0.4

  ; Per-instrument analysis (accumulate max across overlapping voices)
  k_rms    rms    a_out
  gk_pad_rms   max gk_pad_rms, k_rms
  gk_pad_pulse max gk_pad_pulse, k_envA

  ; Delay send
  ga_dly_L = ga_dly_L + a_out * 0.35
  ga_dly_R = ga_dly_R + a_out * 0.35
  ; Reverb send (more reverb for ambient wash)
  ga_rvb_L = ga_rvb_L + a_out * 0.45
  ga_rvb_R = ga_rvb_R + a_out * 0.45

endin

;------------------------------------------------------
; SEQUENCE CONDUCTOR — probabilistic pluck sequencer
;------------------------------------------------------
instr 101

  ; Eighth-note clock at 80 BPM → 2.667 Hz
  ; 30% of ticks skip to quarter-note spacing (adds breathing room)
  k_tick   metro  2.667

  if k_tick == 1 then

    ; 70% eighth note, 30% skip (quarter note gap)
    k_skip   random 0, 1
    if k_skip < 0.70 then

      ; 75% note probability (~12/16 steps active, more space)
      k_roll   random 0, 1
      if k_roll < 0.75 then

        ; Polyphony limit: max 8 simultaneous pluck voices
        k_active active 2
        if k_active < 8 then

          ; --- Pitch: scale-quantized across 1.5 octaves from C3 ---
          ; Pick random degree from C minor pentatonic
          k_deg    random 0, 4.99
          k_semi   table  int(k_deg), gi_scale    ; 0,3,5,7,10
          ; Spread across 1.5 octaves: base octave + random offset
          k_oct_off random 0, 17.99               ; 0–17 semitones ≈ 1.5 oct
          k_oct_off = int(k_oct_off)
          ; Re-quantize to nearest scale degree
          k_total  = k_semi + k_oct_off
          ; Wrap into scale via modulo + octave tracking
          k_octave = int(k_total / 12)
          k_rem    = k_total - k_octave * 12
          ; Snap remainder to nearest pentatonic degree
          ; C=0, Eb=3, F=5, G=7, Bb=10
          k_snap = (k_rem < 2) ? 0 : (k_rem < 4) ? 3 : (k_rem < 6) ? 5 : (k_rem < 9) ? 7 : 10
          k_freq   = 130.81 * semitone(k_snap + k_octave * 12)

          ; 20% chance of octave up
          k_up     random 0, 1
          k_freq   = (k_up < 0.2) ? k_freq * 2 : k_freq

          ; Clamp to reasonable range (C2–C5)
          k_freq   limit k_freq, 65.41, 1046.5

          ; --- Velocity: wide range matching MIDI 12–124 ---
          k_vel    random 0.09, 0.98

          ; --- Pan: spread across stereo field ---
          k_pan    random 0.2, 0.8

          ; --- Spawn pluck note (3.0s covers 2.67s decay + headroom) ---
          event    "i", 2, 0, 3.0, k_freq, k_vel, k_pan

          ; 15% chance of double-trigger (Stepic divider=2)
          k_dbl    random 0, 1
          if k_dbl < 0.15 then
            ; Slight timing offset for double (half an eighth note later)
            event  "i", 2, 0.1875, 3.0, k_freq, k_vel * 0.8, 1 - k_pan
          endif

        endif
      endif
    endif
  endif

endin

;------------------------------------------------------
; PLUCK SYNTH — Meld Basic Shapes pluck
;------------------------------------------------------
instr 2

  i_freq = p4
  i_vel  = p5
  i_pan  = p6

  ; ===== AMP ENVELOPE: 5ms attack, 2.67s decay, zero sustain =====
  ; Squared for exponential decay slope (50% D Slope in Meld)
  ; 5ms avoids click (1ms is <2 k-periods at ksmps=32)
  k_aenv   linseg 0, 0.005, 1, 2.67, 0
  k_aenv   = k_aenv * k_aenv

  ; ===== MOD ENVELOPE: 5ms attack, 1.69s decay (faster than amp) =====
  ; Drives filter — closes before volume fades out
  k_menv   linseg 0, 0.005, 1, 1.69, 0
  k_menv   = k_menv * k_menv

  ; ===== OSCILLATOR: Saw + Square blend at 42.9% =====
  a_saw    vco2   1, i_freq, 0               ; sawtooth
  a_sqr    vco2   1, i_freq, 10, 0.5         ; square (50% duty)
  a_osc    = a_saw * 0.571 + a_sqr * 0.429   ; 42.9% shape blend

  ; ===== FILTER: 24dB/oct LP (cascaded butterlp) =====
  ; Base 313 Hz, modulated by A Env (38%), M Env (53%), Velocity (36%)
  ; Depth scaled so peak with max velocity reaches ~2000–2500 Hz
  i_base_cut = 313
  i_depth    = 4000                           ; modulation depth in Hz
  k_fmod   = k_aenv * 0.38 + k_menv * 0.53 + i_vel * 0.36
  k_cutoff = i_base_cut + k_fmod * i_depth
  k_cutoff limit k_cutoff, 200, 12000

  ; Two cascaded 12dB butterlp = 24dB/oct
  a_filt   butterlp a_osc, k_cutoff
  a_filt   butterlp a_filt, k_cutoff

  ; ===== OUTPUT =====
  ; Volume: velocity × 18% — sits back, headroom for 8 voices summing
  i_vol    = i_vel * 0.18

  ; Stereo pan using sqrt pan law
  i_panL   = sqrt(1 - i_pan)
  i_panR   = sqrt(i_pan)

  a_out    = a_filt * k_aenv * i_vol
  a_outL   = a_out * i_panL
  a_outR   = a_out * i_panR

  outs     a_outL, a_outR

  ; Per-instrument analysis (short integration for transient tracking)
  k_rms    rms    a_out, 20
  gk_pluck_rms max gk_pluck_rms, k_rms

  ; Send to shared effects (high delay send — first echo nearly as loud as dry)
  ga_dly_L = ga_dly_L + a_outL * 0.9
  ga_dly_R = ga_dly_R + a_outR * 0.9
  ga_rvb_L = ga_rvb_L + a_outL * 0.35
  ga_rvb_R = ga_rvb_R + a_outR * 0.35

endin

;------------------------------------------------------
; PAD CONDUCTOR — spawns swarm pad voices
;------------------------------------------------------
instr 102

  ; Slow spawning — pads overlap with long envelopes
  k_timer  init   6                      ; first voice after 6s
  k_timer  -= 1/kr

  if k_timer <= 0 then

    k_voices active 4
    if k_voices < 3 then

      ; Pitch: C3–C4 from pentatonic roots
      k_ridx   random 0, 7.99
      k_semi   table  int(k_ridx), 2    ; gi_roots (weighted)
      k_freq   = 130.81 * semitone(k_semi)   ; C3 base
      k_freq   limit k_freq, 130.81, 261.63  ; C3–C4

      ; Duration: 35–65s (long enough for slow ADSR)
      k_dur    random 35, 65

      ; Amplitude: quieter when more voices active
      k_amp    random 0.22, 0.35
      k_amp    = k_amp / (1 + k_voices * 0.25)

      event    "i", 4, 0, k_dur, k_freq, k_amp

    endif

    ; Reset timer: 15–30s between spawns
    k_timer  random 15, 30

  endif

endin

;------------------------------------------------------
; SWARM PAD — Detuned sine cluster + shaped oscillator
;
; Osc A: Swarm Sine (7 detuned sines, Motion 34.1,
; Spacing 61.1) — shimmery ethereal texture.
; Osc B: Basic Shapes (Shape 52.4%) — adds body.
; Very slow LFO (0.01 Hz) evolves shape and filter.
;
; Filter A: SVF 12dB LP at 3.52 kHz (on swarm)
; Filter B: Membrane Resonator at 8.49 kHz (on shapes)
;
; Amp: A 4.47s, D 6.10s, S -5.5dB, R 1.69s
;
; p4 = frequency (Hz)
; p5 = amplitude (0–1)
;------------------------------------------------------
instr 4

  i_freq = p4
  i_amp  = p5

  ; ===== LFO 1: Glacial evolution (0.01 Hz = 100s period) =====
  ; Basic Shapes with Shape 46, Fold 100 — complex slowly-changing modulator
  ; Approximate: slow triangle folded through sine for rich shape
  k_phs    phasor 0.01
  k_tri    = 1 - 4 * abs(k_phs - 0.5)           ; triangle -1..1
  k_lfo1   = sin(k_tri * $M_PI)                   ; fold creates complex motion

  ; LFO 1 FX: Skew Uni + Fade In, Shape 12.7%, Ramp 24.6s
  k_lfo1_fade linseg 0, 24.6, 1, p3 - 24.6, 1
  k_lfo1_fx = (k_lfo1 * 0.5 + 0.5) * k_lfo1_fade ; skew unipolar: 0..1

  ; ===== LFO 2: Mid-range movement (0.04 Hz = 25s period) =====
  ; Adds faster modulation for filter sweep and shape morphing
  k_phs2   phasor 0.04
  k_lfo2   = sin(k_phs2 * 2 * $M_PI)             ; smooth sine 0.04 Hz
  k_lfo2   = k_lfo2 * 0.5 + 0.5                   ; unipolar 0..1

  ; ===== SWARM (Osc A) =====
  ; 7 detuned voices with per-voice amplitude drift — each voice
  ; slowly fades in/out independently so the texture constantly shifts.
  ; Wider spacing + 3rd/5th partials at low levels for harmonic presence.
  i_spr    = 0.002                                 ; ~3.5 cents per step

  ; Per-voice pitch drift
  k_d1     randi  0.003, 0.41
  k_d2     randi  0.003, 0.33
  k_d3     randi  0.003, 0.47
  k_d4     randi  0.003, 0.37
  k_d5     randi  0.003, 0.44
  k_d6     randi  0.003, 0.31
  k_d7     randi  0.003, 0.49

  ; Per-voice amplitude drift (irrational rates so they never sync)
  ; Range 0.3–1.0: voices never fully disappear but constantly rebalance
  k_a1     randi  0.35, 0.07
  k_a2     randi  0.35, 0.11
  k_a3     randi  0.35, 0.05
  k_a4     randi  0.35, 0.09
  k_a5     randi  0.35, 0.13
  k_a6     randi  0.35, 0.06
  k_a7     randi  0.35, 0.10
  k_a1     = 0.65 + k_a1
  k_a2     = 0.65 + k_a2
  k_a3     = 0.65 + k_a3
  k_a4     = 0.65 + k_a4
  k_a5     = 0.65 + k_a5
  k_a6     = 0.65 + k_a6
  k_a7     = 0.65 + k_a7

  ; Fundamentals
  a_s1     oscili k_a1, i_freq * (1 - i_spr*3 + k_d1)
  a_s2     oscili k_a2, i_freq * (1 - i_spr*2 + k_d2)
  a_s3     oscili k_a3, i_freq * (1 - i_spr   + k_d3)
  a_s4     oscili k_a4, i_freq * (1            + k_d4)
  a_s5     oscili k_a5, i_freq * (1 + i_spr   + k_d5)
  a_s6     oscili k_a6, i_freq * (1 + i_spr*2 + k_d6)
  a_s7     oscili k_a7, i_freq * (1 + i_spr*3 + k_d7)

  ; 3rd partial (~12%) — slightly detuned from exact 3:1 for warmth
  a_h3_1   oscili k_a1*0.12, i_freq * 3.003 * (1 - i_spr*3 + k_d1)
  a_h3_4   oscili k_a4*0.12, i_freq * 2.997 * (1            + k_d4)
  a_h3_7   oscili k_a7*0.12, i_freq * 3.005 * (1 + i_spr*3 + k_d7)

  ; 5th partial (~6%) on alternating voices — airy upper presence
  a_h5_2   oscili k_a2*0.06, i_freq * 5.002 * (1 - i_spr*2 + k_d2)
  a_h5_5   oscili k_a5*0.06, i_freq * 4.998 * (1 + i_spr   + k_d5)

  a_swarm  = (a_s1 + a_s2 + a_s3 + a_s4 + a_s5 + a_s6 + a_s7) / 7
  a_swarm  = a_swarm + (a_h3_1 + a_h3_4 + a_h3_7 + a_h5_2 + a_h5_5) / 5

  ; Filtered noise breath — adds air and texture between the tones
  a_noise  noise  0.03, 0
  a_noise  butterbp a_noise, i_freq * 2, i_freq * 1.5
  a_noise  butterlp a_noise, 6000
  a_swarm  = a_swarm + a_noise

  ; ===== BASIC SHAPES (Osc B) =====
  ; Shape 52.4% — slightly more square than saw
  ; LFO 1 → Osc Macro 1 at 48%, LFO 2 adds faster shape movement
  a_saw    vco2   1, i_freq, 0
  a_sqr    vco2   1, i_freq, 10, 0.5
  k_shape  = 0.524 + k_lfo1_fx * 0.48 + k_lfo2 * 0.15
  k_shape  limit  k_shape, 0, 1
  a_oscB   = a_saw * (1 - k_shape) + a_sqr * k_shape

  ; ===== FILTERS =====
  ; Filter A: SVF 12dB LP — wider sweep with both LFOs
  ; LFO 1 (glacial) + LFO 2 (mid-range) for layered movement
  k_cutA   = 3520 + k_lfo1_fx * 0.47 * 3000 + k_lfo2 * 1500
  k_cutA   limit  k_cutA, 1500, 8000
  a_filtA  butterlp a_swarm, k_cutA

  ; Filter B: Membrane Resonator at 8.49 kHz — airy shimmer on shapes
  ; Higher LP ceiling to let more harmonics through
  a_filtB  mode   a_oscB, 8490, 2
  a_filtB  butterlp a_filtB, 5500

  ; ===== AMP ENVELOPE =====
  ; A: 4.47s, D: 6.10s, S: -5.5 dB (0.53), R: 1.69s
  i_atkA   = 4.47
  i_decA   = 6.10
  i_susLvl = 0.53
  i_relA   = 1.69
  i_susT   = p3 - i_atkA - i_decA - i_relA
  i_susT   = (i_susT > 0.01) ? i_susT : 0.01
  k_env    linseg 0, i_atkA, 1, i_decA, i_susLvl, i_susT, i_susLvl, i_relA, 0

  ; ===== OUTPUT =====
  ; Mix: swarm dominant (ethereal), shapes for body and harmonics
  a_mix    = (a_filtA * 0.65 + a_filtB * 0.35) * i_amp * k_env * 1.8

  ; Safety fade in/out
  k_fade   linseg 0, 3, 1, p3 - 8, 1, 5, 0
  a_out    = a_mix * k_fade

  outs     a_out * 0.5, a_out * 0.5

  ; Per-instrument analysis (accumulate max across overlapping voices)
  k_rms    rms    a_out
  gk_swarm_rms max gk_swarm_rms, k_rms
  gk_swarm_lfo max gk_swarm_lfo, k_lfo1_fx

  ; Moderate delay send — pad echoes add width
  ga_dly_L = ga_dly_L + a_out * 0.25
  ga_dly_R = ga_dly_R + a_out * 0.25
  ; Heavy reverb send — lush wash
  ga_rvb_L = ga_rvb_L + a_out * 0.5
  ga_rvb_R = ga_rvb_R + a_out * 0.5

endin

;------------------------------------------------------
; BASS DRONE — resonant sub-bass at C1
;
; Saw + square oscillators through moogladder 24dB/oct
; LP at 280 Hz with high resonance (Q ~40) for growly
; vowel-like character. Wander LFO modulates filter
; cutoff and oscillator shape for slow organic movement.
;
; p4 = frequency (Hz)
; p5 = amplitude (0–1)
;------------------------------------------------------
instr 3

  i_freq = p4
  i_amp  = p5

  ; ===== WANDER LFO (Meld "Wander" mode at 0.21 Hz) =====
  ; Two randi sources for compound smooth random motion
  k_w1     randi  1, 0.21                 ; primary wander
  k_w2     randi  0.5, 0.09              ; secondary drift (irrational ratio)
  k_wander = (k_w1 + k_w2) / 1.5        ; roughly -1..1

  ; LFO 1 FX: Attenuverter + Fade In
  ; Scale 72.2%, Ramp 2.4s — gradually introduces wander
  k_fade_in linseg 0, 2.4, 1, p3 - 2.4, 1
  k_wander_fx = k_wander * k_fade_in * 0.722

  ; ===== OSCILLATORS =====
  ; Osc A: Saw (36.5%) + Square (63.5%) — shape blend
  ; LFO 1 → Osc Macro 1 at 38% modulates shape ±30%
  k_shape  = 0.635 + k_wander_fx * 0.47      ; wider timbral shift
  k_shape  limit k_shape, 0, 1
  a_saw_A  vco2   1, i_freq, 0            ; sawtooth
  a_sqr_A  vco2   1, i_freq, 10, 0.5      ; square (50% duty)
  a_osc_A  = a_saw_A * (1 - k_shape) + a_sqr_A * k_shape

  ; Osc B: Pure sawtooth at same pitch
  a_osc_B  vco2   1, i_freq, 0

  ; Mix oscillators equally
  a_osc    = (a_osc_A + a_osc_B) * 0.5

  ; ===== FILTER: moogladder 24dB/oct LP =====
  ; Base 350 Hz, resonance 0.55 — pronounced growl
  ; LFO 1 → Filter Freq: ±400 Hz wander for audible sweeps
  k_cutoff = 350 + k_wander_fx * 560
  k_cutoff limit k_cutoff, 140, 800
  a_filt   moogladder a_osc, k_cutoff, 0.72

  ; ===== ENVELOPE: Simple fade in/out =====
  ; 5s fade in, long sustain, 8s fade out
  k_fade   linseg 0, 5, 1, p3 - 13, 1, 8, 0

  ; ===== OUTPUT =====
  a_out    = a_filt * i_amp * k_fade * 2.0

  ; Slight stereo spread (Spread→Pan 50%, subtle for bass)
  outs     a_out * 0.55, a_out * 0.45

  ; Per-instrument analysis (single instance — write channels directly)
  k_rms    rms    a_out
  k_rms    port   k_rms, 0.05
  chnset   k_rms, "bass_rms"
  ; Normalize cutoff to 0–1 range for shader use
  k_cut_n  = (k_cutoff - 140) / (800 - 140)
  k_cut_n  limit k_cut_n, 0, 1
  k_cut_n  port   k_cut_n, 0.05
  chnset   k_cut_n, "bass_cutoff"

  ; Low delay send — sub-bass in ping-pong delay = mud
  ga_dly_L = ga_dly_L + a_out * 0.15
  ga_dly_R = ga_dly_R + a_out * 0.15
  ; Reverb send — warmth and presence
  ga_rvb_L = ga_rvb_L + a_out * 0.4
  ga_rvb_R = ga_rvb_R + a_out * 0.4

endin

;------------------------------------------------------
; CHANNEL WRITER — smooths polyphonic accumulators
; and writes to named channels for JS polling.
; Runs after voices (1-4) but before effects (98-99).
;------------------------------------------------------
instr 97

  ; Smooth accumulated values (port ~50ms for gentle transitions)
  k_pr     port   gk_pad_rms, 0.05
  k_pp     port   gk_pad_pulse, 0.05
  k_sr     port   gk_swarm_rms, 0.05
  k_sl     port   gk_swarm_lfo, 0.05
  k_plr    port   gk_pluck_rms, 0.02     ; shorter for transient response

  ; Write to named channels
  chnset   k_pr,  "pad_rms"
  chnset   k_pp,  "pad_pulse"
  chnset   k_sr,  "swarm_rms"
  chnset   k_sl,  "swarm_lfo"
  chnset   k_plr, "pluck_rms"

  ; Reset accumulators for next k-cycle
  gk_pad_rms   = 0
  gk_pad_pulse = 0
  gk_swarm_rms = 0
  gk_swarm_lfo = 0
  gk_pluck_rms = 0

endin

;------------------------------------------------------
; PING-PONG DELAY — dotted eighths at 80 BPM
;------------------------------------------------------
instr 98

  i_bpm    = 80
  i_eighth = 60 / i_bpm / 2
  i_dotted = i_eighth * 1.5            ; 0.5625s
  i_maxdel = 2.0

  k_fb     = 0.65
  k_wet    = 0.55

  k_mod    lfo    0.003, 0.23, 0

  a_tap_L  init   0
  a_tap_R  init   0

  a_buf_L  delayr i_maxdel
  a_tap_L  deltap3 i_dotted + k_mod
           delayw ga_dly_L + a_tap_R * k_fb

  a_buf_R  delayr i_maxdel
  a_tap_R  deltap3 i_dotted - k_mod
           delayw ga_dly_R + a_tap_L * k_fb

  outs     a_tap_L * k_wet, a_tap_R * k_wet

  ga_rvb_L = ga_rvb_L + a_tap_L * 0.2
  ga_rvb_R = ga_rvb_R + a_tap_R * 0.2

  ga_dly_L = 0
  ga_dly_R = 0

endin

;------------------------------------------------------
; REVERB
;------------------------------------------------------
instr 99
  a_L, a_R reverbsc ga_rvb_L, ga_rvb_R, 0.88, 7000
  outs     a_L * 0.6, a_R * 0.6
  ga_rvb_L = 0
  ga_rvb_R = 0
endin

</CsInstruments>
<CsScore>

; Run indefinitely — stop via UI button
i100 0 99999       ; drone pad conductor
i101 0 99999       ; pluck sequence conductor
i102 0 99999       ; swarm pad conductor
i3   0 99999 32.70 0.60  ; bass drone at C1 (32.7 Hz)
i97  0 99999       ; channel writer (after voices, before effects)
i98  0 99999       ; ping-pong delay
i99  0 99999       ; reverb
</CsScore>
</CsoundSynthesizer>
