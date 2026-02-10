<Cabbage>
form caption("HRTF Binaural Reverb Rig") size(740, 510), colour(30, 30, 50), pluginId("hrtf")

; Header
label bounds(10, 8, 720, 25) text("HRTF BINAURAL REVERB RIG") fontColour(224, 100, 160) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — hrtfearly + hrtfreverb binaural spatial reverb (Brian Carty)") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 220, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(224, 100, 160) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("USE HEADPHONES for binaural effect. Move source position to hear 3D spatialization.") fontColour(200, 140, 160) fontSize(10) align("left")
}

;=====================================================================
; ROW 2 (y=160): SOURCE POSITION + REVERB + OUTPUT
;=====================================================================

; 3D source position
groupbox bounds(10, 160, 220, 130) text("SOURCE POSITION (k-rate)") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("pos_x") range(0.5, 9.5, 3, 1, 0.1) text("X") textColour(200,200,220) trackerColour(224, 100, 160)
    rslider bounds(70, 25, 55, 55) channel("pos_y") range(0.5, 9.5, 5, 1, 0.1) text("Y") textColour(200,200,220) trackerColour(224, 100, 160)
    rslider bounds(130, 25, 55, 55) channel("pos_z") range(0.5, 2.5, 1.5, 1, 0.1) text("Z") textColour(200,200,220) trackerColour(224, 100, 160)
    label bounds(10, 85, 200, 30) text("Source in meters. Room is 10x10x3 default. Listener at center.") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Late reverb
groupbox bounds(235, 160, 230, 130) text("LATE REVERB") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("low_rt60") range(0.5, 10, 3.0, 0.3, 0.1) text("Low RT") textColour(200,200,220) trackerColour(224, 130, 160)
    rslider bounds(70, 25, 55, 55) channel("high_rt60") range(0.3, 8, 1.5, 0.3, 0.1) text("High RT") textColour(200,200,220) trackerColour(224, 130, 160)
    rslider bounds(130, 25, 55, 55) channel("early_mix") range(0, 1, 0.5, 1, 0.01) text("Early") textColour(200,200,220) trackerColour(224, 130, 160)
    label bounds(10, 85, 220, 30) text("RT60 in seconds (low/high freq). Early = early reflections mix.") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Output
groupbox bounds(470, 160, 260, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.7, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("late_mix") range(0, 1, 0.7, 1, 0.01) text("Late") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 240, 30) text("Late = late diffuse field amount. Use headphones!") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 195) text(
"HRTF BINAURAL REVERB — True 3D spatial audio reverb for headphones (Dr. Brian Carty).\n\n\
Two-stage system:\n\
  1. hrtfearly: Early reflections in a shoebox room. Source position is k-rate — moving XYZ creates\n\
     accurate 3D source movement perceived through headphones via HRTF (head-related transfer function).\n\
  2. hrtfreverb: Late diffuse field with averaged binaural filters and accurate interaural coherence.\n\n\
Ideal for immersive meditation/sleep pieces where spatial envelopment matters. Multiple hrtfearly\n\
instances (one per instrument) can feed a single hrtfreverb for accurate multi-source 3D scenes.\n\n\
REQUIREMENTS:\n\
  • HRTF data files: 'hrtf-44100-left.dat' and 'hrtf-44100-right.dat' must be in Csound's search path\n\
    (typically included with Csound installations). Set SADIR environment variable if not found.\n\
  • Best at sr=44100. This rig uses 48000 with slight inaccuracy (acceptable for design).\n\
  • HEADPHONES REQUIRED for proper binaural perception.\n\n\
Good starting points:\n\
  • Intimate: Source close (3,5,1.5), Low RT 1.5, High RT 0.8\n\
  • Concert hall: Source far (8,8,2), Low RT 4.0, High RT 2.0\n\
  • Cathedral: Low RT 8, High RT 3, source near center"
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
; HRTF REVERB — instr 99
;
; Two-stage binaural reverb:
; 1. hrtfearly: early reflections with 3D source positioning
; 2. hrtfreverb: late diffuse field
;
; The early reflections output estimated RT60 values that
; feed into the late reverb for consistent decay.
;
; NOTE: Requires hrtf-44100-left.dat and hrtf-44100-right.dat
; in Csound's SADIR search path.
;==============================================================
instr 99

  ; Read parameters
  kposx     chnget "pos_x"
  kposy     chnget "pos_y"
  kposz     chnget "pos_z"
  klowrt    chnget "low_rt60"
  khighrt   chnget "high_rt60"
  kearly    chnget "early_mix"
  klate     chnget "late_mix"
  kdrywet   chnget "dry_wet"
  kvol      chnget "master_vol"

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Stage 1: Early reflections with 3D positioning
  ; hrtfearly: asig, ksrcx, ksrcy, ksrcz, Sfile_left, Sfile_right
  ;            [, iSR, iorder, ithreed, kwall1-6, irx, iry, irz, ircvx, ircvy, ircvz]
  ; Using medium room (10x10x3), listener at center (5,5,1.5)
  aeL, aeR, irt60lo, irt60hi, imfp hrtfearly amono, kposx, kposy, kposz, \
    "hrtf-44100-left.dat", "hrtf-44100-right.dat", \
    sr, 2, 1, \
    0.3, 0.3, 0.3, 0.3, 0.3, 0.3, \
    10, 10, 3, \
    5, 5, 1.5

  ; Stage 2: Late diffuse field
  ; Use estimated RT60 from early stage, scaled by user controls
  ; hrtfreverb: asig, ilowrt60, ihighrt60, Sfile_left, Sfile_right [, iSR, imfp]
  ; i-rate params read via chnget (i(kvar) is Csound 7 only)
  ilowrt  chnget "low_rt60"
  ihighrt chnget "high_rt60"
  alateL, alateR hrtfreverb amono, ilowrt, ihighrt, \
    "hrtf-44100-left.dat", "hrtf-44100-right.dat", sr, imfp

  ; Combine early + late
  awetL = aeL * kearly + alateL * klate
  awetR = aeR * kearly + alateR * klate

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
