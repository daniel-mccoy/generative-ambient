<Cabbage>
form caption("Karplus-Strong Rig") size(740, 490), colour(30, 30, 50), pluginId("kpst")

; Header
label bounds(10, 8, 720, 25) text("KARPLUS-STRONG RIG") fontColour(180, 220, 200) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Extended Karplus-Strong plucked/struck string synthesis") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(2) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(180, 220, 200) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Any excitation creates pitched string tones. Noise bursts = plucked. Sine = bowed feel.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): STRING PARAMS + EXCITATION + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 280, 130) text("STRING PARAMETERS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("ks_freq") range(20, 500, 110, 0.3, 0.1) text("Pitch") textColour(200,200,220) trackerColour(180, 220, 200)
    rslider bounds(70, 25, 55, 55) channel("ks_decay") range(0.5, 30, 5, 0.5, 0.1) text("Decay") textColour(200,200,220) trackerColour(180, 220, 200)
    rslider bounds(130, 25, 55, 55) channel("ks_bright") range(0, 1, 0.5, 1, 0.01) text("Bright") textColour(200,200,220) trackerColour(180, 220, 200)
    rslider bounds(190, 25, 55, 55) channel("ks_stretch") range(0.9, 1.1, 1, 1, 0.001) text("Stretch") textColour(200,200,220) trackerColour(180, 220, 200)
    label bounds(10, 85, 270, 30) text("Pitch = fundamental. Decay = ring time (sec). Bright = LP cutoff in loop. Stretch = inharmonicity.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(295, 160, 155, 130) text("EXCITATION") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("ks_excite") range(0, 1, 0.5, 1, 0.01) text("Mix") textColour(200,200,220) trackerColour(200, 220, 180)
    rslider bounds(70, 25, 55, 55) channel("ks_pos") range(0, 1, 0.2, 1, 0.01) text("Position") textColour(200,200,220) trackerColour(200, 220, 180)
    label bounds(10, 85, 140, 30) text("Mix = excitation vs KS output. Position = pluck point along string.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(455, 160, 275, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.7, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("ks_reverb") range(0, 0.5, 0.15, 1, 0.01) text("Reverb") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(190, 25, 55, 55) channel("ks_chorus") range(0, 1, 0.3, 1, 0.01) text("Chorus") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 265, 30) text("Chorus = detuned double for thickness. Reverb = post-reverb.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"KARPLUS-STRONG — Extended plucked/struck string synthesis via delay-line feedback.

Classic KS algorithm: short noise burst → delay line (1/freq period) → LP filter → feedback.
The noise excitation defines the initial 'pluck', then the delay+filter loop produces a decaying
pitched tone. Extensions: brightness control (LP cutoff in loop), stretch factor for inharmonicity,
and pluck position (comb filtering the excitation at the pluck point).

This is a synthesis effect — the input audio excites the KS string rather than noise. Any transient
becomes a pitched string pluck. Feed noise for classic pluck, feed pitched audio for bowed feel.

Good starting points:
  • Clean pluck: Freq 220, Decay 5, Bright 0.5, Stretch 1
  • Bass guitar: Freq 55, Decay 8, Bright 0.3, Stretch 1
  • Bell-like: Freq 440, Decay 10, Bright 0.8, Stretch 1.05
  • Prepared piano: Freq 110, Decay 3, Bright 0.4, Stretch 0.95"
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
; KARPLUS-STRONG — instr 99
;
; Extended KS: input excitation → delay(1/freq) → LP → feedback.
; Pluck position = comb filter on excitation.
; Stretch factor = allpass in loop for inharmonicity.
; Dual strings (slightly detuned) for chorus.
;==============================================================
instr 99

  ; Read parameters
  kks_freq   chnget "ks_freq"
  kks_decay  chnget "ks_decay"
  kks_bright chnget "ks_bright"
  kks_stretch chnget "ks_stretch"
  kks_excite chnget "ks_excite"
  kks_pos    chnget "ks_pos"
  kdrywet    chnget "dry_wet"
  kvol       chnget "master_vol"
  krvb       chnget "ks_reverb"
  kchorus    chnget "ks_chorus"

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Pluck position comb filter: delay excitation by pos * period
  kperiod = 1 / kks_freq
  kpos_delay = kks_pos * kperiod
  kpos_delay limit kpos_delay, 0.00002, 0.05

  aexcite delayr 0.06
  aexcite_tap deltap3 kpos_delay
              delayw amono
  ; Comb: subtract delayed from original
  aexcite_comb = amono - aexcite_tap * 0.5

  ; LP cutoff for brightness: map 0-1 to 1000-16000 Hz
  kks_lpf = 1000 + kks_bright * 15000

  ; Decay: compute loop gain for desired ring time
  ; gain = 10^(-3 * period / decay_time) — -60dB in decay_time seconds
  ; Use k-rate power workaround for Csound 6
  kloop_gain = exp(-6.908 * kperiod / kks_decay)
  kloop_gain limit kloop_gain, 0, 0.9999

  ; Feedback from previous cycle
  afb1 init 0
  afb2 init 0

  ; String 1 — main
  kdel1 = kperiod * kks_stretch
  kdel1 limit kdel1, 0.00005, 0.1

  abuf1 delayr 0.15
  atap1 deltap3 kdel1
        delayw aexcite_comb * kks_excite + afb1

  ; LP in loop
  afb1 tone atap1 * kloop_gain, kks_lpf

  ; String 2 — slightly detuned for chorus (when enabled)
  kdetune = 1 + kchorus * 0.003
  kdel2 = kperiod * kks_stretch * kdetune
  kdel2 limit kdel2, 0.00005, 0.1

  abuf2 delayr 0.15
  atap2 deltap3 kdel2
        delayw aexcite_comb * kks_excite + afb2

  afb2 tone atap2 * kloop_gain, kks_lpf

  ; Mix strings: S1 center-left, S2 center-right
  awet_L = atap1 * 0.6 + atap2 * 0.3 * kchorus
  awet_R = atap1 * 0.3 + atap2 * 0.6 * kchorus
  ; When chorus is 0, S2 is silent and output is mono S1
  if kchorus < 0.01 then
    awet_L = atap1 * 0.5
    awet_R = atap1 * 0.5
  endif

  ; Post reverb
  arvb_L, arvb_R reverbsc awet_L, awet_R, 0.6, 8000
  awet_L = awet_L + arvb_L * krvb
  awet_R = awet_R + arvb_R * krvb

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
