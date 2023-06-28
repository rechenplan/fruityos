mkdir bin
gcc -I../../../pith/libpith/include -Os -c -Wno-int-conversion -Wno-builtin-declaration-mismatch -Wno-incompatible-pointer-types -nostdlib src/cat.c -o src/cat.o
ld -n -s src/cat.o ../../../pith/libpith/bin/linux-x86-64/_start.o ../../../pith/libpith/bin/linux-x86-64/libpith.a -o bin/cat
