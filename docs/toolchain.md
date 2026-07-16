# Jabara, Orgasm, and Yuzu toolchains

FruityOS builds its kernel and userland with Jabara and assembles generated
modules with Orgasm. Yuzu supplies the `byc`, `yc`, and `zest` tools.

## Bootstrap and self-hosting

The top-level `bin/` directory checks in `pish` for Linux and `pish.fap` for
FruityOS. Packed Orgasm, Juicer, and Concat bootstrap executables live under
`bin/bootstrap/<platform>/`. No Jabara compiler executable is checked in.

Jabara owns the bootstrap. `jabara/src/jc/build.psh` links
`jabara/src/jbc/jbc.asm` with the ordinary `lib/$platform/link.psh`, installs
the first `jc`, and immediately rebuilds the compiler through the common driver.
`jabara/src/orgasm/build.psh` then rebuilds and installs Orgasm. The component
publishes host and FruityOS outputs under `jabara/out/<platform>/`.

No C bootstrap compiler or separate bootstrap script is used.

`jc` accepts:

```text
jc input.jabara [input.jabara ...] output.asm
```

Inputs are parsed in command-line order. The output is headerless module
assembly; the compiler does not add a runtime or invoke an assembler.

## Platform application drivers

Use the generic driver for a native application:

```text
bin/jc.psh $platform output source.jabara
```

Use the explicit FruityOS front end for a FruityOS application:

```text
bin/jc-fruityos-x86_64.psh output.fap source.jabara
```

The public Linux front end is `jc-linux-x86_64.psh`. Both front ends call the
common `jc.psh` driver, which selects `lib/<platform>/pith.jabara`, startup
assembly, and runtime assembly.

## Calling convention

Jabara uses a callee-clean stack ABI. Arguments are evaluated and pushed left
to right, so the final argument is nearest the return address. Generated
functions read parameters at positive frame offsets and remove their argument
words when returning. External assembly routines use the same convention.

## Pith stub pruning

The compiler emits one `%define PITH_name` for each referenced external Pith
call. The ELF and FAP runtimes guard their stubs with the corresponding
`%ifdef`, so unreferenced service wrappers do not appear in the program.
Allocation reachability is tracked independently with `JABARA_ALLOC`.

## Orgasm

Orgasm accepts one or more input files followed by an output path:

```text
orgasm input.asm [input.asm ...] output
```

All inputs share one symbol table and are assembled in command-line order.
Orgasm handles the directives, expressions, data forms, and x86-64 instructions
used throughout the repository, including the flat `%define` and `%ifdef`
processing required by Pith stub pruning.

## Yuzu

`yuzu/build.psh $1` uses the rebuilt Jabara tools and writes `byc`, `yc`, and
`zest` to `yuzu/out/$1/`. The root invokes it separately for the host and
FruityOS platforms; Peel does not build Yuzu artifacts.
