<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

;======================================================
; STELLAR DRIFT — Deep Space Generative Ambient
;
; Three layers: pluck sequencer + FM bass drone + pad chords
; All responding to circle-of-fifths harmonic modulation.
;
; Derived from composition-rig.csd (Cabbage prototype).
; Adapted for browser playback via Csound WASM.
;======================================================

sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1

seed 0

; Sine table for oscili
gi_sine ftgen 1, 0, 8192, 10, 1

;=====================================================================
; CIRCLE-OF-FIFTHS DATA TABLES
;=====================================================================
gi_weights ftgen 100, 0, -12, -2, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0
gi_cof_pc  ftgen 102, 0, -12, -2, 0, 7, 2, 9, 4, 11, 6, 1, 8, 3, 10, 5

;=====================================================================
; PATTERN TABLES
;=====================================================================
gi_pat_note ftgen 103, 0, -32, -2, 0
gi_pat_vel  ftgen 104, 0, -32, -2, 0
gi_pat_dbl  ftgen 105, 0, -32, -2, 0

;=====================================================================
; SCALE TABLES
;=====================================================================
gi_sc_minpent ftgen 110, 0, -5,  -2, 0, 3, 5, 7, 10
gi_sc_majpent ftgen 111, 0, -5,  -2, 0, 2, 4, 7, 9
gi_sc_minor   ftgen 112, 0, -7,  -2, 0, 2, 3, 5, 7, 8, 10
gi_sc_major   ftgen 113, 0, -7,  -2, 0, 2, 4, 5, 7, 9, 11
gi_sc_dorian  ftgen 114, 0, -7,  -2, 0, 2, 3, 5, 7, 9, 10
gi_sc_chrom   ftgen 115, 0, -12, -2, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11

gi_sc_len_minpent = 5
gi_sc_len_majpent = 5
gi_sc_len_minor   = 7
gi_sc_len_major   = 7
gi_sc_len_dorian  = 7
gi_sc_len_chrom   = 12

;=====================================================================
; PAD WAVETABLES — GEN10 fallback (GENpadsynth unavailable in WASM)
; Overwritten by WAV loader (instr 78) if samples are present.
;=====================================================================
#define PAD_SIZE #262144#
gi_pad_A ftgen 200, 0, $PAD_SIZE, 10, 1, 0.5, 0.333, 0.25, 0.2, 0.167, 0.143, 0.125
gi_pad_B ftgen 201, 0, $PAD_SIZE, 10, 1, 0, 0.5, 0, 0.333, 0, 0.143, 0
gi_pad_size_A init $PAD_SIZE
gi_pad_size_B init $PAD_SIZE
gi_pad_fund   init 261.63

;=====================================================================
; GLOBAL SEND BUSES
;=====================================================================
ga_rvb_L init 0
ga_rvb_R init 0
ga_dly_L init 0
ga_dly_R init 0

;=====================================================================
; CONDUCTOR STATE
;=====================================================================
gk_cof_pos init 0

;=====================================================================
; PER-INSTRUMENT ANALYSIS ACCUMULATORS
;=====================================================================
gk_pluck_rms init 0
gk_pad_rms   init 0
gk_pad_pulse init 0

;=====================================================================
; PER-INSTRUMENT MODULATION ACCUMULATORS
;=====================================================================
gk_plk_mod_cutoff  init 0
gk_plk_mod_reso    init 0
gk_plk_mod_shape   init 0
gk_plk_mod_density init 0

gk_fm_mod_cutoff   init 0
gk_fm_mod_reso     init 0

gk_pad_mod_morph   init 0
gk_pad_mod_cutoff  init 0
gk_pad_mod_reso    init 0


;==============================================================
; UDO: WeightedPC — Pick weighted random pitch class
;==============================================================
opcode WeightedPC, k, 0

  k_wt = gi_weights
  k_w0  tablekt 0, k_wt
  k_w1  tablekt 1, k_wt
  k_w2  tablekt 2, k_wt
  k_w3  tablekt 3, k_wt
  k_w4  tablekt 4, k_wt
  k_w5  tablekt 5, k_wt
  k_w6  tablekt 6, k_wt
  k_w7  tablekt 7, k_wt
  k_w8  tablekt 8, k_wt
  k_w9  tablekt 9, k_wt
  k_w10 tablekt 10, k_wt
  k_w11 tablekt 11, k_wt

  k_tw = k_w0+k_w1+k_w2+k_w3+k_w4+k_w5+k_w6+k_w7+k_w8+k_w9+k_w10+k_w11

  k_pc = -1

  if k_tw > 0.001 then
    k_wroll random 0, k_tw

    k_c0  = k_w0
    k_c1  = k_c0 + k_w1
    k_c2  = k_c1 + k_w2
    k_c3  = k_c2 + k_w3
    k_c4  = k_c3 + k_w4
    k_c5  = k_c4 + k_w5
    k_c6  = k_c5 + k_w6
    k_c7  = k_c6 + k_w7
    k_c8  = k_c7 + k_w8
    k_c9  = k_c8 + k_w9
    k_c10 = k_c9 + k_w10

    k_pc = 11
    if k_wroll < k_c10 then
      k_pc = 10
    endif
    if k_wroll < k_c9 then
      k_pc = 9
    endif
    if k_wroll < k_c8 then
      k_pc = 8
    endif
    if k_wroll < k_c7 then
      k_pc = 7
    endif
    if k_wroll < k_c6 then
      k_pc = 6
    endif
    if k_wroll < k_c5 then
      k_pc = 5
    endif
    if k_wroll < k_c4 then
      k_pc = 4
    endif
    if k_wroll < k_c3 then
      k_pc = 3
    endif
    if k_wroll < k_c2 then
      k_pc = 2
    endif
    if k_wroll < k_c1 then
      k_pc = 1
    endif
    if k_wroll < k_c0 then
      k_pc = 0
    endif
  endif

  xout k_pc
endop


;==============================================================
; UDO: PCtoMIDI — Convert pitch class to MIDI note
;==============================================================
opcode PCtoMIDI, k, kkkk
  kpc, kroot, krange, koctjump xin

  k_root_oct = int(kroot / 12)
  k_root_pc  = kroot % 12

  k_midi = k_root_oct * 12 + kpc
  if kpc < k_root_pc then
    k_midi = k_midi + 12
  endif

  k_range_oct = int(krange)
  if k_range_oct > 0 then
    k_oct_rnd random 0, k_range_oct + 0.999
    k_midi = k_midi + int(k_oct_rnd) * 12
  endif

  k_oct_roll random 0, 1
  if k_oct_roll < koctjump then
    k_midi = k_midi + 12
  endif

  k_midi limit k_midi, 24, 108

  xout k_midi
endop


;==============================================================
; CHANNEL INIT — instr 10
; Sets all channel defaults from composition-rig preset.
;==============================================================
instr 10

  ; Sequencer
  chnset 80, "seq_bpm"
  chnset 1, "seq_play"
  chnset 1, "seq_scale"
  chnset 4, "seq_root"
  chnset 3, "seq_patmode"
  chnset 8, "seq_patrep"

  ; Pluck
  chnset 1, "plk_play"
  chnset 0.59, "plk_vol"
  chnset 0.82, "plk_dly_send"
  chnset 0.35, "plk_rvb_send"

  ; FM Drone
  chnset 1, "fm_play"
  chnset 0.18, "fm_vol"
  chnset 0.25, "fm_dly_send"
  chnset 0.74, "fm_rvb_send"

  ; Pad Chords
  chnset 1, "pad_play"
  chnset 0.32, "pad_vol"
  chnset 0.25, "pad_dly_send"
  chnset 0.79, "pad_rvb_send"

  ; Conductor
  chnset 1, "cond_start_key"
  chnset 3, "cond_speed"
  chnset 1, "cond_dir"
  chnset 1, "cond_enabled"

  ; Master
  chnset 0.7, "master_vol"
  chnset 12000, "master_lpf"
  chnset 0.3, "warmth"

  ; Delay
  chnset 3, "dly_div"
  chnset 0.55, "dly_fb"
  chnset 0.52, "dly_mix"
  chnset 0.003, "dly_mod"
  chnset 0.2, "dly_rvb_send"

  ; Reverb
  chnset 0.94, "rvb_fb"
  chnset 1835, "rvb_cut"
  chnset 1.0, "rvb_wet"

  turnoff

endin


;==============================================================
; WAV LOADER — instr 78
; Files pre-loaded into WASM filesystem by JavaScript.
;==============================================================
instr 78

  S_path_a = "padsynth-export-a.wav"
  S_path_b = "padsynth-export-b.wav"

  i_va filevalid S_path_a
  if i_va == 1 then
    gi_pad_A ftgen 200, 0, 0, -1, S_path_a, 0, 0, 0
    gi_pad_size_A = ftlen(gi_pad_A)
    prints "Loaded pad table A: %d samples\n", gi_pad_size_A
  else
    prints "WAV not found: %s — using GEN10 fallback\n", S_path_a
  endif

  i_vb filevalid S_path_b
  if i_vb == 1 then
    gi_pad_B ftgen 201, 0, 0, -1, S_path_b, 0, 0, 0
    gi_pad_size_B = ftlen(gi_pad_B)
    prints "Loaded pad table B: %d samples\n", gi_pad_size_B
  else
    prints "WAV not found: %s — using GEN10 fallback\n", S_path_b
  endif

  gi_pad_fund = 261.63

  turnoff

endin


;==============================================================
; LFO MODULATOR — instr 90
; Inlined LFOs (no UDO calls) to avoid Csound 6 state-sharing.
;==============================================================
instr 90

  ; === PLUCK LFOs ===
  k_pw1a randi 1, 0.03
  k_pw1b randi 0.5, 0.03 * 0.4286
  k_plk_cut = (k_pw1a + k_pw1b) / 1.5

  k_plk_reso_phs phasor 0.02
  k_plk_reso = (1 - 4 * abs(k_plk_reso_phs - 0.5)) * 0.18

  k_plk_shp_phs phasor 0.02
  k_plk_shp_val init 0
  k_plk_shp_prv init 1
  if k_plk_shp_phs < k_plk_shp_prv then
    k_plk_shp_val random -1, 1
  endif
  k_plk_shp_prv = k_plk_shp_phs
  k_plk_shp = k_plk_shp_val * 0.45

  k_plk_den_phs phasor 0.02
  k_plk_den_val init 0
  k_plk_den_prv init 1
  if k_plk_den_phs < k_plk_den_prv then
    k_plk_den_val random -1, 1
  endif
  k_plk_den_prv = k_plk_den_phs
  k_plk_den = k_plk_den_val * 0.26

  gk_plk_mod_cutoff  = k_plk_cut * 4000
  gk_plk_mod_reso    = k_plk_reso * 0.3
  gk_plk_mod_shape   = k_plk_shp * 0.3
  gk_plk_mod_density = k_plk_den * 0.3

  ; === FM DRONE LFOs ===
  k_fm_cut_phs phasor 0.02
  k_fm_cut = sin(k_fm_cut_phs * 6.28318530718)

  k_fm_reso_phs phasor 0.02
  k_fm_reso = (1 - 4 * abs(k_fm_reso_phs - 0.5)) * 0.47

  gk_fm_mod_cutoff = k_fm_cut * 4000
  gk_fm_mod_reso   = k_fm_reso * 0.3

  ; === PAD LFOs ===
  k_pad_mrph_phs phasor 0.02
  k_pad_mrph = sin(k_pad_mrph_phs * 6.28318530718)

  k_pad_w2a randi 1, 0.03
  k_pad_w2b randi 0.5, 0.03 * 0.4286
  k_pad_cut = (k_pad_w2a + k_pad_w2b) / 1.5

  k_pad_reso_phs phasor 0.05
  k_pad_reso = sin(k_pad_reso_phs * 6.28318530718) * 0.15

  gk_pad_mod_morph  = k_pad_mrph * 0.5
  gk_pad_mod_cutoff = k_pad_cut * 4000
  gk_pad_mod_reso   = k_pad_reso * 0.3

endin


;==============================================================
; PLUCK VOICE — instr 1
; p4 = frequency (Hz), p5 = velocity (0-1), p6 = pan (0-1)
;==============================================================
instr 1

  ifreq = p4
  ivel  = p5
  ipan  = p6

  ; Hard-coded sound params + LFO modulation
  k_shape   = 0.52 + gk_plk_mod_shape
  k_detune  = 1.7
  k_sub_lvl = 0.47
  k_cut     = 313  + gk_plk_mod_cutoff
  k_reso    = 0.25 + gk_plk_mod_reso
  k_envamt  = 0.5

  k_shape limit k_shape, 0, 1
  k_cut   limit k_cut, 200, 12000
  k_reso  limit k_reso, 0, 0.9
  i_filt_dec = 1.69
  i_amp_a   = 0.005
  i_amp_d   = 0.15
  i_amp_s   = 0.18

  k_vol      chnget "plk_vol"
  k_dly_send chnget "plk_dly_send"
  k_rvb_send chnget "plk_rvb_send"
  k_master   chnget "master_vol"
  k_warmth_v chnget "warmth"
  k_lpf      chnget "master_lpf"

  ; Amp envelope
  i_hold = p3 - i_amp_a - i_amp_d
  i_hold = (i_hold < 0.01) ? 0.01 : i_hold
  k_aenv linseg 0, i_amp_a, 1, i_amp_d, i_amp_s, i_hold, i_amp_s
  k_aenv = k_aenv * k_aenv

  ; Filter mod envelope
  i_mod_hold = p3 - 0.005 - i_filt_dec
  i_mod_hold = (i_mod_hold < 0.001) ? 0.001 : i_mod_hold
  k_menv linseg 0, 0.005, 1, i_filt_dec, 0, i_mod_hold, 0
  k_menv = k_menv * k_menv

  ; Oscillators
  a_saw vco2 1, ifreq, 0
  a_sqr vco2 1, ifreq, 10, 0.5
  a_osc = a_saw * (1 - k_shape) + a_sqr * k_shape

  k_det_hz = ifreq * (k_detune * 0.01 / 12)
  a_saw2 vco2 0.5, ifreq + k_det_hz, 0
  a_osc = a_osc + a_saw2

  a_sub oscili k_sub_lvl, ifreq * 0.5, gi_sine
  a_osc = a_osc + a_sub

  ; Filter (cutoff-proportional envelope sweep)
  k_filt_cut = k_cut + k_menv * k_envamt * (k_cut * 4) + ivel * 400
  k_filt_cut limit k_filt_cut, 60, 18000

  a_filt moogladder a_osc, k_filt_cut, k_reso

  ; Apply envelope + velocity
  a_out = a_filt * k_aenv * ivel * 0.18

  ; Warmth
  if k_warmth_v > 0.01 then
    a_out = tanh(a_out * (1 + k_warmth_v * 2))
    a_low butterlp a_out, 200
    a_out = a_out + a_low * k_warmth_v * 0.4
  endif

  ; Master LPF
  a_out butterlp a_out, k_lpf

  ; Per-instrument analysis
  k_rms rms a_out, 20
  gk_pluck_rms max gk_pluck_rms, k_rms

  ; Stereo
  aL = a_out * (1 - ipan)
  aR = a_out * ipan

  ; Volume + soft clip
  aL = tanh(aL * k_vol * k_master)
  aR = tanh(aR * k_vol * k_master)

  ; DC block
  aL dcblock aL
  aR dcblock aR

  ; Dry output (minus delay wet)
  k_dly_mix chnget "dly_mix"
  outs aL * (1 - k_dly_mix), aR * (1 - k_dly_mix)

  ; Effect sends
  ga_dly_L = ga_dly_L + aL * k_dly_send
  ga_dly_R = ga_dly_R + aR * k_dly_send
  ga_rvb_L = ga_rvb_L + aL * k_rvb_send
  ga_rvb_R = ga_rvb_R + aR * k_rvb_send

endin


;==============================================================
; FM DRONE VOICE — instr 2 (long-lived, channel-driven)
;==============================================================
instr 2

  k_lvl_a    = 0.51
  k_lvl_b    = 0.6
  k_mix      = 0.49
  k_fine     = 7
  k_noise_lvl = 0.17

  k_cut_base = 1285 + gk_fm_mod_cutoff
  k_reso     = 0.55 + gk_fm_mod_reso
  k_env_amt  = 0.5
  k_keytrk   = 0.51

  k_cut_base limit k_cut_base, 200, 16000
  k_reso     limit k_reso, 0, 0.9

  i_amp_a    = 0.8
  i_amp_d    = 1.5
  i_amp_s    = 0.7

  i_flt_a    = 0.01
  i_flt_d    = 2.0
  i_flt_s    = 0.2

  k_vol      chnget "fm_vol"
  k_dly_send chnget "fm_dly_send"
  k_rvb_send chnget "fm_rvb_send"
  k_master   chnget "master_vol"
  k_warmth   chnget "warmth"
  k_lpf      chnget "master_lpf"

  k_drone_midi chnget "drone_midi"
  k_drone_gate chnget "drone_gate"

  k_gate_smooth portk k_drone_gate, 0.5

  if k_gate_smooth < 0.001 && k_drone_gate < 0.5 then
    k_alive timeinsts
    if k_alive > 2 then
      turnoff
    endif
  endif

  k_drone_midi limit k_drone_midi, 12, 36
  k_cps = cpsmidinn(k_drone_midi)

  i_ads_hold = 3600
  k_ads linseg 0, i_amp_a, 1, i_amp_d, i_amp_s, i_ads_hold, i_amp_s

  k_flt_ads linseg 0, i_flt_a, 1, i_flt_d, i_flt_s, i_ads_hold, i_flt_s

  ; Osc A: sine
  a_osc_a oscili 1, k_cps, gi_sine

  ; Osc B: saw (detuned)
  k_semi_total = k_fine * 0.01
  k_cps_b = k_cps * semitone(k_semi_total)
  a_osc_b vco2 1, k_cps_b, 0

  a_osc = a_osc_a * k_lvl_a * (1 - k_mix) + a_osc_b * k_lvl_b * k_mix

  a_noise noise k_noise_lvl * 0.3, 0
  a_osc = a_osc + a_noise

  ; Filter
  k_keytrk_hz = (k_cps - 261.63) * k_keytrk * 8
  k_filt_cut = k_cut_base + k_flt_ads * k_env_amt * 8000 + k_keytrk_hz
  k_filt_cut limit k_filt_cut, 60, 18000

  a_filt moogladder a_osc, k_filt_cut, k_reso

  a_out = a_filt * k_ads * k_gate_smooth

  ; Warmth
  if k_warmth > 0.01 then
    a_out = tanh(a_out * (1 + k_warmth * 2))
    a_low butterlp a_out, 200
    a_out = a_out + a_low * k_warmth * 0.4
  endif

  ; Master LPF
  a_out butterlp a_out, k_lpf

  ; Per-instrument analysis (single instance — write directly)
  k_rms rms a_out
  k_rms port k_rms, 0.05
  chnset k_rms, "bass_rms"
  k_cut_n = (k_filt_cut - 200) / (16000 - 200)
  k_cut_n limit k_cut_n, 0, 1
  k_cut_n port k_cut_n, 0.05
  chnset k_cut_n, "bass_cutoff"

  ; Stereo (center)
  aL = a_out * 0.5
  aR = a_out * 0.5

  aL = tanh(aL * k_vol * k_master)
  aR = tanh(aR * k_vol * k_master)

  aL dcblock aL
  aR dcblock aR

  outs aL, aR

  ga_dly_L = ga_dly_L + aL * k_dly_send
  ga_dly_R = ga_dly_R + aR * k_dly_send
  ga_rvb_L = ga_rvb_L + aL * k_rvb_send
  ga_rvb_R = ga_rvb_R + aR * k_rvb_send

endin


;==============================================================
; PAD VOICE — instr 3 (polyphonic chord tones, hold until released)
; p4 = frequency (Hz), p5 = velocity (0-1), p6 = pan (0-1)
;==============================================================
instr 3

  ifreq = p4
  ivel  = p5
  ipan  = p6

  k_morph    = 0.48 + gk_pad_mod_morph
  k_padlvl   = 0.56
  k_sub_lvl  = 0.18
  k_cut_base = 8000 + gk_pad_mod_cutoff
  k_reso     = 0.1  + gk_pad_mod_reso
  k_envamt   = 0.3

  k_morph  limit k_morph, 0, 1
  k_cut_base limit k_cut_base, 200, 16000
  k_reso   limit k_reso, 0, 0.9
  i_filt_dec = 4.0
  i_amp_a    = 0.8
  i_amp_d    = 1.5
  i_amp_s    = 0.7
  i_amp_r    = 4.0
  k_uni_det_base = 15
  k_uni_spd  = 1.0

  k_vol      chnget "pad_vol"
  k_dly_send chnget "pad_dly_send"
  k_rvb_send chnget "pad_rvb_send"
  k_master   chnget "master_vol"
  k_warmth   chnget "warmth"
  k_lpf      chnget "master_lpf"

  i_fund   = gi_pad_fund
  i_size_a = gi_pad_size_A
  i_size_b = gi_pad_size_B
  i_sros_a = sr / i_size_a
  i_sros_b = sr / i_size_b

  ; HOLD + RELEASE via xtratim + release
  xtratim i_amp_r + 0.1

  k_rel release
  k_releasing init 0

  if k_rel == 1 && k_releasing == 0 then
    k_releasing = 1
    reinit start_pad_release
  endif

  ; Amp ADS envelope
  i_ads_hold = 3600
  k_ads linseg 0, i_amp_a, 1, i_amp_d, i_amp_s, i_ads_hold, i_amp_s

  ; Filter mod envelope
  i_mod_hold = 3600
  k_menv linseg 0, 0.005, 1, i_filt_dec, 0, i_mod_hold, 0
  k_menv = k_menv * k_menv

  ; Release envelope
  k_rel_env init 1
  if k_releasing == 1 then
start_pad_release:
    k_rel_env linseg 1, i_amp_r, 0
    rireturn
  endif

  k_amp_env = k_ads * k_rel_env

  if k_releasing == 1 && k_rel_env <= 0.001 then
    turnoff
  endif

  ; PADSYNTH OSCILLATORS — 4 UNISON VOICES
  k_rate_a = ifreq / i_fund * i_sros_a
  k_rate_b = ifreq / i_fund * i_sros_b

  k_det_ratio = (2 ^ (k_uni_det_base / 1200)) - 1
  k_det_a = k_rate_a * k_det_ratio
  k_det_b = k_rate_b * k_det_ratio

  a_a0 poscil 1, k_rate_a, gi_pad_A
  a_b0 poscil 1, k_rate_b, gi_pad_B
  a_mix0 = a_a0 * (1 - k_morph) + a_b0 * k_morph

  a_a1 poscil 1, k_rate_a + k_det_a, gi_pad_A
  a_b1 poscil 1, k_rate_b + k_det_b, gi_pad_B
  a_mix1 = a_a1 * (1 - k_morph) + a_b1 * k_morph

  a_a2 poscil 1, k_rate_a - k_det_a, gi_pad_A
  a_b2 poscil 1, k_rate_b - k_det_b, gi_pad_B
  a_mix2 = a_a2 * (1 - k_morph) + a_b2 * k_morph

  a_a3 poscil 1, k_rate_a + k_det_a * 1.5, gi_pad_A
  a_b3 poscil 1, k_rate_b + k_det_b * 1.5, gi_pad_B
  a_mix3 = a_a3 * (1 - k_morph) + a_b3 * k_morph

  k_norm = 0.25

  k_sp = k_uni_spd
  a_pad_L = (a_mix0 * 0.5 + a_mix1 * (1 - k_sp * 0.8) + a_mix2 * k_sp * 0.8 + a_mix3 * (0.6 - k_sp * 0.2)) * k_norm * k_padlvl
  a_pad_R = (a_mix0 * 0.5 + a_mix1 * k_sp * 0.8 + a_mix2 * (1 - k_sp * 0.8) + a_mix3 * (0.4 + k_sp * 0.2)) * k_norm * k_padlvl

  a_sub oscili k_sub_lvl, ifreq * 0.5, gi_sine

  a_osc_L = a_pad_L + a_sub * 0.5
  a_osc_R = a_pad_R + a_sub * 0.5

  ; Filter
  k_filt_cut = k_cut_base + k_menv * k_envamt * 8000
  k_filt_cut limit k_filt_cut, 60, 18000
  a_filt_L moogladder a_osc_L, k_filt_cut, k_reso
  a_filt_R moogladder a_osc_R, k_filt_cut, k_reso

  a_out_L = a_filt_L * k_amp_env * ivel
  a_out_R = a_filt_R * k_amp_env * ivel

  ; Warmth
  if k_warmth > 0.01 then
    a_out_L = tanh(a_out_L * (1 + k_warmth * 2))
    a_out_R = tanh(a_out_R * (1 + k_warmth * 2))
    a_low_L butterlp a_out_L, 200
    a_low_R butterlp a_out_R, 200
    a_out_L = a_out_L + a_low_L * k_warmth * 0.4
    a_out_R = a_out_R + a_low_R * k_warmth * 0.4
  endif

  ; Master LPF
  a_out_L butterlp a_out_L, k_lpf
  a_out_R butterlp a_out_R, k_lpf

  ; Per-instrument analysis
  a_mono = (a_out_L + a_out_R) * 0.5
  k_rms rms a_mono
  gk_pad_rms max gk_pad_rms, k_rms
  gk_pad_pulse max gk_pad_pulse, k_amp_env

  ; Pan
  aL = a_out_L * (1 - ipan) + a_out_R * ipan * 0.3
  aR = a_out_R * ipan + a_out_L * (1 - ipan) * 0.3

  aL = tanh(aL * k_vol * k_master)
  aR = tanh(aR * k_vol * k_master)

  aL dcblock aL
  aR dcblock aR

  outs aL, aR

  ga_dly_L = ga_dly_L + aL * k_dly_send
  ga_dly_R = ga_dly_R + aR * k_dly_send
  ga_rvb_L = ga_rvb_L + aL * k_rvb_send
  ga_rvb_R = ga_rvb_R + aR * k_rvb_send

endin


;==============================================================
; CONDUCTOR — instr 70
; Circle-of-fifths harmonic modulation engine.
;==============================================================
instr 70

  k_start_key chnget "cond_start_key"
  k_speed     chnget "cond_speed"
  k_dir_sel   chnget "cond_dir"
  k_enabled   chnget "cond_enabled"
  k_manual    chnget "cond_manual"
  k_scale     chnget "seq_scale"

  k_cof_pos     init 0
  k_xfade       init 0
  k_active      init 0
  k_pc_out      init 0
  k_pc_in       init 0
  k_direction   init 1
  k_prev_key    init 1
  k_initialized init 0

  if k_initialized == 0 then
    k_cof_pos = k_start_key - 1
    k_prev_key = k_start_key
    k_initialized = 1
    gk_cof_pos = k_cof_pos
    event "i", 71, 0, 0.1, k_cof_pos, k_scale
  endif

  if k_start_key != k_prev_key then
    k_cof_pos = k_start_key - 1
    k_prev_key = k_start_key
    k_xfade = 0
    k_active = 0
    gk_cof_pos = k_cof_pos
    event "i", 71, 0, 0.1, k_cof_pos, k_scale
  endif

  k_prev_scale init 1
  if k_scale != k_prev_scale then
    k_prev_scale = k_scale
    event "i", 71, 0, 0.1, k_cof_pos, k_scale
  endif

  ; Manual step (can be triggered from JS via chnset)
  k_man_trig trigger k_manual, 0.5, 0
  if k_man_trig == 1 then
    chnset k(0), "cond_manual"
    if k_active == 0 then
      if k_dir_sel == 1 then
        k_direction = 1
      elseif k_dir_sel == 2 then
        k_direction = -1
      else
        k_coin random 0, 1
        k_direction = (k_coin < 0.5) ? 1 : -1
      endif

      k_wt_cof = gi_cof_pc
      k_root_pc tablekt k_cof_pos, k_wt_cof

      if k_direction == 1 then
        k_pc_out = (k_root_pc + 5) % 12
        k_pc_in  = (k_root_pc + 6) % 12
      else
        k_pc_out = (k_root_pc + 11) % 12
        k_pc_in  = (k_root_pc + 10) % 12
      endif

      k_xfade = 0
      k_active = 1
    endif
  endif

  ; Auto-modulation
  if k_enabled > 0.5 && k_active == 0 then
    if k_dir_sel == 1 then
      k_direction = 1
    elseif k_dir_sel == 2 then
      k_direction = -1
    else
      k_coin random 0, 1
      k_direction = (k_coin < 0.5) ? 1 : -1
    endif

    k_wt_cof = gi_cof_pc
    k_root_pc tablekt k_cof_pos, k_wt_cof

    if k_direction == 1 then
      k_pc_out = (k_root_pc + 5) % 12
      k_pc_in  = (k_root_pc + 6) % 12
    else
      k_pc_out = (k_root_pc + 11) % 12
      k_pc_in  = (k_root_pc + 10) % 12
    endif

    k_xfade = 0
    k_active = 1
  endif

  ; Crossfade engine
  if k_active == 1 then
    k_inc = (ksmps / sr) / (k_speed * 60)
    k_xfade = k_xfade + k_inc

    if k_xfade >= 1 then
      k_xfade = 1
      k_active = 0
      k_cof_pos = (k_cof_pos + k_direction + 12) % 12
      gk_cof_pos = k_cof_pos
      event "i", 71, 0, 0.1, k_cof_pos, k_scale
    endif

    k_wt = gi_weights
    tablewkt (1 - k_xfade), k_pc_out, k_wt
    tablewkt k_xfade, k_pc_in, k_wt
  endif

  ; Update gk_cof_pos periodically
  k_gui_metro metro 5
  if k_gui_metro == 1 then
    gk_cof_pos = k_cof_pos
  endif

endin


;==============================================================
; KEY RESET — instr 71
; p4 = CoF position (0-11), p5 = scale mode (1-6)
;==============================================================
instr 71

  i_cof_pos = int(p4)
  i_scale   = int(p5)

  i_root_pc tab_i i_cof_pos, gi_cof_pc

  i_sc_tab = gi_sc_minpent
  i_sc_len = gi_sc_len_minpent

  if i_scale == 2 then
    i_sc_tab = gi_sc_majpent
    i_sc_len = gi_sc_len_majpent
  elseif i_scale == 3 then
    i_sc_tab = gi_sc_minor
    i_sc_len = gi_sc_len_minor
  elseif i_scale == 4 then
    i_sc_tab = gi_sc_major
    i_sc_len = gi_sc_len_major
  elseif i_scale == 5 then
    i_sc_tab = gi_sc_dorian
    i_sc_len = gi_sc_len_dorian
  elseif i_scale == 6 then
    i_sc_tab = gi_sc_chrom
    i_sc_len = gi_sc_len_chrom
  endif

  i_idx = 0
loop_clear:
  tabw_i 0, i_idx, gi_weights
  i_idx = i_idx + 1
  if i_idx < 12 igoto loop_clear

  i_deg = 0
loop_set:
  i_interval tab_i i_deg, i_sc_tab
  i_pc = (i_root_pc + i_interval) % 12
  tabw_i 1, i_pc, gi_weights
  i_deg = i_deg + 1
  if i_deg < i_sc_len igoto loop_set

  turnoff

endin


;==============================================================
; CHORD GENERATOR — instr 75
;==============================================================
instr 75

  k_pad_play chnget "pad_play"
  k_scale    chnget "seq_scale"

  k_prev_pos init -1
  k_prev_pad_play init -1

  k_changed = 0
  if k_prev_pos < 0 then
    k_prev_pos = gk_cof_pos
    k_prev_pad_play = k_pad_play
    k_changed = 1
  endif

  if gk_cof_pos != k_prev_pos then
    k_changed = 1
    k_prev_pos = gk_cof_pos
  endif

  if k_pad_play > 0.5 && k_prev_pad_play < 0.5 then
    k_changed = 1
  endif
  k_prev_pad_play = k_pad_play

  k_prev_sc init -1
  if k_prev_sc < 0 then
    k_prev_sc = k_scale
  endif
  if k_scale != k_prev_sc then
    k_changed = 1
    k_prev_sc = k_scale
  endif

  if k_changed == 1 && k_pad_play > 0.5 then

    turnoff2 3, 0, 1

    k_wt_cof = gi_cof_pc
    k_root_pc tablekt gk_cof_pos, k_wt_cof

    k_sc_tab = gi_sc_minpent
    k_sc_len = gi_sc_len_minpent

    if k_scale == 2 then
      k_sc_tab = gi_sc_majpent
      k_sc_len = gi_sc_len_majpent
    elseif k_scale == 3 then
      k_sc_tab = gi_sc_minor
      k_sc_len = gi_sc_len_minor
    elseif k_scale == 4 then
      k_sc_tab = gi_sc_major
      k_sc_len = gi_sc_len_major
    elseif k_scale == 5 then
      k_sc_tab = gi_sc_dorian
      k_sc_len = gi_sc_len_dorian
    elseif k_scale == 6 then
      k_sc_tab = gi_sc_chrom
      k_sc_len = gi_sc_len_chrom
    endif

    ; Voicing selection (6 types)
    k_voicing random 0, 5.999
    k_voicing = int(k_voicing)

    k_da = 0
    k_db = 2
    k_dc = 4
    k_oa = 0
    k_ob = 0
    k_oc = 0

    if k_voicing == 1 then
      k_da = 2
      k_db = 4
      k_dc = 0
      k_oc = 1
    elseif k_voicing == 2 then
      k_db = 4
      k_dc = 2
      k_oc = 1
    elseif k_voicing == 3 then
      k_db = 1
    elseif k_voicing == 4 then
      k_db = 3
    elseif k_voicing == 5 then
      k_db = 4
      k_dc = 1
      k_oc = 1
    endif

    if k_da >= k_sc_len then
      k_da = k_sc_len - 1
    endif
    if k_db >= k_sc_len then
      k_db = k_sc_len - 1
    endif
    if k_dc >= k_sc_len then
      k_dc = k_sc_len - 1
    endif

    k_sa = 0
    k_sb = 0
    k_sc = 0

    if k_scale == 6 then
      if k_voicing == 0 then
        k_sa = 0
        k_sb = 4
        k_sc = 7
      elseif k_voicing == 1 then
        k_sa = 4
        k_sb = 7
        k_sc = 0
        k_oc = 1
      elseif k_voicing == 2 then
        k_sa = 0
        k_sb = 7
        k_sc = 4
        k_oc = 1
      elseif k_voicing == 3 then
        k_sa = 0
        k_sb = 2
        k_sc = 7
      elseif k_voicing == 4 then
        k_sa = 0
        k_sb = 5
        k_sc = 7
      elseif k_voicing == 5 then
        k_sa = 0
        k_sb = 7
        k_sc = 2
        k_oc = 1
      endif
    else
      k_sa tablekt k_da, k_sc_tab
      k_sb tablekt k_db, k_sc_tab
      k_sc tablekt k_dc, k_sc_tab
    endif

    k_base = 4 * 12
    k_ma = k_base + ((k_root_pc + k_sa) % 12) + k_oa * 12
    k_mb = k_base + ((k_root_pc + k_sb) % 12) + k_ob * 12
    k_mc = k_base + ((k_root_pc + k_sc) % 12) + k_oc * 12

    if k_mb <= k_ma then
      k_mb = k_mb + 12
    endif
    if k_mc <= k_mb then
      k_mc = k_mc + 12
    endif

    k_ma limit k_ma, 36, 84
    k_mb limit k_mb, 36, 84
    k_mc limit k_mc, 36, 84

    k_fa = cpsmidinn(k_ma)
    k_fb = cpsmidinn(k_mb)
    k_fc = cpsmidinn(k_mc)

    k_vel_a = 0.7
    k_vel_bc = 0.6
    k_pan_a random 0.35, 0.65
    k_pan_b random 0.15, 0.45
    k_pan_c random 0.55, 0.85

    event "i", 3, 0, 3600, k_fa, k_vel_a,  k_pan_a
    event "i", 3, 0, 3600, k_fb, k_vel_bc, k_pan_b
    event "i", 3, 0, 3600, k_fc, k_vel_bc, k_pan_c

  endif

  if k_pad_play < 0.5 then
    k_pad_off_trig init 0
    if k_pad_off_trig == 0 then
      turnoff2 3, 0, 1
      k_pad_off_trig = 1
    endif
  else
    k_pad_off_trig = 0
  endif

endin


;==============================================================
; DRONE CONTROLLER — instr 76
;==============================================================
instr 76

  k_fm_play chnget "fm_play"

  k_wt_cof = gi_cof_pc
  k_root_pc tablekt gk_cof_pos, k_wt_cof

  k_target_midi = 24 + k_root_pc

  k_drone_midi portk k_target_midi, 2.0

  chnset k_drone_midi, "drone_midi"

  k_drone_active init 0

  if k_fm_play > 0.5 then
    chnset k(1), "drone_gate"
    if k_drone_active == 0 then
      event "i", 2, 0, 3600
      k_drone_active = 1
    endif
  else
    chnset k(0), "drone_gate"
    if k_drone_active == 1 then
      k_drone_active = 0
    endif
  endif

endin


;==============================================================
; SEQUENCER — instr 80
;==============================================================
instr 80

  k_play    chnget "seq_play"
  k_plk_play chnget "plk_play"
  k_bpm     chnget "seq_bpm"
  k_scale   chnget "seq_scale"

  ; Hard-coded from sequencer-rig preset
  k_swing   = 0
  k_dens    = 0.8 + gk_plk_mod_density
  k_dens    limit k_dens, 0, 1
  k_gate    = 3.0
  k_range   = 1.5
  k_octjump = 0.2

  ; Derive root from conductor key + register
  k_reg     chnget "seq_root"
  k_wt_cof  = gi_cof_pc
  k_cond_pc tablekt gk_cof_pos, k_wt_cof
  k_root_oct = int(k_reg) + 1
  k_root     = k_root_oct * 12 + k_cond_pc

  k_patmode chnget "seq_patmode"
  k_patrep  chnget "seq_patrep"

  k_velmin = 0.3
  k_velmax = 0.8
  k_accent = 0.3

  ; Scale table selection
  k_sc_tab  = gi_sc_minpent
  k_sc_len  = gi_sc_len_minpent

  if k_scale == 2 then
    k_sc_tab = gi_sc_majpent
    k_sc_len = gi_sc_len_majpent
  elseif k_scale == 3 then
    k_sc_tab = gi_sc_minor
    k_sc_len = gi_sc_len_minor
  elseif k_scale == 4 then
    k_sc_tab = gi_sc_major
    k_sc_len = gi_sc_len_major
  elseif k_scale == 5 then
    k_sc_tab = gi_sc_dorian
    k_sc_len = gi_sc_len_dorian
  elseif k_scale == 6 then
    k_sc_tab = gi_sc_chrom
    k_sc_len = gi_sc_len_chrom
  endif

  k_range_semi = k_range * 12
  k_max_deg = k_range_semi / 12 * k_sc_len
  k_max_deg limit k_max_deg, 1, 60

  ; Pattern state
  k_pat_step     init 0
  k_pat_rep      init 0
  k_pat_len      init 8
  k_pat_ready    init 0
  k_pat_need_gen init 0
  k_gen_active   init 0
  k_gen_step     init 0
  k_gen_len      init 8
  k_prev_patmode init 1
  k_prev_scale   init 1
  k_prev_root    init 48

  k_new_len = 8
  if k_patmode == 3 then
    k_new_len = 16
  elseif k_patmode == 4 then
    k_new_len = 32
  endif

  if k_patmode != k_prev_patmode then
    k_pat_need_gen = 1
    k_pat_ready = 0
    k_prev_patmode = k_patmode
  endif

  if k_scale != k_prev_scale then
    if k_patmode > 1 then
      k_pat_need_gen = 1
    endif
    k_prev_scale = k_scale
  endif
  if k_root != k_prev_root then
    if k_patmode > 1 then
      k_pat_need_gen = 1
    endif
    k_prev_root = k_root
  endif

  if k_patmode == 1 && k_gen_active == 1 then
    k_gen_active = 0
  endif

  if k_patmode > 1 && k_pat_ready == 0 && k_gen_active == 0 then
    k_pat_need_gen = 1
  endif

  if k_pat_need_gen == 1 && k_patmode > 1 then
    k_gen_active = 1
    k_gen_step = 0
    k_gen_len = k_new_len
    k_pat_ready = 0
    k_pat_need_gen = 0
  endif

  ; Pattern generation state machine
  if k_gen_active == 1 then

    k_gen_roll random 0, 1
    if k_gen_roll < k_dens then

      k_gdeg random 0, k_max_deg
      k_gdeg = int(k_gdeg)
      k_goct = int(k_gdeg / k_sc_len)
      k_gdeg_sc = k_gdeg - k_goct * k_sc_len
      k_gdeg_sc limit k_gdeg_sc, 0, k_sc_len - 1
      k_gsemi tablekt k_gdeg_sc, k_sc_tab
      k_gmidi = k_root + k_goct * 12 + k_gsemi

      k_goct_roll random 0, 1
      if k_goct_roll < k_octjump then
        k_gmidi = k_gmidi + 12
      endif
      k_gmidi limit k_gmidi, 24, 108

      k_gacc random 0, 1
      if k_gacc < k_accent then
        k_gvel = k_velmax
      else
        k_gvel random k_velmin, k_velmax
      endif

      k_wt_pn = gi_pat_note
      tablewkt k_gmidi, k_gen_step, k_wt_pn
      k_wt_pv = gi_pat_vel
      tablewkt k_gvel, k_gen_step, k_wt_pv

      k_gdbl random 0, 1
      if k_gdbl < 0.15 then
        k_gdeg2 random 0, k_max_deg
        k_gdeg2 = int(k_gdeg2)
        k_goct2 = int(k_gdeg2 / k_sc_len)
        k_gdeg2_sc = k_gdeg2 - k_goct2 * k_sc_len
        k_gdeg2_sc limit k_gdeg2_sc, 0, k_sc_len - 1
        k_gsemi2 tablekt k_gdeg2_sc, k_sc_tab
        k_gmidi2 = k_root + k_goct2 * 12 + k_gsemi2
        k_gmidi2 limit k_gmidi2, 24, 108
        k_wt_pd = gi_pat_dbl
        tablewkt k_gmidi2, k_gen_step, k_wt_pd
      else
        k_wt_pd = gi_pat_dbl
        tablewkt 0, k_gen_step, k_wt_pd
      endif

    else
      k_wt_pn = gi_pat_note
      tablewkt 0, k_gen_step, k_wt_pn
      k_wt_pv = gi_pat_vel
      tablewkt 0, k_gen_step, k_wt_pv
      k_wt_pd = gi_pat_dbl
      tablewkt 0, k_gen_step, k_wt_pd
    endif

    k_gen_step = k_gen_step + 1
    if k_gen_step >= k_gen_len then
      k_gen_active = 0
      k_pat_ready = 1
      k_pat_step = 0
      k_pat_rep = 0
      k_pat_len = k_gen_len
    endif

  endif

  ; Eighth-note metro with swing
  k_eighth = 60 / k_bpm / 2

  k_step init 0
  k_next_time init 0

  k_time timeinsts
  k_trig = 0

  if k_time >= k_next_time then
    k_trig = 1
    if k_step == 0 then
      k_next_time = k_time + k_eighth * (1 + k_swing)
    else
      k_next_time = k_time + k_eighth * (1 - k_swing)
    endif
    k_step = 1 - k_step
  endif

  ; Note generation
  if k_trig == 1 && k_play > 0.5 && k_plk_play > 0.5 then

    if k_patmode == 1 then
      ; FREE MODE
      k_roll random 0, 1
      if k_roll < k_dens then

        k_deg random 0, k_max_deg
        k_deg = int(k_deg)
        k_octave = int(k_deg / k_sc_len)
        k_degree_in_scale = k_deg - k_octave * k_sc_len
        k_degree_in_scale limit k_degree_in_scale, 0, k_sc_len - 1
        k_semi tablekt k_degree_in_scale, k_sc_tab
        k_midi_note = k_root + k_octave * 12 + k_semi

        k_oct_roll random 0, 1
        if k_oct_roll < k_octjump then
          k_midi_note = k_midi_note + 12
        endif
        k_midi_note limit k_midi_note, 24, 108
        k_freq = cpsmidinn(k_midi_note)

        k_acc_roll random 0, 1
        if k_acc_roll < k_accent then
          k_vel = k_velmax
        else
          k_vel random k_velmin, k_velmax
        endif

        k_pan random 0.2, 0.8

        k_active active 1
        if k_active < 8 then
          event "i", 1, 0, k_gate, k_freq, k_vel, k_pan
        endif

        k_dbl_roll random 0, 1
        if k_dbl_roll < 0.15 && k_active < 7 then
          k_deg2 random 0, k_max_deg
          k_deg2 = int(k_deg2)
          k_oct2 = int(k_deg2 / k_sc_len)
          k_deg2_sc = k_deg2 - k_oct2 * k_sc_len
          k_deg2_sc limit k_deg2_sc, 0, k_sc_len - 1
          k_semi2 tablekt k_deg2_sc, k_sc_tab
          k_midi2 = k_root + k_oct2 * 12 + k_semi2
          k_midi2 limit k_midi2, 24, 108
          k_freq2 = cpsmidinn(k_midi2)
          k_vel2 random k_velmin, k_velmax
          k_pan2 random 0.2, 0.8
          event "i", 1, k_eighth * 0.5, k_gate, k_freq2, k_vel2, k_pan2
        endif

      endif

    else
      ; PATTERN MODE
      if k_pat_ready == 1 then
        k_wt_pn = gi_pat_note
        k_p_midi tablekt k_pat_step, k_wt_pn

        if k_p_midi > 0 then
          k_p_freq = cpsmidinn(k_p_midi)
          k_wt_pv = gi_pat_vel
          k_p_vel tablekt k_pat_step, k_wt_pv
          k_p_pan random 0.2, 0.8

          k_active active 1
          if k_active < 8 then
            event "i", 1, 0, k_gate, k_p_freq, k_p_vel, k_p_pan
          endif

          k_wt_pd = gi_pat_dbl
          k_p_dbl tablekt k_pat_step, k_wt_pd
          if k_p_dbl > 0 && k_active < 7 then
            k_p_freq2 = cpsmidinn(k_p_dbl)
            k_p_vel2 random k_velmin, k_velmax
            k_p_pan2 random 0.2, 0.8
            event "i", 1, k_eighth * 0.5, k_gate, k_p_freq2, k_p_vel2, k_p_pan2
          endif
        endif

        k_pat_step = k_pat_step + 1
        if k_pat_step >= k_pat_len then
          k_pat_step = 0
          k_pat_rep = k_pat_rep + 1
          if k_pat_rep >= k_patrep then
            k_pat_rep = 0
            k_pat_need_gen = 1
            k_pat_ready = 0
          endif
        endif
      endif

    endif
  endif

endin


;==============================================================
; CHANNEL WRITER — instr 97
; Smooths polyphonic analysis accumulators and writes to
; named channels matching existing shader uniforms.
;==============================================================
instr 97

  k_plk_r port gk_pluck_rms, 0.02
  k_pad_r port gk_pad_rms, 0.05
  k_pad_p port gk_pad_pulse, 0.05

  ; bass_rms and bass_cutoff written directly by instr 2
  chnset k_pad_r, "pad_rms"
  chnset k_pad_p, "pad_pulse"
  ; Map pad data to swarm channels for shader reactivity
  chnset k_pad_r * 0.7, "swarm_rms"
  ; Map pad morph LFO to swarm_lfo (normalize to 0-1)
  k_morph_n = (gk_pad_mod_morph + 0.5)
  k_morph_n limit k_morph_n, 0, 1
  chnset k_morph_n, "swarm_lfo"
  chnset k_plk_r, "pluck_rms"

  ; Key position for shader (normalized 0-1, smoothed for gradual camera shift)
  k_key_n port gk_cof_pos / 12.0, 3.0
  chnset k_key_n, "key_pos"

  ; Reset accumulators
  gk_pluck_rms = 0
  gk_pad_rms = 0
  gk_pad_pulse = 0

endin


;==============================================================
; DELAY — instr 98 (Ping-Pong, BPM-synced)
;==============================================================
instr 98

  k_div      chnget "dly_div"
  k_bpm      chnget "seq_bpm"
  k_fb       chnget "dly_fb"
  k_mix      chnget "dly_mix"
  k_mod_dep  chnget "dly_mod"
  k_rvb_send chnget "dly_rvb_send"

  k_quarter = 60 / k_bpm

  k_time = k_quarter
  if k_div == 1 then
    k_time = k_quarter * 2
  elseif k_div == 3 then
    k_time = k_quarter * 0.75
  elseif k_div == 4 then
    k_time = k_quarter * 0.5
  elseif k_div == 5 then
    k_time = k_quarter * 0.25
  elseif k_div == 6 then
    k_time = k_quarter * 0.6667
  elseif k_div == 7 then
    k_time = k_quarter * 0.3333
  endif

  k_time limit k_time, 0.05, 1.95

  k_mod lfo k_mod_dep, 0.23, 0

  i_maxdel = 2.0

  a_tap_L init 0
  a_tap_R init 0

  a_buf_L delayr i_maxdel
  a_tap_L deltap3 k_time + k_mod
          delayw ga_dly_L + a_tap_R * k_fb

  a_buf_R delayr i_maxdel
  a_tap_R deltap3 k_time - k_mod
          delayw ga_dly_R + a_tap_L * k_fb

  outs a_tap_L * k_mix, a_tap_R * k_mix

  ga_rvb_L = ga_rvb_L + a_tap_L * k_rvb_send
  ga_rvb_R = ga_rvb_R + a_tap_R * k_rvb_send

  ga_dly_L = 0
  ga_dly_R = 0

endin


;==============================================================
; REVERB — instr 99 (reverbsc)
;==============================================================
instr 99

  k_fb   chnget "rvb_fb"
  k_cut  chnget "rvb_cut"
  k_wet  chnget "rvb_wet"

  a_L, a_R reverbsc ga_rvb_L, ga_rvb_R, k_fb, k_cut
  outs a_L * k_wet, a_R * k_wet

  ga_rvb_L = 0
  ga_rvb_R = 0

endin


</CsInstruments>
<CsScore>
i 10 0  0.1          ; channel init (set defaults, then turnoff)
i 78 0  0.5          ; WAV loader (load pad samples, then turnoff)
i 90 0  99999        ; LFO modulator
i 70 0  99999        ; conductor (circle-of-fifths)
i 76 0  99999        ; drone controller
i 75 0  99999        ; chord generator
i 80 0  99999        ; sequencer
i 97 0  99999        ; channel writer (analysis for shaders)
i 98 0  99999        ; delay
i 99 0  99999        ; reverb
</CsScore>
</CsoundSynthesizer>
