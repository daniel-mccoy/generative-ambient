<Cabbage>
form caption("Shimmer Reverb Rig") size(740, 480), colour(30, 30, 50), pluginId("shrv")

; Header
label bounds(10, 8, 720, 25) text("SHIMMER REVERB RIG") fontColour(100, 180, 224) fontSize(18) align("left")
label bounds(10, 32, 720, 18) text("Generative Ambient — reverbsc + PVS pitch shift + feedback delay (after Steven Yi)") fontColour(150, 150, 170) fontSize(12) align("left")

;=====================================================================
; ROW 1 (y=60): TEST SOURCE
;=====================================================================

groupbox bounds(10, 60, 720, 90) text("TEST SOURCE") colour(40, 40, 60) fontColour(200, 200, 220) {
    combobox bounds(10, 28, 110, 22) channel("src_type") value(1) text("Sine Ping", "Noise Burst", "Sustained Sine", "Sustained Noise")
    rslider bounds(130, 22, 50, 50) channel("src_freq") range(60, 2000, 220, 0.4, 1) text("Freq") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(185, 22, 50, 50) channel("src_level") range(0, 1, 0.5, 1, 0.01) text("Level") textColour(200,200,220) trackerColour(150, 150, 200)
    rslider bounds(240, 22, 50, 50) channel("src_rate") range(0.1, 4, 0.5, 0.5, 0.01) text("Rate") textColour(200,200,220) trackerColour(150, 150, 200)
    button bounds(300, 30, 60, 35) channel("src_trigger") text("Ping", "Ping") value(0) colour:0(60, 60, 80) colour:1(100, 180, 224) fontColour:0(200, 200, 220)
    label bounds(375, 28, 340, 40) text("Sine/Noise Ping = auto-triggered bursts at Rate Hz. Sustained = continuous. Manual Ping button always works.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; ROW 2 (y=160): REVERB + SHIMMER + FEEDBACK
;=====================================================================

; Core reverb
groupbox bounds(10, 160, 190, 130) text("REVERB") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 50, 50) channel("rvb_size") range(0.5, 0.99, 0.93, 1, 0.01) text("Size") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(65, 25, 50, 50) channel("rvb_tone") range(1000, 16000, 10000, 0.4, 1) text("Tone") textColour(200,200,220) trackerColour(100, 180, 224)
    rslider bounds(120, 25, 50, 50) channel("rvb_predelay") range(0, 300, 30, 0.5, 1) text("PreDly") textColour(200,200,220) trackerColour(100, 180, 224)
    label bounds(10, 82, 170, 30) text("reverbsc core. Size = feedback, Tone = HF damping.") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Shimmer
groupbox bounds(205, 160, 290, 130) text("SHIMMER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 50, 50) channel("shim_ratio") range(0.5, 4.0, 2.0, 0.5, 0.01) text("Ratio") textColour(200,200,220) trackerColour(120, 200, 224)
    rslider bounds(65, 25, 50, 50) channel("shim_amount") range(0, 0.9, 0.4, 1, 0.01) text("Amount") textColour(200,200,220) trackerColour(120, 200, 224)
    rslider bounds(120, 25, 50, 50) channel("shim_fb_time") range(20, 3000, 200, 0.4, 1) text("FB Time") textColour(200,200,220) trackerColour(120, 200, 224)
    rslider bounds(175, 25, 50, 50) channel("shim_fb_damp") range(200, 12000, 5000, 0.4, 1) text("FB Damp") textColour(200,200,220) trackerColour(120, 200, 224)
    label bounds(10, 82, 270, 30) text("Ratio: pitch shift (2=octave, 1.5=fifth). Amount: shimmer feedback. FB Time/Damp: echo delay + HF damping.") fontColour(140, 140, 160) fontSize(9) align("left")
}

; Master
groupbox bounds(500, 160, 230, 130) text("OUTPUT") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(10, 25, 50, 50) channel("dry_wet") range(0, 1, 0.7, 1, 0.01) text("Dry/Wet") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(65, 25, 50, 50) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 180, 100)
    rslider bounds(120, 25, 50, 50) channel("warmth") range(0, 1, 0.2, 1, 0.01) text("Warmth") textColour(200,200,220) trackerColour(224, 180, 100)
    label bounds(10, 82, 210, 30) text("Warmth adds tanh saturation + low shelf.") fontColour(140, 140, 160) fontSize(9) align("left")
}

;=====================================================================
; DESCRIPTION
;=====================================================================

label bounds(10, 305, 720, 165) text(
"SHIMMER REVERB — Inspired by Brian Eno's ambient feedback reverb technique.\n\n\
Signal flow: Input → Pre-delay → Mix with feedback → DC block + tanh soft clip → reverbsc → PVS pitch shift → delay → back to mix.\n\n\
The pitch-shifted reverb tail feeds back into itself, creating stacked layers of harmonics. At Ratio=2.0 (octave up),\n\
each feedback cycle adds another octave, building a shimmering cathedral. At 1.5 (fifth), you get Pythagorean stacking.\n\
Tanh soft clipping in the feedback loop prevents runaway while adding subtle harmonic warmth.\n\n\
Good starting points:\n\
  • Subtle shimmer: Size 0.93, Amount 0.3, Ratio 2.0, FB Time 200ms\n\
  • Cathedral wash: Size 0.97, Amount 0.5, Ratio 2.0, FB Time 400ms\n\
  • Ethereal fifth: Size 0.95, Amount 0.45, Ratio 1.5, FB Time 300ms\n\
  • Deep space: Size 0.98, Amount 0.6, Ratio 2.0, FB Time 1500ms, FB Damp 2000"
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
; UDO: ShimmerReverb
;
; Stereo shimmer reverb inspired by Steven Yi's shimmer_reverb.
; reverbsc → PVS pitch shift → feedback delay → tanh soft clip.
;
; Inputs:
;   ainL, ainR   — stereo input
;   kpredelay    — pre-delay in ms (0-300)
;   krvbfb       — reverbsc feedback (0.5-0.99)
;   krvbco       — reverbsc cutoff Hz
;   kfblvl       — shimmer feedback amount (0-0.9)
;   kfbdel       — feedback delay time in ms
;   kfbdamp      — feedback lowpass cutoff Hz
;   kratio       — pitch shift ratio (2.0 = octave up)
;
; Outputs:
;   aoutL, aoutR — wet reverb signal (stereo)
;==============================================================
opcode ShimmerReverb, aa, aakkkkkkk
  ainL, ainR, kpredelay, krvbfb, krvbco, kfblvl, kfbdel, kfbdamp, kratio xin

  ; Pre-delay
  apdL vdelay3 ainL, kpredelay, 500
  apdR vdelay3 ainR, kpredelay, 500

  ; Mix with feedback from previous cycle
  afbL init 0
  afbR init 0
  amixL = apdL + afbL * kfblvl
  amixR = apdR + afbR * kfblvl

  ; DC block + soft clip to prevent runaway
  amixL dcblock2 amixL
  amixR dcblock2 amixR
  amixL = tanh(amixL)
  amixR = tanh(amixR)

  ; Reverb
  arvbL, arvbR reverbsc amixL, amixR, krvbfb, krvbco

  ; Pitch shift via PVS (left channel)
  ffL  pvsanal  arvbL, 2048, 256, 2048, 1
  ffLs pvscale  ffL, kratio
  apshL pvsynth ffLs

  ; Pitch shift via PVS (right channel)
  ffR  pvsanal  arvbR, 2048, 256, 2048, 1
  ffRs pvscale  ffR, kratio
  apshR pvsynth ffRs

  ; Feedback path: delay + damping filter
  afdL vdelay3 apshL, kfbdel, 5000
  afdR vdelay3 apshR, kfbdel, 5000
  afbL tone afdL, kfbdamp
  afbR tone afdR, kfbdamp

  xout arvbL, arvbR
endop


;==============================================================
; TEST SOURCE — instr 1
;
; Generates test signals to feed the reverb:
;   1 = Sine Ping (auto-triggered bursts)
;   2 = Noise Burst (auto-triggered)
;   3 = Sustained Sine
;   4 = Sustained Noise
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

  ; Generate all signal types (only selected one used)
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
; SHIMMER REVERB — instr 99
;
; Reads from send bus, processes through ShimmerReverb UDO,
; mixes dry/wet, applies warmth, outputs to speakers.
;==============================================================
instr 99

  ; Read parameters
  ksize     chnget "rvb_size"
  ktone     chnget "rvb_tone"
  kpredel   chnget "rvb_predelay"
  kratio    chnget "shim_ratio"
  kamount   chnget "shim_amount"
  kfbtime   chnget "shim_fb_time"
  kfbdamp   chnget "shim_fb_damp"
  kdrywet   chnget "dry_wet"
  kvol      chnget "master_vol"
  kwarmth   chnget "warmth"

  ; Process through shimmer reverb UDO
  awetL, awetR ShimmerReverb ga_send_L, ga_send_R, kpredel, ksize, ktone, kamount, kfbtime, kfbdamp, kratio

  ; Dry/wet mix
  aL = ga_send_L * (1 - kdrywet) + awetL * kdrywet
  aR = ga_send_R * (1 - kdrywet) + awetR * kdrywet

  ; Warmth: saturation + low shelf
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

  ; Clear send bus
  ga_send_L = 0
  ga_send_R = 0

endin


</CsInstruments>
<CsScore>
i 1  0 [60*60*4]   ; test source
i 99 0 [60*60*4]   ; shimmer reverb
e
</CsScore>
</CsoundSynthesizer>
