# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Blaster Master is a 2D tile-based game engine and game reimplementation written in C, inspired by the NES game. It uses SDL 1.2 + OpenGL for rendering and targets Windows via MinGW/GCC.

## Build Commands

```bash
# Build everything (engine, game DLLs, tools)
./build.sh

# Clean all build artifacts
./clean.sh

# Build a single module
cd engine && make        # Main executable ("Blaster Master.exe")
cd bmgame && make        # BMGame.dll (engine-game interface)
cd game/common && make   # Common game DLL
cd game/map00 && make    # Per-map DLL (map00 through map09, map0C)

# Generate scroll table data
./compile_scrolltable.sh
```

Alternative: Open `Blaster Master.workspace` in Code::Blocks IDE.

No test infrastructure exists. Testing is done by running the game.

## Architecture

### Engine / Game DLL Split

The engine (`engine/`) compiles to the main executable and handles rendering, entity management, sound, and map loading. It knows nothing about game-specific logic.

Game code compiles to DLLs loaded at runtime:
- `bmgame/` -> `BMGame.dll` — core game interface
- `game/common/` -> common gameplay DLL (Tank, Jason, shared enemies)
- `game/common_dungeon/` -> dungeon-specific enemies
- `game/map00/` through `game/map0C/` -> per-map DLLs with map-specific entities and logic

Communication happens through two structs defined in `common/bm_game.h`:
- `hostfunctions` — engine API exposed to game DLLs (sprites, entities, sound, map access)
- `dllfunctions` — game callbacks the engine invokes (init, think, draw, HUD)

### Entity System

Entities use inclusion-based inheritance: every entity struct starts with `#include "basic.h"` which embeds the base fields (position, physics, collision, health, flags). The engine works with `entity_t*` and casts to specific types.

Key entity lifecycle function pointers: `init`, `prethink`, `postthink`, `touched`, `draw`, `death`, `maptest`, `attacked`.

Entity classes are registered in each module's `classes.h` (enum) and `interface.c` (class properties table).

### Adding a New Entity

From within a game module directory (e.g., `game/common/`):

```bash
perl newent.pl EntityName              # Generates EntityName.c/.h from Template
perl linkinent.pl EntityName 0xNN      # Registers in classes.h, interface.c, Makefile
```

### Map System

Maps use a custom chunk-based format (chunks: TXTR, TILE, FLGS, MAPD, ENTS, DOOR, RGNS, MUSC, GAME). Loading and tile access is in `common/newmap.c`. Maps are 16x16 tile grids with wrapping coordinates, composed of 2x2 background tiles.

### Key Shared Headers (`common/`)

- `basic.h` — base entity fields (included in every entity struct)
- `bm_game.h` — host/DLL interface structs
- `newmap.h` / `newmap.c` — map loading, tile queries, collision
- `entflags.h` — entity and map flags

### Physics

Fixed-point 16.15 arithmetic (macros: `FIX`, `MULT`, `ABS`). Tile-based collision using map flags (`MAPFLAG_SOLID`, `MAPFLAG_WATER`, `MAPFLAG_LADDER`). Per-map gravity, friction, and acceleration.

## Dependencies

SDL 1.2, SDL_image, SDL_mixer, OpenGL, zlib, libpng, MinGW (Windows)
