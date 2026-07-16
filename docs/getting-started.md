# Getting started

## Host requirements

The repository checks in four packed x86-64 Linux executables: `bin/pish`,
`bin/orgasm`, `bin/juicer`, and `bin/concat`. They build the first Jabara
compiler and the Peel tools. The build contains no shell scripts and does not
require GCC, NASM, or Make.

Pish treats the directory from which it starts as its root and searches that
root's `bin` directory for commands, so start builds from the repository root.

## Build

```text
bin/pish build.psh
```

The root script builds Jabara, Yuzu, Peel, Seed, and Pulp, creates the initrd,
and produces the BIOS, floppy, and UEFI images. See
[Build system](build-system.md) for the complete pipeline.

## Startup

Every boot path produces the same kernel handoff. Pulp initializes the kernel,
unpacks the initrd into RAMFS, starts `/bin/pish.fap`, and Pish executes
`/init.psh`. The supplied script prints the welcome banner and returns to the
interactive shell.

All installed applications are already present in `/bin`; boot does not compile
or install additional programs.

## Generated artifacts

| Path | Description |
| --- | --- |
| `out/fruityos_hdd.img` | BIOS hard-disk image padded to 1 MiB. |
| `out/fruityos_floppy.img` | BIOS floppy image padded to 1.44 MiB. |
| `out/fruityos_uefi.img` | UEFI disk image containing a FAT16 EFI system partition. |
| `out/fruityos.efi` | Standalone x86-64 EFI application. |
| `pulp/out/fruityos-x86_64/pulp.bin` | Flat Pulp kernel. |
| `pulp/out/fruityos-x86_64/pulp.sys` | Compressed Pulp kernel embedded in the initrd. |
| `peel/out/fruityos-x86_64/<name>` | Extensionless compressed FruityOS Peel applications. |
| `jabara/out/fruityos-x86_64/{jc,orgasm}` | FruityOS compiler and assembler applications. |
| `peel/out/$platform/<name>` | Native Peel executables for `$platform`. |
| `initrd/` | Files archived into the boot RAM filesystem. |

## Physical UEFI systems

`out/fruityos.efi` is unsigned. Disable Secure Boot or sign the application with
a key trusted by the firmware. After exiting firmware services, FruityOS uses
VGA-compatible text output and a PS/2-compatible keyboard controller.

## Clean

```text
bin/pish clean.psh
```

Cleaning removes generated component outputs, the initrd staging tree, and
transient derived executables. It preserves the four checked-in bootstrap
executables.
