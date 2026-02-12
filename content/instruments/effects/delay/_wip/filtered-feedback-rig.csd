<Cabbage>
form caption("Filtered Feedback Delay Rig") size(740, 490), colour(30, 30, 50), pluginId("ffbd")

; Header
label bounds(10, 8, 720, 25) text("FILTERED FEEDBACK DELAY RIG") fontColour(150, 200, 224) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Warm darkening delay with LP/HP in feedback loop") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(150, 200, 224) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Each repeat gets darker (LP) and thinner (HP). High feedback + low tone = infinite warm wash.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): DELAY + FILTER + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 180, 130) text("DELAY") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dly_time") range(0.01, 2, 0.5, 0.5, 0.01) text("Time") textColour(200,200,220) trackerColour(150, 200, 224)
    rslider bounds(70, 25, 55, 55) channel("dly_fb") range(0, 0.98, 0.7, 1, 0.01) text("Feedback") textColour(200,200,220) trackerColour(150, 200, 224)
    label bounds(10, 85, 160, 30) text("Time in seconds. FB up to 0.98 for long tails.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(195, 160, 290, 130) text("FEEDBACK FILTERS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("fb_lp") range(200, 16000, 5000, 0.3, 1) text("LP Cutoff") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(70, 25, 55, 55) channel("fb_hp") range(20, 2000, 40, 0.3, 1) text("HP Cutoff") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(130, 25, 55, 55) channel("fb_sat") range(0, 1, 0, 1, 0.01) text("Saturation") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(190, 25, 55, 55) channel("fb_mod") range(0, 0.01, 0.001, 0.5, 0.0001) text("Mod Depth") textColour(200,200,220) trackerColour(200, 180, 130)
    label bounds(10, 85, 280, 30) text("LP = darken repeats. HP = thin low end. Sat = tanh warmth. Mod = slight pitch drift.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(490, 160, 240, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.5, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("ping_pong") range(0, 1, 0, 1, 0.01) text("P-Pong") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 230, 30) text("P-Pong = cross-feed amount between L/R delays for stereo bounce.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"FILTERED FEEDBACK DELAY — The bread-and-butter ambient delay.

Each repeat passes through LP and HP filters in the feedback loop, progressively darkening and
thinning the sound. High feedback (0.9+) with low LP cutoff creates infinite warm washes where
only the fundamental survives. HP in feedback prevents low-end mud buildup.

Optional tanh saturation adds analog warmth. Mod depth adds subtle pitch drift (via randi
modulating delay time) for natural imperfection. Ping-pong cross-feeds L/R for spatial movement.

Good starting points:
  • Warm ambient: Time 0.5, FB 0.8, LP 3000, HP 80, Sat 0.2
  • Dark infinite: Time 0.7, FB 0.95, LP 1500, HP 100, Sat 0.4
  • Bright slapback: Time 0.1, FB 0.4, LP 12000, HP 20, Sat 0
  • Spatial bounce: Time 0.35, FB 0.7, LP 5000, P-Pong 0.8"
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
; FILTERED FEEDBACK DELAY — instr 99
;
; Stereo delay with LP/HP/saturation in feedback loop.
; Optional ping-pong cross-feed for stereo movement.
;==============================================================
instr 99

  ; Read parameters
  ktime    chnget "dly_time"
  kfb      chnget "dly_fb"
  kfb_lp   chnget "fb_lp"
  kfb_hp   chnget "fb_hp"
  ksat     chnget "fb_sat"
  kmod     chnget "fb_mod"
  kdrywet  chnget "dry_wet"
  kvol     chnget "master_vol"
  kpp      chnget "ping_pong"

  ; Slight modulation for natural imperfection
  kmod_L randi kmod, 0.7
  kmod_R randi kmod, 0.9

  kdel_L = ktime + kmod_L
  kdel_R = ktime + kmod_R
  kdel_L limit kdel_L, 0.001, 2.99
  kdel_R limit kdel_R, 0.001, 2.99

  ; Feedback from previous cycle (filtered)
  afb_L init 0
  afb_R init 0

  ; Ping-pong cross-feed: mix opposite channel feedback
  ain_L = ga_send_L + afb_L * (1 - kpp) + afb_R * kpp
  ain_R = ga_send_R + afb_R * (1 - kpp) + afb_L * kpp

  ; Delay lines
  abuf_L delayr 3.0
  atap_L deltap3 kdel_L
         delayw ain_L

  abuf_R delayr 3.0
  atap_R deltap3 kdel_R
         delayw ain_R

  ; Feedback filtering: LP (darken) + HP (thin)
  afb_L tone atap_L * kfb, kfb_lp
  afb_R tone atap_R * kfb, kfb_lp
  afb_L atone afb_L, kfb_hp
  afb_R atone afb_R, kfb_hp

  ; Saturation in feedback
  if ksat > 0.01 then
    k_drive = 1 + ksat * 3
    afb_L = tanh(afb_L * k_drive)
    afb_R = tanh(afb_R * k_drive)
  endif

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
