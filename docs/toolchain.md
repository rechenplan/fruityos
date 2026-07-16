# Jabara, Orgasm, and Yuzu toolchains

## Self-hosting bootstrap

Linux, Windows, and FruityOS each start from four checked-in executables: Pish,
Orgasm, Juicer, and Concat. They are all contained under `bin/`; no compiler
binary, C compiler, shell toolchain, assembler package, or platform SDK is
required.

Jabara owns compiler bootstrap. `jabara/src/jc/build.psh` links
`jabara/src/jbc/jbc.asm` with `lib/$platform/link.psh`, installs the first host
`jc`, rebuilds `jc` through the common driver, and then rebuilds Orgasm. Peel
rebuilds Concat, Juicer, Pish, and the remaining host tools. The root then
cross-builds FruityOS.

## Compiler drivers

```text
bin/jc.psh PLATFORM OUTPUT SOURCE...
bin/jc-linux-x86_64.psh OUTPUT SOURCE...
bin/jc-windows-x86_64.psh OUTPUT SOURCE...
bin/jc-fruityos-x86_64.psh OUTPUT SOURCE...
```

`jc` itself emits headerless x86-64 module assembly:

```text
jc input.jabara [input.jabara ...] output.asm
```

The selected platform linker adds headers, startup, Pith wrappers, runtime, and
compression.

## Calling convention

Jabara uses a callee-clean stack ABI. Arguments are evaluated and pushed left to
right, so the final argument is nearest the return address. Platform runtimes
adapt this ABI to Linux syscalls, the FruityOS syscall table, or Microsoft x64
`kernel32.dll` calls.

## Pith reachability and imports

JC emits `%define PITH_name` for referenced external calls. Orgasm's preprocessor
supports nested `%ifdef`, `%ifndef`, `%else`, and `%endif`; directives in inactive
branches have no side effects. Platform runtimes use those definitions to omit
unreferenced wrappers. The Windows runtime also derives a conditional import
table, so each PE carries only the `kernel32.dll` APIs required by that program.

## Orgasm

```text
orgasm input.asm [input.asm ...] output
```

Inputs share one symbol table. Orgasm implements the compact x86-64 subset used
by FruityOS. Windows runtime assembly deliberately works within that subset
rather than expanding Orgasm for isolated instruction forms.

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
