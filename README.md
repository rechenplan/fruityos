# build instructions

	1. Run init.sh to install all required software and clone required repositories.
	2. Run build.sh to build all required repositories and create floppy image.
	3. Run run.sh to run in qemu.

# memory map

	0x000500 - 0x010000
	0x010000 - 0x040000 192k kernel space
	0x040000 - 0x080000 256k application space
	0x100000 - 0x200000 kernel heap
	0x200000 - 0x?????? application heap

