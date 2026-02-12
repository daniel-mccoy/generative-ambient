<Cabbage>
form caption("Modal Resonator Rig") size(740, 490), colour(30, 30, 50), pluginId("mdrs")

; Header
label bounds(10, 8, 720, 25) text("MODAL RESONATOR RIG") fontColour(240, 180, 130) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Bank of mode filters for metallic/resonant body simulation") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(2) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(240, 180, 130) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Noise bursts excite all modes — like striking a bell or metal plate. Try different presets for character.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): MODE TUNING + RESONANCE + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 310, 130) text("MODE TUNING (6 partials)") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 25, 45, 45) channel("m1_ratio") range(0.5, 8, 1, 0.5, 0.01) text("M1") textColour(200,200,220) trackerColour(240, 180, 130)
    rslider bounds(52, 25, 45, 45) channel("m2_ratio") range(0.5, 8, 2.76, 0.5, 0.01) text("M2") textColour(200,200,220) trackerColour(240, 180, 130)
    rslider bounds(99, 25, 45, 45) channel("m3_ratio") range(0.5, 8, 5.40, 0.5, 0.01) text("M3") textColour(200,200,220) trackerColour(240, 180, 130)
    rslider bounds(146, 25, 45, 45) channel("m4_ratio") range(0.5, 8, 8.93, 0.5, 0.01) text("M4") textColour(200,200,220) trackerColour(240, 180, 130)
    rslider bounds(193, 25, 45, 45) channel("m5_ratio") range(0.5, 16, 13.3, 0.5, 0.01) text("M5") textColour(200,200,220) trackerColour(240, 180, 130)
    rslider bounds(240, 25, 45, 45) channel("m6_ratio") range(0.5, 16, 18.7, 0.5, 0.01) text("M6") textColour(200,200,220) trackerColour(240, 180, 130)
    label bounds(5, 78, 300, 35) text("Frequency ratios x base freq. Defaults = circular plate modes (non-harmonic). Harmonic: 1,2,3,4,5,6.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(325, 160, 155, 130) text("RESONANCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("md_base") range(30, 1000, 220, 0.3, 1) text("Base Hz") textColour(200,200,220) trackerColour(240, 180, 130)
    rslider bounds(70, 25, 55, 55) channel("md_q") range(10, 5000, 500, 0.3, 1) text("Q Factor") textColour(200,200,220) trackerColour(240, 180, 130)
    label bounds(10, 85, 140, 30) text("Base = fundamental. Q = ring time (higher = longer).") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(485, 160, 245, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.6, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("md_mix") range(0, 1, 0.5, 1, 0.01) text("Mix") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 230, 30) text("Mix blends between mode outputs. Alternating L/R panning per mode.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"MODAL RESONATOR — Bank of mode filters for physical object simulation.

6 parallel mode filters (2nd-order bandpass resonators) tuned to frequency ratios of a base pitch.
Any audio fed through them rings at those frequencies — like exciting a metal plate, bell, tube,
or any resonant body. The Q factor controls ring time: low Q = short ping, high Q = long singing.

Non-harmonic ratios (default: plate modes 1, 2.76, 5.40, 8.93, 13.3, 18.7) create metallic/bell
character. Harmonic ratios (1, 2, 3, 4, 5, 6) create stringy/vocal resonance. Noise excitation
lights up all modes equally — like striking the object.

Modes are panned alternating L/R for stereo spread.

Good starting points:
  • Metal plate: Base 220, ratios 1/2.76/5.40/8.93/13.3/18.7, Q 500
  • Tubular bell: Base 440, ratios 1/2/3.01/4.03/5.08/6.12, Q 2000
  • Singing bowl: Base 130, ratios 1/2.71/5.0/8.0/11.8/16.3, Q 3000
  • Marimba: Base 220, ratios 1/3.98/9.01/14.9/22.0/30.5, Q 200"
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
; MODAL RESONATOR — instr 99
;
; 6 parallel mode filters tuned to ratios of a base frequency.
; mode opcode: asig, kfreq, kq
; Alternating L/R panning for stereo.
;==============================================================
instr 99

  ; Read parameters
  kr1    chnget "m1_ratio"
  kr2    chnget "m2_ratio"
  kr3    chnget "m3_ratio"
  kr4    chnget "m4_ratio"
  kr5    chnget "m5_ratio"
  kr6    chnget "m6_ratio"
  kbase  chnget "md_base"
  kq     chnget "md_q"
  kdrywet chnget "dry_wet"
  kvol   chnget "master_vol"
  kmix   chnget "md_mix"

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Compute mode frequencies, clamped to Nyquist
  kf1 = kbase * kr1
  kf2 = kbase * kr2
  kf3 = kbase * kr3
  kf4 = kbase * kr4
  kf5 = kbase * kr5
  kf6 = kbase * kr6

  ; Clamp to safe range (mode needs freq < sr/2)
  kf1 limit kf1, 20, sr * 0.45
  kf2 limit kf2, 20, sr * 0.45
  kf3 limit kf3, 20, sr * 0.45
  kf4 limit kf4, 20, sr * 0.45
  kf5 limit kf5, 20, sr * 0.45
  kf6 limit kf6, 20, sr * 0.45

  ; 6 mode filters — each decays independently based on Q
  ; Higher partials decay faster (lower Q)
  am1 mode amono, kf1, kq
  am2 mode amono, kf2, kq * 0.8
  am3 mode amono, kf3, kq * 0.6
  am4 mode amono, kf4, kq * 0.5
  am5 mode amono, kf5, kq * 0.35
  am6 mode amono, kf6, kq * 0.25

  ; Mix modes with alternating L/R panning
  ; Odd modes left, even modes right
  ; Scale by inverse ratio for natural amplitude rolloff
  awet_L = (am1 + am3 * 0.7 + am5 * 0.4) * kmix * 0.3
  awet_R = (am2 * 0.85 + am4 * 0.55 + am6 * 0.3) * kmix * 0.3

  ; Soft clip to prevent ringing blowup at high Q
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
