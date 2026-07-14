# Seed

Seed contains the FruityOS bootloaders.

- `hdseed` is the 512-byte legacy hard-disk loader used by
  `fruityos_hdd.img`.
- `fdseed` is the retained floppy-oriented loader.
- `uefiseed` is a dependency-free x86-64 PE32+ EFI application and FAT16 image
  generator written in NASM.

Both supported boot paths decompress Pulp at physical `0x10000`, place the
initrd where it remains stable during kernel initialization, and enter the
kernel at `0x10100` with the initrd pointer in `RSI`.

The root build produces the BIOS image, standalone `fruityos.efi`, and
`fruityos_uefi.img` containing `EFI/BOOT/BOOTX64.EFI`.

See [Boot and firmware](../docs/boot-and-firmware.md) for image layouts, PE
structure, firmware calls, memory reservations, and hardware requirements.
