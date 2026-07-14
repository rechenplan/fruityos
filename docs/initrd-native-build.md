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
│   ├── jc.fap
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

These ten FAPs form the bootstrap set:

| Program | Why it must be host-built in the initrd |
| --- | --- |
| `pish` | Runs `/init.psh`, nested build scripts, and external commands. |
| `echo` | Reports init and build progress. |
| `mkdir` | Creates `/src/fruityos` and native build directories. |
| `del` | Removes the temporary decompressed source Jar. |
| `jar` | Extracts the source checkout. |
| `juicer` | Decompresses the checkout and creates native FAP streams. |
| `concat` | Combines Jabara sources, generated assembly, and runtimes. |
| `jc` | Compiles Jabara sources into FAP assembly. |
| `orgasm` | Assembles generated FAP assembly inside FruityOS. |
| `copy` | Installs the freshly built userland into `/bin`. |

Utilities such as `dir`, `fred`, `move`, `type`, and `write` are not copied from
the host. They appear in `/bin` only after the native build succeeds.

## Source archive

During every host build, the root script snapshots all tracked and unignored
worktree files. It adds the current generated Pulp assembly and binary, then
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
del ../fruityos.jar
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
raw files live in `peel/tmp`; compressed results remain in `peel/bin` inside the
checkout.

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

The host packages `pulp/pulp-generated.asm` and `pulp/pulp.bin` from the current
sources. Full target-side parsing of the combined Pulp input exceeds the current
application arena, so `pulp/build.psh` identifies that current generated binary
as ready instead of launching a build that would exhaust memory.

This is different from silently retaining an old kernel: the host build always
regenerates `pulp.bin` before packaging the source tree. Native userland remains
fully rebuilt and installed on every boot.

## Archive and compression formats

Jar entries contain a NUL-terminated path, an eight-byte size, and raw file
bytes. A zero-length path terminates the archive. Directory paths end in `/`.
The initrd Jar passed to Pulp is not itself compressed.

Juicer is a compact LZ-style stream with a 1024-byte history window. It is used
for the kernel, FAP executables, and the packaged source Jar. Seed, Pulp, and the
userland tool contain compatible decompressors.
