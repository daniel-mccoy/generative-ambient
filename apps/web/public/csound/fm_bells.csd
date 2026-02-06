<CsoundSynthesizer>
<CsOptions>
-odac
-d
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 10
nchnls = 2
0dbfs = 1

instr 1
  icar = p4
  imod = icar * 1.414
  ipeak = p5

  kindex expon ipeak, p3, 0.01
  kenv expon 0.3, p3, 0.001

  amod oscil imod * kindex, imod, 1
  acar oscil kenv, icar + amod, 1

  outs acar, acar
endin
</CsInstruments>
<CsScore>
f1 0 4096 10 1
i1  0   4    440   8
i1  1   4    880   10
i1  2   5    660   12
e
</CsScore>
</CsoundSynthesizer>
