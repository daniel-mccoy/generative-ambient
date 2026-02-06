<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

;======================================================
; BAND TEST - Isolated bass / mid / high for shader debug
; Cycles: BASS alone → pause → MID alone → pause →
;         HIGH alone → pause → ALL together → repeat
;======================================================

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

; --- BASS: fat sub pulse (80 Hz + 120 Hz) ---
instr 1
  iamp = p4
  kenv linseg 0, 0.05, iamp, p3-0.15, iamp, 0.1, 0
  a1 vco2 kenv, 80, 0       ; sawtooth
  a2 vco2 kenv*0.7, 120, 0
  amix = (a1 + a2) * 0.5
  ; low-pass to keep it purely bass
  afilt butterlp amix, 250
  outs afilt, afilt
endin

; --- MID: nasal vocal tone (600 Hz + 1200 Hz) ---
instr 2
  iamp = p4
  kenv linseg 0, 0.05, iamp, p3-0.15, iamp, 0.1, 0
  a1 vco2 kenv, 600, 10     ; square
  a2 vco2 kenv*0.6, 1200, 10
  amix = (a1 + a2) * 0.4
  ; band-pass: cut below 300, above 2000
  alow butterhp amix, 300
  afilt butterlp alow, 2000
  outs afilt, afilt
endin

; --- HIGH: bright shimmer (4000 Hz + 8000 Hz noise burst) ---
instr 3
  iamp = p4
  kenv linseg 0, 0.02, iamp, p3-0.12, iamp, 0.1, 0
  a1 poscil kenv, 4000
  a2 poscil kenv*0.5, 8000
  anoise noise kenv*0.3, 0.5
  amix = a1 + a2 + anoise
  ; high-pass to keep it purely highs
  afilt butterhp amix, 2500
  outs afilt * 0.5, afilt * 0.5
endin

</CsInstruments>
<CsScore>

; Each section ~3s with 1s gap, then all together
; Round 1
;        start dur  amp
; BASS alone
i1       0     3    0.5
; gap 1s
; MID alone
i2       4     3    0.4
; gap 1s
; HIGH alone
i3       8     3    0.35
; gap 1s

; ALL TOGETHER
i1       12    4    0.5
i2       12    4    0.4
i3       12    4    0.35

; gap 1s

; Round 2 - louder, more dramatic
; BASS pulses (staccato)
i1       17    0.5  0.6
i1       18    0.5  0.6
i1       19    0.5  0.6
; gap
; MID sustained
i2       21    4    0.5
; gap
; HIGH bursts
i3       26    0.3  0.4
i3       26.5  0.3  0.4
i3       27    0.3  0.4
i3       27.5  0.3  0.4
; gap

; Final: everything at once, big
i1       29    6    0.6
i2       29    6    0.5
i3       29    6    0.4

e
</CsScore>
</CsoundSynthesizer>
