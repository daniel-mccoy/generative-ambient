<Cabbage>
form caption("FB Reverb Mixer Rig") size(740, 490), colour(30, 30, 50), pluginId("fbrv")

; Header
label bounds(10, 8, 720, 25) text("FB REVERB MIXER RIG") fontColour(224, 160, 80) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — reverbsc + feedback delay + tanh saturation (after Steven Yi)") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 220, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(224, 160, 80) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Sine/Noise Ping = auto-triggered bursts at Rate Hz. Sustained = continuous. Manual Ping button always works.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): REVERB + FEEDBACK DELAY + OUTPUT
;=====================================================================

; Core reverb
groupbox bounds(10, 160, 170, 130) text("REVERB") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("rvb_size") range(0.3, 0.99, 0.88, 1, 0.01) text("Size") textColour(200,200,220) trackerColour(224, 160, 80)
    rslider bounds(70, 25, 55, 55) channel("rvb_tone") range(1000, 16000, 8000, 0.4, 1) text("Tone") textColour(200,200,220) trackerColour(224, 160, 80)
    label bounds(10, 85, 150, 25) text("reverbsc. Size = tail length.") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Feedback delay
groupbox bounds(185, 160, 280, 130) text("FEEDBACK DELAY") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 50, 50) channel("fb_time") range(20, 5000, 300, 0.3, 1) text("Time") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(65, 25, 50, 50) channel("fb_amount") range(0, 0.85, 0.4, 1, 0.01) text("Amount") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(120, 25, 50, 50) channel("fb_damp") range(200, 14000, 6000, 0.4, 1) text("Damp") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(175, 25, 50, 50) channel("saturation") range(0, 1, 0.3, 1, 0.01) text("Saturate") textColour(200,200,220) trackerColour(224, 122, 95)
    label bounds(10, 82, 260, 30) text("Mixed output feeds back through delay. Damp rolls off HF in loop. Saturate = tanh drive.") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Output
groupbox bounds(470, 160, 260, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.6, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("warmth") range(0, 1, 0.2, 1, 0.01) text("Warmth") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(190, 25, 55, 55) channel("stereo_spread") range(0, 1, 0.5, 1, 0.01) text("Spread") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 240, 25) text("Warmth = low shelf boost. Spread = stereo width.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"FB REVERB MIXER — Always-on reverb bus with compound feedback topology.\n\n\
Signal flow: Dry input + reverbsc output + feedback delay → tanh soft clip → speakers.\n\
The mixed output also feeds into a vdelay3 feedback path with damping filter, creating compound\n\
reverb-delay interactions where the reverb tail feeds back through the delay and vice versa.\n\n\
This is the standard bus-style reverb architecture for generative pieces. Unlike the shimmer reverb,\n\
there is no pitch shifting — the feedback creates density and warmth through recirculation alone.\n\
Tanh saturation prevents runaway while adding analog-style harmonic warmth.\n\n\
Good starting points:\n\
  • Clean hall: Size 0.88, FB Amount 0.2, FB Time 300ms, Saturate 0.1\n\
  • Warm ambient: Size 0.93, FB Amount 0.4, FB Time 500ms, Saturate 0.3, Warmth 0.4\n\
  • Dense wash: Size 0.96, FB Amount 0.6, FB Time 1000ms, Saturate 0.5\n\
  • Infinite space: Size 0.98, FB Amount 0.75, FB Time 2000ms, Damp 3000, Saturate 0.4\n\n\
For pieces: replace test source with instrument send buses (ga_send_L/R). The reverb bus runs always-on."
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

; Send bus from test source to reverb
ga_send_L init 0
ga_send_R init 0


;==============================================================
; TEST SOURCE — instr 1
;
; Same test source pattern as the other reverb rigs.
;==============================================================
instr 1

  ktype  chnget "src_type"
  kfreq  chnget "src_freq"
  klevel chnget "src_level"
  krate  chnget "src_rate"

  ; Manual trigger (rising edge)
  k_man chnget "src_trigger"
  k_man_trig trigger k_man, 0.5, 0

  ; Auto trigger for burst modes (types 1, 2)
  k_auto_trig = 0
  if ktype <= 2 then
    k_auto_trig metro krate
  endif

  ; Combined trigger
  if (k_auto_trig + k_man_trig) > 0 then
    reinit do_ping
  endif

do_ping:
  aenv expseg 1, 0.15, 0.001
rireturn

  ; Generate all signal types
  asing  oscili 1, kfreq, gi_sine
  anoise noise  0.3, 0

  ; Select signal + apply envelope/level
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

  ; Send to effect bus
  ga_send_L = ga_send_L + asig
  ga_send_R = ga_send_R + asig

endin


;==============================================================
; FB REVERB MIXER — instr 99
;
; Compound reverb: reverbsc + feedback delay + tanh saturation.
;
; The mixed output (dry + reverb + feedback) passes through
; tanh soft clipping, then into a feedback delay path. This
; creates compound interactions where reverb tails recirculate
; through the delay and back into the reverb.
;
; Architecture:
;   dry + rvb + fb_prev → tanh → speakers
;                              → vdelay3 → tone → fb_next
;==============================================================
instr 99

  ; Read parameters
  krvb_size chnget "rvb_size"
  krvb_tone chnget "rvb_tone"
  kfb_time  chnget "fb_time"
  kfb_amt   chnget "fb_amount"
  kfb_damp  chnget "fb_damp"
  ksat      chnget "saturation"
  kdrywet   chnget "dry_wet"
  kvol      chnget "master_vol"
  kwarmth   chnget "warmth"
  kspread   chnget "stereo_spread"

  ; Reverb
  arvb_L, arvb_R reverbsc ga_send_L, ga_send_R, krvb_size, krvb_tone

  ; Feedback from previous cycle
  afb_L init 0
  afb_R init 0

  ; Mix: dry input + reverb + feedback
  amix_L = ga_send_L + arvb_L + afb_L
  amix_R = ga_send_R + arvb_R + afb_R

  ; Tanh saturation on the full mix
  k_drive = 1 + ksat * 3
  amix_L = tanh(amix_L * k_drive)
  amix_R = tanh(amix_R * k_drive)

  ; Feedback path: delay the mixed output + damping filter
  afd_L vdelay3 amix_L * kfb_amt, kfb_time, 10000
  afd_R vdelay3 amix_R * kfb_amt, kfb_time, 10000
  afb_L tone afd_L, kfb_damp
  afb_R tone afd_R, kfb_damp

  ; Stereo spread: slightly different delay for L/R feedback
  ; adds width without extra controls
  k_spread_ms = kspread * 15
  afb_R vdelay3 afb_R, k_spread_ms, 20

  ; Warmth: low shelf boost
  if kwarmth > 0.01 then
    aLlow butterlp amix_L, 200
    aRlow butterlp amix_R, 200
    amix_L = amix_L + aLlow * kwarmth * 0.5
    amix_R = amix_R + aRlow * kwarmth * 0.5
  endif

  ; Dry/wet mix
  aout_L = ga_send_L * (1 - kdrywet) + amix_L * kdrywet
  aout_R = ga_send_R * (1 - kdrywet) + amix_R * kdrywet

  ; Master volume + output
  aout_L = aout_L * kvol
  aout_R = aout_R * kvol
  aout_L dcblock aout_L
  aout_R dcblock aout_R
  outs aout_L, aout_R

  ; Clear send bus
  ga_send_L = 0
  ga_send_R = 0

endin


</CsInstruments>
<CsScore>
i 1  0 [60*60*4]   ; test source
i 99 0 [60*60*4]   ; fb reverb mixer
e
</CsScore>
</CsoundSynthesizer>
