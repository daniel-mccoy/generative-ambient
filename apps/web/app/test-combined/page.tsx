"use client";

import { useState, useRef, useEffect, useCallback } from "react";

// Only shaders that have audio-reactive uniforms (u_bass, u_mid, u_high)
const SHADER_FILES = [
  { name: "kaleidoscope.frag", label: "Kaleidoscope" },
  { name: "mandala.frag", label: "Morphing Mandala" },
  { name: "embers.frag", label: "Ambient Embers" },
  { name: "rocaille.frag", label: "Rocaille" },
  { name: "ocean.frag", label: "Ocean" },
  { name: "galaxy.frag", label: "Galaxy" },
  { name: "aurora.frag", label: "Aurora Borealis" },
];

const CSD_FILES: Array<{
  name: string;
  label: string;
  samples?: Array<{ url: string; filename: string }>;
}> = [
  { name: "deep_focus.csd", label: "Deep Focus (Full Composition)" },
  { name: "deep_focus_bass.csd", label: "Deep Focus — Bass Drone" },
  { name: "deep_focus_pad.csd", label: "Deep Focus — Drone Pad" },
  { name: "deep_focus_swarm.csd", label: "Deep Focus — Swarm Pad" },
  { name: "deep_focus_pluck.csd", label: "Deep Focus — Pluck Sequencer" },
  {
    name: "ocean_waves.csd",
    label: "Ocean Waves",
    samples: [
      { url: "/samples/ocean-roar.wav", filename: "ocean-roar.wav" },
    ],
  },
  {
    name: "aurora_ocean.csd",
    label: "Aurora Ocean",
    samples: [
      { url: "/samples/ocean-roar.wav", filename: "ocean-roar.wav" },
      { url: "/samples/padsynth-a.wav", filename: "padsynth-a.wav" },
      { url: "/samples/padsynth-b.wav", filename: "padsynth-b.wav" },
    ],
  },
  {
    name: "stellar_drift.csd",
    label: "Stellar Drift",
    samples: [
      { url: "/samples/padsynth-export-a.wav", filename: "padsynth-export-a.wav" },
      { url: "/samples/padsynth-export-b.wav", filename: "padsynth-export-b.wav" },
    ],
  },
];

const VERTEX_SHADER = `
attribute vec2 a_position;
void main() {
  gl_Position = vec4(a_position, 0.0, 1.0);
}
`;

// Frequency band bin ranges (at 44100 Hz, fftSize=2048, each bin ≈ 21.5 Hz)
// Tuned for dark, filtered voices: drone (C2-C3) + pluck (C2-C5, 24dB LP @ 313-2500 Hz)
const BASS_LOW = 1;
const BASS_HIGH = 6; // ~20-130 Hz — drone fundamentals
const MID_LOW = 6;
const MID_HIGH = 28; // ~130-600 Hz — drone harmonics + pluck fundamentals
const HIGH_LOW = 28;
const HIGH_HIGH = 116; // ~600-2500 Hz — pluck filter sweep + upper harmonics

function averageBand(data: Uint8Array<ArrayBuffer>, lo: number, hi: number): number {
  let sum = 0;
  const end = Math.min(hi, data.length);
  for (let i = lo; i < end; i++) {
    sum += data[i];
  }
  return sum / ((end - lo) * 255);
}

export default function TestCombinedPage() {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const glRef = useRef<WebGLRenderingContext | null>(null);
  const programRef = useRef<WebGLProgram | null>(null);
  const rafRef = useRef<number>(0);
  const startTimeRef = useRef<number>(0);

  // Audio analysis refs (not state — updated every frame)
  const analyserRef = useRef<AnalyserNode | null>(null);
  const freqDataRef = useRef<Uint8Array<ArrayBuffer> | null>(null);
  const bassRef = useRef(0);
  const midRef = useRef(0);
  const highRef = useRef(0);
  const debugRef = useRef<HTMLDivElement>(null);

  // Uniform locations for audio (stored per-program)
  const uBassRef = useRef<WebGLUniformLocation | null>(null);
  const uMidRef = useRef<WebGLUniformLocation | null>(null);
  const uHighRef = useRef<WebGLUniformLocation | null>(null);

  // Per-instrument Csound channel values (polled non-blocking)
  const CSOUND_CHANNELS = [
    "bass_rms", "bass_cutoff", "pad_rms", "pad_pulse",
    "swarm_rms", "swarm_lfo", "pluck_rms",
  ] as const;
  const channelRefs = useRef<Record<string, number>>(
    Object.fromEntries(CSOUND_CHANNELS.map((n) => [n, 0])),
  );

  // Uniform locations for per-instrument channels
  const uChannelRefs = useRef<Record<string, WebGLUniformLocation | null>>(
    Object.fromEntries(CSOUND_CHANNELS.map((n) => [n, null])),
  );

  // Noise texture for shaders that need sampler2D (galaxy, etc.)
  const noiseTextureRef = useRef<WebGLTexture | null>(null);

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const csoundRef = useRef<any>(null);

  const [selectedShader, setSelectedShader] = useState(SHADER_FILES[0].name);
  const [selectedCsd, setSelectedCsd] = useState(CSD_FILES[0].name);
  const [status, setStatus] = useState("Ready");
  const [playing, setPlaying] = useState(false);
  const [showUI, setShowUI] = useState(true);

  // Smoothing factor for exponential smoothing on top of AnalyserNode
  const SMOOTH = 0.3;

  // --- WebGL helpers ---

  const compileShader = useCallback(
    (gl: WebGLRenderingContext, type: number, source: string): WebGLShader | null => {
      const shader = gl.createShader(type);
      if (!shader) return null;
      gl.shaderSource(shader, source);
      gl.compileShader(shader);
      if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
        const log = gl.getShaderInfoLog(shader);
        setStatus(`Shader compile error: ${log}`);
        console.error("Shader compile error:", log);
        gl.deleteShader(shader);
        return null;
      }
      return shader;
    },
    [],
  );

  const buildProgram = useCallback(
    async (gl: WebGLRenderingContext, shaderName: string): Promise<WebGLProgram | null> => {
      const res = await fetch(`/shaders/${shaderName}`);
      if (!res.ok) {
        setStatus(`Error: Failed to fetch ${shaderName} (${res.status})`);
        return null;
      }
      const fragSource = await res.text();

      const vertShader = compileShader(gl, gl.VERTEX_SHADER, VERTEX_SHADER);
      const fragShader = compileShader(gl, gl.FRAGMENT_SHADER, fragSource);
      if (!vertShader || !fragShader) return null;

      const program = gl.createProgram();
      if (!program) {
        setStatus("Error: Failed to create program");
        return null;
      }
      gl.attachShader(program, vertShader);
      gl.attachShader(program, fragShader);
      gl.linkProgram(program);

      if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
        setStatus(`Link error: ${gl.getProgramInfoLog(program)}`);
        gl.deleteProgram(program);
        return null;
      }

      gl.deleteShader(vertShader);
      gl.deleteShader(fragShader);

      return program;
    },
    [compileShader],
  );

  // --- Render loop ---

  const startRenderLoop = useCallback(
    (gl: WebGLRenderingContext, program: WebGLProgram) => {
      gl.useProgram(program);

      // Bind vertex attribute
      const posLoc = gl.getAttribLocation(program, "a_position");
      gl.enableVertexAttribArray(posLoc);
      gl.vertexAttribPointer(posLoc, 2, gl.FLOAT, false, 0, 0);

      // Standard uniform locations
      const uResolution = gl.getUniformLocation(program, "u_resolution");
      const uTime = gl.getUniformLocation(program, "u_time");
      const uMouse = gl.getUniformLocation(program, "u_mouse");

      // Audio uniform locations (null if shader doesn't have them — gl.uniform1f with null is a no-op)
      uBassRef.current = gl.getUniformLocation(program, "u_bass");
      uMidRef.current = gl.getUniformLocation(program, "u_mid");
      uHighRef.current = gl.getUniformLocation(program, "u_high");

      // Per-instrument channel uniform locations
      for (const name of CSOUND_CHANNELS) {
        uChannelRefs.current[name] = gl.getUniformLocation(program, `u_${name}`);
      }

      // Noise texture uniform (null if shader doesn't declare u_noise)
      const uNoise = gl.getUniformLocation(program, "u_noise");
      if (uNoise && noiseTextureRef.current) {
        gl.activeTexture(gl.TEXTURE0);
        gl.bindTexture(gl.TEXTURE_2D, noiseTextureRef.current);
        gl.uniform1i(uNoise, 0);
      }

      startTimeRef.current = performance.now() / 1000;

      const canvas = canvasRef.current!;

      const render = () => {
        // Resize to fill window
        const dpr = window.devicePixelRatio || 1;
        const width = window.innerWidth;
        const height = window.innerHeight;
        if (canvas.width !== width * dpr || canvas.height !== height * dpr) {
          canvas.width = width * dpr;
          canvas.height = height * dpr;
          canvas.style.width = width + "px";
          canvas.style.height = height + "px";
          gl.viewport(0, 0, canvas.width, canvas.height);
        }

        // Audio analysis — synchronous, no awaits
        const analyser = analyserRef.current;
        const freqData = freqDataRef.current;
        if (analyser && freqData) {
          analyser.getByteFrequencyData(freqData);
          const rawBass = averageBand(freqData, BASS_LOW, BASS_HIGH);
          const rawMid = averageBand(freqData, MID_LOW, MID_HIGH);
          const rawHigh = averageBand(freqData, HIGH_LOW, HIGH_HIGH);
          // Exponential smoothing
          bassRef.current += (rawBass - bassRef.current) * SMOOTH;
          midRef.current += (rawMid - midRef.current) * SMOOTH;
          highRef.current += (rawHigh - highRef.current) * SMOOTH;
        }

        // Non-blocking poll of per-instrument Csound channels
        const cs = csoundRef.current;
        if (cs) {
          Promise.all(CSOUND_CHANNELS.map((name) => cs.getControlChannel(name)))
            .then((values: number[]) => {
              for (let i = 0; i < CSOUND_CHANNELS.length; i++) {
                channelRefs.current[CSOUND_CHANNELS[i]] = values[i] || 0;
              }
            })
            .catch(() => {
              // Ignore errors (e.g. after stop)
            });
        }

        // Update debug display via direct DOM manipulation (no React re-render)
        if (debugRef.current) {
          const ch = channelRefs.current;
          debugRef.current.textContent =
            `Bass: ${bassRef.current.toFixed(3)}  Mid: ${midRef.current.toFixed(3)}  High: ${highRef.current.toFixed(3)}\n` +
            `bass_rms: ${ch.bass_rms.toFixed(3)}  bass_cut: ${ch.bass_cutoff.toFixed(3)}  pad_rms: ${ch.pad_rms.toFixed(3)}  pad_pulse: ${ch.pad_pulse.toFixed(3)}\n` +
            `swarm_rms: ${ch.swarm_rms.toFixed(3)}  swarm_lfo: ${ch.swarm_lfo.toFixed(3)}  pluck_rms: ${ch.pluck_rms.toFixed(3)}`;
        }

        const time = performance.now() / 1000 - startTimeRef.current;

        gl.uniform2f(uResolution, canvas.width, canvas.height);
        gl.uniform1f(uTime, time);
        gl.uniform2f(uMouse, 0, 0);

        // Set audio uniforms (safe no-op if location is null)
        gl.uniform1f(uBassRef.current, bassRef.current);
        gl.uniform1f(uMidRef.current, midRef.current);
        gl.uniform1f(uHighRef.current, highRef.current);

        // Set per-instrument channel uniforms (1-2 frame lag, imperceptible)
        for (const name of CSOUND_CHANNELS) {
          gl.uniform1f(uChannelRefs.current[name], channelRefs.current[name]);
        }

        gl.drawArrays(gl.TRIANGLES, 0, 6);
        rafRef.current = requestAnimationFrame(render);
      };

      rafRef.current = requestAnimationFrame(render);
    },
    [],
  );

  // --- Init WebGL context (once) ---

  const ensureGL = useCallback((): WebGLRenderingContext | null => {
    if (glRef.current) return glRef.current;

    const canvas = canvasRef.current;
    if (!canvas) return null;

    const gl = canvas.getContext("webgl", { antialias: false, alpha: false });
    if (!gl) {
      setStatus("Error: WebGL not supported");
      return null;
    }
    glRef.current = gl;

    // Set up full-screen quad
    const buffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, buffer);
    gl.bufferData(
      gl.ARRAY_BUFFER,
      new Float32Array([-1, -1, 1, -1, -1, 1, -1, 1, 1, -1, 1, 1]),
      gl.STATIC_DRAW,
    );

    // Create 256x256 noise texture (used by galaxy, etc.)
    if (!noiseTextureRef.current) {
      const tex = gl.createTexture();
      if (tex) {
        const size = 256;
        const data = new Uint8Array(size * size);
        for (let i = 0; i < data.length; i++) {
          data[i] = Math.floor(Math.random() * 256);
        }
        gl.bindTexture(gl.TEXTURE_2D, tex);
        gl.texImage2D(gl.TEXTURE_2D, 0, gl.LUMINANCE, size, size, 0, gl.LUMINANCE, gl.UNSIGNED_BYTE, data);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
        gl.bindTexture(gl.TEXTURE_2D, null);
        noiseTextureRef.current = tex;
      }
    }

    return gl;
  }, []);

  // --- Start/switch shader (does NOT touch Csound/AnalyserNode) ---

  const loadShader = useCallback(
    async (shaderName: string) => {
      // Stop current render loop
      if (rafRef.current) {
        cancelAnimationFrame(rafRef.current);
        rafRef.current = 0;
      }

      const gl = ensureGL();
      if (!gl) return;

      // Clean up old program
      if (programRef.current) {
        gl.deleteProgram(programRef.current);
        programRef.current = null;
      }

      setStatus(`Loading shader: ${shaderName}...`);
      const program = await buildProgram(gl, shaderName);
      if (!program) return;

      programRef.current = program;
      startRenderLoop(gl, program);
      setStatus(playing ? `Playing audio + ${shaderName}` : `Shader: ${shaderName}`);
    },
    [ensureGL, buildProgram, startRenderLoop, playing],
  );

  // --- Csound lifecycle ---

  const handlePlay = useCallback(async () => {
    try {
      setStatus("Loading @csound/browser...");
      const { Csound } = await import("@csound/browser");

      // Clean up previous instance
      if (csoundRef.current) {
        try {
          await csoundRef.current.stop();
          await csoundRef.current.terminateInstance();
        } catch {
          // ignore cleanup errors
        }
        csoundRef.current = null;
        analyserRef.current = null;
        freqDataRef.current = null;
      }

      setStatus("Initializing Csound...");
      const csound = await Csound();
      if (!csound) {
        setStatus("Error: Csound failed to initialize");
        return;
      }
      csoundRef.current = csound;

      // Listen for natural end of performance
      csound.on("realtimePerformanceEnded", () => {
        setPlaying(false);
        // Don't null out csound yet — let stop handler do cleanup
        // Audio levels will naturally decay to 0 via smoothing
        setStatus(`Performance ended — shader continues`);
      });

      setStatus(`Fetching /csound/${selectedCsd}...`);
      const res = await fetch(`/csound/${selectedCsd}`);
      if (!res.ok) {
        setStatus(`Error: Failed to fetch ${selectedCsd} (${res.status})`);
        return;
      }
      const csdText = await res.text();

      // Load samples into Csound virtual filesystem before compilation
      const csdEntry = CSD_FILES.find((c) => c.name === selectedCsd);
      if (csdEntry?.samples && csound.fs) {
        for (const sample of csdEntry.samples) {
          setStatus(`Loading sample: ${sample.filename}...`);
          try {
            const sampleRes = await fetch(sample.url);
            if (!sampleRes.ok) {
              setStatus(`Error: Failed to fetch sample ${sample.url} (${sampleRes.status})`);
              return;
            }
            const buf = await sampleRes.arrayBuffer();
            await csound.fs.writeFile(sample.filename, new Uint8Array(buf));
          } catch (e) {
            setStatus(`Error loading sample ${sample.filename}: ${e}`);
            return;
          }
        }
      }

      setStatus("Compiling CSD...");
      const result = await csound.compileCSD(csdText, 1);
      if (result !== 0) {
        setStatus("Error: CSD compilation failed (check console)");
        return;
      }

      setStatus("Starting playback...");
      await csound.start();

      // --- Set up AnalyserNode tap ---
      const audioContext = await csound.getAudioContext();
      const csoundNode = await csound.getNode();

      if (audioContext && csoundNode) {
        const analyser = audioContext.createAnalyser();
        analyser.fftSize = 2048;
        analyser.smoothingTimeConstant = 0.8;

        // Parallel tap: Csound node already connects to destination (speakers)
        // We add a second connection to the analyser for analysis only
        csoundNode.connect(analyser);

        analyserRef.current = analyser;
        freqDataRef.current = new Uint8Array(analyser.frequencyBinCount);
      }

      setPlaying(true);
      setStatus(`Playing: ${selectedCsd} + ${selectedShader}`);
    } catch (err) {
      setStatus(`Error: ${err instanceof Error ? err.message : String(err)}`);
      console.error("Csound error:", err);
    }
  }, [selectedCsd, selectedShader]);

  const handleStop = useCallback(async () => {
    const csound = csoundRef.current;
    if (!csound) return;
    csoundRef.current = null;
    analyserRef.current = null;
    freqDataRef.current = null;

    // Reset audio levels
    bassRef.current = 0;
    midRef.current = 0;
    highRef.current = 0;
    for (const name of CSOUND_CHANNELS) {
      channelRefs.current[name] = 0;
    }

    try {
      setStatus("Stopping...");
      await csound.stop();
      await csound.terminateInstance();
      setPlaying(false);
      setStatus(`Stopped — shader: ${selectedShader}`);
    } catch (err) {
      setStatus(`Stop error: ${err instanceof Error ? err.message : String(err)}`);
      console.error("Csound stop error:", err);
    }
  }, [selectedShader]);

  // --- Load initial shader on mount ---

  useEffect(() => {
    loadShader(selectedShader);
    return () => {
      if (rafRef.current) {
        cancelAnimationFrame(rafRef.current);
        rafRef.current = 0;
      }
    };
    // Only run on mount
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // --- Shader switching handler ---

  const handleShaderChange = (name: string) => {
    setSelectedShader(name);
    loadShader(name);
  };

  return (
    <>
      <canvas
        ref={canvasRef}
        className="fixed inset-0 w-full h-full"
        onClick={() => setShowUI((v) => !v)}
      />

      {showUI && (
        <div className="fixed top-4 left-4 z-10 flex flex-col gap-3 rounded-lg bg-black/70 p-4 backdrop-blur-sm min-w-[280px]">
          <h1 className="text-lg font-bold text-white">Deep Focus — Audio + Shader</h1>

          {/* CSD selector */}
          <label className="flex flex-col gap-1">
            <span className="text-xs text-neutral-400">Csound CSD</span>
            <select
              value={selectedCsd}
              onChange={(e) => setSelectedCsd(e.target.value)}
              disabled={playing}
              className="rounded border border-neutral-600 bg-neutral-800 px-3 py-1.5 text-sm text-white disabled:opacity-40 disabled:cursor-not-allowed"
            >
              {CSD_FILES.map((f) => (
                <option key={f.name} value={f.name}>
                  {f.label}
                </option>
              ))}
            </select>
          </label>

          {/* Shader selector */}
          <label className="flex flex-col gap-1">
            <span className="text-xs text-neutral-400">Shader (switch anytime)</span>
            <select
              value={selectedShader}
              onChange={(e) => handleShaderChange(e.target.value)}
              className="rounded border border-neutral-600 bg-neutral-800 px-3 py-1.5 text-sm text-white"
            >
              {SHADER_FILES.map((f) => (
                <option key={f.name} value={f.name}>
                  {f.label}
                </option>
              ))}
            </select>
          </label>

          {/* Play/Stop */}
          <div className="flex gap-3">
            <button
              onClick={handlePlay}
              disabled={playing}
              className="flex-1 rounded bg-green-700 px-4 py-2 font-medium text-sm text-white hover:bg-green-600 disabled:opacity-40 disabled:cursor-not-allowed"
            >
              Play
            </button>
            <button
              onClick={handleStop}
              disabled={!playing}
              className="flex-1 rounded bg-red-700 px-4 py-2 font-medium text-sm text-white hover:bg-red-600 disabled:opacity-40 disabled:cursor-not-allowed"
            >
              Stop
            </button>
          </div>

          {/* Status */}
          <div className="text-xs text-neutral-400">
            Status: <span className="text-neutral-200">{status}</span>
          </div>

          {/* Audio level debug */}
          <div
            ref={debugRef}
            className="text-xs text-neutral-500 font-mono"
            style={{ whiteSpace: "pre" }}
          >
            Bass: 0.000  Mid: 0.000  High: 0.000
          </div>

          <div className="text-xs text-neutral-500">Click canvas to toggle UI</div>
        </div>
      )}
    </>
  );
}
