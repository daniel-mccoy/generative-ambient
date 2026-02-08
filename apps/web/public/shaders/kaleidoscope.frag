#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;

// Audio inputs - OSC addresses /u_bass, /u_mid, /u_high
uniform float u_bass;
uniform float u_mid;
uniform float u_high;

// Per-instrument Csound channels (polled via getControlChannel)
uniform float u_bass_rms;     // Bass drone RMS (~0-0.5)
uniform float u_bass_cutoff;  // Bass drone filter cutoff (0-1)
uniform float u_pad_rms;      // Drone pad RMS (~0-0.3)
uniform float u_pad_pulse;    // Drone pad envelope (0-1)
uniform float u_swarm_rms;    // Swarm pad RMS (~0-0.3)
uniform float u_swarm_lfo;    // Swarm pad glacial LFO (0-1)
uniform float u_pluck_rms;    // Pluck transient RMS (~0-0.2)

const float TAU = 6.28318;
const float segments = 6.0;

vec3 palette(float t, float midShift) {
    // Warm palette with subtle mid-frequency color drift
    vec3 a = vec3(0.5, 0.4, 0.3);
    vec3 b = vec3(0.5, 0.4, 0.3);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.0, 0.1, 0.2) + midShift * vec3(0.05, 0.08, 0.1);
    return a + b * cos(TAU * (c * t + d));
}

float getPattern(vec2 fuv, float zr, float drift, float detail) {
    float p = sin(fuv.x * 10.0 + drift)
            * cos(fuv.y * 8.0 - drift * 0.7)
            + sin(zr * 6.0 - drift * 1.5);
    // High frequencies add subtle detail ripples
    p += detail * sin(fuv.x * 25.0 + fuv.y * 20.0 + drift * 2.0) * 0.15;
    return p * 0.25 + 0.5;
}

void main() {
    vec2 uv = (gl_FragCoord.xy - 0.5 * u_resolution.xy) / u_resolution.y;

    // Rotation: constant speed + swarm_lfo as additive angle offset
    float rotation = u_time * 0.1 + u_swarm_lfo * 0.3;
    uv = mat2(cos(rotation), -sin(rotation),
              sin(rotation), cos(rotation)) * uv;

    float angle = atan(uv.y, uv.x);
    float radius = length(uv);

    // Kaleidoscope fold
    float segmentAngle = TAU / segments;
    angle = mod(angle, segmentAngle);
    angle = min(angle, segmentAngle - angle);

    // Zoom: constant speed + bass_rms as additive depth offset
    float logRadius = log2(radius + 0.001) - u_time * 0.25 - u_bass_rms * 0.3;

    // Two-layer crossfade for seamless zoom
    float f1 = fract(logRadius);
    float f2 = fract(logRadius + 0.5);

    float zoomRadius1 = pow(2.0, f1);
    float zoomRadius2 = pow(2.0, f2);

    vec2 foldedUV1 = vec2(cos(angle), sin(angle)) * zoomRadius1;
    vec2 foldedUV2 = vec2(cos(angle), sin(angle)) * zoomRadius2;

    float drift = u_time * 0.2;
    // pluck_rms → detail flash on transients, swarm_rms → steady shimmer
    float detail = u_pluck_rms * 1.0 + u_swarm_rms * 1.5;
    float pattern1 = getPattern(foldedUV1, zoomRadius1, drift, detail);
    float pattern2 = getPattern(foldedUV2, zoomRadius2, drift, detail);

    float blend = smoothstep(0.0, 0.5, f1) * smoothstep(1.0, 0.5, f1);
    float pattern = mix(pattern2, pattern1, blend);

    // Hue shifts with mid frequencies + bass_cutoff warmth + swarm_lfo drift
    vec3 color = palette(pattern + radius * 0.3 + u_time * 0.05, u_mid * 0.06 + u_bass_cutoff * 0.15 + u_swarm_lfo * 0.12);

    // Vignette: pad_pulse breathes the visible area open/closed
    float vignetteOuter = 1.0 + u_pad_pulse * 0.15;
    float vignette = 1.0 - smoothstep(0.4, vignetteOuter, radius);
    color *= vignette;

    // Contrast: bass FFT + bass_rms for deeper punch
    float contrast = 1.0 + u_bass * 0.15 + u_bass_rms * 0.3;
    color = mix(vec3(0.5), color, contrast);

    // pad_rms → ambient brightness lift
    color += u_pad_rms * 0.3;

    // Highs + pluck_rms pulse the brightest areas
    float luminance = dot(color, vec3(0.299, 0.587, 0.114));
    float highlightMask = smoothstep(0.3, 0.6, luminance);
    color += highlightMask * u_pluck_rms * 1.0;

    // Deepen colors
    color = pow(color, vec3(1.2));

    gl_FragColor = vec4(color, 1.0);
}
