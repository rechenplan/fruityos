# FruityOS

FruityOS 0.03 is a small, monotasking 64-bit operating system for x86 PCs. It boots
through legacy BIOS or x86-64 UEFI, initializes a Jabara-written kernel and
RAM filesystem, and starts the Pish shell in ring 3.

The repository includes its own systems language, compiler, assembler,
bootloaders, kernel, userland, archive format, and compression format. Every
host build also packages the current source tree into the initrd. At boot,
FruityOS extracts that tree, rebuilds its userland natively with Jabara and
Orgasm, and installs the new applications in `/bin`.

## Build and run

On Debian or Ubuntu, install the development dependencies with:

```sh
./init.sh
```

Build everything and boot the BIOS image:

```sh
./build.sh
./run.sh
```

Boot through UEFI with OVMF:

```sh
./run-uefi.sh
```

The build produces `fruityos_hdd.img`, `fruityos_uefi.img`, and the standalone
`fruityos.efi` application. Physical UEFI systems must disable Secure Boot or
sign the EFI application with a trusted key.

## Components

- `jabara/` — Jabara bootstrap and self-hosted compilers, Orgasm, runtimes,
  tests, and the language manual.
- `seed/` — BIOS and native PE32+ UEFI bootloaders.
- `pulp/` — the FruityOS kernel.
- `peel/` — Pish and the FruityOS userland.
- `yuzu/` — the retained Yuzu compatibility toolchain.
- `scripts/` — files installed at the initrd root.

## Documentation

Start with the [documentation index](docs/README.md), or go directly to:

- [Getting started](docs/getting-started.md)
- [Build system](docs/build-system.md)
- [Boot and firmware](docs/boot-and-firmware.md)
- [Kernel architecture and memory](docs/kernel.md)
- [System-call ABI](docs/system-calls.md)
- [Initrd and native rebuild](docs/initrd-native-build.md)
- [Shell and userland](docs/userland.md)
- [Jabara and Orgasm toolchain](docs/toolchain.md)
- [Development, testing, and limitations](docs/development.md)

FruityOS is an experimental teaching and language/OS co-development system,
not a Unix-compatible general-purpose OS.
