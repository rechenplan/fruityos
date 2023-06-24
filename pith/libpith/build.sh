nasm src/linux-x86-64/_start.asm -felf64 -o src/linux-x86-64/_start.o
nasm src/linux-x86-64/open.asm -felf64 -o src/linux-x86-64/open.o
nasm src/linux-x86-64/read.asm -felf64 -o src/linux-x86-64/read.o
nasm src/linux-x86-64/write.asm -felf64 -o src/linux-x86-64/write.o
nasm src/linux-x86-64/exit.asm -felf64 -o src/linux-x86-64/exit.o
nasm src/linux-x86-64/getch.asm -felf64 -o src/linux-x86-64/getch.o
nasm src/linux-x86-64/putch.asm -felf64 -o src/linux-x86-64/putch.o
nasm src/linux-x86-64/close.asm -felf64 -o src/linux-x86-64/close.o
nasm src/linux-x86-64/seek.asm -felf64 -o src/linux-x86-64/seek.o
nasm src/linux-x86-64/creat.asm -felf64 -o src/linux-x86-64/creat.o
ar -crs bin/linux-x86-64/libpith.a src/linux-x86-64/*.o
