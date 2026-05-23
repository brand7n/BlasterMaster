# Blaster Master

A game engine recreation of the classic NES game Blaster Master, written in C using SDL2 and OpenGL.

## Building on macOS

### Prerequisites

Install dependencies via Homebrew:

```bash
brew install sdl2 sdl2_image sdl2_mixer libpng
```

### Build

```bash
./build.sh
```

Or build individual modules:

```bash
cd engine && make      # Main executable
cd bmgame && make      # Core game DLL
cd game/common && make # Common gameplay entities
cd mapconverter && make # ROM map extractor
```

### Extracting Game Data

The engine requires map and texture data extracted from a Blaster Master NES ROM:

```bash
./Map\ Extractor path/to/rom.nes
```

This generates `maps/` and `textures/` directories with the game data.

### Running

```bash
./Blaster\ Master
```

## Controls

| Key | Action |
|-----|--------|
| Arrow keys | Move |
| Z | Jump |
| X | Shoot |
| A | Switch (enter/exit tank) |
| Enter | Pause |
| Alt+Enter | Toggle fullscreen |
| Escape | Quit |
| F1-F8 | Load maps 00-07 |

Gamepad/joystick is also supported.

## Architecture

The engine uses a plugin architecture where game logic is loaded as dynamic libraries (`.dylib` on macOS, `.dll` on Windows) at runtime:

- **`engine/`** — Core engine: rendering (OpenGL), entity management, input, sound, map loading
- **`bmgame/`** — Client DLL that bootstraps the game
- **`game/common/`** — Shared gameplay entities (Tank, Jason, enemies, bullets, etc.)
- **`game/common_dungeon/`** — Dungeon-specific entities
- **`game/map00/`–`map0C/`** — Per-map entities and logic
- **`common/`** — Shared headers and map I/O (`newmap.c`)
- **`mapconverter/`** — Extracts map/tile data from the NES ROM

## Port from Windows/MinGW

This project was originally built for Windows using MinGW/GCC with SDL 1.2. It has been ported to build natively on macOS with:

- **SDL 1.2 → SDL2** — Window management, input, audio APIs updated
- **DLL → dylib** — `dllwrap` replaced with `gcc -dynamiclib`
- **Build system** — Makefiles updated from MinGW toolchain to native macOS (clang/gcc, `-framework OpenGL`, `sdl2-config`)
- **64-bit fixes** — `unsigned long` size differences, POSIX compatibility (`mntent.h`, `mkdir`)
- **Modern compiler compliance** — Added missing function declarations for clang's stricter C99 enforcement

## Sound

Sound effects are not included. The NES used hardware-synthesized audio (2A03 APU), not sampled audio. To add sound, record effects from an NES emulator and place them as `.ogg` files in the `sound/` directory matching the paths referenced in `game/common/interface.c`.
