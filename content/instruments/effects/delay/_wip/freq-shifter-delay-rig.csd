<Cabbage>
form caption("Frequency Shifter Delay Rig") size(740, 490), colour(30, 30, 50), pluginId("fsdl")

; Header
label bounds(10, 8, 720, 25) text("FREQUENCY SHIFTER DELAY RIG") fontColour(200, 160, 220) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Hilbert SSB frequency shift in delay feedback loop") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(200, 160, 220) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Each repeat shifts by N Hz — sine pings become metallic bells. Try small shifts (1-5 Hz) for subtle.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): DELAY + FREQ SHIFT + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 180, 130) text("DELAY") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dly_time") range(0.05, 2, 0.4, 0.5, 0.01) text("Time") textColour(200,200,220) trackerColour(200, 160, 220)
    rslider bounds(70, 25, 55, 55) channel("dly_fb") range(0, 0.95, 0.7, 1, 0.01) text("Feedback") textColour(200,200,220) trackerColour(200, 160, 220)
    label bounds(10, 85, 160, 30) text("Time in seconds. High FB for long shimmer tails.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(195, 160, 270, 130) text("FREQUENCY SHIFT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("fs_shift") range(-20, 20, 3, 1, 0.1) text("Shift Hz") textColour(200,200,220) trackerColour(200, 160, 220)
    rslider bounds(70, 25, 55, 55) channel("fs_mod_depth") range(0, 10, 0, 0.5, 0.1) text("Mod Dep") textColour(200,200,220) trackerColour(200, 160, 220)
    rslider bounds(130, 25, 55, 55) channel("fs_mod_rate") range(0.01, 2, 0.1, 0.5, 0.01) text("Mod Rate") textColour(200,200,220) trackerColour(200, 160, 220)
    rslider bounds(190, 25, 55, 55) channel("fs_tone") range(500, 14000, 8000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(200, 160, 220)
    label bounds(10, 85, 255, 30) text("Shift = Hz offset per repeat. + = up, - = down. Mod = LFO on shift amount. Tone = LP in loop.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(470, 160, 260, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.5, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("fs_width") range(0, 2, 1, 1, 0.01) text("Width") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 250, 30) text("Width controls stereo from Hilbert pair. Mid-side processing.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"FREQUENCY SHIFTER DELAY — Hilbert SSB frequency shift in delay feedback loop.

Each repeat through the delay loop gets shifted by N Hz via single-sideband modulation using
the Hilbert transform. Unlike pitch shifting, frequency shifting moves ALL frequencies by the
same absolute amount — destroying harmonic relationships and creating inharmonic, bell-like,
metallic textures. Small shifts (1-5 Hz) create gentle beating/phasing. Large shifts (10+ Hz)
create rapid metallic decay into noise.

The Hilbert transform produces two signals (cos/sin quadrature) which enable both up-shift and
down-shift — this rig uses the upper sideband (positive = up, negative = down).

Good starting points:
  • Gentle shimmer: Shift 2, FB 0.7, Time 0.4, Tone 8000
  • Metallic bells: Shift 8, FB 0.8, Time 0.3, Tone 12000
  • Deep undertones: Shift -3, FB 0.7, Time 0.5, Tone 4000
  • Modulated wash: Shift 5, Mod Dep 4, Mod Rate 0.1, FB 0.8"
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
; FREQUENCY SHIFTER DELAY — instr 99
;
; Delay loop with Hilbert-transform SSB frequency shifting.
; Each repeat shifts by kshift Hz, creating inharmonic cascades.
; hilbert → multiply by carrier → extract upper sideband.
;==============================================================
instr 99

  ; Read parameters
  ktime      chnget "dly_time"
  kfb        chnget "dly_fb"
  kshift     chnget "fs_shift"
  kmod_depth chnget "fs_mod_depth"
  kmod_rate  chnget "fs_mod_rate"
  ktone      chnget "fs_tone"
  kdrywet    chnget "dry_wet"
  kvol       chnget "master_vol"
  kwidth     chnget "fs_width"

  ; LFO modulation on shift amount
  kmod_lfo oscili kmod_depth, kmod_rate, gi_sine
  kshift_actual = kshift + kmod_lfo

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Feedback from previous cycle (already frequency-shifted)
  afb_L init 0
  afb_R init 0

  ; Delay lines
  abuf_L delayr 3.0
  atap_L deltap3 ktime
         delayw amono + afb_L * kfb

  abuf_R delayr 3.0
  atap_R deltap3 ktime
         delayw amono + afb_R * kfb

  ; Hilbert transform of delay output (produces cos and sin quadrature signals)
  areal_L, aimag_L hilbert atap_L
  areal_R, aimag_R hilbert atap_R

  ; Carrier oscillator for SSB modulation
  acos_car oscili 1, kshift_actual, gi_sine
  ; 90-degree offset for sin carrier
  asin_car oscili 1, kshift_actual, gi_sine, 0.25

  ; Upper sideband: real*cos - imag*sin
  ashift_L = areal_L * acos_car - aimag_L * asin_car
  ashift_R = areal_R * acos_car - aimag_R * asin_car

  ; Tone filter
  afb_L tone ashift_L, ktone
  afb_R tone ashift_R, ktone

  ; Stereo width (mid-side)
  a_mid  = (ashift_L + ashift_R) * 0.5
  a_side = (ashift_L - ashift_R) * 0.5
  awet_L = a_mid + a_side * kwidth
  awet_R = a_mid - a_side * kwidth

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
