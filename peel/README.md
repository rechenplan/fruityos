# Peel

Peel is FruityOS's Jabara-written userland. It provides Pish, RAMFS utilities,
Fred, Jar, Juicer, and image-building tools.

Peel does not own or build Jabara, Orgasm, or Yuzu.

## Build

```text
cd peel
build.psh platform
```

`build.psh $1` compiles only the sources beneath `peel/src/`. Its
`rename-$1.psh` helper publishes Linux programs as `.elf` and FruityOS programs
as `.fap` beneath `peel/out/$1/`, and installs host counterparts into root
`bin/` as soon as they are available. During initrd assembly, the root copies
the already named FruityOS `.fap` outputs into `/bin`.

See [Shell and userland](../docs/userland.md).
