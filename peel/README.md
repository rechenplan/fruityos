# Peel

Peel is FruityOS's Jabara-written userland. It provides Pish, RAMFS utilities,
Fred, Jar, Juicer, the Jabara compiler, and Orgasm.

## Build

The root build first runs:

```text
peel/build.sh $platform
```

This host bootstrap writes the bootstrap `jc` and all native Peel tools to
`peel/out/$platform/`. It writes nothing to root `bin/`; top-level `build.psh`
performs that installation after the shell script returns.

Later, the root build runs `peel/build.psh fruityos-x86_64`. That target build
writes compressed applications and compiler artifacts to
`peel/out/fruityos-x86_64/`, including `orgasm.fap`, `jc.fap`, `yc.fap`,
`zest.fap`, and `jc.asm`.

The root build installs the selected FAP programs into initrd `/bin`.

See [Shell and userland](../docs/userland.md).
