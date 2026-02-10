<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

;======================================================
; DEEP FOCUS — Pluck Sequencer (solo)
;
; Probabilistic eighth-note plucks (instr 2) with
; velocity-driven moogladder filter sweeps across
; C minor pentatonic. Conductor (101) modulates
; density, range, cutoff, and resonance via LFOs.
;======================================================

sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

; C minor pentatonic (one octave): C, Eb, F, G, Bb
gi_scale ftgen 1, 0, -5, -2, 0, 3, 5, 7, 10

; Send buses
ga_rvb_L init 0
ga_rvb_R init 0
ga_dly_L init 0
ga_dly_R init 0

; Per-instrument analysis accumulator
gk_pluck_rms init 0

; Pluck modulation (set by conductor 101, read by voice 2)
gk_pluck_mod_cutoff init 0
gk_pluck_mod_reso   init 0

;------------------------------------------------------
; SEQUENCE CONDUCTOR — probabilistic pluck sequencer
;
; Modulation LFOs (matching rig preset):
;   Density wander  — 0.1 Hz, +/-0.165 around 0.50
;   Range S&H       — 0.07 Hz, +/-0.48 octaves around 1.5
;   Cutoff sine     — 0.05 Hz, +/-2040 Hz (written to global)
;   Reso wander     — 0.15 Hz, +/-0.078 around 0.25 (written to global)
;------------------------------------------------------
instr 101

  ; === MODULATION LFOs ===

  ; Density wander (~0.1 Hz, +/-0.165)
  k_dw1    randi  1, 0.1
  k_dw2    randi  0.5, 0.043
  k_dens_mod = (k_dw1 + k_dw2) / 1.5 * 0.165

  ; Range S&H (~0.07 Hz, +/-0.48 octaves)
  k_rphs   phasor 0.07
  k_rsh    init   0
  k_rprev  init   1
  if k_rphs < k_rprev then
    k_rsh  random -1, 1
  endif
  k_rprev  = k_rphs
  k_range_mod = k_rsh * 0.48

  ; Cutoff sine (~0.05 Hz, +/-2040 Hz) -> global for voice
  k_cut_lfo lfo 1, 0.05, 0
  gk_pluck_mod_cutoff = k_cut_lfo * 2040

  ; Reso wander (~0.15 Hz, +/-0.078) -> global for voice
  k_rw1    randi  1, 0.15
  k_rw2    randi  0.5, 0.064
  gk_pluck_mod_reso = (k_rw1 + k_rw2) / 1.5 * 0.078

  ; === COMPUTED PARAMETERS ===

  k_density = 0.50 + k_dens_mod
  k_density limit k_density, 0.1, 0.9

  k_range  = 1.5 + k_range_mod
  k_range  limit k_range, 0.5, 2.5
  k_range_semi = k_range * 12

  ; === SEQUENCER ===

  ; Eighth-note clock at 80 BPM -> 2.667 Hz
  k_tick   metro  2.667

  if k_tick == 1 then

    ; Single density gate
    k_roll   random 0, 1
    if k_roll < k_density then

      ; Polyphony limit: max 8 simultaneous pluck voices
      k_active active 2
      if k_active < 8 then

        ; --- Pitch: scale-quantized across modulated range from C3 ---
        k_deg    random 0, 4.99
        k_semi   table  int(k_deg), gi_scale
        k_oct_off random 0, k_range_semi - 0.01
        k_oct_off = int(k_oct_off)
        k_total  = k_semi + k_oct_off
        k_octave = int(k_total / 12)
        k_rem    = k_total - k_octave * 12
        k_snap = (k_rem < 2) ? 0 : (k_rem < 4) ? 3 : (k_rem < 6) ? 5 : (k_rem < 9) ? 7 : 10
        k_freq   = 130.81 * semitone(k_snap + k_octave * 12)

        ; 20% chance of octave up
        k_up     random 0, 1
        k_freq   = (k_up < 0.2) ? k_freq * 2 : k_freq

        ; Clamp to reasonable range (C2-C5)
        k_freq   limit k_freq, 65.41, 1046.5

        ; --- Velocity: wide range ---
        k_vel    random 0.09, 0.98

        ; --- Pan: spread across stereo field ---
        k_pan    random 0.2, 0.8

        ; --- Spawn pluck note ---
        event    "i", 2, 0, 3.0, k_freq, k_vel, k_pan

        ; 15% chance of double-trigger (syncopation)
        k_dbl    random 0, 1
        if k_dbl < 0.15 then
          event  "i", 2, 0.1875, 3.0, k_freq, k_vel * 0.8, 1 - k_pan
        endif

      endif
    endif
  endif

endin

;------------------------------------------------------
; PLUCK SYNTH — moogladder with resonance modulation
;------------------------------------------------------
instr 2

  i_freq = p4
  i_vel  = p5
  i_pan  = p6

  ; ===== AMP ENVELOPE: 5ms attack, 2.67s decay, zero sustain =====
  k_aenv   linseg 0, 0.005, 1, 2.67, 0
  k_aenv   = k_aenv * k_aenv

  ; ===== MOD ENVELOPE: 5ms attack, 1.69s decay =====
  k_menv   linseg 0, 0.005, 1, 1.69, 0
  k_menv   = k_menv * k_menv

  ; ===== OSCILLATOR: Saw + Square blend at 42.9% =====
  a_saw    vco2   1, i_freq, 0
  a_sqr    vco2   1, i_freq, 10, 0.5
  a_osc    = a_saw * 0.571 + a_sqr * 0.429

  ; ===== FILTER: moogladder 24dB/oct LP with resonance =====
  i_base_cut = 313
  i_depth    = 4000
  k_fmod   = k_aenv * 0.38 + k_menv * 0.53 + i_vel * 0.36
  k_cutoff = i_base_cut + k_fmod * i_depth + gk_pluck_mod_cutoff
  k_cutoff limit k_cutoff, 200, 12000

  ; Resonance: 0.25 base + conductor wander modulation
  k_reso   = 0.25 + gk_pluck_mod_reso
  k_reso   limit k_reso, 0, 0.8

  ; moogladder: 24dB/oct with resonance for pluck character
  a_filt   moogladder a_osc, k_cutoff, k_reso

  ; ===== OUTPUT =====
  i_vol    = i_vel * 0.18

  i_panL   = sqrt(1 - i_pan)
  i_panR   = sqrt(i_pan)

  a_out    = a_filt * k_aenv * i_vol
  a_outL   = a_out * i_panL
  a_outR   = a_out * i_panR

  outs     a_outL, a_outR

  ; Per-instrument analysis
  k_rms    rms    a_out, 20
  gk_pluck_rms max gk_pluck_rms, k_rms

  ; Effect sends (high delay send)
  ga_dly_L = ga_dly_L + a_outL * 0.9
  ga_dly_R = ga_dly_R + a_outR * 0.9
  ga_rvb_L = ga_rvb_L + a_outL * 0.35
  ga_rvb_R = ga_rvb_R + a_outR * 0.35

endin

;------------------------------------------------------
; CHANNEL WRITER
;------------------------------------------------------
instr 97

  k_plr    port   gk_pluck_rms, 0.02

  chnset   k_plr, "pluck_rms"

  gk_pluck_rms = 0

endin

;------------------------------------------------------
; PING-PONG DELAY — dotted eighths at 80 BPM
;------------------------------------------------------
instr 98

  i_bpm    = 80
  i_eighth = 60 / i_bpm / 2
  i_dotted = i_eighth * 1.5
  i_maxdel = 2.0

  k_fb     = 0.65
  k_wet    = 0.88

  k_mod    lfo    0.003, 0.23, 0

  a_tap_L  init   0
  a_tap_R  init   0

  a_buf_L  delayr i_maxdel
  a_tap_L  deltap3 i_dotted + k_mod
           delayw ga_dly_L + a_tap_R * k_fb

  a_buf_R  delayr i_maxdel
  a_tap_R  deltap3 i_dotted - k_mod
           delayw ga_dly_R + a_tap_L * k_fb

  outs     a_tap_L * k_wet, a_tap_R * k_wet

  ga_rvb_L = ga_rvb_L + a_tap_L * 0.2
  ga_rvb_R = ga_rvb_R + a_tap_R * 0.2

  ga_dly_L = 0
  ga_dly_R = 0

endin

;------------------------------------------------------
; REVERB
;------------------------------------------------------
instr 99
  a_L, a_R reverbsc ga_rvb_L, ga_rvb_R, 0.88, 7000
  outs     a_L * 0.6, a_R * 0.6
  ga_rvb_L = 0
  ga_rvb_R = 0
endin

</CsInstruments>
<CsScore>
i101 0 99999       ; pluck sequence conductor
i97  0 99999       ; channel writer
i98  0 99999       ; delay
i99  0 99999       ; reverb
</CsScore>
</CsoundSynthesizer>
