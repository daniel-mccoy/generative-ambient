<Cabbage>
form caption("Trigger Delay Rig") size(740, 490), colour(30, 30, 50), pluginId("trdl")

; Header
label bounds(10, 8, 720, 25) text("TRIGGER DELAY RIG") fontColour(220, 180, 140) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Input-amplitude-driven delay with envelope following") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(220, 180, 140) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Delay parameters react to input volume. Loud = different settings than quiet. Dynamic, expressive.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): TRIGGER + DELAY + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 280, 130) text("ENVELOPE FOLLOWER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("tr_thresh") range(0, 0.5, 0.05, 0.5, 0.001) text("Thresh") textColour(200,200,220) trackerColour(220, 180, 140)
    rslider bounds(70, 25, 55, 55) channel("tr_attack") range(0.001, 0.1, 0.01, 0.5, 0.001) text("Attack") textColour(200,200,220) trackerColour(220, 180, 140)
    rslider bounds(130, 25, 55, 55) channel("tr_release") range(0.01, 2, 0.3, 0.5, 0.01) text("Release") textColour(200,200,220) trackerColour(220, 180, 140)
    rslider bounds(190, 25, 55, 55) channel("tr_sense") range(0, 1, 0.5, 1, 0.01) text("Sense") textColour(200,200,220) trackerColour(220, 180, 140)
    label bounds(10, 85, 270, 30) text("Thresh = trigger level. Attack/Release = envelope speed. Sense = how much envelope drives params.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(295, 160, 170, 130) text("DELAY (env-driven)") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("tr_time_lo") range(0.05, 2, 0.5, 0.5, 0.01) text("T-Low") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(70, 25, 55, 55) channel("tr_time_hi") range(0.05, 2, 0.15, 0.5, 0.01) text("T-High") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(130, 25, 55, 55) channel("tr_fb") range(0, 0.9, 0.5, 1, 0.01) text("Feedback") textColour(200,200,220) trackerColour(200, 180, 130)
    label bounds(10, 85, 165, 30) text("T-Low = quiet delay time. T-High = loud delay time. Interpolated by envelope.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(470, 160, 260, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.5, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("tr_tone") range(500, 14000, 6000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(190, 25, 55, 55) channel("tr_spread") range(0, 30, 10, 0.5, 0.1) text("Spread") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 250, 30) text("Tone = LP in feedback. Spread = stereo offset (ms).") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"TRIGGER DELAY — Input-amplitude-driven delay parameters.

The input signal's envelope (via RMS follower) dynamically controls delay time, feedback, and
filtering. Loud transients can trigger shorter delay times for rhythmic staccato, while quiet
passages open up into longer, washy echoes (or vice versa — fully configurable).

T-Low sets the delay time when the envelope is at zero. T-High sets the delay time when the
envelope exceeds the threshold. The Sense control blends between static and dynamic behavior.
The envelope follower's Attack and Release shape how quickly parameters respond.

Good starting points:
  • Dynamic staccato: T-Low 0.5, T-High 0.1, Sense 0.7, FB 0.5, Attack 0.01
  • Swelling wash: T-Low 0.2, T-High 0.8, Sense 0.5, FB 0.7, Release 1.0
  • Responsive echo: T-Low 0.4, T-High 0.25, Sense 0.4, FB 0.6, Tone 4000
  • Gated bounce: T-Low 0.3, T-High 0.3, Sense 0, FB 0.5, Thresh 0.1"
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
; TRIGGER DELAY — instr 99
;
; Envelope follower drives delay time and feedback.
; RMS → smoothed envelope → interpolates between lo/hi params.
; Based on COSMO patterns for input-reactive processing.
;==============================================================
instr 99

  ; Read parameters
  kthresh    chnget "tr_thresh"
  kattack    chnget "tr_attack"
  krelease   chnget "tr_release"
  ksense     chnget "tr_sense"
  ktime_lo   chnget "tr_time_lo"
  ktime_hi   chnget "tr_time_hi"
  kfb        chnget "tr_fb"
  kdrywet    chnget "dry_wet"
  kvol       chnget "master_vol"
  ktone      chnget "tr_tone"
  kspread    chnget "tr_spread"

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Envelope follower (RMS with attack/release)
  krms rms amono
  ; Smooth with different attack/release
  kenv init 0
  if krms > kenv then
    kenv = kenv + (krms - kenv) * (1 - exp(-1 / (kattack * kr)))
  else
    kenv = kenv + (krms - kenv) * (1 - exp(-1 / (krelease * kr)))
  endif

  ; Normalize envelope: 0 when below thresh, 1 at thresh+headroom
  kenv_norm = (kenv - kthresh) / (0.5 - kthresh + 0.001)
  kenv_norm limit kenv_norm, 0, 1

  ; Apply sensitivity
  kenv_drive = kenv_norm * ksense

  ; Interpolate delay time between lo and hi
  ktime = ktime_lo * (1 - kenv_drive) + ktime_hi * kenv_drive
  ktime limit ktime, 0.01, 2.99

  ; Feedback from previous cycle
  afb_L init 0
  afb_R init 0

  ; Stereo spread offset
  kspread_sec = kspread * 0.001

  ; L delay
  abuf_L delayr 3.0
  atap_L deltap3 ktime
         delayw amono + afb_L * kfb

  ; R delay (with spread offset)
  ktime_R = ktime + kspread_sec
  ktime_R limit ktime_R, 0.01, 2.99

  abuf_R delayr 3.0
  atap_R deltap3 ktime_R
         delayw amono + afb_R * kfb

  ; Tone filter in feedback
  afb_L tone atap_L, ktone
  afb_R tone atap_R, ktone

  ; Dry/wet mix
  aL = ga_send_L * (1 - kdrywet) + atap_L * kdrywet
  aR = ga_send_R * (1 - kdrywet) + atap_R * kdrywet

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
