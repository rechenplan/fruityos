# fruityos

a monotasking 64 bit OS written in yuzu: a custom system language. this repository contains several directories:

	1. yuzu - a system programming language
	2. peel - a userspace suite with commands similar to dos
	3. pulp - the fruityos kernel
	4. seed - the fruityos bootloader
	5. fapld - a loader for fruityos applications under linux

# build instructions

	1. Run init.sh to install all required software
	2. Run build.sh to build
	3. Run run.sh to run in qemu.

# memory map

	0x001000 - 0x010000 scratch, idt at 0xf000
	0x010000 - 0x040000 kernel & stack
	0x040000 - 0x080000 page table
	0x100000 - 0x200000 kernel heap
	0x200000 - 0x?????? application space

