#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;
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

//-------------------------------------------------------------
// AURORA OCEAN — Northern lights reflected in dark water
//
// Sky:   triangle-wave noise aurora (after StillTravelling)
// Water: wave functions (after afl_ext) with aurora reflection
//-------------------------------------------------------------

// --- Aurora noise utilities ---

float tri(float x) {
    return clamp(abs(fract(x) - 0.5), 0.01, 0.49);
}
vec2 tri2(vec2 p) {
    return vec2(tri(p.x) + tri(p.y), tri(p.y + tri(p.x)));
}

mat2 rot2(float a) {
    float c = cos(a), s = sin(a);
    return mat2(c, s, -s, c);
}

float triNoise2d(vec2 p, float spd) {
    float z = 1.8;
    float z2 = 2.5;
    float rz = 0.0;
    p *= rot2(p.x * 0.06);
    vec2 bp = p;
    for (int i = 0; i < 5; i++) {
        vec2 dg = tri2(bp * 1.85) * 0.75;
        dg *= rot2(u_time * spd);
        p -= dg / z2;
        bp *= 1.3;
        z2 *= 0.45;
        z *= 0.42;
        p *= 1.21 + (rz - 1.0) * 0.02;
        rz += tri(p.x + tri(p.y)) * z;
        p *= -mat2(0.95534, 0.29552, -0.29552, 0.95534);
    }
    return clamp(1.0 / pow(rz * 29.0, 1.3), 0.0, 0.55);
}

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

// --- Stars ---

float starLayer(vec2 uv) {
    vec2 id = floor(uv);
    vec2 f = fract(uv);
    float rnd = hash(id);
    float star = 0.0;
    if (rnd > 0.97) {
        vec2 center = vec2(fract(rnd * 91.7), fract(rnd * 127.3)) * 0.7 + 0.15;
        float d = length(f - center);
        float twinkle = sin(u_time * (1.5 + rnd * 3.0) + rnd * 6.283) * 0.4 + 0.6;
        star = smoothstep(0.04, 0.0, d) * twinkle * (0.4 + rnd * 0.6);
    }
    return star;
}

// --- Ocean waves (simplified from ocean.frag) ---

#define WAVE_DRAG 0.38
#define WAVE_ITER 32

vec2 wavedx(vec2 position, vec2 direction, float frequency, float timeshift) {
    float x = dot(direction, position) * frequency + timeshift;
    float wave = exp(sin(x) - 1.0);
    float dx = wave * cos(x);
    return vec2(wave, -dx);
}

float getwaves(vec2 position, float speedMul) {
    float wavePhaseShift = length(position) * 0.1;
    float iter = 0.0;
    float frequency = 1.0;
    float timeMultiplier = 2.0;
    float weight = 1.0;
    float sumOfValues = 0.0;
    float sumOfWeights = 0.0;
    for (int i = 0; i < WAVE_ITER; i++) {
        vec2 d = vec2(sin(iter), cos(iter));
        vec2 res = wavedx(position, d, frequency,
                          u_time * timeMultiplier * speedMul + wavePhaseShift);
        position += d * res.y * weight * WAVE_DRAG;
        sumOfValues += res.x * weight;
        sumOfWeights += weight;
        weight = mix(weight, 0.0, 0.2);
        frequency *= 1.18;
        timeMultiplier *= 1.07;
        iter += 1232.399963;
    }
    return sumOfValues / sumOfWeights;
}

// --- Main ---

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
    vec2 p = uv * 2.0 - 1.0;
    float aspect = u_resolution.x / u_resolution.y;
    p.x *= aspect;

    // --- Audio-reactive parameters ---
    float intensity  = 0.9 + u_bass_rms * 4.0 + u_pad_pulse * 0.6;
    float speed      = 0.04 + u_mid * 0.08;
    float spread     = 1.0 + u_pad_rms * 1.5;
    float warmth     = u_bass_cutoff;
    float shimmer    = 0.6 + u_swarm_rms * 1.5;
    float hueDrift   = u_swarm_lfo * 0.4;
    float flash      = u_pluck_rms * 6.0;
    float brightness = 0.7 + u_bass * 0.5 + u_high * 0.3;
    float waveSpeed  = 1.0 + u_bass * 0.4;

    // --- Horizon ---
    float horizonUV = 0.52;
    float horizonP  = horizonUV * 2.0 - 1.0;
    bool isSky = uv.y >= horizonUV;

    // --- Water: compute wave normal + reflected aurora sample point ---
    vec2 ap = p;
    float depthFade = 0.0;
    float fresnel   = 0.0;
    float waveSurf  = 0.0;
    vec3 wNorm      = vec3(0.0, 1.0, 0.0);

    if (!isSky) {
        depthFade = clamp((horizonUV - uv.y) / horizonUV, 0.0, 1.0);

        // Perspective-mapped water position
        float perspDist = 0.3 / max(0.005, horizonUV - uv.y);
        vec2 waterPos = vec2(
            p.x * perspDist * 0.3,
            perspDist * 0.5 + u_time * 0.08
        );

        // Wave height + finite-difference normal
        float e   = 0.05;
        float wH  = getwaves(waterPos, waveSpeed);
        float wHx = getwaves(waterPos + vec2(e, 0.0), waveSpeed);
        float wHy = getwaves(waterPos + vec2(0.0, e), waveSpeed);
        waveSurf = wH;
        wNorm = normalize(vec3(wH - wHx, e * 0.5, wH - wHy));

        // Mirror p across horizon + perturb with wave normal
        ap.y = -p.y + 2.0 * horizonP;
        ap.x += wNorm.x * 0.15 * (1.0 + depthFade);
        ap.y += wNorm.z * 0.1;

        // Fresnel: stronger reflection at grazing angle (near horizon)
        float viewAngle = 1.0 - depthFade;
        fresnel = 0.04 + 0.96 * pow(viewAngle, 5.0);
    }

    // --- Aurora accumulation (once per pixel, using ap) ---
    vec3 rd = normalize(vec3(ap.x, ap.y * spread + 0.15, -1.0));
    rd.y += 0.08;
    rd.z -= 0.3;
    float tilt = -0.25;
    float ct = cos(tilt), st = sin(tilt);
    float tmp = rd.y;
    rd.y = ct * tmp - st * rd.z;
    rd.z = st * tmp + ct * rd.z;

    vec4 col = vec4(0.0);
    vec4 avgCol = vec4(0.0);

    vec3 colorBase = vec3(
        2.15 - warmth * 1.5 + hueDrift,
        -1.0 + warmth * 1.5,
        1.0 - warmth * 0.5
    );

    #define AURORA_STEPS 25
    for (int i = 0; i < AURORA_STEPS; i++) {
        float fi = float(i);
        float jitter = 0.006 * hash(gl_FragCoord.xy) * smoothstep(0.0, 15.0, fi);
        float pt = (0.8 + pow(fi, 1.4) * 0.002) / (rd.y * 2.0 + 0.4);
        pt -= jitter;
        vec3 bpos = vec3(0.0, 0.0, -6.7) + pt * rd;
        vec2 samplePos = bpos.zx + sin(u_time * 0.01);
        float n = triNoise2d(samplePos, speed * shimmer);
        vec3 layerColor = sin(1.0 - colorBase + fi * 0.043) * 0.5 + 0.5;
        vec4 layerCol = vec4(layerColor * n, n);
        avgCol = mix(avgCol, layerCol, 0.5);
        col += avgCol * exp2(-fi * 0.065 - 2.5) * smoothstep(0.0, 5.0, fi);
    }

    col *= clamp(rd.y * 15.0 + 0.4, 0.0, 1.0);
    col *= intensity * brightness;
    col.rgb += col.rgb * flash;

    // --- Compose sky or water ---
    vec3 final_color;

    if (isSky) {
        // Sky gradient
        float skyT = (uv.y - horizonUV) / (1.0 - horizonUV);
        vec3 bg = mix(vec3(0.01, 0.005, 0.02), vec3(0.0, 0.015, 0.045), skyT);

        // Stars
        float stars = 0.0;
        stars += starLayer(p * 12.0);
        stars += starLayer(p * 20.0 + 73.1) * 0.7;
        stars += starLayer(p * 35.0 + 191.7) * 0.4;
        float auroraLum = dot(col.rgb, vec3(0.2, 0.7, 0.1));
        stars *= smoothstep(0.15, 0.0, auroraLum);
        stars *= smoothstep(horizonUV + 0.01, horizonUV + 0.12, uv.y);
        bg += vec3(0.9, 0.92, 1.0) * stars;

        // Horizon glow (sky side)
        float hGlow = exp(-(uv.y - horizonUV) * 18.0) * 0.08;
        vec3 hColor = mix(vec3(0.0, 0.08, 0.12), vec3(0.06, 0.03, 0.08), warmth);
        bg += hColor * hGlow * intensity;

        final_color = bg + col.rgb;
    } else {
        // Dark water base
        vec3 waterBase = mix(
            vec3(0.006, 0.02, 0.035),   // shallow (near horizon)
            vec3(0.002, 0.008, 0.018),   // deep (bottom)
            depthFade
        );

        // Aurora reflection weighted by Fresnel
        vec3 reflection = col.rgb * fresnel;

        // Wave crest highlights tinted with aurora
        float crest = smoothstep(0.35, 0.6, waveSurf);
        float highlight = crest * (1.0 - depthFade * 0.7) * 0.03;
        vec3 highlightCol = mix(vec3(0.5, 0.7, 0.8), col.rgb * 0.3 + 0.05, 0.5);

        // Subsurface scattering — faint blue-green glow
        vec3 sss = vec3(0.01, 0.025, 0.04) * (1.0 - depthFade) * 0.3;

        // Horizon glow (water side)
        float hGlow = exp(-(horizonUV - uv.y) * 14.0) * 0.06;
        vec3 hColor = mix(vec3(0.0, 0.08, 0.12), vec3(0.06, 0.03, 0.08), warmth);

        final_color = waterBase + reflection + highlightCol * highlight + sss;
        final_color += hColor * hGlow * intensity;
    }

    // Vignette
    vec2 vc = (uv - 0.5) * vec2(aspect, 1.0);
    float vig = 1.0 - 0.35 * dot(vc, vc);
    final_color *= vig;

    // Gamma
    final_color = pow(final_color, vec3(1.0 / 2.2));

    gl_FragColor = vec4(final_color, 1.0);
}
