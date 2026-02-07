<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

; Swarm pad solo test

sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

gi_roots ftgen 2, 0, 8, -2, 0, 7, 5, 3, 0, 7, 0, 5

ga_rvb_L init 0
ga_rvb_R init 0
ga_dly_L init 0
ga_dly_R init 0

;------------------------------------------------------
; PAD CONDUCTOR
;------------------------------------------------------
instr 102

  k_timer  init   2
  k_timer  -= 1/kr

  if k_timer <= 0 then

    k_voices active 4
    if k_voices < 3 then

      k_ridx   random 0, 7.99
      k_semi   table  int(k_ridx), 2
      k_freq   = 130.81 * semitone(k_semi)
      k_freq   limit k_freq, 130.81, 261.63

      k_dur    random 35, 65
      k_amp    random 0.15, 0.25
      k_amp    = k_amp / (1 + k_voices * 0.25)

      event    "i", 4, 0, k_dur, k_freq, k_amp

    endif

    k_timer  random 12, 25

  endif

endin

;------------------------------------------------------
; SWARM PAD
;------------------------------------------------------
instr 4

  i_freq = p4
  i_amp  = p5

  k_phs    phasor 0.01
  k_tri    = 1 - 4 * abs(k_phs - 0.5)
  k_lfo1   = sin(k_tri * $M_PI)

  k_lfo1_fade linseg 0, 24.6, 1, p3 - 24.6, 1
  k_lfo1_fx = (k_lfo1 * 0.5 + 0.5) * k_lfo1_fade

  i_spr    = 0.0006

  k_d1     randi  0.0008, 0.31
  k_d2     randi  0.0008, 0.27
  k_d3     randi  0.0008, 0.34
  k_d4     randi  0.0008, 0.29
  k_d5     randi  0.0008, 0.33
  k_d6     randi  0.0008, 0.26
  k_d7     randi  0.0008, 0.36

  a_s1     oscili 1, i_freq * (1 - i_spr*3 + k_d1)
  a_s2     oscili 1, i_freq * (1 - i_spr*2 + k_d2)
  a_s3     oscili 1, i_freq * (1 - i_spr   + k_d3)
  a_s4     oscili 1, i_freq * (1            + k_d4)
  a_s5     oscili 1, i_freq * (1 + i_spr   + k_d5)
  a_s6     oscili 1, i_freq * (1 + i_spr*2 + k_d6)
  a_s7     oscili 1, i_freq * (1 + i_spr*3 + k_d7)

  a_swarm  = (a_s1 + a_s2 + a_s3 + a_s4 + a_s5 + a_s6 + a_s7) / 7

  a_saw    vco2   1, i_freq, 0
  a_sqr    vco2   1, i_freq, 10, 0.5
  k_shape  = 0.524 + k_lfo1_fx * 0.48
  k_shape  limit  k_shape, 0, 1
  a_oscB   = a_saw * (1 - k_shape) + a_sqr * k_shape

  k_cutA   = 3520 + k_lfo1_fx * 0.47 * 3000
  k_cutA   limit  k_cutA, 1200, 7000
  a_filtA  butterlp a_swarm, k_cutA

  a_filtB  mode   a_oscB, 8490, 2
  a_filtB  butterlp a_filtB, 4000

  i_atkA   = 4.47
  i_decA   = 6.10
  i_susLvl = 0.53
  i_relA   = 1.69
  i_susT   = p3 - i_atkA - i_decA - i_relA
  i_susT   = (i_susT > 0.01) ? i_susT : 0.01
  k_env    linseg 0, i_atkA, 1, i_decA, i_susLvl, i_susT, i_susLvl, i_relA, 0

  a_mix    = (a_filtA * 0.75 + a_filtB * 0.25) * i_amp * k_env

  k_fade   linseg 0, 3, 1, p3 - 8, 1, 5, 0
  a_out    = a_mix * k_fade

  outs     a_out * 0.5, a_out * 0.5

  ga_dly_L = ga_dly_L + a_out * 0.25
  ga_dly_R = ga_dly_R + a_out * 0.25
  ga_rvb_L = ga_rvb_L + a_out * 0.5
  ga_rvb_R = ga_rvb_R + a_out * 0.5

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
i102 0 99999
i98  0 99999
i99  0 99999
</CsScore>
</CsoundSynthesizer>
