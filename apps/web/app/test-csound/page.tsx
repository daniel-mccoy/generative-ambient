"use client";

import { useState, useRef, useCallback } from "react";

const CSD_FILES = [
  { name: "test.csd", label: "220 Hz Sine (2s)" },
  { name: "fm_bells.csd", label: "FM Bells" },
  { name: "cascade_harmonics.csd", label: "Cascade Harmonics + Reverb" },
  { name: "gen_pulse.csd", label: "Gen Pulse (full 4-layer)" },
  { name: "bass_drone_solo.csd", label: "Bass Drone Solo" },
  { name: "swarm_pad_solo.csd", label: "Swarm Pad Solo" },
];

export default function TestCsoundPage() {
  const [status, setStatus] = useState("Ready");
  const [selected, setSelected] = useState(CSD_FILES[0].name);
  const [playing, setPlaying] = useState(false);
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const csoundRef = useRef<any>(null);

  const handlePlay = useCallback(async () => {
    try {
      setStatus("Loading @csound/browser...");

      // Dynamic import to avoid SSR issues with WASM
      const { Csound } = await import("@csound/browser");

      // Clean up previous instance if any
      if (csoundRef.current) {
        try {
          await csoundRef.current.stop();
          await csoundRef.current.terminateInstance();
        } catch {
          // ignore cleanup errors
        }
        csoundRef.current = null;
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
        setStatus("Performance ended");
        csoundRef.current = null;
      });

      setStatus(`Fetching /csound/${selected}...`);
      const res = await fetch(`/csound/${selected}?t=${Date.now()}`);
      if (!res.ok) {
        setStatus(`Error: Failed to fetch ${selected} (${res.status})`);
        return;
      }
      const csdText = await res.text();

      setStatus("Compiling CSD...");
      const result = await csound.compileCSD(csdText, 1);
      if (result !== 0) {
        setStatus("Error: CSD compilation failed (check console)");
        return;
      }

      setStatus("Starting playback...");
      await csound.start();
      setPlaying(true);
      setStatus(`Playing: ${selected}`);
    } catch (err) {
      setStatus(`Error: ${err instanceof Error ? err.message : String(err)}`);
      console.error("Csound error:", err);
    }
  }, [selected]);

  const handleStop = useCallback(async () => {
    const csound = csoundRef.current;
    if (!csound) return;
    csoundRef.current = null;
    try {
      setStatus("Stopping...");
      await csound.stop();
      await csound.terminateInstance();
      setPlaying(false);
      setStatus("Stopped");
    } catch (err) {
      setStatus(`Stop error: ${err instanceof Error ? err.message : String(err)}`);
      console.error("Csound stop error:", err);
    }
  }, []);

  return (
    <div className="flex flex-col items-center justify-center gap-8 px-6 py-24">
      <h1 className="text-3xl font-bold tracking-tight">Csound Browser Test</h1>
      <p className="text-neutral-400">
        Proof-of-concept: load a .csd file and play it via Csound WASM.
      </p>

      <div className="flex flex-col gap-4 w-full max-w-sm">
        <label className="flex flex-col gap-1">
          <span className="text-sm text-neutral-400">Select CSD file</span>
          <select
            value={selected}
            onChange={(e) => setSelected(e.target.value)}
            disabled={playing}
            className="rounded border border-neutral-700 bg-neutral-900 px-3 py-2 text-white"
          >
            {CSD_FILES.map((f) => (
              <option key={f.name} value={f.name}>
                {f.label}
              </option>
            ))}
          </select>
        </label>

        <div className="flex gap-3">
          <button
            onClick={handlePlay}
            disabled={playing}
            className="flex-1 rounded bg-green-700 px-4 py-2 font-medium text-white hover:bg-green-600 disabled:opacity-40 disabled:cursor-not-allowed"
          >
            Play
          </button>
          <button
            onClick={handleStop}
            disabled={!playing}
            className="flex-1 rounded bg-red-700 px-4 py-2 font-medium text-white hover:bg-red-600 disabled:opacity-40 disabled:cursor-not-allowed"
          >
            Stop
          </button>
        </div>

        <div className="rounded border border-neutral-700 bg-neutral-900 px-4 py-3">
          <span className="text-sm text-neutral-400">Status: </span>
          <span className="text-sm text-white">{status}</span>
        </div>
      </div>
    </div>
  );
}
