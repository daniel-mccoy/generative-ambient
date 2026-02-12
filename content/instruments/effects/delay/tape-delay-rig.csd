<Cabbage>
form caption("Tape Delay Rig") size(740, 490), colour(30, 30, 50), pluginId("tpdl")

; Header
label bounds(10, 8, 720, 25) text("TAPE DELAY RIG") fontColour(224, 170, 100) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Analog tape echo with wow, flutter, and degradation") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(224, 170, 100) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Try pings to hear each repeat darken and waver. Sustained tones show the chorusing from wow/flutter.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): TAPE DELAY + TAPE CHARACTER + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 200, 130) text("DELAY") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dly_time") range(0.05, 2, 0.4, 0.5, 0.01) text("Time") textColour(200,200,220) trackerColour(224, 170, 100)
    rslider bounds(70, 25, 55, 55) channel("dly_fb") range(0, 0.95, 0.6, 1, 0.01) text("Feedback") textColour(200,200,220) trackerColour(224, 170, 100)
    rslider bounds(130, 25, 55, 55) channel("dly_heads") range(1, 4, 1, 1, 1) text("Heads") textColour(200,200,220) trackerColour(224, 170, 100)
    label bounds(10, 85, 185, 30) text("Time in seconds. Heads = number of playback heads (1-4).") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(215, 160, 260, 130) text("TAPE CHARACTER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 50, 50) channel("wow_depth") range(0, 5, 1.5, 0.5, 0.01) text("Wow") textColour(200,200,220) trackerColour(200, 150, 100)
    rslider bounds(65, 25, 50, 50) channel("flutter_depth") range(0, 1, 0.3, 0.5, 0.01) text("Flutter") textColour(200,200,220) trackerColour(200, 150, 100)
    rslider bounds(120, 25, 50, 50) channel("tape_tone") range(500, 12000, 4000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(200, 150, 100)
    rslider bounds(175, 25, 50, 50) channel("tape_sat") range(0, 1, 0.3, 1, 0.01) text("Saturation") textColour(200,200,220) trackerColour(200, 150, 100)
    label bounds(10, 85, 245, 30) text("Wow = slow drift (ms). Flutter = fast jitter (ms). Tone = LP in feedback. Sat = tanh warmth.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(480, 160, 250, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.5, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("stereo_spread") range(0, 30, 10, 0.5, 0.1) text("Spread") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 240, 30) text("Spread = stereo offset between heads (ms). 0 = mono delay.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"TAPE DELAY — Analog tape echo simulation with wow, flutter, and degradation.

Signal flow: Input → delay line (vdelay3) → tone filter (LP in feedback) → tanh saturation → back to input.
Wow (slow pitch drift, 0.3 Hz randi) and Flutter (fast jitter, 5 Hz randi) modulate the delay time,
creating the characteristic pitch instability of tape machines. Each repeat gets darker (tone filter)
and warmer (tanh soft-clipping). Multi-head mode adds 2-4 taps at fractional delay times.

Good starting points:
  • Clean echo: Time 0.4, FB 0.5, Wow 0, Flutter 0, Sat 0
  • Vintage tape: Time 0.35, FB 0.6, Wow 1.5, Flutter 0.3, Tone 4000, Sat 0.3
  • Degraded loop: Time 0.8, FB 0.85, Wow 3, Flutter 0.5, Tone 2000, Sat 0.6
  • Multi-head: Time 0.3, Heads 3, FB 0.5, Spread 15"
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
; TAPE DELAY — instr 99
;
; Multi-head tape echo with wow, flutter, tone, and saturation.
; Each head taps at a fraction of the base delay time.
; Wow = slow randi (0.3 Hz), Flutter = fast randi (5 Hz).
;==============================================================
instr 99

  ; Read parameters
  ktime    chnget "dly_time"
  kfb      chnget "dly_fb"
  kheads   chnget "dly_heads"
  kwow     chnget "wow_depth"
  kflutter chnget "flutter_depth"
  ktone    chnget "tape_tone"
  ksat     chnget "tape_sat"
  kdrywet  chnget "dry_wet"
  kvol     chnget "master_vol"
  kspread  chnget "stereo_spread"

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Tape modulation: wow (slow drift) + flutter (fast jitter)
  kwow_mod   randi kwow * 0.001, 0.3
  kflut_mod  randi kflutter * 0.001, 5.0

  ; Feedback from previous cycle
  afb_L init 0
  afb_R init 0

  ; Head 1 (primary) — L channel
  kdel1_L = ktime + kwow_mod + kflut_mod
  kdel1_L limit kdel1_L, 0.001, 2.99

  abuf1_L delayr 3.0
  atap1_L deltap3 kdel1_L
          delayw amono + afb_L * kfb

  ; Head 1 — R channel (slight spread offset)
  kdel1_R = ktime + kwow_mod + kflut_mod + kspread * 0.001
  kdel1_R limit kdel1_R, 0.001, 2.99

  abuf1_R delayr 3.0
  atap1_R deltap3 kdel1_R
          delayw amono + afb_R * kfb

  ; Multi-head taps (heads 2-4 at fractional delay times)
  ; Head 2 at 0.5x delay time
  abuf2_L delayr 3.0
  atap2_L deltap3 kdel1_L * 0.5
          delayw amono + afb_L * kfb * 0.5

  abuf2_R delayr 3.0
  atap2_R deltap3 kdel1_R * 0.5
          delayw amono + afb_R * kfb * 0.5

  ; Head 3 at 0.75x
  abuf3_L delayr 3.0
  atap3_L deltap3 kdel1_L * 0.75
          delayw amono + afb_L * kfb * 0.3

  abuf3_R delayr 3.0
  atap3_R deltap3 kdel1_R * 0.75
          delayw amono + afb_R * kfb * 0.3

  ; Head 4 at 1.33x
  kd4_L limit kdel1_L * 1.33, 0.001, 2.99
  kd4_R limit kdel1_R * 1.33, 0.001, 2.99

  abuf4_L delayr 3.0
  atap4_L deltap3 kd4_L
          delayw amono + afb_L * kfb * 0.2

  abuf4_R delayr 3.0
  atap4_R deltap3 kd4_R
          delayw amono + afb_R * kfb * 0.2

  ; Mix heads based on head count
  awet_L = atap1_L
  awet_R = atap1_R
  if kheads >= 2 then
    awet_L = awet_L + atap2_L * 0.7
    awet_R = awet_R + atap2_R * 0.7
  endif
  if kheads >= 3 then
    awet_L = awet_L + atap3_L * 0.5
    awet_R = awet_R + atap3_R * 0.5
  endif
  if kheads >= 4 then
    awet_L = awet_L + atap4_L * 0.4
    awet_R = awet_R + atap4_R * 0.4
  endif

  ; Tone filter in feedback path (darken each repeat)
  afb_L tone awet_L, ktone
  afb_R tone awet_R, ktone

  ; Tape saturation in feedback
  if ksat > 0.01 then
    k_drive = 1 + ksat * 3
    afb_L = tanh(afb_L * k_drive)
    afb_R = tanh(afb_R * k_drive)
  endif

  ; Dry/wet mix
  aL = ga_send_L * (1 - kdrywet) + awet_L * kdrywet
  aR = ga_send_R * (1 - kdrywet) + awet_R * kdrywet

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
