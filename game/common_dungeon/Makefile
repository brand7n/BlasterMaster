# Dylib makefile
CPP  = g++
CC   = gcc

INCS = -I"../../common" $(shell sdl2-config --cflags)

OBJ  = Bullet.o Explosion.o interface.o Jason.o PowerUp.o RingFlyer.o RingSpawner.o World.o
BIN  = "../common_dungeon.dylib"

LIBS = -framework OpenGL
CFLAGS = $(INCS) -g -fPIC

.PHONY:	clean deps

$(BIN):	deps $(OBJ)
	$(CC) -dynamiclib $(OBJ) $(LIBS) -o $(BIN)

clean:
	rm -f $(OBJ)

deps:
	$(CC) $(CFLAGS) -MM *.c > dependencies

-include dependencies
