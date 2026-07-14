# Build system

FruityOS uses small shell scripts instead of Make. The root `build.sh` is the
authoritative host build; each component also has a local build script.

## Pipeline

The root build executes these stages in order:

1. `jabara/build.sh` builds the C bootstrap compiler, the self-hosted Jabara
   compiler, and Orgasm.
2. `yuzu/build.sh` produces the retained Yuzu compatibility programs with the
   current Jabara toolchain.
3. `peel/build.sh` compiles the FruityOS userland into compressed FAP files. It
   also creates Linux Jar and Juicer programs needed by the host packaging
   stages.
4. `seed/build.sh` assembles the BIOS boot sectors.
5. `pulp/build.sh` compiles Pulp with Jabara, combines generated and handwritten
   assembly, assembles the flat kernel, and compresses it with Juicer.
6. The root script constructs a source snapshot, initrd, BIOS image, standalone
   EFI application, and UEFI disk image.

Every stage stops on its first failed command. Temporary host build directories
are created below `${TMPDIR:-/tmp}` and removed by traps.

## Jabara bootstrap

Jabara has two implementations of the same compiler interface:

- `jbc`, written in C, establishes the bootstrap compiler;
- `jc`, written in Jabara, is compiled first by `jbc` and then by itself.

The resulting compiler emits NASM-compatible assembly. It does not invoke an
assembler or silently add a runtime. See [Toolchain](toolchain.md) and the
[language manual](../jabara/docs/manual.md).

Orgasm is a Zest-compatible assembler written in Jabara. Its host executable is
built after `jc`. The Pulp build selects it when `FRUITY_ASSEMBLER=orgasm`; NASM
remains the default and is still required by bootstrap and bootloader stages.

## Userland build

For each Peel program, `peel/build.sh`:

1. concatenates `jabara/lib/pith.jabara` with the program source;
2. invokes `jc fap` to generate assembly at the FruityOS application origin;
3. appends `jabara/lib/fap-runtime.asm`;
4. assembles the raw application;
5. compresses it into `peel/bin/<name>.fap` with Juicer.

The script additionally installs the compiler and assembler FAPs needed by the
native build. The host build creates the complete set, but only the bootstrap
subset described in [Initrd and native rebuild](initrd-native-build.md) is
placed in the initrd.

## Kernel build

`pulp/build.sh` concatenates `pulp/src/platform.jabara` and all kernel Jabara
sources, then invokes:

```text
jc module pulp.jabara pulp-generated.asm
```

The generated module is combined with `entry.asm` and `idt.asm`. The system-call
dispatch table must remain at kernel offset zero and executable entry remains at
offset `0x100`. The selected assembler emits `pulp.bin`; host Juicer produces
`pulp.sys`.

As part of source packaging, the root build also places the current generated
Pulp assembly and `pulp.bin` in the archived checkout. The native build does not
reuse those artifacts: it compiles each implementation as a namespaced `part`,
combines the parts with one module containing shared globals, assembles them
with Orgasm, and compresses the result with Juicer.

## Source snapshot

The packaged checkout is not a downloaded release. It is a snapshot of all
tracked and unignored files in the current worktree, selected with:

```text
git ls-files --cached --others --exclude-standard
```

The selected paths are copied to a temporary `fruityos/` tree. The build adds
`pulp/pulp-generated.asm` and the current `pulp/pulp.bin`, creates a Jar archive,
and compresses it to `initrd/src/fruityos.jz`.

This means uncommitted, unignored source files are deliberately included in the
booted checkout. Generated files ignored by Git are excluded unless the build
explicitly stages them.

## Initrd and image assembly

The initrd staging tree contains the minimal host-built bootstrap applications,
two target runtime assembly files, `/init.psh`, and the compressed source
snapshot. Host Jar turns this tree into `initrd.jar`.

The BIOS image is a direct concatenation:

```text
hdseed.bin + pulp.sys + initrd.jar + zero padding
```

The UEFI build embeds `pulp.sys` and `initrd.jar` in `fruityos.efi`, then places
that application at the standard removable-media path inside
`fruityos_uefi.img`.

## Reproducibility boundaries

The build avoids timestamps in the custom Jar and Juicer formats and writes a
zero PE timestamp. The source snapshot nevertheless reflects the current
worktree, and tool output can depend on the installed compiler, NASM, and shell
versions. The UEFI FAT image uses fixed geometry and directory entries rather
than invoking a host filesystem formatter.
