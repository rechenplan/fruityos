# Development, testing, and limitations

## Test suites

Run the integrated Jabara suite with:

```sh
cd jabara
./test.sh
```

It checks the C bootstrap compiler, self-hosted compiler, language features,
expected diagnostics, ELF and FAP generation, Juicer round trips, retained Yuzu
compatibility, and compilation of every Peel program. Linux Peel executables
are left in the repository's top-level `bin/` directory.

Run the assembler-specific suite with:

```sh
./jabara/src/orgasm/test.sh
```

It covers FAP assembly, self-hosting, expression and addressing forms, data and
descriptor directives, and the complete Pulp input.

A release-quality change should normally pass:

```sh
FRUITY_ASSEMBLER=orgasm ./build.sh
./jabara/test.sh
./jabara/src/orgasm/test.sh
git diff --check
```

## Boot verification

`run.sh` exercises the legacy BIOS path and `run-uefi.sh` the OVMF path. A full
verification waits for the native build to finish and the
`/src/fruityos>` prompt to appear; seeing only the firmware or welcome message
does not verify source extraction, target compilation, or `/bin` installation.

For headless UEFI diagnostics, QEMU can expose debug port `0xE9`:

```sh
qemu-system-x86_64 \
  -m 512 \
  -bios /usr/share/qemu/OVMF.fd \
  -drive format=raw,file=fruityos_uefi.img \
  -display none -serial none -debugcon stdio -no-reboot
```

UEFI Seed emits compact progress markers before Pulp starts. Kernel console
characters are then mirrored to the same port, making the entire init and native
build log visible without VGA.

## Machine debugging

From the repository root:

```sh
./debug.sh
```

This starts GDB with `debug.gdb`. GDB launches QEMU paused and enables interrupt
and CPU-reset logging in `log.txt`. Useful fixed addresses include:

| Address | Meaning |
| ---: | --- |
| `0x7c00` | BIOS boot-sector entry. |
| `0x10000` | Kernel dispatch table. |
| `0x10100` | Pulp executable entry. |
| `0xf000` | Permanent IDT. |
| `0x801000` | Current FAP entry in ring 3. |

Because most generated assembly is flat rather than linked with debugging
metadata, inspecting `pulp-generated.asm`, Orgasm output, and fixed addresses is
often more useful than source-level stepping.

## Repository conventions

- New language sources outside `yuzu/` use the `.jabara` suffix.
- Target runtimes remain separate from compiler output.
- Host scripts use temporary directories for generated intermediate files.
- The source archive includes tracked and unignored worktree files, so ignore
  rules are part of the boot-image boundary.
- The system-call table must remain at Pulp offset zero and entry at `0x100`.
- Initrd bootstrap additions should be justified by an actual startup or native
  build dependency. Ordinary utilities should be built inside FruityOS.
- RAMFS inode layout changes must be reflected in both Pulp and the Peel inode
  inspection utility.

## Current limitations

FruityOS is intentionally narrow:

- one active user program and no preemptive scheduler;
- volatile RAMFS with no disk access after boot;
- no networking, USB stack, audio, graphics-mode API, SMP, ACPI discovery, or
  general device enumeration;
- direct VGA text output and PS/2 keyboard input after firmware handoff;
- unsigned EFI application and no Secure Boot integration;
- fixed physical memory reservations and a fixed 128 MiB application window;
- fixed-block kernel allocation with a 1024-byte maximum request;
- no heap/stack collision guard in application space;
- `fork`, `waitpid`, `dup2`, and `mmap` compatibility stubs;
- Pish has no pipes, redirection, quoting, wildcard expansion, or environment;
- native Pulp compilation is split into per-file parts to fit the target
  application arena; the rebuilt artifacts remain in RAMFS and do not replace
  the currently running kernel.

These are descriptions of the present implementation, not compatibility
promises. The project is best treated as a compact OS/toolchain laboratory.
