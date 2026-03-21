# Boris Granular - Schwung Audio FX Module

Port of [Boris Granular Station](https://github.com/glesdora/boris-granular-station) by Alessandro Gaiba for Ableton Move.

## Architecture

Single C file (`src/dsp/granular.c`) implementing the Audio FX API v2 (instance-based).

### DSP Components
- **Circular buffer**: 10-second mono recording buffer (441000 samples at 44.1kHz)
- **Grain voices**: Up to 24 simultaneous grains with independent state
- **Envelope tables**: Pre-computed Hann, Triangle, and Trapezoid windows (1024 samples) with continuous morphing
- **Smoothed values**: Click-free parameter changes via linear ramp (~50ms)
- **DC blocker**: Per-channel DC removal on wet signal
- **PRNG**: xorshift32 for per-grain randomization
- **MIDI clock**: BPM detection from 0xF8 timing messages (24 PPQN)

### Signal Flow
```
Stereo In -> Mono Sum -> Input Gain -> Mix with Feedback
-> Circular Buffer Write (unless Frozen)
-> Trigger (Boris formula or Tempo Sync) -> Spawn Grains
-> Grain Playback (buffer read with interpolation + envelope + pan)
-> DC Block -> Feedback Store
-> Dry/Wet Mix -> Soft Clip -> Stereo Out
```

### Parameters (23 total, 4 pages)

| Page | Key | Type | Range | Default | Description |
|------|-----|------|-------|---------|-------------|
| Granular | density | float | 0.04-1.0 | 0.52 | Grain trigger density |
| Granular | grain_size | float | 20-2000 | 200 | Grain length in ms |
| Granular | pitch | float | 0.25-4.0 | 1.0 | Playback speed ratio |
| Granular | envelope | float | 0-1 | 0 | Window shape (Hann->Tri->Trap) |
| Granular | position | float | 0-1 | 0 | Read position in buffer |
| Granular | drift | float | 0-1 | 0 | Position randomization (quadratic) |
| Granular | wet | float | 0-1.5 | 1.0 | Wet level |
| Granular | freeze | enum | off/on | off | Stop buffer recording |
| Randomize | random_length | float | 0-100 | 0 | Grain size randomization % |
| Randomize | random_delay | float | 0-100 | 0 | Trigger delay randomization % |
| Randomize | random_pitch | float | 0-100 | 0 | Pitch randomization % |
| Randomize | reverse_prob | float | 0-100 | 0 | Reverse playback probability % |
| Randomize | pan_width | float | 0-100 | 0 | Stereo pan spread % |
| Randomize | random_vol | float | 0-100 | 0 | Volume randomization % |
| Randomize | chance | float | 0-100 | 100 | Grain trigger probability % |
| Randomize | feedback | float | 0-90 | 0 | Feedback amount % |
| Sync | sync | enum | off/on | off | Tempo sync mode |
| Sync | division | enum | 1/16-4/1 | 1/2 | Musical division |
| Sync | rhythm | enum | normal/dotted/triplet | normal | Rhythm modifier |
| Advanced | gain | float | 0-1.5 | 1.0 | Input gain |
| Advanced | dry | float | 0-1.5 | 1.0 | Dry level |
| Advanced | mute | enum | off/on | off | Mute grain output |
| Advanced | voice_count | int | 1-24 | 24 | Max simultaneous grains |

### Trigger Formula
Boris trigger frequency: `(-0.60651 + 41.4268 * exp(-0.001 * len_ms)) * density`

## Build and Deploy

```bash
./scripts/build.sh          # Cross-compile via Docker
./scripts/install.sh        # Deploy to Move via SSH
```

Requires Docker or `aarch64-linux-gnu-gcc` cross-compiler.

## Release Process

1. Update version in `src/module.json`
2. Commit and push
3. Tag with `git tag v<version> && git push --tags`
4. GitHub Actions builds, creates release, updates `release.json`
