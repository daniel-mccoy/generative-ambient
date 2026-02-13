#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform float u_bass;
uniform float u_mid;
uniform float u_high;
uniform float u_bass_rms;
uniform float u_bass_cutoff;
uniform float u_pad_rms;
uniform float u_pad_pulse;
uniform float u_swarm_rms;
uniform float u_swarm_lfo;
uniform float u_pluck_rms;

void main() {
    float t = u_time;
    vec2 uv = gl_FragCoord.xy;

    float d = 0.0;
    float s = 0.0;
    vec4 col = vec4(0.0);

    for (int i = 0; i < 100; i++) {
        vec3 p = d * normalize(vec3(uv + uv, 0.0) - u_resolution.xyx);

        // Inner fractal: s starts 0.15, doubles each step
        // 0.15, 0.3, 0.6 = 3 iterations before >= 1.0
        s = 0.15;
        for (int j = 0; j < 3; j++) {
            p += abs(dot(0.2 * p.x + sin(p.z + t + p * s * 32.0), vec3(0.01))) / s;
            s += s;
        }

        s = 0.03 + abs(0.3 - abs(p.y)) * 0.3 + abs(p.x * 0.05);
        d += s;
        col += vec4(4.0, 3.0, 2.0, 0.0) / s;
    }

    // tanh tone mapping (squared variant for richer contrast)
    vec4 v = col * col / 4e6;
    vec4 e = exp(2.0 * clamp(v, 0.0, 10.0));
    col = (e - 1.0) / (e + 1.0);

    // Audio-reactive warmth
    col.r += u_pluck_rms * 0.25;
    col.g += u_bass_cutoff * 0.1;
    col.rgb *= 1.0 + u_bass * 0.1;

    gl_FragColor = vec4(col.rgb, 1.0);
}
