# zest

zest is a nasm style assembler written in yuzu that assembles the subset of x86-64 assembly needed to assemble
byc/yc output and just enough to assemble libpith as well. it outputs flat files and uses 0x100000 as the origin.

## usage

	bin/zest in.asm out.bin
