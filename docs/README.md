# FruityOS documentation

This directory is the canonical integrated-system documentation for FruityOS
0.03.
The component READMEs provide short introductions; the documents here describe
how the bootloaders, kernel, toolchain, initrd, and userland work together.

## Guides

1. [Getting started](getting-started.md) covers dependencies, building,
   running each image, generated artifacts, and cleanup.
2. [Build system](build-system.md) follows the complete host build pipeline and
   explains compiler targets and generated files.
3. [Boot and firmware](boot-and-firmware.md) documents the BIOS disk layout,
   PE32+ loader, FAT16 UEFI image, and kernel handoff.
4. [Kernel architecture](kernel.md) describes initialization, paging,
   privilege transitions, task execution, RAMFS, devices, and memory maps.
5. [System-call ABI](system-calls.md) specifies interrupt `0x84`, registers,
   dispatch-table layout, and every current call.
6. [Initrd and native rebuild](initrd-native-build.md) describes source
   packaging, the minimal bootstrap userland, native compilation, and `/bin`
   installation.
7. [Shell and userland](userland.md) documents Pish, scripts, FAP programs,
   Jar, Juicer, and the installed utilities.
8. [Toolchain](toolchain.md) covers Jabara bootstrapping, output formats,
   runtimes, Orgasm, and retained Yuzu compatibility.
9. [Development](development.md) covers tests, debugging, diagnostics,
   repository conventions, and current limitations.

## Component references

- [Jabara overview](../jabara/README.md)
- [Jabara language manual](../jabara/docs/manual.md)
- [Peel userland](../peel/README.md)
- [Pulp kernel](../pulp/README.md)
- [Seed bootloaders](../seed/README.md)
- [Yuzu compatibility layer](../yuzu/README.md)
