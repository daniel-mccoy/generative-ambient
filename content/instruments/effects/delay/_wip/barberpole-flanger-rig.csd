<Cabbage>
form caption("Barberpole Flanger Rig") size(740, 490), colour(30, 30, 50), pluginId("bpfl")

; Header
label bounds(10, 8, 720, 25) text("BARBERPOLE FLANGER RIG") fontColour(180, 200, 240) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Shepard-tone infinite flanging via Hilbert transform") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(3) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 220, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(180, 200, 240) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Use Sustained Sine — the infinite upward/downward sweep is hypnotic. Like Shepard tones for flanging.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): FLANGER + BARBERPOLE + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 250, 130) text("FLANGER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("fl_rate") range(0.01, 2, 0.1, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(180, 200, 240)
    rslider bounds(70, 25, 55, 55) channel("fl_depth") range(0, 5, 2, 0.5, 0.01) text("Depth") textColour(200,200,220) trackerColour(180, 200, 240)
    rslider bounds(130, 25, 55, 55) channel("fl_center") range(0.5, 10, 3, 0.5, 0.1) text("Center") textColour(200,200,220) trackerColour(180, 200, 240)
    label bounds(10, 85, 240, 30) text("Rate = sweep speed. Depth = modulation (ms). Center = base delay (ms).") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(265, 160, 210, 130) text("BARBERPOLE") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("bp_shift") range(-5, 5, 0.5, 1, 0.1) text("Shift Hz") textColour(200,200,220) trackerColour(160, 220, 240)
    rslider bounds(70, 25, 55, 55) channel("bp_feedback") range(0, 0.9, 0.5, 1, 0.01) text("Feedback") textColour(200,200,220) trackerColour(160, 220, 240)
    rslider bounds(130, 25, 55, 55) channel("bp_regen") range(0, 0.95, 0.3, 1, 0.01) text("Regen") textColour(200,200,220) trackerColour(160, 220, 240)
    label bounds(10, 85, 200, 30) text("Shift = Hilbert freq offset for infinite sweep. + = up, - = down. Regen = flanging intensity.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(480, 160, 250, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.5, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("fl_stereo") range(0, 1, 0.7, 1, 0.01) text("Stereo") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 245, 30) text("Stereo = L/R phase offset for wide spatial flanging.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"BARBERPOLE FLANGER — Shepard-tone infinite flanging via Hilbert transform.

Combines a conventional modulated-delay flanger with Hilbert-transform frequency shifting.
The frequency shift creates the illusion of infinitely rising or falling comb filter notches —
like a barber pole that seems to move endlessly upward or downward. This is impossible with
conventional flanging (which always reverses direction).

The flanger section provides the base comb filter effect (delay modulated by LFO). The barberpole
section adds the SSB frequency shift in the feedback path for the infinite sweep illusion.
Regen controls the depth of the comb notches (resonance). Stereo offsets the L/R LFO phases.

Good starting points:
  • Classic barberpole up: Rate 0.1, Depth 2, Shift 0.5, Regen 0.3
  • Deep downward: Rate 0.05, Depth 3, Shift -0.8, Regen 0.5
  • Metallic sweep: Rate 0.2, Depth 1, Shift 2, Regen 0.6, FB 0.7
  • Gentle shimmer: Rate 0.03, Depth 1.5, Shift 0.2, Regen 0.2"
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
; BARBERPOLE FLANGER — instr 99
;
; Conventional flanger (modulated vdelay3) with Hilbert
; frequency shifting in the feedback path for infinite
; upward/downward sweep illusion.
;==============================================================
instr 99

  ; Read parameters
  kfl_rate   chnget "fl_rate"
  kfl_depth  chnget "fl_depth"
  kfl_center chnget "fl_center"
  kbp_shift  chnget "bp_shift"
  kbp_fb     chnget "bp_feedback"
  kbp_regen  chnget "bp_regen"
  kdrywet    chnget "dry_wet"
  kvol       chnget "master_vol"
  kstereo    chnget "fl_stereo"

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Feedback from previous cycle
  afb_L init 0
  afb_R init 0

  ; Flanger LFO — L and R with phase offset for stereo
  kphs phasor kfl_rate
  klfo_L = sin(kphs * 6.28318)
  klfo_R = sin((kphs + kstereo * 0.5) * 6.28318)

  ; Modulated delay times (ms → sec)
  kdel_L = (kfl_center + klfo_L * kfl_depth) * 0.001
  kdel_R = (kfl_center + klfo_R * kfl_depth) * 0.001
  kdel_L limit kdel_L, 0.00005, 0.03
  kdel_R limit kdel_R, 0.00005, 0.03

  ; Delay lines with regeneration feedback
  abuf_L delayr 0.05
  atap_L deltap3 kdel_L
         delayw amono + afb_L * kbp_regen

  abuf_R delayr 0.05
  atap_R deltap3 kdel_R
         delayw amono + afb_R * kbp_regen

  ; Hilbert transform on delay output for frequency shifting
  areal_L, aimag_L hilbert atap_L
  areal_R, aimag_R hilbert atap_R

  ; SSB modulation carrier
  acos_car oscili 1, kbp_shift, gi_sine
  asin_car oscili 1, kbp_shift, gi_sine, 0.25

  ; Upper sideband: real*cos - imag*sin
  ashift_L = areal_L * acos_car - aimag_L * asin_car
  ashift_R = areal_R * acos_car - aimag_R * asin_car

  ; Feedback (frequency-shifted signal goes back into delay)
  afb_L = ashift_L * kbp_fb
  afb_R = ashift_R * kbp_fb

  ; Mix: flanger output is delay mixed with dry
  ; The comb effect comes from delay + dry interference
  awet_L = atap_L
  awet_R = atap_R

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
