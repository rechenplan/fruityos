mkdir bin
gcc -I../../../pith/libpith/include -Os -c -Wno-int-conversion -Wno-builtin-declaration-mismatch -Wno-incompatible-pointer-types -nostdlib src/io.c -o src/io.o
ld -n -s src/io.o ../../../pith/libpith/bin/linux-x86-64/libpith.a -o bin/io
