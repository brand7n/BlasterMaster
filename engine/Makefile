CPP  = g++
CC   = gcc

INCS = -I"../common" $(shell sdl2-config --cflags)

OBJ  = bm.o bm_game.o entities.o opengl.o sound.o ../common/newmap.o
BIN  = "../Blaster Master"

LIBS = $(shell sdl2-config --libs) -lSDL2_image -lSDL2_mixer -lz -ldl -framework OpenGL
CFLAGS = $(INCS) -g -DGL_SILENCE_DEPRECATION

.PHONY:	clean deps

$(BIN):	deps $(OBJ)
	$(CC) $(OBJ) -o $(BIN) $(LIBS)

clean:
	rm -f $(OBJ)

deps:
	$(CC) $(CFLAGS) -MM *.c > dependencies

-include dependencies
