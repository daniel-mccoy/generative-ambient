<Cabbage>
form caption("Composition Rig — Multi-Instrument Generative Composition") size(820, 580), colour(30, 30, 50), pluginId("cmpr"), guiMode("queue")

; Header
label bounds(10, 8, 800, 25) text("COMPOSITION RIG") fontColour(120, 200, 150) fontSize(18) align("left")

;=====================================================================
; ROW 1 (y=38, h=100): TIMING | PITCH | HARMONY
;=====================================================================

; Tempo
groupbox bounds(10, 38, 90, 100) text("TEMPO") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(20, 25, 50, 50) channel("seq_bpm") range(40, 200, 80, 1, 1) text("BPM") textColour(200,200,220) trackerColour(120, 200, 150)
}

; Pitch
groupbox bounds(105, 38, 190, 100) text("PITCH") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 25, 90, 18) channel("seq_scale") value(1) text("Min Pent", "Maj Pent", "Minor", "Major", "Dorian", "Chromatic")
    label bounds(10, 44, 90, 12) text("Scale") fontColour(140, 140, 160) fontSize(8) align("centre")
    combobox bounds(108, 25, 72, 18) channel("seq_root") value(3) text("Low", "Mid-Lo", "Mid", "High")
    label bounds(108, 44, 72, 12) text("Register") fontColour(140, 140, 160) fontSize(8) align("centre")
    combobox bounds(10, 64, 65, 18) channel("seq_patmode") value(1) text("Free", "1 Bar", "2 Bar", "4 Bar")
    label bounds(10, 83, 65, 12) text("Pattern") fontColour(140, 140, 160) fontSize(8) align("centre")
    rslider bounds(82, 58, 38, 38) channel("seq_patrep") range(1, 32, 8, 0.5, 1) text("Rep") textColour(200,200,220) trackerColour(120, 200, 150)
    label bounds(122, 68, 60, 18) text("times\nbfr new") fontColour(140, 140, 160) fontSize(7) align("left")
}

; Harmony
groupbox bounds(300, 38, 510, 100) text("HARMONY") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 25, 55, 18) channel("cond_start_key") value(1) text("C", "G", "D", "A", "E", "B", "F#", "C#", "Ab", "Eb", "Bb", "F")
    label bounds(10, 46, 55, 12) text("Key") fontColour(140, 140, 160) fontSize(8) align("centre")
    rslider bounds(72, 20, 42, 42) channel("cond_speed") range(0.5, 10, 3, 0.5, 0.1) text("Speed") textColour(200,200,220) trackerColour(200, 160, 255)
    label bounds(72, 62, 42, 12) text("min") fontColour(140, 140, 160) fontSize(7) align("centre")
    combobox bounds(122, 25, 60, 18) channel("cond_dir") value(1) text("Sharps", "Flats", "Random")
    label bounds(122, 46, 60, 12) text("Direction") fontColour(140, 140, 160) fontSize(8) align("centre")
    button bounds(190, 25, 42, 18) channel("cond_enabled") text("OFF", "ON") value(0) colour:0(60, 60, 80) colour:1(200, 160, 255) fontColour:0(180, 180, 200) fontColour:1(30, 30, 50)
    label bounds(190, 46, 42, 12) text("Mod") fontColour(140, 140, 160) fontSize(8) align("centre")
    button bounds(240, 25, 42, 18) channel("cond_manual") text("Next", "Next") value(0) colour:0(60, 60, 80) colour:1(120, 200, 150) fontColour:0(180, 180, 200) fontColour:1(30, 30, 50)
    label bounds(240, 46, 42, 12) text("Step") fontColour(140, 140, 160) fontSize(8) align("centre")
    label bounds(10, 76, 90, 16) channel("cond_key_lbl") text("Key: C") fontColour(200, 160, 255) fontSize(11) align("left")
    label bounds(105, 76, 120, 16) channel("cond_status") text("Idle") fontColour(180, 180, 200) fontSize(9) align("left")
    gentable bounds(270, 62, 80, 32) tableNumber(100) tableColour(200, 160, 255) tableBackgroundColour(30, 30, 50) ampRange(0, 1.1, 100) identChannel("cond_gt_ident")
}

;=====================================================================
; ROW 2 (y=145, h=100): PLUCK | FM DRONE | PAD CHORDS
;=====================================================================

groupbox bounds(10, 145, 260, 100) text("PLUCK") colour(40, 45, 60) fontColour(120, 200, 150) {
    button bounds(10, 24, 45, 20) channel("plk_play") text("OFF", "ON") value(1) colour:0(60, 60, 80) colour:1(120, 200, 150) fontColour:0(180, 180, 200) fontColour:1(30, 30, 50)
    rslider bounds(60, 22, 44, 44) channel("plk_vol") range(0, 1, 0.84, 0.5, 0.01) text("Vol") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(108, 22, 44, 44) channel("plk_dly_send") range(0, 1, 0.82, 1, 0.01) text("Dly") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(156, 22, 44, 44) channel("plk_rvb_send") range(0, 1, 0.52, 1, 0.01) text("Rvb") textColour(200,200,220) trackerColour(120, 200, 150)
    label bounds(10, 72, 240, 18) text("Saw/Sqr pluck — sequencer driven") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(280, 145, 260, 100) text("FM DRONE") colour(40, 40, 55) fontColour(100, 180, 224) {
    button bounds(10, 24, 45, 20) channel("fm_play") text("OFF", "ON") value(1) colour:0(60, 60, 80) colour:1(100, 180, 224) fontColour:0(180, 180, 200) fontColour:1(30, 30, 50)
    rslider bounds(60, 22, 44, 44) channel("fm_vol") range(0, 1, 0.13, 0.5, 0.01) text("Vol") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(108, 22, 44, 44) channel("fm_dly_send") range(0, 1, 0.25, 1, 0.01) text("Dly") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(156, 22, 44, 44) channel("fm_rvb_send") range(0, 1, 0.73, 1, 0.01) text("Rvb") textColour(200,200,220) trackerColour(100, 180, 224)
    label bounds(10, 72, 240, 18) text("Dual-osc bass drone — key tracking") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(550, 145, 260, 100) text("PAD CHORDS") colour(45, 40, 55) fontColour(224, 140, 180) {
    button bounds(10, 24, 45, 20) channel("pad_play") text("OFF", "ON") value(1) colour:0(60, 60, 80) colour:1(224, 140, 180) fontColour:0(180, 180, 200) fontColour:1(30, 30, 50)
    rslider bounds(60, 22, 44, 44) channel("pad_vol") range(0, 1, 0.1, 0.5, 0.01) text("Vol") textColour(200,200,220) trackerColour(224, 140, 180)
    rslider bounds(108, 22, 44, 44) channel("pad_dly_send") range(0, 1, 0.25, 1, 0.01) text("Dly") textColour(200,200,220) trackerColour(224, 140, 180)
    rslider bounds(156, 22, 44, 44) channel("pad_rvb_send") range(0, 1, 1, 1, 0.01) text("Rvb") textColour(200,200,220) trackerColour(224, 140, 180)
    label bounds(10, 72, 240, 18) text("Wavetable pad — triad chords") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 3 (y=252, h=110): DELAY | REVERB | MASTER
;=====================================================================

groupbox bounds(10, 252, 220, 110) text("DELAY") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(5, 26, 45, 18) channel("dly_div") value(3) text("1/2", "1/4", "D.1/8", "1/8", "1/16", "T.1/4", "T.1/8")
    rslider bounds(55, 22, 44, 44) channel("dly_fb") range(0, 0.9, 0.55, 1, 0.01) text("FB") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(103, 22, 44, 44) channel("dly_mix") range(0, 1, 0.4, 1, 0.01) text("Mix") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(151, 22, 44, 44) channel("dly_mod") range(0, 0.02, 0.003, 0.5, 0.001) text("Mod") textColour(200,200,220) trackerColour(100, 180, 224)
    label bounds(5, 48, 45, 12) text("Div") fontColour(140, 140, 160) fontSize(8) align("centre")
    label bounds(5, 80, 210, 16) text("BPM-synced ping-pong") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(235, 252, 185, 110) text("REVERB") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 22, 48, 48) channel("rvb_fb") range(0.3, 0.99, 0.88, 1, 0.01) text("Size") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(60, 22, 48, 48) channel("rvb_cut") range(1000, 14000, 7000, 0.4, 1) text("Tone") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(115, 22, 48, 48) channel("rvb_wet") range(0, 1, 0.5, 1, 0.01) text("Wet") textColour(200,200,220) trackerColour(100, 180, 224)
    label bounds(5, 80, 175, 16) text("reverbsc hall") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(425, 252, 200, 110) text("MASTER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 22, 50, 50) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(68, 22, 50, 50) channel("master_lpf") range(200, 16000, 12000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(126, 22, 50, 50) channel("warmth") range(0, 1, 0.3, 1, 0.01) text("Warmth") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 82, 185, 16) text("Volume, filter, saturation") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(630, 252, 180, 110) text("FX SENDS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(65, 22, 48, 48) channel("dly_rvb_send") range(0, 1, 0.2, 1, 0.01) text("Dly>Rvb") textColour(200,200,220) trackerColour(150, 150, 200)
    label bounds(5, 80, 170, 16) text("Delay into reverb") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 4 (y=370, h=60): TRANSPORT + PRESET
;=====================================================================

button bounds(10, 375, 100, 50) channel("seq_play") text("PLAY", "STOP") value(1) colour:0(60, 60, 80) colour:1(120, 200, 150) fontColour:0(180, 180, 200) fontColour:1(30, 30, 50)
label bounds(120, 378, 400, 16) text("All instruments respond to circle-of-fifths harmonic modulation.") fontColour(140, 140, 160) fontSize(10) align("left")
label bounds(120, 398, 400, 16) channel("seq_status") text("Playing...") fontColour(120, 200, 150) fontSize(11) align("left")

button bounds(630, 375, 85, 28) channel("preset_save") text("Save", "Save") value(0) colour:0(50, 50, 70) colour:1(100, 180, 224) fontColour:0(180, 180, 200) fontColour:1(255, 255, 255)
button bounds(720, 375, 85, 28) channel("preset_load") text("Load", "Load") value(0) colour:0(50, 50, 70) colour:1(100, 180, 224) fontColour:0(180, 180, 200) fontColour:1(255, 255, 255)
label bounds(630, 406, 175, 14) text("Save/load preset to JSON") fontColour(140, 140, 160) fontSize(9) align("centre")

;=====================================================================
; ROW 5 (y=430, h=60): KEYBOARD
;=====================================================================

keyboard bounds(10, 435, 800, 60)
label bounds(10, 498, 400, 14) text("Click a key to set the sequencer register") fontColour(140, 140, 160) fontSize(9) align("left")

</Cabbage>

<CsoundSynthesizer>
<CsOptions>
-odac -d -+rtmidi=NULL -M0
</CsOptions>
<CsInstruments>

sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1

seed 0

; Route keyboard MIDI to root note capture instrument
massign 0, 85

; Sine table for oscili
gi_sine ftgen 1, 0, 8192, 10, 1

;=====================================================================
; CIRCLE-OF-FIFTHS DATA TABLES
;=====================================================================

; Chromatic weight table: 12 slots, initialized to C minor pentatonic
gi_weights ftgen 100, 0, -12, -2, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0

; Major scale intervals (legacy, used as fallback)
gi_major_intervals ftgen 101, 0, -7, -2, 0, 2, 4, 5, 7, 9, 11

; Circle-of-fifths pitch classes: C G D A E B F# C# Ab Eb Bb F
gi_cof_pc ftgen 102, 0, -12, -2, 0, 7, 2, 9, 4, 11, 6, 1, 8, 3, 10, 5

;=====================================================================
; PATTERN TABLES (for pattern repeat mode)
;=====================================================================
gi_pat_note ftgen 103, 0, -32, -2, 0
gi_pat_vel  ftgen 104, 0, -32, -2, 0
gi_pat_dbl  ftgen 105, 0, -32, -2, 0

;=====================================================================
; SCALE TABLES (explicit ftable numbers to avoid collisions)
;=====================================================================
gi_sc_minpent ftgen 110, 0, -5,  -2, 0, 3, 5, 7, 10
gi_sc_majpent ftgen 111, 0, -5,  -2, 0, 2, 4, 7, 9
gi_sc_minor   ftgen 112, 0, -7,  -2, 0, 2, 3, 5, 7, 8, 10
gi_sc_major   ftgen 113, 0, -7,  -2, 0, 2, 4, 5, 7, 9, 11
gi_sc_dorian  ftgen 114, 0, -7,  -2, 0, 2, 3, 5, 7, 9, 10
gi_sc_chrom   ftgen 115, 0, -12, -2, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11

gi_sc_len_minpent = 5
gi_sc_len_majpent = 5
gi_sc_len_minor   = 7
gi_sc_len_major   = 7
gi_sc_len_dorian  = 7
gi_sc_len_chrom   = 12

;=====================================================================
; PAD WAVETABLES — loaded by instr 78
;=====================================================================
#define PAD_SIZE #262144#
; Defaults: padsynth so fallback is audible even if WAVs not found
gi_pad_A ftgen 200, 0, $PAD_SIZE, "padsynth", 261.63, 25, 1, 1, 1, 1, 1, 0.5, 0.333, 0.25, 0.2, 0.167, 0.143, 0.125
gi_pad_B ftgen 201, 0, $PAD_SIZE, "padsynth", 261.63, 25, 1, 1, 1, 1, 1, 0, 0.333, 0, 0.2, 0, 0.143, 0
gi_pad_size_A init $PAD_SIZE
gi_pad_size_B init $PAD_SIZE
gi_pad_fund   init 261.63

;=====================================================================
; GLOBAL SEND BUSES
;=====================================================================
ga_rvb_L init 0
ga_rvb_R init 0
ga_dly_L init 0
ga_dly_R init 0

;=====================================================================
; CONDUCTOR STATE (written by instr 70, read by 75+76+80)
;=====================================================================
gk_cof_pos init 0

;=====================================================================
; PER-INSTRUMENT MODULATION ACCUMULATORS
; Written by instr 90 (hard-coded LFOs from rig presets).
; Each instrument reads only its own prefixed globals.
;=====================================================================

; Pluck mods (from sequencer-rig-preset LFOs)
gk_plk_mod_cutoff  init 0
gk_plk_mod_reso    init 0
gk_plk_mod_shape   init 0
gk_plk_mod_density init 0

; FM drone mods (from fm-synth-rig-preset LFOs)
gk_fm_mod_cutoff   init 0
gk_fm_mod_reso     init 0

; Pad mods (from wave-edit-rig-preset LFOs)
gk_pad_mod_morph   init 0
gk_pad_mod_cutoff  init 0
gk_pad_mod_reso    init 0


;==============================================================
; SYNC MACROS
;==============================================================
#define SYNC_WIDGET(CH) #
k_sv chnget "$CH"
cabbageSetValue "$CH", k_sv
#


;==============================================================
; UDO: WeightedPC — Pick weighted random pitch class from gi_weights
;==============================================================
opcode WeightedPC, k, 0

  k_wt = gi_weights
  k_w0  tablekt 0, k_wt
  k_w1  tablekt 1, k_wt
  k_w2  tablekt 2, k_wt
  k_w3  tablekt 3, k_wt
  k_w4  tablekt 4, k_wt
  k_w5  tablekt 5, k_wt
  k_w6  tablekt 6, k_wt
  k_w7  tablekt 7, k_wt
  k_w8  tablekt 8, k_wt
  k_w9  tablekt 9, k_wt
  k_w10 tablekt 10, k_wt
  k_w11 tablekt 11, k_wt

  k_tw = k_w0+k_w1+k_w2+k_w3+k_w4+k_w5+k_w6+k_w7+k_w8+k_w9+k_w10+k_w11

  k_pc = -1

  if k_tw > 0.001 then
    k_wroll random 0, k_tw

    k_c0  = k_w0
    k_c1  = k_c0 + k_w1
    k_c2  = k_c1 + k_w2
    k_c3  = k_c2 + k_w3
    k_c4  = k_c3 + k_w4
    k_c5  = k_c4 + k_w5
    k_c6  = k_c5 + k_w6
    k_c7  = k_c6 + k_w7
    k_c8  = k_c7 + k_w8
    k_c9  = k_c8 + k_w9
    k_c10 = k_c9 + k_w10

    k_pc = 11
    if k_wroll < k_c10 then
      k_pc = 10
    endif
    if k_wroll < k_c9 then
      k_pc = 9
    endif
    if k_wroll < k_c8 then
      k_pc = 8
    endif
    if k_wroll < k_c7 then
      k_pc = 7
    endif
    if k_wroll < k_c6 then
      k_pc = 6
    endif
    if k_wroll < k_c5 then
      k_pc = 5
    endif
    if k_wroll < k_c4 then
      k_pc = 4
    endif
    if k_wroll < k_c3 then
      k_pc = 3
    endif
    if k_wroll < k_c2 then
      k_pc = 2
    endif
    if k_wroll < k_c1 then
      k_pc = 1
    endif
    if k_wroll < k_c0 then
      k_pc = 0
    endif
  endif

  xout k_pc
endop


;==============================================================
; UDO: PCtoMIDI — Convert pitch class to MIDI note
;==============================================================
opcode PCtoMIDI, k, kkkk
  kpc, kroot, krange, koctjump xin

  k_root_oct = int(kroot / 12)
  k_root_pc  = kroot % 12

  k_midi = k_root_oct * 12 + kpc
  if kpc < k_root_pc then
    k_midi = k_midi + 12
  endif

  k_range_oct = int(krange)
  if k_range_oct > 0 then
    k_oct_rnd random 0, k_range_oct + 0.999
    k_midi = k_midi + int(k_oct_rnd) * 12
  endif

  k_oct_roll random 0, 1
  if k_oct_roll < koctjump then
    k_midi = k_midi + 12
  endif

  k_midi limit k_midi, 24, 108

  xout k_midi
endop


;==============================================================
; UDO: LFOWave — Multi-waveform LFO (kept for future use)
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
; MODULATOR — instr 90
;
; Hard-coded LFOs from each rig preset. No GUI — these are baked
; into the composition sound. Writes per-instrument globals.
;
; Pluck LFOs (sequencer-rig-preset):
;   LFO1: Wander  f=0.03 a=1.0  → Cutoff
;   LFO2: Tri     f=0.02 a=0.18 → Reso
;   LFO3: S&H     f=0.02 a=0.45 → Shape
;   LFO4: S&H     f=0.02 a=0.26 → Density
;
; FM drone LFOs (fm-synth-rig-preset):
;   LFO1: Sine    f=0.02 a=1.0  → Cutoff
;   LFO2: Tri     f=0.02 a=0.47 → Reso
;
; Pad LFOs (wave-edit-rig-preset):
;   LFO1: Sine    f=0.02 a=1.0  → Morph
;   LFO2: Wander  f=0.03 a=1.0  → Cutoff
;   LFO3: Sine    f=0.05 a=0.15 → Reso
;
; NOTE: LFOs are inlined (not via LFOWave UDO) to avoid
; Csound 6 UDO instance state-sharing with 9 concurrent calls.
;==============================================================
instr 90

  ; === PLUCK LFOs ===

  ; LFO1: Wander → Cutoff (f=0.03, a=1.0)
  k_pw1a randi 1, 0.03
  k_pw1b randi 0.5, 0.03 * 0.4286
  k_plk_cut = (k_pw1a + k_pw1b) / 1.5

  ; LFO2: Triangle → Reso (f=0.02, a=0.18)
  k_plk_reso_phs phasor 0.02
  k_plk_reso = (1 - 4 * abs(k_plk_reso_phs - 0.5)) * 0.18

  ; LFO3: S&H → Shape (f=0.02, a=0.45)
  k_plk_shp_phs phasor 0.02
  k_plk_shp_val init 0
  k_plk_shp_prv init 1
  if k_plk_shp_phs < k_plk_shp_prv then
    k_plk_shp_val random -1, 1
  endif
  k_plk_shp_prv = k_plk_shp_phs
  k_plk_shp = k_plk_shp_val * 0.45

  ; LFO4: S&H → Density (f=0.02, a=0.26)
  k_plk_den_phs phasor 0.02
  k_plk_den_val init 0
  k_plk_den_prv init 1
  if k_plk_den_phs < k_plk_den_prv then
    k_plk_den_val random -1, 1
  endif
  k_plk_den_prv = k_plk_den_phs
  k_plk_den = k_plk_den_val * 0.26

  gk_plk_mod_cutoff  = k_plk_cut * 4000
  gk_plk_mod_reso    = k_plk_reso * 0.3
  gk_plk_mod_shape   = k_plk_shp * 0.3
  gk_plk_mod_density = k_plk_den * 0.3

  ; === FM DRONE LFOs ===

  ; LFO1: Sine → Cutoff (f=0.02, a=1.0)
  k_fm_cut_phs phasor 0.02
  k_fm_cut = sin(k_fm_cut_phs * 6.28318530718)

  ; LFO2: Triangle → Reso (f=0.02, a=0.47)
  k_fm_reso_phs phasor 0.02
  k_fm_reso = (1 - 4 * abs(k_fm_reso_phs - 0.5)) * 0.47

  gk_fm_mod_cutoff = k_fm_cut * 4000
  gk_fm_mod_reso   = k_fm_reso * 0.3

  ; === PAD LFOs ===

  ; LFO1: Sine → Morph (f=0.02, a=1.0)
  k_pad_mrph_phs phasor 0.02
  k_pad_mrph = sin(k_pad_mrph_phs * 6.28318530718)

  ; LFO2: Wander → Cutoff (f=0.03, a=1.0)
  k_pad_w2a randi 1, 0.03
  k_pad_w2b randi 0.5, 0.03 * 0.4286
  k_pad_cut = (k_pad_w2a + k_pad_w2b) / 1.5

  ; LFO3: Sine → Reso (f=0.05, a=0.15)
  k_pad_reso_phs phasor 0.05
  k_pad_reso = sin(k_pad_reso_phs * 6.28318530718) * 0.15

  gk_pad_mod_morph  = k_pad_mrph * 0.5
  gk_pad_mod_cutoff = k_pad_cut * 4000
  gk_pad_mod_reso   = k_pad_reso * 0.3

endin


;==============================================================
; PLUCK VOICE — instr 1 (event-triggered, polyphonic)
;
; Sound params hard-coded from sequencer-rig-preset.json.
; p4 = frequency (Hz), p5 = velocity (0-1), p6 = pan (0-1)
;==============================================================
instr 1

  ifreq = p4
  ivel  = p5
  ipan  = p6

  ; --- Hard-coded sound params (from sequencer-rig preset) ---
  ; Apply LFO modulation from globals (written by instr 90)
  k_shape   = 0.52 + gk_plk_mod_shape
  k_detune  = 1.7
  k_sub_lvl = 0.47
  k_cut     = 313  + gk_plk_mod_cutoff
  k_reso    = 0.25 + gk_plk_mod_reso
  k_envamt  = 0.5

  ; Clamp modulated params
  k_shape limit k_shape, 0, 1
  k_cut   limit k_cut, 200, 12000
  k_reso  limit k_reso, 0, 0.9
  i_filt_dec = 1.69
  i_amp_a   = 0.005
  i_amp_d   = 0.15
  i_amp_s   = 0.18

  ; --- Per-instrument mix params ---
  k_vol      chnget "plk_vol"
  k_dly_send chnget "plk_dly_send"
  k_rvb_send chnget "plk_rvb_send"

  ; --- Master params (shared with other instruments) ---
  k_master   chnget "master_vol"
  k_warmth_v chnget "warmth"
  k_lpf      chnget "master_lpf"

  ; --- Amp envelope ---
  i_hold = p3 - i_amp_a - i_amp_d
  i_hold = (i_hold < 0.01) ? 0.01 : i_hold
  k_aenv linseg 0, i_amp_a, 1, i_amp_d, i_amp_s, i_hold, i_amp_s
  k_aenv = k_aenv * k_aenv

  ; --- Filter mod envelope ---
  i_mod_hold = p3 - 0.005 - i_filt_dec
  i_mod_hold = (i_mod_hold < 0.001) ? 0.001 : i_mod_hold
  k_menv linseg 0, 0.005, 1, i_filt_dec, 0, i_mod_hold, 0
  k_menv = k_menv * k_menv

  ; --- Oscillators ---
  a_saw vco2 1, ifreq, 0
  a_sqr vco2 1, ifreq, 10, 0.5
  a_osc = a_saw * (1 - k_shape) + a_sqr * k_shape

  k_det_hz = ifreq * (k_detune * 0.01 / 12)
  a_saw2 vco2 0.5, ifreq + k_det_hz, 0
  a_osc = a_osc + a_saw2

  a_sub oscili k_sub_lvl, ifreq * 0.5, gi_sine
  a_osc = a_osc + a_sub

  ; --- Filter (envelope tracks cutoff for LFO-responsive sweep) ---
  k_filt_cut = k_cut + k_menv * k_envamt * (k_cut * 4) + ivel * 400
  k_filt_cut limit k_filt_cut, 60, 18000

  a_filt moogladder a_osc, k_filt_cut, k_reso

  ; --- Apply envelope + velocity ---
  a_out = a_filt * k_aenv * ivel * 0.18

  ; --- Warmth ---
  if k_warmth_v > 0.01 then
    a_out = tanh(a_out * (1 + k_warmth_v * 2))
    a_low butterlp a_out, 200
    a_out = a_out + a_low * k_warmth_v * 0.4
  endif

  ; --- Master LPF ---
  a_out butterlp a_out, k_lpf

  ; --- Stereo ---
  aL = a_out * (1 - ipan)
  aR = a_out * ipan

  ; --- Volume + soft clip ---
  aL = tanh(aL * k_vol * k_master)
  aR = tanh(aR * k_vol * k_master)

  ; --- DC block ---
  aL dcblock aL
  aR dcblock aR

  ; --- Dry output (minus delay wet) ---
  k_dly_mix chnget "dly_mix"
  outs aL * (1 - k_dly_mix), aR * (1 - k_dly_mix)

  ; --- Send to effect buses ---
  ga_dly_L = ga_dly_L + aL * k_dly_send
  ga_dly_R = ga_dly_R + aR * k_dly_send
  ga_rvb_L = ga_rvb_L + aL * k_rvb_send
  ga_rvb_R = ga_rvb_R + aR * k_rvb_send

endin


;==============================================================
; FM DRONE VOICE — instr 2 (long-lived, channel-driven)
;
; Reads drone_midi/drone_gate channels from Drone Controller (76).
; Sound params hard-coded from fm-synth-rig-preset.json.
;==============================================================
instr 2

  ; --- Hard-coded sound params (from fm-synth-rig preset) ---
  ; Osc A: sine (wave 4), Osc B: saw (wave 1)
  k_lvl_a    = 0.51
  k_lvl_b    = 0.6
  k_mix      = 0.49
  k_fine     = 7
  k_noise_lvl = 0.17

  ; Filter (with LFO modulation from instr 90)
  k_cut_base = 1285 + gk_fm_mod_cutoff
  k_reso     = 0.55 + gk_fm_mod_reso
  k_env_amt  = 0.5
  k_keytrk   = 0.51

  ; Clamp modulated params
  k_cut_base limit k_cut_base, 200, 16000
  k_reso     limit k_reso, 0, 0.9

  ; Amp envelope
  i_amp_a    = 0.8
  i_amp_d    = 1.5
  i_amp_s    = 0.7

  ; Filter envelope
  i_flt_a    = 0.01
  i_flt_d    = 2.0
  i_flt_s    = 0.2

  ; --- Per-instrument mix params ---
  k_vol      chnget "fm_vol"
  k_dly_send chnget "fm_dly_send"
  k_rvb_send chnget "fm_rvb_send"
  k_master   chnget "master_vol"
  k_warmth   chnget "warmth"
  k_lpf      chnget "master_lpf"

  ; --- Read frequency from drone controller ---
  k_drone_midi chnget "drone_midi"
  k_drone_gate chnget "drone_gate"

  ; Portamento on gate for volume fade
  k_gate_smooth portk k_drone_gate, 0.5

  ; Auto-turnoff when fully faded out and gate is off
  if k_gate_smooth < 0.001 && k_drone_gate < 0.5 then
    ; Only turn off if we've been alive for a bit (avoid instant turnoff)
    k_alive timeinsts
    if k_alive > 2 then
      turnoff
    endif
  endif

  ; Convert MIDI to frequency
  k_drone_midi limit k_drone_midi, 12, 36
  k_cps = cpsmidinn(k_drone_midi)

  ; --- Amp ADS envelope ---
  i_ads_hold = 3600
  k_ads linseg 0, i_amp_a, 1, i_amp_d, i_amp_s, i_ads_hold, i_amp_s

  ; --- Filter ADS envelope ---
  k_flt_ads linseg 0, i_flt_a, 1, i_flt_d, i_flt_s, i_ads_hold, i_flt_s

  ; --- Osc A: sine ---
  a_osc_a oscili 1, k_cps, gi_sine

  ; --- Osc B: saw (detuned by Fine cents) ---
  k_semi_total = k_fine * 0.01
  k_cps_b = k_cps * semitone(k_semi_total)
  a_osc_b vco2 1, k_cps_b, 0

  ; --- Mix oscillators ---
  a_osc = a_osc_a * k_lvl_a * (1 - k_mix) + a_osc_b * k_lvl_b * k_mix

  ; --- Noise layer ---
  a_noise noise k_noise_lvl * 0.3, 0
  a_osc = a_osc + a_noise

  ; --- Filter ---
  k_keytrk_hz = (k_cps - 261.63) * k_keytrk * 8
  k_filt_cut = k_cut_base + k_flt_ads * k_env_amt * 8000 + k_keytrk_hz
  k_filt_cut limit k_filt_cut, 60, 18000

  a_filt moogladder a_osc, k_filt_cut, k_reso

  ; --- Apply envelope + gate ---
  a_out = a_filt * k_ads * k_gate_smooth

  ; --- Warmth ---
  if k_warmth > 0.01 then
    a_out = tanh(a_out * (1 + k_warmth * 2))
    a_low butterlp a_out, 200
    a_out = a_out + a_low * k_warmth * 0.4
  endif

  ; --- Master LPF ---
  a_out butterlp a_out, k_lpf

  ; --- Stereo (center) ---
  aL = a_out * 0.5
  aR = a_out * 0.5

  ; --- Volume + soft clip ---
  aL = tanh(aL * k_vol * k_master)
  aR = tanh(aR * k_vol * k_master)

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
; PAD VOICE — instr 3 (polyphonic chord tones, hold until released)
;
; Wavetable morph + unison. Sound params from wave-edit-rig preset.
; p4 = frequency (Hz), p5 = velocity (0-1), p6 = pan (0-1)
;==============================================================
instr 3

  ifreq = p4
  ivel  = p5
  ipan  = p6

  ; --- Hard-coded sound params (from wave-edit-rig preset) ---
  ; Apply LFO modulation from globals (written by instr 90)
  k_morph    = 0.48 + gk_pad_mod_morph
  k_padlvl   = 0.56
  k_sub_lvl  = 0.18
  k_cut_base = 8000 + gk_pad_mod_cutoff
  k_reso     = 0.1  + gk_pad_mod_reso
  k_envamt   = 0.3

  ; Clamp modulated params
  k_morph  limit k_morph, 0, 1
  k_cut_base limit k_cut_base, 200, 16000
  k_reso   limit k_reso, 0, 0.9
  i_filt_dec = 4.0
  i_amp_a    = 0.8
  i_amp_d    = 1.5
  i_amp_s    = 0.7
  i_amp_r    = 4.0
  k_uni_v    = 4
  k_uni_det_base = 15
  k_uni_spd  = 1.0

  ; --- Per-instrument mix params ---
  k_vol      chnget "pad_vol"
  k_dly_send chnget "pad_dly_send"
  k_rvb_send chnget "pad_rvb_send"
  k_master   chnget "master_vol"
  k_warmth   chnget "warmth"
  k_lpf      chnget "master_lpf"

  ; --- Capture table sizes at note-on ---
  i_fund   = gi_pad_fund
  i_size_a = gi_pad_size_A
  i_size_b = gi_pad_size_B
  i_sros_a = sr / i_size_a
  i_sros_b = sr / i_size_b

  ; --- HOLD + RELEASE via xtratim + release ---
  xtratim i_amp_r + 0.1

  k_rel release
  k_releasing init 0

  if k_rel == 1 && k_releasing == 0 then
    k_releasing = 1
    reinit start_pad_release
  endif

  ; --- Amp ADS envelope ---
  i_ads_hold = 3600
  k_ads linseg 0, i_amp_a, 1, i_amp_d, i_amp_s, i_ads_hold, i_amp_s

  ; --- Filter mod envelope ---
  i_mod_hold = 3600
  k_menv linseg 0, 0.005, 1, i_filt_dec, 0, i_mod_hold, 0
  k_menv = k_menv * k_menv

  ; --- Release envelope ---
  k_rel_env init 1
  if k_releasing == 1 then
start_pad_release:
    k_rel_env linseg 1, i_amp_r, 0
    rireturn
  endif

  k_amp_env = k_ads * k_rel_env

  ; Auto-turnoff when release complete
  if k_releasing == 1 && k_rel_env <= 0.001 then
    turnoff
  endif

  ; --- PADSYNTH OSCILLATORS — 4 UNISON VOICES ---
  k_rate_a = ifreq / i_fund * i_sros_a
  k_rate_b = ifreq / i_fund * i_sros_b

  k_det_ratio = (2 ^ (k_uni_det_base / 1200)) - 1
  k_det_a = k_rate_a * k_det_ratio
  k_det_b = k_rate_b * k_det_ratio

  ; Voice 0: center pitch
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

  ; Voice 3: detuned up more (1.5x)
  a_a3 poscil 1, k_rate_a + k_det_a * 1.5, gi_pad_A
  a_b3 poscil 1, k_rate_b + k_det_b * 1.5, gi_pad_B
  a_mix3 = a_a3 * (1 - k_morph) + a_b3 * k_morph

  ; 4 voices always active, normalize
  k_norm = 0.25

  ; Stereo spread
  k_sp = k_uni_spd
  a_pad_L = (a_mix0 * 0.5 + a_mix1 * (1 - k_sp * 0.8) + a_mix2 * k_sp * 0.8 + a_mix3 * (0.6 - k_sp * 0.2)) * k_norm * k_padlvl
  a_pad_R = (a_mix0 * 0.5 + a_mix1 * k_sp * 0.8 + a_mix2 * (1 - k_sp * 0.8) + a_mix3 * (0.4 + k_sp * 0.2)) * k_norm * k_padlvl

  ; --- Sub oscillator ---
  a_sub oscili k_sub_lvl, ifreq * 0.5, gi_sine

  ; --- Mix ---
  a_osc_L = a_pad_L + a_sub * 0.5
  a_osc_R = a_pad_R + a_sub * 0.5

  ; --- Filter ---
  k_filt_cut = k_cut_base + k_menv * k_envamt * 8000
  k_filt_cut limit k_filt_cut, 60, 18000
  a_filt_L moogladder a_osc_L, k_filt_cut, k_reso
  a_filt_R moogladder a_osc_R, k_filt_cut, k_reso

  ; --- Apply envelope + velocity ---
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

  ; --- Pan ---
  aL = a_out_L * (1 - ipan) + a_out_R * ipan * 0.3
  aR = a_out_R * ipan + a_out_L * (1 - ipan) * 0.3

  ; --- Volume + soft clip ---
  aL = tanh(aL * k_vol * k_master)
  aR = tanh(aR * k_vol * k_master)

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
; CONDUCTOR — instr 70
;
; Circle-of-fifths harmonic modulation engine.
; Writes gk_cof_pos for chord generator and drone controller.
;==============================================================
instr 70

  ; --- Read GUI parameters ---
  k_start_key chnget "cond_start_key"
  k_speed     chnget "cond_speed"
  k_dir_sel   chnget "cond_dir"
  k_enabled   chnget "cond_enabled"
  k_manual    chnget "cond_manual"
  k_scale     chnget "seq_scale"

  ; --- State ---
  k_cof_pos     init 0
  k_xfade       init 0
  k_active      init 0
  k_pc_out      init 0
  k_pc_in       init 0
  k_direction   init 1
  k_prev_key    init 1
  k_initialized init 0

  ; --- Initialize ---
  if k_initialized == 0 then
    k_cof_pos = k_start_key - 1
    k_prev_key = k_start_key
    k_initialized = 1
    gk_cof_pos = k_cof_pos
    event "i", 71, 0, 0.1, k_cof_pos, k_scale
  endif

  ; --- Detect start key change ---
  if k_start_key != k_prev_key then
    k_cof_pos = k_start_key - 1
    k_prev_key = k_start_key
    k_xfade = 0
    k_active = 0
    gk_cof_pos = k_cof_pos
    event "i", 71, 0, 0.1, k_cof_pos, k_scale
  endif

  ; --- Detect scale change ---
  k_prev_scale init 1
  if k_scale != k_prev_scale then
    k_prev_scale = k_scale
    event "i", 71, 0, 0.1, k_cof_pos, k_scale
  endif

  ; --- Manual "Next" button ---
  k_man_trig trigger k_manual, 0.5, 0
  if k_man_trig == 1 then
    chnset k(0), "cond_manual"
    if k_active == 0 then
      if k_dir_sel == 1 then
        k_direction = 1
      elseif k_dir_sel == 2 then
        k_direction = -1
      else
        k_coin random 0, 1
        k_direction = (k_coin < 0.5) ? 1 : -1
      endif

      k_wt_cof = gi_cof_pc
      k_root_pc tablekt k_cof_pos, k_wt_cof

      if k_direction == 1 then
        k_pc_out = (k_root_pc + 5) % 12
        k_pc_in  = (k_root_pc + 6) % 12
      else
        k_pc_out = (k_root_pc + 11) % 12
        k_pc_in  = (k_root_pc + 10) % 12
      endif

      k_xfade = 0
      k_active = 1
    endif
  endif

  ; --- Auto-modulation ---
  if k_enabled > 0.5 && k_active == 0 then
    if k_dir_sel == 1 then
      k_direction = 1
    elseif k_dir_sel == 2 then
      k_direction = -1
    else
      k_coin random 0, 1
      k_direction = (k_coin < 0.5) ? 1 : -1
    endif

    k_wt_cof = gi_cof_pc
    k_root_pc tablekt k_cof_pos, k_wt_cof

    if k_direction == 1 then
      k_pc_out = (k_root_pc + 5) % 12
      k_pc_in  = (k_root_pc + 6) % 12
    else
      k_pc_out = (k_root_pc + 11) % 12
      k_pc_in  = (k_root_pc + 10) % 12
    endif

    k_xfade = 0
    k_active = 1
  endif

  ; --- Crossfade engine ---
  if k_active == 1 then
    k_inc = (ksmps / sr) / (k_speed * 60)
    k_xfade = k_xfade + k_inc

    if k_xfade >= 1 then
      k_xfade = 1
      k_active = 0
      k_cof_pos = (k_cof_pos + k_direction + 12) % 12
      gk_cof_pos = k_cof_pos
      ; Rebuild weight table for new key
      event "i", 71, 0, 0.1, k_cof_pos, k_scale
    endif

    k_wt = gi_weights
    tablewkt (1 - k_xfade), k_pc_out, k_wt
    tablewkt k_xfade, k_pc_in, k_wt
  endif

  ; --- GUI label updates (throttled to ~5 Hz) ---
  k_gui_metro metro 5
  if k_gui_metro == 1 then

    gk_cof_pos = k_cof_pos

    k_kn = k_cof_pos
    Skey = ""
    if k_kn == 0 then
      Skey = "C"
    elseif k_kn == 1 then
      Skey = "G"
    elseif k_kn == 2 then
      Skey = "D"
    elseif k_kn == 3 then
      Skey = "A"
    elseif k_kn == 4 then
      Skey = "E"
    elseif k_kn == 5 then
      Skey = "B"
    elseif k_kn == 6 then
      Skey = "F#"
    elseif k_kn == 7 then
      Skey = "C#"
    elseif k_kn == 8 then
      Skey = "Ab"
    elseif k_kn == 9 then
      Skey = "Eb"
    elseif k_kn == 10 then
      Skey = "Bb"
    elseif k_kn == 11 then
      Skey = "F"
    endif

    Slbl sprintfk {{text("Key: %s")}}, Skey
    cabbageSet "cond_key_lbl", Slbl

    if k_active == 1 then
      k_tgt = (k_cof_pos + k_direction + 12) % 12
      Stgt = ""
      if k_tgt == 0 then
        Stgt = "C"
      elseif k_tgt == 1 then
        Stgt = "G"
      elseif k_tgt == 2 then
        Stgt = "D"
      elseif k_tgt == 3 then
        Stgt = "A"
      elseif k_tgt == 4 then
        Stgt = "E"
      elseif k_tgt == 5 then
        Stgt = "B"
      elseif k_tgt == 6 then
        Stgt = "F#"
      elseif k_tgt == 7 then
        Stgt = "C#"
      elseif k_tgt == 8 then
        Stgt = "Ab"
      elseif k_tgt == 9 then
        Stgt = "Eb"
      elseif k_tgt == 10 then
        Stgt = "Bb"
      elseif k_tgt == 11 then
        Stgt = "F"
      endif

      k_pct = int(k_xfade * 100)
      Sstat sprintfk {{text("%s > %s [%d%%]")}}, Skey, Stgt, k_pct
      cabbageSet "cond_status", Sstat
    else
      if k_enabled > 0.5 then
        Sstat sprintfk {{text("%s (auto)")}}, Skey
        cabbageSet "cond_status", Sstat
      else
        cabbageSet "cond_status", {{text("Idle")}}
      endif
    endif

    cabbageSet "cond_gt_ident", {{tableNumber(100)}}
  endif

endin


;==============================================================
; KEY RESET — instr 71
;
; Rebuilds the weight table for a given circle-of-fifths position
; using the selected scale mode.
; p4 = CoF position (0-11), p5 = scale mode (1-6)
;==============================================================
instr 71

  i_cof_pos = int(p4)
  i_scale   = int(p5)

  ; Get root pitch class from CoF table
  i_root_pc tab_i i_cof_pos, gi_cof_pc

  ; Select scale table and length
  i_sc_tab = gi_sc_minpent
  i_sc_len = gi_sc_len_minpent

  if i_scale == 2 then
    i_sc_tab = gi_sc_majpent
    i_sc_len = gi_sc_len_majpent
  elseif i_scale == 3 then
    i_sc_tab = gi_sc_minor
    i_sc_len = gi_sc_len_minor
  elseif i_scale == 4 then
    i_sc_tab = gi_sc_major
    i_sc_len = gi_sc_len_major
  elseif i_scale == 5 then
    i_sc_tab = gi_sc_dorian
    i_sc_len = gi_sc_len_dorian
  elseif i_scale == 6 then
    i_sc_tab = gi_sc_chrom
    i_sc_len = gi_sc_len_chrom
  endif

  ; Clear all 12 weights to 0
  i_idx = 0
loop_clear:
  tabw_i 0, i_idx, gi_weights
  i_idx = i_idx + 1
  if i_idx < 12 igoto loop_clear

  ; Set scale degrees to 1 (transposed to root)
  i_deg = 0
loop_set:
  i_interval tab_i i_deg, i_sc_tab
  i_pc = (i_root_pc + i_interval) % 12
  tabw_i 1, i_pc, gi_weights
  i_deg = i_deg + 1
  if i_deg < i_sc_len igoto loop_set

  turnoff

endin


;==============================================================
; CHORD GENERATOR — instr 75
;
; Tracks gk_cof_pos. On key change: turnoff2 existing pad voices,
; trigger 3 new pad voices with randomly varied voicings:
; root position, inversions, open, sus2, sus4, spread.
;==============================================================
instr 75

  k_pad_play chnget "pad_play"
  k_scale    chnget "seq_scale"

  ; Track CoF position for key changes
  k_prev_pos init -1
  k_prev_pad_play init -1

  ; Detect key change OR pad_play toggle on
  k_changed = 0
  if k_prev_pos < 0 then
    k_prev_pos = gk_cof_pos
    k_prev_pad_play = k_pad_play
    k_changed = 1
  endif

  if gk_cof_pos != k_prev_pos then
    k_changed = 1
    k_prev_pos = gk_cof_pos
  endif

  ; Detect pad_play toggled on
  if k_pad_play > 0.5 && k_prev_pad_play < 0.5 then
    k_changed = 1
  endif
  k_prev_pad_play = k_pad_play

  ; Detect scale change
  k_prev_sc init -1
  if k_prev_sc < 0 then
    k_prev_sc = k_scale
  endif
  if k_scale != k_prev_sc then
    k_changed = 1
    k_prev_sc = k_scale
  endif

  if k_changed == 1 && k_pad_play > 0.5 then

    ; Release existing pad voices
    turnoff2 3, 0, 1

    ; Get root pitch class from CoF table
    k_wt_cof = gi_cof_pc
    k_root_pc tablekt gk_cof_pos, k_wt_cof

    ; Select scale table and length for triad
    k_sc_tab = gi_sc_minpent
    k_sc_len = gi_sc_len_minpent

    if k_scale == 2 then
      k_sc_tab = gi_sc_majpent
      k_sc_len = gi_sc_len_majpent
    elseif k_scale == 3 then
      k_sc_tab = gi_sc_minor
      k_sc_len = gi_sc_len_minor
    elseif k_scale == 4 then
      k_sc_tab = gi_sc_major
      k_sc_len = gi_sc_len_major
    elseif k_scale == 5 then
      k_sc_tab = gi_sc_dorian
      k_sc_len = gi_sc_len_dorian
    elseif k_scale == 6 then
      k_sc_tab = gi_sc_chrom
      k_sc_len = gi_sc_len_chrom
    endif

    ; === VOICING SELECTION ===
    ; Randomly pick from 6 voicing types on each key change:
    ;   0: Root position    (deg 0, deg 2, deg 4)
    ;   1: 1st inversion    (deg 2, deg 4, deg 0 +oct)
    ;   2: Open voicing     (deg 0, deg 4, deg 2 +oct)
    ;   3: Sus2             (deg 0, deg 1, deg 4)
    ;   4: Sus4             (deg 0, deg 3, deg 4)
    ;   5: Spread           (deg 0, deg 4, deg 1 +oct)

    k_voicing random 0, 5.999
    k_voicing = int(k_voicing)

    ; Default: root position
    k_da = 0
    k_db = 2
    k_dc = 4
    k_oa = 0
    k_ob = 0
    k_oc = 0

    if k_voicing == 1 then
      ; 1st inversion: 3rd low, 5th, root high
      k_da = 2
      k_db = 4
      k_dc = 0
      k_oc = 1
    elseif k_voicing == 2 then
      ; Open: root, 5th, 3rd up an octave
      k_db = 4
      k_dc = 2
      k_oc = 1
    elseif k_voicing == 3 then
      ; Sus2: root, 2nd, 5th
      k_db = 1
    elseif k_voicing == 4 then
      ; Sus4: root, 4th, 5th
      k_db = 3
    elseif k_voicing == 5 then
      ; Spread: root, 5th, 9th (2nd up an octave)
      k_db = 4
      k_dc = 1
      k_oc = 1
    endif

    ; Clamp degrees to scale length
    if k_da >= k_sc_len then
      k_da = k_sc_len - 1
    endif
    if k_db >= k_sc_len then
      k_db = k_sc_len - 1
    endif
    if k_dc >= k_sc_len then
      k_dc = k_sc_len - 1
    endif

    ; Look up semitone intervals from scale table
    k_sa = 0
    k_sb = 0
    k_sc = 0

    if k_scale == 6 then
      ; Chromatic: use fixed semitone intervals
      if k_voicing == 0 then
        k_sa = 0
        k_sb = 4
        k_sc = 7
      elseif k_voicing == 1 then
        k_sa = 4
        k_sb = 7
        k_sc = 0
        k_oc = 1
      elseif k_voicing == 2 then
        k_sa = 0
        k_sb = 7
        k_sc = 4
        k_oc = 1
      elseif k_voicing == 3 then
        k_sa = 0
        k_sb = 2
        k_sc = 7
      elseif k_voicing == 4 then
        k_sa = 0
        k_sb = 5
        k_sc = 7
      elseif k_voicing == 5 then
        k_sa = 0
        k_sb = 7
        k_sc = 2
        k_oc = 1
      endif
    else
      k_sa tablekt k_da, k_sc_tab
      k_sb tablekt k_db, k_sc_tab
      k_sc tablekt k_dc, k_sc_tab
    endif

    ; Compute MIDI notes (base octave 4 = MIDI 48 area)
    k_base = 4 * 12
    k_ma = k_base + ((k_root_pc + k_sa) % 12) + k_oa * 12
    k_mb = k_base + ((k_root_pc + k_sb) % 12) + k_ob * 12
    k_mc = k_base + ((k_root_pc + k_sc) % 12) + k_oc * 12

    ; Ensure voices ascend (each above previous)
    if k_mb <= k_ma then
      k_mb = k_mb + 12
    endif
    if k_mc <= k_mb then
      k_mc = k_mc + 12
    endif

    ; Clamp to pad range
    k_ma limit k_ma, 36, 84
    k_mb limit k_mb, 36, 84
    k_mc limit k_mc, 36, 84

    ; Convert to frequency and trigger
    k_fa = cpsmidinn(k_ma)
    k_fb = cpsmidinn(k_mb)
    k_fc = cpsmidinn(k_mc)

    ; Varied velocity/pan per voicing for interest
    k_vel_a = 0.7
    k_vel_bc = 0.6
    k_pan_a random 0.35, 0.65
    k_pan_b random 0.15, 0.45
    k_pan_c random 0.55, 0.85

    event "i", 3, 0, 3600, k_fa, k_vel_a,  k_pan_a
    event "i", 3, 0, 3600, k_fb, k_vel_bc, k_pan_b
    event "i", 3, 0, 3600, k_fc, k_vel_bc, k_pan_c

  endif

  ; Handle pad_play toggled off -> release voices
  if k_pad_play < 0.5 then
    k_pad_off_trig init 0
    if k_pad_off_trig == 0 then
      turnoff2 3, 0, 1
      k_pad_off_trig = 1
    endif
  else
    k_pad_off_trig = 0
  endif

endin


;==============================================================
; DRONE CONTROLLER — instr 76
;
; Tracks gk_cof_pos, computes drone MIDI note in C0-C1 octave,
; applies portamento, writes drone_midi/drone_gate channels.
;==============================================================
instr 76

  k_fm_play chnget "fm_play"

  ; Get root pitch class from CoF table
  k_wt_cof = gi_cof_pc
  k_root_pc tablekt gk_cof_pos, k_wt_cof

  ; Target MIDI note: C1 octave (MIDI 24 + pitch_class)
  k_target_midi = 24 + k_root_pc

  ; Apply portamento (~2 sec glide)
  k_drone_midi portk k_target_midi, 2.0

  ; Write to channels
  chnset k_drone_midi, "drone_midi"

  ; Manage drone voice lifecycle
  k_drone_active init 0

  if k_fm_play > 0.5 then
    chnset k(1), "drone_gate"
    if k_drone_active == 0 then
      ; Start drone voice
      event "i", 2, 0, 3600
      k_drone_active = 1
    endif
  else
    chnset k(0), "drone_gate"
    ; Don't turnoff2 — let the gate fade handle it
    if k_drone_active == 1 then
      k_drone_active = 0
    endif
  endif

endin


;==============================================================
; WAV LOADER — instr 78
;
; Loads padsynth-export WAV files into ftables 200/201.
; Runs once at score time 0, then turns off.
;==============================================================
instr 78

  #define SAMPLES_DIR #/Users/daniel/PycharmProjects/generative-ambient/apps/web/public/samples#

  S_path_a = "$SAMPLES_DIR/padsynth-export-a.wav"
  S_path_b = "$SAMPLES_DIR/padsynth-export-b.wav"

  i_va filevalid S_path_a
  if i_va == 1 then
    gi_pad_A ftgen 200, 0, 0, -1, S_path_a, 0, 0, 0
    gi_pad_size_A = ftlen(gi_pad_A)
    prints "Loaded pad table A: %d samples\n", gi_pad_size_A
  else
    prints "WAV not found: %s — using default padsynth\n", S_path_a
  endif

  i_vb filevalid S_path_b
  if i_vb == 1 then
    gi_pad_B ftgen 201, 0, 0, -1, S_path_b, 0, 0, 0
    gi_pad_size_B = ftlen(gi_pad_B)
    prints "Loaded pad table B: %d samples\n", gi_pad_size_B
  else
    prints "WAV not found: %s — using default padsynth\n", S_path_b
  endif

  gi_pad_fund = 261.63

  turnoff

endin


;==============================================================
; SEQUENCER — instr 80
;
; Probabilistic note generator with scale-aware pitch selection.
; Uses scale tables for note picking (not WeightedPC from CoF rig).
; Only triggers pluck voices when plk_play is on.
;==============================================================
instr 80

  ; --- Read sequencer parameters ---
  k_play    chnget "seq_play"
  k_plk_play chnget "plk_play"
  k_bpm     chnget "seq_bpm"
  k_scale   chnget "seq_scale"

  ; Hard-coded from sequencer-rig preset
  k_swing   = 0
  k_dens    = 0.8 + gk_plk_mod_density
  k_dens    limit k_dens, 0, 1
  k_gate    = 3.0
  k_range   = 1.5
  k_octjump = 0.2

  ; Derive effective root from conductor key + register combobox
  ; Register: 1=Low(oct2), 2=Mid-Lo(oct3), 3=Mid(oct4), 4=High(oct5)
  k_reg     chnget "seq_root"
  k_wt_cof  = gi_cof_pc
  k_cond_pc tablekt gk_cof_pos, k_wt_cof
  k_root_oct = int(k_reg) + 1
  k_root     = k_root_oct * 12 + k_cond_pc

  ; --- Pattern mode parameters ---
  k_patmode chnget "seq_patmode"
  k_patrep  chnget "seq_patrep"

  ; Fixed dynamics (from sequencer-rig preset)
  k_velmin = 0.3
  k_velmax = 0.8
  k_accent = 0.3

  ;==========================================================
  ; SCALE TABLE SELECTION
  ;==========================================================
  k_sc_tab  = gi_sc_minpent
  k_sc_len  = gi_sc_len_minpent

  if k_scale == 2 then
    k_sc_tab = gi_sc_majpent
    k_sc_len = gi_sc_len_majpent
  elseif k_scale == 3 then
    k_sc_tab = gi_sc_minor
    k_sc_len = gi_sc_len_minor
  elseif k_scale == 4 then
    k_sc_tab = gi_sc_major
    k_sc_len = gi_sc_len_major
  elseif k_scale == 5 then
    k_sc_tab = gi_sc_dorian
    k_sc_len = gi_sc_len_dorian
  elseif k_scale == 6 then
    k_sc_tab = gi_sc_chrom
    k_sc_len = gi_sc_len_chrom
  endif

  k_range_semi = k_range * 12
  k_max_deg = k_range_semi / 12 * k_sc_len
  k_max_deg limit k_max_deg, 1, 60

  ;==========================================================
  ; PATTERN STATE
  ;==========================================================
  k_pat_step     init 0
  k_pat_rep      init 0
  k_pat_len      init 8
  k_pat_ready    init 0
  k_pat_need_gen init 0
  k_gen_active   init 0
  k_gen_step     init 0
  k_gen_len      init 8
  k_prev_patmode init 1
  k_prev_scale   init 1
  k_prev_root    init 48

  k_new_len = 8
  if k_patmode == 3 then
    k_new_len = 16
  elseif k_patmode == 4 then
    k_new_len = 32
  endif

  if k_patmode != k_prev_patmode then
    k_pat_need_gen = 1
    k_pat_ready = 0
    k_prev_patmode = k_patmode
  endif

  if k_scale != k_prev_scale then
    if k_patmode > 1 then
      k_pat_need_gen = 1
    endif
    k_prev_scale = k_scale
  endif
  if k_root != k_prev_root then
    if k_patmode > 1 then
      k_pat_need_gen = 1
    endif
    k_prev_root = k_root
  endif

  if k_patmode == 1 && k_gen_active == 1 then
    k_gen_active = 0
  endif

  if k_patmode > 1 && k_pat_ready == 0 && k_gen_active == 0 then
    k_pat_need_gen = 1
  endif

  if k_pat_need_gen == 1 && k_patmode > 1 then
    k_gen_active = 1
    k_gen_step = 0
    k_gen_len = k_new_len
    k_pat_ready = 0
    k_pat_need_gen = 0
  endif

  ;==========================================================
  ; PATTERN GENERATION STATE MACHINE
  ;==========================================================
  if k_gen_active == 1 then

    k_gen_roll random 0, 1
    if k_gen_roll < k_dens then

      k_gdeg random 0, k_max_deg
      k_gdeg = int(k_gdeg)
      k_goct = int(k_gdeg / k_sc_len)
      k_gdeg_sc = k_gdeg - k_goct * k_sc_len
      k_gdeg_sc limit k_gdeg_sc, 0, k_sc_len - 1
      k_gsemi tablekt k_gdeg_sc, k_sc_tab
      k_gmidi = k_root + k_goct * 12 + k_gsemi

      k_goct_roll random 0, 1
      if k_goct_roll < k_octjump then
        k_gmidi = k_gmidi + 12
      endif
      k_gmidi limit k_gmidi, 24, 108

      k_gacc random 0, 1
      if k_gacc < k_accent then
        k_gvel = k_velmax
      else
        k_gvel random k_velmin, k_velmax
      endif

      k_wt_pn = gi_pat_note
      tablewkt k_gmidi, k_gen_step, k_wt_pn
      k_wt_pv = gi_pat_vel
      tablewkt k_gvel, k_gen_step, k_wt_pv

      k_gdbl random 0, 1
      if k_gdbl < 0.15 then
        k_gdeg2 random 0, k_max_deg
        k_gdeg2 = int(k_gdeg2)
        k_goct2 = int(k_gdeg2 / k_sc_len)
        k_gdeg2_sc = k_gdeg2 - k_goct2 * k_sc_len
        k_gdeg2_sc limit k_gdeg2_sc, 0, k_sc_len - 1
        k_gsemi2 tablekt k_gdeg2_sc, k_sc_tab
        k_gmidi2 = k_root + k_goct2 * 12 + k_gsemi2
        k_gmidi2 limit k_gmidi2, 24, 108
        k_wt_pd = gi_pat_dbl
        tablewkt k_gmidi2, k_gen_step, k_wt_pd
      else
        k_wt_pd = gi_pat_dbl
        tablewkt 0, k_gen_step, k_wt_pd
      endif

    else
      k_wt_pn = gi_pat_note
      tablewkt 0, k_gen_step, k_wt_pn
      k_wt_pv = gi_pat_vel
      tablewkt 0, k_gen_step, k_wt_pv
      k_wt_pd = gi_pat_dbl
      tablewkt 0, k_gen_step, k_wt_pd
    endif

    k_gen_step = k_gen_step + 1
    if k_gen_step >= k_gen_len then
      k_gen_active = 0
      k_pat_ready = 1
      k_pat_step = 0
      k_pat_rep = 0
      k_pat_len = k_gen_len
    endif

  endif

  ; --- Eighth-note metro with swing ---
  k_eighth = 60 / k_bpm / 2

  k_step init 0
  k_next_time init 0

  k_time timeinsts
  k_trig = 0

  if k_time >= k_next_time then
    k_trig = 1
    if k_step == 0 then
      k_next_time = k_time + k_eighth * (1 + k_swing)
    else
      k_next_time = k_time + k_eighth * (1 - k_swing)
    endif
    k_step = 1 - k_step
  endif

  ; --- Note generation (only when plk_play AND seq_play are on) ---
  if k_trig == 1 && k_play > 0.5 && k_plk_play > 0.5 then

    if k_patmode == 1 then
      ; FREE MODE
      k_roll random 0, 1
      if k_roll < k_dens then

        k_deg random 0, k_max_deg
        k_deg = int(k_deg)
        k_octave = int(k_deg / k_sc_len)
        k_degree_in_scale = k_deg - k_octave * k_sc_len
        k_degree_in_scale limit k_degree_in_scale, 0, k_sc_len - 1
        k_semi tablekt k_degree_in_scale, k_sc_tab
        k_midi_note = k_root + k_octave * 12 + k_semi

        k_oct_roll random 0, 1
        if k_oct_roll < k_octjump then
          k_midi_note = k_midi_note + 12
        endif
        k_midi_note limit k_midi_note, 24, 108
        k_freq = cpsmidinn(k_midi_note)

        k_acc_roll random 0, 1
        if k_acc_roll < k_accent then
          k_vel = k_velmax
        else
          k_vel random k_velmin, k_velmax
        endif

        k_pan random 0.2, 0.8

        k_active active 1
        if k_active < 8 then
          event "i", 1, 0, k_gate, k_freq, k_vel, k_pan
        endif

        k_dbl_roll random 0, 1
        if k_dbl_roll < 0.15 && k_active < 7 then
          k_deg2 random 0, k_max_deg
          k_deg2 = int(k_deg2)
          k_oct2 = int(k_deg2 / k_sc_len)
          k_deg2_sc = k_deg2 - k_oct2 * k_sc_len
          k_deg2_sc limit k_deg2_sc, 0, k_sc_len - 1
          k_semi2 tablekt k_deg2_sc, k_sc_tab
          k_midi2 = k_root + k_oct2 * 12 + k_semi2
          k_midi2 limit k_midi2, 24, 108
          k_freq2 = cpsmidinn(k_midi2)
          k_vel2 random k_velmin, k_velmax
          k_pan2 random 0.2, 0.8
          event "i", 1, k_eighth * 0.5, k_gate, k_freq2, k_vel2, k_pan2
        endif

      endif

    else
      ; PATTERN MODE
      if k_pat_ready == 1 then
        k_wt_pn = gi_pat_note
        k_p_midi tablekt k_pat_step, k_wt_pn

        if k_p_midi > 0 then
          k_p_freq = cpsmidinn(k_p_midi)
          k_wt_pv = gi_pat_vel
          k_p_vel tablekt k_pat_step, k_wt_pv
          k_p_pan random 0.2, 0.8

          k_active active 1
          if k_active < 8 then
            event "i", 1, 0, k_gate, k_p_freq, k_p_vel, k_p_pan
          endif

          k_wt_pd = gi_pat_dbl
          k_p_dbl tablekt k_pat_step, k_wt_pd
          if k_p_dbl > 0 && k_active < 7 then
            k_p_freq2 = cpsmidinn(k_p_dbl)
            k_p_vel2 random k_velmin, k_velmax
            k_p_pan2 random 0.2, 0.8
            event "i", 1, k_eighth * 0.5, k_gate, k_p_freq2, k_p_vel2, k_p_pan2
          endif
        endif

        k_pat_step = k_pat_step + 1
        if k_pat_step >= k_pat_len then
          k_pat_step = 0
          k_pat_rep = k_pat_rep + 1
          if k_pat_rep >= k_patrep then
            k_pat_rep = 0
            k_pat_need_gen = 1
            k_pat_ready = 0
          endif
        endif
      endif

    endif
  endif

endin


;==============================================================
; ROOT NOTE CAPTURE — instr 85
;==============================================================
instr 85

  inum notnum
  ; Map MIDI octave to register combobox: oct2→1, oct3→2, oct4→3, oct5→4
  i_oct = int(inum / 12)
  i_reg = i_oct - 1
  i_reg = (i_reg < 1) ? 1 : i_reg
  i_reg = (i_reg > 4) ? 4 : i_reg
  chnset k(i_reg), "seq_root"
  turnoff

endin


;==============================================================
; PRESET MANAGER — instr 95
;==============================================================
instr 95

  k_save chnget "preset_save"
  k_load chnget "preset_load"

  k_gui_refresh init 0
  k_gui_delay   init 0

  ; Auto-load last saved preset on startup
  i_exists filevalid "/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/composition-rig-preset.json"
  k_init init 0
  if k_init == 0 && i_exists == 1 then
    kOk = cabbageChannelStateRecall:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/composition-rig-preset.json")
    chnset k(0), "preset_save"
    printks "Auto-loaded preset from composition-rig-preset.json\\n", 0
    k_gui_refresh = 1
    k_init = 1
  elseif k_init == 0 then
    k_init = 1
  endif

  k_sv trigger k_save, 0.5, 0
  k_ld trigger k_load, 0.5, 0

  k_save_delay init -1

  if k_sv == 1 then
    $SYNC_WIDGET(cond_start_key)
    $SYNC_WIDGET(cond_dir)
    $SYNC_WIDGET(seq_scale)
    $SYNC_WIDGET(seq_root)
    $SYNC_WIDGET(seq_patmode)
    $SYNC_WIDGET(dly_div)
    k_save_delay = 2
  endif

  if k_save_delay > 0 then
    k_save_delay -= 1
  elseif k_save_delay == 0 then
    k_save_delay = -1
    kOk = cabbageChannelStateSave:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/composition-rig-preset.json")
    chnset k(0), "preset_save"
    printks "Preset saved to composition-rig-preset.json\\n", 0
  endif

  if k_ld == 1 then
    kOk = cabbageChannelStateRecall:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/composition-rig-preset.json")
    chnset k(0), "preset_load"
    chnset k(0), "preset_save"
    printks "Preset loaded from composition-rig-preset.json\\n", 0
    k_gui_refresh = 1
  endif

  ; --- GUI refresh ---
  if k_gui_refresh == 1 then
    k_gui_delay += 1
    if k_gui_delay >= 15 then
      k_gui_refresh = 0
      k_gui_delay   = 0

      ; Sync sequencer (swing/density/gate/range/octjump hard-coded)
      $SYNC_WIDGET(seq_bpm)
      $SYNC_WIDGET(seq_root)
      $SYNC_WIDGET(seq_scale)
      $SYNC_WIDGET(seq_patmode)
      $SYNC_WIDGET(seq_patrep)

      ; Sync instruments
      $SYNC_WIDGET(plk_play)
      $SYNC_WIDGET(plk_vol)
      $SYNC_WIDGET(plk_dly_send)
      $SYNC_WIDGET(plk_rvb_send)
      $SYNC_WIDGET(fm_play)
      $SYNC_WIDGET(fm_vol)
      $SYNC_WIDGET(fm_dly_send)
      $SYNC_WIDGET(fm_rvb_send)
      $SYNC_WIDGET(pad_play)
      $SYNC_WIDGET(pad_vol)
      $SYNC_WIDGET(pad_dly_send)
      $SYNC_WIDGET(pad_rvb_send)

      ; Sync effects
      $SYNC_WIDGET(dly_div)
      $SYNC_WIDGET(dly_fb)
      $SYNC_WIDGET(dly_mix)
      $SYNC_WIDGET(dly_mod)
      $SYNC_WIDGET(rvb_fb)
      $SYNC_WIDGET(rvb_cut)
      $SYNC_WIDGET(rvb_wet)
      $SYNC_WIDGET(master_vol)
      $SYNC_WIDGET(master_lpf)
      $SYNC_WIDGET(warmth)
      $SYNC_WIDGET(dly_rvb_send)
      $SYNC_WIDGET(seq_play)

      ; Sync conductor
      $SYNC_WIDGET(cond_start_key)
      $SYNC_WIDGET(cond_speed)
      $SYNC_WIDGET(cond_dir)
      $SYNC_WIDGET(cond_enabled)

      ; Rebuild weight table for recalled key + scale
      k_sk chnget "cond_start_key"
      k_sc chnget "seq_scale"
      event "i", 71, 0, 0.1, k_sk - 1, k_sc
    endif
  endif

endin


;==============================================================
; DELAY — instr 98 (Ping-Pong, BPM-synced)
;==============================================================
instr 98

  k_div      chnget "dly_div"
  k_bpm      chnget "seq_bpm"
  k_fb       chnget "dly_fb"
  k_mix      chnget "dly_mix"
  k_mod_dep  chnget "dly_mod"
  k_rvb_send chnget "dly_rvb_send"

  k_quarter = 60 / k_bpm

  k_time = k_quarter
  if k_div == 1 then
    k_time = k_quarter * 2
  elseif k_div == 3 then
    k_time = k_quarter * 0.75
  elseif k_div == 4 then
    k_time = k_quarter * 0.5
  elseif k_div == 5 then
    k_time = k_quarter * 0.25
  elseif k_div == 6 then
    k_time = k_quarter * 0.6667
  elseif k_div == 7 then
    k_time = k_quarter * 0.3333
  endif

  k_time limit k_time, 0.05, 1.95

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

  outs a_tap_L * k_mix, a_tap_R * k_mix

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
i 78 0  0.5          ; WAV loader (init then turnoff)
i 90 0  [60*60*4]    ; LFO modulator (hard-coded per-instrument)
i 70 0  [60*60*4]    ; conductor
i 76 0  [60*60*4]    ; drone controller
i 75 0  [60*60*4]    ; chord generator
i 80 0  [60*60*4]    ; sequencer
i 95 0  [60*60*4]    ; preset manager
i 98 0  [60*60*4]    ; delay
i 99 0  [60*60*4]    ; reverb
e
</CsScore>
</CsoundSynthesizer>
