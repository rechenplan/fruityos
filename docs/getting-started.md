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

## Bootstrap surface

The only irreducible executable is `stage0/petit.com`. Reconstruction starts
under DOS with `stage0/build.bat`, whose 8.3-safe inputs `orglin.pm` and
`orgwin.pm` produce the two seed Orgasm images in `stage0/out`.

Continue with `stage0/linux.sh` or `stage0/win64.bat`. The seed first assembles
`stage0/jbc.asm`; JBC compiles current Orgasm; the seed assembles current
Orgasm once; current Orgasm builds every later output. Either host continuation
cross-builds this complete uncompressed bootstrap set:

```text
stage0/out/orgasm.{elf,exe,fap}
stage0/out/juicer.{elf,exe,fap}
stage0/out/concat.{elf,exe,fap}
stage0/out/pish.{elf,exe,fap}
```

The host `jbc.elf` or `jbc.exe` remains in `stage0/out` as an intermediate. No
bootstrap assembly snapshot is checked in except `stage0/jbc.asm`.

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
