# Getting started

## Host requirements

On Debian or Ubuntu, install the build and emulator dependencies with:

```sh
sudo ./debian-init.sh
```

The script installs:

```text
nasm gcc qemu-system-x86 ovmf
```

The build scripts also use a POSIX shell and ordinary Unix file utilities. The
compiler and generated binaries target x86-64.

## Build

From the repository root:

```sh
./build.sh
```

The root script builds Jabara, Yuzu, Peel, Seed, and Pulp, creates the initrd,
and then produces the BIOS, floppy, and UEFI images. Success ends with:

```text
fruityos: Jabara and NASM build passed
```

See [Build system](build-system.md) for the complete pipeline and size checks.

## Run

Select one boot path:

```sh
./run.sh hdd
./run.sh fd
./run.sh uefi
```

`run.sh` starts QEMU with 512 MiB of RAM. It copies the selected image to a
private temporary file before starting QEMU, leaving the build output unlocked
and unchanged.

For UEFI, the script checks these firmware locations and then the `OVMF`
environment variable:

```text
/usr/share/qemu/OVMF.fd
/usr/share/ovmf/OVMF.fd
/usr/local/share/qemu/edk2-x86_64-code.fd
/opt/homebrew/share/qemu/edk2-x86_64-code.fd
```

Set an explicit path when necessary:

```sh
OVMF=/path/to/OVMF.fd ./run.sh uefi
```

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
| `bin/fruityos_hdd.img` | BIOS hard-disk image padded to 1 MiB. |
| `bin/fruityos_floppy.img` | BIOS floppy image padded to 1.44 MiB. |
| `bin/fruityos_uefi.img` | UEFI disk image containing a FAT16 EFI system partition. |
| `bin/fruityos.efi` | Standalone x86-64 EFI application. |
| `pulp/bin/pulp.bin` | Flat Pulp kernel. |
| `pulp/bin/pulp.sys` | Compressed Pulp kernel embedded in the initrd. |
| `peel/bin/*.fap` | Compressed FruityOS applications. |
| `peel/bin/jar.elf` | Host Jar utility. |
| `peel/bin/juicer.elf` | Host Juicer utility. |
| `initrd/` | Files archived into the boot RAM filesystem. |
| `loc.txt` | Line counts for C, assembly, Jabara, and Yuzu sources. |

## Physical UEFI systems

`bin/fruityos.efi` is unsigned. Disable Secure Boot or sign the application with
a key trusted by the firmware. After exiting firmware services, FruityOS uses
VGA-compatible text output and a PS/2-compatible keyboard controller.

## Clean

```sh
./cleanup.sh
```

The cleanup scripts remove component build outputs, generated images, and
temporary top-level build files. They do not remove source files.
