<Cabbage>
form caption("Granular Reverb Rig") size(740, 500), colour(30, 30, 50), pluginId("grrv")

; Header
label bounds(10, 8, 720, 25) text("GRANULAR REVERB RIG") fontColour(140, 200, 120) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — Circular buffer + grain scattering (after Brandtsegg / Saue)") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 220, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(140, 200, 120) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Sine/Noise Ping = auto-triggered bursts. Sustained = continuous. Try pings to hear the grain scatter.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): GRANULAR + FEEDBACK + OUTPUT
;=====================================================================

groupbox bounds(10, 160, 320, 130) text("GRAIN PARAMETERS") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 50, 50) channel("density") range(10, 800, 400, 0.4, 1) text("Density") textColour(200,200,220) trackerColour(140, 200, 120)
    rslider bounds(65, 25, 50, 50) channel("grain_dur") range(0.003, 0.3, 0.015, 0.3, 0.001) text("Size") textColour(200,200,220) trackerColour(140, 200, 120)
    rslider bounds(120, 25, 50, 50) channel("amp_jitter") range(0, 0.5, 0.4, 1, 0.01) text("Amp Jit") textColour(200,200,220) trackerColour(140, 200, 120)
    rslider bounds(175, 25, 50, 50) channel("pitch_jitter") range(0, 0.5, 0.15, 0.5, 0.001) text("Pitch Jit") textColour(200,200,220) trackerColour(140, 200, 120)
    rslider bounds(230, 25, 50, 50) channel("grain_bright") range(500, 16000, 4000, 0.4, 1) text("Bright") textColour(200,200,220) trackerColour(140, 200, 120)
    label bounds(10, 82, 300, 30) text("Density = grains/sec. Size = grain duration. Jitter = random variation. Bright = post-grain LP.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(335, 160, 155, 130) text("FEEDBACK") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("feedback") range(0, 0.9, 0.7, 1, 0.01) text("Amount") textColour(200,200,220) trackerColour(200, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("fb_filter") range(200, 12000, 6000, 0.4, 1) text("Damp") textColour(200,200,220) trackerColour(200, 180, 100)
    label bounds(10, 85, 140, 30) text("Grain output feeds back to buffer. Damp = LP in loop.") fontColour(140, 140, 160) fontSize(9) align("left")
}

groupbox bounds(495, 160, 235, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("dry_wet") range(0, 1, 0.7, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(70, 25, 55, 55) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(130, 25, 55, 55) channel("stereo_w") range(0, 1, 0.5, 1, 0.01) text("Spread") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 85, 220, 30) text("Spread = stereo decorrelation between L/R grain streams.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 185) text(
"GRANULAR REVERB — Time-scattering reverb using granular synthesis (after Brandtsegg / Saue).\n\n\
Signal flow: Input + feedback → write to circular buffer → grain opcode reads random positions → LP filter →\n\
feeds back to buffer. The grains scatter audio fragments in time, creating a cloudy, diffuse reverb tail.\n\n\
Unlike delay-based reverbs, the granular approach creates evolving textures rather than static decay.\n\
Grain parameters morph the reverb character: small dense grains = smooth wash, large sparse grains = rhythmic echoes,\n\
high pitch jitter = spectral smearing, high density + feedback = infinite evolving cloud.\n\n\
Good starting points:\n\
  • Smooth wash: Density 80, Size 0.08, Feedback 0.5, Pitch Jit 0.01\n\
  • Rhythmic scatter: Density 15, Size 0.15, Feedback 0.4, Pitch Jit 0\n\
  • Cloud texture: Density 120, Size 0.05, Feedback 0.7, Pitch Jit 0.03, Amp Jit 0.3\n\
  • Infinite evolve: Density 60, Size 0.12, Feedback 0.85, Pitch Jit 0.05, Damp 3000\n\n\
Buffer = 5.46 seconds. Grains read from random positions in the buffer history."
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

; Circular buffer for granular reverb (2^18 = 262144 samples ≈ 5.46 sec at 48kHz)
gi_buf ftgen 0, 0, 262144, 7, 0, 262144, 0

; Hanning window for grain envelope
gi_win ftgen 0, 0, 8192, 20, 2

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
; GRANULAR REVERB — instr 99
;
; Writes input + feedback to a circular buffer table.
; Two grain streams (L/R, slightly offset for stereo) read
; from random positions in the buffer.
; Grain output feeds back to the buffer for recirculation.
;==============================================================
instr 99

  ; --- Read parameters ---
  kdensity   chnget "density"
  kgdur      chnget "grain_dur"
  kampjit    chnget "amp_jitter"
  kpitchjit  chnget "pitch_jitter"
  kbright    chnget "grain_bright"
  kfeedback  chnget "feedback"
  kfbfilt    chnget "fb_filter"
  kdrywet    chnget "dry_wet"
  kvol       chnget "master_vol"
  kspread    chnget "stereo_w"

  ; --- Mono input ---
  amono = (ga_send_L + ga_send_R) * 0.5

  ; --- Feedback from previous cycle (filtered) ---
  afb_L init 0
  afb_R init 0
  afb_mono = (afb_L + afb_R) * 0.5

  ; --- Write input + feedback to circular buffer ---
  ; Audio-rate phasor cycles through the buffer
  awr_phs phasor sr / ftlen(gi_buf)
  awr_idx = awr_phs * ftlen(gi_buf)
  tablew amono + afb_mono * kfeedback, awr_idx, gi_buf

  ; --- Left grain stream ---
  ; grain: amp, pitch, density, amp_offset, pitch_offset, dur, table, window, maxdur, mode
  ; mode 0 = random grain position in table
  agrain_L grain 0.5, 1, kdensity, kampjit, kpitchjit, kgdur, gi_buf, gi_win, 1, 0

  ; --- Right grain stream (slightly different density for decorrelation) ---
  kdensity_R = kdensity * (1 + kspread * 0.15)
  agrain_R grain 0.5, 1, kdensity_R, kampjit, kpitchjit, kgdur, gi_buf, gi_win, 1, 0

  ; --- Post-grain brightness filter ---
  agrain_L butterlp agrain_L, kbright
  agrain_R butterlp agrain_R, kbright

  ; --- Feedback path with damping ---
  afb_L tone agrain_L, kfbfilt
  afb_R tone agrain_R, kfbfilt

  ; --- Dry/wet mix ---
  aL = ga_send_L * (1 - kdrywet) + agrain_L * kdrywet
  aR = ga_send_R * (1 - kdrywet) + agrain_R * kdrywet

  ; --- Master volume + output ---
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
