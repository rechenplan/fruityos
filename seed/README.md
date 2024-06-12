# seed

this repository will contain a collection of bootloaders for fruityos.

# fdseed

a bootsector for a floppy image. there will be no file system on the floppy. it will simply contain pulp and the initrd written consecutively to disk.

1. load entire floppy disk into ram.
2. decompress pulp in memory.
4. decompress initrd in memory
5. switch to long mode
6. jump to pulp with pointer to decompressed initrd


# hdseed

a bootsector for a harddrive or other bootable media. behaves similar to fdseed.
