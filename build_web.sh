#!/bin/sh
# Emscripten build script for Blaster Master web port
set -e

mkdir -p web

# All source files to compile
ENGINE_SRCS="engine/bm.c engine/bm_game.c engine/entities.c engine/opengl.c engine/sound.c"
COMMON_SRCS="common/newmap.c"
BMGAME_SRCS="bmgame/interface.c"
GAME_COMMON_SRCS="game/common/Bullet.c game/common/Explosion.c game/common/FlyBomber.c \
  game/common/interface.c game/common/Jason.c game/common/Keyhole.c \
  game/common/Mechipede.c game/common/Mine.c game/common/PowerUp.c \
  game/common/RingFlyer.c game/common/RingSpawner.c game/common/RockClimber.c \
  game/common/RockGunner.c game/common/RockWalker.c game/common/Squidy.c \
  game/common/Tank.c game/common/Turret.c game/common/VDoor.c \
  game/common/VFlyer.c game/common/World.c"

INCS="-Icommon -Iengine"
GAME_COMMON_INCS="-Icommon -Igame/common"

echo "Building Blaster Master for web..."

emcc \
  $ENGINE_SRCS $COMMON_SRCS $BMGAME_SRCS $GAME_COMMON_SRCS \
  $INCS $GAME_COMMON_INCS \
  -s LEGACY_GL_EMULATION=1 \
  -s GL_UNSAFE_OPTS=0 \
  -s ALLOW_MEMORY_GROWTH=1 \
  -s TOTAL_MEMORY=67108864 \
  --use-port=sdl2 \
  --use-port=sdl2_image:formats=png \
  --use-port=sdl2_mixer \
  --preload-file maps/ \
  --preload-file textures/ \
  -DGL_SILENCE_DEPRECATION \
  -g \
  -o web/index.html

echo "Build complete! Files in web/"
echo "Run: cd web && python3 -m http.server"
