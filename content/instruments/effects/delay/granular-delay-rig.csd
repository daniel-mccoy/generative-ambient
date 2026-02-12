<Cabbage>
form caption("Granular Delay Rig") size(740, 490), colour(30, 30, 50), pluginId("grdl")

; Header
label bounds(10, 8, 720, 25) text("GRANULAR DELAY RIG") fontColour(180, 220, 130) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Live-buffer granular delay with density and jitter") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 440, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(180, 220, 130) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Pings get scattered into granular clouds. Increase density for thick textures, jitter for randomness.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): GRAIN PARAMS + FEEDBACK + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 280, 130) text("GRAIN PARAMETERS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(5, 25, 50, 50) channel("gr_delay") range(0.05, 3, 0.4, 0.5, 0.01) text("Delay") textColour(200,200,220) trackerColour(180, 220, 130)
    rslider bounds(57, 25, 50, 50) channel("gr_size") range(0.01, 0.5, 0.08, 0.5, 0.001) text("Size") textColour(200,200,220) trackerColour(180, 220, 130)
    rslider bounds(109, 25, 50, 50) channel("gr_density") range(1, 60, 12, 0.5, 1) text("Density") textColour(200,200,220) trackerColour(180, 220, 130)
    rslider bounds(161, 25, 50, 50) channel("gr_jitter") range(0, 1, 0.3, 1, 0.01) text("Jitter") textColour(200,200,220) trackerColour(180, 220, 130)
    rslider bounds(213, 25, 50, 50) channel("gr_pitch") range(0.5, 2, 1, 1, 0.01) text("Pitch") textColour(200,200,220) trackerColour(180, 220, 130)
    label bounds(5, 82, 270, 35) text("Delay = read position. Size = grain length. Density = grains/sec. Jitter = random offset. Pitch = grain playback speed.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(295, 160, 155, 130) text("FEEDBACK") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("gr_fb") range(0, 0.9, 0.4, 1, 0.01) text("Amount") textColour(200,200,220) trackerColour(200, 180, 130)
    rslider bounds(70, 25, 55, 55) channel("gr_fb_tone") range(500, 14000, 6000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(200, 180, 130)
    label bounds(10, 85, 140, 30) text("Feedback re-records grains into buffer.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(455, 160, 275, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.5, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("gr_spread") range(0, 1, 0.6, 1, 0.01) text("Spread") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(190, 25, 55, 55) channel("gr_reverb") range(0, 0.5, 0.15, 1, 0.01) text("Reverb") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 265, 30) text("Spread = stereo randomization of grain position. Reverb = post-reverb.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 175) text(
"GRANULAR DELAY — Live-buffer granular processing for self-evolving delay clouds.

Input is continuously recorded into a circular buffer. Grains are read from a delayed position
with random jitter, creating scattered clouds from the source. Each grain gets a Hanning envelope
for smooth overlap. Feedback re-records the granulated output for recursive transformation.

High density + small size = smooth texture. Low density + large size = stuttering rhythmic.
Jitter randomizes read position around the delay point. Pitch shifts grain playback speed.

Good starting points:
  • Smooth cloud: Delay 0.4, Size 0.08, Density 12, Jitter 0.3, Pitch 1.0, FB 0.4
  • Dense texture: Delay 0.2, Size 0.04, Density 40, Jitter 0.5, Pitch 1.0, FB 0.6
  • Pitched scatter: Delay 0.3, Size 0.12, Density 8, Jitter 0.8, Pitch 0.5, FB 0.3
  • Evolving wash: Delay 1.0, Size 0.2, Density 15, Jitter 1.0, Pitch 1.0, FB 0.7"
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
; Hanning window for grain envelope
gi_hann ftgen 0, 0, 8192, 20, 2

; Circular buffer — 4 seconds at sr
gi_buf_len = 4
gi_buf    ftgen 0, 0, sr * gi_buf_len, 2, 0

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
; GRANULAR DELAY — instr 99
;
; Continuous recording into circular buffer.
; Grains read from delayed position with jitter.
; Feedback re-records into the buffer.
;==============================================================
instr 99

  ; Read parameters
  kdelay    chnget "gr_delay"
  ksize     chnget "gr_size"
  kdensity  chnget "gr_density"
  kjitter   chnget "gr_jitter"
  kpitch    chnget "gr_pitch"
  kfb       chnget "gr_fb"
  kfb_tone  chnget "gr_fb_tone"
  kdrywet   chnget "dry_wet"
  kvol      chnget "master_vol"
  kspread   chnget "gr_spread"
  krvb      chnget "gr_reverb"

  ; Mono input
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Feedback from previous cycle
  afb init 0
  afb tone afb, kfb_tone

  ; Write into circular buffer (input + feedback)
  awrite = amono + afb * kfb
  kwrite_pos phasor sr / ftlen(gi_buf)
  tablew awrite, a(kwrite_pos), gi_buf, 1

  ; Grain parameters
  kgrain_trig metro kdensity

  ; Grain read position: delayed from write position
  kbuf_len = ftlen(gi_buf) / sr
  kread_base = kwrite_pos - (kdelay / kbuf_len)
  ; Wrap to 0-1
  if kread_base < 0 then
    kread_base = kread_base + 1
  endif

  ; Accumulate grains using granule-style approach with reinit
  ; Use fog opcode for live granular synthesis
  ; Simple approach: multiple grain streams via vdelay3

  ; Convert delay to samples for table read
  kdelay_samps = kdelay * sr
  kjitter_samps = kjitter * kdelay * sr

  ; 4 grain streams with staggered phases
  ; Stream 1
  kph1 phasor kdensity / 4
  kjit1 randi kjitter_samps, kdensity * 0.7
  krd1 = kwrite_pos * ftlen(gi_buf) - kdelay_samps + kjit1
  krd1 = krd1 % ftlen(gi_buf)
  if krd1 < 0 then
    krd1 = krd1 + ftlen(gi_buf)
  endif
  kenv1 = sin(kph1 * 3.14159)
  kenv1 = kenv1 * kenv1
  agr1 tablekt a(krd1), gi_buf
  agr1 = agr1 * kenv1

  ; Stream 2 (offset 25%)
  kph2 phasor kdensity / 4
  kph2 = kph2 + 0.25
  if kph2 >= 1 then
    kph2 = kph2 - 1
  endif
  kjit2 randi kjitter_samps, kdensity * 0.9
  krd2 = kwrite_pos * ftlen(gi_buf) - kdelay_samps + kjit2
  krd2 = krd2 % ftlen(gi_buf)
  if krd2 < 0 then
    krd2 = krd2 + ftlen(gi_buf)
  endif
  kenv2 = sin(kph2 * 3.14159)
  kenv2 = kenv2 * kenv2
  agr2 tablekt a(krd2), gi_buf
  agr2 = agr2 * kenv2

  ; Stream 3 (offset 50%)
  kph3 phasor kdensity / 4
  kph3 = kph3 + 0.5
  if kph3 >= 1 then
    kph3 = kph3 - 1
  endif
  kjit3 randi kjitter_samps, kdensity * 1.1
  krd3 = kwrite_pos * ftlen(gi_buf) - kdelay_samps + kjit3
  krd3 = krd3 % ftlen(gi_buf)
  if krd3 < 0 then
    krd3 = krd3 + ftlen(gi_buf)
  endif
  kenv3 = sin(kph3 * 3.14159)
  kenv3 = kenv3 * kenv3
  agr3 tablekt a(krd3), gi_buf
  agr3 = agr3 * kenv3

  ; Stream 4 (offset 75%)
  kph4 phasor kdensity / 4
  kph4 = kph4 + 0.75
  if kph4 >= 1 then
    kph4 = kph4 - 1
  endif
  kjit4 randi kjitter_samps, kdensity * 1.3
  krd4 = kwrite_pos * ftlen(gi_buf) - kdelay_samps + kjit4
  krd4 = krd4 % ftlen(gi_buf)
  if krd4 < 0 then
    krd4 = krd4 + ftlen(gi_buf)
  endif
  kenv4 = sin(kph4 * 3.14159)
  kenv4 = kenv4 * kenv4
  agr4 tablekt a(krd4), gi_buf
  agr4 = agr4 * kenv4

  ; Mix grain streams
  awet_mono = (agr1 + agr2 + agr3 + agr4) * 0.35

  ; Stereo spread: random pan per grain stream
  kpan1 randi kspread * 0.5, kdensity * 0.3
  kpan2 randi kspread * 0.5, kdensity * 0.5
  kpan3 randi kspread * 0.5, kdensity * 0.7
  kpan4 randi kspread * 0.5, kdensity * 0.9

  awet_L = agr1 * (0.5 + kpan1) + agr2 * (0.5 - kpan2) + agr3 * (0.5 + kpan3) + agr4 * (0.5 - kpan4)
  awet_R = agr1 * (0.5 - kpan1) + agr2 * (0.5 + kpan2) + agr3 * (0.5 - kpan3) + agr4 * (0.5 + kpan4)
  awet_L = awet_L * 0.35
  awet_R = awet_R * 0.35

  ; Post reverb
  arvb_L, arvb_R reverbsc awet_L, awet_R, 0.6, 8000
  awet_L = awet_L + arvb_L * krvb
  awet_R = awet_R + arvb_R * krvb

  ; Feedback (mono sum)
  afb = (awet_L + awet_R) * 0.5

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
