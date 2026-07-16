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

## Complete binary bootstrap surface

All executable bootstrap state is under `bin/` and consists of exactly four
files per host:

| Host | Pish | Orgasm | Juicer | Concat |
| --- | --- | --- | --- | --- |
| Linux | `bin/pish` | `bin/bootstrap/linux-x86_64/orgasm.elf` | `.../juicer.elf` | `.../concat.elf` |
| Windows | `bin/pish.exe` | `bin/bootstrap/windows-x86_64/orgasm.exe` | `.../juicer.exe` | `.../concat.exe` |
| FruityOS | `bin/pish.fap` | `bin/bootstrap/fruityos-x86_64/orgasm.fap` | `.../juicer.fap` | `.../concat.fap` |

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
3. `yuzu/build.psh $platform` builds host Yuzu; a second call builds FruityOS Yuzu.
4. `peel/build.psh fruityos-x86_64` builds the target userland.
5. Seed and Pulp build for `fruityos-x86_64`.
6. The root script stages the initrd and produces BIOS and UEFI images.

Every subdirectory build receives its output platform as `$1` and writes only
beneath its own `out/$1`. Rename helpers publish extension-bearing executables:
`.elf`, `.exe`, or `.fap`.

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
