# Peel

Peel is FruityOS's Jabara-written userland. It provides Pish, RAMFS utilities,
Fred, Jar, Juicer, the Jabara compiler, and Orgasm.

## Build

The root Pish build runs `peel/build.psh` after rebuilding Jabara and Yuzu.
Peel writes all generated files to `peel/out/`:

- Linux-hosted `.elf` executables;
- one compressed FAP for each userland program;
- `orgasm.fap`, `jc.fap`, `yc.fap`, and `zest.fap`;
- `jc.asm`, the FAP Jabara compiler module.

Each target is compiled with `jabara/out/jc`, assembled with
`jabara/out/orgasm`, and compressed with the newly built `peel/out/juicer.elf`.
The root build installs the selected FAP programs into initrd `/bin`.

See [Shell and userland](../docs/userland.md).
