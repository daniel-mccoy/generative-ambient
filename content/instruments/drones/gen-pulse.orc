;------------------------------------------------------
; GEN-PULSE — Generative Pulse Drone
;
; Core technique: Looping AD envelope with S&H-randomized
; decay rate. Dual sawtooth oscillators — root pitch plus
; a second voice that wanders through scale degrees.
; LFO-modulated Moog-style low-pass filter.
;
; Requires:
;   gi_scale — ftable of scale intervals in semitones
;              (e.g. 0, 2, 3, 5, 7, 8, 10, 12 for natural minor)
;   ga_rvb_L, ga_rvb_R — reverb send bus (init 0)
;
; p4 = base frequency (Hz)
; p5 = peak amplitude (0–1)
;------------------------------------------------------

instr gen_pulse

  i_base = p4
  i_amp  = p5
  i_att  = 0.04                        ; attack time (s)

  ; --- Random S&H modulates decay time ---
  ; New random value ~every 2s, maps to 0.4–3.0s decay
  k_rnd  randh  1, 0.5
  k_dec  = 0.4 + (k_rnd + 1) * 0.5 * 2.6

  ; --- Looping AD envelope ---
  k_rate = 1 / (i_att + k_dec)
  k_env  loopseg k_rate, 0, 0,  0, i_att, 1, k_dec, 0
  k_env  port   k_env, 0.008          ; smooth to avoid clicks

  ; --- Oscillator A: sawtooth at root ---
  a_osc1 vco2   1, i_base, 0

  ; --- Oscillator B: scale-detuned sawtooth ---
  ; Slow triangle LFO selects scale degree (0–7)
  k_wand lfo    3.5, 0.07, 1          ; ~14s period
  k_raw  = k_wand + 3.5
  k_idx  = int(k_raw)
  k_idx  limit  k_idx, 0, 7
  k_semi table  k_idx, gi_scale
  k_freq2 = i_base * semitone(k_semi)
  a_osc2 vco2   1, k_freq2, 0

  ; --- Mix + Moog-style low-pass filter ---
  a_mix  = a_osc1 * 0.55 + a_osc2 * 0.45
  k_flfo lfo    1, 0.11, 0            ; sine ~9s period
  k_cut  = 1400 + k_flfo * 1100       ; 300–2500 Hz
  a_filt moogladder a_mix, k_cut, 0.35

  ; --- Gentle fade-in (3s) ---
  k_fade linseg 0, 3, 1, p3 - 3, 1

  ; --- Output ---
  a_out  = a_filt * k_env * i_amp * k_fade
  outs   a_out * 0.6, a_out * 0.4     ; slight stereo spread

  ; --- Reverb send ---
  ga_rvb_L = ga_rvb_L + a_out * 0.45
  ga_rvb_R = ga_rvb_R + a_out * 0.45

endin
