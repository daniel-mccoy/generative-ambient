// Rocaille — Ornate flowing turbulence with audio reactivity
// Original by @XorDev (Shadertoy), ported for generative-ambient engine
// Multiple layers of turbulence with time and color offsets
// Creates flowing baroque filigree with jewel-tone colors

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;

// Audio inputs (0.0 - 1.0 from AnalysisGrabber envelope followers)
uniform float u_bass;
uniform float u_mid;
uniform float u_high;

// Per-instrument Csound channels (polled via getControlChannel)
uniform float u_bass_rms;     // Bass drone RMS (~0-0.5)
uniform float u_bass_cutoff;  // Bass drone filter cutoff (0-1)
uniform float u_pad_rms;      // Drone pad RMS (~0-0.3)
uniform float u_pad_pulse;    // Drone pad envelope (0-1)
uniform float u_swarm_rms;    // Swarm pad RMS (~0-0.3)
uniform float u_swarm_lfo;    // Swarm pad glacial LFO (0-1)
uniform float u_pluck_rms;    // Pluck transient RMS (~0-0.2)

// tanh approximation (Pade) — not available in GLSL ES 1.0
vec4 tanhApprox(vec4 x) {
    x = clamp(x, -3.0, 3.0);
    vec4 x2 = x * x;
    return x * (27.0 + x2) / (27.0 + 9.0 * x2);
}

void main() {
    // Scale: bass drone breathing gently zooms the pattern
    float scale = 0.3 + u_bass_rms * 0.02;

    // Centered and scaled coordinates
    vec2 v = u_resolution.xy;
    vec2 p = (gl_FragCoord.xy * 2.0 - v) / v.y / scale;

    // Time: swarm LFO adds subtle drift to evolution speed
    float t = u_time + u_swarm_lfo * 0.8;

    // Color palette shift: pad envelope warms, bass filter opens, swarm drifts
    float colorShift = u_pad_pulse * 0.4 + u_bass_cutoff * 0.3 + u_swarm_lfo * 0.5;

    // Turbulence amplitude: swarm pad adds detail when louder
    float turbAmp = 1.0 + u_swarm_rms * 0.5;

    vec4 O = vec4(0.0);

    // 9 layers of turbulence, each with unique color and phase
    for (float i = 1.0; i < 10.0; i += 1.0) {
        // Turbulence: accumulate sin waves at increasing frequency
        v = p;
        for (float f = 1.0; f < 10.0; f += 1.0) {
            v += sin(v.yx * f + i + t) / f * turbAmp;
        }

        // Color per layer, attenuated by turbulent distance
        // Bright where turbulence converges (length(v) near 0)
        O += (cos(i + colorShift + vec4(0, 1, 2, 3)) + 1.0) / 6.0 / length(v);
    }

    // Pluck transients brighten convergence points
    O *= 1.0 + u_pluck_rms * 1.5;

    // Pad RMS adds ambient glow
    O += u_pad_rms * 0.2;

    // Tonemapping: tanh(O^2) — soft highlight compression
    O = tanhApprox(O * O);

    gl_FragColor = O;
}
