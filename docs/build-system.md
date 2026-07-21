# Build system

The build graph is Pish source and is identical on Linux x86-64, Windows x86-64,
and FruityOS x86-64. Pish exposes the host as `$platform`, the repository root as
`$root`, and resolves bare executables using the platform suffix `.elf`, `.exe`,
or `.fap`.

## Host entrypoints

```text
Linux:    bin/pish build.psh
Windows:  bin\pish.exe build.psh
FruityOS: bin/pish build.psh
```

## Stage-0 and host bootstrap surfaces

The sole irreducible executable is `stage0/petit.com`. Its readable source,
`stage0/petit.pm`, reproduces it exactly. The DOS phase reads the 8.3-safe
`orglin.pm` and `orgwin.pm` sources and writes the raw seed assemblers beneath
`stage0/out`.

The host continuation first assembles `stage0/jbc.asm`, uses JBC to compile
the bootstrap compiler, uses the seed to assemble current Orgasm once, and then
uses current Orgasm for every later assembly. It produces four uncompressed
files per target directly in `stage0/out`:

| Host | Pish | Orgasm | Juicer | Concat |
| --- | --- | --- | --- | --- |
| Linux | `stage0/out/pish.elf` | `stage0/out/orgasm.elf` | `stage0/out/jus.elf` | `stage0/out/concat.elf` |
| Windows | `stage0/out/pish.exe` | `stage0/out/orgasm.exe` | `stage0/out/jus.exe` | `stage0/out/concat.exe` |
| FruityOS | `stage0/out/pish.fap` | `stage0/out/orgasm.fap` | `stage0/out/jus.fap` | `stage0/out/concat.fap` |

`bin/orgasm.psh`, `bin/jus.psh`, and `bin/concat.psh` dispatch to
`bin/bootstrap/$platform/<tool>` without spelling an extension. Pish appends the
host suffix. As soon as a rebuilt `bin/<tool>.<suffix>` exists, normal binary
lookup selects it before the launcher.

No compiler executable is checked in. JBC creates the first Jabara compiler,
which is installed as `bin/jabara.<suffix>`. The legacy `bin/jb.psh` driver
builds current Orgasm, bootstrap Juicer and Pad, and the first runnable copies
of Haruka and Phobos. Every normal native or cross build after that uses
`bin/jc.psh PLATFORM OUTPUT SOURCE.hr...`, whose platform linker invokes
Phobos.

## Root pipeline

1. `jabara/build.psh $platform fruityos-x86_64` creates Jabara and Orgasm for
   the host and FruityOS.
2. `peel/bootstrap.psh`, `haruka/bootstrap.psh`, and
   `sol/phobos/bootstrap.psh` create the minimal host tools needed to leave the
   legacy chain.
3. Bootstrap Haruka and Phobos rebuild Phobos through
   Haruka -> Sol -> Phobos.
4. That Phobos rebuilds Haruka for the host and FruityOS, then rebuilds itself
   again with the final Haruka frontend.
5. Phobos compiles Mars from `sol/mars`, preserving Mars as a distinct backend
   rather than an alias or renamed copy.
6. Peel, Yuzu, Pulp, and all other Haruka-language native and cross-target
   programs build through the same Phobos-backed `jc.psh` path.
7. The root script stages both `mars.fap` and `phobos.fap` in the initrd and
   produces BIOS and UEFI images.

Every subdirectory build receives its output platform as `$1` and writes only
beneath its own `out/$1`. Rename helpers publish extension-bearing executables:
`.elf`, `.exe`, or `.fap`.


## Pulp mixed-language image

Pulp is linked as two adjacent flat regions. Handwritten x86-64 remains in
Orgasm; Haruka-language kernel sources are compiled by Haruka to Sol and by
Phobos to x86-64 bytes.

```text
Pulp `.hr` sources             -> Haruka -> pulp.sol
pulp.sol at 0x11200            -> Phobos layout map
assembly + Sol map             -> Orgasm -> 0x10000 region + assembly map
pulp.sol + assembly map        -> Phobos -> 0x11200 region
padded assembly + Phobos bytes -> Concat -> pulp.bin -> Juicer -> pulp.sys
```

The handwritten region is fixed at 4,608 bytes (`0x10000` through `0x111ff`).
`pad` rejects an oversized Orgasm result before padding it to that exact size,
so the Phobos origin cannot silently drift. Phobos and Orgasm exchange
absolute symbols as `name equ address` text files. The final
`pad ... 0 8192` command
retains the existing 8 KiB compressed-kernel limit.

## Platform linkers

Each compiler driver selects:

```text
lib/<platform>/pith.hr
lib/<platform>/start.asm
lib/<platform>/runtime.asm
lib/<platform>/trailer.sol
lib/<platform>/link.psh
```

### Linux x86-64

Phobos first exports the Haruka region's symbols. Orgasm uses that map to build
a fixed 1 KiB ELF/startup/runtime prefix, then Phobos resolves the assembly
symbols and emits the adjacent code region. Concat joins both regions; Juicer compresses
the result and a small ELF decode stub enters it at its linked address.

### Windows x86-64

The same two-map protocol builds a fixed 4 KiB PE32+ prefix followed by the Phobos-generated
region. The runtime has no CRT or import library and includes only the
`kernel32.dll` APIs selected by Pith reachability. Juicer compresses that PE and
Concat appends it to a compact PE32+ launcher that:

1. opens its own executable;
2. reads the appended Juicer stream;
3. decodes the raw PE into temporary memory;
4. allocates the payload at its preferred image base;
5. copies the image, resolves its imports with `LoadLibraryA` and
   `GetProcAddress`, and enters its PE entrypoint.

### FruityOS x86-64

The linker combines the flat FruityOS startup/runtime and Juicer format into a
`.fap` entered at the image's first byte.

## No host shell dependency

Build scripts invoke only Pish, `jc`, the three bootstrap tools, and utilities
built from Peel source. They do not invoke Bash, POSIX `cp`/`rm`, PowerShell,
`cmd.exe`, MSVC, MinGW, or platform SDK tools.

## Initrd and clean

The initrd is a boot environment: it contains Pulp, Pish, the Peel user
utilities, the executable compiler/backend toolchain, and the shared Orgone
runtime dictionary. Cross-platform runtimes, linker sources, and other source
files remain in the repository instead of being copied into the boot image.

Cleaning removes component outputs and images while retaining populated,
Git-ignored host tools in `bin/`; this leaves the next normal build runnable.
The exact checked-in bootstrap surface above remains unchanged.
