<Cabbage>
form caption("Wave Edit Rig — PadSynth Wavetable Preview") size(820, 720), colour(30, 30, 50), pluginId("werg"), guiMode("queue")

; Header
label bounds(10, 8, 800, 25) text("WAVE EDIT RIG") fontColour(224, 140, 180) fontSize(18) align("left")
label bounds(10, 32, 800, 18) text("Generative Ambient — Load PadSynth WAVs / A↔B Morph / Browser-Matched Playback") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=55): TABLE LOADING
;=====================================================================

groupbox bounds(5, 55, 390, 108) text("TABLE A") colour(45, 35, 55) fontColour(224, 160, 120) {
    filebutton bounds(10, 26, 170, 25) channel("wave_path_a") text("Browse WAV...") mode("file") filetype("*.wav") colour(60, 60, 80) fontColour(180, 180, 200)
    button bounds(185, 26, 60, 25) channel("load_a") text("Load A", "Load A") value(0) colour:0(80, 50, 70) colour:1(224, 140, 180) fontColour:0(200, 200, 220) fontColour:1(30, 30, 50) fontSize(11)
    label bounds(10, 56, 370, 14) channel("status_a") text("No WAV loaded — playing default sine") fontColour(150, 150, 170) fontSize(10) align("left")
    label bounds(10, 74, 370, 14) channel("size_a") text("Table size: 8192") fontColour(130, 130, 150) fontSize(9) align("left")
}

groupbox bounds(405, 55, 390, 108) text("TABLE B") colour(35, 45, 55) fontColour(100, 180, 224) {
    filebutton bounds(10, 26, 170, 25) channel("wave_path_b") text("Browse WAV...") mode("file") filetype("*.wav") colour(60, 60, 80) fontColour(180, 180, 200)
    button bounds(185, 26, 60, 25) channel("load_b") text("Load B", "Load B") value(0) colour:0(40, 60, 80) colour:1(100, 180, 224) fontColour:0(200, 200, 220) fontColour:1(30, 30, 50) fontSize(11)
    label bounds(10, 56, 370, 14) channel("status_b") text("No WAV loaded — playing default sine") fontColour(150, 150, 170) fontSize(10) align("left")
    label bounds(10, 74, 370, 14) channel("size_b") text("Table size: 8192") fontColour(130, 130, 150) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=168): FILTER + AMP + MIX
;=====================================================================

groupbox bounds(10, 168, 210, 95) text("FILTER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 25, 48, 55) channel("filt_cutoff") range(200, 16000, 8000, 0.3, 1) text("Cutoff") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(53, 25, 48, 55) channel("filt_reso") range(0, 0.9, 0.1, 1, 0.01) text("Reso") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(101, 25, 48, 55) channel("filt_envamt") range(0, 1, 0.3, 1, 0.01) text("EnvAmt") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(149, 25, 48, 55) channel("filt_decay") range(0.1, 15, 4, 0.3, 0.01) text("F.Decay") textColour(200,200,220) trackerColour(224, 160, 80)
}

groupbox bounds(225, 168, 210, 95) text("AMP ENVELOPE") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 25, 48, 55) channel("amp_a") range(0.001, 10, 0.8, 0.3, 0.001) text("A") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(53, 25, 48, 55) channel("amp_d") range(0.001, 10, 1.5, 0.3, 0.001) text("D") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(101, 25, 48, 55) channel("amp_s") range(0, 1, 0.7, 1, 0.01) text("S") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(149, 25, 48, 55) channel("amp_r") range(0.01, 15, 4.0, 0.3, 0.01) text("R") textColour(200,200,220) trackerColour(224, 122, 95)
}

groupbox bounds(440, 168, 370, 95) text("MIX + UNISON") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 25, 48, 55) channel("morph") range(0, 1, 0, 1, 0.01) text("A<>B") textColour(200,200,220) trackerColour(180, 120, 224)
    rslider bounds(53, 25, 48, 55) channel("sub_level") range(0, 1, 0, 1, 0.01) text("Sub") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(101, 25, 48, 55) channel("noise_level") range(0, 1, 0, 1, 0.01) text("Noise") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(149, 25, 48, 55) channel("pad_level") range(0, 2, 1, 0.5, 0.01) text("PadLvl") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(210, 25, 48, 55) channel("uni_voices") range(1, 4, 1, 1, 1) text("UniV") textColour(200,200,220) trackerColour(200, 160, 224)
    rslider bounds(258, 25, 48, 55) channel("uni_detune") range(0, 50, 15, 1, 0.1) text("UniDet") textColour(200,200,220) trackerColour(200, 160, 224)
    rslider bounds(306, 25, 48, 55) channel("uni_spread") range(0, 1, 0.5, 1, 0.01) text("UniSpd") textColour(200,200,220) trackerColour(200, 160, 224)
}

;=====================================================================
; ROW 3 (y=268): MODULATION — 4 LFOs
;=====================================================================

groupbox bounds(10, 268, 800, 160) text("MODULATION") colour(35, 35, 55) fontColour(200, 200, 220) {

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
; ROW 4 (y=434): EFFECTS + MASTER
;=====================================================================

groupbox bounds(10, 434, 220, 130) text("DELAY") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 28, 48, 48) channel("dly_time") range(0.05, 1.5, 0.4, 0.5, 0.01) text("Time") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(55, 28, 48, 48) channel("dly_fb") range(0, 0.9, 0.55, 1, 0.01) text("FB") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(105, 28, 48, 48) channel("dly_wet") range(0, 1, 0.3, 1, 0.01) text("Wet") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(155, 28, 48, 48) channel("dly_mod") range(0, 0.02, 0.003, 0.5, 0.001) text("Mod") textColour(200,200,220) trackerColour(100, 180, 224)
}

groupbox bounds(235, 434, 185, 130) text("REVERB") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 28, 50, 50) channel("rvb_fb") range(0.3, 0.99, 0.92, 1, 0.01) text("Size") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(60, 28, 50, 50) channel("rvb_cut") range(1000, 14000, 7000, 0.4, 1) text("Tone") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(115, 28, 50, 50) channel("rvb_wet") range(0, 1, 0.5, 1, 0.01) text("Wet") textColour(200,200,220) trackerColour(100, 180, 224)
}

groupbox bounds(425, 434, 200, 130) text("MASTER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 28, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(72, 28, 55, 55) channel("master_lpf") range(200, 16000, 12000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(134, 28, 55, 55) channel("warmth") range(0, 1, 0.3, 1, 0.01) text("Warmth") textColour(200,200,220) trackerColour(224, 180, 100)
}

groupbox bounds(630, 434, 180, 130) text("SENDS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 28, 50, 50) channel("dly_send") range(0, 1, 0.25, 1, 0.01) text("Delay") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(65, 28, 50, 50) channel("rvb_send") range(0, 1, 0.55, 1, 0.01) text("Reverb") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(120, 28, 50, 50) channel("dly_rvb_send") range(0, 1, 0.2, 1, 0.01) text("Dly>Rvb") textColour(200,200,220) trackerColour(150, 150, 200)
}

;=====================================================================
; ROW 5 (y=570): KEYBOARD + CONTROLS
;=====================================================================

keyboard bounds(10, 570, 620, 60)
button bounds(640, 570, 80, 25) channel("hold") text("HOLD", "HOLD") value(0) colour:0(60, 60, 80) colour:1(120, 200, 150) fontColour:0(180, 180, 200) fontColour:1(30, 30, 50)
button bounds(640, 600, 80, 25) channel("import_all") text("IMPORT", "IMPORT") value(0) colour:0(50, 70, 50) colour:1(120, 200, 120) fontColour:0(200, 200, 220) fontColour:1(30, 30, 50) fontSize(11)

button bounds(730, 570, 80, 25) channel("preset_save") text("Save", "Save") value(0) colour:0(50, 50, 70) colour:1(100, 180, 224) fontColour:0(180, 180, 200) fontColour:1(255, 255, 255)
button bounds(730, 600, 80, 25) channel("preset_load") text("Load", "Load") value(0) colour:0(50, 50, 70) colour:1(100, 180, 224) fontColour:0(180, 180, 200) fontColour:1(255, 255, 255)

label bounds(10, 638, 800, 50) channel("import_status") text("IMPORT loads both WAVs + all performance params from padsynth-rig export. Browse/Load for manual WAV loading.") fontColour(130, 130, 150) fontSize(10) align("left")

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

; Default tables: real padsynth so fallback is audible with the rate formula.
; These get replaced when the user loads WAV files.
#define PAD_SIZE #262144#
gi_pad_A ftgen 1, 0, $PAD_SIZE, "padsynth", 261.63, 25, 1, 1, 1, 1, 1, 0.5, 0.333, 0.25, 0.2, 0.167, 0.143, 0.125
gi_pad_B ftgen 2, 0, $PAD_SIZE, "padsynth", 261.63, 25, 1, 1, 1, 1, 1, 0, 0.333, 0, 0.2, 0, 0.143, 0

gi_pad_size_A init $PAD_SIZE
gi_pad_size_B init $PAD_SIZE


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
; TABLE MANAGER — instr 80
;
; Loads WAV files into ftables via GEN01.
; Uses filebutton + Load button pattern from sample-looper-rig.
;==============================================================
instr 80

  ; Initialize fund channel (no GUI knob — set by IMPORT from config)
  k_init_fund init 1
  if k_init_fund == 1 then
    chnset k(261.63), "pad_fund"
    k_init_fund = 0
  endif

  ; --- Triggers ---
  k_load_a chnget "load_a"
  k_load_a_trig trigger k_load_a, 0.5, 0
  k_load_b chnget "load_b"
  k_load_b_trig trigger k_load_b, 0.5, 0

  ; --- Load A ---
  if k_load_a_trig == 1 then
    chnset k(0), "load_a"
    reinit load_table_a
  endif

  ; --- Load B ---
  if k_load_b_trig == 1 then
    chnset k(0), "load_b"
    reinit load_table_b
  endif

  ; --- Import All (WAVs + config from padsynth-rig export) ---
  k_import chnget "import_all"
  k_import_trig trigger k_import, 0.5, 0
  if k_import_trig == 1 then
    ; Load config JSON — applies all matching performance params
    ; (filter, amp, mix, LFO, effects, master, fund Hz)
    S_cfg = "/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/padsynth-export-config.json"
    kOk = cabbageChannelStateRecall:k(S_cfg)
    printks "Loaded config from padsynth-export-config.json\n", 0
    chnset k(0), "import_all"
    k_imp_refresh = 1
    k_imp_delay = 0
    ; Load both WAV tables
    reinit import_tables
  endif

  ; --- GUI Refresh after import recall ---
  k_imp_refresh init 0
  k_imp_delay init 0
  if k_imp_refresh == 1 then
    k_imp_delay += 1
    if k_imp_delay >= 5 then
      $SYNC_LFO(1)
      $SYNC_LFO(2)
      $SYNC_LFO(3)
      $SYNC_LFO(4)
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
      $SYNC_WIDGET(uni_voices)
      $SYNC_WIDGET(uni_detune)
      $SYNC_WIDGET(uni_spread)
      printks "GUI widgets synced after import\n", 0
      k_imp_refresh = 0
      k_imp_delay = 0
    endif
  endif

  ; Skip reinit blocks on initial pass (prevent spurious load attempts)
  igoto skip_loads

  ; === Load Table A ===
load_table_a:
  S_path_a chnget "wave_path_a"
  i_len_a strlen S_path_a
  prints "Loading Table A: %s\n", S_path_a
  i_valid_a filevalid S_path_a
  if i_valid_a == 1 && i_len_a > 4 then
    gi_pad_A ftgen 1, 0, 0, -1, S_path_a, 0, 0, 0
    gi_pad_size_A = ftlen(gi_pad_A)
    prints "Table A loaded: %d samples (%.2f sec)\n", gi_pad_size_A, gi_pad_size_A / sr
  else
    prints "Invalid file for Table A — keeping current table\n"
  endif
rireturn

  ; === Load Table B ===
load_table_b:
  S_path_b chnget "wave_path_b"
  i_len_b strlen S_path_b
  prints "Loading Table B: %s\n", S_path_b
  i_valid_b filevalid S_path_b
  if i_valid_b == 1 && i_len_b > 4 then
    gi_pad_B ftgen 2, 0, 0, -1, S_path_b, 0, 0, 0
    gi_pad_size_B = ftlen(gi_pad_B)
    prints "Table B loaded: %d samples (%.2f sec)\n", gi_pad_size_B, gi_pad_size_B / sr
  else
    prints "Invalid file for Table B — keeping current table\n"
  endif
rireturn

  ; === Import Both Tables (from padsynth-rig export) ===
import_tables:
  #define IMPORT_DIR #/Users/daniel/PycharmProjects/generative-ambient/apps/web/public/samples#
  S_imp_a = "$IMPORT_DIR/padsynth-export-a.wav"
  S_imp_b = "$IMPORT_DIR/padsynth-export-b.wav"

  i_va filevalid S_imp_a
  if i_va == 1 then
    gi_pad_A ftgen 1, 0, 0, -1, S_imp_a, 0, 0, 0
    gi_pad_size_A = ftlen(gi_pad_A)
    prints "Imported Table A: %d samples\n", gi_pad_size_A
  else
    prints "No export found: %s\n", S_imp_a
  endif

  i_vb filevalid S_imp_b
  if i_vb == 1 then
    gi_pad_B ftgen 2, 0, 0, -1, S_imp_b, 0, 0, 0
    gi_pad_size_B = ftlen(gi_pad_B)
    prints "Imported Table B: %d samples\n", gi_pad_size_B
  else
    prints "No export found: %s\n", S_imp_b
  endif

  prints "Import complete — config + both tables loaded\n"
rireturn

skip_loads:

endin


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
; PAD VOICE — instr 1 (MIDI-driven polyphonic)
;
; poscil playback with browser-matched rate formula:
;   rate = icps / fund * (sr / ftlen(table))
;
; This is identical to padsynth-rig instr 1 except the
; table rate calculation uses ftlen() for variable-size WAVs.
;==============================================================
instr 1

  ; --- MIDI pitch & velocity ---
  icps cpsmidi
  ivel veloc 0, 1

  ; --- Capture fund frequency and table sizes at note-on ---
  i_fund chnget "pad_fund"
  i_size_a = gi_pad_size_A
  i_size_b = gi_pad_size_B
  i_sros_a = sr / i_size_a
  i_sros_b = sr / i_size_b

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
  ; Rate formula: rate = freq / fund * (sr / table_size)
  k_rate_a = icps / i_fund * i_sros_a
  k_rate_b = icps / i_fund * i_sros_b

  ; Detune amounts in table-rate units (cents → ratio → rate delta)
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

  i_exists filevalid "/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/wave-edit-rig-preset.json"
  k_init init 0
  if k_init == 0 && i_exists == 1 then
    kOk = cabbageChannelStateRecall:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/wave-edit-rig-preset.json")
    printks "Auto-loaded preset from wave-edit-rig-preset.json\n", 0
    k_init = 1
    k_gui_refresh = 1
    k_gui_delay = 0
  elseif k_init == 0 then
    k_init = 1
  endif

  k_sv trigger k_save, 0.5, 0
  k_ld trigger k_load, 0.5, 0

  if k_sv == 1 then
    kOk = cabbageChannelStateSave:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/wave-edit-rig-preset.json")
    chnset k(0), "preset_save"
    printks "Preset saved to wave-edit-rig-preset.json\n", 0
  endif

  if k_ld == 1 then
    kOk = cabbageChannelStateRecall:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/wave-edit-rig-preset.json")
    chnset k(0), "preset_load"
    printks "Preset loaded from wave-edit-rig-preset.json\n", 0
    k_gui_refresh = 1
    k_gui_delay = 0
  endif

  ; --- GUI Refresh after recall ---
  ; guiMode("queue") may not auto-update widget visuals on recall.
  ; Read channels back and force widget sync via cabbageSetValue.
  if k_gui_refresh == 1 then
    k_gui_delay += 1
    if k_gui_delay >= 5 then
      $SYNC_LFO(1)
      $SYNC_LFO(2)
      $SYNC_LFO(3)
      $SYNC_LFO(4)
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
i 80 0 [60*60*4]   ; table manager
i 90 0 [60*60*4]   ; LFO modulator
i 95 0 [60*60*4]   ; preset manager
i 98 0 [60*60*4]   ; ping-pong delay
i 99 0 [60*60*4]   ; reverb
e
</CsScore>
</CsoundSynthesizer>
