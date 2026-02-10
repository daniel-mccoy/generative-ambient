<Cabbage>
form caption("Babo Rig — Ball-in-Box 3D Room") size(740, 490), colour(30, 30, 50), pluginId("babo")

; Header
label bounds(10, 8, 720, 25) text("BABO RIG") fontColour(100, 160, 224) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Ball-within-the-Box 3D room model (Rocchesso / Filippi / Bernardini)") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 220, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(100, 160, 224) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Try moving the source position sliders slowly while playing sustained tones — hear the sound move through the room.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): ROOM + SOURCE + OUTPUT
;=====================================================================

; Room dimensions
groupbox bounds(10, 160, 170, 130) text("ROOM (meters)") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 45, 45) channel("room_x") range(1, 50, 10, 0.3, 0.1) text("Width") textColour(200,200,220) trackerColour(100, 160, 224)
    rslider bounds(58, 25, 45, 45) channel("room_y") range(1, 50, 12, 0.3, 0.1) text("Depth") textColour(200,200,220) trackerColour(100, 160, 224)
    rslider bounds(106, 25, 45, 45) channel("room_z") range(1, 20, 4, 0.3, 0.1) text("Height") textColour(200,200,220) trackerColour(100, 160, 224)
    label bounds(10, 78, 150, 30) text("Box dimensions. Larger = longer reverb. Height affects early reflections.") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Source position
groupbox bounds(185, 160, 220, 130) text("SOURCE POSITION (k-rate!)") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("src_x") range(0.1, 0.9, 0.4, 1, 0.01) text("X") textColour(200,200,220) trackerColour(120, 200, 224)
    rslider bounds(70, 25, 55, 55) channel("src_y") range(0.1, 0.9, 0.5, 1, 0.01) text("Y") textColour(200,200,220) trackerColour(120, 200, 224)
    rslider bounds(130, 25, 55, 55) channel("src_z") range(0.1, 0.9, 0.5, 1, 0.01) text("Z") textColour(200,200,220) trackerColour(120, 200, 224)
    label bounds(10, 85, 200, 30) text("Normalized 0-1 within room. Move for dynamic spatialization.") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Diffusion + output
groupbox bounds(410, 160, 320, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 50, 50) channel("diffusion") range(0, 1, 0.5, 1, 0.01) text("Diffuse") textColour(200,200,220) trackerColour(100, 160, 224)
    rslider bounds(65, 25, 50, 50) channel("dry_wet") range(0, 1, 0.6, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(120, 25, 50, 50) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(175, 25, 50, 50) channel("post_lpf") range(500, 16000, 8000, 0.4, 1) text("Tone") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 300, 30) text("Diffuse = wall diffusion. Tone = post-filter (babo walls can be harsh at high diffusion).") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"BABO — Ball-within-the-Box 3D room simulator (Davide Rocchesso, CMJ 1995).\n\n\
Models a box-shaped resonant space where source position is k-rate controllable. Moving the XYZ sliders\n\
while audio plays creates the effect of a sound source moving through a physical room.\n\n\
Room dimensions dramatically change the character: small rooms (2x3x2) produce tight, boxy resonances;\n\
large rooms (20x25x7) produce spacious hall-like wash. Height is especially important for the character\n\
of early reflections.\n\n\
Good starting points:\n\
  • Small room: 3x4x3, Diffuse 0.3, Source centered\n\
  • Medium hall: 10x12x4, Diffuse 0.5, Source offset\n\
  • Large space: 20x25x7, Diffuse 0.7, Tone 4000\n\
  • Moving source: any room, slowly sweep Source X from 0.1 to 0.9 over 30 seconds\n\n\
The source position values are proportional to room dimensions (0 = one wall, 1 = opposite wall)."
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
; BABO — instr 99
;
; Ball-within-the-Box 3D room model.
; Source position is k-rate for real-time movement.
;==============================================================
instr 99

  ; Read room parameters
  krx    chnget "room_x"
  kry    chnget "room_y"
  krz    chnget "room_z"

  ; Source position (normalized 0-1, scaled to room dimensions)
  ksrcx  chnget "src_x"
  ksrcy  chnget "src_y"
  ksrcz  chnget "src_z"

  kdiff  chnget "diffusion"
  kdrywet chnget "dry_wet"
  kvol   chnget "master_vol"
  klpf   chnget "post_lpf"

  ; Scale source position to room dimensions
  ksrcx_m = ksrcx * krx
  ksrcy_m = ksrcy * kry
  ksrcz_m = ksrcz * krz

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; babo: asig, ksrcx, ksrcy, ksrcz, irx, iry, irz, idiff
  ; Room dimensions are i-rate — read at init via chnget
  irx chnget "room_x"
  iry chnget "room_y"
  irz chnget "room_z"
  idiff chnget "diffusion"
  aL, aR babo amono, ksrcx_m, ksrcy_m, ksrcz_m, irx, iry, irz, idiff

  ; Post-filter (babo can be harsh)
  aL butterlp aL, klpf
  aR butterlp aR, klpf

  ; Dry/wet mix
  aoutL = ga_send_L * (1 - kdrywet) + aL * kdrywet
  aoutR = ga_send_R * (1 - kdrywet) + aR * kdrywet

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
