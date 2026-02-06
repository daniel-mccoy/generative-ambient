// Ambient Embers - Slow drifting particle shader with audio reactivity
// Ported from Shadertoy fire particles by Jan Mróz (jaszunio15), CC BY 3.0
// Re-tuned for ambient/generative music visualization

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;

// Audio inputs (0.0 - 1.0 from AnalysisGrabber envelope followers)
// Configure AnalysisGrabber to send to /u_bass, /u_mid, /u_high
uniform float u_bass;
uniform float u_mid;
uniform float u_high;

#define PI 3.1415927
#define TWO_PI 6.283185

// --- Tuning constants (ambient embers) ---
#define ANIMATION_SPEED 0.5
#define MOVEMENT_SPEED 0.25
#define MOVEMENT_DIRECTION vec2(0.3, -0.4)

#define PARTICLE_SIZE 0.012

#define PARTICLE_SCALE (vec2(0.5, 1.6))
#define PARTICLE_SCALE_VAR (vec2(0.25, 0.2))

#define PARTICLE_BLOOM_SCALE (vec2(0.5, 0.8))
#define PARTICLE_BLOOM_SCALE_VAR (vec2(0.3, 0.1))

// Deep warm ember colors (subdued from original fire)
#define SPARK_COLOR vec3(1.0, 0.6, 0.25) * 1.2
#define BLOOM_COLOR vec3(0.9, 0.5, 0.2) * 0.5
#define SMOKE_COLOR vec3(0.6, 0.3, 0.15) * 0.7

#define SIZE_MOD 1.05
#define ALPHA_MOD 0.9
#define LAYERS_COUNT 12

// --- Hash functions ---

float hash1_2(in vec2 x) {
    return fract(sin(dot(x, vec2(52.127, 61.2871))) * 521.582);
}

vec2 hash2_2(in vec2 x) {
    return fract(sin(x * mat2(20.52, 24.1994, 70.291, 80.171)) * 492.194);
}

// --- Interpolated noise ---

vec2 noise2_2(vec2 uv) {
    vec2 f = smoothstep(0.0, 1.0, fract(uv));

    vec2 uv00 = floor(uv);
    vec2 uv01 = uv00 + vec2(0, 1);
    vec2 uv10 = uv00 + vec2(1, 0);
    vec2 uv11 = uv00 + 1.0;
    vec2 v00 = hash2_2(uv00);
    vec2 v01 = hash2_2(uv01);
    vec2 v10 = hash2_2(uv10);
    vec2 v11 = hash2_2(uv11);

    vec2 v0 = mix(v00, v01, f.y);
    vec2 v1 = mix(v10, v11, f.y);
    vec2 v = mix(v0, v1, f.x);

    return v;
}

float noise1_2(in vec2 uv) {
    vec2 f = fract(uv);

    vec2 uv00 = floor(uv);
    vec2 uv01 = uv00 + vec2(0, 1);
    vec2 uv10 = uv00 + vec2(1, 0);
    vec2 uv11 = uv00 + 1.0;

    float v00 = hash1_2(uv00);
    float v01 = hash1_2(uv01);
    float v10 = hash1_2(uv10);
    float v11 = hash1_2(uv11);

    float v0 = mix(v00, v01, f.y);
    float v1 = mix(v10, v11, f.y);
    float v = mix(v0, v1, f.x);

    return v;
}

// --- Layered noise for smoke ---

float layeredNoise1_2(in vec2 uv, in float sizeMod, in float alphaMod, in int layers, in float animation) {
    float noise = 0.0;
    float alpha = 1.0;
    float size = 1.0;
    vec2 offset;
    // Audio: high frequencies add gentle drift variation
    float movementSpeed = MOVEMENT_SPEED + u_high * 0.05;
    for (int i = 0; i < layers; i++) {
        offset += hash2_2(vec2(alpha, size)) * 10.0;
        noise += noise1_2(uv * size + u_time * animation * 8.0 * MOVEMENT_DIRECTION * movementSpeed + offset) * alpha;
        alpha *= alphaMod;
        size *= sizeMod;
    }
    noise *= (1.0 - alphaMod) / (1.0 - pow(alphaMod, float(layers)));
    return noise;
}

// --- Rotation ---

vec2 rotate(in vec2 point, in float deg) {
    float s = sin(deg);
    float c = cos(deg);
    return mat2(s, c, -c, s) * point;
}

// --- Voronoi helpers ---

vec2 voronoiPointFromRoot(in vec2 root, in float deg) {
    vec2 point = hash2_2(root) - 0.5;
    float s = sin(deg);
    float c = cos(deg);
    point = mat2(s, c, -c, s) * point * 0.66;
    point += root + 0.5;
    return point;
}

float degFromRootUV(in vec2 uv) {
    return u_time * ANIMATION_SPEED * (hash1_2(uv) - 0.5) * 2.0;
}

vec2 randomAround2_2(in vec2 point, in vec2 range, in vec2 uv) {
    return point + (hash2_2(uv) - 0.5) * range;
}

// --- Fire particle rendering ---

vec3 fireParticles(in vec2 uv, in vec2 originalUV) {
    vec3 particles = vec3(0.0);
    vec2 rootUV = floor(uv);
    float deg = degFromRootUV(rootUV);
    vec2 pointUV = voronoiPointFromRoot(rootUV, deg);
    float dist = 2.0;
    float distBloom = 0.0;

    // UV manipulation for subtle particle movement
    vec2 tempUV = uv + (noise2_2(uv * 2.0) - 0.5) * 0.1;
    tempUV += -(noise2_2(uv * 3.0 + u_time) - 0.5) * 0.07;

    // Audio: mid frequencies gently expand particle size
    float particleSize = PARTICLE_SIZE + u_mid * 0.003;

    // Sparks sdf
    dist = length(rotate(tempUV - pointUV, 0.7) * randomAround2_2(PARTICLE_SCALE, PARTICLE_SCALE_VAR, rootUV));

    // Bloom sdf
    distBloom = length(rotate(tempUV - pointUV, 0.7) * randomAround2_2(PARTICLE_BLOOM_SCALE, PARTICLE_BLOOM_SCALE_VAR, rootUV));

    // Audio: high frequencies add subtle sparkle to spark brightness
    vec3 sparkColor = SPARK_COLOR * (0.8 + u_high * 0.4);

    // Audio: mid-frequency color warmth shift
    // Positive u_mid pushes toward warmer (more red/orange), low u_mid cools slightly
    vec3 warmShift = vec3(0.15, -0.05, -0.1) * u_mid;
    sparkColor += warmShift;

    // Add sparks
    particles += (1.0 - smoothstep(particleSize * 0.6, particleSize * 3.0, dist)) * sparkColor;

    // Audio: bass gently increases bloom glow
    vec3 bloomColor = (BLOOM_COLOR + warmShift * 0.5) * (0.5 + u_bass * 0.6);

    // Add bloom
    particles += pow((1.0 - smoothstep(0.0, particleSize * 6.0, distBloom)) * 1.0, 3.0) * bloomColor;

    // Upper disappear curve randomization
    float border = (hash1_2(rootUV) - 0.5) * 2.0;
    float disappear = 1.0 - smoothstep(border, border + 0.5, originalUV.y);

    // Lower appear curve randomization
    border = (hash1_2(rootUV + 0.214) - 1.8) * 0.7;
    float appear = smoothstep(border, border + 0.4, originalUV.y);

    return particles * disappear * appear;
}

// --- Layered particles for depth ---

vec3 layeredParticles(in vec2 uv, in float sizeMod, in float alphaMod, in int layers, in float smoke) {
    vec3 particles = vec3(0);
    float size = 1.0;
    float alpha = 1.0;
    vec2 offset = vec2(0.0);
    vec2 noiseOffset;
    vec2 bokehUV;

    // Audio: high frequencies add gentle drift variation
    float movementSpeed = MOVEMENT_SPEED + u_high * 0.05;

    for (int i = 0; i < layers; i++) {
        // Particle noise movement
        noiseOffset = (noise2_2(uv * size * 2.0 + 0.5) - 0.5) * 0.15;

        // UV with applied movement
        bokehUV = (uv * size + u_time * MOVEMENT_DIRECTION * movementSpeed) + offset + noiseOffset;

        // Adding particles — if there is more smoke, remove smaller particles
        particles += fireParticles(bokehUV, uv) * alpha * (1.0 - smoothstep(0.0, 1.0, smoke) * (float(i) / float(layers)));

        // Moving uv origin to avoid generating the same particles
        offset += hash2_2(vec2(alpha, alpha)) * 10.0;

        alpha *= alphaMod;
        size *= sizeMod;
    }

    return particles;
}

// --- Main ---

void main() {
    vec2 uv = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.x;

    float vignette = 1.0 - smoothstep(0.4, 1.4, length(uv + vec2(0.0, 0.3)));

    uv *= 1.8;

    // Audio: high frequencies add gentle drift variation
    float movementSpeed = MOVEMENT_SPEED + u_high * 0.05;

    float smokeIntensity = layeredNoise1_2(uv * 10.0 + u_time * 4.0 * MOVEMENT_DIRECTION * movementSpeed, 1.7, 0.7, 6, 0.2);
    smokeIntensity *= pow(1.0 - smoothstep(-1.0, 1.6, uv.y), 2.0);

    // Audio: bass swells thicken the atmosphere
    vec3 smoke = smokeIntensity * SMOKE_COLOR * 0.8 * vignette * (0.8 + u_bass * 0.5);

    // Cutting holes in smoke
    smoke *= pow(layeredNoise1_2(uv * 4.0 + u_time * 0.5 * MOVEMENT_DIRECTION * movementSpeed, 1.8, 0.5, 3, 0.2), 2.0) * 1.5;

    vec3 particles = layeredParticles(uv, SIZE_MOD, ALPHA_MOD, LAYERS_COUNT, smokeIntensity);

    vec3 col = particles + smoke + SMOKE_COLOR * 0.02;
    col *= vignette;

    col = smoothstep(-0.08, 1.0, col);

    gl_FragColor = vec4(col, 1.0);
}
