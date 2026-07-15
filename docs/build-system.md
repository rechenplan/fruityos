# Build system

FruityOS uses Pish scripts rather than Bash, Make, or a POSIX shell. The root
`build.psh` is the complete build entry point. Every component has matching
`build.psh` and `clean.psh` scripts.

Start the build from the repository root:

```text
bin/pish build.psh
```

Pish saves that directory as its root and resolves bare command names through
the root `bin/` directory.

## Checked-in bootstrap

Only two executables are checked in:

```text
bin/pish
bin/orgasm
```

The generated assembly module `jabara/src/jbc/jbc.asm` is the Jabara compiler
compiled from the Jabara sources by `jc`. The opening section of `build.psh`
assembles that module with Orgasm to obtain a temporary compiler.

The temporary compiler first builds Peel `echo`, placing it temporarily in
`bin/` before the build prints any status messages. It then compiles the Peel
`mkdir`, `del`, and `rmdir` programs from their Jabara sources. Orgasm turns
those generated modules into temporary Linux executables. No separate bootstrap
script, generic filesystem helper, or additional bootstrap assembly is used.

## Root pipeline

The root build runs these stages in order:

1. `build.psh` assembles the Jabara bootstrap, builds `echo` before its first
   use, and compiles the required Peel file utilities;
2. `jabara/build.psh` rebuilds Orgasm and self-hosts `jc`;
3. `yuzu/build.psh` builds the Yuzu compatibility tools;
4. `peel/build.psh` builds the complete userland and host utilities;
5. `seed/build.psh` builds the BIOS and UEFI loaders;
6. `pulp/build.psh` builds the kernel;
7. the root script assembles the initrd and boot images.

Every operation is performed by Pish itself or by a Peel/Jabara executable.
There are no calls to host shell commands.

## Component outputs

Each component writes generated files to its own `out/` directory:

- `jabara/out/` — rebuilt `jc`, `jc-self`, and `orgasm`;
- `yuzu/out/` — `byc`, `yc`, and `zest`;
- `peel/out/` — Linux executables, compressed FAPs, and `jc.asm`;
- `seed/out/` — BIOS loaders and the UEFI prefix;
- `pulp/out/` — flat and compressed kernels.

Temporary compiler and assembler inputs are written to component `tmp/`
directories and removed as each target completes.

## Jabara

The assembled `jbc` compiler first builds a new Orgasm and then a new `jc`.
That rebuilt compiler produces `jc-self` as the self-hosting consistency build.
The temporary `jbc` executable is removed after the repository toolchain is
available. No C bootstrap compiler is present or invoked.

## Yuzu

The rebuilt Jabara compiler and Orgasm build `byc`, `yc`, and `zest` into
`yuzu/out/`.

## Peel

Peel builds Linux and FAP forms of the userland programs. Its newly built
`juicer.elf` compresses every FAP. The compressed `orgasm.fap` is checked against
its 8 KiB limit. Peel also produces the FAP Jabara compiler module.

## Seed and Pulp

Orgasm assembles the Seed byte-source files into `seed/out/`. Pulp is compiled
as one Jabara module, assembled into `pulp/out/pulp.bin`, compressed to
`pulp/out/pulp.sys`, and checked against its 8 KiB limit.

## Initrd

The root script creates the required runtime tree:

```text
initrd/
├── bin/
├── lib/
├── src/
├── init.psh
└── pulp.sys
```

The `initrd/bin/` directory contains the selected Peel FAP applications.
Jabara runtime assembly is copied to `initrd/lib/`. The rebuilt Jar program
archives the tree as `initrd.jar`.

## Images

The rebuilt Peel commands construct every final image:

- `concat.elf` combines a BIOS seed and the initrd;
- `pad.elf` enforces the BIOS load limits and pads the HDD and floppy images;
- `uefi.elf` combines the UEFI seed prefix and initrd, writes the PE32+
  application, and creates the FAT16 UEFI disk image.

Final images are written to the top-level `out/` directory.

## Clean

```text
bin/pish clean.psh
```

The root cleaner uses the transient cleanup tools produced at the beginning of
the build, mirrors the build hierarchy, removes the initrd staging tree and
generated outputs, and finally removes the transient bootstrap executables.
