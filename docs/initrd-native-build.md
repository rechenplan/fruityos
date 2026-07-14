# Initrd and native rebuild

FruityOS boots into a RAM filesystem containing only the files required to
extract and rebuild the packaged checkout. General-purpose host-built utilities
are deliberately excluded; the native build creates and installs them.

## Initrd layout

The generated staging tree is:

```text
initrd/
├── bin/
│   ├── concat.fap
│   ├── del.fap
│   ├── jar.fap
│   ├── juicer.fap
│   ├── orgasm.fap
│   └── pish.fap
├── lib/
│   ├── elf-runtime.asm
│   └── fap-runtime.asm
├── src/
│   └── fruityos.jz
└── init.psh
```

These six FAPs form the binary bootstrap set:

| Program | Why it must be host-built in the initrd |
| --- | --- |
| `pish` | Runs `/init.psh`, nested build scripts, and external commands. |
| `del` | Removes the temporary decompressed source Jar. |
| `jar` | Extracts the source checkout. |
| `juicer` | Decompresses the checkout and creates native FAP streams. |
| `concat` | Combines Jabara sources, generated assembly, and runtimes. |
| `orgasm` | Assembles generated FAP assembly inside FruityOS. |

The source archive contains the empty native output directories. The Peel build
creates `echo.fap` directly in `/bin` before reporting progress, then writes all
remaining applications there as they are built. This removes `mkdir`, `echo`,
and `copy` from the host-built bootstrap set.

The host uses `jc` to generate the complete compiler assembly, including its FAP
entry and runtime, then compresses it into the source checkout as
`jabara/jc.asm.jz`. At startup, FruityOS extracts the checkout, removes the outer
archive, decompresses the compiler assembly, and has Orgasm assemble it to a
temporary raw binary. Juicer then creates `/bin/jc.fap`. The raw binary and both
assembly forms are deleted, leaving the compiler ready for the native source
build without making it one of the host-assembled bootstrap binaries.

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
native rebuild:

- the root, Peel, and Pulp `.psh` build files;
- all Peel Jabara application sources;
- all Pulp Jabara and handwritten assembly sources;
- `pith.jabara`, `fap-runtime.asm`, and `fap-stack-runtime.asm`;
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
del fruityos.jz
jar x fruityos.jar
del fruityos.jar
cd fruityos
juicer d jabara/jc.asm.jz jabara/jc.asm
orgasm f jabara/jc.asm /bin/jc.raw
juicer c /bin/jc.raw /bin/jc.fap
del /bin/jc.raw jabara/jc.asm jabara/jc.asm.jz
build.psh
```

The archive is rooted at `fruityos/`, so extraction under `/src` recreates the
checkout directory. Deleting each outer archive as soon as it is no longer
needed bounds peak RAMFS use. When `build.psh` returns, Pish remains in
`/src/fruityos` and displays the interactive prompt.

## Native build sequence

The checkout's root `build.psh` invokes `peel/build.psh` and then
`pulp/build.psh`.

The Peel script first builds `echo` directly in `/bin`, then builds each
ordinary userland application with the bootstrap `concat`, `jc`, `orgasm`, and
`juicer` tools. Intermediate Jabara, assembly, and raw files are deleted after
each application to return their RAMFS blocks; compressed results replace or
extend the applications in `/bin` immediately.

The following applications are rebuilt:

```text
concat copy del dir echo fill fred inode jar juicer mkdir move pish rmdir type write
```

The completion message is executed through the newly built `echo.fap`.

The native install changes only RAMFS. It does not modify the boot image or host
working tree and disappears at shutdown.

## Native kernel stage

`pulp/build.psh` compiles each kernel implementation file separately with
`jc part`. Each compiler input combines `platform.jabara`, which provides the
shared extern declarations and global names, with one implementation file.
The small inputs stay within the target-side compiler arena.

Part output namespaces compiler-private labels and omits repeated global
storage. The platform declarations are compiled once with `jc module` to emit
the shared global block. Native `concat` combines the handwritten entry and IDT
assembly, all generated parts, and that global block; Orgasm emits
`pulp/bin/pulp.bin`, and Juicer emits `pulp/bin/pulp.sys`. These artifacts do not
replace the running kernel, but they verify that the packaged checkout can
rebuild Pulp entirely inside FruityOS.

## Archive and compression formats

Jar entries contain a NUL-terminated path, an eight-byte size, and raw file
bytes. A zero-length path terminates the archive. Directory paths end in `/`.
The initrd Jar passed to Pulp is not itself compressed.

Juicer is a compact LZ-style stream with a 1024-byte history window. It is used
for the kernel, FAP executables, and the packaged source Jar. Seed, Pulp, and the
userland tool contain compatible decompressors.
