<Cabbage>
form caption("Tanpura Drone Rig — Modular Sound Design") size(820, 810), colour(30, 30, 50), pluginId("sdri"), guiMode("queue")

; Header
label bounds(10, 8, 800, 25) text("TANPURA DRONE RIG") fontColour(224, 122, 95) fontSize(18) align("left")
label bounds(10, 32, 800, 18) text("Generative Ambient — Modular Prototyping Environment") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60–225): SYNTH — Tanpura controls
;=====================================================================

; Tuning
groupbox bounds(10, 60, 200, 165) text("TUNING") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 30, 55, 55) channel("fund_freq") range(40, 200, 60, 0.5, 0.1) text("Root Hz") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(72, 30, 55, 55) channel("pa_ratio") range(1.3, 1.55, 1.5, 1, 0.001) text("Pa Ratio") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(134, 30, 55, 55) channel("detune") range(0, 4, 1.2, 1, 0.1) text("Detune") textColour(200,200,220) trackerColour(224, 122, 95)
    label bounds(10, 90, 180, 55) text("Pa=5th, Sa x2, Sa low octave") fontColour(140, 140, 160) fontSize(10) align("left")
}

; Jivari
groupbox bounds(215, 60, 200, 165) text("JIVARI (BRIDGE)") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 30, 55, 55) channel("jivari_amt") range(0, 1, 0.45, 1, 0.01) text("Amount") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(72, 30, 55, 55) channel("jivari_bright") range(0, 1, 0.5, 1, 0.01) text("Bright") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(134, 30, 55, 55) channel("jivari_asym") range(0, 1, 0.3, 1, 0.01) text("Asymmetry") textColour(200,200,220) trackerColour(224, 122, 95)
    label bounds(10, 90, 180, 55) text("Curved bridge buzz model") fontColour(140, 140, 160) fontSize(10) align("left")
}

; Overtones
groupbox bounds(420, 60, 200, 165) text("OVERTONES") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 30, 55, 55) channel("num_harmonics") range(6, 24, 14, 1, 1) text("N Harms") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(72, 30, 55, 55) channel("harm_decay") range(0.2, 0.95, 0.7, 1, 0.01) text("Decay") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(134, 30, 55, 55) channel("harm_motion") range(0, 1, 0.4, 1, 0.01) text("Motion") textColour(200,200,220) trackerColour(224, 122, 95)
    label bounds(10, 90, 180, 55) text("Harmonic series shaping") fontColour(140, 140, 160) fontSize(10) align("left")
}

; Excitation
groupbox bounds(625, 60, 185, 165) text("EXCITATION") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 30, 42, 42) channel("pluck_rate") range(0.1, 2, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(48, 30, 42, 42) channel("pluck_bright") range(0, 1, 0.6, 1, 0.01) text("Bright") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(91, 30, 42, 42) channel("pluck_rand") range(0, 1, 0.3, 1, 0.01) text("Random") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(134, 30, 42, 42) channel("pluck_depth") range(0, 1, 0.65, 1, 0.01) text("Depth") textColour(200,200,220) trackerColour(224, 122, 95)
    label bounds(5, 78, 175, 65) text("Pluck cycle. Depth 0 = smooth sustained drone. Depth 1 = full pluck pulse.") fontColour(140, 140, 160) fontSize(10) align("left")
}

;=====================================================================
; ROW 2 (y=235–330): ENVELOPES — Amp + Mod
;=====================================================================

; Amp Envelope + Cycle
groupbox bounds(10, 235, 395, 95) text("AMP ENVELOPE") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 45, 45) channel("amp_a") range(0.001, 10, 0.01, 0.3, 0.001) text("A") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(60, 25, 45, 45) channel("amp_d") range(0.001, 10, 0.6, 0.3, 0.001) text("D") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(110, 25, 45, 45) channel("amp_s") range(0, 1, 1, 1, 0.01) text("S") textColour(200,200,220) trackerColour(224, 160, 80)
    combobox bounds(165, 28, 60, 20) channel("env_loop") value(1) text("Off", "Free", "BPM")
    rslider bounds(230, 25, 45, 45) channel("env_rate") range(0.1, 20, 2, 0.4, 0.01) text("Rate Hz") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(280, 25, 45, 45) channel("env_bpm") range(20, 240, 120, 1, 1) text("BPM") textColour(200,200,220) trackerColour(224, 160, 80)
    hslider bounds(165, 55, 220, 12) channel("amp_env_out") range(0, 1, 0) colour(224, 160, 80) trackerColour(224, 160, 80) active(0)
    label bounds(165, 72, 220, 14) text("Off=one-shot, Free=Hz rate, BPM=tempo sync") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Mod Envelope
groupbox bounds(410, 235, 300, 95) text("MOD ENVELOPE") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 45, 45) channel("mod_a") range(0.001, 10, 0.001, 0.3, 0.001) text("A") textColour(200,200,220) trackerColour(180, 120, 224)
    rslider bounds(60, 25, 45, 45) channel("mod_d") range(0.001, 10, 0.6, 0.3, 0.001) text("D") textColour(200,200,220) trackerColour(180, 120, 224)
    rslider bounds(110, 25, 45, 45) channel("mod_peak") range(0, 1, 1, 1, 0.01) text("Peak") textColour(200,200,220) trackerColour(180, 120, 224)
    rslider bounds(160, 25, 45, 45) channel("mod_s") range(0, 1, 0, 1, 0.01) text("S") textColour(200,200,220) trackerColour(180, 120, 224)
    combobox bounds(215, 30, 75, 20) channel("mod_env_target") value(1) text("None", "Amount", "Bright", "Decay", "Motion", "Tone", "Warmth", "Rate", "Root", "Pa", "Detune")
    hslider bounds(215, 55, 75, 12) channel("mod_env_out") range(0, 1, 0) colour(180, 120, 224) trackerColour(180, 120, 224) active(0)
    label bounds(215, 72, 75, 14) text("Route to knob") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Retrigger button
button bounds(715, 235, 95, 35) channel("env_retrig") text("Retrigger", "Retrigger") value(0) colour:0(60, 60, 80) colour:1(224, 122, 95) fontColour:0(200, 200, 220) fontColour:1(255, 255, 255)
label bounds(715, 275, 95, 45) text("Restarts both envelopes from zero") fontColour(140, 140, 160) fontSize(9) align("centre")

;=====================================================================
; ROW 3 (y=340–510): MODULATOR — 4 LFO columns
;=====================================================================

groupbox bounds(10, 340, 800, 170) text("MODULATION") colour(35, 35, 55) fontColour(200, 200, 220) {

    ; LFO 1
    label bounds(15, 22, 180, 14) text("LFO 1") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(15, 38, 45, 45) channel("lfo1_freq") range(0.01, 10, 0.1, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(62, 38, 45, 45) channel("lfo1_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(112, 40, 78, 20) channel("lfo1_wave") value(1) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(112, 64, 78, 20) channel("lfo1_target") value(1) text("None", "Amount", "Bright", "Decay", "Motion", "Tone", "Warmth", "Rate", "Root", "Pa", "Detune")
    hslider bounds(15, 90, 175, 12) channel("lfo1_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; LFO 2
    label bounds(210, 22, 180, 14) text("LFO 2") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(210, 38, 45, 45) channel("lfo2_freq") range(0.01, 10, 0.07, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(257, 38, 45, 45) channel("lfo2_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(307, 40, 78, 20) channel("lfo2_wave") value(2) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(307, 64, 78, 20) channel("lfo2_target") value(1) text("None", "Amount", "Bright", "Decay", "Motion", "Tone", "Warmth", "Rate", "Root", "Pa", "Detune")
    hslider bounds(210, 90, 175, 12) channel("lfo2_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; LFO 3
    label bounds(405, 22, 180, 14) text("LFO 3") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(405, 38, 45, 45) channel("lfo3_freq") range(0.01, 10, 0.05, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(452, 38, 45, 45) channel("lfo3_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(502, 40, 78, 20) channel("lfo3_wave") value(4) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(502, 64, 78, 20) channel("lfo3_target") value(1) text("None", "Amount", "Bright", "Decay", "Motion", "Tone", "Warmth", "Rate", "Root", "Pa", "Detune")
    hslider bounds(405, 90, 175, 12) channel("lfo3_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; LFO 4
    label bounds(600, 22, 190, 14) text("LFO 4") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(600, 38, 45, 45) channel("lfo4_freq") range(0.01, 10, 0.15, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(647, 38, 45, 45) channel("lfo4_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(697, 40, 78, 20) channel("lfo4_wave") value(6) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(697, 64, 78, 20) channel("lfo4_target") value(1) text("None", "Amount", "Bright", "Decay", "Motion", "Tone", "Warmth", "Rate", "Root", "Pa", "Detune")
    hslider bounds(600, 90, 175, 12) channel("lfo4_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; Hint
    label bounds(15, 108, 780, 40) text("Amp starts at 0 (off). Pick a Wave shape and Target, then raise Amp. Green bars show LFO output.") fontColour(130, 130, 150) fontSize(10) align("left")
}

;=====================================================================
; ROW 4 (y=520–660): EFFECTS + MASTER
;=====================================================================

; Delay
groupbox bounds(10, 520, 265, 135) text("DELAY") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 28, 50, 50) channel("dly_time") range(0.05, 1.5, 0.4, 0.5, 0.01) text("Time") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(67, 28, 50, 50) channel("dly_fb") range(0, 0.9, 0.55, 1, 0.01) text("Feedback") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(124, 28, 50, 50) channel("dly_wet") range(0, 1, 0.4, 1, 0.01) text("Wet") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(181, 28, 50, 50) channel("dly_mod") range(0, 0.02, 0.003, 0.5, 0.001) text("Mod") textColour(200,200,220) trackerColour(100, 180, 224)
    label bounds(10, 88, 250, 30) text("Ping-pong delay with modulation") fontColour(140, 140, 160) fontSize(10) align("left")
}

; Reverb
groupbox bounds(280, 520, 200, 135) text("REVERB") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 28, 55, 55) channel("rvb_fb") range(0.3, 0.99, 0.88, 1, 0.01) text("Size") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(72, 28, 55, 55) channel("rvb_cut") range(1000, 14000, 7000, 0.4, 1) text("Tone") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(134, 28, 55, 55) channel("rvb_wet") range(0, 1, 0.5, 1, 0.01) text("Wet") textColour(200,200,220) trackerColour(100, 180, 224)
    label bounds(10, 93, 185, 25) text("reverbsc hall") fontColour(140, 140, 160) fontSize(10) align("left")
}

; Master
groupbox bounds(485, 520, 200, 135) text("MASTER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 28, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(72, 28, 55, 55) channel("master_lpf") range(200, 16000, 8000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(134, 28, 55, 55) channel("warmth") range(0, 1, 0.5, 1, 0.01) text("Warmth") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 93, 185, 25) text("Volume, filter, saturation") fontColour(140, 140, 160) fontSize(10) align("left")
}

; Sends + Width
groupbox bounds(690, 520, 120, 135) text("SENDS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 28, 50, 50) channel("dly_send") range(0, 1, 0.3, 1, 0.01) text("Delay") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(60, 28, 50, 50) channel("rvb_send") range(0, 1, 0.4, 1, 0.01) text("Reverb") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(33, 82, 50, 50) channel("stereo_width") range(0, 1, 0.6, 1, 0.01) text("Width") textColour(200,200,220) trackerColour(150, 150, 200)
}

;=====================================================================
; ROW 5 (y=665): DELAY EXTRAS
;=====================================================================

label bounds(10, 665, 100, 16) text("Delay extras:") fontColour(160, 160, 180) fontSize(11) align("left")
rslider bounds(120, 660, 50, 50) channel("dly_mod_rate") range(0.05, 2, 0.23, 0.5, 0.01) text("Mod Rate") textColour(200,200,220) trackerColour(100, 180, 224)
rslider bounds(180, 660, 50, 50) channel("dly_rvb_send") range(0, 1, 0.2, 1, 0.01) text("Dly>Rvb") textColour(200,200,220) trackerColour(100, 180, 224)

button bounds(630, 665, 85, 30) channel("preset_save") text("Save", "Save") value(0) colour:0(50, 50, 70) colour:1(100, 180, 224) fontColour:0(180, 180, 200) fontColour:1(255, 255, 255)
button bounds(720, 665, 85, 30) channel("preset_load") text("Load", "Load") value(0) colour:0(50, 50, 70) colour:1(100, 180, 224) fontColour:0(180, 180, 200) fontColour:1(255, 255, 255)
label bounds(630, 698, 175, 16) text("Save/load preset to JSON") fontColour(140, 140, 160) fontSize(9) align("centre")

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

; Sine table for gbuzz
gi_sine ftgen 0, 0, 8192, 10, 1

;=====================================================================
; GLOBAL SEND BUSES
;=====================================================================
ga_rvb_L init 0
ga_rvb_R init 0
ga_dly_L init 0
ga_dly_R init 0

;=====================================================================
; GLOBAL MODULATION ACCUMULATORS (synth targets only)
; Reset each k-cycle by instr 90. LFOs + mod envelope add here.
;=====================================================================
gk_mod_jivari      init 0
gk_mod_jivari_br   init 0
gk_mod_harm_decay  init 0
gk_mod_harm_motion init 0
gk_mod_master_lpf  init 0
gk_mod_warmth      init 0
gk_mod_pluck_rate  init 0
gk_mod_root        init 0
gk_mod_pa          init 0
gk_mod_detune      init 0

; (Amp + mod envelopes are local to instr 1 — no globals needed)


;==============================================================
; SYNC MACROS — Force widget visual update after preset recall.
; guiMode("queue") means chnset alone doesn't update visuals.
; Read channel back → cabbageSetValue to push to GUI queue.
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
;
; Uses phasor internally so waveform can be switched at k-rate
; (unlike the built-in lfo opcode whose type is i-rate only).
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
; UDO: LFORoute — Route a modulation value to a target
;
; ktgt: combobox value (1=None, 2=Amount .. 8=Rate, 9=Root, 10=Pa, 11=Detune)
; kval: modulation value (scaled by caller's amp)
;
; Scaling per target keeps modulation musically useful.
;==============================================================
opcode LFORoute, 0, kk
  ktgt, kval xin

  if ktgt == 2 then
    gk_mod_jivari = gk_mod_jivari + kval * 0.3
  elseif ktgt == 3 then
    gk_mod_jivari_br = gk_mod_jivari_br + kval * 0.3
  elseif ktgt == 4 then
    gk_mod_harm_decay = gk_mod_harm_decay + kval * 0.2
  elseif ktgt == 5 then
    gk_mod_harm_motion = gk_mod_harm_motion + kval * 0.3
  elseif ktgt == 6 then
    gk_mod_master_lpf = gk_mod_master_lpf + kval * 3000
  elseif ktgt == 7 then
    gk_mod_warmth = gk_mod_warmth + kval * 0.3
  elseif ktgt == 8 then
    gk_mod_pluck_rate = gk_mod_pluck_rate + kval * 0.3
  elseif ktgt == 9 then
    gk_mod_root = gk_mod_root + kval * 20
  elseif ktgt == 10 then
    gk_mod_pa = gk_mod_pa + kval * 0.1
  elseif ktgt == 11 then
    gk_mod_detune = gk_mod_detune + kval * 2
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
  gk_mod_jivari      = 0
  gk_mod_jivari_br   = 0
  gk_mod_harm_decay  = 0
  gk_mod_harm_motion = 0
  gk_mod_master_lpf  = 0
  gk_mod_warmth      = 0
  gk_mod_pluck_rate  = 0
  gk_mod_root        = 0
  gk_mod_pa          = 0
  gk_mod_detune      = 0

  ; --- LFO 1 ---
  k_frq1  chnget "lfo1_freq"
  k_amp1  chnget "lfo1_amp"
  k_wav1  chnget "lfo1_wave"
  k_tgt1  chnget "lfo1_target"
  k_val1  LFOWave k_amp1, k_frq1, k_wav1
  LFORoute k_tgt1, k_val1
  cabbageSetValue "lfo1_out", k_val1

  ; --- LFO 2 ---
  k_frq2  chnget "lfo2_freq"
  k_amp2  chnget "lfo2_amp"
  k_wav2  chnget "lfo2_wave"
  k_tgt2  chnget "lfo2_target"
  k_val2  LFOWave k_amp2, k_frq2, k_wav2
  LFORoute k_tgt2, k_val2
  cabbageSetValue "lfo2_out", k_val2

  ; --- LFO 3 ---
  k_frq3  chnget "lfo3_freq"
  k_amp3  chnget "lfo3_amp"
  k_wav3  chnget "lfo3_wave"
  k_tgt3  chnget "lfo3_target"
  k_val3  LFOWave k_amp3, k_frq3, k_wav3
  LFORoute k_tgt3, k_val3
  cabbageSetValue "lfo3_out", k_val3

  ; --- LFO 4 ---
  k_frq4  chnget "lfo4_freq"
  k_amp4  chnget "lfo4_amp"
  k_wav4  chnget "lfo4_wave"
  k_tgt4  chnget "lfo4_target"
  k_val4  LFOWave k_amp4, k_frq4, k_wav4
  LFORoute k_tgt4, k_val4
  cabbageSetValue "lfo4_out", k_val4

endin


;==============================================================
; UDO: TanpuraString — Single string with jivari
;
; Uses gbuzz for harmonic series, then models jivari
; (curved bridge buzz) as waveshaping + slow AM.
;==============================================================
opcode TanpuraString, aa, kkkkkkkkk
  kfreq, kjivari, kjbright, kjasym, knharm, khdecay, kmotion, kpluckbright, kpan xin

  ; Harmonic series via gbuzz
  araw gbuzz 1, kfreq, knharm, 1, khdecay, gi_sine

  ; Jivari: slow AM simulates string touching curved bridge
  kjiv_rate = 0.12 + kfreq * 0.0005
  kjiv_mod  lfo 1, kjiv_rate, 1
  kjiv_mod  = (kjiv_mod + kjasym * kjiv_mod * kjiv_mod) / (1 + kjasym)
  kjiv_env  = 1 + kjivari * kjiv_mod * 0.5

  ; Soft saturation for nonlinear bridge contact
  adriven   = araw * kjiv_env * (1 + kjivari * 1.5)
  ajivari   = tanh(adriven)

  ; Motion: slow random filter sweep
  kfilt_rnd1 randi kmotion * 1500, 0.07
  kfilt_rnd2 randi kmotion * 800, 0.03
  kcutoff    = 800 + kjbright * 6000 + kfilt_rnd1 + kfilt_rnd2
  kcutoff    limit kcutoff, 300, 14000

  aout butterlp ajivari, kcutoff

  ; Stereo panning
  aL = aout * (1 - kpan)
  aR = aout * kpan

  xout aL, aR
endop


;==============================================================
; SYNTH — instr 1 (Tanpura Drone)
;
; 4 strings with pluck envelopes -> master processing ->
; send buses (delay + reverb). Effects handled by 98/99.
; Amp + mod envelopes are local (no global ordering issues).
;==============================================================
instr 1

  ; --- Read base parameters ---
  kfund_base    chnget "fund_freq"
  kpa           chnget "pa_ratio"
  kdetune       chnget "detune"
  kjivari_base  chnget "jivari_amt"
  kjbright_base chnget "jivari_bright"
  kjasym        chnget "jivari_asym"
  knharm        chnget "num_harmonics"
  khdecay_base  chnget "harm_decay"
  kmotion_base  chnget "harm_motion"
  kpluck_base   chnget "pluck_rate"
  kpluckbr      chnget "pluck_bright"
  kpluckrn      chnget "pluck_rand"
  kpluck_depth  chnget "pluck_depth"
  kwidth        chnget "stereo_width"
  kvol          chnget "master_vol"
  klpf_base     chnget "master_lpf"
  kwarmth_base  chnget "warmth"
  kdly_send     chnget "dly_send"
  krvb_send     chnget "rvb_send"

  ; ============================================================
  ; ENVELOPES (local to instr 1 — no global ordering issues)
  ;
  ; Amp: 0 → 1 (attack) → sustain (decay) → hold
  ; Mod: 0 → peak (attack) → sustain*peak (decay) → hold
  ;
  ; Loop modes:
  ;   Off (1)  = one-shot, hold at sustain forever
  ;   Free (2) = auto-retrigger at env_rate Hz
  ;   BPM (3)  = auto-retrigger synced to env_bpm
  ;
  ; Manual Retrigger button always works in any mode.
  ; ============================================================
  k_loop_mode chnget "env_loop"
  k_loop_rate chnget "env_rate"
  k_loop_bpm  chnget "env_bpm"

  ; Auto-retrigger via metro
  k_auto_trig = 0
  if k_loop_mode == 2 then
    k_auto_trig metro k_loop_rate
  elseif k_loop_mode == 3 then
    k_auto_trig metro (k_loop_bpm / 60)
  endif

  ; Manual retrigger (rising edge above 0.5)
  k_retrig chnget "env_retrig"
  k_man_trig trigger k_retrig, 0.5, 0

  ; Combined trigger
  if k_auto_trig + k_man_trig > 0 then
    reinit restart_envs
  endif

restart_envs:
  ; Amp envelope
  i_a_atk chnget "amp_a"
  i_a_dec chnget "amp_d"
  i_a_sus chnget "amp_s"
  i_a_atk = (i_a_atk < 0.001) ? 0.001 : i_a_atk
  i_a_dec = (i_a_dec < 0.001) ? 0.001 : i_a_dec
  i_a_hold = p3 - i_a_atk - i_a_dec
  i_a_hold = (i_a_hold < 0.01) ? 0.01 : i_a_hold
  k_amp_env linseg 0, i_a_atk, 1, i_a_dec, i_a_sus, i_a_hold, i_a_sus

  ; Mod envelope
  i_m_atk  chnget "mod_a"
  i_m_dec  chnget "mod_d"
  i_m_peak chnget "mod_peak"
  i_m_sus  chnget "mod_s"
  i_m_atk  = (i_m_atk < 0.001) ? 0.001 : i_m_atk
  i_m_dec  = (i_m_dec < 0.001) ? 0.001 : i_m_dec
  i_m_hold = p3 - i_m_atk - i_m_dec
  i_m_hold = (i_m_hold < 0.01) ? 0.01 : i_m_hold
  i_m_sus_lvl = i_m_sus * i_m_peak
  k_mod_env linseg 0, i_m_atk, i_m_peak, i_m_dec, i_m_sus_lvl, i_m_hold, i_m_sus_lvl

rireturn

  ; Envelope output meters
  cabbageSetValue "amp_env_out", k_amp_env
  cabbageSetValue "mod_env_out", k_mod_env

  ; --- Apply LFO modulation from globals (set by instr 90) ---
  kjivari  = kjivari_base + gk_mod_jivari
  kjbright = kjbright_base + gk_mod_jivari_br
  khdecay  = khdecay_base + gk_mod_harm_decay
  kmotion  = kmotion_base + gk_mod_harm_motion
  klpf     = klpf_base + gk_mod_master_lpf
  kwarmth  = kwarmth_base + gk_mod_warmth
  kpluck   = kpluck_base + gk_mod_pluck_rate
  kfund    = kfund_base + gk_mod_root
  kpa_mod  = kpa + gk_mod_pa
  kdet_mod = kdetune + gk_mod_detune

  ; --- Apply mod envelope directly to target parameter ---
  k_mod_tgt chnget "mod_env_target"
  if k_mod_tgt == 2 then
    kjivari = kjivari + k_mod_env * 0.3
  elseif k_mod_tgt == 3 then
    kjbright = kjbright + k_mod_env * 0.3
  elseif k_mod_tgt == 4 then
    khdecay = khdecay + k_mod_env * 0.2
  elseif k_mod_tgt == 5 then
    kmotion = kmotion + k_mod_env * 0.3
  elseif k_mod_tgt == 6 then
    klpf = klpf + k_mod_env * 3000
  elseif k_mod_tgt == 7 then
    kwarmth = kwarmth + k_mod_env * 0.3
  elseif k_mod_tgt == 8 then
    kpluck = kpluck + k_mod_env * 0.3
  elseif k_mod_tgt == 9 then
    kfund = kfund + k_mod_env * 20
  elseif k_mod_tgt == 10 then
    kpa_mod = kpa_mod + k_mod_env * 0.1
  elseif k_mod_tgt == 11 then
    kdet_mod = kdet_mod + k_mod_env * 2
  endif

  ; --- Clamp all modulated parameters ---
  kjivari  limit kjivari, 0, 1
  kjbright limit kjbright, 0, 1
  khdecay  limit khdecay, 0.2, 0.95
  kmotion  limit kmotion, 0, 1
  klpf     limit klpf, 200, 16000
  kwarmth  limit kwarmth, 0, 1
  kpluck   limit kpluck, 0.1, 2
  kfund    limit kfund, 20, 400
  kpa_mod  limit kpa_mod, 1.0, 2.0
  kdet_mod limit kdet_mod, -10, 10

  ; --- 4 strings with traditional tuning ---
  kfreq1 = kfund * kpa_mod              ; Pa string
  kfreq2 = kfund * 2                    ; Sa upper
  kfreq3 = kfund * 2 + kdet_mod         ; Sa upper (detuned)
  kfreq4 = kfund                        ; Sa lower octave

  ; Stereo placement
  kpan1 = 0.5 - kwidth * 0.35
  kpan2 = 0.5 + kwidth * 0.15
  kpan3 = 0.5 - kwidth * 0.15
  kpan4 = 0.5 + kwidth * 0.35

  ; --- Generate strings ---
  aL1, aR1 TanpuraString kfreq1, kjivari, kjbright, kjasym, knharm, khdecay, kmotion, kpluckbr, kpan1
  aL2, aR2 TanpuraString kfreq2, kjivari, kjbright, kjasym, knharm, khdecay, kmotion, kpluckbr, kpan2
  aL3, aR3 TanpuraString kfreq3, kjivari, kjbright, kjasym, knharm, khdecay, kmotion, kpluckbr, kpan3
  aL4, aR4 TanpuraString kfreq4, kjivari * 0.7, kjbright * 0.8, kjasym, knharm * 0.7, khdecay, kmotion, kpluckbr, kpan4

  ; --- Pluck envelopes ---
  kperiod1 = (1/kpluck) * (1 + kpluckrn * (randi:k(0.3, 0.5) ))
  kperiod2 = (1/kpluck) * (1 + kpluckrn * (randi:k(0.3, 0.7) ))
  kperiod3 = (1/kpluck) * 1.02 * (1 + kpluckrn * (randi:k(0.3, 0.6) ))
  kperiod4 = (1/kpluck) * 1.5 * (1 + kpluckrn * (randi:k(0.3, 0.4) ))

  kphase1 phasor 1/kperiod1
  kphase2 phasor 1/kperiod2
  kphase3 phasor 1/kperiod3
  kphase4 phasor 1/kperiod4

  ; Envelope shape: sharp attack, slow decay
  ksharp = 3 + kpluckbr * 12
  kenv1 = (1 - kphase1) ^ ksharp
  kenv2 = (1 - kphase2) ^ ksharp
  kenv3 = (1 - kphase3) ^ ksharp
  kenv4 = (1 - kphase4) ^ ksharp

  ; Depth controls pluck envelope amount:
  ;   depth=0 → aenv=1 (smooth sustained drone, no pulse)
  ;   depth=1 → aenv=0.35+kenv*0.65 (full pluck cycling)
  k_pbase  = 1 - kpluck_depth * 0.65
  k_prange = kpluck_depth * 0.65
  aenv1 = a(k_pbase + kenv1 * k_prange)
  aenv2 = a(k_pbase + kenv2 * k_prange)
  aenv3 = a(k_pbase + kenv3 * k_prange)
  aenv4 = a(k_pbase + kenv4 * k_prange)

  ; --- Mix strings ---
  aL = aL1*aenv1 + aL2*aenv2 + aL3*aenv3 + aL4*aenv4
  aR = aR1*aenv1 + aR2*aenv2 + aR3*aenv3 + aR4*aenv4

  ; --- Warmth: saturation + low shelf boost ---
  if kwarmth > 0.01 then
    aL = tanh(aL * (1 + kwarmth * 2))
    aR = tanh(aR * (1 + kwarmth * 2))
    aLlow butterlp aL, 200
    aRlow butterlp aR, 200
    aL = aL + aLlow * kwarmth * 0.5
    aR = aR + aRlow * kwarmth * 0.5
  endif

  ; --- Master low pass filter ---
  aL butterlp aL, klpf
  aR butterlp aR, klpf

  ; --- Apply amp envelope ---
  aL = aL * k_amp_env
  aR = aR * k_amp_env

  ; --- Master volume + soft clip ---
  aL = tanh(aL * kvol * 0.3)
  aR = tanh(aR * kvol * 0.3)

  ; --- DC block ---
  aL dcblock aL
  aR dcblock aR

  ; --- Direct out ---
  outs aL, aR

  ; --- Send to effects buses ---
  ga_dly_L = ga_dly_L + aL * kdly_send
  ga_dly_R = ga_dly_R + aR * kdly_send
  ga_rvb_L = ga_rvb_L + aL * krvb_send
  ga_rvb_R = ga_rvb_R + aR * krvb_send

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

  ; GUI refresh flags (for syncing widget visuals after recall)
  k_gui_refresh init 0
  k_gui_delay   init 0

  ; Auto-load last saved preset on startup (if file exists)
  i_exists filevalid "/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/tanpura-drone-rig-preset.json"
  k_init init 0
  if k_init == 0 && i_exists == 1 then
    kOk = cabbageChannelStateRecall:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/tanpura-drone-rig-preset.json")
    printks "Auto-loaded preset from tanpura-drone-rig-preset.json\\n", 0
    k_gui_refresh = 1
    k_init = 1
  elseif k_init == 0 then
    k_init = 1
  endif

  k_sv trigger k_save, 0.5, 0
  k_ld trigger k_load, 0.5, 0

  if k_sv == 1 then
    kOk = cabbageChannelStateSave:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/tanpura-drone-rig-preset.json")
    chnset k(0), "preset_save"
    printks "Preset saved to tanpura-drone-rig-preset.json\\n", 0
  endif

  if k_ld == 1 then
    kOk = cabbageChannelStateRecall:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/tanpura-drone-rig-preset.json")
    chnset k(0), "preset_load"
    printks "Preset loaded from tanpura-drone-rig-preset.json\\n", 0
    k_gui_refresh = 1
  endif

  ; --- GUI refresh: sync widget visuals after preset recall ---
  if k_gui_refresh == 1 then
    k_gui_delay += 1
    if k_gui_delay >= 5 then
      k_gui_refresh = 0
      k_gui_delay   = 0

      ; Sync LFOs
      $SYNC_LFO(1)
      $SYNC_LFO(2)
      $SYNC_LFO(3)
      $SYNC_LFO(4)

      ; Sync rig-specific widgets
      $SYNC_WIDGET(fund_freq)
      $SYNC_WIDGET(pa_ratio)
      $SYNC_WIDGET(detune)
      $SYNC_WIDGET(jivari_amt)
      $SYNC_WIDGET(jivari_bright)
      $SYNC_WIDGET(jivari_asym)
      $SYNC_WIDGET(num_harmonics)
      $SYNC_WIDGET(harm_decay)
      $SYNC_WIDGET(harm_motion)
      $SYNC_WIDGET(pluck_rate)
      $SYNC_WIDGET(pluck_bright)
      $SYNC_WIDGET(pluck_rand)
      $SYNC_WIDGET(pluck_depth)
      $SYNC_WIDGET(amp_a)
      $SYNC_WIDGET(amp_d)
      $SYNC_WIDGET(amp_s)
      $SYNC_WIDGET(env_loop)
      $SYNC_WIDGET(env_rate)
      $SYNC_WIDGET(env_bpm)
      $SYNC_WIDGET(mod_a)
      $SYNC_WIDGET(mod_d)
      $SYNC_WIDGET(mod_peak)
      $SYNC_WIDGET(mod_s)
      $SYNC_WIDGET(mod_env_target)
      $SYNC_WIDGET(dly_time)
      $SYNC_WIDGET(dly_fb)
      $SYNC_WIDGET(dly_wet)
      $SYNC_WIDGET(dly_mod)
      $SYNC_WIDGET(dly_mod_rate)
      $SYNC_WIDGET(rvb_fb)
      $SYNC_WIDGET(rvb_cut)
      $SYNC_WIDGET(rvb_wet)
      $SYNC_WIDGET(master_vol)
      $SYNC_WIDGET(master_lpf)
      $SYNC_WIDGET(warmth)
      $SYNC_WIDGET(dly_send)
      $SYNC_WIDGET(rvb_send)
      $SYNC_WIDGET(dly_rvb_send)
      $SYNC_WIDGET(stereo_width)
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
  k_time     chnget "dly_time"
  k_fb       chnget "dly_fb"
  k_wet      chnget "dly_wet"
  k_mod_dep  chnget "dly_mod"
  k_mod_rate chnget "dly_mod_rate"
  k_rvb_send chnget "dly_rvb_send"

  ; --- Modulation oscillator ---
  k_mod lfo k_mod_dep, k_mod_rate, 0

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
; Score order: modulator -> synth (w/ envelopes) -> delay -> reverb
i 90 0 [60*60*4]   ; modulator (LFOs — sets mod globals)
i 1  0 [60*60*4]   ; tanpura synth (envelopes are local)
i 95 0 [60*60*4]   ; preset manager
i 98 0 [60*60*4]   ; ping-pong delay
i 99 0 [60*60*4]   ; reverb
e
</CsScore>
</CsoundSynthesizer>
