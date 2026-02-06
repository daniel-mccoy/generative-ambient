<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

;======================================================
; GEN PULSE TEST
; Generative pulse drone: looping AD envelope with
; randomized decay, dual oscillators with scale-detuned
; second voice, Moog-style LFO-modulated filter, reverb.
;
; One held note — the looping envelope + modulation
; creates all the rhythmic and timbral variation.
;======================================================

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

; A natural minor: intervals in semitones from root
gi_scale ftgen 1, 0, 8, -2, 0, 2, 3, 5, 7, 8, 10, 12

; Reverb send bus
ga_rvb_L init 0
ga_rvb_R init 0

;------------------------------------------------------
; GENERATIVE PULSE
;------------------------------------------------------
instr 1

  i_base = p4
  i_amp  = p5
  i_att  = 0.04

  ; Random S&H: new value ~every 2s, controls decay time
  k_rnd  randh  1, 0.5
  k_dec  = 0.4 + (k_rnd + 1) * 0.5 * 2.6   ; 0.4–3.0s

  ; Looping AD envelope
  k_rate = 1 / (i_att + k_dec)
  k_env  loopseg k_rate, 0, 0,  0, i_att, 1, k_dec, 0
  k_env  port   k_env, 0.008

  ; Osc A: sawtooth at root
  a_osc1 vco2   1, i_base, 0

  ; Osc B: scale-detuned saw (wandering through scale degrees)
  k_wand lfo    3.5, 0.07, 1           ; slow triangle ~14s
  k_raw  = k_wand + 3.5                ; 0–7
  k_idx  = int(k_raw)
  k_idx  limit  k_idx, 0, 7
  k_semi table  k_idx, gi_scale
  k_freq2 = i_base * semitone(k_semi)
  a_osc2 vco2   1, k_freq2, 0

  ; Mix + filter
  a_mix  = a_osc1 * 0.55 + a_osc2 * 0.45
  k_flfo lfo    1, 0.11, 0             ; sine ~9s
  k_cut  = 1400 + k_flfo * 1100        ; 300–2500 Hz
  a_filt moogladder a_mix, k_cut, 0.35

  ; Gentle 3s fade-in
  k_fade linseg 0, 3, 1, p3 - 3, 1

  ; Output
  a_out  = a_filt * k_env * i_amp * k_fade
  outs   a_out * 0.6, a_out * 0.4

  ; Reverb send
  ga_rvb_L = ga_rvb_L + a_out * 0.45
  ga_rvb_R = ga_rvb_R + a_out * 0.45

endin

;------------------------------------------------------
; REVERB
;------------------------------------------------------
instr 99
  a_L, a_R reverbsc ga_rvb_L, ga_rvb_R, 0.88, 10000
  outs     a_L * 0.4, a_R * 0.4
  ga_rvb_L = 0
  ga_rvb_R = 0
endin

</CsInstruments>
<CsScore>

; Reverb always on
i99 0 70

; Single held note — A2 (110 Hz)
; The looping envelope creates all the rhythmic variation
;     start dur  freq  amp
i1    0     60   110   0.35

e
</CsScore>
</CsoundSynthesizer>
