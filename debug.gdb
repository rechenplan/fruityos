target remote | qemu-system-x86_64 -d int,cpu_reset -D ./log.txt -S -gdb stdio -m 16 -drive file=fruityos.img,index=0,if=floppy
b *0x7c00
b *0x10100
c
layout asm
