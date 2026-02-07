<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

; Bass drone solo test

sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

ga_rvb_L init 0
ga_rvb_R init 0
ga_dly_L init 0
ga_dly_R init 0

;------------------------------------------------------
; BASS DRONE — resonant sub-bass at C1
;------------------------------------------------------
instr 3

  i_freq = p4
  i_amp  = p5

  k_w1     randi  1, 0.21
  k_w2     randi  0.5, 0.09
  k_wander = (k_w1 + k_w2) / 1.5

  k_fade_in linseg 0, 2.4, 1, p3 - 2.4, 1
  k_wander_fx = k_wander * k_fade_in * 0.722

  k_shape  = 0.635 + k_wander_fx * 0.47
  k_shape  limit k_shape, 0, 1
  a_saw_A  vco2   1, i_freq, 0
  a_sqr_A  vco2   1, i_freq, 10, 0.5
  a_osc_A  = a_saw_A * (1 - k_shape) + a_sqr_A * k_shape

  a_osc_B  vco2   1, i_freq, 0

  a_osc    = (a_osc_A + a_osc_B) * 0.5

  k_cutoff = 350 + k_wander_fx * 560
  k_cutoff limit k_cutoff, 140, 800
  a_filt   moogladder a_osc, k_cutoff, 0.72

  k_fade   linseg 0, 5, 1, p3 - 13, 1, 8, 0

  a_out    = a_filt * i_amp * k_fade * 2.0

  outs     a_out * 0.55, a_out * 0.45

  ga_dly_L = ga_dly_L + a_out * 0.15
  ga_dly_R = ga_dly_R + a_out * 0.15
  ga_rvb_L = ga_rvb_L + a_out * 0.4
  ga_rvb_R = ga_rvb_R + a_out * 0.4

endin

;------------------------------------------------------
; PING-PONG DELAY
;------------------------------------------------------
instr 98
  i_bpm    = 80
  i_eighth = 60 / i_bpm / 2
  i_dotted = i_eighth * 1.5
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
i3   0 99999 32.70 0.60
i98  0 99999
i99  0 99999
</CsScore>
</CsoundSynthesizer>
