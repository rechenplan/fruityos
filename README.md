# FruityOS

FruityOS is a small, monotasking 64-bit operating system for x86 PCs. It boots
through BIOS or x86-64 UEFI, starts the Jabara-written Pulp kernel, unpacks a
volatile RAM filesystem, and launches the Pish shell in ring 3.

The repository contains the complete self-hosting build chain: Pish, Jabara,
Orgasm, Yuzu, Peel userland, Seed bootloaders, the Pulp kernel, the Jar archive
format, and Juicer compression. The same Pish build graph runs on
`linux-x86_64`, `windows-x86_64`, and `fruityos-x86_64` without POSIX shell,
PowerShell, `cmd.exe`, Make, NASM, GCC, or another host compiler.

## Build

Run the platform entrypoint from the repository root:

| Host | Command |
| --- | --- |
| Linux x86-64 | `bin/pish build.psh` |
| Windows x86-64 | `bin\pish.exe build.psh` |
| FruityOS x86-64 | `bin/pish build.psh` |

Pish sets `$root` to the startup directory and `$platform` to the host platform.
Every component writes to `out/$1`, where `$1` is its explicit output platform.
The root build always creates the FruityOS kernel and boot images; host tools are
built for the platform running Pish.

Clean with the corresponding Pish entrypoint and `clean.psh`.

## Bootstrap surfaces

The irreducible binary surface is one file:

```text
stage0/petit.com   254-byte DOS stage-0 assembler
```

[`stage0/petit.pm`](stage0/petit.pm) reproduces it byte-for-byte. Petit then
materializes the raw Linux and Windows Orgasm bootstraps from human-editable
`.pm` source. Those generated Orgasm executables assemble the ordinary stage-0
`.asm` inputs and hand control to the normal Jabara/Pish build.

The platform bootstrap files under `bin/bootstrap/<platform>/` are generated
host artifacts. A populated build tree uses the following host surface:

| Host | Pish entrypoint | Bootstrap executables |
| --- | --- | --- |
| Linux x86-64 | `bin/pish` | `bin/bootstrap/linux-x86_64/orgasm.elf`, `juicer.elf`, `concat.elf` |
| Windows x86-64 | `bin/pish.exe` | `bin/bootstrap/windows-x86_64/orgasm.exe`, `juicer.exe`, `concat.exe` |
| FruityOS x86-64 | `bin/pish.fap` | `bin/bootstrap/fruityos-x86_64/orgasm.fap`, `juicer.fap`, `concat.fap` |

No `jc` executable is authoritative. Jabara assembles the first host compiler,
installs it into `bin/`, and immediately uses the common compiler driver for
the rest of the build. Fresh host Orgasm, Juicer, Concat, Pish, and Peel tools
replace bootstrap artifacts as soon as they are available.

## Executable formats

- Linux programs are published as `.elf`. The linked ELF is Juicer-compressed
  behind a small ELF launcher that mmaps executable memory, decodes the original
  image at `0x400000`, reads its ELF entrypoint, and transfers control.
- Windows programs are published as `.exe`. They are compact one-section PE32+
  console images with no CRT. The original PE is Juicer-compressed behind a
  PE32+ launcher that allocates executable memory, reconstructs the image at its
  preferred base, resolves its `kernel32.dll` imports, and enters it.
- FruityOS programs are published as `.fap` and use the FruityOS runtime ABI.

Pish searches only the extension for `$platform`: `.elf`, `.exe`, or `.fap`.

## Build outputs

| Path | Description |
| --- | --- |
| `out/fruityos_hdd.img` | 1 MiB BIOS hard-disk image. |
| `out/fruityos_floppy.img` | 1.44 MiB BIOS floppy image. |
| `out/fruityos_uefi.img` | UEFI disk image with a FAT16 EFI system partition. |
| `out/fruityos.efi` | Standalone x86-64 PE32+ EFI application. |
| `jabara/out/<platform>/` | Published host or target `jc` and Orgasm artifacts. |
| `peel/out/<platform>/` | Peel tools named `.elf`, `.exe`, or `.fap`. |
| `yuzu/out/<platform>/` | `byc`, `yc`, and `zest` for the selected platform. |
| `pulp/out/fruityos-x86_64/pulp.sys` | Juicer-compressed Pulp kernel. |
| `initrd/` | Staging tree archived into the boot RAM filesystem. |

## Components

- `bin/` — generated host bootstrap artifacts, launchers, and compiler drivers.
- `lib/<platform>/` — Pith declarations, startup code, runtime assembly, and linker script.
- `jabara/` — Jabara compilers, Orgasm, tests, and language manual.
- `yuzu/` — Yuzu compiler and Zest assembler sources.
- `peel/` — Pish and the Jabara-written host/FruityOS userland.
- `seed/` — BIOS and x86-64 UEFI bootloaders.
- `pulp/` — the FruityOS kernel.
- `scripts/` — files copied to the initrd root.
- `docs/` — integrated operating-system and build documentation.

## Compiler drivers

Use the common driver with an explicit output platform:

```text
bin/jc.psh PLATFORM OUTPUT SOURCES...
```

The thin public frontends are:

```text
bin/jc-linux-x86_64.psh
bin/jc-windows-x86_64.psh
bin/jc-fruityos-x86_64.psh
```

All three select their runtime from `lib/<platform>/` and use the same Jabara
compiler interface.

## Documentation

Start with the [documentation index](docs/README.md), especially:

- [Getting started](docs/getting-started.md)
- [Build system](docs/build-system.md)
- [Toolchains](docs/toolchain.md)
- [Development and validation](docs/development.md)

FruityOS is an experimental operating-system and language laboratory rather
than a Unix-compatible general-purpose system.

## DOS stage 0

The `stage0/` directory contains the platform-blind 254-byte Petit assembler,
its self-reproducing `petit.pm` source, readable `.pm` sources for the raw Linux
and Windows Orgasm bootstraps, and DOS batch files. Running
`stage0/build.bat` writes the Orgasm outputs directly into
`bin/bootstrap/<platform>/`.

See [`stage0/PETIT.md`](stage0/PETIT.md) for the complete language, memory model,
forward-reference algorithm, limits, and self-reproduction procedure.
