# Peel

Peel is FruityOS's Jabara-written userland. It provides Pish, RAMFS utilities,
Fred, Jar, Juicer, and image-building tools.

Peel does not own or build Jabara, Orgasm, or Yuzu.

## Build

```text
cd peel
build.psh platform
```

`build.psh $1` compiles only the sources beneath `peel/src/` and writes
extensionless programs to `peel/out/$1/`. The root build first invokes it for
`$platform`, installs the resulting host utilities into root `bin/`, and later
invokes it for `fruityos-x86_64`.

During initrd assembly, the root copies the FruityOS outputs to `/bin` with
`.fap` destination names.

See [Shell and userland](../docs/userland.md).
