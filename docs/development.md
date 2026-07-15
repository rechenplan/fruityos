# Development, testing, and limitations

## Test suites

Build the repository before running the integrated tests:

```sh
./build.sh
./jabara/test.sh
./jabara/src/orgasm/test.sh
git diff --check
```

`jabara/test.sh` checks:

- C and Jabara compiler behavior;
- self-compilation;
- records, closures, stack calls with more than six arguments, startup arguments, and expected diagnostics;
- ELF and FAP output;
- Yuzu compiler and assembler integration;
- Juicer compression round trips when the host utility is available;
- compilation of every Peel program.

`jabara/src/orgasm/test.sh` checks:

- FAP assembly against NASM output;
- a self-assembled Orgasm executable;
- expressions, addressing, descriptors, and output directives;
- assembly of the complete Pulp input.

## Boot verification

Exercise all image paths with:

```sh
./run.sh hdd
./run.sh fd
./run.sh uefi
```

A complete boot reaches the welcome banner and an interactive Pish prompt. The
three paths share the same kernel and initrd but use independent Seed loaders.

For display-free UEFI diagnostics, expose I/O port `0xE9`:

```sh
OVMF=/path/to/OVMF.fd
qemu-system-x86_64 \
  -m 512 \
  -bios "$OVMF" \
  -drive format=raw,file=bin/fruityos_uefi.img \
  -display none \
  -serial none \
  -debugcon stdio \
  -no-reboot
```

UEFI Seed emits progress markers, and the Pulp console mirrors characters to
the same port.

## Repository invariants

- Jabara source files use `.jabara`; Yuzu component sources use `.yuzu`.
- Compiler output remains separate from executable headers and platform
  runtimes.
- Host scripts create generated intermediates in private temporary directories.
- The system-call table occupies Pulp offset zero; executable entry is offset
  `0x100`.
- The root `build.sh` list is the initrd application manifest.
- `pulp.sys` and `orgasm.fap` each remain within their 8 KiB checks.
- The BIOS hard-disk payload remains within 1 MiB.
- The BIOS floppy payload remains within 350,208 bytes.
- RAMFS inode layout changes are reflected in both Pulp and the `inode` utility.

## Implementation limits

FruityOS provides:

- one active user program and no preemptive scheduler;
- a volatile RAMFS and no disk access after boot;
- VGA text output and PS/2 keyboard input;
- fixed physical memory reservations;
- a fixed 128 MiB application window;
- fixed-block kernel allocation with a 1024-byte maximum request;
- no separate user heap/stack collision guard;
- stub implementations of `fork`, `waitpid`, `dup2`, and `mmap`;
- a shell without pipes, redirection, quoting, wildcard expansion, or an
  environment.

It does not provide networking, USB, audio, a graphics API, SMP startup, ACPI
discovery, general device enumeration, Secure Boot integration, or persistent
storage.
