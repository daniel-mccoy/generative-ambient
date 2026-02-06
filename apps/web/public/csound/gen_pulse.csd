<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

;======================================================
; GEN PULSE — Generative Version
;
; Two layers: drone + pluck sequence
;
; Layer 1 (Drone): Conductor (100) spawns overlapping
; gen_pulse voices (1) with looping AD envelopes,
; waveform morphing, and filter modulation.
;
; Layer 2 (Pluck): Sequence conductor (101) fires
; probabilistic eighth-note plucks (2) with velocity-
; driven filter sweeps across C minor pentatonic.
;
; Signal chain:
;   conductors (100,101) → voices (1,2) →
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

  ; Send to shared effects (high delay send — first echo nearly as loud as dry)
  ga_dly_L = ga_dly_L + a_outL * 0.9
  ga_dly_R = ga_dly_R + a_outR * 0.9
  ga_rvb_L = ga_rvb_L + a_outL * 0.35
  ga_rvb_R = ga_rvb_R + a_outR * 0.35

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
i100 0 99999
i101 0 99999
i98  0 99999
i99  0 99999
</CsScore>
</CsoundSynthesizer>
