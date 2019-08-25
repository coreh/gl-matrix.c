CFLAGS=-Wall -Werror -pedantic-errors -std=c99
LFLAGS=
LIB_PATH=/usr/local/lib
INCLUDE_PATH=/usr/local/include

SOURCES=vec2.c vec3.c vec4.c mat3.c mat4.c quat.c str.c
OBJECTS=$(SOURCES:.c=.o)

all: libgl-matrix.a glmatrix.h

libgl-matrix.a: $(OBJECTS)
	ar -rcs libgl-matrix.a $(OBJECTS)

clean:
	-rm $(OBJECTS)
	-rm libgl-matrix.a
	-rm glmatrix.h

.c.o:
	$(CC) -c $< $(CFLAGS) -o $@

vec2.o: vec2.c gl-matrix.h
vec3.o: vec3.c gl-matrix.h
vec4.o: vec4.c gl-matrix.h
mat3.o: mat3.c gl-matrix.h
mat4.o: mat4.c gl-matrix.h
quat.o: quat.c gl-matrix.h
str.o: str.c gl-matrix.h

install:
	cp libgl-matrix.a $(LIB_PATH)/libgl-matrix.a
	cp gl-matrix.h $(INCLUDE_PATH)/gl-matrix.h

# Single header file library
glmatrix.h: gl-matrix.h $(SOURCES)
	echo '/* Single header library vector and matrix library.' > $@
	echo ' * You need to `#define GL_MATRIX_IMPLEMENTATION` in one of your source files' >> $@
	echo ' * Single header version which can be obtained at <https://github.com/wernsey/gl-matrix.c>' >> $@
	echo ' * Modified from the original C port by Marco Buono <https://github.com/coreh/gl-matrix.c>' >> $@
	echo " * Which was ported to C from Brandon Jones' original JavaScript version <https://github.com/toji/gl-matrix>" >> $@
	echo '' >> $@
	cat LICENSE >> $@
	echo '' >> $@
	echo ' */' >> $@
	cat gl-matrix.h >> $@
	echo '#ifdef GL_MATRIX_IMPLEMENTATION' >> $@
	echo '#include <stdio.h>' >> $@
	echo '#include <stdlib.h>' >> $@
	echo '#include <math.h>' >> $@
	sed '/#include.*$$/d' $(SOURCES) >> $@
	echo '#endif /* GL_MATRIX_IMPLEMENTATION */' >> $@