# fruityos

a monotasking 64 bit OS written in yuzu: a custom system language. this repository contains several directories:

	1. yuzu - a system programming language
	2. peel - a userspace suite with commands similar to dos
	3. pulp - the fruityos kernel
	4. seed - the fruityos bootloader

# build under ubuntu instructions

	1. Run init.sh to install all required software
	2. Run build.sh to build
	3. Run run.sh to run in qemu.

# memory map

	0x0001000 - 0x0010000 scratch, idt at 0xf000, page table at 0x1000
	0x0010000 - 0x0040000 kernel & stack
	0x0040000 - 0x0040200 mbr
	0x0040200 - 0x0060000 exception stack
	0x0100000 - 0x0400000 paging structures
	0x0400000 - 0x0800000 kernel heap
	0x0800000 - 0x1000000 application space

