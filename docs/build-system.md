# Build system

Run the build from the repository root:

```text
bin/pish build.psh
```

Pish saves that directory as `$root`, exposes the runtime-selected host as
`$platform`, and resolves bare commands through root `bin/`.

## Checked-in toolset

The repository checks in exactly four host executables:

```text
bin/pish
bin/orgasm
bin/juicer
bin/concat
```

All four are packed Linux x86-64 executables. No `jc` executable is checked in.
There are no bootstrap build scripts or platform bootstrap linkers.

Jabara owns the compiler bootstrap. `jabara/src/jc/build.psh` links the checked-in
`src/jbc/jbc.asm` through the ordinary `lib/$platform/link.psh`, installs that
first compiler as `bin/jc`, and immediately rebuilds the compiler through the
common driver. Jabara then rebuilds Orgasm and cross-builds both tools for
FruityOS.

Linux links create a raw ELF, compress it with Juicer, and concatenate it after
`lib/linux-x86_64/juicer-decode-stub.asm`. The stub mmaps the linked region at
`0x400000`, decodes the ELF there, reads `e_entry`, and transfers control while
preserving the original process stack.

## Root pipeline

The root build runs these stages in order:

1. `jabara/build.psh $platform fruityos-x86_64` builds host and target `jc` and Orgasm;
2. `peel/build.psh $platform` builds the native Peel utilities;
3. the root installs the native Peel utilities into root `bin/`;
4. `yuzu/build.psh $platform` and `yuzu/build.psh fruityos-x86_64` build Yuzu tools;
5. `peel/build.psh fruityos-x86_64` builds the FruityOS Peel utilities;
6. `seed/build.psh fruityos-x86_64` builds BIOS and UEFI loaders;
7. `pulp/build.psh fruityos-x86_64` builds the kernel;
8. the root script creates the initrd and final boot images.

Every component receives its output platform explicitly as `$1`. Jabara receives
both the host and FruityOS platforms because it must establish the host compiler
before cross-building the target tools.

## Source ownership

Each source directory has one `build.psh` and one `clean.psh`. Build products
remain owned by the component that contains their source:

- `jabara/src/jc/out/<platform>/` — local compiler outputs and the FruityOS compiler module;
- `jabara/src/orgasm/out/<platform>/` — local Orgasm outputs;
- `jabara/out/<platform>/` — published `jc`, `jc-self`, `orgasm`, and target `jc.asm`;
- `peel/out/<platform>/` — Peel userland utilities only;
- `yuzu/src/{byc,yc,zest}/out/<platform>/` — local Yuzu outputs;
- `yuzu/out/<platform>/` — published `byc`, `yc`, and `zest`;
- `seed/src/{fdseed,hdseed,uefiseed}/out/fruityos-x86_64/` — local seed outputs;
- `seed/out/fruityos-x86_64/` — published BIOS loaders and UEFI prefix;
- `pulp/out/fruityos-x86_64/` — flat and compressed kernels.

Component outputs are extensionless. The root initrd manifest assigns `.fap`
names only while copying FruityOS programs into `initrd/bin/`.

The top-level final images remain under root `out/`.

## Compiler drivers

Native and cross-compiled applications use the common driver with an explicit
platform:

```text
bin/jc.psh $platform output source.jabara
bin/jc.psh fruityos-x86_64 output source.jabara
```

The public convenience front ends are:

```text
bin/jc-linux-x86_64.psh
bin/jc-fruityos-x86_64.psh
```

They call the same common driver, which selects Pith declarations, startup
assembly, runtime assembly, and linking through `lib/<platform>/`.

## Initrd and images

The root script creates the runtime tree under `initrd/`, copies target outputs
from Jabara and Peel, archives it with Jar, and writes:

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

The root cleaner invokes each component's `clean.psh`, removes the initrd staging
tree and final images, and deletes derived host tools while preserving the four
checked-in executables.
