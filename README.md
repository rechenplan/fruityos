# FruityOS

FruityOS is a small, monotasking 64-bit operating system for x86 PCs. It boots
through BIOS or x86-64 UEFI, starts the Jabara-written Pulp kernel, unpacks a
volatile RAM filesystem, and launches the Pish shell in ring 3.

The repository contains the complete build chain: systems languages, compilers,
assembler, bootloaders, kernel, userland, archive format, and compression
format.

## Build

The build is driven entirely by Pish scripts and Peel executables. Four packed
Linux bootstrap executables—`pish`, `orgasm`, `juicer`, and `concat`—build the
first platform compiler and the native Peel environment; the top-level Pish
script installs the derived tools into `bin/`.

Build every component and generate all boot images from the repository root:

```text
bin/pish build.psh
```

The build uses no POSIX shell scripts and does not require an ANSI C compiler,
NASM, or Make. Orchestration uses Pish, Peel commands, Jabara, and Orgasm. Component artifacts are separated under
`out/<platform>/`; final images remain under the top-level `out/` directory.

Clean generated files with:

```text
bin/pish clean.psh
```

## Build outputs

| Path | Description |
| --- | --- |
| `out/fruityos_hdd.img` | 1 MiB BIOS hard-disk image. |
| `out/fruityos_floppy.img` | 1.44 MiB BIOS floppy image. |
| `out/fruityos_uefi.img` | UEFI disk image with a FAT16 EFI system partition. |
| `out/fruityos.efi` | Standalone x86-64 PE32+ EFI application. |
| `pulp/out/fruityos-x86_64/pulp.bin` | Flat uncompressed Pulp kernel. |
| `pulp/out/fruityos-x86_64/pulp.sys` | Juicer-compressed Pulp kernel. |
| `peel/out/fruityos-x86_64/<name>` | Extensionless compressed Peel applications. |
| `jabara/out/fruityos-x86_64/{jc,orgasm}` | FruityOS compiler and assembler applications. |
| `peel/out/$platform/<name>` | Native Peel tools used by the host build. |
| `initrd/` | Staging tree archived into the boot RAM filesystem. |

## Components

- `bin/` — the checked-in packed Pish, Orgasm, Juicer, and Concat bootstrap tools.
- `jabara/` — Jabara compilers, Orgasm, platform runtimes, tests, and language
  manual.
- `yuzu/` — Yuzu compiler and Zest assembler sources.
- `seed/` — BIOS and x86-64 UEFI bootloaders.
- `pulp/` — the FruityOS kernel.
- `peel/` — Pish and the FruityOS userland.
- `scripts/` — files copied to the initrd root.
- `docs/` — integrated operating-system documentation.

## Documentation

Start with the [documentation index](docs/README.md), or open a topic directly:

- [Getting started](docs/getting-started.md)
- [Build system](docs/build-system.md)
- [Boot and firmware](docs/boot-and-firmware.md)
- [Kernel architecture and memory](docs/kernel.md)
- [System-call ABI](docs/system-calls.md)
- [Initial RAM filesystem](docs/initrd.md)
- [Shell and userland](docs/userland.md)
- [Jabara, Orgasm, and Yuzu toolchains](docs/toolchain.md)
- [Development, testing, and limitations](docs/development.md)

FruityOS is an experimental operating-system and language laboratory rather
than a Unix-compatible general-purpose system.

## Compiler drivers

Applications are compiled through `bin/jc.psh PLATFORM OUTPUT SOURCES...`.
`bin/jc-linux-x86_64.psh` and `bin/jc-fruityos-x86_64.psh` are thin public
front ends. Runtime assembly and Pith declarations live under
`lib/linux-x86_64/` and `lib/fruityos-x86_64/`. Pish exposes the runtime-owned
platform string as `$platform` and the build root as `$root`.
