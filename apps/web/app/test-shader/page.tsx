"use client";

import { useState, useRef, useEffect, useCallback } from "react";

const SHADER_FILES = [
  { name: "cosmic_swirl.frag", label: "Cosmic Swirl" },
  { name: "kaleidoscope.frag", label: "Kaleidoscope" },
  { name: "mandala.frag", label: "Morphing Mandala" },
  { name: "embers.frag", label: "Ambient Embers" },
];

const VERTEX_SHADER = `
attribute vec2 a_position;
void main() {
  gl_Position = vec4(a_position, 0.0, 1.0);
}
`;

export default function TestShaderPage() {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const glRef = useRef<WebGLRenderingContext | null>(null);
  const programRef = useRef<WebGLProgram | null>(null);
  const rafRef = useRef<number>(0);
  const startTimeRef = useRef<number>(0);

  const [selected, setSelected] = useState(SHADER_FILES[0].name);
  const [status, setStatus] = useState("Ready");
  const [running, setRunning] = useState(false);
  const [showUI, setShowUI] = useState(true);

  const cleanup = useCallback(() => {
    if (rafRef.current) {
      cancelAnimationFrame(rafRef.current);
      rafRef.current = 0;
    }
    const gl = glRef.current;
    if (gl && programRef.current) {
      gl.deleteProgram(programRef.current);
      programRef.current = null;
    }
  }, []);

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

  const startShader = useCallback(
    async (shaderName: string) => {
      cleanup();

      const canvas = canvasRef.current;
      if (!canvas) return;

      // Init WebGL if needed
      if (!glRef.current) {
        const gl = canvas.getContext("webgl", { antialias: false, alpha: false });
        if (!gl) {
          setStatus("Error: WebGL not supported");
          return;
        }
        glRef.current = gl;

        // Set up full-screen quad (two triangles)
        const buffer = gl.createBuffer();
        gl.bindBuffer(gl.ARRAY_BUFFER, buffer);
        gl.bufferData(
          gl.ARRAY_BUFFER,
          new Float32Array([-1, -1, 1, -1, -1, 1, -1, 1, 1, -1, 1, 1]),
          gl.STATIC_DRAW,
        );
      }

      const gl = glRef.current;

      setStatus(`Fetching ${shaderName}...`);
      const res = await fetch(`/shaders/${shaderName}`);
      if (!res.ok) {
        setStatus(`Error: Failed to fetch ${shaderName} (${res.status})`);
        return;
      }
      const fragSource = await res.text();

      setStatus("Compiling shaders...");
      const vertShader = compileShader(gl, gl.VERTEX_SHADER, VERTEX_SHADER);
      const fragShader = compileShader(gl, gl.FRAGMENT_SHADER, fragSource);
      if (!vertShader || !fragShader) return;

      const program = gl.createProgram();
      if (!program) {
        setStatus("Error: Failed to create program");
        return;
      }
      gl.attachShader(program, vertShader);
      gl.attachShader(program, fragShader);
      gl.linkProgram(program);

      if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
        setStatus(`Link error: ${gl.getProgramInfoLog(program)}`);
        gl.deleteProgram(program);
        return;
      }

      // Shaders are linked into program, originals no longer needed
      gl.deleteShader(vertShader);
      gl.deleteShader(fragShader);

      gl.useProgram(program);
      programRef.current = program;

      // Bind vertex attribute
      const posLoc = gl.getAttribLocation(program, "a_position");
      gl.enableVertexAttribArray(posLoc);
      gl.vertexAttribPointer(posLoc, 2, gl.FLOAT, false, 0, 0);

      // Get uniform locations
      const uResolution = gl.getUniformLocation(program, "u_resolution");
      const uTime = gl.getUniformLocation(program, "u_time");
      const uMouse = gl.getUniformLocation(program, "u_mouse");

      startTimeRef.current = performance.now() / 1000;
      setRunning(true);
      setStatus(`Running: ${shaderName}`);

      const render = () => {
        // Resize canvas to fill window
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

        const time = performance.now() / 1000 - startTimeRef.current;

        gl.uniform2f(uResolution, canvas.width, canvas.height);
        gl.uniform1f(uTime, time);
        gl.uniform2f(uMouse, 0, 0);

        gl.drawArrays(gl.TRIANGLES, 0, 6);
        rafRef.current = requestAnimationFrame(render);
      };

      rafRef.current = requestAnimationFrame(render);
    },
    [cleanup, compileShader],
  );

  // Load initial shader on mount
  useEffect(() => {
    startShader(selected);
    return cleanup;
    // Only run on mount
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleChange = (name: string) => {
    setSelected(name);
    startShader(name);
  };

  return (
    <>
      <canvas
        ref={canvasRef}
        className="fixed inset-0 w-full h-full"
        onClick={() => setShowUI((v) => !v)}
      />

      {showUI && (
        <div className="fixed top-4 left-4 z-10 flex flex-col gap-3 rounded-lg bg-black/70 p-4 backdrop-blur-sm">
          <h1 className="text-lg font-bold text-white">Shader Test</h1>

          <select
            value={selected}
            onChange={(e) => handleChange(e.target.value)}
            className="rounded border border-neutral-600 bg-neutral-800 px-3 py-1.5 text-sm text-white"
          >
            {SHADER_FILES.map((f) => (
              <option key={f.name} value={f.name}>
                {f.label}
              </option>
            ))}
          </select>

          <div className="text-xs text-neutral-400">
            Status: <span className="text-neutral-200">{status}</span>
          </div>
          <div className="text-xs text-neutral-500">Click canvas to toggle UI</div>
        </div>
      )}
    </>
  );
}
