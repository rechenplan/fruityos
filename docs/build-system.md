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
current Orgasm, uses the seed to assemble current Orgasm once, and then uses
current Orgasm for every later assembly. It produces four uncompressed files
per target directly in `stage0/out`:

| Host | Pish | Orgasm | Juicer | Concat |
| --- | --- | --- | --- | --- |
| Linux | `stage0/out/pish.elf` | `stage0/out/orgasm.elf` | `stage0/out/juicer.elf` | `stage0/out/concat.elf` |
| Windows | `stage0/out/pish.exe` | `stage0/out/orgasm.exe` | `stage0/out/juicer.exe` | `stage0/out/concat.exe` |
| FruityOS | `stage0/out/pish.fap` | `stage0/out/orgasm.fap` | `stage0/out/juicer.fap` | `stage0/out/concat.fap` |

`bin/orgasm.psh`, `bin/juicer.psh`, and `bin/concat.psh` dispatch to
`bin/bootstrap/$platform/<tool>` without spelling an extension. Pish appends the
host suffix. As soon as a rebuilt `bin/<tool>.<suffix>` exists, normal binary
lookup selects it before the launcher.

No `jc` executable is checked in. Jabara uses the ordinary host linker to create
and install the first compiler, then every subsequent native or cross build uses
`bin/jc.psh PLATFORM OUTPUT SOURCES...`.

## Root pipeline

1. `jabara/build.psh $platform fruityos-x86_64` creates host `jc`/Orgasm and
   cross-builds their FruityOS forms.
2. `peel/build.psh $platform` builds and immediately installs the host Peel tools.
3. Haruka and Mars are built for the host and for FruityOS.
4. `yuzu/build.psh $platform` builds host Yuzu; a second call builds FruityOS Yuzu.
5. `peel/build.psh fruityos-x86_64` builds the target userland.
6. Seed and Pulp build for `fruityos-x86_64`.
7. The root script stages the initrd and produces BIOS and UEFI images.

Every subdirectory build receives its output platform as `$1` and writes only
beneath its own `out/$1`. Rename helpers publish extension-bearing executables:
`.elf`, `.exe`, or `.fap`.


## Pulp mixed-language image

Pulp is linked as two adjacent flat regions. Handwritten x86-64 remains in
Orgasm; Jabara-language kernel sources are compiled by Haruka to Sol and by
Mars to x86-64 bytes.

```text
Jabara-language Pulp sources -> Haruka -> pulp.sol
pulp.sol at 0x11200         -> Mars layout map
assembly + Sol map          -> Orgasm -> 0x10000 region + assembly map
pulp.sol + assembly map     -> Mars -> 0x11200 region
padded assembly + Mars bytes -> Concat -> pulp.bin -> Juicer -> pulp.sys
```

The handwritten region is fixed at 4,608 bytes (`0x10000` through `0x111ff`).
`pad` rejects an oversized Orgasm result before padding it to that exact size,
so the Mars origin cannot silently drift. Mars and Orgasm exchange absolute
symbols as `name equ address` text files. The final `pad ... 0 8192` command
retains the existing 8 KiB compressed-kernel limit.

## Platform linkers

Each compiler driver selects:

```text
lib/<platform>/pith.jabara
lib/<platform>/start.asm
lib/<platform>/runtime.asm
lib/<platform>/link.psh
```

### Linux x86-64

Orgasm creates a raw static ELF. Juicer compresses it. Concat appends the stream
to a small ELF launcher, which mmaps the decoded image at `0x400000`, reads
`e_entry`, restores the native process stack, and enters it.

### Windows x86-64

Orgasm creates a one-section PE32+ console image with 512-byte file and section
alignment, no CRT, no import library, and only the `kernel32.dll` APIs selected
by Pith reachability. Juicer compresses that PE. Concat appends it to a compact
PE32+ launcher that:

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

The root build copies the Windows compiler frontend and runtime sources into the
FruityOS initrd, so FruityOS can cross-build Windows `.exe` files. Cleaning
removes generated `.elf`, `.exe`, and `.fap` files while preserving the exact
checked-in bootstrap surface above.
