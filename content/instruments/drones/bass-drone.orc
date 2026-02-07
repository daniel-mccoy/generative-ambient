;------------------------------------------------------
; BASS DRONE — Resonant Sub-Bass
;
; Saw + square oscillators through moogladder 24dB/oct
; LP at 280 Hz with high resonance (Q ~40) for growly
; vowel-like character. Wander LFO (randi at 0.21 Hz)
; modulates filter cutoff and oscillator shape for slow
; organic movement.
;
; Based on Meld tutorial bass preset:
;   Osc A: Basic Shapes, Shape 63.5% (mostly square)
;   Osc B: Basic Shapes, Shape 0.0% (pure saw)
;   Filter A: SVF 24dB, 280 Hz, Q 39.8
;   LFO 1: Wander 0.21 Hz → Osc Macro 1 (38%), Filter Freq (27%)
;   LFO 1 FX: Attenuv + Fade In, Scale 72.2%, Ramp 2.4
;
; Requires:
;   ga_rvb_L/R     — reverb send bus (init 0)
;   ga_dly_L/R     — delay send bus (init 0)
;
; p4 = frequency (Hz)
; p5 = peak amplitude (0–1)
;------------------------------------------------------

instr bass_drone

  i_freq = p4
  i_amp  = p5

  ; ========== WANDER LFO (Meld "Wander" mode at 0.21 Hz) ==========
  ; Two randi sources for compound smooth random motion
  k_w1     randi  1, 0.21                 ; primary wander
  k_w2     randi  0.5, 0.09              ; secondary drift (irrational ratio)
  k_wander = (k_w1 + k_w2) / 1.5        ; roughly -1..1

  ; LFO 1 FX: Attenuverter + Fade In
  ; Scale 72.2%, Ramp 2.4s — gradually introduces wander
  k_fade_in linseg 0, 2.4, 1, p3 - 2.4, 1
  k_wander_fx = k_wander * k_fade_in * 0.722

  ; ========== OSCILLATORS ==========
  ; Osc A: Saw (36.5%) + Square (63.5%) — shape blend
  ; LFO 1 → Osc Macro 1 at 38% modulates shape
  k_shape  = 0.635 + k_wander_fx * 0.38 * 0.365   ; wander nudges shape ±14%
  k_shape  limit k_shape, 0, 1
  a_saw_A  vco2   1, i_freq, 0            ; sawtooth
  a_sqr_A  vco2   1, i_freq, 10, 0.5      ; square (50% duty)
  a_osc_A  = a_saw_A * (1 - k_shape) + a_sqr_A * k_shape

  ; Osc B: Pure sawtooth at same pitch
  a_osc_B  vco2   1, i_freq, 0

  ; Mix oscillators equally
  a_osc    = (a_osc_A + a_osc_B) * 0.5

  ; ========== FILTER: moogladder 24dB/oct LP ==========
  ; Base 280 Hz, resonance 0.4 (Q ~40)
  ; LFO 1 → Filter Freq at 27%: ±200 Hz wander around base
  k_cutoff = 280 + k_wander_fx * 0.27 * 740
  k_cutoff limit k_cutoff, 120, 500
  a_filt   moogladder a_osc, k_cutoff, 0.4

  ; ========== ENVELOPE: Simple fade in/out ==========
  ; 5s fade in, long sustain, 8s fade out
  k_fade   linseg 0, 5, 1, p3 - 13, 1, 8, 0

  ; ========== OUTPUT ==========
  a_out    = a_filt * i_amp * k_fade

  ; Slight stereo spread (subtle for bass)
  outs     a_out * 0.55, a_out * 0.45

  ; Low delay send — sub-bass in ping-pong delay = mud
  ga_dly_L = ga_dly_L + a_out * 0.1
  ga_dly_R = ga_dly_R + a_out * 0.1
  ; Moderate reverb send — warmth without blur
  ga_rvb_L = ga_rvb_L + a_out * 0.25
  ga_rvb_R = ga_rvb_R + a_out * 0.25

endin
