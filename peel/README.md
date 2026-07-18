# Peel

Peel is FruityOS's Jabara-written userland. It provides Pish, RAMFS utilities,
Fred, Jar, Juicer, Jews, and image-building tools.

Peel does not own or build Jabara, Orgasm, or Yuzu.

## Build

```text
cd peel
build.psh platform
```

`build.psh $1` compiles only sources beneath `peel/src/`. Its
`rename-$1.psh` helper publishes Linux programs as `.elf`, Windows programs as
`.exe`, and FruityOS programs as `.fap` beneath `peel/out/$1/`.

For the active host platform, each tool is also installed into root `bin/` as
soon as it is built. Fresh Concat, Juicer, Jews, and other host binaries take precedence
over their bootstrap launchers before later components use them. Windows and
FruityOS rebuild their canonical `pish.exe` or `pish.fap`; Linux publishes
`pish.elf` beside the checked-in native entrypoint `bin/pish`. During initrd
assembly, the root copies the already named FruityOS `.fap` outputs into `/bin`.

All Peel orchestration is Pish source. It uses only `jc`, the checked-in
bootstrap tools, and Peel utilities that have already been built; it does not
invoke host shell utilities.

See [Shell and userland](../docs/userland.md).
