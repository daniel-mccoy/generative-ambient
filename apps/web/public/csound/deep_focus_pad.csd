<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

;======================================================
; DEEP FOCUS — Drone Pad (solo)
;
; Conductor (100) spawns overlapping drone voices (1)
; with looping AD envelopes, waveform morphing, and
; filter modulation. C2–C3 range, scale-detuned Osc B.
;======================================================

sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

; C minor pentatonic (one octave): C, Eb, F, G, Bb
gi_scale ftgen 1, 0, -5, -2, 0, 3, 5, 7, 10

; Strong roots for C minor pentatonic (weighted): C, G, F, Eb
gi_roots ftgen 2, 0, 8, -2, 0, 7, 5, 3, 0, 7, 0, 5

; Send buses
ga_rvb_L init 0
ga_rvb_R init 0
ga_dly_L init 0
ga_dly_R init 0

; Per-instrument analysis accumulators
gk_pad_rms   init 0
gk_pad_pulse init 0

;------------------------------------------------------
; CONDUCTOR — spawns drone voices over time
;------------------------------------------------------
instr 100

  k_dens   lfo    1, 0.02, 0
  k_gap_lo = 8 - k_dens * 3
  k_gap_hi = 20 - k_dens * 6

  k_timer  init   2
  k_timer  -= 1/kr

  if k_timer <= 0 then

    k_voices active 1
    if k_voices < 3 then

      k_ridx   random 0, 7.99
      k_semi   table  int(k_ridx), 2

      k_freq   = 65.41 * semitone(k_semi)
      k_freq   limit k_freq, 65.41, 130.81

      k_dur    random 30, 60

      k_amp    random 0.10, 0.18
      k_amp    = k_amp / (1 + k_voices * 0.3)

      event    "i", 1, 0, k_dur, k_freq, k_amp

    endif

    k_timer  random k_gap_lo, k_gap_hi

  endif

endin

;------------------------------------------------------
; DRONE PAD VOICE
;------------------------------------------------------
instr 1

  i_base = p4
  i_amp  = p5
  i_att  = 0.001

  ; ===== MODULATION SOURCES =====

  k_w1     lfo    1, 0.07, 0
  k_w2     lfo    0.6, 0.031, 0
  k_wander = (k_w1 + k_w2) / 1.6

  k_rnd    randh  1, 1.33
  k_dec    = 4.01 + k_rnd * 1.2

  k_phs    phasor 0.04
  k_trig1  trigger k_phs, 0.99, 1
  k_gate_on init 0
  if k_trig1 == 1 then
    k_roll random 0, 100
    k_gate_on = (k_roll < 63.5) ? 1 : 0
  endif
  k_gate_len = 0.23
  k_lfo1   = (k_gate_on == 1 ? (k_phs < k_gate_len ? 1 : 0) : 0)
  k_lfo1   port   k_lfo1, 0.02

  k_lfo1fx port   k_lfo1, 3.4

  ; ===== ENVELOPE A: Looping AD =====

  k_rate   = 1 / (i_att + k_dec)
  k_envA   loopseg k_rate, 0, 0,  0, i_att, 1, k_dec, 0
  k_envA   = k_envA * k_envA
  k_envA   port   k_envA, 0.01

  ; ===== ENVELOPE B: Slow ADSR =====

  i_atkB   = 4.47
  i_decB   = 4.97
  i_susLvl = 0.61
  i_relB   = 2.66
  i_susT   = p3 - i_atkB - i_decB - i_relB
  i_susT   = (i_susT > 0.01) ? i_susT : 0.01
  k_envB   linseg 0, i_atkB, 1, i_decB, i_susLvl, i_susT, i_susLvl, i_relB, 0

  ; ===== OSCILLATOR A (root pitch) =====

  a_saw1   vco2   1, i_base, 0
  k_pw     = 0.5 + k_lfo1 * 0.15
  a_pls1   vco2   1, i_base, 2, k_pw
  k_shape  = k_lfo1 * 0.41
  a_osc1   = a_saw1 * (1 - k_shape) + a_pls1 * k_shape

  ; ===== OSCILLATOR B (scale-detuned) =====

  k_walk   init   2
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

  ; ===== FILTERS =====

  k_cutA   = 2000 + k_lfo1fx * 800 + k_wander * 150
  k_cutA   limit  k_cutA, 1500, 3000
  a_filtA  butterlp a_osc1, k_cutA

  k_resF   = 755 + k_wander * 60
  a_filtB  mode a_osc2, k_resF, 12

  ; ===== OUTPUT =====

  a_outA   = a_filtA * k_envA * 0.55
  a_outB   = a_filtB * k_envB * 0.45

  k_fade   linseg 0, 5, 1, p3 - 13, 1, 8, 0
  a_out    = (a_outA + a_outB) * i_amp * k_fade
  outs     a_out * 0.6, a_out * 0.4

  ; Per-instrument analysis
  k_rms    rms    a_out
  gk_pad_rms   max gk_pad_rms, k_rms
  gk_pad_pulse max gk_pad_pulse, k_envA

  ; Effect sends
  ga_dly_L = ga_dly_L + a_out * 0.35
  ga_dly_R = ga_dly_R + a_out * 0.35
  ga_rvb_L = ga_rvb_L + a_out * 0.45
  ga_rvb_R = ga_rvb_R + a_out * 0.45

endin

;------------------------------------------------------
; CHANNEL WRITER
;------------------------------------------------------
instr 97

  k_pr     port   gk_pad_rms, 0.05
  k_pp     port   gk_pad_pulse, 0.05

  chnset   k_pr,  "pad_rms"
  chnset   k_pp,  "pad_pulse"

  gk_pad_rms   = 0
  gk_pad_pulse = 0

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
i100 0 99999       ; drone pad conductor
i97  0 99999       ; channel writer
i98  0 99999       ; delay
i99  0 99999       ; reverb
</CsScore>
</CsoundSynthesizer>
