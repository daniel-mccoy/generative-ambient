<Cabbage>
form caption("Dattorro Plate Reverb Rig") size(740, 530), colour(30, 30, 50), pluginId("dtpl")

; Header
label bounds(10, 8, 720, 25) text("DATTORRO PLATE REVERB RIG") fontColour(224, 140, 100) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Allpass-loop plate reverb (after Jon Dattorro, 'Effect Design Part 1')") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 220, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(224, 140, 100) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Sine/Noise Ping = auto-triggered bursts at Rate Hz. Sustained = continuous.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): PLATE PARAMETERS
;=====================================================================

groupbox bounds(10, 160, 310, 130) text("PLATE") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("decay") range(0.1, 0.999, 0.7, 1, 0.001) text("Decay") textColour(200,200,220) trackerColour(224, 140, 100)
    rslider bounds(70, 25, 55, 55) channel("damping") range(500, 16000, 8000, 0.4, 1) text("Damping") textColour(200,200,220) trackerColour(224, 140, 100)
    rslider bounds(130, 25, 55, 55) channel("bandwidth") range(500, 16000, 12000, 0.4, 1) text("Bandwidth") textColour(200,200,220) trackerColour(224, 140, 100)
    rslider bounds(190, 25, 55, 55) channel("predelay") range(0, 200, 10, 0.5, 1) text("PreDly") textColour(200,200,220) trackerColour(224, 140, 100)
    label bounds(10, 85, 290, 30) text("Decay = reverb time. Damping = HF rolloff in tank. Bandwidth = input brightness.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(325, 160, 185, 130) text("DIFFUSION") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 50, 50) channel("in_diff1") range(0.1, 0.95, 0.75, 1, 0.01) text("Input 1") textColour(200,200,220) trackerColour(200, 140, 100)
    rslider bounds(65, 25, 50, 50) channel("in_diff2") range(0.1, 0.95, 0.625, 1, 0.01) text("Input 2") textColour(200,200,220) trackerColour(200, 140, 100)
    label bounds(10, 85, 170, 30) text("Input diffusor coefficients. Higher = denser early reflections.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(515, 160, 215, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.7, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("mod_depth") range(0, 0.002, 0.0004, 0.5, 0.0001) text("Mod") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 200, 30) text("Mod = tank allpass modulation depth. Blurs harmonics in the tail.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 215) text(
"DATTORRO PLATE — The 'Rosetta Stone' of reverb design (Jon Dattorro, JAES 1997).\n\n\
Architecture: Input → bandwidth filter → 4 input diffusor allpasses →\n\
Tank (two cross-fed halves, each: modulated allpass → delay → damping LP → decay → allpass → delay).\n\
Output: multi-tap from both tank halves for decorrelated stereo.\n\n\
The cross-fed tank topology creates natural modal density that builds over time. Modulated allpasses\n\
in the tank add subtle pitch blur that prevents metallic ringing. The allpass-loop structure produces\n\
a lusher, more musical character than parallel-comb designs — rated by Gogins as 'clearly superior\n\
to reverbsc' for bass response and spaciousness.\n\n\
Good starting points:\n\
  • Small plate: Decay 0.4, Damping 10000, Bandwidth 12000\n\
  • Medium plate: Decay 0.7, Damping 8000, Bandwidth 10000\n\
  • Large plate: Decay 0.85, Damping 6000, Bandwidth 8000\n\
  • Infinite plate: Decay 0.99, Damping 4000, Bandwidth 6000, Mod 0.001\n\n\
This is a faithful implementation of the Dattorro topology with all delay times scaled from\n\
the original 29761 Hz reference sample rate."
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
; DATTORRO PLATE — instr 99
;
; Jon Dattorro's plate reverb algorithm from "Effect Design
; Part 1: Reverberator and Other Filters" (JAES 1997).
;
; All delay times originally specified at 29761 Hz.
; Converted to seconds for sample-rate independence.
;
; Topology:
;   Input → bandwidth LP → 4 input diffusor allpasses →
;   Tank (2 cross-fed halves):
;     Half A: mod-allpass → delay → damp-LP → decay → allpass → delay
;     Half B: mod-allpass → delay → damp-LP → decay → allpass → delay
;   Output: multi-tap from both halves
;==============================================================
instr 99

  ; --- Read parameters ---
  kdecay    chnget "decay"
  kdamp     chnget "damping"
  kbw       chnget "bandwidth"
  kpredel   chnget "predelay"
  kid1      chnget "in_diff1"
  kid2      chnget "in_diff2"
  kdrywet   chnget "dry_wet"
  kvol      chnget "master_vol"
  kmod_dep  chnget "mod_depth"

  ; Decay diffusion coefficients derived from decay
  kdd1 = 0.7 * kdecay + 0.1
  kdd2 = 0.5 * kdecay + 0.15
  kdd1 limit kdd1, 0.1, 0.95
  kdd2 limit kdd2, 0.1, 0.95

  ; --- Delay times (seconds, from Dattorro at 29761 Hz) ---
  ; Input diffusors
  #define ID1 # 0.004771 #
  #define ID2 # 0.003595 #
  #define ID3 # 0.012735 #
  #define ID4 # 0.009307 #
  ; Tank A (left)
  #define TA_MA # 0.022580 #
  #define TA_D1 # 0.149625 #
  #define TA_AP # 0.060481 #
  #define TA_D2 # 0.124995 #
  ; Tank B (right)
  #define TB_MA # 0.030509 #
  #define TB_D1 # 0.141695 #
  #define TB_AP # 0.089244 #
  #define TB_D2 # 0.106280 #

  ; --- Pre-delay ---
  amono = (ga_send_L + ga_send_R) * 0.5
  apd vdelay3 amono, kpredel, 300

  ; --- Input bandwidth filter (one-pole LP) ---
  abandw tone apd, kbw

  ; ============================================================
  ; INPUT DIFFUSOR CHAIN (4 allpass filters in series)
  ; ============================================================

  ; Input diffusor 1
  a_id1_buf delayr 0.02
  a_id1_del deltap $ID1
  a_id1_wr = abandw + kid1 * a_id1_del
  a_id1_out = -kid1 * a_id1_wr + a_id1_del
  delayw a_id1_wr

  ; Input diffusor 2
  a_id2_buf delayr 0.02
  a_id2_del deltap $ID2
  a_id2_wr = a_id1_out + kid1 * a_id2_del
  a_id2_out = -kid1 * a_id2_wr + a_id2_del
  delayw a_id2_wr

  ; Input diffusor 3
  a_id3_buf delayr 0.02
  a_id3_del deltap $ID3
  a_id3_wr = a_id2_out + kid2 * a_id3_del
  a_id3_out = -kid2 * a_id3_wr + a_id3_del
  delayw a_id3_wr

  ; Input diffusor 4
  a_id4_buf delayr 0.02
  a_id4_del deltap $ID4
  a_id4_wr = a_id3_out + kid2 * a_id4_del
  a_diff_out = -kid2 * a_id4_wr + a_id4_del
  delayw a_id4_wr

  ; ============================================================
  ; TANK — Two cross-fed halves
  ;
  ; Cross-feedback: each half's output feeds the other's input
  ; on the next cycle (one-block delay provides the feedback).
  ; ============================================================

  a_xfeed_A init 0
  a_xfeed_B init 0

  ; Save cross-feeds from previous cycle before overwriting
  a_xf_to_A = a_xfeed_B
  a_xf_to_B = a_xfeed_A

  ; ---- TANK A (left half) ----

  ; Tank A input: diffusor output + cross-feed from B
  a_ta_in = a_diff_out + kdecay * a_xf_to_A

  ; Modulated allpass
  kmod_A lfo kmod_dep, 1.0, 0
  a_ta_ma_buf delayr 0.05
  a_ta_ma_del deltapi $TA_MA + kmod_A
  a_ta_ma_wr = a_ta_in + kdd1 * a_ta_ma_del
  a_ta_ma_out = -kdd1 * a_ta_ma_wr + a_ta_ma_del
  delayw a_ta_ma_wr

  ; Delay 1 (with output taps for stereo)
  a_ta_d1_buf delayr 0.2
  a_ta_d1_out deltap $TA_D1
  a_ta_d1_tap deltap 0.066995
  delayw a_ta_ma_out

  ; Damping lowpass
  a_ta_damp tone a_ta_d1_out, kdamp

  ; Apply decay
  a_ta_dec = a_ta_damp * kdecay

  ; Allpass 2 (with output tap)
  a_ta_ap_buf delayr 0.1
  a_ta_ap_del deltap $TA_AP
  a_ta_ap_tap deltap 0.044899
  a_ta_ap_wr = a_ta_dec + kdd2 * a_ta_ap_del
  a_ta_ap_out = -kdd2 * a_ta_ap_wr + a_ta_ap_del
  delayw a_ta_ap_wr

  ; Delay 2 (with output taps)
  a_ta_d2_buf delayr 0.2
  a_ta_d2_out deltap $TA_D2
  a_ta_d2_tap deltap 0.041262
  delayw a_ta_ap_out

  ; Cross-feed to Tank B
  a_xfeed_A = a_ta_d2_out

  ; ---- TANK B (right half) ----

  ; Tank B input: diffusor output + cross-feed from A
  a_tb_in = a_diff_out + kdecay * a_xf_to_B

  ; Modulated allpass (different LFO rate for decorrelation)
  kmod_B lfo kmod_dep, 0.77, 0
  a_tb_ma_buf delayr 0.05
  a_tb_ma_del deltapi $TB_MA + kmod_B
  a_tb_ma_wr = a_tb_in + kdd1 * a_tb_ma_del
  a_tb_ma_out = -kdd1 * a_tb_ma_wr + a_tb_ma_del
  delayw a_tb_ma_wr

  ; Delay 3 (with output taps)
  a_tb_d1_buf delayr 0.2
  a_tb_d1_out deltap $TB_D1
  a_tb_d1_tap deltap 0.008938
  delayw a_tb_ma_out

  ; Damping lowpass
  a_tb_damp tone a_tb_d1_out, kdamp

  ; Apply decay
  a_tb_dec = a_tb_damp * kdecay

  ; Allpass 4 (with output tap)
  a_tb_ap_buf delayr 0.12
  a_tb_ap_del deltap $TB_AP
  a_tb_ap_tap deltap 0.070931
  a_tb_ap_wr = a_tb_dec + kdd2 * a_tb_ap_del
  a_tb_ap_out = -kdd2 * a_tb_ap_wr + a_tb_ap_del
  delayw a_tb_ap_wr

  ; Delay 4 (with output taps)
  a_tb_d2_buf delayr 0.15
  a_tb_d2_out deltap $TB_D2
  a_tb_d2_tap deltap 0.011256
  delayw a_tb_ap_out

  ; Cross-feed to Tank A
  a_xfeed_B = a_tb_d2_out

  ; ============================================================
  ; MULTI-TAP STEREO OUTPUT
  ;
  ; Left output: taps from Tank B delays + Tank A delay 1
  ; Right output: taps from Tank A delays + Tank B delay 1
  ; Cross-tank tapping creates natural stereo decorrelation.
  ; ============================================================

  awetL = a_tb_d1_tap + a_tb_ap_tap - a_tb_d2_tap + a_ta_d1_tap - a_ta_ap_tap
  awetR = a_ta_d1_tap + a_ta_ap_tap - a_ta_d2_tap + a_tb_d1_tap - a_tb_ap_tap

  ; Scale output
  awetL = awetL * 0.4
  awetR = awetR * 0.4

  ; --- Dry/wet mix ---
  aL = ga_send_L * (1 - kdrywet) + awetL * kdrywet
  aR = ga_send_R * (1 - kdrywet) + awetR * kdrywet

  ; --- Master volume + output ---
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
