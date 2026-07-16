# Build system

The root build is a Pish script with one small POSIX-shell bootstrap. Start it
from the repository root:

```text
bin/pish build.psh
```

Pish saves that directory as `$root`, exposes the runtime-selected host as
`$platform`, and resolves bare commands through root `bin/`.

## Checked-in bootstrap

The repository checks in:

```text
bin/pish
bin/orgasm
```

The root script first runs:

```text
peel/build.sh $platform
```

That script uses checked-in Orgasm and `jabara/src/jbc/jbc.asm` to create the
bootstrap Jabara compiler. It builds native Peel tools into:

```text
peel/out/$platform/
```

The bootstrap compiler itself is written to `peel/out/$platform/jc`. The shell
script uses it with `lib/$platform/` and the platform linker to build every
native Peel tool in the same output directory. It does not install anything
into root `bin/`.

The top-level `build.psh`, not `peel/build.sh`, installs the completed native
Peel environment, including the bootstrap `jc`, into root `bin/`. Pish itself is replaced by copying to a
temporary name and renaming it over the running executable.

## Root pipeline

The root build runs these stages in order:

1. `peel/build.sh $platform` builds native Peel tools;
2. `build.psh` copies `peel/out/$platform/*` into root `bin/`;
3. `jabara/build.psh $platform` rebuilds Orgasm and self-hosts `jc`;
4. `yuzu/build.psh $platform` builds native Yuzu compatibility tools;
5. `peel/build.psh fruityos-x86_64` builds FruityOS applications;
6. `seed/build.psh fruityos-x86_64` builds BIOS and UEFI loaders;
7. `pulp/build.psh fruityos-x86_64` builds the kernel;
8. the root script assembles the initrd and final boot images.

Every component build receives its output platform explicitly as `$1`.

## Component outputs

Every non-root build script creates a local `out/$1` before writing any
artifacts. Nested builders publish from their local directories into their
component-level `out/$1` when the root build needs a stable component path:

- `jabara/src/orgasm/out/$platform/` and `jabara/src/jc/out/$platform/` — local Jabara tool outputs;
- `jabara/out/$platform/` — published `jc`, `jc-self`, and `orgasm`;
- `yuzu/src/{byc,yc,zest}/out/$platform/` — local Yuzu tool outputs;
- `yuzu/out/$platform/` — published `byc`, `yc`, and `zest`;
- `peel/out/$platform/` — native Peel host tools;
- `peel/out/fruityos-x86_64/` — compressed FAPs and `jc.asm`;
- `seed/src/{fdseed,hdseed,uefiseed}/out/fruityos-x86_64/` — local seed outputs;
- `seed/out/fruityos-x86_64/` — published BIOS loaders and UEFI prefix;
- `pulp/out/fruityos-x86_64/` — flat and compressed kernels.

The top-level final images remain under root `out/`.

## Compiler drivers

Native applications use the generic driver with an explicit platform:

```text
bin/jc.psh $platform output source.jabara
```

FruityOS applications use the explicit target front end:

```text
bin/jc-fruityos-x86_64.psh output.fap source.jabara
```

Both public front ends call the common driver. It selects Pith declarations,
startup assembly, runtime assembly, and linking through `lib/<platform>/`.

## Initrd and images

The root script creates the runtime tree under `initrd/`, copies the selected
FruityOS FAPs from `peel/out/fruityos-x86_64/`, archives it with Jar, and writes:

```text
out/fruityos_hdd.img
out/fruityos_floppy.img
out/fruityos.efi
out/fruityos_uefi.img
```

## Clean

```text
bin/pish clean.psh
```

The cleaner passes the same explicit platform arguments through the component
and nested clean scripts. Each clean script removes its generated files, its
local `out/$1`, and the enclosing `out` directory. The root cleaner also removes
final images and the native Peel tools installed into root `bin/`.
