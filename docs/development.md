# Development and limitations

## Build validation

Run the complete build through the native Pish entrypoint:

```text
Linux:    bin/pish build.psh
Windows:  bin\pish.exe build.psh
FruityOS: bin/pish build.psh
```

The build exercises compiler bootstrap, Orgasm self-hosting, native Peel/Yuzu,
FruityOS cross-compilation, kernel compression, initrd creation, and all BIOS and
UEFI image writers.

Windows executable validation should additionally check both layers of each
compressed `.exe`: the outer PE launcher and the Juicer-decoded inner PE. The
inner image must be x86-64 PE32+, use matching 512-byte file/RVA section offsets,
and have an entrypoint and import directory inside the executable image.

## Repository invariants

- Every normal-build orchestration script is Pish source with the `.psh`
  suffix; platform shell scripts are confined to stage0 reconstruction.
- The irreducible executable is `stage0/petit.com`. The populated host surface
  additionally retains Pish plus Orgasm, Juicer, and Concat for each platform
  beneath `bin/`.
- No `jc` executable is checked in.
- Component artifacts are written to local `out/<platform>/` directories.
- Published executable suffixes are `.elf`, `.exe`, and `.fap`.
- Linux and Windows native executables are Juicer-compressed launchers.
- Compiler output remains separate from platform headers and runtimes.
- Jabara owns JC and Orgasm; Peel owns only Peel utilities; Yuzu owns Yuzu tools.
- The root `build.psh` application list is the initrd manifest.
- `pulp.sys` and `orgasm.fap` remain within their FruityOS size limits.
- BIOS disk payload limits and RAMFS inode layout remain synchronized with their
  writers and inspection tools.

## Host-independent build surface

The build may assume only the host operating system's ability to start its Pish
binary. After that point, all file operations, process launches, compilation,
assembly, compression, copying, deletion, directory creation, and image writing
are performed by Pish or repository-built executables.

## Boot verification

A complete boot reaches the welcome banner and interactive Pish prompt through
BIOS HDD, BIOS floppy, and UEFI paths. The images are:

```text
out/fruityos_hdd.img
out/fruityos_floppy.img
out/fruityos_uefi.img
```

## Implementation limits

FruityOS provides one active user program, volatile RAMFS, VGA text, PS/2
keyboard input, fixed physical reservations, a fixed application window, and
fixed-block kernel allocation. It has no networking, USB, audio, graphics API,
SMP startup, ACPI discovery, general device enumeration, Secure Boot integration,
or persistent storage.
