# Jabara, Haruka, Mars, Orgasm, and Yuzu toolchains

## Self-hosting bootstrap

The bootstrap begins from one irreducible executable: the 254-byte DOS
`stage0/petit.com`. Petit reproduces the seed Orgasm binaries. The host seed
assembles JBC; JBC produces the first Jabara compiler; that compiler builds
current Orgasm and one bootstrap copy each of Haruka and Mars.

Jabara is retained as the bootstrap language. Its sources remain `.jabara`, and
its legacy driver is `bin/jb.psh`. Once bootstrap Haruka and Mars exist, every
ordinary native and cross build uses Haruka -> Sol -> Mars through `bin/jc.psh`.
Peel is then rebuilt through that default chain, followed by the rest of the
system.

## Compiler drivers

```text
bin/jc.psh PLATFORM OUTPUT SOURCE.hr...
bin/jc-linux-x86_64.psh OUTPUT SOURCE.hr...
bin/jc-windows-x86_64.psh OUTPUT SOURCE.hr...
bin/jc-fruityos-x86_64.psh OUTPUT SOURCE.hr...
```

The default driver compiles Haruka source to Sol, lays it out with Mars, and
cross-resolves platform assembly through Orgasm's symbol map. The selected
platform linker adds the executable prefix, startup, Pith wrappers, runtime,
and compression.

Jabara and bootstrap-only inputs use the separate legacy driver:

```text
bin/jb.psh PLATFORM OUTPUT SOURCE.jabara...
```

`jb.psh` invokes the Jabara compiler and the preserved Jabara/Orgasm platform
linker. It is not used by normal application builds.

## Calling convention

Jabara and Haruka use the same callee-clean stack ABI. Arguments are evaluated and pushed left to
right, so the final argument is nearest the return address. Platform runtimes
adapt this ABI to Linux syscalls, the FruityOS syscall table, or Microsoft x64
`kernel32.dll` calls.

## Pith reachability and imports

Haruka emits external calls, and Mars's layout map emits `%define PITH_name` for referenced platform symbols. Orgasm's preprocessor
supports nested `%ifdef`, `%ifndef`, `%else`, and `%endif`; directives in inactive
branches have no side effects. Platform runtimes use those definitions to omit
unreferenced wrappers. The Windows runtime also derives a conditional import
table, so each PE carries only the `kernel32.dll` APIs required by that program.

## Haruka and Mars

Haruka implements the shared language and emits width-neutral Sol:

```text
haruka input.hr [input.hr ...] output.sol
```

Mars consumes one logical Sol stream and emits a raw x86-64 image:

```text
mars input.sol [input.sol ...] output.bin
mars -o ORIGIN -M output.map input.sol [input.sol ...]
```

`-o` supplies an implicit origin when the stream has no `org`. `-M` performs
layout only, permits declared externals to remain unresolved, and writes global
symbols as `name equ address` for a later assembly pass.

## Orgasm

```text
orgasm input.asm [input.asm ...] output
orgasm -m output.map input.asm [input.asm ...] output
```

Inputs share one symbol table. With `-m`, Orgasm writes resolved symbols in the
same `name equ address` format accepted by Sol. Pulp uses the two map modes to
cross-resolve handwritten assembly and Mars-generated code without introducing
an object format or general linker.

Orgasm implements the compact x86-64 subset used by FruityOS. Windows runtime
assembly deliberately works within that subset rather than expanding Orgasm
for isolated instruction forms.

## Windows runtime

Windows programs are native PE32+ console executables, not C or POSIX layers.
The runtime implements the Pith surface with `kernel32.dll`: file handles,
standard I/O, current directory, file operations, directory enumeration,
process creation/waiting, and `VirtualAlloc`-backed memory. Paths are normalized
to forward slashes for Pish scripts. The Jabara heap reserves 128 MiB of virtual
memory, sufficient for the self-hosting compiler workload without increasing
file size.

## Yuzu

`yuzu/build.psh $1` writes `byc`, `yc`, and `zest` beneath
`yuzu/out/$1/`, publishing `.elf`, `.exe`, or `.fap` according to `$1`. Peel does
not own or build Yuzu artifacts.
