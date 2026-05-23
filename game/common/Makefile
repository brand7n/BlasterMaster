# Dylib makefile
CPP  = g++
CC   = gcc

INCS = -I"../../common" $(shell sdl2-config --cflags)

OBJ  = Bullet.o Explosion.o FlyBomber.o interface.o Jason.o Keyhole.o Mechipede.o Mine.o PowerUp.o RingFlyer.o RingSpawner.o RockClimber.o RockGunner.o RockWalker.o Squidy.o Tank.o Turret.o VDoor.o VFlyer.o World.o
BIN  = "../common.dylib"

LIBS = -framework OpenGL
CFLAGS = $(INCS) -g -fPIC -DGL_SILENCE_DEPRECATION

.PHONY:	clean deps

$(BIN):	deps $(OBJ)
	$(CC) -dynamiclib $(OBJ) $(LIBS) -o $(BIN)

clean:
	rm -f $(OBJ)

deps:
	$(CC) $(CFLAGS) -MM *.c > dependencies

-include dependencies
