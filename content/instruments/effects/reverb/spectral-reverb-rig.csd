<Cabbage>
form caption("Spectral Reverb Rig") size(740, 500), colour(30, 30, 50), pluginId("sprv")

; Header
label bounds(10, 8, 720, 25) text("SPECTRAL REVERB RIG") fontColour(180, 120, 224) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — pvsblur + pvsfreeze spectral wash (after Brandtsegg / Lazzarini)") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 220, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(180, 120, 224) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Sine/Noise Ping = auto-triggered bursts at Rate Hz. Sustained = continuous. Manual Ping button always works.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): SPECTRAL + FREEZE + POST
;=====================================================================

; Spectral processing
groupbox bounds(10, 160, 250, 130) text("SPECTRAL") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 55, 55) channel("blur_time") range(0.01, 10, 2.0, 0.3, 0.01) text("Blur") textColour(200,200,220) trackerColour(180, 120, 224)
    rslider bounds(70, 25, 55, 55) channel("spec_filter") range(200, 16000, 12000, 0.3, 1) text("Filter") textColour(200,200,220) trackerColour(180, 120, 224)
    combobox bounds(135, 28, 100, 22) channel("fft_size") value(3) text("512", "1024", "2048", "4096")
    label bounds(10, 85, 230, 30) text("Blur = time-averaging window in seconds. Filter = post-spectral lowpass. FFT = resolution.") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Freeze controls
groupbox bounds(265, 160, 210, 130) text("FREEZE") colour(40, 40, 60) fontColour(200, 200, 220) {
    button bounds(15, 30, 80, 40) channel("freeze") text("FREEZE", "FROZEN") value(0) colour:0(50, 50, 70) colour:1(200, 80, 120) fontColour:0(180, 180, 200) fontColour:1(255, 255, 255)
    button bounds(105, 30, 40, 18) channel("freeze_amp") text("Amp", "Amp") value(1) colour:0(50, 50, 70) colour:1(180, 120, 224) fontColour:0(160, 160, 180) fontColour:1(255, 255, 255)
    button bounds(150, 30, 40, 18) channel("freeze_frq") text("Freq", "Freq") value(1) colour:0(50, 50, 70) colour:1(180, 120, 224) fontColour:0(160, 160, 180) fontColour:1(255, 255, 255)
    label bounds(10, 85, 190, 30) text("Freeze captures current spectrum. Toggle Amp/Freq to freeze independently.") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Post-processing + output
groupbox bounds(480, 160, 250, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 50, 50) channel("post_size") range(0.1, 0.99, 0.5, 1, 0.01) text("Post Rvb") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(65, 25, 50, 50) channel("post_tone") range(1000, 16000, 8000, 0.4, 1) text("Post Tone") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(120, 25, 50, 50) channel("dry_wet") range(0, 1, 0.8, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(175, 25, 50, 50) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 82, 230, 30) text("Post reverbsc adds stereo width + tail smoothing.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 185) text(
"SPECTRAL REVERB — Frequency-domain wash and infinite sustain via PVS opcodes.\n\n\
Signal flow: Input → pvsanal (FFT) → pvsblur (time averaging) → pvsfreeze (spectral hold) → pvsynth → post-reverbsc (stereo).\n\n\
pvsblur averages amplitude and frequency tracks over a time window. Long blur times (2-10s) create massive spectral washes\n\
where individual notes dissolve into evolving harmonic clouds. Unlike delay-based reverbs, this naturally avoids metallic ringing.\n\n\
pvsfreeze captures a spectral snapshot and sustains it indefinitely. Freeze Amp holds harmonic amplitudes while letting\n\
frequencies drift. Freeze Freq locks frequencies while amplitudes evolve. Both frozen = complete spectral photograph.\n\n\
Good starting points:\n\
  • Gentle wash: Blur 1.0s, FFT 2048, no freeze, Post Rvb 0.5\n\
  • Deep ocean: Blur 5.0s, FFT 4096, no freeze, Post Rvb 0.7\n\
  • Frozen moment: Play a chord → hit FREEZE → Blur 3.0s for slow spectral evolution\n\
  • Drone generator: Sustained Sine → Blur 8.0s → FREEZE with Amp only → infinite evolving tone\n\n\
Note: pvsblur introduces latency equal to blur time. FFT size changes cause brief silence during reinitialization."
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
; Same test source pattern as shimmer-reverb-rig.
; Generates test signals to feed the spectral reverb.
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
; SPECTRAL REVERB — instr 99
;
; Mono spectral processing (pvsblur + pvsfreeze) with stereo
; post-reverb for width and smoothing.
;
; FFT size is selectable via combobox; changing it triggers
; reinit of the entire PVS chain.
;==============================================================
instr 99

  ; Read k-rate parameters
  kblur     chnget "blur_time"
  kfreeze   chnget "freeze"
  kfrz_amp  chnget "freeze_amp"
  kfrz_frq  chnget "freeze_frq"
  kfilt     chnget "spec_filter"
  kpost_sz  chnget "post_size"
  kpost_tn  chnget "post_tone"
  kdrywet   chnget "dry_wet"
  kvol      chnget "master_vol"

  ; Detect FFT size change → reinit PVS chain
  kfftsel chnget "fft_size"
  k_prev_fft init -1
  if kfftsel != k_prev_fft then
    k_prev_fft = kfftsel
    reinit setup_pvs
  endif

setup_pvs:
  ; Determine FFT size from combobox (1=512, 2=1024, 3=2048, 4=4096)
  i_sel chnget "fft_size"
  i_fft = 2048
  i_fft = (i_sel == 1) ? 512  : i_fft
  i_fft = (i_sel == 2) ? 1024 : i_fft
  i_fft = (i_sel == 4) ? 4096 : i_fft
  i_ovlp = i_fft / 4

  ; Mono input for spectral processing
  amono = (ga_send_L + ga_send_R) * 0.5

  ; Spectral analysis
  fsig pvsanal amono, i_fft, i_ovlp, i_fft, 1

  ; Blur: time-average amplitude + frequency tracks
  fblur pvsblur fsig, kblur, 10

  ; Freeze: hold spectral snapshot when active
  ; kfreeze toggles freeze on/off; kfrz_amp/kfrz_frq select what to freeze
  kfa = (kfreeze > 0.5 && kfrz_amp > 0.5) ? 1 : 0
  kff = (kfreeze > 0.5 && kfrz_frq > 0.5) ? 1 : 0
  ffrz pvsfreeze fblur, kfa, kff

  ; Resynthesize
  awet pvsynth ffrz

rireturn

  ; Post-spectral lowpass filter
  awet butterlp awet, kfilt

  ; Post-reverb provides stereo image + tail smoothing
  apostL, apostR reverbsc awet, awet, kpost_sz, kpost_tn

  ; Wet signal: post-reverb stereo + direct center for clarity
  awetL = apostL + awet * 0.25
  awetR = apostR + awet * 0.25

  ; Dry/wet mix
  aL = ga_send_L * (1 - kdrywet) + awetL * kdrywet
  aR = ga_send_R * (1 - kdrywet) + awetR * kdrywet

  ; Master volume + output
  aL = aL * kvol
  aR = aR * kvol
  aL dcblock aL
  aR dcblock aR
  outs aL, aR

  ; Clear send bus
  ga_send_L = 0
  ga_send_R = 0

endin


</CsInstruments>
<CsScore>
i 1  0 [60*60*4]   ; test source
i 99 0 [60*60*4]   ; spectral reverb
e
</CsScore>
</CsoundSynthesizer>
