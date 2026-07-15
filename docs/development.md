# Development and limitations

## Build validation

Run the complete repository build from its root:

```text
bin/pish build.psh
```

The build itself validates the current integration points:

- Jabara rebuilds Orgasm and then rebuilds itself;
- Orgasm assembles every host executable, boot seed, FAP, and Pulp;
- Juicer compresses every FAP and the kernel;
- `orgasm.fap` and `pulp.sys` are each checked against 8 KiB;
- `pad.elf` checks the BIOS HDD and floppy load limits;
- `uefi.elf` constructs both the PE32+ application and FAT16 disk image.

Compiler regression inputs remain under `jabara/tests/` and can be compiled with
the rebuilt `jabara/out/jc` and `jabara/out/orgasm` tools.

## Repository invariants

- All build orchestration is Pish source with the `.psh` suffix.
- Build scripts invoke only Pish builtins and Peel/Jabara executables.
- The checked-in root `bin/` directory contains only bootstrap tools.
- Generated artifacts are written to `out/` and `tmp/` directories.
- Compiler output remains separate from executable headers and platform
  runtimes.
- The system-call table occupies Pulp offset zero; executable entry is offset
  `0x100`.
- The root `build.psh` application list is the initrd manifest.
- `pulp.sys` and `orgasm.fap` remain within their 8 KiB limits.
- The BIOS hard-disk payload remains within 1 MiB.
- The BIOS floppy payload remains within 350,208 bytes.
- RAMFS inode layout changes are reflected in both Pulp and the `inode` utility.

## Boot verification

A complete boot reaches the welcome banner and an interactive Pish prompt. The
BIOS HDD, BIOS floppy, and UEFI paths share the same kernel and initrd but use
independent Seed loaders. The images are:

```text
out/fruityos_hdd.img
out/fruityos_floppy.img
out/fruityos_uefi.img
```

UEFI Seed and the Pulp console also emit characters to diagnostic port `0xE9`.

## Implementation limits

FruityOS provides one active user program, a volatile RAMFS, VGA text output,
PS/2 keyboard input, fixed physical memory reservations, a fixed application
window, and fixed-block kernel allocation. It has no networking, USB, audio,
graphics API, SMP startup, ACPI discovery, general device enumeration, Secure
Boot integration, or persistent storage.
