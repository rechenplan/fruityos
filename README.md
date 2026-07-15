# FruityOS

FruityOS is a small, monotasking 64-bit operating system for x86 PCs. It boots
through BIOS or x86-64 UEFI, starts the Jabara-written Pulp kernel, unpacks a
volatile RAM filesystem, and launches the Pish shell in ring 3.

The repository contains the complete build chain: systems languages, compilers,
assembler, bootloaders, kernel, userland, archive format, and compression
format.

## Build

On Debian or Ubuntu, install the required packages with:

```sh
sudo ./debian-init.sh
```

Build every component and generate all boot images:

```sh
./build.sh
```

The build requires a C compiler (cc) and NASM for bootstrapping the
Jabara compiler, Orgasm assembler, and bootloaders. After that it is
entirely self-hosting :). Standard POSIX shell utilities are required
by build scripts. QEMU and OVMF are required only for the supplied run
script.

## Run

```sh
./run.sh hdd
./run.sh fd
./run.sh uefi
```

Each command starts QEMU with 512 MiB of RAM and a temporary copy of the chosen
image. Set `OVMF` to an x86-64 UEFI firmware image when it is not installed in
one of the paths checked by `run.sh`.

FruityOS prints its welcome message, then presents an interactive Pish prompt.
The initrd already contains the kernel support files, shell, compiler,
assembler, archive tools, editor, and filesystem utilities.

## Build outputs

| Path | Description |
| --- | --- |
| `bin/fruityos_hdd.img` | 1 MiB BIOS hard-disk image. |
| `bin/fruityos_floppy.img` | 1.44 MiB BIOS floppy image. |
| `bin/fruityos_uefi.img` | UEFI disk image with a FAT16 EFI system partition. |
| `bin/fruityos.efi` | Standalone x86-64 PE32+ EFI application. |
| `pulp/bin/pulp.bin` | Flat uncompressed Pulp kernel. |
| `pulp/bin/pulp.sys` | Juicer-compressed Pulp kernel. |
| `peel/bin/*.fap` | Compressed FruityOS applications. |
| `peel/bin/jar.elf` | Linux Jar packaging utility. |
| `peel/bin/juicer.elf` | Linux Juicer packaging utility. |
| `initrd/` | Staging tree archived into the boot RAM filesystem. |

## Components

- `jabara/` — Jabara compilers, Orgasm, platform runtimes, tests, and language
  manual.
- `yuzu/` — Yuzu compiler and Zest assembler sources and build scripts.
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
