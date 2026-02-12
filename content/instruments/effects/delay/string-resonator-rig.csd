<Cabbage>
form caption("String Resonator Rig") size(740, 490), colour(30, 30, 50), pluginId("sres")

; Header
label bounds(10, 8, 720, 25) text("STRING RESONATOR RIG") fontColour(224, 200, 120) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Sympathetic string resonance via streson (Lazzarini)") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(2) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(224, 200, 120) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Noise bursts excite all strings equally — like hitting a piano with sustain pedal down. Try it!") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): CHORD TUNING + RESONANCE + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 310, 130) text("STRING TUNING (6 strings)") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 25, 45, 45) channel("str1_freq") range(30, 1000, 65.41, 0.3, 0.01) text("S1") textColour(200,200,220) trackerColour(224, 200, 120)
    rslider bounds(52, 25, 45, 45) channel("str2_freq") range(30, 1000, 98.0, 0.3, 0.01) text("S2") textColour(200,200,220) trackerColour(224, 200, 120)
    rslider bounds(99, 25, 45, 45) channel("str3_freq") range(30, 1000, 130.81, 0.3, 0.01) text("S3") textColour(200,200,220) trackerColour(224, 200, 120)
    rslider bounds(146, 25, 45, 45) channel("str4_freq") range(30, 1000, 196.0, 0.3, 0.01) text("S4") textColour(200,200,220) trackerColour(224, 200, 120)
    rslider bounds(193, 25, 45, 45) channel("str5_freq") range(30, 1000, 261.63, 0.3, 0.01) text("S5") textColour(200,200,220) trackerColour(224, 200, 120)
    rslider bounds(240, 25, 45, 45) channel("str6_freq") range(30, 1000, 392.0, 0.3, 0.01) text("S6") textColour(200,200,220) trackerColour(224, 200, 120)
    label bounds(5, 78, 300, 35) text("Defaults = C2 G2 C3 G3 C4 G4 (open C tuning). Each string resonates sympathetically at its frequency.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(325, 160, 155, 130) text("RESONANCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("res_fb") range(0.9, 0.9999, 0.995, 1, 0.0001) text("Sustain") textColour(200,200,220) trackerColour(224, 200, 120)
    rslider bounds(70, 25, 55, 55) channel("res_mix") range(0, 1, 0.6, 1, 0.01) text("Mix") textColour(200,200,220) trackerColour(224, 200, 120)
    label bounds(10, 85, 140, 30) text("Sustain > 0.999 = very long ringing strings.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(485, 160, 245, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.6, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("post_lpf") range(500, 16000, 10000, 0.4, 1) text("Tone") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 230, 30) text("Tone = post-filter. Tame string brightness.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"STRING RESONATOR — Sympathetic resonance via streson (Victor Lazzarini, SndObj).

6 parallel streson filters tuned to a chord. Any audio fed through them rings at those pitches —
like opening a piano's sustain pedal and playing into it. Noise bursts excite all strings equally,
creating shimmering harmonic clouds. Pitched input excites strings whose frequencies align.

streson = comb filter + allpass + lowpass network simulating string vibration. Feedback (Sustain)
controls ring time: 0.99 = moderate, 0.999 = very long, 0.9999 = nearly infinite.

Strings are panned alternating L/R for stereo spread.

Good starting points:
  • Open C: 65.4, 98, 130.8, 196, 261.6, 392 (default)
  • Drone fifth: 55, 82.5, 110, 165, 220, 330 (A power chord)
  • Gamelan: 73.4, 110, 146.8, 185, 220, 293.7 (non-Western)
  • Sustain 0.999 for long ringing, 0.995 for shorter pluck-like decay"
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
; STRING RESONATOR — instr 99
;
; 6 parallel streson filters tuned to a chord.
; Alternating L/R panning for stereo spread.
; streson: asig, kfreq, kfdbgain
;==============================================================
instr 99

  ; Read parameters
  kf1    chnget "str1_freq"
  kf2    chnget "str2_freq"
  kf3    chnget "str3_freq"
  kf4    chnget "str4_freq"
  kf5    chnget "str5_freq"
  kf6    chnget "str6_freq"
  kfb    chnget "res_fb"
  kmix   chnget "res_mix"
  kdrywet chnget "dry_wet"
  kvol   chnget "master_vol"
  klpf   chnget "post_lpf"

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; 6 parallel string resonators
  as1 streson amono, kf1, kfb
  as2 streson amono, kf2, kfb
  as3 streson amono, kf3, kfb
  as4 streson amono, kf4, kfb
  as5 streson amono, kf5, kfb
  as6 streson amono, kf6, kfb

  ; Mix strings with alternating L/R panning
  ; Odd strings left, even strings right
  awet_L = (as1 + as3 + as5) * kmix * 0.33
  awet_R = (as2 + as4 + as6) * kmix * 0.33

  ; Post-filter
  awet_L butterlp awet_L, klpf
  awet_R butterlp awet_R, klpf

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
