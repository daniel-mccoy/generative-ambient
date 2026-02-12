<Cabbage>
form caption("Waveguide Mesh Rig") size(740, 490), colour(30, 30, 50), pluginId("wgms")

; Header
label bounds(10, 8, 720, 25) text("WAVEGUIDE MESH RIG") fontColour(200, 200, 140) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — 2D delay mesh network for resonant spatial textures") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(2) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(200, 200, 140) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Noise pings excite the mesh — listen for complex resonant patterns. Adjust damping to control ring.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): MESH + DAMPING + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 250, 130) text("MESH PARAMETERS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("mesh_size") range(0.5, 5, 2, 0.5, 0.01) text("Size") textColour(200,200,220) trackerColour(200, 200, 140)
    rslider bounds(70, 25, 55, 55) channel("mesh_spread") range(0.5, 4, 1, 0.5, 0.01) text("Spread") textColour(200,200,220) trackerColour(200, 200, 140)
    rslider bounds(130, 25, 55, 55) channel("mesh_mod") range(0, 1, 0.2, 0.5, 0.01) text("Mod") textColour(200,200,220) trackerColour(200, 200, 140)
    label bounds(10, 85, 240, 30) text("Size = delay scale (ms). Spread = ratio between node delays. Mod = LFO on delay times.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(265, 160, 200, 130) text("DAMPING") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("mesh_damp") range(0.1, 0.99, 0.7, 1, 0.01) text("Decay") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(70, 25, 55, 55) channel("mesh_tone") range(500, 14000, 6000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(130, 25, 55, 55) channel("mesh_inject") range(0, 1, 0.3, 1, 0.01) text("Inject") textColour(200,200,220) trackerColour(200, 180, 130)
    label bounds(10, 85, 195, 30) text("Decay = node feedback. Tone = LP per node. Inject = input spread across nodes.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(470, 160, 260, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.6, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("mesh_width") range(0, 1, 0.7, 1, 0.01) text("Width") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 250, 30) text("Width = stereo spread from different mesh pickup points.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"WAVEGUIDE MESH — 2D delay network simulating a vibrating surface.

A 3x3 grid of interconnected delay nodes where each node feeds its neighbors. The signal propagates
through the mesh like vibrations through a plate or membrane. Different delay times at each node
create complex resonant patterns impossible with simple delay lines.

Size controls the base delay time per node. Spread varies the ratio between nodes for asymmetric
resonance. Each node has its own tone filter and decay. Multi-point output tapped from different
mesh corners provides natural stereo decorrelation.

Good starting points:
  • Resonant plate: Size 2, Spread 1, Decay 0.7, Tone 6000
  • Metallic surface: Size 0.8, Spread 1.5, Decay 0.85, Tone 10000
  • Deep membrane: Size 4, Spread 0.7, Decay 0.6, Tone 2000
  • Evolving mesh: Size 2, Spread 1.5, Mod 0.5, Decay 0.75"
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
; WAVEGUIDE MESH — instr 99
;
; 3x3 grid of delay nodes interconnected.
; Each node: delayr/deltap3/delayw with neighbor mixing.
; Different prime delays per node for complex resonance.
; Output tapped from corners for stereo spread.
;
; Topology (4-connected):
;   [0,0]--[0,1]--[0,2]
;     |      |      |
;   [1,0]--[1,1]--[1,2]
;     |      |      |
;   [2,0]--[2,1]--[2,2]
;
; Due to Csound feedback constraints, we use 1-cycle delay
; (init 0 + update each k-cycle) between nodes.
;==============================================================
instr 99

  ; Read parameters
  ksize    chnget "mesh_size"
  kspread  chnget "mesh_spread"
  kmod     chnget "mesh_mod"
  kdecay   chnget "mesh_damp"
  ktone    chnget "mesh_tone"
  kinject  chnget "mesh_inject"
  kdrywet  chnget "dry_wet"
  kvol     chnget "master_vol"
  kwidth   chnget "mesh_width"

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Modulation LFOs
  kmod1 oscili kmod * 0.0002, 0.31, gi_sine
  kmod2 oscili kmod * 0.0002, 0.47, gi_sine
  kmod3 oscili kmod * 0.0002, 0.61, gi_sine

  ; Base delay times per node (ms → sec), with prime-ratio spacing
  ; Row 0: 1.7, 2.3, 3.1 ms
  ; Row 1: 2.9, 3.7, 4.3 ms
  ; Row 2: 4.1, 5.3, 6.1 ms
  kd00 = (0.0017 * kspread + kmod1) * ksize
  kd01 = (0.0023 + kmod2) * ksize
  kd02 = (0.0031 * kspread + kmod3) * ksize
  kd10 = (0.0029 + kmod1 * 0.8) * ksize
  kd11 = (0.0037 * kspread + kmod2 * 0.7) * ksize
  kd12 = (0.0043 + kmod3 * 0.9) * ksize
  kd20 = (0.0041 * kspread + kmod1 * 1.1) * ksize
  kd21 = (0.0053 + kmod2 * 1.2) * ksize
  kd22 = (0.0061 * kspread + kmod3 * 0.6) * ksize

  ; Clamp all delays
  kd00 limit kd00, 0.00005, 0.1
  kd01 limit kd01, 0.00005, 0.1
  kd02 limit kd02, 0.00005, 0.1
  kd10 limit kd10, 0.00005, 0.1
  kd11 limit kd11, 0.00005, 0.1
  kd12 limit kd12, 0.00005, 0.1
  kd20 limit kd20, 0.00005, 0.1
  kd21 limit kd21, 0.00005, 0.1
  kd22 limit kd22, 0.00005, 0.1

  ; Node feedback from previous cycle
  an00 init 0
  an01 init 0
  an02 init 0
  an10 init 0
  an11 init 0
  an12 init 0
  an20 init 0
  an21 init 0
  an22 init 0

  ; Input injection: center node gets most, corners get less
  ain_center = amono
  ain_edge   = amono * kinject * 0.5
  ain_corner = amono * kinject * 0.25

  ; Node [0,0]: neighbors = [0,1], [1,0]
  ab00 delayr 0.15
  at00 deltap3 kd00
       delayw ain_corner + (an01 + an10) * 0.5 * kdecay
  an00 tone at00, ktone

  ; Node [0,1]: neighbors = [0,0], [0,2], [1,1]
  ab01 delayr 0.15
  at01 deltap3 kd01
       delayw ain_edge + (an00 + an02 + an11) * 0.333 * kdecay
  an01 tone at01, ktone

  ; Node [0,2]: neighbors = [0,1], [1,2]
  ab02 delayr 0.15
  at02 deltap3 kd02
       delayw ain_corner + (an01 + an12) * 0.5 * kdecay
  an02 tone at02, ktone

  ; Node [1,0]: neighbors = [0,0], [1,1], [2,0]
  ab10 delayr 0.15
  at10 deltap3 kd10
       delayw ain_edge + (an00 + an11 + an20) * 0.333 * kdecay
  an10 tone at10, ktone

  ; Node [1,1]: neighbors = [0,1], [1,0], [1,2], [2,1]
  ab11 delayr 0.15
  at11 deltap3 kd11
       delayw ain_center + (an01 + an10 + an12 + an21) * 0.25 * kdecay
  an11 tone at11, ktone

  ; Node [1,2]: neighbors = [0,2], [1,1], [2,2]
  ab12 delayr 0.15
  at12 deltap3 kd12
       delayw ain_edge + (an02 + an11 + an22) * 0.333 * kdecay
  an12 tone at12, ktone

  ; Node [2,0]: neighbors = [1,0], [2,1]
  ab20 delayr 0.15
  at20 deltap3 kd20
       delayw ain_corner + (an10 + an21) * 0.5 * kdecay
  an20 tone at20, ktone

  ; Node [2,1]: neighbors = [2,0], [2,2], [1,1]
  ab21 delayr 0.15
  at21 deltap3 kd21
       delayw ain_edge + (an20 + an22 + an11) * 0.333 * kdecay
  an21 tone at21, ktone

  ; Node [2,2]: neighbors = [2,1], [1,2]
  ab22 delayr 0.15
  at22 deltap3 kd22
       delayw ain_corner + (an21 + an12) * 0.5 * kdecay
  an22 tone at22, ktone

  ; Output: tap from different corners for stereo
  ; L = top-left + bottom-center
  ; R = top-right + bottom-center (shifted by width)
  awet_L = (an00 + an20 * kwidth + an11 * (1 - kwidth)) * 0.4
  awet_R = (an02 + an22 * kwidth + an11 * (1 - kwidth)) * 0.4

  ; Soft clip
  awet_L = tanh(awet_L * 2) * 0.5
  awet_R = tanh(awet_R * 2) * 0.5

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
