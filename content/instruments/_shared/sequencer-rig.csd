<Cabbage>
form caption("Sequencer Rig — Generative Pluck") size(820, 720), colour(30, 30, 50), pluginId("sqrg")

; Header
label bounds(10, 8, 800, 25) text("SEQUENCER RIG") fontColour(120, 200, 150) fontSize(18) align("left")
label bounds(10, 32, 800, 18) text("Generative Ambient — Probabilistic Pluck Sequencer") fontColour(150, 150, 170) fontSize(12) align("left")

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

; Pitch
groupbox bounds(245, 60, 265, 130) text("PITCH") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 48, 48) channel("seq_root") range(24, 72, 48, 1, 1) text("Root") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(65, 28, 80, 20) channel("seq_scale") value(1) text("Min Pent", "Maj Pent", "Minor", "Major", "Dorian", "Chromatic")
    rslider bounds(152, 25, 48, 48) channel("seq_range") range(0.5, 3, 1.5, 1, 0.1) text("Range") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(204, 25, 48, 48) channel("seq_octjump") range(0, 0.5, 0.2, 1, 0.01) text("OctJump") textColour(200,200,220) trackerColour(120, 200, 150)
    label bounds(65, 52, 80, 20) text("Scale") fontColour(140, 140, 160) fontSize(9) align("centre")
    label bounds(10, 80, 245, 30) text("Root=MIDI note, Range=octaves above root") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Dynamics
groupbox bounds(515, 60, 295, 130) text("DYNAMICS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("seq_velmin") range(0.1, 1, 0.3, 1, 0.01) text("Vel Min") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(72, 25, 55, 55) channel("seq_velmax") range(0.1, 1, 0.8, 1, 0.01) text("Vel Max") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(134, 25, 55, 55) channel("seq_accent") range(0, 1, 0.3, 1, 0.01) text("Accent") textColour(200,200,220) trackerColour(120, 200, 150)
    label bounds(10, 85, 280, 25) text("Random velocity range. Accent = probability of max hit.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=200): SYNTH
;=====================================================================

; Oscillator
groupbox bounds(10, 200, 180, 95) text("OSCILLATOR") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 48, 48) channel("osc_shape") range(0, 1, 0.43, 1, 0.01) text("Shape") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(65, 25, 48, 48) channel("osc_detune") range(0, 10, 3, 1, 0.1) text("Detune") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(120, 25, 48, 48) channel("osc_sub") range(0, 1, 0.2, 1, 0.01) text("Sub") textColour(200,200,220) trackerColour(224, 160, 80)
}

; Filter
groupbox bounds(195, 200, 260, 95) text("FILTER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("filt_cutoff") range(200, 12000, 313, 0.3, 1) text("Cutoff") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(68, 25, 55, 55) channel("filt_reso") range(0, 0.9, 0, 1, 0.01) text("Reso") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(126, 25, 55, 55) channel("filt_envamt") range(0, 1, 0.5, 1, 0.01) text("EnvAmt") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(184, 25, 55, 55) channel("filt_decay") range(0.1, 5, 1.69, 0.5, 0.01) text("F.Decay") textColour(200,200,220) trackerColour(224, 160, 80)
}

; Amp
groupbox bounds(460, 200, 200, 95) text("AMP ENVELOPE") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("amp_a") range(0.001, 0.5, 0.005, 0.3, 0.001) text("Attack") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(72, 25, 55, 55) channel("amp_d") range(0.1, 8, 2.67, 0.3, 0.01) text("Decay") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(134, 25, 55, 55) channel("amp_s") range(0, 0.5, 0, 1, 0.01) text("Sustain") textColour(200,200,220) trackerColour(224, 122, 95)
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

; Sine table for oscili
gi_sine ftgen 0, 0, 8192, 10, 1

;=====================================================================
; SCALE TABLES (GEN -2: non-power-of-two sizes allowed)
;=====================================================================
gi_sc_minpent ftgen 0, 0, -5,  -2, 0, 3, 5, 7, 10
gi_sc_majpent ftgen 0, 0, -5,  -2, 0, 2, 4, 7, 9
gi_sc_minor   ftgen 0, 0, -7,  -2, 0, 2, 3, 5, 7, 8, 10
gi_sc_major   ftgen 0, 0, -7,  -2, 0, 2, 4, 5, 7, 9, 11
gi_sc_dorian  ftgen 0, 0, -7,  -2, 0, 2, 3, 5, 7, 9, 10
gi_sc_chrom   ftgen 0, 0, -12, -2, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11

gi_sc_len_minpent = 5
gi_sc_len_majpent = 5
gi_sc_len_minor   = 7
gi_sc_len_major   = 7
gi_sc_len_dorian  = 7
gi_sc_len_chrom   = 12


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
  chnset k_val1, "lfo1_out"

  ; --- LFO 2 ---
  k_frq2  chnget "lfo2_freq"
  k_amp2  chnget "lfo2_amp"
  k_wav2  chnget "lfo2_wave"
  k_tgt2  chnget "lfo2_target"
  k_val2  LFOWave k_amp2, k_frq2, k_wav2
  LFORoutePluck k_tgt2, k_val2
  chnset k_val2, "lfo2_out"

  ; --- LFO 3 ---
  k_frq3  chnget "lfo3_freq"
  k_amp3  chnget "lfo3_amp"
  k_wav3  chnget "lfo3_wave"
  k_tgt3  chnget "lfo3_target"
  k_val3  LFOWave k_amp3, k_frq3, k_wav3
  LFORoutePluck k_tgt3, k_val3
  chnset k_val3, "lfo3_out"

  ; --- LFO 4 ---
  k_frq4  chnget "lfo4_freq"
  k_amp4  chnget "lfo4_amp"
  k_wav4  chnget "lfo4_wave"
  k_tgt4  chnget "lfo4_target"
  k_val4  LFOWave k_amp4, k_frq4, k_wav4
  LFORoutePluck k_tgt4, k_val4
  chnset k_val4, "lfo4_out"

endin


;==============================================================
; SEQUENCER — instr 80
;
; Probabilistic note generator. Uses metro at eighth-note rate,
; rolls against density for note probability, picks random
; scale degree, fires event to spawn pluck voice (instr 1).
;==============================================================
instr 80

  ; --- Read sequencer parameters ---
  k_play    chnget "seq_play"
  k_bpm     chnget "seq_bpm"
  k_swing   chnget "seq_swing"
  k_dens_b  chnget "seq_density"
  k_gate_b  chnget "seq_gate"
  k_root    chnget "seq_root"
  k_scale   chnget "seq_scale"
  k_range_b chnget "seq_range"
  k_octjump chnget "seq_octjump"
  k_velmin  chnget "seq_velmin"
  k_velmax  chnget "seq_velmax"
  k_accent  chnget "seq_accent"

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

  ; --- Eighth-note metro with swing ---
  ; Eighth note period = 60 / BPM / 2
  k_eighth = 60 / k_bpm / 2

  ; Step counter for swing (0=on-beat, 1=off-beat)
  k_step init 0
  k_next_time init 0

  ; Time-based metro for swing support
  k_time timeinsts
  k_trig = 0

  if k_time >= k_next_time then
    k_trig = 1
    ; Calculate next step time with swing
    if k_step == 0 then
      ; On-beat: next step gets swing delay
      k_next_time = k_time + k_eighth * (1 + k_swing)
    else
      ; Off-beat: next step is normal minus swing
      k_next_time = k_time + k_eighth * (1 - k_swing)
    endif
    k_step = 1 - k_step
  endif

  ; --- Note generation ---
  if k_trig == 1 && k_play > 0.5 then

    ; Roll against density
    k_roll random 0, 1
    if k_roll < k_dens then

      ; --- Select scale table and length ---
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

      ; --- Pick random scale degree ---
      ; Range in semitones above root
      k_range_semi = k_range * 12
      ; Number of scale degrees that fit in range
      k_max_deg = k_range_semi / 12 * k_sc_len
      k_max_deg limit k_max_deg, 1, 60

      ; Random degree index
      k_deg random 0, k_max_deg
      k_deg = int(k_deg)

      ; Convert degree to MIDI note
      k_octave = int(k_deg / k_sc_len)
      k_degree_in_scale = k_deg - k_octave * k_sc_len
      ; Clamp degree index to valid range
      k_degree_in_scale limit k_degree_in_scale, 0, k_sc_len - 1

      ; Look up semitone offset from scale table
      k_semi tablekt k_degree_in_scale, k_sc_tab
      k_midi_note = k_root + k_octave * 12 + k_semi

      ; Oct jump: probability of +1 octave
      k_oct_roll random 0, 1
      if k_oct_roll < k_octjump then
        k_midi_note = k_midi_note + 12
      endif

      ; Clamp to valid MIDI range
      k_midi_note limit k_midi_note, 24, 108

      ; Convert to frequency
      k_freq = cpsmidinn(k_midi_note)

      ; --- Velocity ---
      k_acc_roll random 0, 1
      if k_acc_roll < k_accent then
        k_vel = k_velmax
      else
        k_vel random k_velmin, k_velmax
      endif

      ; --- Pan (random spread) ---
      k_pan random 0.2, 0.8

      ; --- Polyphony check ---
      k_active active 1
      if k_active < 8 then
        ; Fire pluck voice: p4=freq, p5=vel, p6=pan
        event "i", 1, 0, k_gate, k_freq, k_vel, k_pan
      endif

      ; --- Double trigger (15% syncopation at half-eighth offset) ---
      k_dbl_roll random 0, 1
      if k_dbl_roll < 0.15 && k_active < 7 then
        ; Pick a different note for the double
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

    endif ; density check
  endif ; trig + play check

endin


;==============================================================
; PLUCK VOICE — instr 1 (event-triggered, polyphonic)
;
; Saw+Square blend with moogladder filter, squared-linseg
; envelopes for amp and mod (filter). Adapted from gen_pulse.
;
; p4 = frequency (Hz)
; p5 = velocity (0–1)
; p6 = pan (0–1)
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
  ; Attack → peak, decay → sustain, hold sustain for gate duration
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
; PRESET MANAGER — instr 95
;
; Save/Load all channel values to/from JSON file.
; Uses channelStateSave / channelStateRecall opcodes.
;==============================================================
instr 95

  k_save chnget "preset_save"
  k_load chnget "preset_load"

  k_sv trigger k_save, 0.5, 0
  k_ld trigger k_load, 0.5, 0

  if k_sv == 1 then
    kOk channelStateSave "sequencer-rig-preset.json"
    chnset k(0), "preset_save"
    printks "Preset saved to sequencer-rig-preset.json\\n", 0
  endif

  if k_ld == 1 then
    kOk channelStateRecall "sequencer-rig-preset.json"
    chnset k(0), "preset_load"
    printks "Preset loaded from sequencer-rig-preset.json\\n", 0
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
  ; Quarter note = 60/BPM
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
; Score order: LFOs -> sequencer -> delay -> reverb
; Pluck voices (instr 1) are event-triggered by sequencer
i 90 0 [60*60*4]   ; LFO modulator
i 80 0 [60*60*4]   ; probabilistic sequencer
i 95 0 [60*60*4]   ; preset manager
i 98 0 [60*60*4]   ; ping-pong delay
i 99 0 [60*60*4]   ; reverb
e
</CsScore>
</CsoundSynthesizer>
