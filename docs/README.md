# FruityOS documentation

FruityOS is built by the same Pish graph on Linux x86-64, Windows x86-64, and
FruityOS x86-64. The documents below separate build, toolchain, firmware,
kernel, ABI, and userland concerns. The complete compiler bootstrap begins from
`stage0/petit.com`.

## Start here

1. [Getting started](getting-started.md) covers host entrypoints, bootstrap
   requirements, generated images, startup, and cleanup.
2. [Repository layout](repository-layout.md) maps source components, bootstrap
   files, component outputs, and final images.
3. [Build system](build-system.md) follows the platform-aware Pish pipeline.
4. [Executable formats](executable-formats.md) documents Linux ELF, Windows
   PE32+, FruityOS FAP, compression launchers, and suffix resolution.
5. [Toolchains](toolchain.md) covers Jabara, Orgasm, Yuzu, compiler drivers, and
   platform runtimes.

## Operating system

- [Boot and firmware](boot-and-firmware.md) documents BIOS, PE32+ UEFI, FAT16,
  and the kernel handoff.
- [Kernel architecture](kernel.md) describes initialization, paging, privilege
  transitions, execution, RAMFS, devices, and memory maps.
- [System-call ABI](system-calls.md) specifies interrupt `0x84` and every call
  slot.
- [Initial RAM filesystem](initrd.md) describes initrd staging and startup.
- [Shell and userland](userland.md) documents Pish, FAPs, Jar, Juicer, and Peel.
- [Development](development.md) records repository invariants, validation, and
  implementation limits.

## Component references

- [Jabara overview](../jabara/README.md)
- [Jabara language manual](../jabara/docs/manual.md)
- [Peel userland](../peel/README.md)
- [Pulp kernel](../pulp/README.md)
- [Seed bootloaders](../seed/README.md)
- [Yuzu toolchain](../yuzu/README.md)

## Stage 0

- [Stage-0 bootstrap reconstruction](../stage0/README.md)
- [Petit language and implementation](../stage0/PETIT.md)
