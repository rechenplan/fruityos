# FruityOS documentation

These documents describe the repository as built by `bin/pish build.psh`.

## Guides

1. [Getting started](getting-started.md) covers bootstrapping, building,
   generated artifacts, and cleanup.
2. [Build system](build-system.md) follows the complete Pish/Peel pipeline.
3. [Boot and firmware](boot-and-firmware.md) documents the BIOS images, PE32+
   application, FAT16 UEFI image, and kernel handoff.
4. [Kernel architecture](kernel.md) describes initialization, paging,
   privilege transitions, execution, RAMFS, devices, and memory maps.
5. [System-call ABI](system-calls.md) specifies interrupt `0x84`, registers,
   dispatch-table layout, and every implemented call slot.
6. [Initial RAM filesystem](initrd.md) describes the initrd staging tree,
   archive format, installed programs, and startup sequence.
7. [Shell and userland](userland.md) documents Pish, FAP applications, Jar,
   Juicer, and the installed utilities.
8. [Toolchains](toolchain.md) covers Jabara, Orgasm, Yuzu, and executable targets.
9. [Development](development.md) covers repository invariants and limits.

## Component references

- [Jabara overview](../jabara/README.md)
- [Jabara language manual](../jabara/docs/manual.md)
- [Peel userland](../peel/README.md)
- [Pulp kernel](../pulp/README.md)
- [Seed bootloaders](../seed/README.md)
- [Yuzu toolchain](../yuzu/README.md)
