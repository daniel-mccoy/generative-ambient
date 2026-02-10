<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

;======================================================
; OCEAN WAVES — Field Recording Looper
;
; Crossfade-looped ocean field recording (DPA binaural)
; with LP/HP filtering and reverb wash.
; Sample loaded into virtual FS before compilation.
;======================================================

sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

; Load stereo sample from virtual filesystem (written by JS before compile)
gi_sample_L ftgen 1, 0, 0, 1, "ocean-roar.wav", 0, 0, 1
gi_sample_R ftgen 2, 0, 0, 1, "ocean-roar.wav", 0, 0, 2
gi_dur = ftlen(gi_sample_L) / sr

; Send buses
ga_rvb_L init 0
ga_rvb_R init 0

;------------------------------------------------------
; OCEAN LOOPER
;------------------------------------------------------
instr 1

  ; Loop the full sample with crossfade (palindrome mode)
  ; flooper2: kamp, kpitch, kloopstart, kloopend, kcrossfade, ifn, istart, imode
  ; imode 2 = forward-backward (palindrome)
  k_speed = 0.6
  k_xfade = 2.0        ; generous 2s crossfade for seamless loop
  k_start = 0
  k_end   = gi_dur

  aL flooper2 1, k_speed, k_start, k_end, k_xfade, gi_sample_L, 0, 2
  aR flooper2 1, k_speed, k_start, k_end, k_xfade, gi_sample_R, 0, 2

  ; LP filter — gentle rolloff for warmth
  aL moogladder aL, 5500, 0.07
  aR moogladder aR, 5500, 0.07

  ; HP — remove sub-rumble
  aL butterhp aL, 23
  aR butterhp aR, 23

  ; Warmth — gentle saturation
  aL = tanh(aL * 1.6)
  aR = tanh(aR * 1.6)

  ; Output
  aL = aL * 0.7
  aR = aR * 0.7
  outs aL, aR

  ; Reverb send
  ga_rvb_L = ga_rvb_L + aL * 0.45
  ga_rvb_R = ga_rvb_R + aR * 0.45

endin

;------------------------------------------------------
; REVERB
;------------------------------------------------------
instr 99
  a_L, a_R reverbsc ga_rvb_L, ga_rvb_R, 0.88, 7000
  outs     a_L * 0.5, a_R * 0.5
  ga_rvb_L = 0
  ga_rvb_R = 0
endin

</CsInstruments>
<CsScore>
i1  0 99999    ; ocean looper
i99 0 99999    ; reverb
</CsScore>
</CsoundSynthesizer>
