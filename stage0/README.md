# Stage 0

Stage 0 contains FruityOS's smallest trusted bootstrap boundary.

The only irreducible executable is [`petit.com`](petit.com), a 254-byte DOS
assembler. Its readable, self-reproducing source is [`petit.pm`](petit.pm).
Petit is platform-blind and knows only a compact byte-emission and symbolic-
fixup language.

## Contents

- `petit.com` — the sole checked-in stage-0 executable blob.
- `petit.pm` — readable source that reproduces `petit.com` exactly.
- `PETIT.md` — complete language, implementation, and bootstrap documentation.
- `orgasm-linux-x86_64.pm` — uncompressed Linux ELF Orgasm bootstrap source.
- `orgasm-windows-x86_64.pm` — uncompressed Windows PE32+ Orgasm bootstrap source.
- `jbc.asm` — generated Orgasm assembly retained for stage-0 bootstrap work.
- `build.bat` — regenerates raw Orgasm bootstraps into `bin/bootstrap/<platform>/`.
- `rebuild-petit.bat` — verifies that Petit reproduces itself byte-for-byte.
- `clean.bat` — removes DOS stage-0 outputs.

The authoritative Jabara source tree remains under `jabara/src/`; stage 0 does
not replace or remove it. Generated assembly in this directory is bootstrap
input, not a competing source language.

## DOS commands

From this directory:

```bat
rebuild-petit.bat
build.bat
```

`build.bat` produces:

```text
../bin/bootstrap/linux-x86_64/orgasm.elf
../bin/bootstrap/windows-x86_64/orgasm.exe
```

Both are raw, uncompressed executables. Petit contains no platform-selection
logic; the batch file simply feeds it the appropriate `.pm` source.

The FruityOS Orgasm `.pm` source is intentionally deferred.

See [`PETIT.md`](PETIT.md) for the complete syntax and implementation notes.
