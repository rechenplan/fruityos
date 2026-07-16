# Getting started

## Supported build hosts

The repository self-hosts on three x86-64 platforms:

| Host | Start command | `$platform` |
| --- | --- | --- |
| Linux | `bin/pish build.psh` | `linux-x86_64` |
| Windows | `bin\pish.exe build.psh` | `windows-x86_64` |
| FruityOS | `bin/pish build.psh` | `fruityos-x86_64` |

Run from the repository root. Pish treats its startup directory as `$root` and
searches `$root/bin` for commands. On Windows the build does not invoke
PowerShell, `cmd.exe`, MSVC, MinGW, or host file utilities. On Linux it does not
invoke a POSIX shell, GCC, NASM, or Make. All orchestration is `.psh` source.

## Exact checked-in executable surface

A host needs only Pish, Orgasm, Juicer, and Concat:

```text
Linux:
  bin/pish
  bin/bootstrap/linux-x86_64/orgasm.elf
  bin/bootstrap/linux-x86_64/juicer.elf
  bin/bootstrap/linux-x86_64/concat.elf

Windows:
  bin/pish.exe
  bin/bootstrap/windows-x86_64/orgasm.exe
  bin/bootstrap/windows-x86_64/juicer.exe
  bin/bootstrap/windows-x86_64/concat.exe

FruityOS:
  bin/pish.fap
  bin/bootstrap/fruityos-x86_64/orgasm.fap
  bin/bootstrap/fruityos-x86_64/juicer.fap
  bin/bootstrap/fruityos-x86_64/concat.fap
```

No compiler binary is checked in. The first `jc` is assembled from
`jabara/src/jbc/jbc.asm`, installed as the host platform executable, and then
replaced by the self-hosted Jabara compiler.

## Build result

The root script builds host Jabara/Peel/Yuzu tools, cross-builds the FruityOS
userland, Seed, and Pulp, constructs the initrd, and writes:

```text
out/fruityos_hdd.img
out/fruityos_floppy.img
out/fruityos_uefi.img
out/fruityos.efi
```

Host component outputs use their native suffix:

```text
out/linux-x86_64/*.elf
out/windows-x86_64/*.exe
out/fruityos-x86_64/*.fap
```

Component outputs live under the corresponding component, for example
`peel/out/windows-x86_64/pish.exe` or
`jabara/out/fruityos-x86_64/orgasm.fap`.

## Startup

Every boot path produces the same kernel handoff. Pulp initializes the kernel,
unpacks the initrd into RAMFS, starts `/bin/pish.fap`, and Pish executes
`/init.psh` before entering the interactive shell.

## Clean

Run `clean.psh` through the same host Pish entrypoint. Cleaning removes generated
component outputs, host replacements in `bin/`, the initrd staging tree, and
final images. It preserves the four checked-in executables for each host, the
Pish launchers, and compiler-driver scripts.
