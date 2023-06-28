mkdir bin
gcc -Wno-builtin-declaration-mismatch -nostdlib -Os -c -I../../pith/libpith/include/ src/lexer.c -o src/lexer.o
gcc -Wno-builtin-declaration-mismatch -nostdlib -Os -c -I../../pith/libpith/include/ src/parser.c -o src/parser.o
gcc -Wno-builtin-declaration-mismatch -nostdlib -Os -c -I../../pith/libpith/include/ src/emitter.c -o src/emitter.o
gcc -fno-stack-protector -Wno-builtin-declaration-mismatch -Wno-int-conversion -Wno-builtin-declaration-mismatch -nostdlib -Os -c -I../../pith/libpith/include/ src/byc.c -o src/byc.o
ld -s -n src/lexer.o src/parser.o src/emitter.o src/byc.o ../../pith/libpith/bin/linux-x86-64/libpith.a ../../pith/libpith/bin/linux-x86-64/_start.o -o bin/byc
