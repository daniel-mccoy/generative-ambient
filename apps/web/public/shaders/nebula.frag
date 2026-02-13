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
    vec2 uv = (gl_FragCoord.xy * 2.0 - u_resolution) / u_resolution.y;

    float d = 0.0;
    float s = 0.0;
    vec4 col = vec4(0.0);

    for (int i = 0; i < 64; i++) {
        vec3 p = vec3(uv * d, d + t);
        s = 8.0 - length(p.xy * sin(p.y * 0.25));

        float a = 0.05;
        for (int j = 0; j < 6; j++) {
            p += cos(t + p.yzx) * 0.03;
            s -= abs(dot(sin(0.5 * t + 0.1 * p.z + p * a * 12.0), vec3(0.05))) / a;
            a *= 2.0;
        }

        s = 0.05 + abs(s) * 0.2;
        d += s;
        col += 1.0 / s;
    }

    // tanh tone mapping (tanh unavailable in GLSL ES 1.0)
    vec4 v = col * col / 3e6 / dot(uv, uv);
    vec4 e = exp(2.0 * clamp(v, 0.0, 10.0));
    col = (e - 1.0) / (e + 1.0);

    // Subtle audio-reactive color tint
    vec3 tint = vec3(
        0.9 + u_bass_cutoff * 0.2 + u_pluck_rms * 2.0,
        0.85 + u_swarm_lfo * 0.15,
        1.0 + u_pad_rms * 0.5
    );
    col.rgb *= tint;

    gl_FragColor = vec4(col.rgb, 1.0);
}
