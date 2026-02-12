whok ittonastills<Cabbage>
form caption("Tan
e
pura Drone Engine") size(820, 480), colour(30, 30, 50), pluginId("tnpr")

; Header
label bounds(10, 8, 800, 25) text("TANPURA DRONE ENGINE") fontColour(224, 122, 95) fontSize(18) align("left")
label bounds(10, 32, 800, 18) text("Generative Ambient — Instrument Prototype") fontColour(150, 150, 170) fontSize(12) align("left")

; String Tuning Section
groupbox bounds(10, 60, 260, 180) text("TUNING") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(15, 30, 70, 70) channel("fund_freq") range(40, 200, 60, 0.5, 0.1) text("Root Hz") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(95, 30, 70, 70) channel("pa_ratio") range(1.3, 1.55, 1.5, 1, 0.001) text("Pa Ratio") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(175, 30, 70, 70) channel("detune") range(0, 4, 1.2, 1, 0.1) text("Detune Hz") textColour(200,200,220) trackerColour(224, 122, 95)
    label bounds(10, 110, 240, 40) text("4 strings: Pa(5th), Sa(root)×2, Sa(low octave). Detune adds organic beating between Sa strings.") fontColour(140, 140, 160) fontSize(11) align("left")
}

; Jivari (Bridge Buzz) Section
groupbox bounds(280, 60, 260, 180) text("JIVARI (BRIDGE)") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(15, 30, 70, 70) channel("jivari_amt") range(0, 1, 0.45, 1, 0.01) text("Amount") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(95, 30, 70, 70) channel("jivari_bright") range(0, 1, 0.5, 1, 0.01) text("Brightness") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(175, 30, 70, 70) channel("jivari_asym") range(0, 1, 0.3, 1, 0.01) text("Asymmetry") textColour(200,200,220) trackerColour(224, 122, 95)
    label bounds(10, 110, 240, 40) text("Jivari models the curved bridge. Amount controls overtone bloom. Asymmetry adds the characteristic buzzing quality.") fontColour(140, 140, 160) fontSize(11) align("left")
}

; Overtone Shaping
groupbox bounds(550, 60, 260, 180) text("OVERTONES") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(15, 30, 70, 70) channel("num_harmonics") range(6, 24, 14, 1, 1) text("Harmonics") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(95, 30, 70, 70) channel("harm_decay") range(0.2, 0.95, 0.7, 1, 0.01) text("Decay Rate") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(175, 30, 70, 70) channel("harm_motion") range(0, 1, 0.4, 1, 0.01) text("Motion") textColour(200,200,220) trackerColour(224, 122, 95)
    label bounds(10, 110, 240, 40) text("Number of overtones per string. Decay controls rolloff. Motion adds slow random drift to harmonic amplitudes.") fontColour(140, 140, 160) fontSize(11) align("left")
}

; String Excitation
groupbox bounds(10, 250, 260, 180) text("EXCITATION") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(15, 30, 70, 70) channel("pluck_rate") range(0.1, 2, 0.5, 0.5, 0.01) text("Pluck Rate") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(95, 30, 70, 70) channel("pluck_bright") range(0, 1, 0.6, 1, 0.01) text("Pluck Tone") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(175, 30, 70, 70) channel("pluck_rand") range(0, 1, 0.3, 1, 0.01) text("Randomness") textColour(200,200,220) trackerColour(224, 122, 95)
    label bounds(10, 110, 240, 40) text("How often strings are re-excited. Each string has its own cycle. Randomness varies timing for organic feel.") fontColour(140, 140, 160) fontSize(11) align("left")
}

; Space / Effects
groupbox bounds(280, 250, 260, 180) text("SPACE") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(15, 30, 70, 70) channel("reverb_mix") range(0, 1, 0.5, 1, 0.01) text("Reverb") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(95, 30, 70, 70) channel("reverb_size") range(0.3, 0.99, 0.88, 1, 0.01) text("Size") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(175, 30, 70, 70) channel("stereo_width") range(0, 1, 0.6, 1, 0.01) text("Width") textColour(200,200,220) trackerColour(224, 122, 95)
    label bounds(10, 110, 240, 40) text("Reverb adds spatial depth. Width spreads strings across stereo field. Large size for meditative space.") fontColour(140, 140, 160) fontSize(11) align("left")
}

; Master
groupbox bounds(550, 250, 260, 180) text("MASTER") colour(40, 40, 60) fontColour(200, 200, 220) {
    rslider bounds(15, 30, 70, 70) channel("master_vol") range(0, 1, 0.7, 0.5, 0.01) text("Volume") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(95, 30, 70, 70) channel("master_lpf") range(200, 16000, 8000, 0.3, 1) text("Tone") textColour(200,200,220) trackerColour(224, 122, 95)
    rslider bounds(175, 30, 70, 70) channel("warmth") range(0, 1, 0.5, 1, 0.01) text("Warmth") textColour(200,200,220) trackerColour(224, 122, 95)
    label bounds(10, 110, 240, 40) text("Master controls. Warmth adds subtle saturation and low-end emphasis for a richer fundamental.") fontColour(140, 140, 160) fontSize(11) align("left")
}

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

; seed random number generator
seed 0

; sine table for gbuzz
gi_sine ftgen 0, 0, 8192, 10, 1

;--------------------------------------------------------------
; UDO: Single Tanpura String with Jivari
;
; Uses gbuzz for the harmonic series, then models jivari
; (curved bridge buzz) as waveshaping + slow AM. Motion is
; implemented as slow random filter modulation.
;--------------------------------------------------------------
opcode TanpuraString, aa, kkkkkkkkk
  kfreq, kjivari, kjbright, kjasym, knharm, khdecay, kmotion, kpluckbright, kpan xin

  ; — harmonic series via gbuzz —
  ; knharm partials, starting at 1st harmonic, khdecay rolloff
  araw gbuzz 1, kfreq, knharm, 1, khdecay, gi_sine

  ; — jivari: curved bridge interaction —
  ; Slow AM simulates string periodically touching bridge
  ; Rate varies slightly per UDO instance (seeded by kfreq)
  kjiv_rate = 0.12 + kfreq * 0.0005
  kjiv_mod  lfo 1, kjiv_rate, 1
  ; Asymmetric shaping: one-sided buzz (string only touches bridge one way)
  kjiv_mod  = (kjiv_mod + kjasym * kjiv_mod * kjiv_mod) / (1 + kjasym)
  kjiv_env  = 1 + kjivari * kjiv_mod * 0.5

  ; Soft saturation adds upper harmonics when jivari is high
  ; (models the nonlinear bridge-string contact)
  adriven   = araw * kjiv_env * (1 + kjivari * 1.5)
  ajivari   = tanh(adriven)

  ; — motion: slow random filter sweep —
  ; Simulates natural drift of overtone amplitudes
  kfilt_rnd1 randi kmotion * 1500, 0.07
  kfilt_rnd2 randi kmotion * 800, 0.03
  kcutoff    = 800 + kjbright * 6000 + kfilt_rnd1 + kfilt_rnd2
  kcutoff    limit kcutoff, 300, 14000

  aout butterlp ajivari, kcutoff

  ; — output with panning —
  aL = aout * (1 - kpan)
  aR = aout * kpan

  xout aL, aR
endop


;--------------------------------------------------------------
; Instrument 1: Tanpura Drone (always on)
;--------------------------------------------------------------
instr 1
  ; — read parameters —
  kfund    chnget "fund_freq"
  kpa      chnget "pa_ratio"
  kdetune  chnget "detune"
  kjivari  chnget "jivari_amt"
  kjbright chnget "jivari_bright"
  kjasym   chnget "jivari_asym"
  knharm   chnget "num_harmonics"
  khdecay  chnget "harm_decay"
  kmotion  chnget "harm_motion"
  kpluck   chnget "pluck_rate"
  kpluckbr chnget "pluck_bright"
  kpluckrn chnget "pluck_rand"
  krvbmix  chnget "reverb_mix"
  krvbsize chnget "reverb_size"
  kwidth   chnget "stereo_width"
  kvol     chnget "master_vol"
  klpf     chnget "master_lpf"
  kwarmth  chnget "warmth"

  ; — 4 strings with traditional tuning —
  ; String 1: Pa (fifth) - typically tuned to ~1.5× fundamental
  ; String 2: Sa (root) - upper octave
  ; String 3: Sa (root) - upper octave, slightly detuned
  ; String 4: Sa (root) - lower octave

  kfreq1 = kfund * kpa            ; Pa string
  kfreq2 = kfund * 2              ; Sa upper
  kfreq3 = kfund * 2 + kdetune   ; Sa upper (detuned for beating)
  kfreq4 = kfund                   ; Sa lower octave

  ; stereo placement: spread strings across field
  ; center = 0.5, width controls spread
  kpan1 = 0.5 - kwidth * 0.35   ; Pa slightly left
  kpan2 = 0.5 + kwidth * 0.15   ; Sa slightly right
  kpan3 = 0.5 - kwidth * 0.15   ; Sa detuned slightly left
  kpan4 = 0.5 + kwidth * 0.35   ; Sa low slightly right

  ; — generate each string —
  aL1, aR1 TanpuraString kfreq1, kjivari, kjbright, kjasym, knharm, khdecay, kmotion, kpluckbr, kpan1
  aL2, aR2 TanpuraString kfreq2, kjivari, kjbright, kjasym, knharm, khdecay, kmotion, kpluckbr, kpan2
  aL3, aR3 TanpuraString kfreq3, kjivari, kjbright, kjasym, knharm, khdecay, kmotion, kpluckbr, kpan3
  aL4, aR4 TanpuraString kfreq4, kjivari * 0.7, kjbright * 0.8, kjasym, knharm * 0.7, khdecay, kmotion, kpluckbr, kpan4

  ; — pluck envelopes —
  ; each string has its own pluck cycle with randomized timing
  ; this simulates the tanpura player re-exciting strings

  ; string pluck timing: independent cycles
  ; base period from pluck_rate, randomized per string
  kperiod1 = (1/kpluck) * (1 + kpluckrn * (randi:k(0.3, 0.5) ))
  kperiod2 = (1/kpluck) * (1 + kpluckrn * (randi:k(0.3, 0.7) ))
  kperiod3 = (1/kpluck) * 1.02 * (1 + kpluckrn * (randi:k(0.3, 0.6) ))
  kperiod4 = (1/kpluck) * 1.5 * (1 + kpluckrn * (randi:k(0.3, 0.4) ))

  ; pluck envelopes using k-rate phasor for cycling
  kphase1 phasor 1/kperiod1
  kphase2 phasor 1/kperiod2
  kphase3 phasor 1/kperiod3
  kphase4 phasor 1/kperiod4

  ; envelope shape: sharp attack, slow decay
  ; pluck_bright controls how sharp the attack is
  ksharp = 3 + kpluckbr * 12
  kenv1 = (1 - kphase1) ^ ksharp
  kenv2 = (1 - kphase2) ^ ksharp
  kenv3 = (1 - kphase3) ^ ksharp
  kenv4 = (1 - kphase4) ^ ksharp

  ; base level so strings never fully die
  aenv1 = 0.35 + a(kenv1) * 0.65
  aenv2 = 0.35 + a(kenv2) * 0.65
  aenv3 = 0.35 + a(kenv3) * 0.65
  aenv4 = 0.35 + a(kenv4) * 0.65

  ; — mix strings with envelopes —
  aL = aL1*aenv1 + aL2*aenv2 + aL3*aenv3 + aL4*aenv4
  aR = aR1*aenv1 + aR2*aenv2 + aR3*aenv3 + aR4*aenv4

  ; — warmth: subtle saturation + low shelf boost —
  if kwarmth > 0.01 then
    aL = tanh(aL * (1 + kwarmth * 2))
    aR = tanh(aR * (1 + kwarmth * 2))
    ; low shelf emphasis
    aLlow butterlp aL, 200
    aRlow butterlp aR, 200
    aL = aL + aLlow * kwarmth * 0.5
    aR = aR + aRlow * kwarmth * 0.5
  endif

  ; — master low pass filter —
  aL butterlp aL, klpf
  aR butterlp aR, klpf

  ; — reverb —
  aRvbL, aRvbR reverbsc aL, aR, krvbsize, 12000
  aL = aL * (1 - krvbmix) + aRvbL * krvbmix
  aR = aR * (1 - krvbmix) + aRvbR * krvbmix

  ; — master volume and soft clip safety —
  aL = tanh(aL * kvol * 0.3)
  aR = tanh(aR * kvol * 0.3)

  ; — DC block —
  aL dcblock aL
  aR dcblock aR

  outs aL, aR

endin

</CsInstruments>
<CsScore>
; tanpura drone runs indefinitely
i 1 0 [60*60*4]   ; 4 hours
e
</CsScore>
</CsoundSynthesizer>
