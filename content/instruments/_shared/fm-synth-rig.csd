<Cabbage>
form caption("FM Synth Rig — Polyphonic Sound Design") size(820, 720), colour(30, 30, 50), pluginId("pdsr")

; Header
label bounds(10, 8, 800, 25) text("FM SYNTH RIG") fontColour(100, 180, 224) fontSize(18) align("left")
label bounds(10, 32, 800, 18) text("Generative Ambient — Polyphonic Sound Design Environment") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): OSCILLATORS
;=====================================================================

; Osc A
groupbox bounds(10, 60, 195, 120) text("OSC A") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 85, 20) channel("osc_a_wave") value(1) text("Saw", "Square", "Triangle", "Sine", "Pulse")
    rslider bounds(105, 22, 55, 55) channel("osc_a_level") range(0, 1, 0.8, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(100, 180, 224)
    label bounds(10, 55, 85, 40) text("Waveform for oscillator A") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Osc B
groupbox bounds(210, 60, 310, 120) text("OSC B") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 85, 20) channel("osc_b_wave") value(1) text("Saw", "Square", "Triangle", "Sine", "Pulse")
    rslider bounds(105, 22, 50, 50) channel("osc_b_level") range(0, 1, 0.6, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(160, 22, 50, 50) channel("osc_b_semi") range(-24, 24, 0, 1, 1) text("Semi") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(215, 22, 50, 50) channel("osc_b_fine") range(-100, 100, 7, 1, 1) text("Fine") textColour(200,200,220) trackerColour(100, 180, 224)
    label bounds(10, 55, 290, 40) text("Detuned osc B. Semi=semitones, Fine=cents.") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Mix / Shape
groupbox bounds(525, 60, 285, 120) text("MIX") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 22, 55, 55) channel("osc_mix") range(0, 1, 0.5, 1, 0.01) text("A/B Mix") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(75, 22, 55, 55) channel("osc_shape") range(0.01, 0.99, 0.5, 1, 0.01) text("Shape") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(140, 22, 55, 55) channel("sub_level") range(0, 1, 0, 1, 0.01) text("Sub") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(205, 22, 55, 55) channel("noise_level") range(0, 1, 0, 1, 0.01) text("Noise") textColour(200,200,220) trackerColour(100, 180, 224)
    label bounds(10, 82, 270, 20) text("Shape=pulse width. Sub=sine -1oct. Noise=hiss layer.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=190): FILTER + ENVELOPES
;=====================================================================

; Filter
groupbox bounds(10, 190, 250, 95) text("FILTER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 50, 50) channel("filt_cutoff") range(200, 16000, 4000, 0.3, 1) text("Cutoff") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(65, 25, 50, 50) channel("filt_reso") range(0, 0.9, 0.3, 1, 0.01) text("Reso") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(120, 25, 50, 50) channel("filt_env_amt") range(0, 1, 0.5, 1, 0.01) text("EnvAmt") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(175, 25, 50, 50) channel("filt_keytrk") range(0, 1, 0.3, 1, 0.01) text("KeyTrk") textColour(200,200,220) trackerColour(224, 160, 80)
}

; Amp Envelope
groupbox bounds(265, 190, 260, 95) text("AMP ENVELOPE") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 50, 50) channel("amp_a") range(0.001, 10, 0.8, 0.3, 0.001) text("A") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(65, 25, 50, 50) channel("amp_d") range(0.001, 10, 1.5, 0.3, 0.001) text("D") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(120, 25, 50, 50) channel("amp_s") range(0, 1, 0.7, 1, 0.01) text("S") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(175, 25, 50, 50) channel("amp_r") range(0.01, 15, 3.0, 0.3, 0.01) text("R") textColour(200,200,220) trackerColour(224, 122, 95)
}

; Filter Envelope
groupbox bounds(530, 190, 280, 95) text("FILTER ENVELOPE") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 50, 50) channel("filt_a") range(0.001, 10, 0.01, 0.3, 0.001) text("A") textColour(200,200,220) trackerColour(180, 120, 224)
    rslider bounds(65, 25, 50, 50) channel("filt_d") range(0.001, 10, 2.0, 0.3, 0.001) text("D") textColour(200,200,220) trackerColour(180, 120, 224)
    rslider bounds(120, 25, 50, 50) channel("filt_s") range(0, 1, 0.2, 1, 0.01) text("S") textColour(200,200,220) trackerColour(180, 120, 224)
    rslider bounds(175, 25, 50, 50) channel("filt_r") range(0.01, 15, 4.0, 0.3, 0.01) text("R") textColour(200,200,220) trackerColour(180, 120, 224)
}

;=====================================================================
; ROW 3 (y=295): MODULATION — 4 LFOs
;=====================================================================

groupbox bounds(10, 295, 800, 170) text("MODULATION") colour(35, 35, 55) fontColour(200, 200, 220) {

    ; LFO 1
    label bounds(15, 22, 180, 14) text("LFO 1") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(15, 38, 45, 45) channel("lfo1_freq") range(0.01, 10, 0.1, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(62, 38, 45, 45) channel("lfo1_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(112, 40, 78, 20) channel("lfo1_wave") value(1) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(112, 64, 78, 20) channel("lfo1_target") value(1) text("None", "Cutoff", "Reso", "Shape", "Fine", "A/B Mix", "EnvAmt", "Volume")
    hslider bounds(15, 90, 175, 12) channel("lfo1_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; LFO 2
    label bounds(210, 22, 180, 14) text("LFO 2") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(210, 38, 45, 45) channel("lfo2_freq") range(0.01, 10, 0.07, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(257, 38, 45, 45) channel("lfo2_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(307, 40, 78, 20) channel("lfo2_wave") value(2) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(307, 64, 78, 20) channel("lfo2_target") value(1) text("None", "Cutoff", "Reso", "Shape", "Fine", "A/B Mix", "EnvAmt", "Volume")
    hslider bounds(210, 90, 175, 12) channel("lfo2_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; LFO 3
    label bounds(405, 22, 180, 14) text("LFO 3") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(405, 38, 45, 45) channel("lfo3_freq") range(0.01, 10, 0.05, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(452, 38, 45, 45) channel("lfo3_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(502, 40, 78, 20) channel("lfo3_wave") value(4) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(502, 64, 78, 20) channel("lfo3_target") value(1) text("None", "Cutoff", "Reso", "Shape", "Fine", "A/B Mix", "EnvAmt", "Volume")
    hslider bounds(405, 90, 175, 12) channel("lfo3_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; LFO 4
    label bounds(600, 22, 190, 14) text("LFO 4") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(600, 38, 45, 45) channel("lfo4_freq") range(0.01, 10, 0.15, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(647, 38, 45, 45) channel("lfo4_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(697, 40, 78, 20) channel("lfo4_wave") value(6) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(697, 64, 78, 20) channel("lfo4_target") value(1) text("None", "Cutoff", "Reso", "Shape", "Fine", "A/B Mix", "EnvAmt", "Volume")
    hslider bounds(600, 90, 175, 12) channel("lfo4_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; Hint
    label bounds(15, 108, 780, 40) text("Amp starts at 0 (off). Pick a Wave shape and Target, then raise Amp. Green bars show LFO output.") fontColour(130, 130, 150) fontSize(10) align("left")
}

;=====================================================================
; ROW 4 (y=475): EFFECTS + MASTER
;=====================================================================

; Delay
groupbox bounds(10, 475, 220, 135) text("DELAY") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 28, 48, 48) channel("dly_time") range(0.05, 1.5, 0.4, 0.5, 0.01) text("Time") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(55, 28, 48, 48) channel("dly_fb") range(0, 0.9, 0.55, 1, 0.01) text("FB") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(105, 28, 48, 48) channel("dly_wet") range(0, 1, 0.3, 1, 0.01) text("Wet") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(155, 28, 48, 48) channel("dly_mod") range(0, 0.02, 0.003, 0.5, 0.001) text("Mod") textColour(200,200,220) trackerColour(100, 180, 224)
    label bounds(5, 85, 210, 30) text("Ping-pong delay with modulation") fontColour(140, 140, 160) fontSize(10) align("left")
}

; Reverb
groupbox bounds(235, 475, 185, 135) text("REVERB") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 28, 50, 50) channel("rvb_fb") range(0.3, 0.99, 0.88, 1, 0.01) text("Size") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(60, 28, 50, 50) channel("rvb_cut") range(1000, 14000, 7000, 0.4, 1) text("Tone") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(115, 28, 50, 50) channel("rvb_wet") range(0, 1, 0.5, 1, 0.01) text("Wet") textColour(200,200,220) trackerColour(100, 180, 224)
    label bounds(5, 88, 175, 25) text("reverbsc hall") fontColour(140, 140, 160) fontSize(10) align("left")
}

; Master
groupbox bounds(425, 475, 200, 135) text("MASTER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 28, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(72, 28, 55, 55) channel("master_lpf") range(200, 16000, 12000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(134, 28, 55, 55) channel("warmth") range(0, 1, 0.3, 1, 0.01) text("Warmth") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 93, 185, 25) text("Volume, filter, saturation") fontColour(140, 140, 160) fontSize(10) align("left")
}

; Sends
groupbox bounds(630, 475, 180, 135) text("SENDS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 28, 50, 50) channel("dly_send") range(0, 1, 0.25, 1, 0.01) text("Delay") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(65, 28, 50, 50) channel("rvb_send") range(0, 1, 0.45, 1, 0.01) text("Reverb") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(120, 28, 50, 50) channel("dly_rvb_send") range(0, 1, 0.2, 1, 0.01) text("Dly>Rvb") textColour(200,200,220) trackerColour(150, 150, 200)
    label bounds(10, 88, 170, 25) text("Effect send levels") fontColour(140, 140, 160) fontSize(10) align("left")
}

;=====================================================================
; ROW 5 (y=620): KEYBOARD
;=====================================================================

keyboard bounds(10, 620, 620, 80)
button bounds(640, 625, 80, 65) channel("hold") text("HOLD", "HOLD") value(0) colour:0(60, 60, 80) colour:1(120, 200, 150) fontColour:0(180, 180, 200) fontColour:1(30, 30, 50)

button bounds(730, 625, 80, 30) channel("preset_save") text("Save", "Save") value(0) colour:0(50, 50, 70) colour:1(100, 180, 224) fontColour:0(180, 180, 200) fontColour:1(255, 255, 255)
button bounds(730, 660, 80, 30) channel("preset_load") text("Load", "Load") value(0) colour:0(50, 50, 70) colour:1(100, 180, 224) fontColour:0(180, 180, 200) fontColour:1(255, 255, 255)

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

; Sine table for oscili
gi_sine ftgen 0, 0, 8192, 10, 1

; Route all MIDI channels to instr 1
massign 0, 1

;=====================================================================
; GLOBAL SEND BUSES
;=====================================================================
ga_rvb_L init 0
ga_rvb_R init 0
ga_dly_L init 0
ga_dly_R init 0

;=====================================================================
; GLOBAL MODULATION ACCUMULATORS (pad synth targets)
; Reset each k-cycle by instr 90. LFOs add here.
;=====================================================================
gk_mod_cutoff   init 0
gk_mod_reso     init 0
gk_mod_shape    init 0
gk_mod_detune   init 0
gk_mod_mix      init 0
gk_mod_filtenv  init 0
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
; UDO: LFORoutePad — Route a modulation value to a pad target
;
; ktgt: combobox value (1=None, 2=Cutoff, 3=Reso, 4=Shape,
;        5=Detune, 6=Mix, 7=FiltEnv, 8=Volume)
;==============================================================
opcode LFORoutePad, 0, kk
  ktgt, kval xin

  if ktgt == 2 then
    gk_mod_cutoff = gk_mod_cutoff + kval * 4000
  elseif ktgt == 3 then
    gk_mod_reso = gk_mod_reso + kval * 0.3
  elseif ktgt == 4 then
    gk_mod_shape = gk_mod_shape + kval * 0.3
  elseif ktgt == 5 then
    gk_mod_detune = gk_mod_detune + kval * 12
  elseif ktgt == 6 then
    gk_mod_mix = gk_mod_mix + kval * 0.3
  elseif ktgt == 7 then
    gk_mod_filtenv = gk_mod_filtenv + kval * 0.5
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
  gk_mod_detune  = 0
  gk_mod_mix     = 0
  gk_mod_filtenv = 0
  gk_mod_vol     = 0

  ; --- LFO 1 ---
  k_frq1  chnget "lfo1_freq"
  k_amp1  chnget "lfo1_amp"
  k_wav1  chnget "lfo1_wave"
  k_tgt1  chnget "lfo1_target"
  k_val1  LFOWave k_amp1, k_frq1, k_wav1
  LFORoutePad k_tgt1, k_val1
  chnset k_val1, "lfo1_out"

  ; --- LFO 2 ---
  k_frq2  chnget "lfo2_freq"
  k_amp2  chnget "lfo2_amp"
  k_wav2  chnget "lfo2_wave"
  k_tgt2  chnget "lfo2_target"
  k_val2  LFOWave k_amp2, k_frq2, k_wav2
  LFORoutePad k_tgt2, k_val2
  chnset k_val2, "lfo2_out"

  ; --- LFO 3 ---
  k_frq3  chnget "lfo3_freq"
  k_amp3  chnget "lfo3_amp"
  k_wav3  chnget "lfo3_wave"
  k_tgt3  chnget "lfo3_target"
  k_val3  LFOWave k_amp3, k_frq3, k_wav3
  LFORoutePad k_tgt3, k_val3
  chnset k_val3, "lfo3_out"

  ; --- LFO 4 ---
  k_frq4  chnget "lfo4_freq"
  k_amp4  chnget "lfo4_amp"
  k_wav4  chnget "lfo4_wave"
  k_tgt4  chnget "lfo4_target"
  k_val4  LFOWave k_amp4, k_frq4, k_wav4
  LFORoutePad k_tgt4, k_val4
  chnset k_val4, "lfo4_out"

endin


;==============================================================
; PAD SYNTH — instr 1 (MIDI-driven polyphonic)
;
; Dual vco2 oscillators + moogladder filter + ADSR envelopes.
; Each MIDI note spawns a separate instance.
; madsr handles note-off release automatically.
;==============================================================
instr 1

  ; --- MIDI pitch & velocity ---
  icps cpsmidi
  ivel veloc 0, 1

  ; --- Read oscillator parameters ---
  k_wav_a    chnget "osc_a_wave"
  k_wav_b    chnget "osc_b_wave"
  k_lvl_a    chnget "osc_a_level"
  k_lvl_b    chnget "osc_b_level"
  k_semi     chnget "osc_b_semi"
  k_fine     chnget "osc_b_fine"
  k_mix_base chnget "osc_mix"
  k_shape_b  chnget "osc_shape"
  k_sub_lvl  chnget "sub_level"
  k_nse_lvl  chnget "noise_level"

  ; --- Read filter parameters ---
  k_cut_base    chnget "filt_cutoff"
  k_reso_base   chnget "filt_reso"
  k_env_amt_b   chnget "filt_env_amt"
  k_keytrk      chnget "filt_keytrk"

  ; --- Read master / send parameters ---
  k_vol_base    chnget "master_vol"
  k_lpf         chnget "master_lpf"
  k_warmth      chnget "warmth"
  k_dly_send    chnget "dly_send"
  k_rvb_send    chnget "rvb_send"

  ; --- Apply LFO modulation ---
  k_mix    = k_mix_base + gk_mod_mix
  k_shape  = k_shape_b + gk_mod_shape
  k_cut    = k_cut_base + gk_mod_cutoff
  k_reso   = k_reso_base + gk_mod_reso
  k_envamt = k_env_amt_b + gk_mod_filtenv
  k_vol    = k_vol_base + gk_mod_vol
  k_det_mod = gk_mod_detune

  ; --- Clamp modulated parameters ---
  k_mix    limit k_mix, 0, 1
  k_shape  limit k_shape, 0.01, 0.99
  k_cut    limit k_cut, 200, 16000
  k_reso   limit k_reso, 0, 0.9
  k_envamt limit k_envamt, 0, 1
  k_vol    limit k_vol, 0, 1

  ; --- HOLD + ENVELOPE LOGIC ---
  ; xtratim keeps the note instance alive long enough for hold + release
  xtratim 3600    ; 1 hour max hold time

  k_hold chnget "hold"
  k_rel release           ; 1 when MIDI note-off received

  ; State tracking
  k_note_off init 0
  k_releasing init 0

  ; Latch note-off event
  if k_rel == 1 then
    k_note_off = 1
  endif

  ; Start release when: note is off AND hold is off AND not already releasing
  if k_note_off == 1 && k_hold == 0 && k_releasing == 0 then
    k_releasing = 1
    reinit start_release
  endif

  ; --- Amp ADS envelope (attack-decay-sustain, no auto-release) ---
  i_amp_a chnget "amp_a"
  i_amp_d chnget "amp_d"
  i_amp_s chnget "amp_s"

  ; ADS: ramp up, decay to sustain, hold at sustain
  i_ads_hold = 3600
  k_ads linseg 0, i_amp_a, 1, i_amp_d, i_amp_s, i_ads_hold, i_amp_s

  ; --- Filter ADS envelope ---
  i_flt_a chnget "filt_a"
  i_flt_d chnget "filt_d"
  i_flt_s chnget "filt_s"
  k_flt_ads linseg 0, i_flt_a, 1, i_flt_d, i_flt_s, i_ads_hold, i_flt_s

  ; --- Release envelopes (triggered by reinit when hold released) ---
  k_rel_env init 1
  k_flt_rel_env init 1
  if k_releasing == 1 then
start_release:
    i_amp_r chnget "amp_r"
    i_flt_r chnget "filt_r"
    k_rel_env linseg 1, i_amp_r, 0
    k_flt_rel_env linseg 1, i_flt_r, 0
    rireturn
  endif

  ; Combined envelopes
  k_amp_env = k_ads * k_rel_env
  k_flt_env = k_flt_ads * k_flt_rel_env

  ; Auto-turnoff when release complete
  if k_releasing == 1 && k_rel_env <= 0.001 then
    turnoff
  endif

  ; --- Osc A frequency ---
  kcps_a = icps

  ; --- Osc A ---
  a_saw_a vco2 1, kcps_a, 0
  a_sqr_a vco2 1, kcps_a, 10, 0.5
  a_tri_a vco2 1, kcps_a, 12, 0.5
  a_sin_a oscili 1, kcps_a, gi_sine
  a_pls_a vco2 1, kcps_a, 2, k_shape

  ; Select waveform A
  a_osc_a = a_saw_a
  if k_wav_a == 2 then
    a_osc_a = a_sqr_a
  elseif k_wav_a == 3 then
    a_osc_a = a_tri_a
  elseif k_wav_a == 4 then
    a_osc_a = a_sin_a
  elseif k_wav_a == 5 then
    a_osc_a = a_pls_a
  endif

  ; --- Osc B frequency (detuned) ---
  k_semi_total = k_semi + k_fine * 0.01 + k_det_mod * 0.01
  kcps_b = icps * semitone(k_semi_total)

  ; --- Osc B ---
  a_saw_b vco2 1, kcps_b, 0
  a_sqr_b vco2 1, kcps_b, 10, 0.5
  a_tri_b vco2 1, kcps_b, 12, 0.5
  a_sin_b oscili 1, kcps_b, gi_sine
  a_pls_b vco2 1, kcps_b, 2, k_shape

  ; Select waveform B
  a_osc_b = a_saw_b
  if k_wav_b == 2 then
    a_osc_b = a_sqr_b
  elseif k_wav_b == 3 then
    a_osc_b = a_tri_b
  elseif k_wav_b == 4 then
    a_osc_b = a_sin_b
  elseif k_wav_b == 5 then
    a_osc_b = a_pls_b
  endif

  ; --- Mix oscillators ---
  a_osc = a_osc_a * k_lvl_a * (1 - k_mix) + a_osc_b * k_lvl_b * k_mix

  ; --- Sub oscillator (sine, -1 octave) ---
  a_sub oscili k_sub_lvl, icps * 0.5, gi_sine
  a_osc = a_osc + a_sub

  ; --- Noise layer ---
  a_noise noise k_nse_lvl * 0.3, 0
  a_osc = a_osc + a_noise

  ; --- Filter ---
  ; Key tracking: higher notes get brighter filter
  k_keytrk_hz = (icps - 261.63) * k_keytrk * 8
  k_filt_cut = k_cut + k_flt_env * k_envamt * 8000 + k_keytrk_hz
  k_filt_cut limit k_filt_cut, 60, 18000

  a_filt moogladder a_osc, k_filt_cut, k_reso

  ; --- Apply amp envelope + velocity ---
  a_out = a_filt * k_amp_env * ivel

  ; --- Warmth: saturation + low shelf boost ---
  if k_warmth > 0.01 then
    a_out = tanh(a_out * (1 + k_warmth * 2))
    a_low butterlp a_out, 200
    a_out = a_out + a_low * k_warmth * 0.4
  endif

  ; --- Master low pass filter ---
  a_out butterlp a_out, k_lpf

  ; --- Stereo spread: slight pan jitter from velocity ---
  k_pan = 0.5 + (ivel - 0.5) * 0.15
  aL = a_out * (1 - k_pan)
  aR = a_out * k_pan

  ; --- Master volume + soft clip ---
  aL = tanh(aL * k_vol)
  aR = tanh(aR * k_vol)

  ; --- DC block ---
  aL dcblock aL
  aR dcblock aR

  ; --- Direct out ---
  outs aL, aR

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
    kOk channelStateSave "fm-synth-rig-preset.json"
    chnset k(0), "preset_save"
    printks "Preset saved to fm-synth-rig-preset.json\\n", 0
  endif

  if k_ld == 1 then
    kOk channelStateRecall "fm-synth-rig-preset.json"
    chnset k(0), "preset_load"
    printks "Preset loaded from fm-synth-rig-preset.json\\n", 0
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
  k_time     chnget "dly_time"
  k_fb       chnget "dly_fb"
  k_wet      chnget "dly_wet"
  k_mod_dep  chnget "dly_mod"
  k_rvb_send chnget "dly_rvb_send"

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

  ; --- Output ---
  outs a_tap_L * k_wet, a_tap_R * k_wet

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
; LFO modulator + effects always on; instr 1 is MIDI-triggered
i 90 0 [60*60*4]   ; LFO modulator
i 95 0 [60*60*4]   ; preset manager
i 98 0 [60*60*4]   ; ping-pong delay
i 99 0 [60*60*4]   ; reverb
e
</CsScore>
</CsoundSynthesizer>
