# Generative Ambient

A generative ambient music platform that runs Csound audio synthesis and GLSL visual shaders in the browser. Never-repeating ambient music paired with reactive visuals for meditation, focus, sleep, and spa environments. Includes AI-powered piece generation via Anthropic API.

## Architecture Overview

**Turborepo monorepo** with pnpm workspaces. Three layers:

1. **`apps/web/`** — Next.js (App Router) web application. Handles routing, UI, auth (NextAuth), payments (Stripe), and orchestrates the engine. Content is fetched at runtime from CDN, not imported at build time.
2. **`packages/engine/`** — Framework-agnostic TypeScript runtime. Csound-WASM in AudioWorklet for audio, WebGL/GLSL for visuals, with an analysis bridge connecting audio features to shader uniforms.
3. **`packages/ai/`** — Server-side AI generation pipeline. Assembles prompts from templates + user input, calls Anthropic API, validates generated Csound code against an opcode whitelist and channel contract.

Content (`content/`) is pure data — Csound orchestras, GLSL shaders, audio samples, AI templates. It deploys to CDN (Cloudflare R2) independently of the app.

## Core Principles

1. **Engine and content are separate.** The engine (TypeScript) changes rarely once stable. Content (`.orc`, `.frag`, samples) changes constantly. They deploy independently.

2. **Content is data, not application code.** Orchestras and shaders are text files published to CDN as static assets, NOT bundled into JavaScript. The repo holds them for version control and local dev.

3. **Csound files work in-browser AND on desktop.** Iterate on instruments in CsoundQt (fast feedback), then test in-browser. Orchestra files must be valid Csound in both contexts.

4. **Each piece is self-contained.** A piece directory has everything needed: orchestra, score, shader, metadata, and references to shared instruments/samples. Pieces are independently deployable and cacheable.

5. **AI templates live with the content.** Prompt templates, instrument docs, and exemplars are maintained alongside the instruments they describe. Update an instrument → update its AI docs in the same commit.

## Directory Structure

```
generative-ambient/
├── apps/web/                        # Next.js web app
├── packages/
│   ├── engine/                      # Core audio/visual runtime
│   │   └── src/
│   │       ├── csound/              # CsoundEngine, AudioWorkletBridge
│   │       ├── shader/              # ShaderRenderer, UniformManager
│   │       ├── bridge/              # AnalysisBridge, Smoother, BandSplitter
│   │       ├── piece/               # PieceLoader, PieceManifest, ParameterMap
│   │       ├── performance/         # PerformanceMonitor, TierManager
│   │       └── util/                # AudioSafety, DeviceDetect
│   └── ai/                          # AI generation pipeline
│       └── src/
│           ├── generation/          # Generator, PromptBuilder, FullGenerator, ModificationGenerator
│           ├── validation/          # OrchestraValidator, OpcodeWhitelist, ChannelContract, ResourceLimits
│           ├── templates/           # TemplateLoader, ContextGuidelines
│           └── client/              # AnthropicClient
├── content/
│   ├── instruments/                 # Reusable Csound instrument library
│   │   ├── drones/                  # tanpura, pad-analog, bowed-string
│   │   ├── melodic/                 # shakuhachi, singing-bowl, bell-fm
│   │   ├── texture/                 # granular, spectral-freeze, rain
│   │   ├── rhythm/                  # pulse-prob, async-loops
│   │   ├── effects/                 # reverb-fdn, delay-mod
│   │   ├── analysis/                # analysis-engine (RMS, bands, centroid)
│   │   ├── conductor/               # meta-instrument for density/timing/transitions
│   │   └── _shared/                 # macros, tuning tables, safety (limiter/DC block)
│   ├── pieces/                      # Complete generative compositions
│   │   ├── meditation/              # theta-targeting, entrainment
│   │   ├── focus/                   # sustained concentration
│   │   └── sleep/                   # sleep induction
│   ├── shaders/lib/                 # Shared GLSL: noise, fbm, warp, palette, sdf, polar, smooth
│   ├── samples/                     # Audio source material
│   │   ├── field-recordings/        # Organized by category with catalog.json
│   │   ├── wavetables/              # Generated from recordings + synthesis
│   │   └── impulses/                # IRs for convolution reverb
│   └── ai-templates/                # Prompt templates for AI generation
│       ├── context-guidelines/      # Per-context rules (meditation, focus, sleep, spa)
│       └── exemplars/               # Quality reference orchestras
├── tools/
│   ├── render/                      # Offline rendering (YouTube video pipeline)
│   ├── field-recording/             # Field recording processing
│   └── deploy-content/              # CDN publishing
├── docs/                            # Architecture docs, business plans, decisions
├── turbo.json
├── package.json
├── pnpm-workspace.yaml
├── tsconfig.base.json
└── .gitattributes                   # LFS rules for .wav/.ogg/.mp3
```

## Piece Structure

Each piece lives in `content/pieces/{context}/{slug}/` and contains:

| File | Purpose |
|------|---------|
| `piece.json` | Metadata: id, name, context, parameters, psychoacoustic targets, performance hints |
| `orchestra.orc` | Main Csound orchestra (includes shared instruments via `#include`) |
| `score.sco` | Score — infinite (reinit loop or always-on) |
| `shader.frag` | Paired GLSL fragment shader |
| `params.json` | Parameter definitions mapping UI controls to Csound channels + shader uniforms |
| `README.md` | Compositional notes, psychoacoustic rationale |

Each instrument in `content/instruments/` has a `.orc` file and a `.md` documentation file. The `.md` files are consumed by the AI pipeline.

## CDN Content Layout

```
/content/v1/manifest.json          # Global piece catalog
/content/v1/pieces/{slug}/         # Per-piece directory
/content/v1/samples/               # Shared sample pool
/content/v1/shaders/lib/           # Shared GLSL includes
```

Versioned path (`v1`) for cache-busting on major content structure changes.

## Engine Architecture

Key components in `packages/engine/`:

- **CsoundEngine** — Csound-WASM lifecycle + channel I/O
- **AudioWorkletBridge** — AudioWorklet setup for Csound
- **ShaderRenderer** — WebGL context, shader compile, render loop
- **UniformManager** — Uniform values + exponential smoothing
- **AnalysisBridge** — Connects Csound analysis output → shader uniforms
- **PieceLoader** — Load + validate piece assets from CDN
- **PerformanceMonitor** / **TierManager** — Auto-detect + switch performance tiers
- **AudioSafety** — Limiter, silence detection, error recovery

## AI Pipeline

Key components in `packages/ai/`:

- **PromptBuilder** — Assembles: system-prompt + instrument-reference + context-guidelines + user input
- **FullGenerator** — Creates new pieces from scratch
- **ModificationGenerator** — Modifies existing pieces
- **OrchestraValidator** — Validates generated Csound code
- **OpcodeWhitelist** — Restricts to allowed opcodes (safety)
- **ChannelContract** — Verifies expected analysis channels
- **ResourceLimits** — Enforces max polyphony, table sizes

Run `npm run build-ai-reference` to regenerate `ai-templates/instrument-reference.md` from individual instrument `.md` files.

## Web App Structure (apps/web/)

Next.js App Router with route groups:
- `(player)/play/[slug]` — Full-screen generative player (minimal layout, no nav)
- `/browse` — Piece browser/library
- `/create` — AI generation interface (Premium)
- `/account` — User settings, subscription
- API routes: `/api/auth/[...nextauth]`, `/api/generate`, `/api/stripe/webhook`

Engine is a singleton managed via React context — initialized once, survives route changes.

## Instrument Design Workflow (Cabbage → Content Pipeline)

Instruments are designed interactively in Cabbage (Csound IDE with GUI controls), then extracted into reusable orchestra files for the generative engine.

### Pipeline

```
1. DESIGN       content/instruments/{category}/{name}.csd   ← Cabbage prototype
2. EXTRACT      content/instruments/{category}/{name}.orc   ← reusable orchestra
3. DOCUMENT     content/instruments/{category}/{name}.md    ← AI pipeline docs
4. INTEGRATE    content/pieces/{context}/{slug}/            ← use in compositions
```

### Step 1: Design in Cabbage

Create a self-contained `.csd` with full Cabbage GUI. This is the sound design sandbox:

- `<Cabbage>` section defines knobs, sliders, labels for every tweakable parameter
- Use `chnget` to read all GUI parameters at k-rate
- Include effects (reverb, delay, saturation) inline for complete sound evaluation
- Use `-odac -d` in CsOptions (not `-n` which disables audio)
- Score starts the instrument immediately: `i 1 0 [60*60*4]`

The `.csd` stays in the repo as the sound design source of truth — always go back to Cabbage to tweak.

### Step 2: Extract Orchestra

Once the sound is dialed in, extract the core synthesis into a `.orc` file:

- Strip `<Cabbage>` GUI section, `<CsOptions>`, and `<CsScore>`
- Convert `chnget "param"` → p-fields (`p4`, `p5`, ...) for note-level parameters (frequency, amplitude, pan)
- Keep `chnget "k_param"` for real-time control parameters that conductors will set via `chnset`
- Remove self-contained effects — the `.orc` sends to shared effect buses (`ga_rvb_L`, `ga_dly_L`, etc.)
- Add per-instrument analysis (`rms`, `chnset`) for shader uniform channels
- UDOs (User Defined Opcodes) are encouraged for reusable synthesis blocks

### Step 3: Document

Write a `.md` file alongside the `.orc` with:

- Instrument description and musical character
- Parameter table: name, range, default, musical purpose
- Channel outputs (analysis channels for shader bridge)
- Compositional notes: what context it suits, how it layers with other instruments
- These docs are consumed by the AI generation pipeline

### Step 4: Integrate into Pieces

Use the extracted `.orc` in piece orchestras:

- Reference via `#include` or inline in the piece's `orchestra.orc`
- Conductor instruments control parameters via `chnset` or p-fields on `event`
- Share effects at piece level (reverb, delay as high-numbered instruments)
- Add to piece's `params.json` for any UI-exposed controls

### Csound 6 (Cabbage) vs WASM Compatibility

| Issue | Cabbage (Csound 6.18) | Browser (WASM) |
|-------|----------------------|----------------|
| Opcodes in while loops | Stateful opcodes (`poscil`, `lfo`) don't maintain state — use `gbuzz`, `adsynt`, or unroll | Same limitation |
| `i()` function | `i(kvar, 0)` syntax not available — capture at init with `ivar = i(kvar)` or use k-rate directly | May differ |
| `^` power operator | K-rate only — no a-rate power expressions | Same |
| Variable declaration | Lenient | **Strict** — must declare/init before use |
| `outs` opcode | Works | Works (shows deprecation warning) |
| Sample rate | Typically 48000 | 44100 (browser default) |

### File Organization

```
content/instruments/
├── drones/
│   ├── tanpura-drone.csd        ← Cabbage prototype (source of truth)
│   ├── tanpura-drone.orc        ← extracted orchestra for pieces
│   └── tanpura-drone.md         ← AI pipeline documentation
├── melodic/
├── texture/
├── effects/
└── _shared/
```

## Development Workflow

1. **Composing instruments**: Design in Cabbage (`content/instruments/{category}/{name}.csd`), extract to `.orc`, verify in-browser with `pnpm dev`
2. **Composing pieces**: Create `content/pieces/{context}/{slug}/`, write orchestra referencing instruments via `#include`, write shader referencing shared GLSL, create piece.json manifest
3. **Writing shaders**: Shared functions in `content/shaders/lib/`, piece-specific in piece dir. Dev server hot-reloads. Per-instrument Csound channels drive shader uniforms via `u_{channel_name}`.
4. **AI template maintenance**: Update instrument `.md` docs → run `build-ai-reference` → test generation

## Conventions

- **Package manager**: pnpm (strict)
- **TypeScript**: strict mode, shared base config in `tsconfig.base.json`
- **Workspaces**: `@generative-ambient/web`, `@generative-ambient/engine`, `@generative-ambient/ai`
- **Audio files**: Git LFS (`.wav`, `.ogg`, `.mp3`)
- **Csound channels**: `k_` prefix for control-rate (e.g., `k_warmth`, `k_density`, `k_reverb_mix`)
- **Styling**: Tailwind CSS
- **Deployment**: Vercel (app), Cloudflare R2 (content)
- **Auth**: NextAuth
- **Payments**: Stripe (webhook-based)

## Git Strategy

- **main** — production. Deploys app to Vercel, content to CDN.
- **develop** — integration branch.
- **feature/** — feature branches off develop.
- **content/** — content-only branches (can merge directly to main since content deploys independently).
