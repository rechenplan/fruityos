# Jabara, Haruka, Phobos, Mars, Orgasm, and Yuzu toolchains

## Self-hosting bootstrap

The bootstrap begins from the 254-byte DOS `stage0/petit.com`. Petit reproduces
the seed Orgasm binaries. The host seed assembles JBC; JBC produces the first
Jabara compiler; Jabara builds current Orgasm, bootstrap Juicer and Pad, and
one bootstrap copy each of Haruka and Phobos.

Jabara remains the bootstrap language. Its sources use `.jabara`, and
`bin/jb.psh` is the bootstrap-only compiler driver. Once bootstrap Haruka and
Phobos exist, ordinary native and cross builds use Haruka -> Sol -> Phobos
through `bin/jc.psh`.

The normal build self-rebuilds Phobos, rebuilds Haruka, and then rebuilds Phobos
again with the final Haruka frontend. Mars is subsequently compiled from
`sol/mars` by that Phobos-backed path. Mars and Phobos are separate programs;
neither output is copied over or aliased to the other.

## Compiler drivers

```text
bin/jc.psh PLATFORM OUTPUT SOURCE.hr...
bin/jc-linux-x86_64.psh OUTPUT SOURCE.hr...
bin/jc-windows-x86_64.psh OUTPUT SOURCE.hr...
bin/jc-fruityos-x86_64.psh OUTPUT SOURCE.hr...
```

The default driver compiles Haruka source to Sol. The selected platform
`link.psh` invokes Phobos for layout and emission, cross-resolves platform
assembly through Orgasm's symbol map, adds the platform startup/runtime, and
compresses the result.

Bootstrap-only inputs use:

```text
bin/jb.psh PLATFORM OUTPUT SOURCE.jabara...
```

`jb.psh` invokes Jabara and the preserved Jabara/Orgasm platform linker. It is
not used for final Haruka-language components.

## Backend roles

Haruka accepts the shared source language and emits width-neutral Sol:

```text
haruka input.hr [input.hr ...] output.sol
```

Phobos is the active production x86-64 backend:

```text
phobos input.sol [input.sol ...] output.bin
phobos -o ORIGIN -M output.map input.sol [input.sol ...]
```

Mars implements the same backend contract from its own source tree and remains
installed for comparison, diagnostics, and continued development:

```text
mars input.sol [input.sol ...] output.bin
mars -o ORIGIN -M output.map input.sol [input.sol ...]
```

`-o` supplies an implicit origin when the stream has no `org`. `-M` performs
layout only, permits declared externals to remain unresolved, and writes global
symbols as `name equ address` for a later Orgasm pass.

Both `mars.fap` and `phobos.fap` are installed in the FruityOS initrd. The
compiler frontends and copied platform linker scripts call `phobos`, so builds
performed inside FruityOS use the same backend as host builds.

## Calling convention

Jabara and Haruka use the same callee-clean stack ABI. Arguments are evaluated
and pushed left to right, so the final argument is nearest the return address.
Platform runtimes adapt this ABI to Linux syscalls, the FruityOS syscall table,
or Microsoft x64 `kernel32.dll` calls.

## Pith reachability and imports

Haruka emits external calls, and Phobos's layout map emits `%define PITH_name`
for referenced platform symbols. Orgasm supports nested `%ifdef`, `%ifndef`,
`%else`, and `%endif`; directives in inactive branches have no side effects.
Platform runtimes use those definitions to omit unreferenced wrappers. The
Windows runtime also derives a conditional import table, so each PE carries
only the `kernel32.dll` APIs required by that program.

## Orgasm

```text
orgasm input.asm [input.asm ...] output
orgasm -m output.map input.asm [input.asm ...] output
```

Inputs share one symbol table. With `-m`, Orgasm writes resolved symbols in the
same `name equ address` format accepted by Sol backends. Pulp uses the two map
modes to cross-resolve handwritten assembly and Phobos-generated code without
an object format or general linker.

## Windows runtime

Windows programs are native PE32+ console executables, not C or POSIX layers.
The runtime implements the Pith surface with `kernel32.dll`: file handles,
standard I/O, current directory, file operations, directory enumeration,
process creation/waiting, and `VirtualAlloc`-backed memory. Paths are normalized
to forward slashes for Pish scripts.

## Yuzu

`yuzu/build.psh $1` writes `byc`, `yc`, and `zest` beneath `yuzu/out/$1/`,
publishing `.elf`, `.exe`, or `.fap` according to `$1`. Each Haruka-language
Yuzu component is linked by Phobos through `jc.psh`.
