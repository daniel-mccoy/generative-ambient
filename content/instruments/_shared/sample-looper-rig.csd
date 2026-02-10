<Cabbage>
form caption("Sample Looper Rig — Field Recording Looper") size(820, 720), colour(30, 30, 50), pluginId("slrg"), guiMode("queue")

; Header
label bounds(10, 8, 800, 25) text("SAMPLE LOOPER RIG") fontColour(180, 140, 224) fontSize(18) align("left")
label bounds(10, 32, 800, 18) text("Generative Ambient — Crossfade Loop Player for Field Recordings") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): SAMPLE + LOOP
;=====================================================================

; Sample
groupbox bounds(10, 60, 340, 130) text("SAMPLE") colour(40, 40, 60) fontColour(200, 200, 220) {
    filebutton bounds(10, 28, 170, 25) channel("sample_path") text("Browse WAV...") mode("file") file("/Users/daniel/Music/Ableton/User Library/Samples") colour(60, 60, 80) fontColour(180, 180, 200)
    button bounds(185, 28, 55, 25) channel("load_sample") text("Load", "Load") value(0) colour:0(60, 60, 80) colour:1(180, 140, 224) fontColour:0(180, 180, 200) fontColour:1(255, 255, 255)
    rslider bounds(255, 20, 55, 55) channel("sample_gain") range(0, 2, 1, 0.5, 0.01) text("Gain") textColour(200,200,220) trackerColour(180, 140, 224)
    label bounds(10, 58, 240, 16) text("Default: DPA - Binaural Rain.wav") fontColour(150, 150, 170) fontSize(10) align("left")
    label bounds(10, 76, 330, 16) text("Browse for WAV file, then click Load to apply.") fontColour(130, 130, 150) fontSize(9) align("left")
    label bounds(10, 94, 330, 16) text("Edit CSD line ~165 to change the default sample path.") fontColour(130, 130, 150) fontSize(9) align("left")
}

; Loop
groupbox bounds(355, 60, 455, 130) text("LOOP") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("loop_start") range(0, 0.99, 0, 1, 0.01) text("Start") textColour(200,200,220) trackerColour(180, 140, 224)
    rslider bounds(70, 25, 55, 55) channel("loop_end") range(0.01, 1, 1, 1, 0.01) text("End") textColour(200,200,220) trackerColour(180, 140, 224)
    rslider bounds(130, 25, 55, 55) channel("loop_xfade") range(0.01, 5, 0.5, 0.5, 0.01) text("Xfade") textColour(200,200,220) trackerColour(180, 140, 224)
    rslider bounds(190, 25, 55, 55) channel("loop_speed") range(0.1, 4, 1, 0.5, 0.01) text("Speed") textColour(200,200,220) trackerColour(180, 140, 224)
    combobox bounds(260, 28, 110, 20) channel("loop_mode") value(1) text("Forward", "Backward", "Palindrome")
    label bounds(260, 52, 110, 16) text("Loop Mode") fontColour(140, 140, 160) fontSize(9) align("centre")
    label bounds(10, 85, 440, 30) text("Start/End = normalized position (0-1). Xfade = crossfade (s). Speed = pitch ratio. Mode change resets playback.") fontColour(130, 130, 150) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=200): FILTER
;=====================================================================

; LP Filter
groupbox bounds(10, 200, 200, 95) text("LOW-PASS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(15, 25, 55, 55) channel("lp_cutoff") range(200, 16000, 12000, 0.3, 1) text("Cutoff") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(85, 25, 55, 55) channel("lp_reso") range(0, 0.9, 0, 1, 0.01) text("Reso") textColour(200,200,220) trackerColour(224, 160, 80)
}

; HP Filter
groupbox bounds(215, 200, 140, 95) text("HIGH-PASS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(15, 25, 55, 55) channel("hp_cutoff") range(20, 2000, 20, 0.3, 1) text("Cutoff") textColour(200,200,220) trackerColour(224, 160, 80)
}

; Stereo
groupbox bounds(360, 200, 140, 95) text("STEREO") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(15, 25, 55, 55) channel("stereo_width") range(0, 2, 1, 1, 0.01) text("Width") textColour(200,200,220) trackerColour(224, 160, 80)
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
    combobox bounds(112, 64, 78, 20) channel("lfo1_target") value(1) text("None", "LP Cut", "HP Cut", "Speed", "LoopSt", "LoopEnd", "Xfade", "Volume")
    hslider bounds(15, 90, 175, 12) channel("lfo1_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; LFO 2
    label bounds(210, 22, 180, 14) text("LFO 2") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(210, 38, 45, 45) channel("lfo2_freq") range(0.01, 10, 0.07, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(257, 38, 45, 45) channel("lfo2_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(307, 40, 78, 20) channel("lfo2_wave") value(2) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(307, 64, 78, 20) channel("lfo2_target") value(1) text("None", "LP Cut", "HP Cut", "Speed", "LoopSt", "LoopEnd", "Xfade", "Volume")
    hslider bounds(210, 90, 175, 12) channel("lfo2_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; LFO 3
    label bounds(405, 22, 180, 14) text("LFO 3") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(405, 38, 45, 45) channel("lfo3_freq") range(0.01, 10, 0.05, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(452, 38, 45, 45) channel("lfo3_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(502, 40, 78, 20) channel("lfo3_wave") value(4) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(502, 64, 78, 20) channel("lfo3_target") value(1) text("None", "LP Cut", "HP Cut", "Speed", "LoopSt", "LoopEnd", "Xfade", "Volume")
    hslider bounds(405, 90, 175, 12) channel("lfo3_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; LFO 4
    label bounds(600, 22, 190, 14) text("LFO 4") fontColour(180, 180, 200) fontSize(11) align("left")
    rslider bounds(600, 38, 45, 45) channel("lfo4_freq") range(0.01, 10, 0.15, 0.3, 0.01) text("Freq") textColour(200,200,220) trackerColour(120, 200, 150)
    rslider bounds(647, 38, 45, 45) channel("lfo4_amp") range(0, 1, 0, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(120, 200, 150)
    combobox bounds(697, 40, 78, 20) channel("lfo4_wave") value(6) text("Sine", "Triangle", "Saw Up", "Saw Down", "Square", "S&H", "Wander")
    combobox bounds(697, 64, 78, 20) channel("lfo4_target") value(1) text("None", "LP Cut", "HP Cut", "Speed", "LoopSt", "LoopEnd", "Xfade", "Volume")
    hslider bounds(600, 90, 175, 12) channel("lfo4_out") range(-1, 1, 0) colour(120, 200, 150) trackerColour(120, 200, 150) active(0)

    ; Hint
    label bounds(15, 108, 780, 40) text("Amp starts at 0 (off). Pick a Wave shape and Target, then raise Amp. Green bars show LFO output.") fontColour(130, 130, 150) fontSize(10) align("left")
}

;=====================================================================
; ROW 4 (y=485): EFFECTS + MASTER
;=====================================================================

; Delay
groupbox bounds(10, 485, 220, 135) text("DELAY") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 28, 48, 48) channel("dly_time") range(0.05, 1.5, 0.4, 0.5, 0.01) text("Time") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(55, 28, 48, 48) channel("dly_fb") range(0, 0.9, 0.55, 1, 0.01) text("FB") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(105, 28, 48, 48) channel("dly_wet") range(0, 1, 0.3, 1, 0.01) text("Wet") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(155, 28, 48, 48) channel("dly_mod") range(0, 0.02, 0.003, 0.5, 0.001) text("Mod") textColour(200,200,220) trackerColour(100, 180, 224)
    label bounds(5, 85, 210, 30) text("Ping-pong delay with modulation") fontColour(140, 140, 160) fontSize(10) align("left")
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
    rslider bounds(10, 28, 50, 50) channel("dly_send") range(0, 1, 0.25, 1, 0.01) text("Delay") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(65, 28, 50, 50) channel("rvb_send") range(0, 1, 0.45, 1, 0.01) text("Reverb") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(120, 28, 50, 50) channel("dly_rvb_send") range(0, 1, 0.2, 1, 0.01) text("Dly>Rvb") textColour(200,200,220) trackerColour(150, 150, 200)
    label bounds(10, 88, 170, 25) text("Effect send levels") fontColour(140, 140, 160) fontSize(10) align("left")
}

;=====================================================================
; ROW 5 (y=630): TRANSPORT + PRESETS
;=====================================================================

button bounds(10, 635, 100, 55) channel("loop_play") text("PLAY", "STOP") value(1) colour:0(60, 60, 80) colour:1(180, 140, 224) fontColour:0(180, 180, 200) fontColour:1(30, 30, 50)
label bounds(120, 640, 400, 18) text("Looper auto-plays on start. Toggle to mute/unmute.") fontColour(140, 140, 160) fontSize(10) align("left")
label bounds(120, 660, 400, 18) text("LFOs modulate loop points and filters for evolving textures.") fontColour(140, 140, 160) fontSize(10) align("left")

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

;=====================================================================
; SAMPLE TABLE — Edit the path below to change the default sample.
; Use the Browse + Load buttons in the GUI to load a different file.
;=====================================================================

; >>> CHANGE THIS PATH to point to your WAV file <<<
#define SAMPLE_PATH #"/Users/daniel/Music/Ableton/User Library/Samples/Field Recordings/DPA - Binaural Rain.wav"#

; Fallback silence tables (replaced on successful file load)
gi_sample_L ftgen 1, 0, 48000, 7, 0, 48000, 0
gi_sample_R ftgen 2, 0, 48000, 7, 0, 48000, 0
gi_sample_dur init 1

; Sine table for LFO oscili
gi_sine ftgen 0, 0, 8192, 10, 1

;=====================================================================
; GLOBAL SEND BUSES
;=====================================================================
ga_rvb_L init 0
ga_rvb_R init 0
ga_dly_L init 0
ga_dly_R init 0

;=====================================================================
; GLOBAL MODULATION ACCUMULATORS (looper targets)
; Reset each k-cycle by instr 90. LFOs add here.
;=====================================================================
gk_mod_lp_cut  init 0
gk_mod_hp_cut  init 0
gk_mod_speed   init 0
gk_mod_start   init 0
gk_mod_end     init 0
gk_mod_xfade   init 0
gk_mod_vol     init 0


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
; UDO: LFORouteLooper — Route modulation to looper targets
;
; ktgt: combobox value (1=None, 2=LP Cut, 3=HP Cut, 4=Speed,
;        5=LoopStart, 6=LoopEnd, 7=Xfade, 8=Volume)
;==============================================================
opcode LFORouteLooper, 0, kk
  ktgt, kval xin

  if ktgt == 2 then
    gk_mod_lp_cut = gk_mod_lp_cut + kval * 4000
  elseif ktgt == 3 then
    gk_mod_hp_cut = gk_mod_hp_cut + kval * 500
  elseif ktgt == 4 then
    gk_mod_speed = gk_mod_speed + kval * 0.5
  elseif ktgt == 5 then
    gk_mod_start = gk_mod_start + kval * 0.2
  elseif ktgt == 6 then
    gk_mod_end = gk_mod_end + kval * 0.2
  elseif ktgt == 7 then
    gk_mod_xfade = gk_mod_xfade + kval * 1
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
  gk_mod_lp_cut = 0
  gk_mod_hp_cut = 0
  gk_mod_speed  = 0
  gk_mod_start  = 0
  gk_mod_end    = 0
  gk_mod_xfade  = 0
  gk_mod_vol    = 0

  ; --- LFO 1 ---
  k_frq1  chnget "lfo1_freq"
  k_amp1  chnget "lfo1_amp"
  k_wav1  chnget "lfo1_wave"
  k_tgt1  chnget "lfo1_target"
  k_val1  LFOWave k_amp1, k_frq1, k_wav1
  LFORouteLooper k_tgt1, k_val1
  cabbageSetValue "lfo1_out", k_val1

  ; --- LFO 2 ---
  k_frq2  chnget "lfo2_freq"
  k_amp2  chnget "lfo2_amp"
  k_wav2  chnget "lfo2_wave"
  k_tgt2  chnget "lfo2_target"
  k_val2  LFOWave k_amp2, k_frq2, k_wav2
  LFORouteLooper k_tgt2, k_val2
  cabbageSetValue "lfo2_out", k_val2

  ; --- LFO 3 ---
  k_frq3  chnget "lfo3_freq"
  k_amp3  chnget "lfo3_amp"
  k_wav3  chnget "lfo3_wave"
  k_tgt3  chnget "lfo3_target"
  k_val3  LFOWave k_amp3, k_frq3, k_wav3
  LFORouteLooper k_tgt3, k_val3
  cabbageSetValue "lfo3_out", k_val3

  ; --- LFO 4 ---
  k_frq4  chnget "lfo4_freq"
  k_amp4  chnget "lfo4_amp"
  k_wav4  chnget "lfo4_wave"
  k_tgt4  chnget "lfo4_target"
  k_val4  LFOWave k_amp4, k_frq4, k_wav4
  LFORouteLooper k_tgt4, k_val4
  cabbageSetValue "lfo4_out", k_val4

endin


;==============================================================
; LOOPER VOICE — instr 1 (always-on)
;
; Plays a WAV file via flooper2 crossfade looper.
; Stereo: separate L/R tables from GEN01 channel selection.
; All loop parameters are k-rate for real-time modulation.
; Mode (fwd/bwd/palindrome) is i-rate — reinit on change.
;==============================================================
instr 1

  ; === READ ALL GUI PARAMETERS (k-rate, before reinit block) ===
  k_play_raw chnget "loop_play"
  k_play     port   k_play_raw, 0.05     ; 50ms fade to avoid clicks
  k_speed_b  chnget "loop_speed"
  k_start_b  chnget "loop_start"
  k_end_b    chnget "loop_end"
  k_xfade_b  chnget "loop_xfade"
  k_gain     chnget "sample_gain"

  ; Filter
  k_lp_cut_b chnget "lp_cutoff"
  k_lp_reso  chnget "lp_reso"
  k_hp_cut_b chnget "hp_cutoff"
  k_width    chnget "stereo_width"

  ; Master
  k_vol_b    chnget "master_vol"
  k_lpf      chnget "master_lpf"
  k_warmth   chnget "warmth"
  k_dly_send chnget "dly_send"
  k_rvb_send chnget "rvb_send"

  ; === APPLY LFO MODULATION ===
  k_lp_cut = k_lp_cut_b + gk_mod_lp_cut
  k_hp_cut = k_hp_cut_b + gk_mod_hp_cut
  k_speed  = k_speed_b  + gk_mod_speed
  k_start  = k_start_b  + gk_mod_start
  k_end    = k_end_b    + gk_mod_end
  k_xfade  = k_xfade_b  + gk_mod_xfade
  k_vol    = k_vol_b    + gk_mod_vol

  ; === CLAMP MODULATED PARAMETERS ===
  k_lp_cut limit k_lp_cut, 200, 16000
  k_hp_cut limit k_hp_cut, 20, 2000
  k_speed  limit k_speed, 0.05, 4
  k_start  limit k_start, 0, 0.98
  k_end    limit k_end, 0.02, 1
  k_xfade  limit k_xfade, 0.01, 5
  k_vol    limit k_vol, 0, 1

  ; === CONVERT LOOP POINTS TO SECONDS ===
  k_dur = gi_sample_dur
  k_start_sec = k_start * k_dur
  k_end_sec   = k_end * k_dur

  ; Ensure minimum loop length of 0.1s
  if k_end_sec - k_start_sec < 0.1 then
    k_end_sec = k_start_sec + 0.1
  endif

  ; Clamp crossfade to half the loop length
  k_loop_len = k_end_sec - k_start_sec
  k_xf_max = k_loop_len * 0.49
  if k_xfade > k_xf_max then
    k_xfade = k_xf_max
  endif

  ; === REINIT TRIGGERS ===
  ; Load button triggers file reload + looper reinit
  k_load_btn chnget "load_sample"
  k_load_trig trigger k_load_btn, 0.5, 0

  ; Mode change triggers looper reinit (imode is i-rate)
  k_mode chnget "loop_mode"
  k_mode_chg changed k_mode

  ; Skip mode-change reinit on very first k-cycle
  k_first_cycle init 1
  if k_first_cycle == 1 then
    k_mode_chg = 0
    k_first_cycle = 0
  endif

  ; Set flag via channel so init block knows Load was clicked
  if k_load_trig == 1 then
    chnset k(1), "_load_flag"
    reinit init_looper
  elseif k_mode_chg == 1 then
    reinit init_looper
  endif

  ; === INIT + PLAYBACK BLOCK ===
  ; flooper2 is INSIDE this reinit region so its internal state
  ; (read position, table ref) resets when a new file loads.
init_looper:

  ; --- Check if Load button was explicitly clicked ---
  i_load_flag chnget "_load_flag"

  if i_load_flag > 0 then
    ; User clicked Load — read file from Browse channel
    S_user chnget "sample_path"
    i_user_len strlen S_user
    prints "Loading: %s\n", S_user
    i_valid filevalid S_user
    if i_valid == 1 && i_user_len > 4 then
      gi_sample_L ftgen 1, 0, 0, 1, S_user, 0, 0, 1
      i_nchnls filenchnls S_user
      if i_nchnls >= 2 then
        gi_sample_R ftgen 2, 0, 0, 1, S_user, 0, 0, 2
      else
        gi_sample_R = gi_sample_L
      endif
      gi_sample_dur = ftlen(gi_sample_L) / sr
      prints "Loaded (%d ch, %.1f sec)\n", i_nchnls, gi_sample_dur
    else
      prints "Invalid file — keeping current sample\n"
    endif
    ; Clear the flag
    chnset 0, "_load_flag"
  else
    ; First init or mode change — load default sample (only if tables are still silence)
    i_current_len ftlen gi_sample_L
    if i_current_len <= 48000 then
      ; Tables are still the 1-second fallback — load default
      S_default = $SAMPLE_PATH
      i_def_valid filevalid S_default
      if i_def_valid == 1 then
        gi_sample_L ftgen 1, 0, 0, 1, S_default, 0, 0, 1
        i_def_nchnls filenchnls S_default
        if i_def_nchnls >= 2 then
          gi_sample_R ftgen 2, 0, 0, 1, S_default, 0, 0, 2
        else
          gi_sample_R = gi_sample_L
        endif
        gi_sample_dur = ftlen(gi_sample_L) / sr
        prints "Loaded default sample (%.1f sec)\n", gi_sample_dur
      else
        prints "Default sample not found — using silence.\n"
      endif
    endif
    ; Otherwise keep current sample (mode change only reinits flooper2)
  endif

  ; --- Loop mode (0=fwd, 1=bwd, 2=palindrome) ---
  i_mode_val chnget "loop_mode"
  i_mode = i_mode_val - 1

  ; === LOOPER PLAYBACK (flooper2) ===
  ; Reinit resets flooper2 internal state (read position, crossfade buffers)
  ; kamp, kpitch, kloopstart, kloopend, kcrossfade, ifn, istart, imode
  aL flooper2 k_play * k_gain, k_speed, k_start_sec, k_end_sec, k_xfade, gi_sample_L, 0, i_mode
  aR flooper2 k_play * k_gain, k_speed, k_start_sec, k_end_sec, k_xfade, gi_sample_R, 0, i_mode

  rireturn

  ; === STEREO WIDTH (mid-side) ===
  a_mid  = (aL + aR) * 0.5
  a_side = (aL - aR) * 0.5
  aL = a_mid + a_side * k_width
  aR = a_mid - a_side * k_width

  ; === LOW-PASS FILTER (moogladder) ===
  aL moogladder aL, k_lp_cut, k_lp_reso
  aR moogladder aR, k_lp_cut, k_lp_reso

  ; === HIGH-PASS FILTER (butterhp) ===
  aL butterhp aL, k_hp_cut
  aR butterhp aR, k_hp_cut

  ; === WARMTH: saturation + low shelf boost ===
  if k_warmth > 0.01 then
    aL = tanh(aL * (1 + k_warmth * 2))
    aR = tanh(aR * (1 + k_warmth * 2))
    aL_low butterlp aL, 200
    aR_low butterlp aR, 200
    aL = aL + aL_low * k_warmth * 0.4
    aR = aR + aR_low * k_warmth * 0.4
  endif

  ; === MASTER LOW-PASS ===
  aL butterlp aL, k_lpf
  aR butterlp aR, k_lpf

  ; === MASTER VOLUME + SOFT CLIP ===
  aL = tanh(aL * k_vol)
  aR = tanh(aR * k_vol)

  ; === DC BLOCK ===
  aL dcblock aL
  aR dcblock aR

  ; === OUTPUT ===
  outs aL, aR

  ; === SEND TO EFFECTS ===
  ga_dly_L = ga_dly_L + aL * k_dly_send
  ga_dly_R = ga_dly_R + aR * k_dly_send
  ga_rvb_L = ga_rvb_L + aL * k_rvb_send
  ga_rvb_R = ga_rvb_R + aR * k_rvb_send

endin


;==============================================================
; PRESET MANAGER — instr 95
;
; Save/Load all channel values to/from JSON file.
;==============================================================
instr 95

  k_save chnget "preset_save"
  k_load chnget "preset_load"

  ; GUI refresh flags (for syncing widget visuals after recall)
  k_gui_refresh init 0
  k_gui_delay   init 0

  ; Auto-load last saved preset on startup (if file exists)
  i_exists filevalid "/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/sample-looper-rig-preset.json"
  k_init init 0
  if k_init == 0 && i_exists == 1 then
    kOk = cabbageChannelStateRecall:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/sample-looper-rig-preset.json")
    printks "Auto-loaded preset from sample-looper-rig-preset.json\n", 0
    k_gui_refresh = 1
    k_init = 1
  elseif k_init == 0 then
    k_init = 1
  endif

  k_sv trigger k_save, 0.5, 0
  k_ld trigger k_load, 0.5, 0

  if k_sv == 1 then
    kOk = cabbageChannelStateSave:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/sample-looper-rig-preset.json")
    chnset k(0), "preset_save"
    printks "Preset saved to sample-looper-rig-preset.json\n", 0
  endif

  if k_ld == 1 then
    kOk = cabbageChannelStateRecall:k("/Users/daniel/PycharmProjects/generative-ambient/content/instruments/_shared/sample-looper-rig-preset.json")
    chnset k(0), "preset_load"
    printks "Preset loaded from sample-looper-rig-preset.json\n", 0
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
      $SYNC_WIDGET(sample_gain)
      $SYNC_WIDGET(loop_start)
      $SYNC_WIDGET(loop_end)
      $SYNC_WIDGET(loop_xfade)
      $SYNC_WIDGET(loop_speed)
      $SYNC_WIDGET(loop_mode)
      $SYNC_WIDGET(lp_cutoff)
      $SYNC_WIDGET(lp_reso)
      $SYNC_WIDGET(hp_cutoff)
      $SYNC_WIDGET(stereo_width)
      $SYNC_WIDGET(dly_time)
      $SYNC_WIDGET(dly_fb)
      $SYNC_WIDGET(dly_wet)
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
      $SYNC_WIDGET(loop_play)
    endif
  endif

endin


;==============================================================
; DELAY — instr 98 (Ping-Pong, free-running time)
;
; Modulated ping-pong delay with UI controls.
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
; Score order: LFOs -> looper -> preset -> delay -> reverb
i 90 0 [60*60*4]   ; LFO modulator
i  1 0 [60*60*4]   ; looper voice
i 95 0 [60*60*4]   ; preset manager
i 98 0 [60*60*4]   ; ping-pong delay
i 99 0 [60*60*4]   ; reverb
e
</CsScore>
</CsoundSynthesizer>
