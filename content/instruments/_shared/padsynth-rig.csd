<Cabbage>
form caption("PadSynth Rig — 64-Partial Spectral Synthesis") size(820, 880), colour(30, 30, 50), pluginId("psrg"), guiMode("queue")

; Header
label bounds(10, 8, 800, 25) text("PADSYNTH RIG") fontColour(224, 140, 180) fontSize(18) align("left")
label bounds(10, 32, 800, 18) text("Generative Ambient — 64-Partial Spectral Synthesis") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=55, h=75): PADSYNTH CORE
;=====================================================================

groupbox bounds(10, 55, 800, 75) text("PADSYNTH CORE") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 22, 55, 45) channel("pad_fund") range(20, 500, 261.63, 0.5, 0.01) text("Fund Hz") textColour(200,200,220) trackerColour(224, 140, 180)
    combobox bounds(80, 25, 95, 20) channel("pad_profile") value(1) text("Gaussian", "Square", "Exponent")
    label bounds(80, 48, 95, 14) text("Profile") fontColour(140, 140, 160) fontSize(9) align("centre")
    rslider bounds(190, 22, 55, 45) channel("pad_pparam") range(0.1, 10, 1, 0.5, 0.1) text("P.Param") textColour(200,200,220) trackerColour(224, 140, 180)
    combobox bounds(260, 25, 100, 20) channel("pad_size") value(1) text("256K", "512K", "1M")
    label bounds(260, 48, 100, 14) text("Table Size") fontColour(140, 140, 160) fontSize(9) align("centre")
}

;=====================================================================
; ROW 2A (y=135, h=130): TABLE A — Spectrum
;=====================================================================

groupbox bounds(10, 135, 800, 130) text("TABLE A — Spectrum") colour(45, 35, 55) fontColour(224, 160, 120) {
    gentable bounds(10, 22, 360, 90) tableNumber(10) tableColour(224, 160, 120) tableBackgroundColour(30, 25, 40) channel("spec_a") ampRange(0, 1.1, 10)

    combobox bounds(380, 22, 80, 20) channel("harm_preset_a") value(1) text("Saw", "Square", "Sine", "Organ", "Bell", "Hollow", "Choir", "Metallic", "Formant")
    label bounds(380, 43, 80, 12) text("Preset") fontColour(140, 140, 160) fontSize(9) align("centre")

    rslider bounds(470, 18, 42, 42) channel("bw_a") range(0.1, 300, 25, 0.5, 0.1) text("BW") textColour(200,200,220) trackerColour(224, 160, 120)
    rslider bounds(515, 18, 42, 42) channel("bwscale_a") range(0, 3, 1, 1, 0.01) text("BWScl") textColour(200,200,220) trackerColour(224, 160, 120)
    rslider bounds(560, 18, 42, 42) channel("stretch_a") range(0.5, 2, 1, 1, 0.001) text("Stretch") textColour(200,200,220) trackerColour(224, 160, 120)

    rslider bounds(380, 62, 42, 42) channel("harmonics_a") range(1, 64, 16, 1, 1) text("Harms") textColour(200,200,220) trackerColour(224, 160, 120)
    rslider bounds(425, 62, 42, 42) channel("rolloff_a") range(0, 4, 1, 1, 0.01) text("Rolloff") textColour(200,200,220) trackerColour(224, 160, 120)
    rslider bounds(470, 62, 42, 42) channel("oddeven_a") range(-1, 1, 0, 1, 0.01) text("O/E") textColour(200,200,220) trackerColour(224, 160, 120)
    rslider bounds(515, 62, 42, 42) channel("tilt_a") range(-1, 1, 0, 1, 0.01) text("Tilt") textColour(200,200,220) trackerColour(224, 160, 120)

    button bounds(610, 22, 62, 35) channel("generate_a") text("GEN A", "GEN A") value(0) colour:0(80, 50, 70) colour:1(224, 140, 180) fontColour:0(200, 200, 220) fontColour:1(30, 30, 50) fontSize(11)
    button bounds(610, 62, 50, 35) channel("randomize_a") text("RND", "RND") value(0) colour:0(60, 50, 70) colour:1(180, 120, 200) fontColour:0(200, 200, 220) fontColour:1(30, 30, 50) fontSize(11)
}

;=====================================================================
; ROW 2B (y=270, h=130): TABLE B — Spectrum
;=====================================================================

groupbox bounds(10, 270, 800, 130) text("TABLE B — Spectrum") colour(35, 45, 55) fontColour(100, 180, 224) {
    gentable bounds(10, 22, 360, 90) tableNumber(11) tableColour(100, 180, 224) tableBackgroundColour(30, 25, 40) channel("spec_b") ampRange(0, 1.1, 11)

    combobox bounds(380, 22, 80, 20) channel("harm_preset_b") value(2) text("Saw", "Square", "Sine", "Organ", "Bell", "Hollow", "Choir", "Metallic", "Formant")
    label bounds(380, 43, 80, 12) text("Preset") fontColour(140, 140, 160) fontSize(9) align("centre")

    rslider bounds(470, 18, 42, 42) channel("bw_b") range(0.1, 300, 25, 0.5, 0.1) text("BW") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(515, 18, 42, 42) channel("bwscale_b") range(0, 3, 1, 1, 0.01) text("BWScl") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(560, 18, 42, 42) channel("stretch_b") range(0.5, 2, 1, 1, 0.001) text("Stretch") textColour(200,200,220) trackerColour(100, 180, 224)

    rslider bounds(380, 62, 42, 42) channel("harmonics_b") range(1, 64, 16, 1, 1) text("Harms") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(425, 62, 42, 42) channel("rolloff_b") range(0, 4, 1, 1, 0.01) text("Rolloff") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(470, 62, 42, 42) channel("oddeven_b") range(-1, 1, 0, 1, 0.01) text("O/E") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(515, 62, 42, 42) channel("tilt_b") range(-1, 1, 0, 1, 0.01) text("Tilt") textColour(200,200,220) trackerColour(100, 180, 224)

    button bounds(610, 22, 62, 35) channel("generate_b") text("GEN B", "GEN B") value(0) colour:0(40, 60, 80) colour:1(100, 180, 224) fontColour:0(200, 200, 220) fontColour:1(30, 30, 50) fontSize(11)
    button bounds(610, 62, 50, 35) channel("randomize_b") text("RND", "RND") value(0) colour:0(50, 60, 70) colour:1(120, 180, 200) fontColour:0(200, 200, 220) fontColour:1(30, 30, 50) fontSize(11)
}

;=====================================================================
; ROW 3 (y=405, h=95): FILTER + AMP + MIX + UNISON
;=====================================================================

groupbox bounds(10, 405, 210, 95) text("FILTER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 25, 48, 55) channel("filt_cutoff") range(200, 16000, 8000, 0.3, 1) text("Cutoff") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(53, 25, 48, 55) channel("filt_reso") range(0, 0.9, 0.1, 1, 0.01) text("Reso") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(101, 25, 48, 55) channel("filt_envamt") range(0, 1, 0.3, 1, 0.01) text("EnvAmt") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(149, 25, 48, 55) channel("filt_decay") range(0.1, 15, 4, 0.3, 0.01) text("F.Decay") textColour(200,200,220) trackerColour(224, 160, 80)
}

groupbox bounds(225, 405, 210, 95) text("AMP ENVELOPE") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 25, 48, 55) channel("amp_a") range(0.001, 10, 0.8, 0.3, 0.001) text("A") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(53, 25, 48, 55) channel("amp_d") range(0.001, 10, 1.5, 0.3, 0.001) text("D") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(101, 25, 48, 55) channel("amp_s") range(0, 1, 0.7, 1, 0.01) text("S") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(149, 25, 48, 55) channel("amp_r") range(0.01, 15, 4.0, 0.3, 0.01) text("R") textColour(200,200,220) trackerColour(224, 122, 95)
}

groupbox bounds(440, 405, 370, 95) text("MIX + UNISON") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 25, 48, 55) channel("morph") range(0, 1, 0, 1, 0.01) text("A<>B") textColour(200,200,220) trackerColour(180, 120, 224)
    rslider bounds(53, 25, 48, 55) channel("sub_level") range(0, 1, 0, 1, 0.01) text("Sub") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(101, 25, 48, 55) channel("noise_level") range(0, 1, 0, 1, 0.01) text("Noise") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(149, 25, 48, 55) channel("pad_level") range(0, 2, 1, 0.5, 0.01) text("PadLvl") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(210, 25, 48, 55) channel("uni_voices") range(1, 4, 1, 1, 1) text("UniV") textColour(200,200,220) trackerColour(200, 160, 224)
    rslider bounds(258, 25, 48, 55) channel("uni_detune") range(0, 50, 15, 1, 0.1) text("UniDet") textColour(200,200,220) trackerColour(200, 160, 224)
    rslider bounds(306, 25, 48, 55) channel("uni_spread") range(0, 1, 0.5, 1, 0.01) text("UniSpd") textColour(200,200,220) trackerColour(200, 160, 224)
}

;=====================================================================
; ROW 4 (y=505, h=160): MODULATION — 4 LFOs
;=====================================================================

groupbox bounds(10, 505, 800, 160) text("MODULATION") colour(35, 35, 55) fontColour(200, 200, 220) {

    ; LFO 1
    label bounds(15, 22, 180, 14) text("LFO 1") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(15, 38, 45, 45) channel("lfo1_freq") range(0.01, 10, 0.1, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(62, 38, 45, 45) channel("lfo1_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(112, 40, 78, 20) channel("lfo1_wave") value(1) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(112, 64, 78, 20) channel("lfo1_target") value(1) text("None", "Cutoff", "Reso", "EnvAmt", "Sub", "Noise", "PadLvl", "Morph", "Volume", "UniDet", "UniSpd")
    hslider bounds(15, 88, 175, 12) channel("lfo1_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; LFO 2
    label bounds(210, 22, 180, 14) text("LFO 2") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(210, 38, 45, 45) channel("lfo2_freq") range(0.01, 10, 0.07, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(257, 38, 45, 45) channel("lfo2_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(307, 40, 78, 20) channel("lfo2_wave") value(2) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(307, 64, 78, 20) channel("lfo2_target") value(1) text("None", "Cutoff", "Reso", "EnvAmt", "Sub", "Noise", "PadLvl", "Morph", "Volume", "UniDet", "UniSpd")
    hslider bounds(210, 88, 175, 12) channel("lfo2_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; LFO 3
    label bounds(405, 22, 180, 14) text("LFO 3") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(405, 38, 45, 45) channel("lfo3_freq") range(0.01, 10, 0.05, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(452, 38, 45, 45) channel("lfo3_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(502, 40, 78, 20) channel("lfo3_wave") value(4) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(502, 64, 78, 20) channel("lfo3_target") value(1) text("None", "Cutoff", "Reso", "EnvAmt", "Sub", "Noise", "PadLvl", "Morph", "Volume", "UniDet", "UniSpd")
    hslider bounds(405, 88, 175, 12) channel("lfo3_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; LFO 4
    label bounds(600, 22, 190, 14) text("LFO 4") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(600, 38, 45, 45) channel("lfo4_freq") range(0.01, 10, 0.15, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(647, 38, 45, 45) channel("lfo4_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(697, 40, 78, 20) channel("lfo4_wave") value(6) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(697, 64, 78, 20) channel("lfo4_target") value(1) text("None", "Cutoff", "Reso", "EnvAmt", "Sub", "Noise", "PadLvl", "Morph", "Volume", "UniDet", "UniSpd")
    hslider bounds(600, 88, 175, 12) channel("lfo4_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    label bounds(15, 108, 780, 35) text("Set Amp > 0 to activate. UniDet/UniSpd targets modulate unison detune and stereo spread.") fontColour(130, 130, 150) fontSize(10) align("left")
}

;=====================================================================
; ROW 5 (y=670, h=130): EFFECTS + MASTER
;=====================================================================

groupbox bounds(10, 670, 220, 130) text("DELAY") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 28, 48, 48) channel("dly_time") range(0.05, 1.5, 0.4, 0.5, 0.01) text("Time") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(55, 28, 48, 48) channel("dly_fb") range(0, 0.9, 0.55, 1, 0.01) text("FB") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(105, 28, 48, 48) channel("dly_wet") range(0, 1, 0.3, 1, 0.01) text("Wet") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(155, 28, 48, 48) channel("dly_mod") range(0, 0.02, 0.003, 0.5, 0.001) text("Mod") textColour(200,200,220) trackerColour(100, 180, 224)
}

groupbox bounds(235, 670, 185, 130) text("REVERB") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 28, 50, 50) channel("rvb_fb") range(0.3, 0.99, 0.92, 1, 0.01) text("Size") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(60, 28, 50, 50) channel("rvb_cut") range(1000, 14000, 7000, 0.4, 1) text("Tone") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(115, 28, 50, 50) channel("rvb_wet") range(0, 1, 0.5, 1, 0.01) text("Wet") textColour(200,200,220) trackerColour(100, 180, 224)
}

groupbox bounds(425, 670, 200, 130) text("MASTER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 28, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(72, 28, 55, 55) channel("master_lpf") range(200, 16000, 12000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(134, 28, 55, 55) channel("warmth") range(0, 1, 0.3, 1, 0.01) text("Warmth") textColour(200,200,220) trackerColour(224, 180, 100)
}

groupbox bounds(630, 670, 180, 130) text("SENDS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 28, 50, 50) channel("dly_send") range(0, 1, 0.25, 1, 0.01) text("Delay") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(65, 28, 50, 50) channel("rvb_send") range(0, 1, 0.55, 1, 0.01) text("Reverb") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(120, 28, 50, 50) channel("dly_rvb_send") range(0, 1, 0.2, 1, 0.01) text("Dly>Rvb") textColour(200,200,220) trackerColour(150, 150, 200)
}

;=====================================================================
; ROW 6 (y=805, h=65): KEYBOARD + CONTROLS
;=====================================================================

keyboard bounds(10, 805, 620, 60)
button bounds(640, 805, 80, 25) channel("hold") text("HOLD", "HOLD") value(0) colour:0(60, 60, 80) colour:1(120, 200, 150) fontColour:0(180, 180, 200) fontColour:1(30, 30, 50)
button bounds(640, 835, 80, 25) channel("export_all") text("EXPORT", "EXPORT") value(0) colour:0(50, 70, 50) colour:1(120, 200, 120) fontColour:0(200, 200, 220) fontColour:1(30, 30, 50) fontSize(11)

button bounds(730, 805, 80, 25) channel("preset_save") text("Save", "Save") value(0) colour:0(50, 50, 70) colour:1(100, 180, 224) fontColour:0(180, 180, 200) fontColour:1(255, 255, 255)
button bounds(730, 835, 80, 25) channel("preset_load") text("Load", "Load") value(0) colour:0(50, 50, 70) colour:1(100, 180, 224) fontColour:0(180, 180, 200) fontColour:1(255, 255, 255)

</Cabbage>

<CsoundSynthesizer>
<CsOptions>
-odac -d -+rtmidi=NULL -M0 --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>

sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1

seed 0

massign 0, 1

gi_sine ftgen 0, 0, 8192, 10, 1

; Default table size = 262144 (256K). Updated by instr 80 from combobox.
gi_pad_size init 262144
gi_sr_over_size init sr / 262144

; Spectral display tables: 64 points each (one per partial), GEN02
gi_spec_A ftgen 10, 0, 64, -2, 0
gi_spec_B ftgen 11, 0, 64, -2, 0

; Formant shape table: custom amplitude peaks for preset #9
; Peaks at harmonics 3-5 and 8-12
gi_formant ftgen 20, 0, 64, -2, 0.2, 0.3, 0.9, 1.0, 0.85, 0.3, 0.15, 0.7, 0.9, 1.0, 0.95, 0.8, 0.3, 0.15, 0.1, 0.08, 0.06, 0.05, 0.04, 0.03, 0.025, 0.02, 0.018, 0.015, 0.013, 0.011, 0.01, 0.009, 0.008, 0.007, 0.006, 0.005, 0.005, 0.004, 0.004, 0.003, 0.003, 0.003, 0.002, 0.002, 0.002, 0.002, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0, 0, 0, 0, 0, 0, 0, 0, 0

; Default Table A: Saw (16 harmonics, rolloff=1) — built via scoreline_i on first gen
gi_pad_A ftgen 1, 0, 262144, "padsynth", 261.63, 25, 1, 1, 1, 1, 1, 0.5, 0.333, 0.25, 0.2, 0.167, 0.143, 0.125, 0.111, 0.1, 0.091, 0.083, 0.077, 0.071, 0.067, 0.063
gi_fund_A init 261.63

; Default Table B: Square (16 odd harmonics)
gi_pad_B ftgen 2, 0, 262144, "padsynth", 261.63, 25, 1, 1, 1, 1, 1, 0, 0.333, 0, 0.2, 0, 0.143, 0, 0.111, 0, 0.091, 0, 0.077, 0, 0.067, 0
gi_fund_B init 261.63

;=====================================================================
; GLOBAL BUSES
;=====================================================================
ga_rvb_L init 0
ga_rvb_R init 0
ga_dly_L init 0
ga_dly_R init 0

;=====================================================================
; MODULATION ACCUMULATORS
;=====================================================================
gk_mod_cutoff   init 0
gk_mod_reso     init 0
gk_mod_envamt   init 0
gk_mod_sub      init 0
gk_mod_noise    init 0
gk_mod_padlvl   init 0
gk_mod_morph    init 0
gk_mod_vol      init 0
gk_mod_unidet   init 0
gk_mod_unispread init 0


;=====================================================================
; MACRO: Apply spectral shape preset to slot A or B
; S = slot suffix (a or b), K = k-rate preset var
; Presets set the shape controls, NOT individual partial values
;=====================================================================
#define APPLY_SHAPE_PRESET(S'K) #
if $K == 1 then
  ; Saw: all harmonics, 1/n rolloff
  cabbageSetValue "harmonics_$S", 32
  cabbageSetValue "rolloff_$S", 1.0
  cabbageSetValue "oddeven_$S", 0.0
  cabbageSetValue "tilt_$S", 0.0
elseif $K == 2 then
  ; Square: odd harmonics only
  cabbageSetValue "harmonics_$S", 32
  cabbageSetValue "rolloff_$S", 1.0
  cabbageSetValue "oddeven_$S", -1.0
  cabbageSetValue "tilt_$S", 0.0
elseif $K == 3 then
  ; Sine: fundamental only
  cabbageSetValue "harmonics_$S", 1
  cabbageSetValue "rolloff_$S", 0.0
  cabbageSetValue "oddeven_$S", 0.0
  cabbageSetValue "tilt_$S", 0.0
elseif $K == 4 then
  ; Organ: even harmonics emphasized, low rolloff
  cabbageSetValue "harmonics_$S", 24
  cabbageSetValue "rolloff_$S", 0.4
  cabbageSetValue "oddeven_$S", 0.7
  cabbageSetValue "tilt_$S", 0.0
elseif $K == 5 then
  ; Bell: moderate rolloff, high-tilt
  cabbageSetValue "harmonics_$S", 24
  cabbageSetValue "rolloff_$S", 1.5
  cabbageSetValue "oddeven_$S", 0.0
  cabbageSetValue "tilt_$S", 0.6
elseif $K == 6 then
  ; Hollow: low fundamental, sparse
  cabbageSetValue "harmonics_$S", 16
  cabbageSetValue "rolloff_$S", 0.8
  cabbageSetValue "oddeven_$S", 0.5
  cabbageSetValue "tilt_$S", -0.5
elseif $K == 7 then
  ; Choir: 32 harmonics, low rolloff, slight odd emphasis
  cabbageSetValue "harmonics_$S", 32
  cabbageSetValue "rolloff_$S", 0.6
  cabbageSetValue "oddeven_$S", -0.3
  cabbageSetValue "tilt_$S", -0.2
elseif $K == 8 then
  ; Metallic: all 64 harmonics, very low rolloff, high-tilt
  cabbageSetValue "harmonics_$S", 64
  cabbageSetValue "rolloff_$S", 0.3
  cabbageSetValue "oddeven_$S", 0.0
  cabbageSetValue "tilt_$S", 0.8
elseif $K == 9 then
  ; Formant: uses custom table (handled in instr 80)
  cabbageSetValue "harmonics_$S", 64
  cabbageSetValue "rolloff_$S", 0.0
  cabbageSetValue "oddeven_$S", 0.0
  cabbageSetValue "tilt_$S", 0.0
endif
#


;==============================================================
; MACRO: Force widget visual update after cabbageChannelStateRecall
; guiMode("queue") requires cabbageSetValue to sync widget display
;==============================================================
#define SYNC_WIDGET(CH) #
k_sv chnget "$CH"
cabbageSetValue "$CH", k_sv
#

#define SYNC_LFO(N) #
k_sv chnget "lfo$N._freq"
cabbageSetValue "lfo$N._freq", k_sv
k_sv chnget "lfo$N._amp"
cabbageSetValue "lfo$N._amp", k_sv
k_sv chnget "lfo$N._wave"
cabbageSetValue "lfo$N._wave", k_sv
k_sv chnget "lfo$N._target"
cabbageSetValue "lfo$N._target", k_sv
#


;==============================================================
; UDO: LFOWave — Multi-waveform LFO
;==============================================================
opcode LFOWave, k, kkk
  kamp, kfreq, ktype xin

  k_phs phasor kfreq

  k_sine  = sin(k_phs * 2 * 3.14159265)
  k_tri   = 1 - 4 * abs(k_phs - 0.5)
  k_sawup = 2 * k_phs - 1
  k_sawdn = 1 - 2 * k_phs
  k_sqr   = (k_phs < 0.5) ? 1 : -1

  k_sh     init 0
  k_prev   init 1
  if k_phs < k_prev then
    k_sh random -1, 1
  endif
  k_prev = k_phs

  k_w1 randi 1, kfreq
  k_w2 randi 0.5, kfreq * 0.4286
  k_wander = (k_w1 + k_w2) / 1.5

  k_val = k_sine
  if ktype == 2 then
    k_val = k_tri
  elseif ktype == 3 then
    k_val = k_sawup
  elseif ktype == 4 then
    k_val = k_sawdn
  elseif ktype == 5 then
    k_val = k_sqr
  elseif ktype == 6 then
    k_val = k_sh
  elseif ktype == 7 then
    k_val = k_wander
  endif

  xout k_val * kamp
endop


;==============================================================
; UDO: LFORoutePad — Route LFO to targets
;
; 1=None, 2=Cutoff, 3=Reso, 4=EnvAmt, 5=Sub,
; 6=Noise, 7=PadLvl, 8=Morph, 9=Volume,
; 10=UniDetune, 11=UniSpread
;==============================================================
opcode LFORoutePad, 0, kk
  ktgt, kval xin

  if ktgt == 2 then
    gk_mod_cutoff = gk_mod_cutoff + kval * 4000
  elseif ktgt == 3 then
    gk_mod_reso = gk_mod_reso + kval * 0.3
  elseif ktgt == 4 then
    gk_mod_envamt = gk_mod_envamt + kval * 0.5
  elseif ktgt == 5 then
    gk_mod_sub = gk_mod_sub + kval * 0.3
  elseif ktgt == 6 then
    gk_mod_noise = gk_mod_noise + kval * 0.3
  elseif ktgt == 7 then
    gk_mod_padlvl = gk_mod_padlvl + kval * 0.5
  elseif ktgt == 8 then
    gk_mod_morph = gk_mod_morph + kval * 0.5
  elseif ktgt == 9 then
    gk_mod_vol = gk_mod_vol + kval * 0.3
  elseif ktgt == 10 then
    gk_mod_unidet = gk_mod_unidet + kval * 20
  elseif ktgt == 11 then
    gk_mod_unispread = gk_mod_unispread + kval * 0.4
  endif

endop


;==============================================================
; LFO MODULATOR — instr 90
;==============================================================
instr 90

  gk_mod_cutoff  = 0
  gk_mod_reso    = 0
  gk_mod_envamt  = 0
  gk_mod_sub     = 0
  gk_mod_noise   = 0
  gk_mod_padlvl  = 0
  gk_mod_morph   = 0
  gk_mod_vol     = 0
  gk_mod_unidet  = 0
  gk_mod_unispread = 0

  k_frq1  chnget "lfo1_freq"
  k_amp1  chnget "lfo1_amp"
  k_wav1  chnget "lfo1_wave"
  k_tgt1  chnget "lfo1_target"
  k_val1  LFOWave k_amp1, k_frq1, k_wav1
  LFORoutePad k_tgt1, k_val1
  cabbageSetValue "lfo1_out", k_val1

  k_frq2  chnget "lfo2_freq"
  k_amp2  chnget "lfo2_amp"
  k_wav2  chnget "lfo2_wave"
  k_tgt2  chnget "lfo2_target"
  k_val2  LFOWave k_amp2, k_frq2, k_wav2
  LFORoutePad k_tgt2, k_val2
  cabbageSetValue "lfo2_out", k_val2

  k_frq3  chnget "lfo3_freq"
  k_amp3  chnget "lfo3_amp"
  k_wav3  chnget "lfo3_wave"
  k_tgt3  chnget "lfo3_target"
  k_val3  LFOWave k_amp3, k_frq3, k_wav3
  LFORoutePad k_tgt3, k_val3
  cabbageSetValue "lfo3_out", k_val3

  k_frq4  chnget "lfo4_freq"
  k_amp4  chnget "lfo4_amp"
  k_wav4  chnget "lfo4_wave"
  k_tgt4  chnget "lfo4_target"
  k_val4  LFOWave k_amp4, k_frq4, k_wav4
  LFORoutePad k_tgt4, k_val4
  cabbageSetValue "lfo4_out", k_val4

endin


;==============================================================
; TABLE GENERATOR — instr 80
;
; Computes 64 partial amplitudes from shape controls,
; stores in display tables (GEN02), builds GENpadsynth
; via scoreline_i.
;==============================================================
instr 80

  ; --- Triggers ---
  k_gen_a chnget "generate_a"
  k_gen_a_trig trigger k_gen_a, 0.5, 0
  k_gen_b chnget "generate_b"
  k_gen_b_trig trigger k_gen_b, 0.5, 0

  k_rnd_a chnget "randomize_a"
  k_rnd_a_trig trigger k_rnd_a, 0.5, 0
  k_rnd_b chnget "randomize_b"
  k_rnd_b_trig trigger k_rnd_b, 0.5, 0

  k_preset_a chnget "harm_preset_a"
  k_preset_a_chg changed k_preset_a
  k_preset_b chnget "harm_preset_b"
  k_preset_b_chg changed k_preset_b

  ; Skip first cycle to avoid triggering on init
  k_first init 1
  if k_first == 1 then
    k_preset_a_chg = 0
    k_preset_b_chg = 0
    k_first = 0
  endif

  ; Auto-regenerate tables after preset auto-load.
  ; Preset recall (instr 95) sets channels but doesn't regenerate ftables.
  ; Wait a few k-cycles for channels to stabilize, then regen both tables.
  k_regen_count init 0
  if k_regen_count < 10 then
    k_regen_count += 1
    if k_regen_count == 10 then
      reinit gen_table_a
      reinit gen_table_b
    endif
  endif

  ; --- Preset A change ---
  if k_preset_a_chg == 1 then
    $APPLY_SHAPE_PRESET(a'k_preset_a)
    reinit gen_table_a
  endif

  ; --- Preset B change ---
  if k_preset_b_chg == 1 then
    $APPLY_SHAPE_PRESET(b'k_preset_b)
    reinit gen_table_b
  endif

  ; --- Randomize A ---
  if k_rnd_a_trig == 1 then
    k_rh random 4, 64
    k_rr random 0.1, 3.0
    k_ro random -1, 1
    k_rt random -1, 1
    k_rbw random 5, 150
    cabbageSetValue "harmonics_a", k_rh
    cabbageSetValue "rolloff_a", k_rr
    cabbageSetValue "oddeven_a", k_ro
    cabbageSetValue "tilt_a", k_rt
    cabbageSetValue "bw_a", k_rbw
    chnset k(0), "randomize_a"
    reinit gen_table_a
  endif

  ; --- Randomize B ---
  if k_rnd_b_trig == 1 then
    k_rh random 4, 64
    k_rr random 0.1, 3.0
    k_ro random -1, 1
    k_rt random -1, 1
    k_rbw random 5, 150
    cabbageSetValue "harmonics_b", k_rh
    cabbageSetValue "rolloff_b", k_rr
    cabbageSetValue "oddeven_b", k_ro
    cabbageSetValue "tilt_b", k_rt
    cabbageSetValue "bw_b", k_rbw
    chnset k(0), "randomize_b"
    reinit gen_table_b
  endif

  ; --- Manual generate A ---
  if k_gen_a_trig == 1 then
    reinit gen_table_a
  endif

  ; --- Manual generate B ---
  if k_gen_b_trig == 1 then
    reinit gen_table_b
  endif

  ; --- Export All (WAVs + config JSON) ---
  k_export chnget "export_all"
  k_export_trig trigger k_export, 0.5, 0
  if k_export_trig == 1 then
    S_cfg = "/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/padsynth-export-config.json"
    kOk = cabbageChannelStateSave:k(S_cfg)
    printks "Saved config to padsynth-export-config.json\n", 0
    event "i", 85, 0, 1
    chnset k(0), "export_all"
  endif

  ; ==========================================================
  ; Generate Table A — 64-partial spectral shape algorithm
  ; ==========================================================
gen_table_a:
  i_fund      chnget "pad_fund"
  i_prof      chnget "pad_profile"
  i_pparam    chnget "pad_pparam"
  i_size_sel  chnget "pad_size"

  ; Table size from combobox: 1=256K, 2=512K, 3=1M
  i_size = 262144
  if i_size_sel == 2 then
    i_size = 524288
  elseif i_size_sel == 3 then
    i_size = 1048576
  endif
  gi_pad_size = i_size
  gi_sr_over_size = sr / i_size

  ; Per-table parameters
  i_bw_a      chnget "bw_a"
  i_bwscl_a   chnget "bwscale_a"
  i_stretch_a chnget "stretch_a"
  i_harms_a   chnget "harmonics_a"
  i_roll_a    chnget "rolloff_a"
  i_oe_a      chnget "oddeven_a"
  i_tilt_a    chnget "tilt_a"
  i_preset_a  chnget "harm_preset_a"

  ; Round harmonics to integer
  i_harms_a = int(i_harms_a)
  if i_harms_a < 1 then
    i_harms_a = 1
  endif
  if i_harms_a > 64 then
    i_harms_a = 64
  endif

  ; Compute 64 partial amplitudes
  i_n = 0
compute_a:
  i_partial = i_n + 1

  ; Check if this is the Formant preset (#9) — use custom table directly
  if i_preset_a == 9 then
    i_amp tab_i i_n, gi_formant
  else
    ; Zero if beyond harmonics count
    if i_partial > i_harms_a then
      i_amp = 0
    else
      ; Base amplitude from rolloff: 1 / n^rolloff
      if i_roll_a <= 0.001 then
        i_amp = 1
      else
        i_amp = 1 / (i_partial ^ i_roll_a)
      endif

      ; Odd/Even weighting
      i_is_odd = i_partial % 2  ; 1 if odd, 0 if even
      if i_is_odd == 1 then
        ; Odd partial
        if i_oe_a > 0 then
          ; Positive = boost evens, reduce odds
          i_amp = i_amp * (1 - i_oe_a * 0.9)
        else
          ; Negative = boost odds
          i_amp = i_amp * (1 + abs(i_oe_a))
        endif
      else
        ; Even partial
        if i_oe_a < 0 then
          ; Negative = boost odds, reduce evens
          i_amp = i_amp * (1 + i_oe_a * 0.9)
        else
          ; Positive = boost evens
          i_amp = i_amp * (1 + i_oe_a)
        endif
      endif

      ; Tilt: (n/32)^tilt
      i_ratio = i_partial / 32
      if i_tilt_a > 0.001 then
        i_tilt_factor = i_ratio ^ i_tilt_a
        i_amp = i_amp * i_tilt_factor
      elseif i_tilt_a < -0.001 then
        ; Negative tilt: invert ratio so lows get boosted
        if i_ratio > 0.001 then
          i_tilt_factor = (1 / i_ratio) ^ abs(i_tilt_a)
          ; Normalize: fundamental shouldn't explode
          i_norm = (1 / (1/32)) ^ abs(i_tilt_a)
          i_tilt_factor = i_tilt_factor / i_norm
          i_amp = i_amp * i_tilt_factor
        endif
      endif
    endif
  endif

  ; Clamp
  if i_amp < 0 then
    i_amp = 0
  endif

  ; Store in display table
  tabw_i i_amp, i_n, gi_spec_A

  i_n += 1
  if i_n < 64 igoto compute_a

  ; Normalize display table: find max, scale to 0..1
  i_max = 0.001
  i_n = 0
norm_a_find:
  i_v tab_i i_n, gi_spec_A
  if i_v > i_max then
    i_max = i_v
  endif
  i_n += 1
  if i_n < 64 igoto norm_a_find

  i_n = 0
norm_a_apply:
  i_v tab_i i_n, gi_spec_A
  tabw_i i_v / i_max, i_n, gi_spec_A
  i_n += 1
  if i_n < 64 igoto norm_a_apply

  ; Build partial amplitude string for scoreline_i
  S_amps = ""
  i_n = 0
build_a:
  i_v tab_i i_n, gi_spec_A
  S_val sprintf "%.6f", i_v
  S_amps strcat S_amps, " "
  S_amps strcat S_amps, S_val
  i_n += 1
  if i_n < 64 igoto build_a

  ; Build and execute GENpadsynth f-statement
  S_cmd sprintf "f 1 0 %d \"padsynth\" %.4f %.4f %.4f %.4f %d %.4f%s", i_size, i_fund, i_bw_a, i_bwscl_a, i_stretch_a, i_prof, i_pparam, S_amps
  scoreline_i S_cmd
  gi_fund_A = i_fund

  ; Update gentable widget
  cabbageSet "spec_a", "tableNumber", 10

  prints "PadSynth A: fund=%.1f bw=%.1f harms=%d rolloff=%.2f oe=%.2f tilt=%.2f\n", i_fund, i_bw_a, i_harms_a, i_roll_a, i_oe_a, i_tilt_a
  chnset k(0), "generate_a"
rireturn

  ; ==========================================================
  ; Generate Table B — 64-partial spectral shape algorithm
  ; ==========================================================
gen_table_b:
  i_fund      chnget "pad_fund"
  i_prof      chnget "pad_profile"
  i_pparam    chnget "pad_pparam"
  i_size_sel  chnget "pad_size"

  ; Table size from combobox
  i_size = 262144
  if i_size_sel == 2 then
    i_size = 524288
  elseif i_size_sel == 3 then
    i_size = 1048576
  endif
  gi_pad_size = i_size
  gi_sr_over_size = sr / i_size

  ; Per-table parameters
  i_bw_b      chnget "bw_b"
  i_bwscl_b   chnget "bwscale_b"
  i_stretch_b chnget "stretch_b"
  i_harms_b   chnget "harmonics_b"
  i_roll_b    chnget "rolloff_b"
  i_oe_b      chnget "oddeven_b"
  i_tilt_b    chnget "tilt_b"
  i_preset_b  chnget "harm_preset_b"

  ; Round harmonics to integer
  i_harms_b = int(i_harms_b)
  if i_harms_b < 1 then
    i_harms_b = 1
  endif
  if i_harms_b > 64 then
    i_harms_b = 64
  endif

  ; Compute 64 partial amplitudes
  i_n = 0
compute_b:
  i_partial = i_n + 1

  ; Formant preset (#9)
  if i_preset_b == 9 then
    i_amp tab_i i_n, gi_formant
  else
    if i_partial > i_harms_b then
      i_amp = 0
    else
      if i_roll_b <= 0.001 then
        i_amp = 1
      else
        i_amp = 1 / (i_partial ^ i_roll_b)
      endif

      i_is_odd = i_partial % 2
      if i_is_odd == 1 then
        if i_oe_b > 0 then
          i_amp = i_amp * (1 - i_oe_b * 0.9)
        else
          i_amp = i_amp * (1 + abs(i_oe_b))
        endif
      else
        if i_oe_b < 0 then
          i_amp = i_amp * (1 + i_oe_b * 0.9)
        else
          i_amp = i_amp * (1 + i_oe_b)
        endif
      endif

      i_ratio = i_partial / 32
      if i_tilt_b > 0.001 then
        i_tilt_factor = i_ratio ^ i_tilt_b
        i_amp = i_amp * i_tilt_factor
      elseif i_tilt_b < -0.001 then
        if i_ratio > 0.001 then
          i_tilt_factor = (1 / i_ratio) ^ abs(i_tilt_b)
          i_norm = (1 / (1/32)) ^ abs(i_tilt_b)
          i_tilt_factor = i_tilt_factor / i_norm
          i_amp = i_amp * i_tilt_factor
        endif
      endif
    endif
  endif

  if i_amp < 0 then
    i_amp = 0
  endif

  tabw_i i_amp, i_n, gi_spec_B

  i_n += 1
  if i_n < 64 igoto compute_b

  ; Normalize display table
  i_max = 0.001
  i_n = 0
norm_b_find:
  i_v tab_i i_n, gi_spec_B
  if i_v > i_max then
    i_max = i_v
  endif
  i_n += 1
  if i_n < 64 igoto norm_b_find

  i_n = 0
norm_b_apply:
  i_v tab_i i_n, gi_spec_B
  tabw_i i_v / i_max, i_n, gi_spec_B
  i_n += 1
  if i_n < 64 igoto norm_b_apply

  ; Build partial amplitude string
  S_amps = ""
  i_n = 0
build_b:
  i_v tab_i i_n, gi_spec_B
  S_val sprintf "%.6f", i_v
  S_amps strcat S_amps, " "
  S_amps strcat S_amps, S_val
  i_n += 1
  if i_n < 64 igoto build_b

  ; Build and execute GENpadsynth f-statement
  S_cmd sprintf "f 2 0 %d \"padsynth\" %.4f %.4f %.4f %.4f %d %.4f%s", i_size, i_fund, i_bw_b, i_bwscl_b, i_stretch_b, i_prof, i_pparam, S_amps
  scoreline_i S_cmd
  gi_fund_B = i_fund

  ; Update gentable widget
  cabbageSet "spec_b", "tableNumber", 11

  prints "PadSynth B: fund=%.1f bw=%.1f harms=%d rolloff=%.2f oe=%.2f tilt=%.2f\n", i_fund, i_bw_b, i_harms_b, i_roll_b, i_oe_b, i_tilt_b
  chnset k(0), "generate_b"
rireturn

endin


;==============================================================
; TABLE EXPORT — instr 85
;
; Exports BOTH padsynth tables to WAV files.
; Triggered by the EXPORT button via event from instr 80.
; Duration = table_size / sr.
;==============================================================
instr 85

  #define EXPORT_DIR #/Users/daniel/PycharmProjects/generative-ambient/apps/web/public/samples#

  S_path_a = "$EXPORT_DIR/padsynth-export-a.wav"
  S_path_b = "$EXPORT_DIR/padsynth-export-b.wav"

  i_size_a = ftlen(1)
  i_size_b = ftlen(2)

  i_dur_a = i_size_a / sr
  i_dur_b = i_size_b / sr
  p3 = (i_dur_a > i_dur_b ? i_dur_a : i_dur_b)

  prints "Exporting Table A (%d samples) and Table B (%d samples)...\n", i_size_a, i_size_b

  a_sig_a poscil 1, sr / i_size_a, 1
  a_sig_b poscil 1, sr / i_size_b, 2

  fout S_path_a, 6, a_sig_a
  fout S_path_b, 6, a_sig_b

  prints "Export complete: Table A + Table B + config.json\n"

endin


;==============================================================
; PAD VOICE — instr 1 (MIDI-driven polyphonic)
;
; Reads both padsynth tables and crossfades via Morph knob.
; Unison: up to 4 detuned voices, stereo-spread.
;==============================================================
instr 1

  ; --- MIDI pitch & velocity ---
  icps cpsmidi
  ivel veloc 0, 1

  ; --- Capture fund frequencies at note-on ---
  i_fund_a = gi_fund_A
  i_fund_b = gi_fund_B
  i_sr_over_size = gi_sr_over_size

  ; --- Read parameters ---
  k_morph_base  chnget "morph"
  k_cut_base    chnget "filt_cutoff"
  k_reso_base   chnget "filt_reso"
  k_envamt_base chnget "filt_envamt"
  i_filt_dec    chnget "filt_decay"
  k_sub_base    chnget "sub_level"
  k_noise_base  chnget "noise_level"
  k_padlvl_base chnget "pad_level"
  k_vol_base    chnget "master_vol"
  k_lpf         chnget "master_lpf"
  k_warmth      chnget "warmth"
  k_dly_send    chnget "dly_send"
  k_rvb_send    chnget "rvb_send"

  ; Unison params
  k_uni_v_base  chnget "uni_voices"
  k_uni_d_base  chnget "uni_detune"
  k_uni_s_base  chnget "uni_spread"

  ; --- Apply LFO modulation ---
  k_morph  = k_morph_base + gk_mod_morph
  k_cut    = k_cut_base + gk_mod_cutoff
  k_reso   = k_reso_base + gk_mod_reso
  k_envamt = k_envamt_base + gk_mod_envamt
  k_sub    = k_sub_base + gk_mod_sub
  k_noise  = k_noise_base + gk_mod_noise
  k_padlvl = k_padlvl_base + gk_mod_padlvl
  k_vol    = k_vol_base + gk_mod_vol
  k_uni_det = k_uni_d_base + gk_mod_unidet
  k_uni_spd = k_uni_s_base + gk_mod_unispread

  ; --- Clamp ---
  k_morph  limit k_morph, 0, 1
  k_cut    limit k_cut, 200, 16000
  k_reso   limit k_reso, 0, 0.9
  k_envamt limit k_envamt, 0, 1
  k_sub    limit k_sub, 0, 1
  k_noise  limit k_noise, 0, 1
  k_padlvl limit k_padlvl, 0, 2
  k_vol    limit k_vol, 0, 1
  k_uni_voices limit k_uni_v_base, 1, 4
  k_uni_det limit k_uni_det, 0, 50
  k_uni_spd limit k_uni_spd, 0, 1

  ; --- HOLD + ENVELOPE LOGIC ---
  xtratim 3600

  k_hold chnget "hold"
  k_rel release

  k_note_off init 0
  k_releasing init 0

  if k_rel == 1 then
    k_note_off = 1
  endif

  if k_note_off == 1 && k_hold == 0 && k_releasing == 0 then
    k_releasing = 1
    reinit start_release
  endif

  ; --- Amp ADS envelope ---
  i_amp_a chnget "amp_a"
  i_amp_d chnget "amp_d"
  i_amp_s chnget "amp_s"

  i_ads_hold = 3600
  k_ads linseg 0, i_amp_a, 1, i_amp_d, i_amp_s, i_ads_hold, i_amp_s

  ; --- Filter mod envelope ---
  i_mod_hold = 3600
  k_menv linseg 0, 0.005, 1, i_filt_dec, 0, i_mod_hold, 0
  k_menv = k_menv * k_menv

  ; --- Release envelope ---
  k_rel_env init 1
  if k_releasing == 1 then
start_release:
    i_amp_r chnget "amp_r"
    k_rel_env linseg 1, i_amp_r, 0
    rireturn
  endif

  k_amp_env = k_ads * k_rel_env

  if k_releasing == 1 && k_rel_env <= 0.001 then
    turnoff
  endif

  ; --- PADSYNTH OSCILLATORS — UNISON (4 unrolled voices) ---
  ; Base playback rates
  k_rate_a = icps * i_sr_over_size / i_fund_a
  k_rate_b = icps * i_sr_over_size / i_fund_b

  ; Detune amounts in table-rate units (cents → ratio → rate delta)
  ; detune_cents → freq_ratio = 2^(cents/1200) - 1 → rate_delta = rate * ratio
  k_det_ratio = (2 ^ (k_uni_det / 1200)) - 1
  k_det_a = k_rate_a * k_det_ratio
  k_det_b = k_rate_b * k_det_ratio

  ; Voice 0 (always active): center pitch
  a_a0 poscil 1, k_rate_a, gi_pad_A
  a_b0 poscil 1, k_rate_b, gi_pad_B
  a_mix0 = a_a0 * (1 - k_morph) + a_b0 * k_morph

  ; Voice 1: detuned up
  a_a1 poscil 1, k_rate_a + k_det_a, gi_pad_A
  a_b1 poscil 1, k_rate_b + k_det_b, gi_pad_B
  a_mix1 = a_a1 * (1 - k_morph) + a_b1 * k_morph

  ; Voice 2: detuned down
  a_a2 poscil 1, k_rate_a - k_det_a, gi_pad_A
  a_b2 poscil 1, k_rate_b - k_det_b, gi_pad_B
  a_mix2 = a_a2 * (1 - k_morph) + a_b2 * k_morph

  ; Voice 3: detuned up more (1.5x detune)
  a_a3 poscil 1, k_rate_a + k_det_a * 1.5, gi_pad_A
  a_b3 poscil 1, k_rate_b + k_det_b * 1.5, gi_pad_B
  a_mix3 = a_a3 * (1 - k_morph) + a_b3 * k_morph

  ; Conditional gains based on voice count
  k_g1 = (k_uni_voices >= 2) ? 1 : 0
  k_g2 = (k_uni_voices >= 3) ? 1 : 0
  k_g3 = (k_uni_voices >= 4) ? 1 : 0
  k_norm = 1 / (1 + k_g1 + k_g2 + k_g3)

  ; Stereo spread: voice 0 center, 1 left, 2 right, 3 center-left
  k_sp = k_uni_spd
  a_pad_L = (a_mix0 * 0.5 + a_mix1 * k_g1 * (1 - k_sp * 0.8) + a_mix2 * k_g2 * k_sp * 0.8 + a_mix3 * k_g3 * (0.6 - k_sp * 0.2)) * k_norm * k_padlvl
  a_pad_R = (a_mix0 * 0.5 + a_mix1 * k_g1 * k_sp * 0.8 + a_mix2 * k_g2 * (1 - k_sp * 0.8) + a_mix3 * k_g3 * (0.4 + k_sp * 0.2)) * k_norm * k_padlvl

  ; --- Sub oscillator (sine, -1 octave) ---
  a_sub oscili k_sub, icps * 0.5, gi_sine

  ; --- Noise layer ---
  a_noise noise k_noise * 0.2, 0

  ; --- Mix (stereo) ---
  a_osc_L = a_pad_L + a_sub * 0.5 + a_noise * 0.5
  a_osc_R = a_pad_R + a_sub * 0.5 + a_noise * 0.5

  ; --- Filter ---
  k_filt_cut = k_cut + k_menv * k_envamt * 8000
  k_filt_cut limit k_filt_cut, 60, 18000
  a_filt_L moogladder a_osc_L, k_filt_cut, k_reso
  a_filt_R moogladder a_osc_R, k_filt_cut, k_reso

  ; --- Apply amp envelope + velocity ---
  a_out_L = a_filt_L * k_amp_env * ivel
  a_out_R = a_filt_R * k_amp_env * ivel

  ; --- Warmth ---
  if k_warmth > 0.01 then
    a_out_L = tanh(a_out_L * (1 + k_warmth * 2))
    a_out_R = tanh(a_out_R * (1 + k_warmth * 2))
    a_low_L butterlp a_out_L, 200
    a_low_R butterlp a_out_R, 200
    a_out_L = a_out_L + a_low_L * k_warmth * 0.4
    a_out_R = a_out_R + a_low_R * k_warmth * 0.4
  endif

  ; --- Master LPF ---
  a_out_L butterlp a_out_L, k_lpf
  a_out_R butterlp a_out_R, k_lpf

  ; --- Master volume + soft clip ---
  aL = tanh(a_out_L * k_vol)
  aR = tanh(a_out_R * k_vol)

  ; --- DC block ---
  aL dcblock aL
  aR dcblock aR

  ; --- Output ---
  outs aL, aR

  ; --- Effect sends ---
  ga_dly_L = ga_dly_L + aL * k_dly_send
  ga_dly_R = ga_dly_R + aR * k_dly_send
  ga_rvb_L = ga_rvb_L + aL * k_rvb_send
  ga_rvb_R = ga_rvb_R + aR * k_rvb_send

endin


;==============================================================
; PRESET MANAGER — instr 95
;==============================================================
instr 95

  k_save chnget "preset_save"
  k_load chnget "preset_load"

  k_gui_refresh init 0
  k_gui_delay init 0

  i_exists filevalid "/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/padsynth-rig-preset.json"
  k_init init 0
  if k_init == 0 && i_exists == 1 then
    kOk = cabbageChannelStateRecall:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/padsynth-rig-preset.json")
    chnset k(0), "preset_save"   ; prevent recall from triggering a save
    printks "Auto-loaded preset from padsynth-rig-preset.json\n", 0
    k_init = 1
    k_gui_refresh = 1
    k_gui_delay = 0
  elseif k_init == 0 then
    k_init = 1
  endif

  k_sv trigger k_save, 0.5, 0
  k_ld trigger k_load, 0.5, 0

  ; Delayed save: sync combobox widgets from channels first,
  ; then wait for guiMode("queue") to process before saving.
  ; cabbageChannelStateSave reads WIDGET state, not channel values,
  ; so comboboxes must be synced via cabbageSetValue beforehand.
  k_save_delay init -1

  if k_sv == 1 then
    ; Force-sync all combobox widgets from their channel values
    $SYNC_WIDGET(lfo1_target)
    $SYNC_WIDGET(lfo2_target)
    $SYNC_WIDGET(lfo3_target)
    $SYNC_WIDGET(lfo4_target)
    $SYNC_WIDGET(lfo1_wave)
    $SYNC_WIDGET(lfo2_wave)
    $SYNC_WIDGET(lfo3_wave)
    $SYNC_WIDGET(lfo4_wave)
    $SYNC_WIDGET(pad_profile)
    $SYNC_WIDGET(pad_size)
    $SYNC_WIDGET(harm_preset_a)
    $SYNC_WIDGET(harm_preset_b)
    k_save_delay = 2
  endif

  if k_save_delay > 0 then
    k_save_delay -= 1
  elseif k_save_delay == 0 then
    k_save_delay = -1
    kOk = cabbageChannelStateSave:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/padsynth-rig-preset.json")
    chnset k(0), "preset_save"
    printks "Preset saved to padsynth-rig-preset.json\n", 0
  endif

  if k_ld == 1 then
    kOk = cabbageChannelStateRecall:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/padsynth-rig-preset.json")
    chnset k(0), "preset_load"
    chnset k(0), "preset_save"   ; prevent recall from triggering a save
    printks "Preset loaded from padsynth-rig-preset.json\n", 0
    k_gui_refresh = 1
    k_gui_delay = 0
  endif

  ; --- GUI Refresh after recall ---
  if k_gui_refresh == 1 then
    k_gui_delay += 1
    if k_gui_delay >= 5 then
      ; LFOs
      $SYNC_LFO(1)
      $SYNC_LFO(2)
      $SYNC_LFO(3)
      $SYNC_LFO(4)
      ; Voice
      $SYNC_WIDGET(morph)
      $SYNC_WIDGET(sub_level)
      $SYNC_WIDGET(noise_level)
      $SYNC_WIDGET(pad_level)
      $SYNC_WIDGET(filt_cutoff)
      $SYNC_WIDGET(filt_reso)
      $SYNC_WIDGET(filt_envamt)
      $SYNC_WIDGET(filt_decay)
      $SYNC_WIDGET(amp_a)
      $SYNC_WIDGET(amp_d)
      $SYNC_WIDGET(amp_s)
      $SYNC_WIDGET(amp_r)
      ; Master + Effects
      $SYNC_WIDGET(master_vol)
      $SYNC_WIDGET(master_lpf)
      $SYNC_WIDGET(warmth)
      $SYNC_WIDGET(dly_send)
      $SYNC_WIDGET(rvb_send)
      $SYNC_WIDGET(dly_rvb_send)
      $SYNC_WIDGET(dly_time)
      $SYNC_WIDGET(dly_fb)
      $SYNC_WIDGET(dly_wet)
      $SYNC_WIDGET(dly_mod)
      $SYNC_WIDGET(rvb_fb)
      $SYNC_WIDGET(rvb_cut)
      $SYNC_WIDGET(rvb_wet)
      $SYNC_WIDGET(hold)
      ; PadSynth core
      $SYNC_WIDGET(pad_fund)
      $SYNC_WIDGET(pad_profile)
      $SYNC_WIDGET(pad_pparam)
      $SYNC_WIDGET(pad_size)
      ; Table A — spectral shape controls
      $SYNC_WIDGET(harm_preset_a)
      $SYNC_WIDGET(bw_a)
      $SYNC_WIDGET(bwscale_a)
      $SYNC_WIDGET(stretch_a)
      $SYNC_WIDGET(harmonics_a)
      $SYNC_WIDGET(rolloff_a)
      $SYNC_WIDGET(oddeven_a)
      $SYNC_WIDGET(tilt_a)
      ; Table B — spectral shape controls
      $SYNC_WIDGET(harm_preset_b)
      $SYNC_WIDGET(bw_b)
      $SYNC_WIDGET(bwscale_b)
      $SYNC_WIDGET(stretch_b)
      $SYNC_WIDGET(harmonics_b)
      $SYNC_WIDGET(rolloff_b)
      $SYNC_WIDGET(oddeven_b)
      $SYNC_WIDGET(tilt_b)
      ; Unison
      $SYNC_WIDGET(uni_voices)
      $SYNC_WIDGET(uni_detune)
      $SYNC_WIDGET(uni_spread)
      printks "GUI widgets synced after recall\n", 0
      k_gui_refresh = 0
      k_gui_delay = 0
    endif
  endif

endin


;==============================================================
; DELAY — instr 98 (Ping-Pong)
;==============================================================
instr 98

  k_time     chnget "dly_time"
  k_fb       chnget "dly_fb"
  k_wet      chnget "dly_wet"
  k_mod_dep  chnget "dly_mod"
  k_rvb_send chnget "dly_rvb_send"

  k_mod lfo k_mod_dep, 0.23, 0

  i_maxdel = 2.0

  a_tap_L init 0
  a_tap_R init 0

  a_buf_L delayr i_maxdel
  a_tap_L deltap3 k_time + k_mod
          delayw ga_dly_L + a_tap_R * k_fb

  a_buf_R delayr i_maxdel
  a_tap_R deltap3 k_time - k_mod
          delayw ga_dly_R + a_tap_L * k_fb

  outs a_tap_L * k_wet, a_tap_R * k_wet

  ga_rvb_L = ga_rvb_L + a_tap_L * k_rvb_send
  ga_rvb_R = ga_rvb_R + a_tap_R * k_rvb_send

  ga_dly_L = 0
  ga_dly_R = 0

endin


;==============================================================
; REVERB — instr 99 (reverbsc)
;==============================================================
instr 99

  k_fb   chnget "rvb_fb"
  k_cut  chnget "rvb_cut"
  k_wet  chnget "rvb_wet"

  a_L, a_R reverbsc ga_rvb_L, ga_rvb_R, k_fb, k_cut
  outs a_L * k_wet, a_R * k_wet

  ga_rvb_L = 0
  ga_rvb_R = 0

endin


</CsInstruments>
<CsScore>
i 80 0 [60*60*4]   ; table generator
i 90 0 [60*60*4]   ; LFO modulator
i 95 0 [60*60*4]   ; preset manager
i 98 0 [60*60*4]   ; ping-pong delay
i 99 0 [60*60*4]   ; reverb
e
</CsScore>
</CsoundSynthesizer>
