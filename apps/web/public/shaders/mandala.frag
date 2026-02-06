// Morphing Mandala - Slowly evolving domain-warped pattern with audio reactivity
// Ported from Shadertoy (Krabcode gradient + IQ domain warp mandala)
// Re-tuned for ambient/generative music visualization

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

#define PI 3.14159265
#define TAU 6.28318531

// --- Color utilities ---

vec3 hsv2rgb(in vec3 c) {
    vec3 rgb = clamp(abs(mod(c.x * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

vec3 hexToRgb(int color) {
    float rValue = float(color / 256 / 256);
    float gValue = float(color / 256 - int(rValue * 256.0));
    float bValue = float(color - int(rValue * 256.0 * 256.0) - int(gValue * 256.0));
    return vec3(rValue / 255.0, gValue / 255.0, bValue / 255.0);
}

// Improved RGB interpolation preserving saturation (nmz)
#define DSP_STR 1.5

float getsat(vec3 c) {
    float mi = min(min(c.x, c.y), c.z);
    float ma = max(max(c.x, c.y), c.z);
    return (ma - mi) / (ma + 1e-7);
}

vec3 iLerp(in vec3 a, in vec3 b, in float x) {
    vec3 ic = mix(a, b, x) + vec3(1e-6, 0.0, 0.0);
    float sd = abs(getsat(ic) - mix(getsat(a), getsat(b), x));
    vec3 dir = normalize(vec3(2.0 * ic.x - ic.y - ic.z, 2.0 * ic.y - ic.x - ic.z, 2.0 * ic.z - ic.y - ic.x));
    float lgt = dot(vec3(1.0), ic);
    float ff = dot(dir, normalize(ic));
    ic += DSP_STR * dir * sd * ff * lgt;
    return clamp(ic, 0.0, 1.0);
}

// --- 5-stop gradient as a function (no struct arrays needed) ---

vec3 gradient(float t) {
    // Palette: deep purple → purple → crimson → coral → warm gold
    vec3 c0 = hexToRgb(0x522d5b) * 0.5;
    vec3 c1 = hexToRgb(0x522d5b);
    vec3 c2 = hexToRgb(0xd7385e);
    vec3 c3 = hexToRgb(0xfb7b6b);
    vec3 c4 = hexToRgb(0xe7d39f);

    // Slow time-based color drift, gently biased by mid frequencies
    float drift = sin(u_time * 0.03) * 0.08;
    float pos = clamp(t + drift + u_mid * 0.06, 0.0, 1.0);

    if (pos < 0.25) return iLerp(c0, c1, pos / 0.25);
    if (pos < 0.5)  return iLerp(c1, c2, (pos - 0.25) / 0.25);
    if (pos < 0.75) return iLerp(c2, c3, (pos - 0.5) / 0.25);
    return iLerp(c3, c4, (pos - 0.75) / 0.25);
}

// --- IQ noise ---

float hash(float n) {
    return fract(sin(n) * 43758.5453);
}

float iqNoise(vec3 x) {
    vec3 p = floor(x);
    vec3 f = fract(x);
    f = f * f * (3.0 - 2.0 * f);
    float n = p.x + p.y * 57.0 + 113.0 * p.z;
    return mix(mix(mix(hash(n + 0.0), hash(n + 1.0), f.x),
                   mix(hash(n + 57.0), hash(n + 58.0), f.x), f.y),
               mix(mix(hash(n + 113.0), hash(n + 114.0), f.x),
                   mix(hash(n + 170.0), hash(n + 171.0), f.x), f.y), f.z);
}

// --- FBM with fixed octave count ---

float fbm(vec2 p) {
    float sum = 0.0;
    float freq = 1.0;
    float amp = 0.5;
    // Always run 4 octaves, but smoothly fade in the upper two with u_high
    for (int i = 0; i < 4; i++) {
        float octaveWeight = 1.0;
        if (i == 2) octaveWeight = 0.5;
        if (i == 3) octaveWeight = 0.15;
        sum += amp * octaveWeight * (1.0 - 2.0 * iqNoise(vec3(p * freq, 0.0)));
        freq *= 2.0;
        amp *= 0.5;
    }
    return sum;
}

// --- Domain warp pattern ---

float pattern(in vec2 p, out vec2 q, out vec2 r) {
    float time = u_time * 0.05;

    q.x = fbm(p + vec2(0.0 + time, 0.0 - time));
    q.y = fbm(p + vec2(5.2 - time, 1.3));

    // Audio: bass gently increases domain warp intensity
    float warpStrength = 4.0 + u_bass * 0.15;

    r.x = fbm(p + warpStrength * q + vec2(1.7, 9.2));
    r.y = fbm(p + warpStrength * q + vec2(8.3, 2.8));

    return fbm(p + warpStrength * r);
}

// --- Render with mandala symmetry ---

float render(vec2 uv) {
    float angle = cos(8.0 * atan(uv.y, uv.x));
    float dist = length(uv * 5.0) - u_time * 0.003;
    vec2 p = vec2(dist, angle);
    vec2 q = vec2(0.0);
    vec2 r = vec2(0.0);
    float n = 0.25 + 0.75 * pattern(p, q, r);
    n *= length(q * 2.0);
    n += r.x;
    n -= r.y;
    return n;
}

// --- Anti-aliased render ---

float renderAA(vec2 uv) {
    float pixelThird = (1.0 / u_resolution.x) / 3.0;
    vec2 aa = vec2(-pixelThird, pixelThird);
    float c1 = render(uv + aa.xx);
    float c2 = render(uv + aa.xy);
    float c3 = render(uv + aa.yx);
    float c4 = render(uv + aa.yy);
    return (c1 + c2 + c3 + c4) / 4.0;
}

// --- Main ---

void main() {
    vec2 uv = (gl_FragCoord.xy - 0.5 * u_resolution.xy) / u_resolution.y;
    float n = renderAA(uv);

    vec3 col = gradient(n);

    // Audio: bass gently brightens
    col *= 1.0 + u_bass * 0.2;

    gl_FragColor = vec4(col, 1.0);
}
