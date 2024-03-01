target remote | qemu-system-x86_64 -S -gdb stdio -m 16 -boot c -fda bin/kernel.img
b *0x7c00
b *0x100000
c
layout asm

