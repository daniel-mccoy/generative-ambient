<Cabbage>
form caption("Circle-of-Fifths Rig — Harmonic Modulation Sequencer") size(820, 850), colour(30, 30, 50), pluginId("cofr"), guiMode("queue")

; Header
label bounds(10, 8, 800, 25) text("CIRCLE-OF-FIFTHS RIG") fontColour(120, 200, 150) fontSize(18) align("left")
label bounds(10, 32, 800, 18) text("Generative Ambient — Probabilistic Pluck Sequencer with Harmonic Modulation") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): SEQUENCER
;=====================================================================

; Timing
groupbox bounds(10, 60, 230, 130) text("TIMING") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 48, 48) channel("seq_bpm") range(40, 200, 80, 1, 1) text("BPM") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(62, 25, 48, 48) channel("seq_swing") range(0, 0.5, 0, 1, 0.01) text("Swing") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(114, 25, 48, 48) channel("seq_density") range(0, 1, 0.75, 1, 0.01) text("Density") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(166, 25, 48, 48) channel("seq_gate") range(0.1, 3, 3, 0.5, 0.01) text("Gate") textColour(200,200,220) trackerColour(120, 200, 150)
    label bounds(10, 80, 210, 30) text("BPM=tempo, Swing=shuffle, Density=note probability") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Pitch + Pattern
groupbox bounds(245, 60, 185, 130) text("PITCH") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 48, 48) channel("seq_root") range(24, 72, 48, 1, 1) text("Root") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(68, 25, 48, 48) channel("seq_range") range(0.5, 3, 1.5, 1, 0.1) text("Range") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(126, 25, 48, 48) channel("seq_octjump") range(0, 0.5, 0.2, 1, 0.01) text("OctJump") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(10, 82, 58, 18) channel("seq_patmode") value(1) text("Free", "1 Bar", "2 Bars", "4 Bars")
    label bounds(10, 102, 58, 12) text("Pattern") fontColour(140, 140, 160) fontSize(8) align("centre")
    rslider bounds(75, 76, 42, 42) channel("seq_patrep") range(1, 32, 8, 0.5, 1) text("Rep") textColour(200,200,220) trackerColour(120, 200, 150)
    label bounds(122, 84, 58, 25) text("times\nbefore new") fontColour(140, 140, 160) fontSize(7) align("left")
}

; Harmony (NEW — circle-of-fifths conductor controls)
groupbox bounds(435, 60, 375, 130) text("HARMONY") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 60, 20) channel("cond_start_key") value(1) text("C", "G", "D", "A", "E", "B", "F#", "C#", "Ab", "Eb", "Bb", "F")
    label bounds(10, 52, 60, 14) text("Key") fontColour(140, 140, 160) fontSize(9) align("centre")
    rslider bounds(80, 22, 48, 48) channel("cond_speed") range(0.5, 10, 3, 0.5, 0.1) text("Speed") textColour(200,200,220) trackerColour(200, 160, 255)
    label bounds(80, 72, 48, 14) text("minutes") fontColour(140, 140, 160) fontSize(8) align("centre")
    combobox bounds(140, 28, 70, 20) channel("cond_dir") value(1) text("Sharps", "Flats", "Random")
    label bounds(140, 52, 70, 14) text("Direction") fontColour(140, 140, 160) fontSize(9) align("centre")
    button bounds(220, 28, 50, 20) channel("cond_enabled") text("OFF", "ON") value(0) colour:0(60, 60, 80) colour:1(200, 160, 255) fontColour:0(180, 180, 200) fontColour:1(30, 30, 50)
    label bounds(220, 52, 50, 14) text("Mod") fontColour(140, 140, 160) fontSize(9) align("centre")
    button bounds(280, 28, 50, 20) channel("cond_manual") text("Next", "Next") value(0) colour:0(60, 60, 80) colour:1(120, 200, 150) fontColour:0(180, 180, 200) fontColour:1(30, 30, 50)
    label bounds(280, 52, 50, 14) text("Step") fontColour(140, 140, 160) fontSize(9) align("centre")
    label bounds(10, 90, 100, 18) channel("cond_key_lbl") text("Key: C") fontColour(200, 160, 255) fontSize(12) align("left")
    label bounds(120, 90, 150, 18) channel("cond_status") text("Idle") fontColour(180, 180, 200) fontSize(10) align("left")
    gentable bounds(280, 72, 85, 45) tableNumber(100) tableColour(200, 160, 255) tableBackgroundColour(30, 30, 50) ampRange(0, 1.1, 100) identChannel("cond_gt_ident")
}

; Dynamics
groupbox bounds(10, 200, 295, 95) text("DYNAMICS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("seq_velmin") range(0.1, 1, 0.3, 1, 0.01) text("Vel Min") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(72, 25, 55, 55) channel("seq_velmax") range(0.1, 1, 0.8, 1, 0.01) text("Vel Max") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(134, 25, 55, 55) channel("seq_accent") range(0, 1, 0.3, 1, 0.01) text("Accent") textColour(200,200,220) trackerColour(120, 200, 150)
    label bounds(10, 80, 280, 12) text("Random velocity range. Accent = probability of max hit.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=305): SYNTH
;=====================================================================

; Oscillator
groupbox bounds(315, 200, 180, 95) text("OSCILLATOR") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 48, 48) channel("osc_shape") range(0, 1, 0.43, 1, 0.01) text("Shape") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(65, 25, 48, 48) channel("osc_detune") range(0, 10, 3, 1, 0.1) text("Detune") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(120, 25, 48, 48) channel("osc_sub") range(0, 1, 0.2, 1, 0.01) text("Sub") textColour(200,200,220) trackerColour(224, 160, 80)
}

; Filter
groupbox bounds(500, 200, 310, 95) text("FILTER + AMP") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 25, 40, 40) channel("filt_cutoff") range(200, 12000, 313, 0.3, 1) text("Cut") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(48, 25, 40, 40) channel("filt_reso") range(0, 0.9, 0, 1, 0.01) text("Res") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(91, 25, 40, 40) channel("filt_envamt") range(0, 1, 0.5, 1, 0.01) text("Env") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(134, 25, 40, 40) channel("filt_decay") range(0.1, 5, 1.69, 0.5, 0.01) text("F.Dec") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(184, 25, 40, 40) channel("amp_a") range(0.001, 0.5, 0.005, 0.3, 0.001) text("Atk") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(227, 25, 40, 40) channel("amp_d") range(0.1, 8, 2.67, 0.3, 0.01) text("Dec") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(270, 25, 40, 40) channel("amp_s") range(0, 0.5, 0, 1, 0.01) text("Sus") textColour(200,200,220) trackerColour(224, 122, 95)
}

;=====================================================================
; ROW 3 (y=305): MODULATION — 4 LFOs
;=====================================================================

groupbox bounds(10, 305, 800, 170) text("MODULATION") colour(35, 35, 55) fontColour(200, 200, 220) {

    ; LFO 1
    label bounds(15, 22, 180, 14) text("LFO 1") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(15, 38, 45, 45) channel("lfo1_freq") range(0.01, 10, 0.1, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(62, 38, 45, 45) channel("lfo1_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(112, 40, 78, 20) channel("lfo1_wave") value(1) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(112, 64, 78, 20) channel("lfo1_target") value(1) text("None", "Cutoff", "Reso", "Shape", "Density", "Range", "Gate", "Volume")
    hslider bounds(15, 90, 175, 12) channel("lfo1_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; LFO 2
    label bounds(210, 22, 180, 14) text("LFO 2") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(210, 38, 45, 45) channel("lfo2_freq") range(0.01, 10, 0.07, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(257, 38, 45, 45) channel("lfo2_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(307, 40, 78, 20) channel("lfo2_wave") value(2) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(307, 64, 78, 20) channel("lfo2_target") value(1) text("None", "Cutoff", "Reso", "Shape", "Density", "Range", "Gate", "Volume")
    hslider bounds(210, 90, 175, 12) channel("lfo2_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; LFO 3
    label bounds(405, 22, 180, 14) text("LFO 3") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(405, 38, 45, 45) channel("lfo3_freq") range(0.01, 10, 0.05, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(452, 38, 45, 45) channel("lfo3_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(502, 40, 78, 20) channel("lfo3_wave") value(4) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(502, 64, 78, 20) channel("lfo3_target") value(1) text("None", "Cutoff", "Reso", "Shape", "Density", "Range", "Gate", "Volume")
    hslider bounds(405, 90, 175, 12) channel("lfo3_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; LFO 4
    label bounds(600, 22, 190, 14) text("LFO 4") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(600, 38, 45, 45) channel("lfo4_freq") range(0.01, 10, 0.15, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(647, 38, 45, 45) channel("lfo4_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(697, 40, 78, 20) channel("lfo4_wave") value(6) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(697, 64, 78, 20) channel("lfo4_target") value(1) text("None", "Cutoff", "Reso", "Shape", "Density", "Range", "Gate", "Volume")
    hslider bounds(600, 90, 175, 12) channel("lfo4_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; Hint
    label bounds(15, 108, 780, 40) text("Amp starts at 0 (off). Pick a Wave shape and Target, then raise Amp. Green bars show LFO output.") fontColour(130, 130, 150) fontSize(10) align("left")
}

;=====================================================================
; ROW 4 (y=485): EFFECTS + MASTER
;=====================================================================

; Delay
groupbox bounds(10, 485, 220, 135) text("DELAY") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(5, 30, 45, 20) channel("dly_div") value(3) text("1/2", "1/4", "D.1/8", "1/8", "1/16", "T.1/4", "T.1/8")
    rslider bounds(55, 28, 48, 48) channel("dly_fb") range(0, 0.9, 0.55, 1, 0.01) text("FB") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(105, 28, 48, 48) channel("dly_mix") range(0, 1, 0.4, 1, 0.01) text("Mix") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(155, 28, 48, 48) channel("dly_mod") range(0, 0.02, 0.003, 0.5, 0.001) text("Mod") textColour(200,200,220) trackerColour(100, 180, 224)
    label bounds(5, 55, 45, 14) text("Div") fontColour(140, 140, 160) fontSize(9) align("centre")
    label bounds(5, 85, 210, 30) text("BPM-synced ping-pong delay") fontColour(140, 140, 160) fontSize(10) align("left")
}

; Reverb
groupbox bounds(235, 485, 185, 135) text("REVERB") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 28, 50, 50) channel("rvb_fb") range(0.3, 0.99, 0.88, 1, 0.01) text("Size") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(60, 28, 50, 50) channel("rvb_cut") range(1000, 14000, 7000, 0.4, 1) text("Tone") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(115, 28, 50, 50) channel("rvb_wet") range(0, 1, 0.5, 1, 0.01) text("Wet") textColour(200,200,220) trackerColour(100, 180, 224)
    label bounds(5, 88, 175, 25) text("reverbsc hall") fontColour(140, 140, 160) fontSize(10) align("left")
}

; Master
groupbox bounds(425, 485, 200, 135) text("MASTER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 28, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(72, 28, 55, 55) channel("master_lpf") range(200, 16000, 12000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(134, 28, 55, 55) channel("warmth") range(0, 1, 0.3, 1, 0.01) text("Warmth") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 93, 185, 25) text("Volume, filter, saturation") fontColour(140, 140, 160) fontSize(10) align("left")
}

; Sends
groupbox bounds(630, 485, 180, 135) text("SENDS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 28, 50, 50) channel("dly_send") range(0, 1, 0.5, 1, 0.01) text("Delay") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(65, 28, 50, 50) channel("rvb_send") range(0, 1, 0.45, 1, 0.01) text("Reverb") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(120, 28, 50, 50) channel("dly_rvb_send") range(0, 1, 0.2, 1, 0.01) text("Dly>Rvb") textColour(200,200,220) trackerColour(150, 150, 200)
    label bounds(10, 88, 170, 25) text("Effect send levels") fontColour(140, 140, 160) fontSize(10) align("left")
}

;=====================================================================
; ROW 5 (y=630): TRANSPORT
;=====================================================================

button bounds(10, 635, 100, 55) channel("seq_play") text("PLAY", "STOP") value(1) colour:0(60, 60, 80) colour:1(120, 200, 150) fontColour:0(180, 180, 200) fontColour:1(30, 30, 50)
label bounds(120, 640, 400, 18) text("Sequencer auto-plays on start. Toggle to stop/start note generation.") fontColour(140, 140, 160) fontSize(10) align("left")
label bounds(120, 660, 400, 18) channel("seq_status") text("Playing...") fontColour(120, 200, 150) fontSize(11) align("left")

button bounds(630, 635, 85, 30) channel("preset_save") text("Save", "Save") value(0) colour:0(50, 50, 70) colour:1(100, 180, 224) fontColour:0(180, 180, 200) fontColour:1(255, 255, 255)
button bounds(720, 635, 85, 30) channel("preset_load") text("Load", "Load") value(0) colour:0(50, 50, 70) colour:1(100, 180, 224) fontColour:0(180, 180, 200) fontColour:1(255, 255, 255)
label bounds(630, 668, 175, 16) text("Save/load preset to JSON") fontColour(140, 140, 160) fontSize(9) align("centre")

;=====================================================================
; ROW 6 (y=695): ROOT NOTE KEYBOARD
;=====================================================================

keyboard bounds(10, 695, 800, 75)
label bounds(10, 773, 400, 14) text("Click a key to set the sequencer root note") fontColour(140, 140, 160) fontSize(9) align("left")

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

; Sine table for oscili (explicit number to avoid collision with 100-102)
gi_sine ftgen 1, 0, 8192, 10, 1

;=====================================================================
; CIRCLE-OF-FIFTHS DATA TABLES
;=====================================================================

; Chromatic weight table: 12 slots (C=0 .. B=11), 1.0 = in scale, 0.0 = out
; Initialized to C major: C D E F G A B = indices 0,2,4,5,7,9,11
gi_weights ftgen 100, 0, -12, -2, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1

; Major scale intervals (semitones from root): 0 2 4 5 7 9 11
gi_major_intervals ftgen 101, 0, -7, -2, 0, 2, 4, 5, 7, 9, 11

; Circle-of-fifths pitch classes: C G D A E B F# C# Ab Eb Bb F
gi_cof_pc ftgen 102, 0, -12, -2, 0, 7, 2, 9, 4, 11, 6, 1, 8, 3, 10, 5

;=====================================================================
; PATTERN TABLES (for pattern repeat mode)
; Max 32 steps = 4 bars x 8 eighth notes
;=====================================================================
gi_pat_note ftgen 103, 0, -32, -2, 0  ; MIDI note per step (0 = rest)
gi_pat_vel  ftgen 104, 0, -32, -2, 0  ; velocity per step
gi_pat_dbl  ftgen 105, 0, -32, -2, 0  ; double-trigger MIDI note (0 = none)


;=====================================================================
; GLOBAL SEND BUSES
;=====================================================================
ga_rvb_L init 0
ga_rvb_R init 0
ga_dly_L init 0
ga_dly_R init 0

;=====================================================================
; GLOBAL MODULATION ACCUMULATORS (pluck targets)
; Reset each k-cycle by instr 90. LFOs add here.
;=====================================================================
gk_mod_cutoff   init 0
gk_mod_reso     init 0
gk_mod_shape    init 0
gk_mod_density  init 0
gk_mod_range    init 0
gk_mod_gate     init 0
gk_mod_vol      init 0


;==============================================================
; SYNC MACROS — Force widget visual update after preset recall.
; guiMode("queue") means chnset alone doesn't update visuals.
; Read channel back -> cabbageSetValue to push to GUI queue.
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
; UDO: LFOWave — Multi-waveform LFO with k-rate shape select
;
; ktype: 1=sine, 2=tri, 3=saw-up, 4=saw-down, 5=square, 6=S&H, 7=wander
; Output range: -kamp .. +kamp
;==============================================================
opcode LFOWave, k, kkk
  kamp, kfreq, ktype xin

  k_phs phasor kfreq

  ; Compute all waveforms from phasor (bipolar -1..+1)
  k_sine  = sin(k_phs * 2 * 3.14159265)
  k_tri   = 1 - 4 * abs(k_phs - 0.5)
  k_sawup = 2 * k_phs - 1
  k_sawdn = 1 - 2 * k_phs
  k_sqr   = (k_phs < 0.5) ? 1 : -1

  ; S&H: latch a new random value each cycle
  k_sh     init 0
  k_prev   init 1
  if k_phs < k_prev then
    k_sh random -1, 1
  endif
  k_prev = k_phs

  ; Wander: two randi at irrational ratio for smooth non-repeating motion
  k_w1 randi 1, kfreq
  k_w2 randi 0.5, kfreq * 0.4286
  k_wander = (k_w1 + k_w2) / 1.5

  ; Select waveform
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
; UDO: LFORoutePluck — Route a modulation value to a pluck target
;
; ktgt: combobox value (1=None, 2=Cutoff, 3=Reso, 4=Shape,
;        5=Density, 6=Range, 7=Gate, 8=Volume)
;==============================================================
opcode LFORoutePluck, 0, kk
  ktgt, kval xin

  if ktgt == 2 then
    gk_mod_cutoff = gk_mod_cutoff + kval * 4000
  elseif ktgt == 3 then
    gk_mod_reso = gk_mod_reso + kval * 0.3
  elseif ktgt == 4 then
    gk_mod_shape = gk_mod_shape + kval * 0.3
  elseif ktgt == 5 then
    gk_mod_density = gk_mod_density + kval * 0.3
  elseif ktgt == 6 then
    gk_mod_range = gk_mod_range + kval * 1
  elseif ktgt == 7 then
    gk_mod_gate = gk_mod_gate + kval * 1
  elseif ktgt == 8 then
    gk_mod_vol = gk_mod_vol + kval * 0.3
  endif

endop


;==============================================================
; UDO: WeightedPC — Pick weighted random pitch class from gi_weights
;
; Reads 12 chromatic weights, computes cumulative sums,
; selects weighted random pitch class 0-11.
; Returns -1 if all weights are 0.
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
;
; Takes pitch class (0-11), root MIDI note, range (octaves),
; and octave jump probability. Returns MIDI note 24-108.
;==============================================================
opcode PCtoMIDI, k, kkkk
  kpc, kroot, krange, koctjump xin

  k_root_oct = int(kroot / 12)
  k_root_pc  = kroot % 12

  k_midi = k_root_oct * 12 + kpc
  if kpc < k_root_pc then
    k_midi = k_midi + 12
  endif

  ; Octave spread
  k_range_oct = int(krange)
  if k_range_oct > 0 then
    k_oct_rnd random 0, k_range_oct + 0.999
    k_midi = k_midi + int(k_oct_rnd) * 12
  endif

  ; Octave jump
  k_oct_roll random 0, 1
  if k_oct_roll < koctjump then
    k_midi = k_midi + 12
  endif

  k_midi limit k_midi, 24, 108

  xout k_midi
endop


;==============================================================
; PLUCK VOICE — instr 1 (event-triggered, polyphonic)
;
; Saw+Square blend with moogladder filter, squared-linseg
; envelopes for amp and mod (filter). Adapted from gen_pulse.
;
; p4 = frequency (Hz)
; p5 = velocity (0-1)
; p6 = pan (0-1)
;==============================================================
instr 1

  ifreq = p4
  ivel  = p5
  ipan  = p6

  ; --- Read oscillator parameters ---
  k_shape_b  chnget "osc_shape"
  k_detune   chnget "osc_detune"
  k_sub_lvl  chnget "osc_sub"

  ; --- Read filter parameters ---
  k_cut_base   chnget "filt_cutoff"
  k_reso_base  chnget "filt_reso"
  k_envamt     chnget "filt_envamt"
  i_filt_dec   chnget "filt_decay"

  ; --- Read amp envelope parameters ---
  i_amp_a    chnget "amp_a"
  i_amp_d    chnget "amp_d"
  i_amp_s    chnget "amp_s"

  ; --- Read master / send parameters ---
  k_vol_base   chnget "master_vol"
  k_lpf        chnget "master_lpf"
  k_warmth     chnget "warmth"
  k_dly_send   chnget "dly_send"
  k_rvb_send   chnget "rvb_send"

  ; --- Apply LFO modulation ---
  k_shape = k_shape_b + gk_mod_shape
  k_cut   = k_cut_base + gk_mod_cutoff
  k_reso  = k_reso_base + gk_mod_reso
  k_vol   = k_vol_base + gk_mod_vol

  ; --- Clamp modulated parameters ---
  k_shape limit k_shape, 0, 1
  k_cut   limit k_cut, 200, 12000
  k_reso  limit k_reso, 0, 0.9
  k_vol   limit k_vol, 0, 1

  ; --- Amp envelope (squared linseg for exponential shape) ---
  ; Attack -> peak, decay -> sustain, hold sustain for gate duration
  i_hold = p3 - i_amp_a - i_amp_d
  i_hold = (i_hold < 0.01) ? 0.01 : i_hold
  k_aenv linseg 0, i_amp_a, 1, i_amp_d, i_amp_s, i_hold, i_amp_s
  k_aenv = k_aenv * k_aenv    ; squared for exponential shape

  ; --- Mod envelope (filter) ---
  ; 5ms attack, decay to 0 over F.Decay time
  i_mod_hold = p3 - 0.005 - i_filt_dec
  i_mod_hold = (i_mod_hold < 0.001) ? 0.001 : i_mod_hold
  k_menv linseg 0, 0.005, 1, i_filt_dec, 0, i_mod_hold, 0
  k_menv = k_menv * k_menv    ; squared for exponential shape

  ; --- Oscillators ---
  ; Saw (vco2 mode 0)
  a_saw vco2 1, ifreq, 0

  ; Square (vco2 mode 10)
  a_sqr vco2 1, ifreq, 10, 0.5

  ; Blend saw/square by shape
  a_osc = a_saw * (1 - k_shape) + a_sqr * k_shape

  ; Detuned second saw for richness
  k_det_hz = ifreq * (k_detune * 0.01 / 12)
  a_saw2 vco2 0.5, ifreq + k_det_hz, 0
  a_osc = a_osc + a_saw2

  ; Sub oscillator (sine, -1 octave)
  a_sub oscili k_sub_lvl, ifreq * 0.5, gi_sine
  a_osc = a_osc + a_sub

  ; --- Filter ---
  ; Velocity-driven brightness: higher velocity opens filter
  k_vel_bright = ivel * 2000
  k_filt_cut = k_cut + k_menv * k_envamt * 8000 + k_vel_bright
  k_filt_cut limit k_filt_cut, 60, 18000

  a_filt moogladder a_osc, k_filt_cut, k_reso

  ; --- Apply amp envelope + velocity ---
  a_out = a_filt * k_aenv * ivel * 0.18

  ; --- Warmth: saturation + low shelf boost ---
  if k_warmth > 0.01 then
    a_out = tanh(a_out * (1 + k_warmth * 2))
    a_low butterlp a_out, 200
    a_out = a_out + a_low * k_warmth * 0.4
  endif

  ; --- Master low pass filter ---
  a_out butterlp a_out, k_lpf

  ; --- Stereo from p6 pan ---
  aL = a_out * (1 - ipan)
  aR = a_out * ipan

  ; --- Master volume + soft clip ---
  aL = tanh(aL * k_vol)
  aR = tanh(aR * k_vol)

  ; --- DC block ---
  aL dcblock aL
  aR dcblock aR

  ; --- Dry/wet split for delay ---
  k_dly_mix  chnget "dly_mix"
  outs aL * (1 - k_dly_mix), aR * (1 - k_dly_mix)

  ; --- Send to effects buses ---
  ga_dly_L = ga_dly_L + aL * k_dly_send
  ga_dly_R = ga_dly_R + aR * k_dly_send
  ga_rvb_L = ga_rvb_L + aL * k_rvb_send
  ga_rvb_R = ga_rvb_R + aR * k_rvb_send

endin


;==============================================================
; CONDUCTOR — instr 70
;
; Circle-of-fifths harmonic modulation engine.
; Crossfades exactly 1 pitch class weight out and 1 in per step.
; CW (sharps):  outgoing = (root_pc + 5) % 12, incoming = (root_pc + 6) % 12
; CCW (flats):  outgoing = (root_pc + 11) % 12, incoming = (root_pc + 10) % 12
;==============================================================
instr 70

  ; Key name lookup (Csound 6 doesn't have string arrays, use sprintfk)
  ; CoF positions: 0=C 1=G 2=D 3=A 4=E 5=B 6=F# 7=C# 8=Ab 9=Eb 10=Bb 11=F

  ; --- Read GUI parameters ---
  k_start_key chnget "cond_start_key"  ; combobox 1-12
  k_speed     chnget "cond_speed"      ; minutes per modulation
  k_dir_sel   chnget "cond_dir"        ; 1=Sharps(CW), 2=Flats(CCW), 3=Random
  k_enabled   chnget "cond_enabled"    ; 0=off, 1=on
  k_manual    chnget "cond_manual"     ; button trigger

  ; --- State ---
  k_cof_pos     init 0     ; current position in circle (0-11)
  k_xfade       init 0     ; crossfade progress 0..1
  k_active      init 0     ; 1 = crossfade in progress
  k_pc_out      init 0     ; pitch class fading out
  k_pc_in       init 0     ; pitch class fading in
  k_direction   init 1     ; +1 = CW (sharps), -1 = CCW (flats)
  k_prev_key    init 1     ; previous start key combobox value (detect change)
  k_initialized init 0

  ; --- Initialize on first k-cycle ---
  if k_initialized == 0 then
    k_cof_pos = k_start_key - 1
    k_prev_key = k_start_key
    k_initialized = 1
    ; Build initial weight table
    event "i", 71, 0, 0.1, k_cof_pos
  endif

  ; --- Detect start key change from GUI ---
  if k_start_key != k_prev_key then
    k_cof_pos = k_start_key - 1
    k_prev_key = k_start_key
    k_xfade = 0
    k_active = 0
    ; Rebuild weight table for new key
    event "i", 71, 0, 0.1, k_cof_pos
  endif

  ; --- Manual "Next" button ---
  k_man_trig trigger k_manual, 0.5, 0
  if k_man_trig == 1 then
    chnset k(0), "cond_manual"
    ; Start a crossfade if not already active
    if k_active == 0 then
      ; Determine direction
      if k_dir_sel == 1 then
        k_direction = 1
      elseif k_dir_sel == 2 then
        k_direction = -1
      else
        ; Random: coin flip
        k_coin random 0, 1
        k_direction = (k_coin < 0.5) ? 1 : -1
      endif

      ; Get current root pitch class from CoF table
      k_wt_cof = gi_cof_pc
      k_root_pc tablekt k_cof_pos, k_wt_cof

      ; Compute outgoing/incoming pitch classes
      if k_direction == 1 then
        ; CW (sharps): sharp the 4th degree
        k_pc_out = (k_root_pc + 5) % 12
        k_pc_in  = (k_root_pc + 6) % 12
      else
        ; CCW (flats): flat the 7th degree
        k_pc_out = (k_root_pc + 11) % 12
        k_pc_in  = (k_root_pc + 10) % 12
      endif

      k_xfade = 0
      k_active = 1
    endif
  endif

  ; --- Auto-modulation when enabled ---
  if k_enabled > 0.5 && k_active == 0 then
    ; Determine direction
    if k_dir_sel == 1 then
      k_direction = 1
    elseif k_dir_sel == 2 then
      k_direction = -1
    else
      k_coin random 0, 1
      k_direction = (k_coin < 0.5) ? 1 : -1
    endif

    ; Get current root pitch class from CoF table
    k_wt_cof = gi_cof_pc
    k_root_pc tablekt k_cof_pos, k_wt_cof

    ; Compute outgoing/incoming pitch classes
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
    ; Increment crossfade
    k_inc = (ksmps / sr) / (k_speed * 60)
    k_xfade = k_xfade + k_inc

    if k_xfade >= 1 then
      k_xfade = 1
      k_active = 0

      ; Advance position in circle of fifths
      k_cof_pos = (k_cof_pos + k_direction + 12) % 12
    endif

    ; Write weights to table (crossfade the two changing pitch classes)
    k_wt = gi_weights
    tablewkt (1 - k_xfade), k_pc_out, k_wt
    tablewkt k_xfade, k_pc_in, k_wt
  endif

  ; --- GUI label updates (throttled to ~5 Hz) ---
  k_gui_metro metro 5
  if k_gui_metro == 1 then

    ; Current key name label
    ; Look up CoF position -> key name via sprintfk
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

    ; Status label
    if k_active == 1 then
      ; Compute target key name
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

    ; Refresh gentable display
    cabbageSet "cond_gt_ident", {{tableNumber(100)}}
  endif

endin


;==============================================================
; KEY RESET — instr 71
;
; Rebuilds the weight table for a given circle-of-fifths position.
; p4 = CoF position (0-11)
; Runs at i-time only, then turns off.
;==============================================================
instr 71

  i_cof_pos = int(p4)

  ; Get root pitch class from CoF table
  i_root_pc tab_i i_cof_pos, gi_cof_pc

  ; Clear all 12 weights to 0
  i_idx = 0
loop_clear:
  tabw_i 0, i_idx, gi_weights
  i_idx = i_idx + 1
  if i_idx < 12 igoto loop_clear

  ; Set major scale degrees to 1
  i_deg = 0
loop_set:
  i_interval tab_i i_deg, gi_major_intervals
  i_pc = (i_root_pc + i_interval) % 12
  tabw_i 1, i_pc, gi_weights
  i_deg = i_deg + 1
  if i_deg < 7 igoto loop_set

  turnoff

endin


;==============================================================
; SEQUENCER — instr 80
;
; Probabilistic note generator with weighted random pitch selection.
; Two modes:
;   Free  — random note each trigger (original behavior)
;   Pattern — generate a fixed pattern, repeat N times, regenerate
;
; Reads chromatic weight table (gi_weights) for scale-aware
; note picking. Uses WeightedPC and PCtoMIDI UDOs.
;==============================================================
instr 80

  ; --- Read sequencer parameters ---
  k_play    chnget "seq_play"
  k_bpm     chnget "seq_bpm"
  k_swing   chnget "seq_swing"
  k_dens_b  chnget "seq_density"
  k_gate_b  chnget "seq_gate"
  k_root    chnget "seq_root"
  k_range_b chnget "seq_range"
  k_octjump chnget "seq_octjump"
  k_velmin  chnget "seq_velmin"
  k_velmax  chnget "seq_velmax"
  k_accent  chnget "seq_accent"

  ; --- Pattern mode parameters ---
  k_patmode chnget "seq_patmode"   ; 1=Free, 2=1bar, 3=2bars, 4=4bars
  k_patrep  chnget "seq_patrep"   ; repeat count before regeneration

  ; --- Apply LFO modulation ---
  k_dens  = k_dens_b + gk_mod_density
  k_range = k_range_b + gk_mod_range
  k_gate  = k_gate_b + gk_mod_gate

  ; --- Clamp modulated parameters ---
  k_dens  limit k_dens, 0, 1
  k_range limit k_range, 0.5, 4
  k_gate  limit k_gate, 0.05, 5

  ; --- Status display ---
  if k_play > 0.5 then
    chnset k_play, "seq_status_val"
  endif

  ;==========================================================
  ; PATTERN STATE
  ;==========================================================
  k_pat_step     init 0    ; current step within pattern
  k_pat_rep      init 0    ; current repeat count
  k_pat_len      init 8    ; pattern length in steps
  k_pat_ready    init 0    ; 1 = pattern valid for playback
  k_pat_need_gen init 0    ; 1 = regeneration requested
  k_gen_active   init 0    ; 1 = generating (one step per k-cycle)
  k_gen_step     init 0    ; current generation step index
  k_gen_len      init 8    ; generation target length
  k_prev_patmode init 1    ; detect mode changes
  k_prev_sk      init -1   ; detect start key changes

  ; --- Calculate pattern length in steps (8 eighths per bar) ---
  k_new_len = 8
  if k_patmode == 3 then
    k_new_len = 16
  elseif k_patmode == 4 then
    k_new_len = 32
  endif

  ; --- Detect mode change -> regenerate ---
  if k_patmode != k_prev_patmode then
    k_pat_need_gen = 1
    k_pat_ready = 0
    k_prev_patmode = k_patmode
  endif

  ; --- Detect start key change -> regenerate ---
  k_sk chnget "cond_start_key"
  if k_prev_sk < 0 then
    k_prev_sk = k_sk
  endif
  if k_sk != k_prev_sk then
    if k_patmode > 1 then
      k_pat_need_gen = 1
    endif
    k_prev_sk = k_sk
  endif

  ; --- Stop generation if switched to free mode ---
  if k_patmode == 1 && k_gen_active == 1 then
    k_gen_active = 0
  endif

  ; --- Request initial generation for pattern mode ---
  if k_patmode > 1 && k_pat_ready == 0 && k_gen_active == 0 then
    k_pat_need_gen = 1
  endif

  ; --- Start generation if requested ---
  if k_pat_need_gen == 1 && k_patmode > 1 then
    k_gen_active = 1
    k_gen_step = 0
    k_gen_len = k_new_len
    k_pat_ready = 0
    k_pat_need_gen = 0
  endif

  ;==========================================================
  ; PATTERN GENERATION STATE MACHINE (one step per k-cycle)
  ;==========================================================
  if k_gen_active == 1 then

    ; Density check for this step
    k_gen_roll random 0, 1
    if k_gen_roll < k_dens then

      ; Pick weighted random pitch class
      k_gpc WeightedPC
      if k_gpc >= 0 then
        ; Convert to MIDI note
        k_gmidi PCtoMIDI k_gpc, k_root, k_range, k_octjump

        ; Velocity
        k_gen_acc random 0, 1
        if k_gen_acc < k_accent then
          k_gvel = k_velmax
        else
          k_gvel random k_velmin, k_velmax
        endif

        ; Store note and velocity
        k_wt_pn = gi_pat_note
        tablewkt k_gmidi, k_gen_step, k_wt_pn
        k_wt_pv = gi_pat_vel
        tablewkt k_gvel, k_gen_step, k_wt_pv

        ; Double trigger (15%)
        k_gen_dbl random 0, 1
        if k_gen_dbl < 0.15 then
          k_gpc2 WeightedPC
          if k_gpc2 >= 0 then
            k_gmidi2 PCtoMIDI k_gpc2, k_root, k_range, 0
            k_wt_pd = gi_pat_dbl
            tablewkt k_gmidi2, k_gen_step, k_wt_pd
          else
            k_wt_pd = gi_pat_dbl
            tablewkt 0, k_gen_step, k_wt_pd
          endif
        else
          k_wt_pd = gi_pat_dbl
          tablewkt 0, k_gen_step, k_wt_pd
        endif

      else
        ; All weights zero — rest
        k_wt_pn = gi_pat_note
        tablewkt 0, k_gen_step, k_wt_pn
        k_wt_pv = gi_pat_vel
        tablewkt 0, k_gen_step, k_wt_pv
        k_wt_pd = gi_pat_dbl
        tablewkt 0, k_gen_step, k_wt_pd
      endif

    else
      ; Rest step (density miss)
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

  ; Step counter for swing (0=on-beat, 1=off-beat)
  k_step init 0
  k_next_time init 0

  ; Time-based metro for swing support
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

  ; --- Note generation ---
  if k_trig == 1 && k_play > 0.5 then

    if k_patmode == 1 then
      ;==========================================================
      ; FREE MODE — random note each trigger (original behavior)
      ;==========================================================

      ; Roll against density
      k_roll random 0, 1
      if k_roll < k_dens then

        k_pc WeightedPC
        if k_pc >= 0 then
          k_midi_note PCtoMIDI k_pc, k_root, k_range, k_octjump
          k_freq = cpsmidinn(k_midi_note)

          ; Velocity
          k_acc_roll random 0, 1
          if k_acc_roll < k_accent then
            k_vel = k_velmax
          else
            k_vel random k_velmin, k_velmax
          endif

          ; Pan
          k_pan random 0.2, 0.8

          ; Polyphony check
          k_active active 1
          if k_active < 8 then
            event "i", 1, 0, k_gate, k_freq, k_vel, k_pan
          endif

          ; Double trigger (15%)
          k_dbl_roll random 0, 1
          if k_dbl_roll < 0.15 && k_active < 7 then
            k_pc2 WeightedPC
            if k_pc2 >= 0 then
              k_midi2 PCtoMIDI k_pc2, k_root, k_range, 0
              k_freq2 = cpsmidinn(k_midi2)
              k_vel2 random k_velmin, k_velmax
              k_pan2 random 0.2, 0.8
              event "i", 1, k_eighth * 0.5, k_gate, k_freq2, k_vel2, k_pan2
            endif
          endif

        endif ; k_pc >= 0
      endif ; density check

    else
      ;==========================================================
      ; PATTERN MODE — play from pre-generated table
      ;==========================================================

      if k_pat_ready == 1 then
        ; Read note from pattern table
        k_wt_pn = gi_pat_note
        k_p_midi tablekt k_pat_step, k_wt_pn

        if k_p_midi > 0 then
          k_p_freq = cpsmidinn(k_p_midi)

          ; Read velocity from pattern table
          k_wt_pv = gi_pat_vel
          k_p_vel tablekt k_pat_step, k_wt_pv

          ; Pan (fresh each playback for spatial variation)
          k_p_pan random 0.2, 0.8

          ; Polyphony check
          k_active active 1
          if k_active < 8 then
            event "i", 1, 0, k_gate, k_p_freq, k_p_vel, k_p_pan
          endif

          ; Check for double trigger
          k_wt_pd = gi_pat_dbl
          k_p_dbl tablekt k_pat_step, k_wt_pd
          if k_p_dbl > 0 && k_active < 7 then
            k_p_freq2 = cpsmidinn(k_p_dbl)
            k_p_vel2 random k_velmin, k_velmax
            k_p_pan2 random 0.2, 0.8
            event "i", 1, k_eighth * 0.5, k_gate, k_p_freq2, k_p_vel2, k_p_pan2
          endif
        endif

        ; Advance step
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
      endif ; pat_ready

    endif ; patmode check
  endif ; trig + play check

endin


;==============================================================
; ROOT NOTE CAPTURE — instr 85
;
; Receives MIDI from keyboard widget, sets seq_root channel,
; then immediately turns off. Only note-on matters.
;==============================================================
instr 85

  inum notnum
  chnset k(inum), "seq_root"
  turnoff

endin


;==============================================================
; MODULATOR — instr 90
;
; 4 LFOs with selectable waveform and routable target.
; Each LFO: Freq, Amp, Wave (dropdown), Target (dropdown).
; Amp defaults to 0 = off. Raise to activate.
;==============================================================
instr 90

  ; --- Reset all mod accumulators ---
  gk_mod_cutoff  = 0
  gk_mod_reso    = 0
  gk_mod_shape   = 0
  gk_mod_density = 0
  gk_mod_range   = 0
  gk_mod_gate    = 0
  gk_mod_vol     = 0

  ; --- LFO 1 ---
  k_frq1  chnget "lfo1_freq"
  k_amp1  chnget "lfo1_amp"
  k_wav1  chnget "lfo1_wave"
  k_tgt1  chnget "lfo1_target"
  k_val1  LFOWave k_amp1, k_frq1, k_wav1
  LFORoutePluck k_tgt1, k_val1
  cabbageSetValue "lfo1_out", k_val1

  ; --- LFO 2 ---
  k_frq2  chnget "lfo2_freq"
  k_amp2  chnget "lfo2_amp"
  k_wav2  chnget "lfo2_wave"
  k_tgt2  chnget "lfo2_target"
  k_val2  LFOWave k_amp2, k_frq2, k_wav2
  LFORoutePluck k_tgt2, k_val2
  cabbageSetValue "lfo2_out", k_val2

  ; --- LFO 3 ---
  k_frq3  chnget "lfo3_freq"
  k_amp3  chnget "lfo3_amp"
  k_wav3  chnget "lfo3_wave"
  k_tgt3  chnget "lfo3_target"
  k_val3  LFOWave k_amp3, k_frq3, k_wav3
  LFORoutePluck k_tgt3, k_val3
  cabbageSetValue "lfo3_out", k_val3

  ; --- LFO 4 ---
  k_frq4  chnget "lfo4_freq"
  k_amp4  chnget "lfo4_amp"
  k_wav4  chnget "lfo4_wave"
  k_tgt4  chnget "lfo4_target"
  k_val4  LFOWave k_amp4, k_frq4, k_wav4
  LFORoutePluck k_tgt4, k_val4
  cabbageSetValue "lfo4_out", k_val4

endin


;==============================================================
; PRESET MANAGER — instr 95
;
; Save/Load all channel values to/from JSON file.
; Uses channelStateSave / channelStateRecall opcodes.
; Includes conductor channels in SYNC list.
;==============================================================
instr 95

  k_save chnget "preset_save"
  k_load chnget "preset_load"

  ; GUI refresh flags (for syncing widget visuals after recall)
  k_gui_refresh init 0
  k_gui_delay   init 0

  ; Auto-load last saved preset on startup (if file exists)
  i_exists filevalid "/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/cof-rig-preset.json"
  k_init init 0
  if k_init == 0 && i_exists == 1 then
    kOk = cabbageChannelStateRecall:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/cof-rig-preset.json")
    chnset k(0), "preset_save"   ; prevent recall from triggering a save
    printks "Auto-loaded preset from cof-rig-preset.json\\n", 0
    k_gui_refresh = 1
    k_init = 1
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
    $SYNC_WIDGET(cond_start_key)
    $SYNC_WIDGET(cond_dir)
    $SYNC_WIDGET(seq_patmode)
    $SYNC_WIDGET(dly_div)
    k_save_delay = 2
  endif

  if k_save_delay > 0 then
    k_save_delay -= 1
  elseif k_save_delay == 0 then
    k_save_delay = -1
    kOk = cabbageChannelStateSave:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/cof-rig-preset.json")
    chnset k(0), "preset_save"
    printks "Preset saved to cof-rig-preset.json\\n", 0
  endif

  if k_ld == 1 then
    kOk = cabbageChannelStateRecall:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/cof-rig-preset.json")
    chnset k(0), "preset_load"
    chnset k(0), "preset_save"   ; prevent recall from triggering a save
    printks "Preset loaded from cof-rig-preset.json\\n", 0
    k_gui_refresh = 1
  endif

  ; --- GUI refresh: sync widget visuals after preset recall ---
  if k_gui_refresh == 1 then
    k_gui_delay += 1
    if k_gui_delay >= 15 then
      k_gui_refresh = 0
      k_gui_delay   = 0

      ; Sync LFO widgets (explicit per-channel instead of macro)
      $SYNC_WIDGET(lfo1_freq)
      $SYNC_WIDGET(lfo1_amp)
      $SYNC_WIDGET(lfo1_wave)
      $SYNC_WIDGET(lfo1_target)
      $SYNC_WIDGET(lfo2_freq)
      $SYNC_WIDGET(lfo2_amp)
      $SYNC_WIDGET(lfo2_wave)
      $SYNC_WIDGET(lfo2_target)
      $SYNC_WIDGET(lfo3_freq)
      $SYNC_WIDGET(lfo3_amp)
      $SYNC_WIDGET(lfo3_wave)
      $SYNC_WIDGET(lfo3_target)
      $SYNC_WIDGET(lfo4_freq)
      $SYNC_WIDGET(lfo4_amp)
      $SYNC_WIDGET(lfo4_wave)
      $SYNC_WIDGET(lfo4_target)

      ; Sync sequencer widgets
      $SYNC_WIDGET(seq_bpm)
      $SYNC_WIDGET(seq_swing)
      $SYNC_WIDGET(seq_density)
      $SYNC_WIDGET(seq_gate)
      $SYNC_WIDGET(seq_root)
      $SYNC_WIDGET(seq_range)
      $SYNC_WIDGET(seq_octjump)
      $SYNC_WIDGET(seq_velmin)
      $SYNC_WIDGET(seq_velmax)
      $SYNC_WIDGET(seq_accent)

      ; Sync synth widgets
      $SYNC_WIDGET(osc_shape)
      $SYNC_WIDGET(osc_detune)
      $SYNC_WIDGET(osc_sub)
      $SYNC_WIDGET(filt_cutoff)
      $SYNC_WIDGET(filt_reso)
      $SYNC_WIDGET(filt_envamt)
      $SYNC_WIDGET(filt_decay)
      $SYNC_WIDGET(amp_a)
      $SYNC_WIDGET(amp_d)
      $SYNC_WIDGET(amp_s)

      ; Sync effect widgets
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
      $SYNC_WIDGET(dly_send)
      $SYNC_WIDGET(rvb_send)
      $SYNC_WIDGET(dly_rvb_send)
      $SYNC_WIDGET(seq_play)

      ; Sync pattern widgets
      $SYNC_WIDGET(seq_patmode)
      $SYNC_WIDGET(seq_patrep)

      ; Sync conductor/harmony widgets
      $SYNC_WIDGET(cond_start_key)
      $SYNC_WIDGET(cond_speed)
      $SYNC_WIDGET(cond_dir)
      $SYNC_WIDGET(cond_enabled)

      ; Rebuild weight table for recalled key
      k_sk chnget "cond_start_key"
      event "i", 71, 0, 0.1, k_sk - 1
    endif
  endif

endin


;==============================================================
; DELAY — instr 98 (Ping-Pong)
;
; Modulated ping-pong delay with UI controls.
; Wet delay taps are sent to reverb and output.
;==============================================================
instr 98

  ; --- Read parameters ---
  k_div      chnget "dly_div"
  k_bpm      chnget "seq_bpm"
  k_fb       chnget "dly_fb"
  k_mix      chnget "dly_mix"
  k_mod_dep  chnget "dly_mod"
  k_rvb_send chnget "dly_rvb_send"

  ; --- BPM-synced delay time from note division ---
  k_quarter = 60 / k_bpm

  ; 1=1/2, 2=1/4, 3=D.1/8, 4=1/8, 5=1/16, 6=T.1/4, 7=T.1/8
  k_time = k_quarter    ; default 1/4
  if k_div == 1 then
    k_time = k_quarter * 2           ; 1/2
  elseif k_div == 3 then
    k_time = k_quarter * 0.75        ; dotted 1/8
  elseif k_div == 4 then
    k_time = k_quarter * 0.5         ; 1/8
  elseif k_div == 5 then
    k_time = k_quarter * 0.25        ; 1/16
  elseif k_div == 6 then
    k_time = k_quarter * 0.6667      ; triplet 1/4
  elseif k_div == 7 then
    k_time = k_quarter * 0.3333      ; triplet 1/8
  endif

  ; Clamp to delay buffer size
  k_time limit k_time, 0.05, 1.95

  ; --- Modulation oscillator ---
  k_mod lfo k_mod_dep, 0.23, 0

  ; --- Ping-pong delay lines ---
  i_maxdel = 2.0

  a_tap_L init 0
  a_tap_R init 0

  a_buf_L delayr i_maxdel
  a_tap_L deltap3 k_time + k_mod
          delayw ga_dly_L + a_tap_R * k_fb

  a_buf_R delayr i_maxdel
  a_tap_R deltap3 k_time - k_mod
          delayw ga_dly_R + a_tap_L * k_fb

  ; --- Output (wet side of dry/wet crossfade) ---
  outs a_tap_L * k_mix, a_tap_R * k_mix

  ; --- Delay -> Reverb send ---
  ga_rvb_L = ga_rvb_L + a_tap_L * k_rvb_send
  ga_rvb_R = ga_rvb_R + a_tap_R * k_rvb_send

  ; --- Clear delay bus ---
  ga_dly_L = 0
  ga_dly_R = 0

endin


;==============================================================
; REVERB — instr 99 (reverbsc)
;
; Hall reverb with UI controls for size, tone, wet.
;==============================================================
instr 99

  ; --- Read parameters ---
  k_fb   chnget "rvb_fb"
  k_cut  chnget "rvb_cut"
  k_wet  chnget "rvb_wet"

  ; --- Reverb ---
  a_L, a_R reverbsc ga_rvb_L, ga_rvb_R, k_fb, k_cut

  ; --- Output ---
  outs a_L * k_wet, a_R * k_wet

  ; --- Clear reverb bus ---
  ga_rvb_L = 0
  ga_rvb_R = 0

endin


</CsInstruments>
<CsScore>
; Score order: conductor -> LFOs -> sequencer -> preset -> delay -> reverb
; Conductor (70) runs first to update weight table before sequencer reads it
; Pluck voices (instr 1) are event-triggered by sequencer
i 70 0 [60*60*4]   ; circle-of-fifths conductor
i 90 0 [60*60*4]   ; LFO modulator
i 80 0 [60*60*4]   ; probabilistic sequencer (weighted random)
i 95 0 [60*60*4]   ; preset manager
i 98 0 [60*60*4]   ; ping-pong delay
i 99 0 [60*60*4]   ; reverb
e
</CsScore>
</CsoundSynthesizer>
