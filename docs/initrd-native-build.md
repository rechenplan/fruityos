# Initrd and native rebuild

FruityOS boots into a RAM filesystem containing only the files required to
extract and rebuild the packaged checkout. General-purpose host-built utilities
are deliberately excluded; the native build creates and installs them.

## Initrd layout

The generated staging tree is:

```text
initrd/
├── bin/
│   ├── jar.fap
│   ├── juicer.fap
│   ├── orgasm.fap
│   └── pish.fap
├── src/
│   └── fruityos.jz
├── init.psh
└── pulp.sys
```

All Seed variants locate the compressed kernel through the `/pulp.sys` Jar
entry. Pulp receives the Jar start and installs that entry in RAMFS along with
the rest of the initrd.

These four FAPs form the binary bootstrap set:

| Program | Why it must be host-built in the initrd |
| --- | --- |
| `pish` | Runs `/init.psh`, nested build scripts, and external commands. |
| `jar` | Extracts the source checkout. |
| `juicer` | Decompresses the checkout and creates native FAP streams. |
| `orgasm` | Assembles generated FAP assembly inside FruityOS. |

Multifile `jc` and Orgasm eliminate the need for `concat` during bootstrap. The
root native script first builds `/bin/del.fap` from its packaged Jabara source,
then uses it to remove the retained source archives and compiler intermediates.
The Peel build creates `echo.fap` directly in `/bin` before reporting progress,
then writes all remaining applications there as they are built. This removes
`del`, `mkdir`, `echo`, and `copy` from the host-built bootstrap set.

The host uses `jc` to generate the complete compiler assembly, including its FAP
entry and runtime, then compresses it into the source checkout as
`jabara/jc.asm.jz`. At startup, FruityOS extracts the checkout, removes the outer
archive, decompresses the compiler assembly, and has Orgasm assemble it to a
temporary raw binary. Juicer then creates `/bin/jc.fap`. The raw binary and both
assembly forms are deleted, leaving the compiler ready for the native source
build without making it one of the host-assembled bootstrap binaries.

First, `jabara/build.psh` compiles the packaged compiler sources with the
initial compiler and replaces `/bin/jc.fap`. The replacement compiler then
compiles the packaged Orgasm sources; the initial assembler turns that output
into the replacement `/bin/orgasm.fap`. Both Peel and Pulp are built only after
the source-built compiler and assembler are installed.

Utilities such as `dir`, `fred`, `move`, `type`, and `write` are not copied from
the host. They appear in `/bin` only after the native build succeeds.

The bootstrap Orgasm and Juicer FAPs use Jabara's stack-based module calling
convention. Their tight parser and compression loops therefore consume heap only
for explicit records and buffers, rather than allocating a persistent
environment for every helper call while processing the kernel artifacts. The
native userland build preserves this calling convention for the replacement
Juicer installed in `/bin`.

## Source archive

During every host build, the root script stages only the inputs used by the
native rebuild. All `.psh` sources live under host `scripts/`; the four native
build scripts are copied to the following extracted-tree paths:

- the root, Peel, Jabara, and Pulp `.psh` build files;
- all Peel Jabara application sources;
- all Pulp Jabara and handwritten assembly sources;
- the Jabara-written compiler and Orgasm sources;
- `jc-fap-config.jabara`, `pith.jabara`, `fap-module-runtime.asm`,
  `fap-runtime.asm`, and `fap-stack-runtime.asm`;
- the compressed generated Jabara compiler assembly, `jabara/jc.asm.jz`;
- empty Peel and Pulp output directories.

Documentation, host shell scripts, tests, compatibility toolchains, bootloader
sources, and other repository files are not placed in `fruityos.jz`. The host
then creates:

1. `fruityos.jar`, a Jar archive rooted at `fruityos/`;
2. `fruityos.jz`, its Juicer-compressed representation;
3. `initrd/src/fruityos.jz`, the copy embedded in both boot images.

No network access occurs at boot. The extracted `fruityos/` directory is a
minimal native-build source tree rather than a complete repository snapshot.

## Startup script

Pulp launches `/bin/pish.fap`. With no explicit script argument, Pish opens
`/init.psh`. That script performs:

```text
cd /src
juicer d fruityos.jz fruityos.jar
jar x fruityos.jar
cd fruityos
juicer d jabara/jc.asm.jz jabara/jc.asm
orgasm jabara/jc.asm /bin/jc.raw
juicer c /bin/jc.raw /bin/jc.fap
build.psh
```

The archive is rooted at `fruityos/`, so extraction under `/src` recreates the
checkout directory. The root build creates `del.fap` first and immediately
removes the no-longer-needed outer archives, compiler assembly, and raw binary.
When `build.psh` returns, Pish remains in `/src/fruityos` and displays the
interactive prompt.

## Native build sequence

The checkout's root `build.psh` invokes `jabara/build.psh`, `peel/build.psh`,
and then `pulp/build.psh`.

The Peel script first builds `echo` directly in `/bin`, then builds each
ordinary userland application with the source-built `jc` and `orgasm` and the
bootstrap `juicer` tool. Sources and runtime assembly are passed directly to
their multifile tools. Intermediate generated assembly and raw files are
deleted after each application to return their RAMFS blocks;
compressed results replace or extend the applications in `/bin` immediately.

The following applications are rebuilt:

```text
concat copy del dir echo fill fred inode jar juicer mkdir move pish rmdir type write
```

The completion message is executed through the newly built `echo.fap`.

The preceding Jabara stage replaces the initially assembled `jc.fap` and the
bootstrap `orgasm.fap` with FAPs compiled from their packaged Jabara sources.
The Peel stage then replaces its bootstrap utilities using those tools. This
means every FAP in `/bin` at the interactive prompt has been compiled from the
extracted source tree.

The native install changes only RAMFS. It does not modify the boot image or host
working tree and disappears at shutdown.

## Native kernel stage

`pulp/build.psh` passes `platform.jabara` and every kernel implementation to one
multifile `jc` invocation. It then passes the handwritten entry assembly, IDT
assembly, and generated module directly to multifile Orgasm. Orgasm emits
`pulp/bin/pulp.bin`, and Juicer emits `pulp/bin/pulp.sys`. These artifacts do
not replace the running kernel, but they verify that the packaged checkout can
rebuild Pulp entirely inside FruityOS.

## Archive and compression formats

Jar entries contain a NUL-terminated path, an eight-byte size, and raw file
bytes. A zero-length path terminates the archive. Directory paths end in `/`.
The initrd Jar passed to Pulp is not itself compressed.

Juicer is a compact LZ-style stream with a 1024-byte history window. It is used
for the kernel, FAP executables, and the packaged source Jar. Seed, Pulp, and the
userland tool contain compatible decompressors.
