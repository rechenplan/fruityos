# FruityOS

This is the Sol branch.

FruityOS is a small, monotasking 64-bit operating system for x86 PCs. It boots
through BIOS or x86-64 UEFI, starts the Jabara-written Pulp kernel, unpacks a
volatile RAM filesystem, and launches the Pish shell in ring 3.

It is also a self-hosting language and operating-system laboratory. The
repository contains its compiler, assembler, shell, userland, bootloaders,
kernel, archive format, compressor, and image-building tools. The same Pish
build graph runs on Linux x86-64, Windows x86-64, and FruityOS x86-64 without a
C compiler, Make, NASM, a POSIX shell, PowerShell, or `cmd.exe`.

The complete toolchain can be reconstructed from one irreducible executable,
the 254-byte DOS assembler `stage0/petit.com`; the process is documented in
[Stage 0 reconstruction](stage0/README.md).

## Build

On Linux, Windows, and FruityOS, run the native Pish entrypoint from the repository root:

```text
bin/pish build.psh
```

The build writes BIOS and UEFI images beneath `out/`. See
[Getting started](docs/getting-started.md) for bootstrap requirements, outputs,
cleanup, and first-boot behavior.

After you have built FruityOS, if you would like to run the FruityOS userland in your host environment you may type

```text
bin/pish
```

## Documentation

- [Documentation index](docs/README.md)
- [Repository layout](docs/repository-layout.md)
- [Build system](docs/build-system.md)
- [Executable formats](docs/executable-formats.md)
- [Toolchains](docs/toolchain.md)
- [Stage 0 reconstruction](stage0/README.md)
- [Kernel architecture](docs/kernel.md)
- [Shell and userland](docs/userland.md)

FruityOS is experimental. It is intentionally much smaller and less general
than a Unix-compatible operating system.


## Sol toolchain

- [`sol/`](sol/) defines the width-neutral Sol IR, its shared streaming parser,
  and the Mars x86-64 flat-binary backend.
- [`haruka/`](haruka/) is the default `.hr` compiler frontend and emits Sol.
- [`sol/phobos/`](sol/phobos/) preserves the radical threaded-control Mars backend as an independently buildable host tool; run `bin/pish build-phobos.psh`.
- Pluto is the planned native ISA for Sol semantics; Luna and Terra are planned
  16-bit and 32-bit x86 backends.

Peel and the rest of userland build through Haruka/Mars; Orgasm remains the platform-prefix assembler and Jabara bootstrap assembler.
