<Cabbage>
form caption("Ping-Pong Delay Rig") size(740, 490), colour(30, 30, 50), pluginId("ppng")

; Header
label bounds(10, 8, 720, 25) text("PING-PONG DELAY RIG") fontColour(100, 200, 180) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — BPM-synced stereo bouncing delay with sub-division control") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(100, 200, 180) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Classic stereo bounce. Try different L/R times for polyrhythmic patterns. Use headphones!") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): L/R DELAY + FEEDBACK + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 350, 130) text("DELAY TIMING") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 65, 65) channel("bpm") range(40, 240, 120, 1, 0.1) text("BPM") textColour(200,200,220) trackerColour(100, 200, 180) fontSize(12)
    combobox bounds(85, 30, 90, 22) channel("div_L") value(4) text("1/2", "1/4", "1/4 dot", "1/8", "1/8 dot", "1/16", "1/16 dot", "1/4 trip", "1/8 trip")
    label bounds(85, 54, 90, 14) text("L Division") fontColour(160, 160, 180) fontSize(10) align("centre")
    combobox bounds(185, 30, 90, 22) channel("div_R") value(5) text("1/2", "1/4", "1/4 dot", "1/8", "1/8 dot", "1/16", "1/16 dot", "1/4 trip", "1/8 trip")
    label bounds(185, 54, 90, 14) text("R Division") fontColour(160, 160, 180) fontSize(10) align("centre")
    label bounds(85, 72, 50, 14) text("L:") fontColour(140, 140, 160) fontSize(10) align("right")
    label bounds(135, 72, 55, 14) text("---") channel("lbl_time_L") fontColour(100, 200, 180) fontSize(10) align("left")
    label bounds(195, 72, 50, 14) text("R:") fontColour(140, 140, 160) fontSize(10) align("right")
    label bounds(245, 72, 55, 14) text("---") channel("lbl_time_R") fontColour(100, 200, 180) fontSize(10) align("left")
    label bounds(10, 95, 340, 24) text("BPM-synced. Divisions: dot = 1.5x, trip = 2/3x. Different L/R = polyrhythmic bounce.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(365, 160, 200, 130) text("FEEDBACK") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dly_fb") range(0, 0.95, 0.6, 1, 0.01) text("Amount") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(70, 25, 55, 55) channel("fb_tone") range(500, 14000, 6000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(130, 25, 55, 55) channel("fb_mod") range(0, 0.01, 0.002, 0.5, 0.0001) text("Mod") textColour(200,200,220) trackerColour(200, 180, 130)
    label bounds(10, 85, 195, 30) text("Cross-fed L↔R. Tone = LP in loop. Mod = pitch drift per repeat.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(570, 160, 160, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.5, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 145, 30) text("Stereo width via mid/side in delay engine.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"PING-PONG DELAY — BPM-synced stereo bouncing delay with sub-division control.

L and R delay lines cross-feed: L output → R input, R output → L input. Each repeat alternates
sides, creating spatial movement essential for headphone listening. Independent L/R subdivisions
create polyrhythmic patterns (e.g., L=1/8 R=1/8dot = 2:3 ratio).

Tone filter darkens each repeat. Mod adds subtle randi-based pitch drift for natural feel.

Good starting points:
  • Classic bounce: BPM 120, L=1/8, R=1/8, FB 0.6, Tone 6000
  • Polyrhythmic: BPM 120, L=1/8, R=1/8 dot, FB 0.5, Tone 8000
  • Wide spatial: BPM 90, L=1/4, R=1/4, FB 0.7, Mod 0.003
  • Infinite wash: BPM 80, L=1/4, R=1/4 dot, FB 0.9, Tone 2000"
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
; PING-PONG DELAY — instr 99
;
; Cross-fed stereo delay lines with independent L/R times.
; L output feeds R input, R output feeds L input.
;==============================================================
instr 99

  ; Read parameters
  k_bpm    chnget "bpm"
  k_div_L  chnget "div_L"
  k_div_R  chnget "div_R"
  kfb      chnget "dly_fb"
  ktone    chnget "fb_tone"
  kmod     chnget "fb_mod"
  kdrywet  chnget "dry_wet"
  kvol     chnget "master_vol"

  ; Beat duration (seconds per quarter note)
  k_beat = 60.0 / k_bpm

  ; Division multipliers table (1-indexed by combobox value)
  ; 1=1/2(2.0)  2=1/4(1.0)  3=1/4dot(1.5)  4=1/8(0.5)  5=1/8dot(0.75)
  ; 6=1/16(0.25)  7=1/16dot(0.375)  8=1/4trip(0.6667)  9=1/8trip(0.3333)
  i_divtab ftgen 0, 0, 16, -2, 0, 2.0, 1.0, 1.5, 0.5, 0.75, 0.25, 0.375, 0.66667, 0.33333

  k_mult_L tablekt k_div_L, i_divtab, 0
  k_mult_R tablekt k_div_R, i_divtab, 0

  kdly_L = k_beat * k_mult_L
  kdly_R = k_beat * k_mult_R

  ; Update display labels (10 Hz)
  k_upd metro 10
  if k_upd == 1 then
    S_L sprintfk "%d ms", kdly_L * 1000
    S_R sprintfk "%d ms", kdly_R * 1000
    chnset S_L, "lbl_time_L"
    chnset S_R, "lbl_time_R"
  endif

  ; Modulation
  kmod_L randi kmod, 0.6
  kmod_R randi kmod, 0.8

  kd_L = kdly_L + kmod_L
  kd_R = kdly_R + kmod_R
  kd_L limit kd_L, 0.001, 2.99
  kd_R limit kd_R, 0.001, 2.99

  ; Feedback from previous cycle (cross-fed and filtered)
  afb_L init 0
  afb_R init 0

  ; L delay line: input = dry L + cross-fed R feedback
  abuf_L delayr 3.0
  atap_L deltap3 kd_L
         delayw ga_send_L + afb_R * kfb

  ; R delay line: input = dry R + cross-fed L feedback
  abuf_R delayr 3.0
  atap_R deltap3 kd_R
         delayw ga_send_R + afb_L * kfb

  ; Filter in feedback path
  afb_L tone atap_L, ktone
  afb_R tone atap_R, ktone

  ; Dry/wet mix
  aL = ga_send_L * (1 - kdrywet) + atap_L * kdrywet
  aR = ga_send_R * (1 - kdrywet) + atap_R * kdrywet

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
