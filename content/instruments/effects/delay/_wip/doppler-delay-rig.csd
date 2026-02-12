<Cabbage>
form caption("Doppler Delay Rig") size(740, 490), colour(30, 30, 50), pluginId("dpdl")

; Header
label bounds(10, 8, 720, 25) text("DOPPLER DELAY RIG") fontColour(140, 200, 220) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Spatial movement simulation via delay-based Doppler shift") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(3) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(140, 200, 220) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Sustained sine shows the pitch sweep clearly. The sound orbits around the listener with Doppler shift.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): DOPPLER + ORBIT + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 250, 130) text("DOPPLER MOTION") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dp_speed") range(0.01, 2, 0.1, 0.5, 0.01) text("Speed") textColour(200,200,220) trackerColour(140, 200, 220)
    rslider bounds(70, 25, 55, 55) channel("dp_radius") range(1, 50, 10, 0.5, 0.1) text("Radius") textColour(200,200,220) trackerColour(140, 200, 220)
    rslider bounds(130, 25, 55, 55) channel("dp_amount") range(0, 1, 0.7, 1, 0.01) text("Amount") textColour(200,200,220) trackerColour(140, 200, 220)
    label bounds(10, 85, 240, 30) text("Speed = orbit Hz. Radius = distance (meters). Amount = Doppler shift strength.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(265, 160, 200, 130) text("ORBIT SHAPE") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dp_shape") range(0, 1, 0, 1, 0.01) text("Ellipse") textColour(200,200,220) trackerColour(180, 200, 180)
    rslider bounds(70, 25, 55, 55) channel("dp_tilt") range(0, 1, 0, 1, 0.01) text("Tilt") textColour(200,200,220) trackerColour(180, 200, 180)
    rslider bounds(130, 25, 55, 55) channel("dp_fb") range(0, 0.9, 0.3, 1, 0.01) text("Feedback") textColour(200,200,220) trackerColour(200, 180, 130)
    label bounds(10, 85, 195, 30) text("Ellipse = orbit eccentricity. Tilt = orbit rotation. Feedback = Doppler-shifted repeats.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(470, 160, 260, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.6, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("dp_reverb") range(0, 0.5, 0.15, 1, 0.01) text("Reverb") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 250, 30) text("Post-reverbsc for spatial depth.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"DOPPLER DELAY — Spatial movement via delay-based Doppler shift.

Simulates a sound source orbiting around the listener. As the source approaches, pitch rises
(compressed wavelengths); as it recedes, pitch falls. This is achieved by modulating the delay
time with a sinusoidal path — changing delay = pitch shift.

The orbit is defined by speed (revolutions per second), radius (distance), and shape (circular
to elliptical). Larger radius + faster speed = more dramatic pitch sweeps. The stereo field
follows the orbit — sound pans naturally as it circles.

Feedback creates trailing orbits, each progressively shifted.

Good starting points:
  • Gentle orbit: Speed 0.1, Radius 10, Amount 0.7
  • Fast flyby: Speed 0.5, Radius 20, Amount 0.9
  • Ambient swirl: Speed 0.03, Radius 5, Amount 0.4, FB 0.5, Reverb 0.3
  • Extreme warp: Speed 1.0, Radius 40, Amount 1.0, FB 0.7"
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
; DOPPLER DELAY — instr 99
;
; Simulates orbiting sound source via modulated delay lines.
; Delay time varies sinusoidally based on orbit path.
; Changing delay rate = pitch shift (Doppler effect).
; L/R panning follows orbit position.
;==============================================================
instr 99

  ; Read parameters
  kspeed   chnget "dp_speed"
  kradius  chnget "dp_radius"
  kamount  chnget "dp_amount"
  kshape   chnget "dp_shape"
  ktilt    chnget "dp_tilt"
  kfb      chnget "dp_fb"
  kdrywet  chnget "dry_wet"
  kvol     chnget "master_vol"
  krvb     chnget "dp_reverb"

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Feedback from previous cycle
  afb init 0

  ; Input with feedback
  ain = amono + afb * kfb

  ; Orbit phase
  kphs phasor kspeed
  kangle = kphs * 6.28318

  ; Elliptical orbit: x = radius, y = radius * (1 - shape)
  kx = kradius * cos(kangle + ktilt * 3.14159)
  ky = kradius * (1 - kshape * 0.8) * sin(kangle + ktilt * 3.14159)

  ; Distance from listener (at origin)
  kdist = sqrt(kx * kx + ky * ky)
  kdist limit kdist, 0.1, 100

  ; Delay time based on distance (speed of sound ~ 343 m/s)
  ; Scale by amount parameter
  kdelay_base = kdist / 343.0
  kdelay = kdelay_base * kamount + 0.01  ; minimum 10ms
  kdelay limit kdelay, 0.001, 0.5

  ; Modulated delay line
  abuf delayr 1.0
  atap deltap3 kdelay
       delayw ain

  ; Amplitude attenuation by distance (inverse square, softened)
  kamp = 1 / (1 + kdist * 0.05)

  ; Stereo panning based on x position
  ; x positive = right, x negative = left
  kpan = (kx / kradius) * 0.5 + 0.5
  kpan limit kpan, 0, 1

  awet = atap * kamp

  awet_L = awet * cos(kpan * 1.5708)  ; cos(pan * pi/2)
  awet_R = awet * sin(kpan * 1.5708)  ; sin(pan * pi/2)

  ; Feedback (mono)
  afb = awet

  ; Post reverb
  arvb_L, arvb_R reverbsc awet_L, awet_R, 0.6, 8000
  awet_L = awet_L + arvb_L * krvb
  awet_R = awet_R + arvb_R * krvb

  ; Dry/wet mix
  aL = ga_send_L * (1 - kdrywet) + awet_L * kdrywet
  aR = ga_send_R * (1 - kdrywet) + awet_R * kdrywet

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
