# FruityOS documentation

These documents describe the repository as built by the root `build.sh` and
run by `run.sh`.

## Guides

1. [Getting started](getting-started.md) covers host dependencies, building,
   running each image, generated artifacts, and cleanup.
2. [Build system](build-system.md) follows the complete host pipeline and lists
   the files placed in each output directory.
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
8. [Toolchains](toolchain.md) covers Jabara, platform runtimes, Orgasm, Yuzu,
   and the compiler-to-image path.
9. [Development](development.md) covers tests, boot diagnostics, repository
   invariants, and implementation limits.

## Component references

- [Jabara overview](../jabara/README.md)
- [Jabara language manual](../jabara/docs/manual.md)
- [Peel userland](../peel/README.md)
- [Pulp kernel](../pulp/README.md)
- [Seed bootloaders](../seed/README.md)
- [Yuzu toolchain](../yuzu/README.md)
