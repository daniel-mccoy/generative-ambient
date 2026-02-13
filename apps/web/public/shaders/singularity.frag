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
    float od = 0.0;
    vec4 col = vec4(0.0);

    for (int i = 0; i < 100; i++) {
        vec3 p = vec3(uv * d, d);
        od = length(p - vec3(
            sin(sin(t) + sin(t * 0.1)) * d / 2.0,
            sin(sin(t * 1.7) + sin(t * 0.1)) * d / 4.0,
            sin(t * 0.5) * 5.0 + 7.0
        )) - 0.8;
        s = min(od, 4.0 - abs(p.y));

        float a = 0.1;
        for (int j = 0; j < 5; j++) {
            p += cos(t + p.yzx) * 0.03;
            s -= abs(dot(sin(p * a * 8.0), vec3(0.05))) / a;
            a *= 2.0;
        }

        s = 0.02 + abs(s) * 0.1;
        d += s;
        col += vec4(4.0, 3.0, 2.0, 0.0) / s;
    }

    // tanh tone mapping (tanh unavailable in GLSL ES 1.0)
    vec4 v = col / 2e3 / max(abs(od), 0.001);
    vec4 e = exp(2.0 * clamp(v, 0.0, 10.0));
    col = (e - 1.0) / (e + 1.0);

    // Audio-reactive warmth shift
    col.r += u_pluck_rms * 0.3;
    col.g += u_pad_rms * 0.15;
    col.rgb *= 1.0 + u_bass * 0.1;

    gl_FragColor = vec4(col.rgb, 1.0);
}
