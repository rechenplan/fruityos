# Seed

Seed contains the FruityOS BIOS and UEFI boot components.

- `hdseed` is the 512-byte BIOS hard-disk loader.
- `fdseed` is the BIOS floppy loader.
- `uefiseed` supplies the prefix used by the Peel UEFI image builder.

All boot paths locate `/pulp.sys` in the initrd Jar, decompress Pulp at physical
`0x10000`, preserve the initrd for kernel initialization, and enter Pulp at
`0x10100` with the Jar pointer in `RSI`.

## Build

`seed/build.psh` writes:

```text
seed/out/fruityos-x86_64/hdseed.bin
seed/out/fruityos-x86_64/fdseed.bin
seed/out/fruityos-x86_64/uefiseed-prefix.bin
```

The root build then uses the native `bin/uefi` tool to write:

```text
out/fruityos.efi
out/fruityos_uefi.img
```

See [Boot and firmware](../docs/boot-and-firmware.md).
