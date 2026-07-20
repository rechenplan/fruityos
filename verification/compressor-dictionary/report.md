# Compressor dictionary build verification

## Result

The 24 distinct Phobos-built `.fap` outputs total **65,028 bytes**, below the 64 KiB target of 65,536 bytes.

The build uses a **396-byte preset Juicer dictionary**. This keeps Pulp's fixed assembly region at exactly **4,608 bytes** while still allowing dictionary-backed `.fap` streams.

`pulp.sys` is **7,994 bytes**.

## Build

Command:

```text
bin/pish clean.psh
bin/pish build.psh
```

Build status: **0**. The final build log was empty.

## FAP inventory

| File | Bytes | Path |
|---|---:|---|
| `byc.fap` | 5,325 | `yuzu/out/fruityos-x86_64/byc.fap` |
| `concat.fap` | 709 | `peel/out/fruityos-x86_64/concat.fap` |
| `copy.fap` | 730 | `peel/out/fruityos-x86_64/copy.fap` |
| `del.fap` | 565 | `peel/out/fruityos-x86_64/del.fap` |
| `dir.fap` | 1,016 | `peel/out/fruityos-x86_64/dir.fap` |
| `echo.fap` | 529 | `peel/out/fruityos-x86_64/echo.fap` |
| `fill.fap` | 797 | `peel/out/fruityos-x86_64/fill.fap` |
| `fred.fap` | 1,787 | `peel/out/fruityos-x86_64/fred.fap` |
| `haruka.fap` | 9,904 | `haruka/out/fruityos-x86_64/haruka.fap` |
| `inode.fap` | 1,043 | `peel/out/fruityos-x86_64/inode.fap` |
| `jar.fap` | 1,372 | `peel/out/fruityos-x86_64/jar.fap` |
| `jus.fap` | 2,307 | `peel/out/fruityos-x86_64/jus.fap` |
| `mars.fap` | 10,318 | `sol/mars/out/fruityos-x86_64/mars.fap` |
| `mkdir.fap` | 528 | `peel/out/fruityos-x86_64/mkdir.fap` |
| `move.fap` | 563 | `peel/out/fruityos-x86_64/move.fap` |
| `pad.fap` | 966 | `peel/out/fruityos-x86_64/pad.fap` |
| `phobos.fap` | 10,318 | `sol/phobos/out/fruityos-x86_64/phobos.fap` |
| `pish.fap` | 2,218 | `peel/out/fruityos-x86_64/pish.fap` |
| `rmdir.fap` | 528 | `peel/out/fruityos-x86_64/rmdir.fap` |
| `type.fap` | 678 | `peel/out/fruityos-x86_64/type.fap` |
| `uefi.fap` | 2,304 | `peel/out/fruityos-x86_64/uefi.fap` |
| `write.fap` | 906 | `peel/out/fruityos-x86_64/write.fap` |
| `yc.fap` | 5,325 | `yuzu/out/fruityos-x86_64/yc.fap` |
| `zest.fap` | 4,292 | `yuzu/out/fruityos-x86_64/zest.fap` |
| **TOTAL** | **65,028** | |

## Backend provenance

- `lib/*/link.psh` invokes `phobos` for Sol layout and final emission.
- `pulp/build.psh` invokes `phobos` for both Sol map and final kernel Sol emission.
- Mars source has no source diff from the verified Phobos baseline when generated `out/` files are excluded.
- Mars and Phobos are distinct binaries; `cmp` returns nonzero for both host `.elf` and FruityOS `.fap` outputs.

See `backend-audit.txt` for the exact command/path audit.

## Tests

Passed:

- Phobos backend semantic, compact, data, multi-file, extern, deterministic, and stress tests.
- Phobos/Orgasm mixed-link test.
- Haruka positive and rejection tests using Phobos as the backend.
- Sol parser tests through the normal `jc.psh` / Phobos path.
- Dictionary-compressed Linux executable smoke test.
- QEMU HDD boot to FruityOS shell.
- `echo ok` inside FruityOS.
- `phobos` invocation inside FruityOS returned to the shell without command-not-found output.

Mars note:

- Mars semantic cases and Mars/Orgasm mixed-link pass.
- The independent Mars backend test still fails at its existing compact-size assertion after printing `result=0` and `result=42`; the test expects the stale Mars compact output size. Mars source was not changed.

## QEMU boot log

```text
Booting...
Welcome to FruityOS 0.8.1! 
/> ok 
/> /> 
```
