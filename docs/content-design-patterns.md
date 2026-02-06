# Content Design Patterns

Patterns and techniques for designing generative ambient instruments and pieces. Gathered from production workflows, tutorials, and experimentation.

---

## 1. Looping Envelopes with Randomized Rates

**Source:** Ableton Meld generative workflow (Signs of Life)

The core generative technique: an amplitude or filter envelope set to loop mode (attack-decay only, sustain at zero) becomes a free-running rhythmic pulse. The key insight is **modulating the decay time** with a random sample-and-hold LFO — this makes the pulse rate constantly vary, producing never-repeating rhythmic patterns from a single held note.

### Csound Implementation

```csound
; Looping AD envelope with randomized decay
instr looping_ad
  k_min_decay = 0.3
  k_max_decay = 3.0

  ; Random S&H modulates decay time
  k_rand randh 1, 0.5          ; new random value ~every 2s
  k_decay = k_min_decay + (k_rand + 1) * 0.5 * (k_max_decay - k_min_decay)

  ; Looping envelope: attack → decay → retrigger
  k_phase phasor (1 / (0.05 + k_decay))
  k_env = k_phase < 0.02 ? k_phase / 0.02 : (1 - (k_phase - 0.02) / 0.98)

  a_sig oscili k_env, p4
  outs a_sig, a_sig
endin
```

### Design Rules
- Attack should be short (5-50ms) for percussive pulses, longer (200ms-1s) for swells
- Decay range determines character: 0.3-1s = rhythmic, 1-5s = breathing, 5-15s = glacial
- Modulating the decay rate with a **slow** random source (period 2-10s) prevents mechanical repetition while maintaining coherence
- Multiple instruments with different loop rates create polyrhythmic textures naturally

---

## 2. Scale-Quantized Pitch Modulation

**Source:** Meld scale awareness feature

When modulating pitch (detuning, transposition, harmonic content), constraining to scale degrees prevents dissonance and keeps the result musical. Sweeping a detune parameter through scale-locked values produces melodic motion rather than microtonal drift.

### Csound Implementation

```csound
; Scale table: A# minor (intervals in semitones from root)
gi_scale ftgen 0, 0, 8, -2, 0, 2, 3, 5, 7, 8, 10, 12

; Quantize a continuous value to nearest scale degree
opcode ScaleSnap, k, kkk
  k_val, k_root_midi, k_table xin
  k_semitones = k_val - k_root_midi
  k_octave = int(k_semitones / 12)
  k_degree = k_semitones - k_octave * 12
  ; Find nearest scale degree
  k_len = ftlen(k_table)
  k_best = 0
  k_best_dist = 99
  k_idx = 0
  loop:
    k_step tab k_idx, k_table
    k_dist = abs(k_degree - k_step)
    if k_dist < k_best_dist then
      k_best = k_step
      k_best_dist = k_dist
    endif
    k_idx += 1
    if k_idx < k_len kgoto loop
  k_snapped = k_root_midi + k_octave * 12 + k_best
  xout k_snapped
endop
```

### Design Rules
- Every piece defines its scale in `piece.json` — the conductor instrument loads it into a function table
- Melodic instruments should quantize any pitch modulation to the piece's scale
- Drone instruments can ignore scale quantization (continuous tuning drift is desirable for beating effects)
- The AI pipeline should generate orchestras that reference the piece's scale table, not hardcode intervals

---

## 3. Layered / Self-Modulation

**Source:** Meld LFO → LFO Effects → destination chain

Deep modulation creates organic movement: an LFO modulates another LFO's rate or depth, which then modulates an audio parameter. The result is modulation that itself evolves over time — critical for long-form ambient where static LFO rates sound mechanical.

### Modulation Hierarchy

```
Layer 1 (slowest): k_meta_lfo — modulates rates/depths of Layer 2
Layer 2 (medium):  k_mod_lfo  — modulates audio parameters
Layer 3 (fastest): audio-rate modulation (vibrato, tremolo, FM)
```

### Csound Implementation

```csound
; Self-modulating LFO chain
k_meta   lfo 1, 0.03, 1           ; very slow triangle (period ~33s)
k_rate   = 0.1 + k_meta * 0.15    ; modulated rate: 0.1 - 0.25 Hz
k_mod    lfo 1, k_rate, 0         ; sine LFO with varying rate
k_filter = 800 + k_mod * 400      ; filter cutoff: 400 - 1200 Hz
```

### Design Rules
- Meta-modulation periods should be 20-60s for ambient — slow enough to be subliminal
- Limit modulation depth chains to 2-3 layers; deeper chains become chaotic
- The conductor instrument owns the meta-layer; individual instruments own their local modulation
- Cross-modulation between instruments (e.g., drone amplitude modulates texture filter) creates coupling — use sparingly for "breathing" effects

---

## 4. Delay-as-Space (Reverb from Delay)

**Source:** Valhalla Delay "Sequence Cinematics" presets creating reverb-like spaces

A delay with high feedback, diffusion, and modulated delay times can approximate reverb, often with more character than a generic reverb algorithm. This is especially effective for ambient because the echoes remain distinct longer, creating depth without mud.

### Csound Implementation

```csound
; Modulated delay as ambient space
instr delay_space
  a_in inch 1
  k_time = 0.3 + lfo:k(0.05, 0.1)    ; modulated delay time ~300ms ± 50ms
  k_fb   = 0.75                        ; high feedback for dense tail
  a_del vdelay3 a_in + a_del * k_fb, k_time * 1000, 1000
  ; Diffuse with allpass chain
  a_diff1 alpass a_del, 0.08, 0.031
  a_diff2 alpass a_diff1, 0.06, 0.022
  outs a_diff2 * 0.4, a_diff2 * 0.4
endin
```

### Design Rules
- Modulating delay time by ±10-20% prevents metallic resonance
- Feedback 0.6-0.8 for ambient wash, 0.3-0.5 for distinct echoes
- A single flexible delay-reverb effect instrument can serve both roles — control via `k_delay_character` channel (0 = clean echo, 1 = diffuse space)
- Always follow with a limiter — high feedback delays can run away

---

## 5. Compositional Architecture: Source + Modulation + Space

**Source:** The overall workflow demonstrated: simple oscillator → deep modulation → spatial effects = complete generative piece

The pattern for building a generative ambient piece:

```
Layer 1: DRONE     — simple sustained tone, looping envelope, slow evolution
Layer 2: SEQUENCE  — scale-quantized melodic fragments, randomized rhythm
Layer 3: TEXTURE   — granular/noise, modulated by meta-LFOs
Layer 4: BASS      — sub-frequency foundation, slow filter modulation
Layer 5: EFFECTS   — delay-space, reverb, shared across layers via sends

CONDUCTOR          — meta-instrument controlling density, timing, transitions
```

### Design Rules
- Each layer should be independently interesting but simple — complexity emerges from interaction
- The conductor modulates layer amplitudes and effect sends over long time scales (30s-5min)
- Not all layers play simultaneously — the conductor fades layers in/out for evolving density
- A piece should sound good with any 2-3 layers active — never depend on all layers for coherence
- Bass and drone can share a Csound instrument with different parameter ranges
- Sequence layer benefits most from scale quantization and randomized note division

---

## 6. Unison and Detuning for Width

**Source:** Meld unison controls adding spread and thickness

Multiple slightly-detuned voices of the same oscillator create width and warmth. For ambient, the detuning amount should be subtle (1-10 cents) for pads, wider (10-30 cents) for drones.

### Csound Implementation

```csound
; Simple unison with spread
instr unison_pad
  i_voices = 5
  i_spread = 0.08  ; 8 cents total spread
  a_mix = 0
  i_v = 0
  loop:
    i_detune = -i_spread/2 + i_spread * (i_v / (i_voices - 1))
    i_freq = p4 * cent(i_detune * 100)
    a_osc oscili 1/i_voices, i_freq
    a_mix += a_osc
    i_v += 1
    if i_v < i_voices igoto loop
  outs a_mix, a_mix
endin
```

### Design Rules
- Odd number of voices (3, 5, 7) keeps a centered pitch
- Pan voices across stereo field for width: center voice at 0, outer voices hard L/R
- Modulating the spread amount slowly adds movement ("chorus" effect)
- For drones, combine unison with beating (Risset-style micro-detuning from cascade_harmonics.csd)
