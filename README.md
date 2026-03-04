# Boris Granular

Real-time granular audio effect for [Ableton Move](https://www.ableton.com/move/), built for the [move-anything](https://github.com/charlesvestal/move-anything) framework.

Captures live audio into a buffer, then spawns overlapping grains with pitch, position, and pan randomization.

## Parameters

### Granular
| Knob | Parameter | Range |
|------|-----------|-------|
| 1 | Density | 0.04 - 1.0 |
| 2 | Size | 20 - 2000 ms |
| 3 | Pitch Shift | 0.25x - 4x |
| 4 | Envelope | 0 - 100% |
| 5 | Position | 0 - 100% |
| 6 | Drift | 0 - 100% |
| 7 | Wet | 0 - 150% |
| 8 | Freeze | off / on |

### Randomize
| Knob | Parameter | Range |
|------|-----------|-------|
| 1 | Rdm Size | 0 - 100% |
| 2 | Rdm Delay | 0 - 100% |
| 3 | Rdm Shift | 0 - 100% |
| 4 | Reverse | 0 - 100% |
| 5 | Pan Width | 0 - 100% |
| 6 | Rdm Vol | 0 - 100% |
| 7 | Chance | 0 - 100% |
| 8 | Feedback | 0 - 90% |

### Sync
Sync | Division (1/16 to 4/1) | Rhythm (normal / dotted / triplet)

### Advanced
Input gain | Dry level | Mute | Voices (1-24)

## Installation

Copy the `granular` folder to your Move:

```
scp -r granular root@move.local:/data/UserData/move-anything/modules/audio_fx/
```

## Tips

- Start with Density ~0.5 and Size ~200ms
- Add Drift for texture, Reverse for ambience
- Feedback creates buildup effects
- Freeze captures a moment to granulate indefinitely
- Sync locks grain triggers to MIDI clock tempo

## Credits

Based on [Boris Granular Station](https://github.com/glesdora/boris-granular-station) by Alessandro Gaiba ([@glesdora](https://github.com/glesdora)).
Ported to Ableton Move by [Vincent Fillion](https://github.com/fillioning).

### Changes from original

- Rewritten from C++/JUCE/RNBO to plain C targeting the move-anything `audio_fx_api_v2` plugin API
- Compiled for ARM64 (Ableton Move / Raspberry Pi 4)
- UI adapted to Move's 8-knob interface across 4 pages (Granular, Randomize, Sync, Advanced)

## License

GPL-3.0 — see [LICENSE](LICENSE)

This project is a derivative of Boris Granular Station, which is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html). As required by GPL-3.0, this derivative work is distributed under the same license.
