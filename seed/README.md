# Seed

Seed contains the FruityOS bootloaders.

- `hdseed` is the 512-byte BIOS hard-disk loader used by
  `bin/fruityos_hdd.img`.
- `fdseed` is the BIOS floppy loader used by `bin/fruityos_floppy.img`.
- `uefiseed` is a dependency-free x86-64 PE32+ EFI application and FAT16 image
  generator written in NASM.

All three paths locate `/pulp.sys` in the initrd Jar, decompress Pulp at physical
`0x10000`, preserve the initrd for kernel initialization, and enter Pulp at
`0x10100` with the Jar pointer in `RSI`.

## Build

`seed/build.sh` writes:

```text
seed/bin/hdseed.bin
seed/bin/fdseed.bin
```

The root build invokes `seed/src/uefiseed/build.sh` after creating the initrd.
That script writes:

```text
bin/fruityos.efi
bin/fruityos_uefi.img
```

See [Boot and firmware](../docs/boot-and-firmware.md) for image layouts,
firmware calls, memory reservations, and hardware requirements.
