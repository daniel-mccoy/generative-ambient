<Cabbage>
form caption("Diffusion Network Rig") size(740, 490), colour(30, 30, 50), pluginId("dfnw")

; Header
label bounds(10, 8, 720, 25) text("DIFFUSION NETWORK RIG") fontColour(160, 200, 180) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Allpass diffusion cascade with external feedback for smeared echoes") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(160, 200, 180) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Pings are smeared into dense, diffuse echoes. Higher diffusion = more reverb-like. Lower = distinct taps.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): DIFFUSION + DELAY + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 250, 130) text("DIFFUSION") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("df_coeff") range(0.1, 0.7, 0.5, 1, 0.01) text("Amount") textColour(200,200,220) trackerColour(160, 200, 180)
    rslider bounds(70, 25, 55, 55) channel("df_spread") range(0.5, 4, 1, 0.5, 0.01) text("Spread") textColour(200,200,220) trackerColour(160, 200, 180)
    rslider bounds(130, 25, 55, 55) channel("df_mod") range(0, 1, 0.2, 0.5, 0.01) text("Mod") textColour(200,200,220) trackerColour(160, 200, 180)
    label bounds(10, 85, 240, 30) text("Amount = allpass coefficient. Spread = delay time multiplier. Mod = LFO on allpass times.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(265, 160, 200, 130) text("FEEDBACK DELAY") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("df_dly") range(0.05, 2, 0.3, 0.5, 0.01) text("Time") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(70, 25, 55, 55) channel("df_fb") range(0, 0.9, 0.5, 1, 0.01) text("Feedback") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(130, 25, 55, 55) channel("df_tone") range(500, 14000, 6000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(200, 180, 130)
    label bounds(10, 85, 195, 30) text("External delay line wrapping around the diffusion cascade.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(470, 160, 260, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.5, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("df_width") range(0, 1, 0.7, 1, 0.01) text("Width") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 250, 30) text("Width controls stereo decorrelation between the allpass chains.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"DIFFUSION NETWORK — Allpass cascade with external feedback for smeared echoes.

4 series allpass filters with prime-ratio delay times act as a diffusion stage. Allpass filters
preserve amplitude but randomize phase, smearing transients into dense clouds. An external feedback
delay wraps around the cascade for repeating echoes, each increasingly diffused.

Low diffusion coefficient = distinct echoes that gradually blur. High coefficient = immediate dense
wash. Spread multiplies all allpass times for larger/smaller diffusion. Mod adds LFO on the allpass
delay times for evolving character. Width decorrelates L/R chains using different prime ratios.

Good starting points:
  • Smeared echo: Amount 0.5, Spread 1, Delay 0.3, FB 0.5, Tone 6000
  • Dense wash: Amount 0.65, Spread 2, Delay 0.5, FB 0.7, Tone 3000
  • Subtle thickening: Amount 0.3, Spread 0.5, Delay 0.1, FB 0.3, Tone 10000
  • Evolving space: Amount 0.5, Spread 1.5, Mod 0.5, Delay 0.4, FB 0.6"
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
; DIFFUSION NETWORK — instr 99
;
; 4 series allpass filters per channel with prime-ratio delays.
; External feedback delay wraps around the cascade.
; L and R channels use different prime sets for decorrelation.
;
; Allpass: y(n) = -g*x(n) + x(n-D) + g*y(n-D)
; Implemented via delayr/delayw with allpass feedback.
;==============================================================
instr 99

  ; Read parameters
  kcoeff  chnget "df_coeff"
  kspread chnget "df_spread"
  kmod    chnget "df_mod"
  kdly    chnget "df_dly"
  kfb     chnget "df_fb"
  ktone   chnget "df_tone"
  kdrywet chnget "dry_wet"
  kvol    chnget "master_vol"
  kwidth  chnget "df_width"

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; External feedback from previous cycle
  aext_fb_L init 0
  aext_fb_R init 0

  ; Input with external feedback
  ain_L = amono + aext_fb_L * kfb
  ain_R = amono + aext_fb_R * kfb

  ; Modulation LFOs for allpass times
  kmod1 oscili kmod * 0.0003, 0.37, gi_sine
  kmod2 oscili kmod * 0.0003, 0.53, gi_sine
  kmod3 oscili kmod * 0.0003, 0.71, gi_sine
  kmod4 oscili kmod * 0.0003, 0.97, gi_sine

  ; ---------------------------------------------------------------
  ; LEFT CHANNEL: 4 series allpasses (prime delays in ms, scaled by spread)
  ; Primes: 7.1, 11.3, 17.9, 23.7 ms
  ; ---------------------------------------------------------------

  ; Allpass 1 — 7.1 ms
  kd1_L = (0.0071 + kmod1) * kspread
  kd1_L limit kd1_L, 0.0002, 0.15

  abuf1_L delayr 0.2
  atap1_L deltap3 kd1_L
          delayw ain_L + atap1_L * kcoeff
  aap1_L = atap1_L - ain_L * kcoeff

  ; Allpass 2 — 11.3 ms
  kd2_L = (0.0113 + kmod2) * kspread
  kd2_L limit kd2_L, 0.0002, 0.15

  abuf2_L delayr 0.2
  atap2_L deltap3 kd2_L
          delayw aap1_L + atap2_L * kcoeff
  aap2_L = atap2_L - aap1_L * kcoeff

  ; Allpass 3 — 17.9 ms
  kd3_L = (0.0179 + kmod3) * kspread
  kd3_L limit kd3_L, 0.0002, 0.15

  abuf3_L delayr 0.2
  atap3_L deltap3 kd3_L
          delayw aap2_L + atap3_L * kcoeff
  aap3_L = atap3_L - aap2_L * kcoeff

  ; Allpass 4 — 23.7 ms
  kd4_L = (0.0237 + kmod4) * kspread
  kd4_L limit kd4_L, 0.0002, 0.15

  abuf4_L delayr 0.2
  atap4_L deltap3 kd4_L
          delayw aap3_L + atap4_L * kcoeff
  aap4_L = atap4_L - aap3_L * kcoeff

  ; ---------------------------------------------------------------
  ; RIGHT CHANNEL: different prime delays for decorrelation
  ; Primes: 8.3, 13.1, 19.7, 29.3 ms (scaled by width blend)
  ; ---------------------------------------------------------------

  ; Blend between same-as-L and decorrelated primes
  kd1_R_base = 0.0071 * (1 - kwidth) + 0.0083 * kwidth
  kd2_R_base = 0.0113 * (1 - kwidth) + 0.0131 * kwidth
  kd3_R_base = 0.0179 * (1 - kwidth) + 0.0197 * kwidth
  kd4_R_base = 0.0237 * (1 - kwidth) + 0.0293 * kwidth

  kd1_R = (kd1_R_base + kmod1 * 1.1) * kspread
  kd2_R = (kd2_R_base + kmod2 * 0.9) * kspread
  kd3_R = (kd3_R_base + kmod3 * 1.2) * kspread
  kd4_R = (kd4_R_base + kmod4 * 0.8) * kspread

  kd1_R limit kd1_R, 0.0002, 0.15
  kd2_R limit kd2_R, 0.0002, 0.15
  kd3_R limit kd3_R, 0.0002, 0.15
  kd4_R limit kd4_R, 0.0002, 0.15

  abuf1_R delayr 0.2
  atap1_R deltap3 kd1_R
          delayw ain_R + atap1_R * kcoeff
  aap1_R = atap1_R - ain_R * kcoeff

  abuf2_R delayr 0.2
  atap2_R deltap3 kd2_R
          delayw aap1_R + atap2_R * kcoeff
  aap2_R = atap2_R - aap1_R * kcoeff

  abuf3_R delayr 0.2
  atap3_R deltap3 kd3_R
          delayw aap2_R + atap3_R * kcoeff
  aap3_R = atap3_R - aap2_R * kcoeff

  abuf4_R delayr 0.2
  atap4_R deltap3 kd4_R
          delayw aap3_R + atap4_R * kcoeff
  aap4_R = atap4_R - aap3_R * kcoeff

  ; ---------------------------------------------------------------
  ; External feedback delay
  ; ---------------------------------------------------------------
  abuf_dly_L delayr 3.0
  adly_L deltap3 kdly
         delayw aap4_L

  abuf_dly_R delayr 3.0
  adly_R deltap3 kdly
         delayw aap4_R

  ; Tone filter in feedback path
  aext_fb_L tone adly_L, ktone
  aext_fb_R tone adly_R, ktone

  ; Wet signal = diffused + delayed
  awet_L = aap4_L
  awet_R = aap4_R

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
