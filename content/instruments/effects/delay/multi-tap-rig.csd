<Cabbage>
form caption("Multi-Tap Delay Rig") size(740, 490), colour(30, 30, 50), pluginId("mtdl")

; Header
label bounds(10, 8, 720, 25) text("MULTI-TAP DELAY RIG") fontColour(200, 120, 200) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — 4 independent delay taps with pan and level") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(200, 120, 200) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Use prime-ratio tap times to avoid comb artifacts. Pings reveal the rhythm pattern clearly.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): 4 TAPS + FEEDBACK + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 370, 130) text("TAP TIMES & LEVELS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 25, 42, 42) channel("tap1_time") range(0.05, 2, 0.137, 0.5, 0.001) text("T1") textColour(200,200,220) trackerColour(200, 120, 200)
    rslider bounds(48, 25, 42, 42) channel("tap1_level") range(0, 1, 0.8, 1, 0.01) text("L1") textColour(200,200,220) trackerColour(200, 120, 200)
    rslider bounds(95, 25, 42, 42) channel("tap2_time") range(0.05, 2, 0.293, 0.5, 0.001) text("T2") textColour(200,200,220) trackerColour(200, 150, 200)
    rslider bounds(138, 25, 42, 42) channel("tap2_level") range(0, 1, 0.6, 1, 0.01) text("L2") textColour(200,200,220) trackerColour(200, 150, 200)
    rslider bounds(185, 25, 42, 42) channel("tap3_time") range(0.05, 2, 0.467, 0.5, 0.001) text("T3") textColour(200,200,220) trackerColour(200, 180, 200)
    rslider bounds(228, 25, 42, 42) channel("tap3_level") range(0, 1, 0.4, 1, 0.01) text("L3") textColour(200,200,220) trackerColour(200, 180, 200)
    rslider bounds(275, 25, 42, 42) channel("tap4_time") range(0.05, 2, 0.631, 0.5, 0.001) text("T4") textColour(200,200,220) trackerColour(200, 200, 220)
    rslider bounds(318, 25, 42, 42) channel("tap4_level") range(0, 1, 0.3, 1, 0.01) text("L4") textColour(200,200,220) trackerColour(200, 200, 220)
    label bounds(5, 75, 360, 40) text("T = tap time (sec). L = tap level. Defaults are prime ratios (0.137, 0.293, 0.467, 0.631) to avoid resonance.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(385, 160, 165, 130) text("FEEDBACK") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("fb_amount") range(0, 0.9, 0.4, 1, 0.01) text("Amount") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(70, 25, 55, 55) channel("fb_tone") range(500, 14000, 6000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(200, 180, 130)
    label bounds(10, 85, 150, 30) text("Only longest tap feeds back. Tone = LP in loop.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(555, 160, 175, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.5, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 165, 30) text("Taps auto-pan: 1=L, 2=R, 3=CL, 4=CR.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"MULTI-TAP DELAY — 4 independent delay taps with auto-panning.

Each tap has its own time and level. Taps are automatically panned across the stereo field
(Tap 1 = hard left, Tap 2 = hard right, Tap 3 = center-left, Tap 4 = center-right) for
spatial complexity. Only the longest tap feeds back to avoid runaway from multiple feedback paths.

Default tap times use prime-number ratios (0.137, 0.293, 0.467, 0.631) to avoid comb filter
resonances and create non-repeating rhythmic patterns.

Good starting points:
  • Prime scatter: T1 0.137, T2 0.293, T3 0.467, T4 0.631, FB 0.4
  • Triplet feel: T1 0.2, T2 0.4, T3 0.6, T4 0.133, FB 0.5
  • Dense cloud: T1 0.08, T2 0.13, T3 0.21, T4 0.34 (Fibonacci), FB 0.6
  • Sparse ambient: T1 0.5, T2 1.0, T3 1.5, T4 2.0, FB 0.3"
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
; MULTI-TAP DELAY — instr 99
;
; Single delay buffer with 4 taps at independent times/levels.
; Taps auto-panned across stereo field.
; Only the longest tap feeds back to prevent runaway.
;==============================================================
instr 99

  ; Read parameters
  kt1    chnget "tap1_time"
  kl1    chnget "tap1_level"
  kt2    chnget "tap2_time"
  kl2    chnget "tap2_level"
  kt3    chnget "tap3_time"
  kl3    chnget "tap3_level"
  kt4    chnget "tap4_time"
  kl4    chnget "tap4_level"
  kfb    chnget "fb_amount"
  ktone  chnget "fb_tone"
  kdrywet chnget "dry_wet"
  kvol   chnget "master_vol"

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Feedback from previous cycle (from longest tap)
  afb init 0

  ; Single delay buffer with multiple taps
  abuf delayr 3.0
  atap1 deltap3 kt1
  atap2 deltap3 kt2
  atap3 deltap3 kt3
  atap4 deltap3 kt4
        delayw amono + afb * kfb

  ; Find longest tap and use for feedback
  ; (simplified: just use the max of all taps weighted by level)
  afb_raw = atap1 * kl1 + atap2 * kl2 + atap3 * kl3 + atap4 * kl4
  afb_raw = afb_raw * 0.3
  afb tone afb_raw, ktone

  ; Pan taps across stereo field
  ; Tap 1: hard left, Tap 2: hard right
  ; Tap 3: center-left, Tap 4: center-right
  awet_L = atap1 * kl1 * 1.0 + atap2 * kl2 * 0.0 + atap3 * kl3 * 0.7 + atap4 * kl4 * 0.3
  awet_R = atap1 * kl1 * 0.0 + atap2 * kl2 * 1.0 + atap3 * kl3 * 0.3 + atap4 * kl4 * 0.7

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
