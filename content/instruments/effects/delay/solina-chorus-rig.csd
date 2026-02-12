<Cabbage>
form caption("Solina Chorus Rig") size(740, 490), colour(30, 30, 50), pluginId("slch")

; Header
label bounds(10, 8, 720, 25) text("SOLINA CHORUS RIG") fontColour(120, 200, 160) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Triple-BBD ensemble chorus (after Solina String Ensemble)") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(3) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 220, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(120, 200, 160) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Use Sustained Sine to hear the classic string ensemble thickening. Slow chorus + fast vibrato.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): CHORUS + VIBRATO + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 250, 130) text("CHORUS (slow)") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("chr_rate") range(0.05, 2, 0.3, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(120, 200, 160)
    rslider bounds(70, 25, 55, 55) channel("chr_depth") range(0, 5, 2, 0.5, 0.01) text("Depth") textColour(200,200,220) trackerColour(120, 200, 160)
    rslider bounds(130, 25, 55, 55) channel("chr_center") range(2, 15, 7, 0.5, 0.1) text("Center") textColour(200,200,220) trackerColour(120, 200, 160)
    label bounds(10, 85, 240, 30) text("Rate = LFO Hz. Depth = modulation (ms). Center = base delay (ms). 3 voices at 120-deg offsets.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(265, 160, 195, 130) text("VIBRATO (fast)") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("vib_rate") range(1, 10, 5.5, 0.5, 0.1) text("Rate") textColour(200,200,220) trackerColour(160, 200, 160)
    rslider bounds(70, 25, 55, 55) channel("vib_depth") range(0, 1, 0.3, 0.5, 0.01) text("Depth") textColour(200,200,220) trackerColour(160, 200, 160)
    label bounds(10, 85, 180, 30) text("Faster modulation for shimmer. Combined with chorus LFO.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(465, 160, 265, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.5, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("stereo_w") range(0, 1, 0.7, 1, 0.01) text("Spread") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 260, 30) text("Spread controls stereo width from the 3 voice positions.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"SOLINA CHORUS — Triple-BBD ensemble chorus (after the ARP/Eminent Solina String Ensemble).

3 modulated delay lines at 120-degree phase offsets, driven by two combined LFOs:
  • Slow chorus (0.05-2 Hz) for broad pitch movement
  • Fast vibrato (1-10 Hz) for shimmer

Each delay voice sees: center_delay + chorus_LFO(phase) * chorus_depth + vibrato_LFO(phase) * vib_depth.
The 120-degree separation ensures the voices don't coincide, creating a wide, lush ensemble effect.

Voice 1 pans left, Voice 2 center, Voice 3 right for stereo spread.

Good starting points:
  • Classic strings: Chr Rate 0.3, Depth 2, Vib Rate 5.5, Depth 0.3
  • Thick unison: Chr Rate 0.15, Depth 3.5, Vib Rate 3, Depth 0.5
  • Subtle shimmer: Chr Rate 0.5, Depth 0.8, Vib Rate 7, Depth 0.15
  • Seasick wobble: Chr Rate 0.1, Depth 5, Vib Rate 1, Depth 0.8"
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
; SOLINA CHORUS — instr 99
;
; 3 modulated delay lines at 120-degree phase offsets.
; Combined slow chorus + fast vibrato LFO per voice.
; Based on the ARP/Eminent Solina String Ensemble circuit.
;==============================================================
instr 99

  ; Read parameters
  kchr_rate   chnget "chr_rate"
  kchr_depth  chnget "chr_depth"
  kchr_center chnget "chr_center"
  kvib_rate   chnget "vib_rate"
  kvib_depth  chnget "vib_depth"
  kdrywet     chnget "dry_wet"
  kvol        chnget "master_vol"
  kspread     chnget "stereo_w"

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Phase offsets: 0, 120, 240 degrees = 0, 0.333, 0.667 of cycle
  ; Chorus LFO (slow) — 3 phases
  kchr_phs phasor kchr_rate
  kchr1 = sin((kchr_phs) * 6.28318)
  kchr2 = sin((kchr_phs + 0.333) * 6.28318)
  kchr3 = sin((kchr_phs + 0.667) * 6.28318)

  ; Vibrato LFO (fast) — 3 phases
  kvib_phs phasor kvib_rate
  kvib1 = sin((kvib_phs) * 6.28318)
  kvib2 = sin((kvib_phs + 0.333) * 6.28318)
  kvib3 = sin((kvib_phs + 0.667) * 6.28318)

  ; Combined delay times (ms → seconds)
  kdel1 = (kchr_center + kchr1 * kchr_depth + kvib1 * kvib_depth) * 0.001
  kdel2 = (kchr_center + kchr2 * kchr_depth + kvib2 * kvib_depth) * 0.001
  kdel3 = (kchr_center + kchr3 * kchr_depth + kvib3 * kvib_depth) * 0.001

  ; Clamp to positive values
  kdel1 limit kdel1, 0.0005, 0.05
  kdel2 limit kdel2, 0.0005, 0.05
  kdel3 limit kdel3, 0.0005, 0.05

  ; 3 modulated delay lines
  av1 vdelay3 amono, kdel1 * 1000, 50
  av2 vdelay3 amono, kdel2 * 1000, 50
  av3 vdelay3 amono, kdel3 * 1000, 50

  ; Pan voices: V1=left, V2=center, V3=right
  awet_L = av1 * 1.0 + av2 * 0.5 + av3 * (1 - kspread)
  awet_R = av1 * (1 - kspread) + av2 * 0.5 + av3 * 1.0
  awet_L = awet_L * 0.4
  awet_R = awet_R * 0.4

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
