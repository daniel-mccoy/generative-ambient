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
    vec2 uv = (gl_FragCoord.xy - u_resolution / 2.0) / u_resolution.y;

    float d = 0.0;
    float s = 0.0;
    vec4 col = vec4(0.0);

    for (int i = 0; i < 100; i++) {
        vec3 p = vec3(uv * d, d + t);

        // Inner fractal detail: s starts 0.15, *=1.5 each step
        // 0.15, 0.225, 0.3375, 0.506, 0.759 = 5 iterations before >= 1.0
        s = 0.15;
        for (int j = 0; j < 5; j++) {
            p += cos(t + p.yzx * 0.6) * sin(p.z * 0.1) * 0.2;
            p.y += sin(t + p.x) * 0.03;
            p += abs(dot(sin(p * s * 24.0), vec3(0.01))) / s;
            s *= 1.5;
        }

        s = 0.03 + abs(2.0 + p.y) * 0.3;
        d += s;
        col += vec4(1.0, 2.0, 4.0, 0.0) / s;
    }

    // tanh tone mapping with off-center vignette
    vec2 vig = uv - 0.35;
    vec4 v = col / 7e3 / dot(vig, vig);
    vec4 e = exp(2.0 * clamp(v, 0.0, 10.0));
    col = (e - 1.0) / (e + 1.0);

    // Audio-reactive cool tint
    col.b += u_pad_rms * 0.2 + u_swarm_lfo * 0.1;
    col.g += u_pluck_rms * 0.2;
    col.rgb *= 1.0 + u_bass * 0.08;

    gl_FragColor = vec4(col.rgb, 1.0);
}
