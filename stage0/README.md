# Stage 0

Stage 0 reconstructs FruityOS's complete bootstrap tool set from one irreducible
binary: the 254-byte DOS program [`petit.com`](petit.com).

Petit is platform-blind. It reads a `.pm` byte source from standard input and
writes the resulting executable image to standard output. It knows nothing
about DOS filenames beyond the redirection performed by the batch file, and it
knows nothing about ELF, PE32+, FAP, Linux, Windows, FruityOS, Jabara, or
Orgasm.

## Checked-in stage0 files

- `petit.com` — the sole irreducible executable.
- `petit.pm` — readable source that reproduces `petit.com` exactly.
- `orglin.pm` — DOS-compatible source name for the raw Linux seed Orgasm.
- `orgwin.pm` — DOS-compatible source name for the raw Windows seed Orgasm.
- `jbc.asm` — the one checked-in generated assembly module used by stage0.
- `build.bat` — DOS seed-materialization phase.
- `repetit.bat` — DOS self-reproduction check for Petit.
- `linux.sh` — Linux x86-64 continuation.
- `win64.bat` — Windows x86-64 continuation.
- `clean.bat` — removes `stage0/out` products.
- `PETIT.md` — Petit language and implementation reference.

Every filename consumed by the DOS phase obeys the 8.3 convention. In
particular, stage0 does not depend on the former long names
`orgasm-linux-x86_64.pm` or `orgasm-windows-x86_64.pm`.

## Why stage0 has two phases

DOS can execute `petit.com`, but it cannot execute the ELF64 or PE32+ images
that Petit emits. Stage0 therefore has a small DOS materialization phase and a
host continuation phase.

From `stage0/` under DOS:

```bat
build.bat
```

This writes only the two seed assemblers:

```text
out/orgseed.elf
out/orgseed.exe
```

Move or expose the same checkout to one supported x86-64 host, remain in the
`stage0/` directory, and run one continuation:

```text
Linux:   ./linux.sh
Windows: win64.bat
```

Only one continuation is required. Either host can cross-build the Linux,
Windows, and FruityOS bootstrap executables.

## Exact dependency order

The continuation deliberately follows this order:

1. The host seed Orgasm assembles `stage0/jbc.asm` with the host startup and
   runtime, producing an uncompressed host JBC executable.
2. JBC compiles the current Orgasm Jabara sources from `jabara/src/orgasm/`.
3. The seed Orgasm assembles that generated module into the current host
   Orgasm executable.
4. The seed is never used again.
5. The current Orgasm assembles every remaining bootstrap executable.
6. JBC compiles Juicer, Concat, and Pish directly from their ordinary sources
   under `peel/src/`.
7. JBC also compiles the current Orgasm module for the two non-host targets;
   the current host Orgasm assembles those cross-target images.
8. Temporary `module.asm` is deleted when the build finishes.

There are no checked-in bootstrap assembly snapshots for Orgasm, Juicer,
Concat, or Pish. The sole checked-in generated assembly input is `jbc.asm`.

## Outputs

A completed continuation leaves the bootstrap products directly in
`stage0/out`:

```text
Linux:
  orgasm.elf
  juicer.elf
  concat.elf
  pish.elf

Windows:
  orgasm.exe
  juicer.exe
  concat.exe
  pish.exe

FruityOS:
  orgasm.fap
  juicer.fap
  concat.fap
  pish.fap
```

It also retains the audit-relevant host intermediates:

```text
Linux continuation:   orgseed.elf, jbc.elf
Windows continuation: orgseed.exe, jbc.exe
```

The outputs are deliberately uncompressed. Juicer and Concat are themselves
part of the reconstructed bootstrap and therefore cannot be prerequisites of
the first JBC or current Orgasm executables.

## Petit self-reproduction

From `stage0/` under DOS:

```bat
repetit.bat
```

The script writes `out/petit2.com` and compares it byte-for-byte with
`petit.com`. Both images must be exactly 254 bytes.
