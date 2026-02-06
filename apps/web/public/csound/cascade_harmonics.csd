<CsoundSynthesizer>
<CsOptions>
-odac
-d
</CsOptions>
<CsInstruments>

;======================================================
; CASCADE HARMONICS - Risset beating effect
; From Kim Cascone's blueCube (faithful version)
; 9 oscillators with slight frequency offsets
; Uses "approaching square" waveform for richer timbre
;======================================================

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

garvbsig init 0

instr 8

  iamp    = p5 / 40000
  i1      = p6
  i2      = 2 * p6
  i3      = 3 * p6
  i4      = 4 * p6

  ampenv  linen iamp, 30, p3, 30

  a1      oscili ampenv, p4, 20
  a2      oscili ampenv, p4+i1, 20
  a3      oscili ampenv, p4+i2, 20
  a4      oscili ampenv, p4+i3, 20
  a5      oscili ampenv, p4+i4, 20
  a6      oscili ampenv, p4-i1, 20
  a7      oscili ampenv, p4-i2, 20
  a8      oscili ampenv, p4-i3, 20
  a9      oscili ampenv, p4-i4, 20

  aoutL   = (a1+a3+a5+a7+a9) * 0.5
  aoutR   = (a2+a4+a6+a8) * 0.5
          outs aoutL, aoutR

  asnd    = (aoutL + aoutR) * 0.5
  garvbsig = garvbsig + asnd * 0.6

endin

; Reverb
instr 99
  aL, aR reverbsc garvbsig, garvbsig, 0.87, 12000
  outs aL * 0.5, aR * 0.5
  garvbsig = 0
endin

</CsInstruments>
<CsScore>
; Approaching square wave - gives richer harmonics than pure sine
f20 0 4096 10 1 0 0 0 .7 .7 .7 .7 .7 .7

; Reverb
i99 0 120

; Cascone parameters with boosted amplitude
;ins strt dur  freq amp    offset
i8   0    80   93   15000  .03

; Experiment: different frequencies
i8   40   60   62   18000  .025    ; lower
i8   60   50   139  15000  .04     ; fifth above

e
</CsScore>
</CsoundSynthesizer>
