<Cabbage>
form caption("Spectral Blur/Freeze Rig") size(740, 490), colour(30, 30, 50), pluginId("sbfr")

; Header
label bounds(10, 8, 720, 25) text("SPECTRAL BLUR / FREEZE RIG") fontColour(100, 180, 224) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — PVS spectral smearing and infinite sustain") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(100, 180, 224) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Play a ping then toggle Freeze — the spectral snapshot sustains infinitely. Blur smears over time.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): BLUR + FREEZE + SMOOTH + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 180, 130) text("BLUR") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("blur_time") range(0.01, 10, 0.5, 0.3, 0.01) text("Time") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(70, 25, 55, 55) channel("blur_mix") range(0, 1, 0.5, 1, 0.01) text("Mix") textColour(200,200,220) trackerColour(100, 180, 224)
    label bounds(10, 85, 170, 30) text("Time = smear window (sec). Longer = more diffuse.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(195, 160, 200, 130) text("FREEZE") colour(40, 40, 60) fontColour(200, 200, 220) {
    button bounds(15, 30, 80, 35) channel("freeze") text("Freeze", "FROZEN") value(0) colour:0(60, 60, 80) colour:1(100, 200, 255) fontColour:0(200, 200, 220) fontColour:1(30, 30, 50)
    rslider bounds(110, 25, 55, 55) channel("freeze_mix") range(0, 1, 0.8, 1, 0.01) text("Mix") textColour(200,200,220) trackerColour(100, 200, 255)
    label bounds(10, 75, 185, 40) text("Toggle to freeze current spectrum. Locks both amplitude and frequency. Mix blends frozen signal.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(400, 160, 155, 130) text("SMOOTH") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("smooth_amp") range(0, 1, 0.3, 1, 0.01) text("Amp") textColour(200,200,220) trackerColour(160, 180, 224)
    rslider bounds(70, 25, 55, 55) channel("smooth_freq") range(0, 1, 0.3, 1, 0.01) text("Freq") textColour(200,200,220) trackerColour(160, 180, 224)
    label bounds(10, 85, 145, 30) text("pvsmooth: separate amp/freq smoothing (no latency).") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(560, 160, 170, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.7, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 160, 30) text("FFT size 2048 for good freq resolution.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"SPECTRAL BLUR / FREEZE — PVS-based spectral time manipulation.

Three independent spectral processors in series:
  1. pvsblur: Averages spectral frames over a time window, creating temporal smearing. Longer
     blur times turn transients into evolving drones. Adds latency equal to blur time.
  2. pvsfreeze: Locks the current spectral snapshot indefinitely. Toggle Freeze to capture
     a moment — it sustains as an infinite, evolving pad. Amplitude and frequency lock independently.
  3. pvsmooth: Separate amplitude/frequency smoothing with NO latency penalty. High values
     create evolving, glassy textures.

Post-processing via reverbsc adds stereo image to the mono spectral output.

Good starting points:
  • Gentle smear: Blur 0.5, Smooth Amp 0.3, Freq 0.3
  • Infinite drone: Freeze ON, Freeze Mix 0.8
  • Evolving cloud: Blur 3.0, Smooth Amp 0.7, Freq 0.5
  • Glassy shimmer: Blur 0.1, Smooth Amp 0.9, Freq 0.1"
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
; SPECTRAL BLUR / FREEZE — instr 99
;
; PVS chain: pvsanal → pvsblur → pvsfreeze → pvsmooth → pvsynth
; Post-reverbsc for stereo image.
;==============================================================
instr 99

  ; Read parameters
  kblur_time chnget "blur_time"
  kblur_mix  chnget "blur_mix"
  kfreeze    chnget "freeze"
  kfrz_mix   chnget "freeze_mix"
  ksmth_amp  chnget "smooth_amp"
  ksmth_freq chnget "smooth_freq"
  kdrywet    chnget "dry_wet"
  kvol       chnget "master_vol"

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; PVS analysis
  i_fft = 2048
  i_hop = i_fft / 4
  fsig pvsanal amono, i_fft, i_hop, i_fft, 1

  ; Stage 1: Blur (spectral smearing)
  fblur pvsblur fsig, kblur_time, 8

  ; Crossfade between original and blurred
  fmix1 pvsmix fsig, fblur

  ; Stage 2: Freeze
  kfa = 0
  kff = 0
  if kfreeze > 0.5 then
    kfa = 1
    kff = 1
  endif
  ffrz pvsfreeze fmix1, kfa, kff

  ; Crossfade freeze
  fmix2 pvsmix fmix1, ffrz

  ; Stage 3: Smooth (no latency)
  fsmth pvsmooth fmix2, ksmth_amp, ksmth_freq

  ; Resynthesize
  awet pvsynth fsmth

  ; Post-reverbsc for stereo image
  awetL, awetR reverbsc awet, awet, 0.3, 8000
  awetL = awet + awetL * 0.3
  awetR = awet + awetR * 0.3

  ; Dry/wet mix
  aL = ga_send_L * (1 - kdrywet) + awetL * kdrywet
  aR = ga_send_R * (1 - kdrywet) + awetR * kdrywet

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
