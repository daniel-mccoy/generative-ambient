<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

;======================================================
; AURORA OCEAN — Ocean Waves + PadSynth + Pluck Sequencer
;
; Three layers over ocean field recording:
;
; Layer 1 (Ocean): Crossfade-looped ocean field recording
;   via flooper2 palindrome. LP 5500 Hz, warmth saturation.
;   Slow steady bed that drives bass_rms for shader.
;
; Layer 2 (Pad): PadSynth A/B morph drone at C4.
;   Pre-rendered 262144-sample padsynth wavetables loaded
;   as WAV, crossfaded via wander LFO. Sub + noise layers.
;   Drives pad_rms and pad_pulse (morph position).
;
; Layer 3 (Pluck): Probabilistic eighth-note sequencer
;   at 63 BPM across C Major Pentatonic. Saw+square
;   blend through resonant moogladder. 4 LFOs modulate
;   cutoff, reso, density, and range.
;   Drives pluck_rms for shader transients.
;
; Signal chain:
;   conductors (100,101) -> voices (1,2,3) ->
;   analysis (97) -> delay (98) -> reverb (99)
;
; Preset values from saved rig presets.
; Sample loaded into virtual FS by JS before compilation.
;======================================================

sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

seed 0

;------------------------------------------------------
; TABLES
;------------------------------------------------------

; Major pentatonic scale
gi_scale ftgen 10, 0, -5, -2, 0, 2, 4, 7, 9
gi_scale_len = 5

; PadSynth tables (pre-rendered via desktop Csound, loaded as WAV)
; 262144 samples each at 44100 Hz, fund = 261.63 Hz, bw = 25 cents
gi_pad_A ftgen 1, 0, 0, 1, "padsynth-a.wav", 0, 0, 0
gi_pad_B ftgen 2, 0, 0, 1, "padsynth-b.wav", 0, 0, 0
gi_pad_fund = 261.63
gi_sr_over_padsize_A = sr / ftlen(gi_pad_A)
gi_sr_over_padsize_B = sr / ftlen(gi_pad_B)

; Ocean sample (written to virtual FS by JS before compile)
gi_ocean_L ftgen 3, 0, 0, 1, "ocean-roar.wav", 0, 0, 1
gi_ocean_R ftgen 4, 0, 0, 1, "ocean-roar.wav", 0, 0, 2
gi_ocean_dur = ftlen(gi_ocean_L) / sr

; Sine for oscili
gi_sine ftgen 0, 0, 8192, 10, 1

;------------------------------------------------------
; SEND BUSES
;------------------------------------------------------
ga_rvb_L init 0
ga_rvb_R init 0
ga_dly_L init 0
ga_dly_R init 0

;------------------------------------------------------
; ANALYSIS ACCUMULATORS
;------------------------------------------------------
gk_pad_rms   init 0
gk_pad_morph init 0
gk_pluck_rms init 0

;------------------------------------------------------
; PAD MODULATION GLOBALS (written by conductor 101)
;------------------------------------------------------
gk_pad_mod_morph  init 0
gk_pad_mod_sub    init 0
gk_pad_mod_noise  init 0
gk_pad_mod_envamt init 0

;------------------------------------------------------
; PLUCK MODULATION GLOBALS (written by conductor 100)
;------------------------------------------------------
gk_pluck_mod_cutoff  init 0
gk_pluck_mod_reso    init 0
gk_pluck_mod_density init 0
gk_pluck_mod_range   init 0


;------------------------------------------------------
; OCEAN LOOPER — instr 3
;
; Crossfade-looped ocean field recording (palindrome).
; From sample-looper-rig preset:
;   speed 0.6, xfade 0.5s, LP 5500 Hz reso 0.07,
;   HP 23 Hz, warmth 0.3, vol 0.7, reverb send 0.45
;------------------------------------------------------
instr 3

  k_speed = 0.6
  k_xfade = 0.5

  aL flooper2 1, k_speed, 0, gi_ocean_dur, k_xfade, gi_ocean_L, 0, 2
  aR flooper2 1, k_speed, 0, gi_ocean_dur, k_xfade, gi_ocean_R, 0, 2

  ; LP filter
  aL moogladder aL, 5500, 0.07
  aR moogladder aR, 5500, 0.07

  ; HP — remove sub-rumble
  aL butterhp aL, 23
  aR butterhp aR, 23

  ; Warmth: saturation + low shelf
  aL = tanh(aL * 1.6)
  aR = tanh(aR * 1.6)
  aL_low butterlp aL, 200
  aR_low butterlp aR, 200
  aL = aL + aL_low * 0.12
  aR = aR + aR_low * 0.12

  ; Master volume
  aL = aL * 0.7
  aR = aR * 0.7

  outs aL, aR

  ; Reverb send
  ga_rvb_L = ga_rvb_L + aL * 0.45
  ga_rvb_R = ga_rvb_R + aR * 0.45

  ; Analysis — ocean drives bass_rms for aurora intensity
  a_mono = (aL + aR) * 0.5
  k_rms  rms a_mono
  k_rms  port k_rms, 0.05
  chnset k_rms, "bass_rms"

  ; Slow filter wander for aurora color shifting
  k_warmth_lfo randi 0.3, 0.02
  k_warmth_n = 0.4 + k_warmth_lfo
  k_warmth_n limit k_warmth_n, 0, 1
  k_warmth_n port k_warmth_n, 0.1
  chnset k_warmth_n, "bass_cutoff"

endin


;------------------------------------------------------
; PAD VOICE — instr 2 (always-on drone)
;
; PadSynth A/B morph at C4 with sub + noise.
; Pre-rendered padsynth wavetables loaded via GEN01.
; From padsynth-rig preset:
;   morph 0.48, cutoff 8000, reso 0.1, envamt 0.3,
;   f.decay 4s, sub 0.25, noise 0.09, padlvl 1.0,
;   amp A=0.8 D=1.5 S=0.7, vol 0.89, warmth 0.49,
;   dly send 0.25, rvb send 1.0
;------------------------------------------------------
instr 2

  i_freq = 261.63    ; C4

  ; === Modulated parameters ===
  k_morph  = 0.48 + gk_pad_mod_morph
  k_sub    = 0.25 + gk_pad_mod_sub
  k_noise  = 0.09 + gk_pad_mod_noise
  k_envamt = 0.3 + gk_pad_mod_envamt

  k_morph  limit k_morph, 0, 1
  k_sub    limit k_sub, 0, 1
  k_noise  limit k_noise, 0, 1
  k_envamt limit k_envamt, 0, 1

  ; === Amp envelope: A=0.8s, D=1.5s, S=0.7, hold ===
  k_env linseg 0, 0.8, 1, 1.5, 0.7, p3 - 2.3, 0.7

  ; === Filter mod envelope: 5ms attack, 4s decay ===
  k_menv linseg 0, 0.005, 1, 4.0, 0, p3 - 4.005, 0
  k_menv = k_menv * k_menv

  ; === PadSynth oscillators (pre-rendered wavetables) ===
  ; poscil reads through the large table; playback rate = freq / fund * (sr / tablesize)
  k_rate_a = i_freq / gi_pad_fund * gi_sr_over_padsize_A
  k_rate_b = i_freq / gi_pad_fund * gi_sr_over_padsize_B
  a_pad_a poscil 1, k_rate_a, gi_pad_A
  a_pad_b poscil 1, k_rate_b, gi_pad_B

  ; Morph crossfade
  a_pad = a_pad_a * (1 - k_morph) + a_pad_b * k_morph

  ; Sub oscillator (-1 octave)
  a_sub oscili k_sub, i_freq * 0.5, gi_sine

  ; Noise layer
  a_noise noise k_noise * 0.2, 0

  ; Mix
  a_osc = a_pad + a_sub + a_noise

  ; === Filter ===
  k_filt_cut = 8000 + k_menv * k_envamt * 8000
  k_filt_cut limit k_filt_cut, 60, 18000
  a_filt moogladder a_osc, k_filt_cut, 0.1

  ; Apply envelope
  a_out = a_filt * k_env

  ; Warmth (0.49)
  a_out = tanh(a_out * (1 + 0.49 * 2))
  a_low butterlp a_out, 200
  a_out = a_out + a_low * 0.196

  ; Master LPF
  a_out butterlp a_out, 12000

  ; Stereo (center)
  aL = a_out * 0.5
  aR = a_out * 0.5

  ; Volume
  aL = tanh(aL * 0.6)
  aR = tanh(aR * 0.6)

  aL dcblock aL
  aR dcblock aR

  outs aL, aR

  ; Analysis
  k_rms rms a_out
  gk_pad_rms max gk_pad_rms, k_rms
  gk_pad_morph = k_morph

  ; Effect sends
  ga_dly_L = ga_dly_L + aL * 0.25
  ga_dly_R = ga_dly_R + aR * 0.25
  ga_rvb_L = ga_rvb_L + aL * 0.7
  ga_rvb_R = ga_rvb_R + aR * 0.7

endin


;------------------------------------------------------
; PLUCK SEQUENCER CONDUCTOR — instr 100
;
; 63 BPM eighth-note probabilistic sequencer.
; C Major Pentatonic, density 0.5, range 1.5 oct.
;
; LFOs (from sequencer-rig preset):
;   1: Sine  0.1Hz  amp 0.55 → Reso  (±0.165)
;   2: Tri   0.07Hz amp 0.48 → Cutoff (±1920 Hz)
;   3: Sine  0.05Hz amp 0.51 → Density (±0.153)
;   4: S&H   0.15Hz amp 0.26 → Range  (±0.26 oct)
;------------------------------------------------------
instr 100

  ; === MODULATION LFOs ===

  ; LFO 1: Sine → Reso
  k_lfo1 lfo 1, 0.1, 0
  gk_pluck_mod_reso = k_lfo1 * 0.55 * 0.3

  ; LFO 2: Triangle → Cutoff
  k_phs2 phasor 0.07
  k_lfo2 = 1 - 4 * abs(k_phs2 - 0.5)
  gk_pluck_mod_cutoff = k_lfo2 * 0.48 * 4000

  ; LFO 3: Sine → Density
  k_lfo3 lfo 1, 0.05, 0
  gk_pluck_mod_density = k_lfo3 * 0.51 * 0.3

  ; LFO 4: S&H → Range
  k_sh4   init 0
  k_phs4  phasor 0.15
  k_prev4 init 1
  if k_phs4 < k_prev4 then
    k_sh4 random -1, 1
  endif
  k_prev4 = k_phs4
  gk_pluck_mod_range = k_sh4 * 0.26 * 1

  ; === COMPUTED PARAMETERS ===

  k_density = 0.5 + gk_pluck_mod_density
  k_density limit k_density, 0.1, 0.9

  k_range = 1.5 + gk_pluck_mod_range
  k_range limit k_range, 0.5, 3
  k_range_semi = k_range * 12

  ; === EIGHTH-NOTE CLOCK AT 63 BPM ===

  k_eighth = 60 / 63 / 2
  k_tick   metro (1 / k_eighth)

  if k_tick == 1 then

    k_roll random 0, 1
    if k_roll < k_density then

      k_active active 1
      if k_active < 8 then

        ; --- Pitch from scale ---
        k_max_deg = k_range_semi / 12 * gi_scale_len
        k_max_deg limit k_max_deg, 1, 60
        k_deg random 0, k_max_deg
        k_deg = int(k_deg)

        k_octave = int(k_deg / gi_scale_len)
        k_deg_sc = k_deg - k_octave * gi_scale_len
        k_deg_sc limit k_deg_sc, 0, gi_scale_len - 1

        k_semi tablekt k_deg_sc, gi_scale
        k_midi = 48 + k_octave * 12 + k_semi    ; Root C3

        ; Oct jump (20%)
        k_oj random 0, 1
        if k_oj < 0.2 then
          k_midi = k_midi + 12
        endif

        k_midi limit k_midi, 24, 108
        k_freq = cpsmidinn(k_midi)

        ; --- Velocity ---
        k_acc random 0, 1
        if k_acc < 0.3 then
          k_vel = 0.8
        else
          k_vel random 0.3, 0.8
        endif

        k_pan random 0.2, 0.8

        event "i", 1, 0, 3.0, k_freq, k_vel, k_pan

        ; Double trigger (15% syncopation)
        k_dbl random 0, 1
        if k_dbl < 0.15 && k_active < 7 then
          k_deg2 random 0, k_max_deg
          k_deg2 = int(k_deg2)
          k_oct2 = int(k_deg2 / gi_scale_len)
          k_deg2_sc = k_deg2 - k_oct2 * gi_scale_len
          k_deg2_sc limit k_deg2_sc, 0, gi_scale_len - 1
          k_semi2 tablekt k_deg2_sc, gi_scale
          k_midi2 = 48 + k_oct2 * 12 + k_semi2
          k_midi2 limit k_midi2, 24, 108
          k_freq2 = cpsmidinn(k_midi2)
          k_vel2 random 0.3, 0.8
          k_pan2 random 0.2, 0.8
          event "i", 1, k_eighth * 0.5, 3.0, k_freq2, k_vel2, k_pan2
        endif

      endif
    endif
  endif

endin


;------------------------------------------------------
; PLUCK VOICE — instr 1 (event-triggered, polyphonic)
;
; Saw+Square blend through moogladder.
; From sequencer-rig preset:
;   shape 0.73, detune 1.7 cents, sub 0.47,
;   cutoff 313, reso 0.25, envamt 0.5, f.decay 1.69,
;   amp A=0.005 D=2.67 S=0.25, warmth 0.3
;
; p4=freq, p5=velocity, p6=pan
;------------------------------------------------------
instr 1

  ifreq = p4
  ivel  = p5
  ipan  = p6

  ; === Modulated parameters ===
  k_cut  = 313 + gk_pluck_mod_cutoff
  k_reso = 0.25 + gk_pluck_mod_reso
  k_cut  limit k_cut, 200, 12000
  k_reso limit k_reso, 0, 0.9

  ; === Amp envelope (squared for exponential shape) ===
  i_hold = p3 - 0.005 - 2.67
  i_hold = (i_hold < 0.01) ? 0.01 : i_hold
  k_aenv linseg 0, 0.005, 1, 2.67, 0.25, i_hold, 0.25
  k_aenv = k_aenv * k_aenv

  ; === Mod envelope (filter) ===
  i_mod_hold = p3 - 0.005 - 1.69
  i_mod_hold = (i_mod_hold < 0.001) ? 0.001 : i_mod_hold
  k_menv linseg 0, 0.005, 1, 1.69, 0, i_mod_hold, 0
  k_menv = k_menv * k_menv

  ; === Oscillators ===
  ; Saw + Square blend at 73%
  a_saw vco2 1, ifreq, 0
  a_sqr vco2 1, ifreq, 10, 0.5
  a_osc = a_saw * 0.27 + a_sqr * 0.73

  ; Detuned second saw (1.7 cents)
  k_det_hz = ifreq * (1.7 * 0.01 / 12)
  a_saw2 vco2 0.5, ifreq + k_det_hz, 0
  a_osc = a_osc + a_saw2

  ; Sub oscillator (-1 octave, level 0.47)
  a_sub oscili 0.47, ifreq * 0.5, gi_sine
  a_osc = a_osc + a_sub

  ; === Filter ===
  k_vel_bright = ivel * 2000
  k_filt_cut = k_cut + k_menv * 0.5 * 8000 + k_vel_bright
  k_filt_cut limit k_filt_cut, 60, 18000
  a_filt moogladder a_osc, k_filt_cut, k_reso

  ; === Output ===
  a_out = a_filt * k_aenv * ivel * 0.18

  ; Warmth (0.3)
  a_out = tanh(a_out * 1.6)
  a_low butterlp a_out, 200
  a_out = a_out + a_low * 0.12

  ; Master LPF
  a_out butterlp a_out, 12000

  ; Stereo pan (sqrt law)
  ipanL = sqrt(1 - ipan)
  ipanR = sqrt(ipan)
  aL = a_out * ipanL
  aR = a_out * ipanR

  outs aL, aR

  ; Analysis (short integration for transient tracking)
  k_rms rms a_out, 20
  gk_pluck_rms max gk_pluck_rms, k_rms

  ; Heavy delay send (echoes are core character)
  ga_dly_L = ga_dly_L + aL * 0.9
  ga_dly_R = ga_dly_R + aR * 0.9
  ga_rvb_L = ga_rvb_L + aL * 0.35
  ga_rvb_R = ga_rvb_R + aR * 0.35

endin


;------------------------------------------------------
; PAD MODULATION CONDUCTOR — instr 101
;
; 4 LFOs for pad voice modulation (from preset):
;   1: Wander 0.1Hz  amp 1.0  → Morph
;   2: Wander 0.07Hz amp 0.5  → Sub
;   3: Tri    0.05Hz amp 0.46 → Noise
;   4: S&H    0.15Hz amp 1.0  → EnvAmt
;------------------------------------------------------
instr 101

  ; LFO 1: Wander → Morph (±0.5)
  k_w1a randi 1, 0.1
  k_w1b randi 0.5, 0.04286
  k_lfo1 = (k_w1a + k_w1b) / 1.5
  gk_pad_mod_morph = k_lfo1 * 0.5

  ; LFO 2: Wander → Sub (±0.15)
  k_w2a randi 1, 0.07
  k_w2b randi 0.5, 0.03
  k_lfo2 = (k_w2a + k_w2b) / 1.5 * 0.5
  gk_pad_mod_sub = k_lfo2 * 0.3

  ; LFO 3: Triangle → Noise (±0.138)
  k_phs3  phasor 0.05
  k_lfo3 = (1 - 4 * abs(k_phs3 - 0.5)) * 0.46
  gk_pad_mod_noise = k_lfo3 * 0.3

  ; LFO 4: S&H → EnvAmt (±0.5)
  k_sh4   init 0
  k_phs4  phasor 0.15
  k_prev4 init 1
  if k_phs4 < k_prev4 then
    k_sh4 random -1, 1
  endif
  k_prev4 = k_phs4
  gk_pad_mod_envamt = k_sh4 * 0.5

endin


;------------------------------------------------------
; CHANNEL WRITER — instr 97
;
; Smooths polyphonic accumulators and writes named
; channels for JS polling → shader uniforms.
;------------------------------------------------------
instr 97

  ; Smooth accumulated values
  k_pr   port gk_pad_rms, 0.05
  k_pm   port gk_pad_morph, 0.05
  k_plr  port gk_pluck_rms, 0.02

  ; Write to named channels
  chnset k_pr,  "pad_rms"
  chnset k_pm,  "pad_pulse"

  ; Use pad modulation outputs for swarm channels
  ; (swarm_rms ← pad noise mod, swarm_lfo ← pad morph mod)
  k_snr port gk_pad_mod_noise, 0.05
  k_snr = abs(k_snr) * 2
  chnset k_snr, "swarm_rms"

  k_slfo port gk_pad_mod_morph, 0.05
  k_slfo = k_slfo * 0.5 + 0.5
  chnset k_slfo, "swarm_lfo"

  chnset k_plr, "pluck_rms"

  ; Reset accumulators
  gk_pad_rms   = 0
  gk_pad_morph = 0
  gk_pluck_rms = 0

endin


;------------------------------------------------------
; PING-PONG DELAY — dotted eighths at 63 BPM
;
; From sequencer-rig preset:
;   div=dotted 1/8 (714ms), FB 0.55, mod 0.005
;------------------------------------------------------
instr 98

  i_bpm    = 63
  i_eighth = 60 / i_bpm / 2
  i_dotted = i_eighth * 1.5              ; ~714ms
  i_maxdel = 2.0

  k_fb  = 0.55
  k_wet = 0.85

  k_mod lfo 0.005, 0.23, 0

  a_tap_L init 0
  a_tap_R init 0

  a_buf_L delayr i_maxdel
  a_tap_L deltap3 i_dotted + k_mod
          delayw ga_dly_L + a_tap_R * k_fb

  a_buf_R delayr i_maxdel
  a_tap_R deltap3 i_dotted - k_mod
          delayw ga_dly_R + a_tap_L * k_fb

  outs a_tap_L * k_wet, a_tap_R * k_wet

  ; Delay → reverb
  ga_rvb_L = ga_rvb_L + a_tap_L * 0.2
  ga_rvb_R = ga_rvb_R + a_tap_R * 0.2

  ga_dly_L = 0
  ga_dly_R = 0

endin


;------------------------------------------------------
; REVERB — lush hall
;
; Blend of pad (0.92, 9443) and pluck (0.88, 7000)
;------------------------------------------------------
instr 99

  a_L, a_R reverbsc ga_rvb_L, ga_rvb_R, 0.91, 8500
  outs a_L * 0.55, a_R * 0.55

  ga_rvb_L = 0
  ga_rvb_R = 0

endin

</CsInstruments>
<CsScore>
; Run indefinitely
i3   0 99999       ; ocean looper
i2   0 99999       ; pad drone
i100 0 99999       ; pluck sequencer conductor
i101 0 99999       ; pad modulation conductor
i97  0 99999       ; channel writer
i98  0 99999       ; ping-pong delay
i99  0 99999       ; reverb
</CsScore>
</CsoundSynthesizer>
