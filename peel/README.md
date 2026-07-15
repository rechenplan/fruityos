# Peel

Peel is FruityOS's Jabara-written userland. It provides the Pish shell, RAMFS
utilities, Fred editor, Jar archiver, Juicer compressor, Jabara compiler, and
Orgasm assembler.

## Build

```sh
./build.sh
```

The script recreates `peel/bin/` and produces:

- `jar.elf` and `juicer.elf` for host packaging;
- one compressed FAP for every program under `src/`;
- `orgasm.fap`, `jc.fap`, `yc.fap`, and `zest.fap`;
- `jc.asm`, a Jabara compiler module combined with FAP runtimes.

Each FAP is compiled with `jabara/bin/jc`, assembled with
`jabara/bin/orgasm`, and compressed with `juicer.elf`.

The root build copies these applications into initrd `/bin`:

```text
jar juicer orgasm pish fred dir mkdir del echo concat copy inode
move rmdir type write fill jc
```

See [Shell and userland](../docs/userland.md) for command behavior and file
formats.
