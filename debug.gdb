target remote | qemu-system-x86_64 --no-reboot -d int,cpu_reset -D ./log.txt -S -gdb stdio -m 512 -drive file=fruityos_hdd.img,index=0,if=ide
b *0x7c00
b *0x10100
b *0x10678
c
layout asm
