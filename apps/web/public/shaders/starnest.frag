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
uniform float u_key_pos;

// Star Nest by Pablo Roman Andrioli — MIT License
// Converted from Shadertoy to WebGL 1.0

#define BPM 80.0

#define formuparam 0.53
#define stepsize 0.1
#define zoom   0.800
#define tile   0.850
#define brightness 0.0015
#define darkmatter 0.300
#define distfading 0.730
#define saturation 0.850

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.xy - 0.5;
    uv.y *= u_resolution.y / u_resolution.x;
    vec3 dir = vec3(uv * zoom, 1.0);

    // Travel speed derived from BPM (halved for ambient drift)
    float speed = BPM / 32000.0;
    float time = u_time * speed + 0.25;

    // Viewing angle shifts with circle-of-fifths key position
    float a1 = 0.5 + u_key_pos * 0.4;
    float a2 = 0.8 + sin(u_key_pos * 6.283) * 0.15;
    mat2 rot1 = mat2(cos(a1), sin(a1), -sin(a1), cos(a1));
    mat2 rot2 = mat2(cos(a2), sin(a2), -sin(a2), cos(a2));
    dir.xz = dir.xz * rot1;
    dir.xy = dir.xy * rot2;
    vec3 from = vec3(1.0, 0.5, 0.5);
    from += vec3(time * 2.0, time, -2.0);
    from.xz = from.xz * rot1;
    from.xy = from.xy * rot2;

    // Volumetric rendering
    float s = 0.1, fade = 1.0;
    vec3 v = vec3(0.0);
    for (int r = 0; r < 20; r++) {
        vec3 p = from + s * dir * 0.5;
        p = abs(vec3(tile) - mod(p, vec3(tile * 2.0)));
        float pa = 0.0;
        float a = 0.0;
        // FM drone LFO modulates fractal structure
        float formu = formuparam + u_bass_cutoff * 0.03;
        for (int i = 0; i < 17; i++) {
            p = abs(p) / dot(p, p) - formu;
            a += abs(length(p) - pa);
            pa = length(p);
        }
        float dm = max(0.0, darkmatter - a * a * 0.001);
        a *= a * a;
        if (r > 6) fade *= 1.0 - dm;
        v += fade;
        v += vec3(s, s * s, s * s * s * s) * a * brightness * fade;
        fade *= distfading;
        s += stepsize;
    }
    v = mix(vec3(length(v)), v, saturation);

    vec3 col = v * 0.01;

    // Audio reactivity handled in volumetric loop (bass_cutoff → large star tint)

    gl_FragColor = vec4(col, 1.0);
}
