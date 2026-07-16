# FruityOS documentation

These documents describe the repository as built on Linux x86-64, Windows
x86-64, or FruityOS x86-64. All three hosts execute the same Pish build graph
and derive the compiler from the small binary surface under `bin/`.

## Guides

1. [Getting started](getting-started.md) covers the three host entrypoints,
   exact bootstrap files, generated artifacts, and cleanup.
2. [Build system](build-system.md) follows the platform-aware Pish pipeline.
3. [Boot and firmware](boot-and-firmware.md) documents BIOS, PE32+ UEFI, FAT16,
   and the kernel handoff.
4. [Kernel architecture](kernel.md) describes initialization, paging,
   privilege transitions, execution, RAMFS, devices, and memory maps.
5. [System-call ABI](system-calls.md) specifies interrupt `0x84` and every call slot.
6. [Initial RAM filesystem](initrd.md) describes initrd staging and startup.
7. [Shell and userland](userland.md) documents Pish, FAPs, Jar, Juicer, and Peel.
8. [Toolchains](toolchain.md) covers Jabara, Orgasm, Yuzu, and all platforms.
9. [Development](development.md) covers invariants, validation, and limits.

## Component references

- [Jabara overview](../jabara/README.md)
- [Jabara language manual](../jabara/docs/manual.md)
- [Peel userland](../peel/README.md)
- [Pulp kernel](../pulp/README.md)
- [Seed bootloaders](../seed/README.md)
- [Yuzu toolchain](../yuzu/README.md)
