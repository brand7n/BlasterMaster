# Dylib makefile
CPP  = g++
CC   = gcc

INCS = -I"../../common" -I"../common_dungeon" $(shell sdl2-config --cflags)

OBJ  = bm_game.o interface.o
BIN  = "../map09.dylib"

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
