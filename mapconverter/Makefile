CPP  = g++
CC   = gcc

INCS = -I"../common" $(shell sdl2-config --cflags) $(shell pkg-config --cflags libpng)

OBJ  = tilepager.o ../common/newmap.o
BIN  = "../Map Extractor"

LIBS = $(shell sdl2-config --libs) $(shell pkg-config --libs libpng) -lz -framework OpenGL
CFLAGS = $(INCS) -g -DGL_SILENCE_DEPRECATION

.PHONY:	clean deps

$(BIN):	deps $(OBJ)
	$(CC) $(OBJ) -o $(BIN) $(LIBS)

clean:
	rm -f $(OBJ)

deps:
	$(CC) $(CFLAGS) -MM *.c > dependencies

-include dependencies
