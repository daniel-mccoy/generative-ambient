;------------------------------------------------------
; PLUCK-MELD — Meld Basic Shapes Pluck Synth
;
; Single-shot pluck with saw/square blend oscillator,
; dual envelopes (amp + filter mod), and 24dB/oct LP
; filter driven by velocity. Darker notes are quieter,
; brighter notes are louder (natural pluck behavior).
;
; Based on Meld preset: Basic Shapes, Shape 42.9%,
; SVF 24dB @ 313 Hz base, zero sustain.
;
; Mod matrix:
;   A Env  → Filter Freq (38%)
;   M Env  → Filter Freq (53%)
;   Vel    → Filter Freq (36%), Volume (50%)
;   Spread → Detune (50%), Pan (50%)
;
; Requires:
;   ga_rvb_L/R — reverb send bus (init 0)
;   ga_dly_L/R — delay send bus (init 0)
;
; p4 = frequency (Hz)
; p5 = velocity (0–1)
; p6 = pan position (0=left, 1=right)
;------------------------------------------------------

instr pluck_meld

  i_freq = p4
  i_vel  = p5
  i_pan  = p6

  ; ===== AMP ENVELOPE: 5ms attack, 2.67s decay, zero sustain =====
  ; Squared for exponential decay slope (50% D Slope in Meld)
  ; 5ms avoids click (1ms is <2 k-periods at ksmps=32)
  k_aenv   linseg 0, 0.005, 1, 2.67, 0
  k_aenv   = k_aenv * k_aenv

  ; ===== MOD ENVELOPE: 5ms attack, 1.69s decay (faster than amp) =====
  ; Drives filter — closes before volume fades out
  k_menv   linseg 0, 0.005, 1, 1.69, 0
  k_menv   = k_menv * k_menv

  ; ===== OSCILLATOR: Saw + Square blend at 42.9% =====
  a_saw    vco2   1, i_freq, 0               ; sawtooth
  a_sqr    vco2   1, i_freq, 10, 0.5         ; square (50% duty)
  a_osc    = a_saw * 0.571 + a_sqr * 0.429   ; 42.9% shape blend

  ; ===== FILTER: 24dB/oct LP (cascaded butterlp) =====
  ; Base 313 Hz, modulated by A Env (38%), M Env (53%), Velocity (36%)
  ; Depth scaled so peak with max velocity reaches ~2000–2500 Hz
  i_base_cut = 313
  i_depth    = 4000                           ; modulation depth in Hz
  k_fmod   = k_aenv * 0.38 + k_menv * 0.53 + i_vel * 0.36
  k_cutoff = i_base_cut + k_fmod * i_depth
  k_cutoff limit k_cutoff, 200, 12000

  ; Two cascaded 12dB butterlp = 24dB/oct
  a_filt   butterlp a_osc, k_cutoff
  a_filt   butterlp a_filt, k_cutoff

  ; ===== OUTPUT =====
  ; Volume: velocity × 50% (Vel→Volume) × master scaling
  i_vol    = i_vel * 0.5

  ; Stereo pan using sqrt pan law
  i_panL   = sqrt(1 - i_pan)
  i_panR   = sqrt(i_pan)

  a_out    = a_filt * k_aenv * i_vol
  a_outL   = a_out * i_panL
  a_outR   = a_out * i_panR

  outs     a_outL, a_outR

  ; Send to shared effects (slightly less than drone)
  ga_dly_L = ga_dly_L + a_outL * 0.25
  ga_dly_R = ga_dly_R + a_outR * 0.25
  ga_rvb_L = ga_rvb_L + a_outL * 0.35
  ga_rvb_R = ga_rvb_R + a_outR * 0.35

endin
