# Getting started

## Host requirements

The supplied setup script targets Debian and Ubuntu:

```sh
./init.sh
```

The build requires a 64-bit Linux host, a C compiler, NASM, and ordinary POSIX
shell tools. QEMU and OVMF are used by the run scripts. GDB is used by the
debugging workflow.

## Build

From the repository root, run:

```sh
./build.sh
```

The root script rebuilds Jabara, the compatibility tools, userland,
bootloaders, and kernel before creating the initrd and boot images. A successful
build ends with:

```text
fruityos: Jabara and NASM build passed
```

Set `FRUITY_ASSEMBLER=orgasm` to use the Jabara-written assembler for the Pulp
kernel instead of NASM:

```sh
FRUITY_ASSEMBLER=orgasm ./build.sh
```

The complete pipeline is described in [Build system](build-system.md).

## Run with BIOS

```sh
./run.sh
```

This starts QEMU with 512 MiB of RAM. The script copies `fruityos_hdd.img` to a
temporary raw IDE disk before starting QEMU, so concurrent or stale emulator
processes cannot lock or modify the generated artifact. Seed loads the
fixed-size copy, enters long mode, and transfers control to Pulp.

## Run with UEFI

```sh
./run-uefi.sh
```

This starts QEMU with OVMF and a temporary copy of `fruityos_uefi.img`. The
image contains a FAT16 EFI system partition and the removable-media loader at
`EFI/BOOT/BOOTX64.EFI`. Temporary BIOS and UEFI copies are deleted when QEMU
exits.

To place the standalone PE application in a temporary virtual EFI system
partition and boot it directly, run:

```sh
./run-pe.sh
```

The application is unsigned. Secure Boot must be disabled on physical machines
unless `fruityos.efi` is signed with a key trusted by that firmware. FruityOS
also currently requires VGA-compatible text output and a PS/2-compatible
keyboard controller after leaving firmware services.

## Expected startup

Both boot paths unpack the initrd and launch Pish. The boot script then extracts
the minimal native source tree, performs the native userland and kernel builds,
installs the new FAP files in `/bin`, and returns to an interactive prompt:

```text
Welcome to FruityOS 0.03!
[ Building FruityOS natively with Jabara ]
[ Building FruityOS userland with Jabara ]
Userland Jabara build complete.
Pulp native Jabara build complete.
/src/fruityos>
```

The native build is intentionally part of startup, so the first prompt takes
longer than a minimal shell-only boot.

## Generated artifacts

| Path | Description |
| --- | --- |
| `fruityos_hdd.img` | Padded 1 MiB legacy BIOS hard-disk image. |
| `fruityos_floppy.img` | Padded 1.44 MiB legacy BIOS floppy image. |
| `fruityos_uefi.img` | UEFI disk image with a FAT16 EFI system partition. |
| `fruityos.efi` | Standalone x86-64 PE32+ EFI application. |
| `pulp/bin/pulp.bin` | Uncompressed flat Pulp kernel. |
| `pulp/bin/pulp.sys` | Juicer-compressed Pulp kernel. |
| `peel/bin/*.fap` | Host-built FruityOS applications. |
| `initrd/` | Staging tree used to create the boot RAM filesystem. |
| `bin/` | Linux Peel executables produced by the test workflow. |

## Clean

```sh
./cleanup.sh
```

Component cleanup scripts remove their generated outputs. Source files and
user-owned changes are not removed.
