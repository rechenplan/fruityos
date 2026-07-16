# Executable formats

FruityOS uses one executable suffix per target platform. Pish resolves bare
program names by appending only the suffix associated with `$platform`.

| Platform | Suffix | Native format |
| --- | --- | --- |
| Linux x86-64 | `.elf` | Static ELF64 executable |
| Windows x86-64 | `.exe` | PE32+ console executable |
| FruityOS x86-64 | `.fap` | Flat FruityOS application image |

## Linux ELF

Orgasm first emits a raw static ELF image. The normal linker compresses that
image with Juicer and appends the compressed stream to a small ELF launcher.

At startup the launcher:

1. maps executable memory at `0x400000`;
2. decodes the original ELF image into that mapping;
3. reads the reconstructed ELF entrypoint;
4. restores the native process stack; and
5. transfers control to the payload.

The resulting file keeps the `.elf` suffix even though it contains both the
launcher and the compressed inner image.

## Windows PE32+

Windows programs are one-section PE32+ console images with no CRT and no import
library. Pith reachability determines which `kernel32.dll` wrappers and imports
are included.

The normal linker compresses the original PE with Juicer and appends it to a
small PE32+ launcher. The launcher:

1. opens its own executable;
2. reads and decodes the appended payload;
3. allocates memory at the payload's preferred image base;
4. copies the reconstructed PE image;
5. resolves its imports with `LoadLibraryA` and `GetProcAddress`; and
6. enters the inner PE entrypoint.

Both the launcher and reconstructed payload are native x86-64 PE32+ images.

## FruityOS FAP

A `.fap` is a flat FruityOS application entered at its first byte. The FruityOS
startup and runtime adapt Jabara's calling convention to the FruityOS syscall
ABI. Normal linked FAPs may contain a Juicer-compressed payload, but they do not
need an ELF or PE container.

## Stage0 images

The first JBC and current Orgasm executables reconstructed under `stage0/` are
intentionally uncompressed. Juicer and Concat are themselves outputs of the
bootstrap and cannot be prerequisites of those first executables.

See [Build system](build-system.md) for the platform link pipelines and
[Toolchains](toolchain.md) for compiler and assembler behavior.
