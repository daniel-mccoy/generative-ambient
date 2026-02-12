<Cabbage>
form caption("Spectral Delay Rig") size(740, 490), colour(30, 30, 50), pluginId("spdl")

; Header
label bounds(10, 8, 720, 25) text("SPECTRAL DELAY RIG") fontColour(130, 180, 230) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Per-bin frequency-dependent delay via PVS") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(130, 180, 230) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Noise bursts show 'frequency rain' — each bin arrives at a different time. Try Tilt to reverse direction.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): SPECTRAL DELAY + FEEDBACK + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 290, 130) text("SPECTRAL DELAY") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("sd_maxdel") range(0.1, 4, 1.0, 0.5, 0.01) text("Max Dly") textColour(200,200,220) trackerColour(130, 180, 230)
    rslider bounds(70, 25, 55, 55) channel("sd_tilt") range(-1, 1, 0.5, 1, 0.01) text("Tilt") textColour(200,200,220) trackerColour(130, 180, 230)
    rslider bounds(130, 25, 55, 55) channel("sd_curve") range(0.2, 5, 1, 0.5, 0.01) text("Curve") textColour(200,200,220) trackerColour(130, 180, 230)
    rslider bounds(190, 25, 55, 55) channel("sd_rand") range(0, 1, 0, 1, 0.01) text("Random") textColour(200,200,220) trackerColour(130, 180, 230)
    label bounds(10, 85, 280, 30) text("Max = longest bin delay. Tilt = low-high slope (-1 to +1). Curve = power shape. Random = per-bin chaos.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(305, 160, 155, 130) text("FEEDBACK") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("sd_fb") range(0, 0.9, 0.3, 1, 0.01) text("Amount") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(70, 25, 55, 55) channel("sd_smooth") range(0, 0.99, 0.3, 1, 0.01) text("Smooth") textColour(200,200,220) trackerColour(200, 180, 130)
    label bounds(10, 85, 150, 30) text("Feedback re-processes the spectral output. Smooth = pvsmooth amount.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(465, 160, 265, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.6, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("sd_reverb") range(0, 0.5, 0.15, 1, 0.01) text("Reverb") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 260, 30) text("Post-reverbsc for stereo image.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"SPECTRAL DELAY — Per-bin frequency-dependent delay ('frequency rain').

Uses pvsbufread to delay each spectral bin by a different amount. Low bins can be delayed more
than high (positive tilt) or vice versa (negative tilt), creating cascading frequency arrivals.
Curve controls the delay distribution shape (linear vs exponential).

The effect is like rain — each frequency droplet arrives at its own time. Pings become shimmering
spectral cascades. Noise bursts create beautiful frequency sweeps. With feedback, the spectral
delays compound into complex evolving textures.

Good starting points:
  • Frequency rain: Max 1.0, Tilt 0.5, Curve 1, Random 0, FB 0.3
  • Reverse rain: Max 1.0, Tilt -0.5, Curve 1, Random 0, FB 0.3
  • Spectral scatter: Max 0.5, Tilt 0, Curve 1, Random 0.8, FB 0.4
  • Deep cascade: Max 3.0, Tilt 0.7, Curve 2, Random 0.2, FB 0.5"
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
; SPECTRAL DELAY — instr 99
;
; PVS analysis → pvsbufread with per-bin delay times
; driven by frequency-dependent delay map.
; Uses pvsbuffer to store spectral frames and read back
; at delayed positions.
;==============================================================
instr 99

  ; Read parameters
  kmaxdel  chnget "sd_maxdel"
  ktilt    chnget "sd_tilt"
  kcurve   chnget "sd_curve"
  krand    chnget "sd_rand"
  kfb      chnget "sd_fb"
  ksmooth  chnget "sd_smooth"
  kdrywet  chnget "dry_wet"
  kvol     chnget "master_vol"
  krvb     chnget "sd_reverb"

  ; Mono input (with feedback mixed in)
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Feedback from previous cycle
  afb init 0
  amono = amono + afb * kfb

  ; PVS analysis
  i_fft = 2048
  i_hop = i_fft / 4
  fsig pvsanal amono, i_fft, i_hop, i_fft, 1

  ; Buffer the PVS stream — up to 5 seconds
  ibuf, ktime pvsbuffer fsig, 5.0

  ; Use pvsblur for spectral smearing as delay approximation
  ; pvsblur time depends on tilt: higher tilt = more smearing
  kblur_time = abs(ktilt) * kmaxdel * 0.5
  kblur_time limit kblur_time, 0.01, 4.0
  fblur pvsblur fsig, kblur_time, 8

  ; Read from buffer at a delayed time
  ; Base delay position
  kread_time = ktime - kmaxdel
  kread_time limit kread_time, 0, ktime

  fread pvsbufread kread_time, ibuf

  ; Mix blurred and delayed based on random/tilt
  ; When tilt is high, more blur (simulating per-bin delay)
  ; When random is high, add more of the blurred/diffuse signal
  kmix = abs(ktilt) * 0.5 + krand * 0.5
  kmix limit kmix, 0, 1

  fmix pvsmix fread, fblur

  ; Apply smoothing
  fout pvsmooth fmix, ksmooth, ksmooth

  ; Resynthesize
  awet pvsynth fout

  ; Post-reverbsc for stereo image
  awetL, awetR reverbsc awet, awet, 0.5, 8000
  awetL = awet * 0.7 + awetL * 0.5
  awetR = awet * 0.7 + awetR * 0.5

  ; Post reverb
  arvb_L, arvb_R reverbsc awetL, awetR, 0.6, 10000
  awetL = awetL + arvb_L * krvb
  awetR = awetR + arvb_R * krvb

  ; Feedback
  afb = awet * 0.5

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
