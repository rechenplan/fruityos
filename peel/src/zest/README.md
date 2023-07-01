# zest

zest is a nasm style assembler written in yuzu that assembles the subset of x86-64 assembly needed to assemble
yuzu/byc output and just enough to assemble libpith as well. it outputs flat files and accepts the org in decimal
as an argument.

## usage

	bin/zest org in.asm out.bin
