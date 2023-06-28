mkdir bin
gcc -I../../../pith/libpith/include -Os -c -Wno-int-conversion -Wno-builtin-declaration-mismatch src/args.c -nostdlib -o src/args.o
ld -n -s src/args.o ../../../pith/libpith/bin/linux-x86-64/_start.o ../../../pith/libpith/bin/linux-x86-64/libpith.a -o bin/args
