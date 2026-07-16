# Build system

Run the build from the repository root:

```text
bin/pish build.psh
```

Pish saves that directory as `$root`, exposes the runtime-selected host as
`$platform`, and resolves bare commands through root `bin/`.

## Checked-in toolset

The repository checks in the canonical shell entrypoints:

```text
bin/pish
bin/pish.fap
```

On Linux, `bin/pish` is directly executable as an ELF. On FruityOS, Pish
resolves the same extensionless path to `bin/pish.fap`. Both hosts therefore use
the same command:

```text
bin/pish build.psh
```

The non-shell bootstrap toolsets live under their platform directories:

```text
bin/bootstrap/linux-x86_64/{orgasm,juicer,concat}.elf
bin/bootstrap/fruityos-x86_64/{orgasm,juicer,concat}.fap
```

The stable Orgasm, Juicer, and Concat launchers in root `bin/` invoke
`bin/bootstrap/$platform/<tool>` without spelling an extension. Pish supplies
the extension selected by `$platform`. Bare tool names prefer
`bin/<tool>.<platform-extension>` and fall back to the launcher only while that
host counterpart is absent.

No `jc` executable is checked in. Jabara links the first compiler through the
ordinary `lib/$platform/link.psh`, installs the platform-appropriate `bin/jc`
counterpart, rebuilds the compiler, and installs host Orgasm immediately. Peel
builds Concat, Juicer, and Pish first and installs each platform counterpart into
`bin/` immediately after it links. The checked-in Linux bootstrap `bin/pish` and
canonical FruityOS `bin/pish.fap` are preserved by cleaning; native builds may
also publish the derived `bin/pish.elf` used by normal Pish command lookup.

Linux links create a raw ELF, compress it with Juicer, and concatenate it after
`lib/linux-x86_64/juicer-decode-stub.asm`. The stub mmaps the linked region at
`0x400000`, decodes the ELF there, reads `e_entry`, and transfers control while
preserving the original process stack.

## Root pipeline

The root build runs these stages in order:

1. `jabara/build.psh $platform fruityos-x86_64` builds host and target `jc` and Orgasm;
2. `peel/build.psh $platform` builds and immediately installs the native Peel utilities;
3. `yuzu/build.psh $platform` and `yuzu/build.psh fruityos-x86_64` build Yuzu tools;
4. `peel/build.psh fruityos-x86_64` builds the FruityOS Peel utilities;
5. `seed/build.psh fruityos-x86_64` builds BIOS and UEFI loaders;
6. `pulp/build.psh fruityos-x86_64` builds the kernel;
7. the root script creates the initrd and final boot images.

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

Each Jabara, Peel, and Yuzu build finishes by calling its
`rename-<platform>.psh` helper. Linux executables are published as `.elf` and
FruityOS executables as `.fap`. Pish uses `$platform` to search only the matching
executable extension; it never falls back to the other platform format.

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
tree and final images, and deletes derived platform tools while preserving `bin/pish`, `bin/pish.fap`, the checked-in bootstrap executables under `bin/bootstrap/<platform>/`, and the launcher scripts.
