<Cabbage>
form caption("Nested Allpass Reverb Rig") size(740, 490), colour(30, 30, 50), pluginId("napr")

; Header
label bounds(10, 8, 720, 25) text("NESTED ALLPASS REVERB RIG") fontColour(224, 200, 100) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Nested allpass diffusion (Mikelson, after Vercoe / Puckette / Gardner)") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 220, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(224, 200, 100) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Compare modes 1-3 with pings to hear different nesting topologies. Mode 1 is densest.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): ALLPASS PARAMETERS + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 200, 130) text("NESTED ALLPASS") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(15, 30, 170, 22) channel("nap_mode") value(1) text("Mode 1 — Dense", "Mode 2 — Medium", "Mode 3 — Sparse")
    rslider bounds(10, 60, 55, 55) channel("nap_gain") range(0.1, 0.9, 0.6, 1, 0.01) text("Gain") textColour(200,200,220) trackerColour(224, 200, 100)
    rslider bounds(70, 60, 55, 55) channel("nap_delay") range(0.005, 0.2, 0.04, 0.3, 0.001) text("Delay") textColour(200,200,220) trackerColour(224, 200, 100)
    label bounds(135, 65, 55, 45) text("3 nesting modes") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Pre/post processing
groupbox bounds(215, 160, 230, 130) text("PROCESSING") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 50, 50) channel("pre_lpf") range(500, 16000, 8000, 0.4, 1) text("Pre LP") textColour(200,200,220) trackerColour(200, 180, 100)
    rslider bounds(65, 25, 50, 50) channel("feedback") range(0, 0.85, 0.4, 1, 0.01) text("FB") textColour(200,200,220) trackerColour(200, 180, 100)
    rslider bounds(120, 25, 50, 50) channel("fb_delay") range(0.01, 0.5, 0.08, 0.3, 0.001) text("FB Dly") textColour(200,200,220) trackerColour(200, 180, 100)
    label bounds(10, 85, 220, 30) text("Pre LP = input filter. FB = recirculate allpass output through a second delay.") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Output
groupbox bounds(450, 160, 280, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.6, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("post_lpf") range(500, 16000, 10000, 0.4, 1) text("Post LP") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 260, 30) text("Post LP tames metallic ringing from the allpass chain.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"NESTED ALLPASS — Nested allpass filter cascade (Hans Mikelson, after Vercoe / Puckette 1985, Gardner 1992).\n\n\
Places allpass filters INSIDE the delay paths of other allpass filters, creating denser diffusion than\n\
simple series chains. The nestedap opcode offers 3 nesting topologies:\n\
  Mode 1: Double-nested AP + single-nested AP (densest — best for ambient)\n\
  Mode 2: Single-nested AP + allpass (medium diffusion)\n\
  Mode 3: Two nested APs in series (most coloration, least density)\n\n\
The nested approach was a key innovation in late-1980s reverb design. By itself, nestedap produces\n\
diffusion without decay. The FB (feedback) knob adds recirculation through an external delay for\n\
actual reverb tail. Pre-LP controls input brightness; Post-LP tames metallic ringing.\n\n\
Good starting points:\n\
  • Smooth diffuser: Mode 1, Gain 0.6, Delay 0.04, FB 0.4\n\
  • Metallic color: Mode 3, Gain 0.8, Delay 0.02, FB 0.3\n\
  • Long tail: Mode 1, Gain 0.5, Delay 0.08, FB 0.7, Pre LP 4000"
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
; NESTED ALLPASS REVERB — instr 99
;
; nestedap provides diffusion only (no decay by itself).
; External feedback loop via delayr/delayw adds reverb tail.
; Cascaded nestedap calls for density, following Mikelson's
; multi-effects pattern.
;==============================================================
instr 99

  ; Read parameters
  kmode    chnget "nap_mode"
  kgain    chnget "nap_gain"
  kdelay   chnget "nap_delay"
  kpre_lpf chnget "pre_lpf"
  kfb      chnget "feedback"
  kfb_dly  chnget "fb_delay"
  kdrywet  chnget "dry_wet"
  kvol     chnget "master_vol"
  kpost_lpf chnget "post_lpf"

  ; Reinit on mode change (imode is i-rate)
  k_prev_mode init -1
  if kmode != k_prev_mode then
    k_prev_mode = kmode
    reinit setup_nap
  endif

setup_nap:
  i_mode chnget "nap_mode"
  i_gain chnget "nap_gain"
  i_del  chnget "nap_delay"
  i_maxdel = 0.5

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Pre-filter
  afilt tone amono, kpre_lpf

  ; Feedback from previous cycle
  afb init 0
  ain = afilt + afb * kfb

  ; Cascaded nested allpass for density
  ; nestedap: asig, imode, imaxdel, idel1, igain1, idel2, igain2[, idel3][, igain3]
  ; Using scaled delay times for each stage
  a1 nestedap ain, i_mode, i_maxdel, i_del, i_gain, i_del*0.73, i_gain*0.9, i_del*0.41, i_gain*0.8
  a2 nestedap a1, i_mode, i_maxdel, i_del*1.37, i_gain*0.9, i_del*0.87, i_gain*0.85, i_del*0.59, i_gain*0.7

rireturn

  ; Post-filter
  awet butterlp a2, kpost_lpf

  ; Feedback delay for reverb tail
  abuf delayr 1.0
  afb_tap deltapi kfb_dly
  delayw awet
  afb tone afb_tap, kpre_lpf

  ; Stereo from slight delay offset
  awetR vdelay3 awet, 7.3, 15
  awetL = awet

  ; Dry/wet mix
  aoutL = ga_send_L * (1 - kdrywet) + awetL * kdrywet
  aoutR = ga_send_R * (1 - kdrywet) + awetR * kdrywet

  ; Master volume + output
  aoutL = aoutL * kvol
  aoutR = aoutR * kvol
  aoutL dcblock aoutL
  aoutR dcblock aoutR
  outs aoutL, aoutR

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
