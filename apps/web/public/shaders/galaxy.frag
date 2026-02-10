// Galaxy — Spiral galaxy with dust, stars, and central bulge
// Original by Fabrice Neyret (Shadertoy, Aug 2013)
// Ported with noise texture for gas/dust and stars

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;
uniform sampler2D u_noise;

// Audio inputs (declared for future wiring)
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

const float RETICULATION = 3.0;  // sharpness of dust wires
const float NB_ARMS = 5.0;
const float COMPR = 0.1;         // spiral arm compression
const float SPEED = 0.1;
const float GALAXY_R = 0.5;
const float BULB_R = 0.25;
const vec3 GALAXY_COL = vec3(0.9, 0.9, 1.0);
const vec3 BULB_COL = vec3(1.0, 0.8, 0.8);
const vec3 SKY_COL = 0.5 * vec3(0.1, 0.3, 0.5);

// Base noise from texture — "wires" mode (ridged)
float tex(vec2 uv) {
    float n = texture2D(u_noise, uv).r;
    return 1.0 - abs(2.0 * n - 1.0);
}

// Turbulent noise — 7 octaves with slow rotation
float noise(vec2 uv) {
    float v = 0.0;
    float a = -SPEED * u_time;
    float co = cos(a), si = sin(a);
    mat2 M = mat2(co, -si, si, co);
    float s = 1.0;
    for (int i = 0; i < 7; i++) {
        uv = M * uv;
        float b = tex(uv * s);
        v += 1.0 / s * pow(b, RETICULATION);
        s *= 2.0;
    }
    return v / 2.0;
}

void main() {
    // Center on screen, uniform scaling by height
    vec2 uv = gl_FragCoord.xy / u_resolution.y
            - vec2(u_resolution.x / u_resolution.y * 0.5, 0.5);

    // Polar coordinates
    float rho = length(uv);
    float ang = atan(uv.y, uv.x);

    // Logarithmic spiral shearing
    float shear = 2.0 * log(rho + 0.0001);
    float c = cos(shear), s = sin(shear);
    mat2 R = mat2(c, -s, s, c);

    // Galaxy profile — gaussian disk + central bulge
    float r;
    r = rho / GALAXY_R;
    float dens = exp(-r * r);
    r = rho / BULB_R;
    float bulb = exp(-r * r);

    // Spiral arm compression
    float phase = NB_ARMS * (ang - shear);
    ang = ang - COMPR * cos(phase) + SPEED * u_time;
    uv = rho * vec2(cos(ang), sin(ang));
    float spires = 1.0 + NB_ARMS * COMPR * sin(phase);
    dens *= 0.7 * spires;

    // Gas/dust texture
    float gaz = noise(0.09 * 1.2 * R * uv);
    float gaz_trsp = pow(1.0 - gaz * dens, 2.0);

    // Stars from noise texture (two layers at different offsets)
    float ratio = 0.8 * u_resolution.y / 256.0;
    float stars1 = texture2D(u_noise, ratio * uv + 0.5).r;
    float stars2 = texture2D(u_noise, ratio * uv + vec2(0.5, 0.73)).r;
    float stars = pow(1.0 - (1.0 - stars1) * (1.0 - stars2), 5.0);

    // Combine: sky -> galaxy gas + stars -> central bulge
    vec3 col = mix(SKY_COL,
                   gaz_trsp * (1.7 * GALAXY_COL) + 1.2 * stars,
                   dens);
    col = mix(col, 1.2 * BULB_COL, bulb);

    gl_FragColor = vec4(col, 1.0);
}
