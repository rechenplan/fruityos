gcc -I../../../pith/libpith/include -Os -c -Wno-int-conversion -Wno-builtin-declaration-mismatch src/hello.c -nostdlib -o src/hello.o
ld -n -s src/hello.o ../../../pith/libpith/bin/linux-x86-64/libpith.a -o bin/hello
