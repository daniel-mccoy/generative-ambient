<Cabbage>
form caption("Platerev Rig") size(740, 490), colour(30, 30, 50), pluginId("plrv")

; Header
label bounds(10, 8, 720, 25) text("PLATEREV RIG") fontColour(200, 150, 224) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Physical plate vibration model (Bilbao / ffitch)") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 220, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(200, 150, 224) fontColour:0(200, 200, 220)
    button bounds(370, 28, 70, 30) channel("bypass") text("Bypass", "BYPASS") value(0) colour:0(60, 60, 80) colour:1(224, 80, 80) fontColour:0(200, 200, 220) fontColour:1(255, 255, 255)
    label bounds(450, 28, 260, 40) text("Skip platerev (saves CPU).") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): PLATE PARAMETERS + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 390, 130) text("PLATE PHYSICS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 50, 50) channel("pl_decay") range(0.5, 15, 3.0, 0.3, 0.1) text("Decay") textColour(200,200,220) trackerColour(200, 150, 224)
    rslider bounds(65, 25, 50, 50) channel("pl_stiff") range(0.01, 4, 0.5, 0.5, 0.01) text("Stiff") textColour(200,200,220) trackerColour(200, 150, 224)
    rslider bounds(120, 25, 50, 50) channel("pl_aspect") range(0.3, 1.0, 0.8, 1, 0.01) text("Aspect") textColour(200,200,220) trackerColour(200, 150, 224)
    rslider bounds(175, 25, 50, 50) channel("pl_loss") range(0.0001, 0.01, 0.001, 0.3, 0.0001) text("Loss") textColour(200,200,220) trackerColour(200, 150, 224)
    combobox bounds(240, 28, 80, 22) channel("pl_boundary") value(1) text("Free", "Clamped", "Pivoting")
    label bounds(240, 55, 140, 30) text("Boundary condition (k-rate — morphable in real-time!)") fontColour(140, 140, 160) fontSize(9) align("left")
    label bounds(10, 85, 220, 30) text("Decay = 30dB time. Stiff < 1 = plate, > 1 = bell. Aspect = shape ratio.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(405, 160, 325, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.7, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.5, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("pl_hpf") range(20, 500, 40, 0.5, 1) text("HPF") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(190, 25, 55, 55) channel("pl_lpf") range(1000, 16000, 10000, 0.4, 1) text("LPF") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 310, 30) text("HPF/LPF = post-plate EQ. Volume lower by default — platerev can be loud!") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"PLATEREV — Physical model of rectangular metal plate vibration (Stefan Bilbao / John ffitch).\n\n\
Unlike algorithmic reverbs, this simulates actual physics: plate stiffness, aspect ratio, damping, and\n\
boundary conditions (free, clamped, pivoting). The result is a complex modal pattern that sounds\n\
authentically metallic/resonant.\n\n\
The boundary condition is k-rate — morphing between free/clamped/pivoting in real-time creates\n\
evolving plate characteristics unique to this reverb. CPU-intensive but sonically distinctive.\n\n\
Good starting points:\n\
  • Classic plate: Decay 3, Stiff 0.5, Aspect 0.8, Clamped\n\
  • Bright bell: Decay 5, Stiff 2.0, Aspect 0.6, Free\n\
  • Dark room: Decay 8, Stiff 0.3, Aspect 0.9, Pivoting, LPF 4000\n\
  • Morphing: Automate boundary between Free↔Clamped over 30 seconds\n\n\
Note: 2 excitation points + 2 pickup points for stereo. CPU is high — this is a true physical model."
) fontColour(130, 130, 160) fontSize(10) align("left")

</Cabbage>

<CsoundSynthesizer>
<CsOptions>
-odac -d -b 1024 -B 4096
</CsOptions>
<CsInstruments>

sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1

seed 0

gi_sine ftgen 0, 0, 8192, 10, 1

; Excitation points: 2 points as (x,y) pairs — values in (0,1) range
; platerev point count comes from number of audio args, NOT table size.
; Table just needs to be big enough: ftlen >= 2*N_points.
; Size 8 (power of 2) with 2 points → reads positions 0-3.
gi_excite ftgen 50, 0, 8, -2, 0.3, 0.4, 0.7, 0.6

; Output pickup points: 2 points as (x,y) pairs
gi_outs ftgen 51, 0, 8, -2, 0.2, 0.3, 0.8, 0.7

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
; PLATEREV — instr 99
;
; Physical plate vibration model. Two excitation points (fed
; the same signal), two pickup points for stereo output.
; Boundary condition is k-rate for real-time morphing.
;==============================================================
instr 99

  ; Read parameters
  kdecay   chnget "pl_decay"
  kstiff   chnget "pl_stiff"
  kaspect  chnget "pl_aspect"
  kloss    chnget "pl_loss"
  kbndry_s chnget "pl_boundary"
  kdrywet  chnget "dry_wet"
  kvol     chnget "master_vol"
  khpf     chnget "pl_hpf"
  klpf     chnget "pl_lpf"

  ; Boundary: combobox 1=Free(0), 2=Clamped(1), 3=Pivoting(2)
  kbndry = kbndry_s - 1
  kbypass chnget "bypass"

  ; ---- BYPASS: skip platerev entirely (saves CPU) ----
  if kbypass == 1 then
    aoutL = ga_send_L * kvol
    aoutR = ga_send_R * kvol
    outs aoutL, aoutR
    ga_send_L = 0
    ga_send_R = 0
    kgoto done
  endif

  ; ---- NORMAL: plate reverb processing ----
  ; Scale input down — physical models distort internally when driven too hard.
  ; platerev needs very low input levels to stay in its linear region.
  amono = (ga_send_L + ga_send_R) * 0.01

  ; platerev: 2 excitation points → 2 audio inputs, 2 pickup points → 2 outputs
  iaspect chnget "pl_aspect"
  istiff  chnget "pl_stiff"
  idecay  chnget "pl_decay"
  iloss   chnget "pl_loss"
  aL, aR platerev gi_excite, gi_outs, kbndry, iaspect, istiff, idecay, iloss, amono, amono

  ; NaN/explosion safety at k-rate
  krmsL rms aL, 20
  krmsR rms aR, 20
  kplate_ok = (krmsL == krmsL && krmsR == krmsR && krmsL < 5 && krmsR < 5) ? 1 : 0
  if kplate_ok == 0 then
    aL = 0
    aR = 0
  endif

  ; Compensate for reduced input level
  aL = aL * 10
  aR = aR * 10

  ; Post EQ
  aL butterhp aL, khpf
  aR butterhp aR, khpf
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

done:

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
