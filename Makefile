CFLAGS=-Wall -Werror -pedantic-errors -std=c99
LFLAGS=
LIB_PATH=/usr/local/lib
INCLUDE_PATH=/usr/local/include

all: vec3 mat3 mat4 quat str
	ar -rcs libgl-matrix.a vec3.o mat3.o mat4.o quat.o str.o

clean:
	rm vec3.o mat3.o mat4.o quat.o str.o 
	rm libgl-matrix.a
	
vec3: vec3.c
	$(CC) -c vec3.c $(CFLAGS) -o vec3.o

mat3: mat3.c
	$(CC) -c mat3.c $(CFLAGS) -o mat3.o

mat4: mat4.c
	$(CC) -c mat4.c $(CFLAGS) -o mat4.o

quat: quat.c
	$(CC) -c quat.c $(CFLAGS) -o quat.o

str: str.c
	$(CC) -c str.c $(CFLAGS) -o str.o

install:
	cp libgl-matrix.a $(LIB_PATH)/libgl-matrix.a
	cp gl-matrix.h $(INCLUDE_PATH)/gl-matrix.h