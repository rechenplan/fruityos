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
│   ├── copy.fap
│   ├── del.fap
│   ├── echo.fap
│   ├── jar.fap
│   ├── juicer.fap
│   ├── mkdir.fap
│   ├── orgasm.fap
│   └── pish.fap
├── lib/
│   ├── elf-runtime.asm
│   └── fap-runtime.asm
├── src/
│   └── fruityos.jz
└── init.psh
```

These nine FAPs form the binary bootstrap set:

| Program | Why it must be host-built in the initrd |
| --- | --- |
| `pish` | Runs `/init.psh`, nested build scripts, and external commands. |
| `echo` | Reports init and build progress. |
| `mkdir` | Creates `/src/fruityos` and native build directories. |
| `del` | Removes the temporary decompressed source Jar. |
| `jar` | Extracts the source checkout. |
| `juicer` | Decompresses the checkout and creates native FAP streams. |
| `concat` | Combines Jabara sources, generated assembly, and runtimes. |
| `orgasm` | Assembles generated FAP assembly inside FruityOS. |
| `copy` | Installs the freshly built userland into `/bin`. |

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

During every host build, the root script snapshots all tracked and unignored
worktree files. It adds the compressed generated Jabara compiler assembly and
the current Pulp assembly, then
creates:

1. `fruityos.jar`, a Jar archive rooted at `fruityos/`;
2. `fruityos.jz`, its Juicer-compressed representation;
3. `initrd/src/fruityos.jz`, the copy embedded in both boot images.

No network access occurs at boot. “Repository” refers to the packaged current
worktree, including uncommitted files that are neither ignored nor generated
outside the explicit staging rules.

## Startup script

Pulp launches `/bin/pish.fap`. With no explicit script argument, Pish opens
`/init.psh`. That script performs:

```text
mkdir /src/fruityos
cd /src/fruityos
juicer d ../fruityos.jz ../fruityos.jar
jar x ../fruityos.jar
del ../fruityos.jar ../fruityos.jz
juicer d jabara/jc.asm.jz jabara/jc.asm
orgasm f jabara/jc.asm /bin/jc.raw
juicer c /bin/jc.raw /bin/jc.fap
del /bin/jc.raw jabara/jc.asm jabara/jc.asm.jz
build.psh
```

The extracted archive has `fruityos/` as its root contents, so the working
directory becomes the checkout itself. When `build.psh` returns, Pish remains
in `/src/fruityos` and displays the interactive prompt.

## Native build sequence

The checkout's root `build.psh` invokes `peel/build.psh` and then
`pulp/build.psh`.

The Peel script builds each ordinary userland application with the bootstrap
`concat`, `jc`, `orgasm`, and `juicer` tools. Intermediate Jabara, assembly, and
raw files are deleted after each application to return their RAMFS blocks;
compressed results remain in `peel/bin` inside the checkout.

The following applications are rebuilt:

```text
concat copy del dir echo fill fred inode jar juicer mkdir move pish rmdir type write
```

After every build succeeds, the script explicitly copies all sixteen FAP files
from `peel/bin` to `/bin`. `copy.fap` copies its own replacement early in this
phase; later copy commands therefore exercise the native binary. The following
completion message is also executed through the newly installed `echo.fap`.

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
