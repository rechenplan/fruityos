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
- `jc`, written in Jabara, is generated first by `jbc` and then by itself.

The resulting compiler emits NASM-compatible assembly. It does not invoke an
assembler or silently add a runtime. See [Toolchain](toolchain.md) and the
[language manual](../jabara/docs/manual.md).

Orgasm is a Zest-compatible assembler written in Jabara. `jbc` generates its
assembly and NASM creates the initial host executable. That executable assembles
`jc`, the self-compiled `jc`, compatibility tools, Peel, and Pulp. Production
NASM use is therefore limited to bootstrapping Orgasm and assembling the Seed
bootloader and firmware sources.

## Userland build

For each Peel program, `peel/build.sh`:

1. passes `jabara/lib/pith.jabara` and the program source to multifile `jc`;
2. selects the FAP origin, startup, allocator, and system calls with runtime
   assembly files;
3. assembles the raw application;
4. compresses it into `peel/bin/<name>.fap` with Juicer.

The script additionally generates the compiler assembly and assembler FAP
needed by the native build. The packaged source archive carries the generated
assembly as `jabara/jc.asm.jz`; FruityOS extracts, decompresses, assembles, and
compresses it during startup instead of embedding a host-assembled `jc.fap`.
Only the bootstrap subset described in
[Initrd and native rebuild](initrd-native-build.md) is placed in the initrd.

## Kernel build

`pulp/build.sh` passes all kernel Jabara sources to one compiler invocation:

```text
jc pulp/src/*.jabara pulp-generated.asm
```

The generated module is assembled with `entry.asm` and `idt.asm`. The system-call
dispatch table must remain at kernel offset zero and executable entry remains at
offset `0x100`. The selected assembler emits `pulp.bin`; host Juicer produces
`pulp.sys`.

The native build uses the same single multifile compiler invocation, passes the
three assembly inputs directly to the newly source-built Orgasm, and compresses
the result with Juicer. The native Jabara compiler and Orgasm rebuild runs
before both userland and kernel builds.

## Native source archive

The root build copies an explicit native-source manifest to a temporary
`fruityos/` tree. Native scripts are stored together under host `scripts/` and
copied into their expected root and component `build.psh` paths in the staged
tree. Peel and Pulp sources, the Jabara-written compiler and Orgasm sources,
and their Jabara library/runtime files are added alongside them. The build adds
the generated `jabara/jc.asm.jz`, creates a Jar archive, and compresses it to
`initrd/src/fruityos.jz`.

Documentation, host shell scripts, tests, Yuzu compatibility sources,
bootloader sources, and unrelated repository files are excluded. The
uncompressed host-built `pulp.bin` is also omitted so the legacy BIOS image
remains within its 1 MiB load window.

## Initrd and image assembly

The initrd staging tree contains `/pulp.sys`, the minimal host-built bootstrap
applications, two target runtime assembly files, `/init.psh`, and the
compressed native source archive. Host Jar turns this tree into `initrd.jar`.

The BIOS image is a direct concatenation:

```text
hdseed.bin + initrd.jar + zero padding
```

The build rejects an unpadded BIOS payload larger than 1 MiB instead of
silently truncating it.

The floppy image similarly combines `fdseed.bin` and `initrd.jar`, then pads to
1.44 MiB. Every seed scans the Jar records for `/pulp.sys`; no image depends on
its archive position.

The UEFI build embeds `initrd.jar` in `bin/fruityos.efi`, then places that
application at the standard removable-media path inside
`bin/fruityos_uefi.img`. All final OS images are written below top-level `bin/`.

## Reproducibility boundaries

The build avoids timestamps in the custom Jar and Juicer formats and writes a
zero PE timestamp. The staged native inputs reflect the current worktree, and
tool output can depend on the installed compiler, NASM, and shell versions. The
UEFI FAT image uses fixed geometry and directory entries rather than invoking a
host filesystem formatter.
