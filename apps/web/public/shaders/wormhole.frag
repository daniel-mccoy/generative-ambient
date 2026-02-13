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

#define T (u_time * 0.1)

float tanh_f(float x) {
    float e = exp(2.0 * clamp(x, -10.0, 10.0));
    return (e - 1.0) / (e + 1.0);
}

vec3 tanh_v3(vec3 x) {
    vec3 e = exp(2.0 * clamp(x, -10.0, 10.0));
    return (e - 1.0) / (e + 1.0);
}

mat2 rot(float a) {
    vec4 c = cos(a + vec4(0.0, 33.0, 11.0, 0.0));
    return mat2(c.x, c.y, c.z, c.w);
}

vec3 pathP(float z) {
    return vec3(cos(z * 0.3) * 0.6 * 7.0, cos(z * 0.1) * 0.8 * 6.0, z);
}

vec3 look(vec3 p) {
    float t = T * 6.0;
    return p - vec3(
        pathP(p.z).x + tanh_f(cos(t * 0.3) * 2.0) * 2.8,
        pathP(p.z).y + tanh_f(cos(t * 0.5) * 2.0) * 2.8,
        1.3 + T + tanh_f(cos(t * 0.15) * 1.9)
    );
}

void main() {
    vec3 ro = pathP(T);
    vec3 Z = normalize(pathP(T + 3.0) - look(ro) - ro);
    vec3 X = normalize(vec3(Z.z, 0.0, -Z.x));
    vec2 uv = rot(sin(T) * 0.6) * (gl_FragCoord.xy - u_resolution / 2.0) / u_resolution.y;
    vec3 D = vec3(uv, 1.0) * mat3(-X, cross(X, Z), Z);

    float s = 0.002;
    float d = 0.0;
    vec3 col = vec3(0.0);

    for (int i = 0; i < 99; i++) {
        if (s <= 0.001) break;

        vec3 p = ro + D * d;
        float shell = 0.1 - length(p.xy - pathP(p.z).xy - d);
        vec3 q = p;
        p += cos(6.0 * T + p.y + p.x + p.zxy) * 0.4;
        s = dot(abs(p - floor(p) - 0.5), vec3(0.45));
        p = q;
        p.y += cos(6.0 * T + p.z) * 0.5;
        p.x += cos(5.0 * T + p.z) * 0.6;
        p *= 2.0;

        float w = 2.0;
        float l;
        for (int j = 0; j < 8; j++) {
            p.xy = p.xy * rot(T);
            p = sin(p);
            p.xy = p.xy * rot(T * 3.5);
            p.xz = p.xz * rot(sin(T * 3.0) * 0.2);
            l = 2.11 / dot(p, p);
            p *= l;
            w *= l;
        }

        d += max(shell, min(s, length(p) / w));
        col += (cos(p.yzx + 0.1) * 0.005) / d / s;
    }

    // tanh tone mapping with distance fog
    col = tanh_v3(col * exp(-d / 24.0));

    // Audio-reactive glow
    col *= 1.0 + u_bass * 0.08;
    col += u_pluck_rms * 0.1;
    col *= 1.0 + u_pad_rms * vec3(0.05, 0.1, 0.15);

    gl_FragColor = vec4(col, 1.0);
}
