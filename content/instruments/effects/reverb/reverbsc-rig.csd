<Cabbage>
form caption("Reverbsc Rig") size(740, 460), colour(30, 30, 50), pluginId("rvrb")

; Header
label bounds(10, 8, 720, 25) text("REVERBSC RIG") fontColour(100, 200, 160) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Sean Costello 8-line FDN (the workhorse reverb)") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 220, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(100, 200, 160) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Sine/Noise Ping = auto-triggered bursts at Rate Hz. Sustained = continuous. Manual Ping button always works.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): REVERB + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 380, 130) text("REVERB") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("rvb_size") range(0.3, 0.995, 0.90, 1, 0.001) text("Size") textColour(200,200,220) trackerColour(100, 200, 160)
    rslider bounds(70, 25, 55, 55) channel("rvb_tone") range(500, 16000, 8000, 0.4, 1) text("Tone") textColour(200,200,220) trackerColour(100, 200, 160)
    rslider bounds(130, 25, 55, 55) channel("rvb_predelay") range(0, 300, 0, 0.5, 1) text("PreDly") textColour(200,200,220) trackerColour(100, 200, 160)
    rslider bounds(190, 25, 55, 55) channel("rvb_pitchmod") range(0, 10, 1, 0.5, 0.1) text("PitchMd") textColour(200,200,220) trackerColour(100, 200, 160)
    button bounds(260, 30, 100, 22) channel("reinit_rvb") text("Apply PitchMd", "Apply PitchMd") value(0) colour:0(50, 50, 70) colour:1(100, 200, 160) fontColour:0(160, 160, 180)
    label bounds(10, 85, 360, 30) text("Size = feedback (0.6 = room, 0.9 = hall, 0.97 = cathedral). Tone = HF damping cutoff. PitchMd = internal delay modulation depth (press Apply — i-rate).") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(395, 160, 335, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.6, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("warmth") range(0, 1, 0.2, 1, 0.01) text("Warmth") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(190, 25, 55, 55) channel("hpf") range(20, 500, 40, 0.5, 1) text("HPF") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 320, 30) text("Warmth = tanh saturation + low shelf boost. HPF = highpass to control low-end buildup.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 145) text(
"REVERBSC — 8-line Feedback Delay Network by Sean Costello (Valhalla DSP).\n\n\
Uses a physical scattering junction model with 8 lossless waveguides. Internal random pitch modulation\n\
via randi opcodes creates harmonic blurring — sounds get richer the longer they reverberate.\n\
This is the reverb in nearly every Csound ambient piece.\n\n\
Good starting points:\n\
  • Live room: Size 0.60, Tone 6000, PitchMd 1\n\
  • Small hall: Size 0.80, Tone 8000, PitchMd 1\n\
  • Large hall: Size 0.90, Tone 10000, PitchMd 1\n\
  • Cathedral: Size 0.95, Tone 12000, PitchMd 2\n\
  • Infinite wash: Size 0.99, Tone 6000, PitchMd 3, HPF 80"
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
; REVERBSC — instr 99
;
; Full-parameter reverbsc with pre-delay, HPF, warmth.
; PitchMd (pitch modulation depth) is i-rate; press Apply
; button to reinit with new value.
;==============================================================
instr 99

  ksize    chnget "rvb_size"
  ktone    chnget "rvb_tone"
  kpredel  chnget "rvb_predelay"
  kdrywet  chnget "dry_wet"
  kvol     chnget "master_vol"
  kwarmth  chnget "warmth"
  khpf     chnget "hpf"

  ; PitchMd reinit on button press
  k_reinit chnget "reinit_rvb"
  k_reinit_trig trigger k_reinit, 0.5, 0
  if k_reinit_trig == 1 then
    reinit setup_rvb
  endif

setup_rvb:
  i_pitchmod chnget "rvb_pitchmod"

  ; Pre-delay
  apdL vdelay3 ga_send_L, kpredel, 500
  apdR vdelay3 ga_send_R, kpredel, 500

  ; Reverb with all parameters
  arvbL, arvbR reverbsc apdL, apdR, ksize, ktone, sr, i_pitchmod

rireturn

  ; High-pass filter to control low-end buildup
  arvbL butterhp arvbL, khpf
  arvbR butterhp arvbR, khpf

  ; Dry/wet mix
  aL = ga_send_L * (1 - kdrywet) + arvbL * kdrywet
  aR = ga_send_R * (1 - kdrywet) + arvbR * kdrywet

  ; Warmth
  if kwarmth > 0.01 then
    aL = tanh(aL * (1 + kwarmth * 2))
    aR = tanh(aR * (1 + kwarmth * 2))
    aLlow butterlp aL, 200
    aRlow butterlp aR, 200
    aL = aL + aLlow * kwarmth * 0.4
    aR = aR + aRlow * kwarmth * 0.4
  endif

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
