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

# uefiseed

`src/uefiseed/uefiseed.asm` is a dependency-free x86-64 UEFI loader. The same
NASM source contains its PE32+ header, embeds the compressed Pulp kernel and
initrd, and can package the result as `EFI/BOOT/BOOTX64.EFI` in a FAT16 EFI
system partition.

The root build produces both a standalone `fruityos.efi` PE32+ application and
`fruityos_uefi.img`, which contains that application at the removable-media
path. The loader reserves FruityOS's fixed physical regions through UEFI, exits
boot services, creates a temporary identity map, restores legacy VGA text mode
and PIC routing, decompresses Pulp at `0x10000`, and jumps to its entry at
`0x10100` with the initrd pointer in `RSI`.
