<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

;======================================================
; DEEP FOCUS — Swarm Pad (solo)
;
; Conductor (102) spawns detuned sine cluster + shaped
; oscillator voices (4) with slow ADSR and glacial LFO
; evolution (0.01 Hz). C3–C4 range. Ethereal shimmer.
;======================================================

sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

; Strong roots for C minor pentatonic (weighted): C, G, F, Eb
gi_roots ftgen 2, 0, 8, -2, 0, 7, 5, 3, 0, 7, 0, 5

; Send buses
ga_rvb_L init 0
ga_rvb_R init 0
ga_dly_L init 0
ga_dly_R init 0

; Per-instrument analysis accumulators
gk_swarm_rms init 0
gk_swarm_lfo init 0

;------------------------------------------------------
; PAD CONDUCTOR — spawns swarm pad voices
;------------------------------------------------------
instr 102

  k_timer  init   6
  k_timer  -= 1/kr

  if k_timer <= 0 then

    k_voices active 4
    if k_voices < 3 then

      k_ridx   random 0, 7.99
      k_semi   table  int(k_ridx), 2
      k_freq   = 130.81 * semitone(k_semi)
      k_freq   limit k_freq, 130.81, 261.63

      k_dur    random 35, 65

      k_amp    random 0.22, 0.35
      k_amp    = k_amp / (1 + k_voices * 0.25)

      event    "i", 4, 0, k_dur, k_freq, k_amp

    endif

    k_timer  random 15, 30

  endif

endin

;------------------------------------------------------
; SWARM PAD — Detuned sine cluster + shaped oscillator
;------------------------------------------------------
instr 4

  i_freq = p4
  i_amp  = p5

  ; ===== LFO 1: Glacial evolution (0.01 Hz = 100s period) =====
  k_phs    phasor 0.01
  k_tri    = 1 - 4 * abs(k_phs - 0.5)
  k_lfo1   = sin(k_tri * $M_PI)

  k_lfo1_fade linseg 0, 24.6, 1, p3 - 24.6, 1
  k_lfo1_fx = (k_lfo1 * 0.5 + 0.5) * k_lfo1_fade

  ; ===== LFO 2: Mid-range movement (0.04 Hz = 25s period) =====
  k_phs2   phasor 0.04
  k_lfo2   = sin(k_phs2 * 2 * $M_PI)
  k_lfo2   = k_lfo2 * 0.5 + 0.5

  ; ===== SWARM (Osc A) =====
  i_spr    = 0.002

  k_d1     randi  0.003, 0.41
  k_d2     randi  0.003, 0.33
  k_d3     randi  0.003, 0.47
  k_d4     randi  0.003, 0.37
  k_d5     randi  0.003, 0.44
  k_d6     randi  0.003, 0.31
  k_d7     randi  0.003, 0.49

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

  ; 3rd partial (~12%)
  a_h3_1   oscili k_a1*0.12, i_freq * 3.003 * (1 - i_spr*3 + k_d1)
  a_h3_4   oscili k_a4*0.12, i_freq * 2.997 * (1            + k_d4)
  a_h3_7   oscili k_a7*0.12, i_freq * 3.005 * (1 + i_spr*3 + k_d7)

  ; 5th partial (~6%)
  a_h5_2   oscili k_a2*0.06, i_freq * 5.002 * (1 - i_spr*2 + k_d2)
  a_h5_5   oscili k_a5*0.06, i_freq * 4.998 * (1 + i_spr   + k_d5)

  a_swarm  = (a_s1 + a_s2 + a_s3 + a_s4 + a_s5 + a_s6 + a_s7) / 7
  a_swarm  = a_swarm + (a_h3_1 + a_h3_4 + a_h3_7 + a_h5_2 + a_h5_5) / 5

  ; Filtered noise breath
  a_noise  noise  0.03, 0
  a_noise  butterbp a_noise, i_freq * 2, i_freq * 1.5
  a_noise  butterlp a_noise, 6000
  a_swarm  = a_swarm + a_noise

  ; ===== BASIC SHAPES (Osc B) =====
  a_saw    vco2   1, i_freq, 0
  a_sqr    vco2   1, i_freq, 10, 0.5
  k_shape  = 0.524 + k_lfo1_fx * 0.48 + k_lfo2 * 0.15
  k_shape  limit  k_shape, 0, 1
  a_oscB   = a_saw * (1 - k_shape) + a_sqr * k_shape

  ; ===== FILTERS =====
  k_cutA   = 3520 + k_lfo1_fx * 0.47 * 3000 + k_lfo2 * 1500
  k_cutA   limit  k_cutA, 1500, 8000
  a_filtA  butterlp a_swarm, k_cutA

  a_filtB  mode   a_oscB, 8490, 2
  a_filtB  butterlp a_filtB, 5500

  ; ===== AMP ENVELOPE =====
  i_atkA   = 4.47
  i_decA   = 6.10
  i_susLvl = 0.53
  i_relA   = 1.69
  i_susT   = p3 - i_atkA - i_decA - i_relA
  i_susT   = (i_susT > 0.01) ? i_susT : 0.01
  k_env    linseg 0, i_atkA, 1, i_decA, i_susLvl, i_susT, i_susLvl, i_relA, 0

  ; ===== OUTPUT =====
  a_mix    = (a_filtA * 0.65 + a_filtB * 0.35) * i_amp * k_env * 1.8

  k_fade   linseg 0, 3, 1, p3 - 8, 1, 5, 0
  a_out    = a_mix * k_fade

  outs     a_out * 0.5, a_out * 0.5

  ; Per-instrument analysis
  k_rms    rms    a_out
  gk_swarm_rms max gk_swarm_rms, k_rms
  gk_swarm_lfo max gk_swarm_lfo, k_lfo1_fx

  ; Effect sends
  ga_dly_L = ga_dly_L + a_out * 0.25
  ga_dly_R = ga_dly_R + a_out * 0.25
  ga_rvb_L = ga_rvb_L + a_out * 0.5
  ga_rvb_R = ga_rvb_R + a_out * 0.5

endin

;------------------------------------------------------
; CHANNEL WRITER
;------------------------------------------------------
instr 97

  k_sr     port   gk_swarm_rms, 0.05
  k_sl     port   gk_swarm_lfo, 0.05

  chnset   k_sr,  "swarm_rms"
  chnset   k_sl,  "swarm_lfo"

  gk_swarm_rms = 0
  gk_swarm_lfo = 0

endin

;------------------------------------------------------
; PING-PONG DELAY — dotted eighths at 80 BPM
;------------------------------------------------------
instr 98

  i_bpm    = 80
  i_eighth = 60 / i_bpm / 2
  i_dotted = i_eighth * 1.5
  i_maxdel = 2.0

  k_fb     = 0.65
  k_wet    = 0.88

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
i102 0 99999       ; swarm pad conductor
i97  0 99999       ; channel writer
i98  0 99999       ; delay
i99  0 99999       ; reverb
</CsScore>
</CsoundSynthesizer>
