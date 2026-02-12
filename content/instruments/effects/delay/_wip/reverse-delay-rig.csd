<Cabbage>
form caption("Reverse Delay Rig") size(740, 490), colour(30, 30, 50), pluginId("rvdl")

; Header
label bounds(10, 8, 720, 25) text("REVERSE DELAY RIG") fontColour(220, 130, 170) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Dual-buffer reverse echo with crossfade for preverb swells") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(220, 130, 170) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Pings create ghostly reverse swells that build up to the attack. Classic preverb effect.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): REVERSE + FEEDBACK + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 250, 130) text("REVERSE DELAY") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("rv_time") range(0.1, 2, 0.5, 0.5, 0.01) text("Window") textColour(200,200,220) trackerColour(220, 130, 170)
    rslider bounds(70, 25, 55, 55) channel("rv_xfade") range(0.01, 0.3, 0.05, 0.5, 0.001) text("X-fade") textColour(200,200,220) trackerColour(220, 130, 170)
    rslider bounds(130, 25, 55, 55) channel("rv_pitch") range(0.25, 2, 1, 1, 0.01) text("Pitch") textColour(200,200,220) trackerColour(220, 130, 170)
    label bounds(10, 85, 240, 30) text("Window = reverse chunk length. X-fade = crossfade between buffers. Pitch = playback speed.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(265, 160, 200, 130) text("FEEDBACK + FILTER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("rv_fb") range(0, 0.9, 0.4, 1, 0.01) text("Feedback") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(70, 25, 55, 55) channel("rv_tone") range(500, 14000, 6000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(130, 25, 55, 55) channel("rv_blur") range(0, 1, 0.2, 1, 0.01) text("Blur") textColour(200,200,220) trackerColour(200, 180, 130)
    label bounds(10, 85, 195, 30) text("Tone = LP in feedback. Blur = post smoothing via PVS.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(470, 160, 260, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.5, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("rv_reverb") range(0, 0.5, 0.2, 1, 0.01) text("Reverb") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 250, 30) text("Post-reverbsc for stereo image from mono reverse.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"REVERSE DELAY — Dual-buffer reverse echo for preverb swells.

Two alternating buffers record input. While one records, the other plays backward. A crossfade
at buffer boundaries prevents clicks. The result: every sound is preceded by its own reverse
ghost, creating the classic 'preverb' effect used in ambient and shoegaze.

Window sets the reverse chunk length — shorter = more stuttering, longer = sweeping buildups.
Pitch shifts the reverse playback speed (0.5 = octave down, 2 = octave up). Feedback re-records
the reverse output for recursive reverse-of-reverse textures. Blur adds PVS smoothing.

Good starting points:
  • Classic preverb: Window 0.5, X-fade 0.05, Pitch 1.0, FB 0.4, Tone 6000
  • Ghostly swell: Window 1.0, X-fade 0.1, Pitch 1.0, FB 0.6, Blur 0.4
  • Stuttered: Window 0.15, X-fade 0.02, Pitch 1.0, FB 0.3, Tone 8000
  • Deep reverse: Window 1.5, X-fade 0.1, Pitch 0.5, FB 0.5, Blur 0.3"
) fontColour(130, 130, 160) fontSize(10) align("left")

</Cabbage>

<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1

seed 0

gi_sine ftgen 0, 0, 8192, 10, 1

; Two recording buffers — 2.5 sec each (max window = 2 sec + headroom)
gi_buf_size = sr * 2.5
gi_bufA  ftgen 0, 0, gi_buf_size, 2, 0
gi_bufB  ftgen 0, 0, gi_buf_size, 2, 0

ga_send_L init 0
ga_send_R init 0


;==============================================================
; TEST SOURCE — instr 1
;==============================================================
instr 1

  ktype  chnget "src_type"
  kfreq  chnget "src_freq"
  klevel chnget "src_level"
  krate  chnget "src_rate"

  k_man chnget "src_trigger"
  k_man_trig trigger k_man, 0.5, 0

  k_auto_trig = 0
  if ktype <= 2 then
    k_auto_trig metro krate
  endif

  if (k_auto_trig + k_man_trig) > 0 then
    reinit do_ping
  endif

do_ping:
  aenv expseg 1, 0.15, 0.001
rireturn

  asing  oscili 1, kfreq, gi_sine
  anoise noise  0.3, 0

  asig = 0
  if ktype == 1 then
    asig = asing * aenv * klevel
  elseif ktype == 2 then
    asig = anoise * aenv * klevel
  elseif ktype == 3 then
    asig = asing * klevel
  elseif ktype == 4 then
    asig = anoise * klevel
  endif

  ga_send_L = ga_send_L + asig
  ga_send_R = ga_send_R + asig

endin


;==============================================================
; REVERSE DELAY — instr 99
;
; Dual alternating buffers: one records forward, the other
; plays backward. Crossfade at boundaries. Feedback re-records
; the reverse output.
;==============================================================
instr 99

  ; Read parameters
  kwindow  chnget "rv_time"
  kxfade   chnget "rv_xfade"
  kpitch   chnget "rv_pitch"
  kfb      chnget "rv_fb"
  ktone    chnget "rv_tone"
  kblur    chnget "rv_blur"
  kdrywet  chnget "dry_wet"
  kvol     chnget "master_vol"
  krvb     chnget "rv_reverb"

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Feedback from previous cycle
  afb init 0

  ; Input with feedback
  ain = amono + afb * kfb

  ; Window in samples
  kwin_samps = kwindow * sr
  kwin_samps limit kwin_samps, sr * 0.05, gi_buf_size - 1

  ; Phase: cycles between 0 and 1 over the window period
  ; Each cycle = one window of recording
  kphase phasor (1 / kwindow)

  ; Write position (forward)
  kwrite_idx = kphase * kwin_samps

  ; Write into the active buffer
  ; Buffer A records on even cycles, B on odd
  ; Use a toggle that flips each time phase wraps
  ktog init 0
  kwrap trigger kphase, 0.001, 1
  if kwrap > 0 then
    ktog = 1 - ktog
  endif

  ; Write to active buffer
  if ktog < 0.5 then
    tablew ain, a(kwrite_idx), gi_bufA
  else
    tablew ain, a(kwrite_idx), gi_bufB
  endif

  ; Read from inactive buffer (backward)
  kread_idx = kwin_samps - (kphase * kwin_samps * kpitch)
  kread_idx limit kread_idx, 0, kwin_samps - 1

  if ktog < 0.5 then
    arev tablekt a(kread_idx), gi_bufB
  else
    arev tablekt a(kread_idx), gi_bufA
  endif

  ; Crossfade envelope near boundaries
  ; Fade in at start, fade out at end of each window
  kxf_samps = kxfade / kwindow
  kenv = 1
  if kphase < kxf_samps then
    kenv = kphase / kxf_samps
  elseif kphase > (1 - kxf_samps) then
    kenv = (1 - kphase) / kxf_samps
  endif
  kenv limit kenv, 0, 1

  arev = arev * kenv

  ; Tone filter in feedback
  afb tone arev, ktone

  ; Wet signal — mono, add reverb for stereo
  awet = arev

  ; Post-reverbsc for stereo image
  awetL, awetR reverbsc awet, awet, 0.4, 8000
  awetL = awet + awetL * 0.4
  awetR = awet + awetR * 0.4

  ; Extra reverb
  arvb_L, arvb_R reverbsc awetL, awetR, 0.65, 10000
  awetL = awetL + arvb_L * krvb
  awetR = awetR + arvb_R * krvb

  ; Dry/wet mix
  aL = ga_send_L * (1 - kdrywet) + awetL * kdrywet
  aR = ga_send_R * (1 - kdrywet) + awetR * kdrywet

  ; Master volume + output
  aL = aL * kvol
  aR = aR * kvol
  aL dcblock aL
  aR dcblock aR
  outs aL, aR

  ga_send_L = 0
  ga_send_R = 0

endin


</CsInstruments>
<CsScore>
i 1  0 [60*60*4]
i 99 0 [60*60*4]
e
</CsScore>
</CsoundSynthesizer>
