# Build system

FruityOS uses Pish scripts rather than Bash, Make, or a POSIX shell. The root
`build.psh` is the complete build entry point. Every component has matching
`build.psh` and `clean.psh` scripts.

Start the build from the repository root:

```text
bin/pish build.psh
```

Pish saves that directory as its root and resolves bare command names through
the checked-in root `bin/` directory. Generated executables are never placed in
that directory.

## Root pipeline

The root build enters and runs these stages in order:

1. `jabara/build.psh`
2. `yuzu/build.psh`
3. `peel/build.psh`
4. `seed/build.psh`
5. `pulp/build.psh`
6. initrd and image assembly

Every operation is performed by Pish itself or by a Peel/Jabara executable.
There are no calls to host shell commands.

## Bootstrap tools

The checked-in `bin/` directory contains only the tools required before the
repository can rebuild itself:

```text
pish jc orgasm echo mkdir del rmdir copy move
```

`jc` and `orgasm` bootstrap the self-hosted toolchain. The remaining commands
provide the small file-operation surface used by the Pish scripts. `clean.psh`
does not remove these files.

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

The checked-in compiler and assembler first rebuild Orgasm. The rebuilt Orgasm
then assembles a new Jabara compiler, and that compiler produces `jc-self` as a
self-hosting consistency build. The build does not compile or invoke the C
bootstrap compiler.

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

The root cleaner mirrors the build hierarchy, invokes each component cleaner,
removes the initrd staging tree, and removes the top-level `out/` directory.
