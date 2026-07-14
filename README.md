# FruityOS

FruityOS is a small, monotasking, 64-bit operating system for x86 PCs. It boots
through either legacy BIOS or x86-64 UEFI without GRUB or another external boot
manager, loads a kernel and RAM filesystem, and starts an interactive shell in
ring 3.

The current kernel and userland are written in
[Jabara](jabara/docs/manual.md), the repository's compact systems language, with
NASM used for the boot sectors and hardware-facing assembly. Jabara is
self-hosted: the normal build first creates a small C bootstrap compiler, uses
it to build the Jabara compiler, and then has that compiler compile itself.

FruityOS 0.02 currently provides:

- 512-byte BIOS and native PE32+ UEFI boot paths;
- a ring-0 kernel with paging, a GDT, TSS, IDT, exception handlers, PIC and
  keyboard interrupt handling;
- a ring-3 application environment and `int 0x84` system-call interface;
- an in-memory hierarchical filesystem unpacked from the boot image;
- a VGA text console and PS/2 keyboard input;
- the Pish command shell and a collection of file utilities;
- Jabara, Yuzu, and Zest compiler/assembler tools in `/bin`;
- ELF, FAP, and headerless module output from the Jabara compiler.

It is intentionally a small experimental system, not a Unix-compatible general
purpose OS. There is no persistent filesystem driver, networking, SMP,
preemptive scheduling, or dynamic hardware discovery.

## Quick start

The supplied setup script targets Debian and Ubuntu systems:

```sh
./init.sh
```

It installs GCC, NASM, GDB, QEMU, and OVMF. Build and boot the BIOS hard-disk
image with:

```sh
./build.sh
./run.sh
```

`run.sh` starts QEMU with 512 MiB of RAM and attaches
`fruityos_hdd.img` as a raw IDE disk. A successful boot ends at:

```text
Welcome to FruityOS 0.02!
/>
```

To use the UEFI image instead:

```sh
./run-uefi.sh
```

This starts QEMU with OVMF and `fruityos_uefi.img`. The UEFI image contains a
FAT16 EFI system partition whose `EFI/BOOT/BOOTX64.EFI` file embeds both the
compressed kernel and the initrd. The build also leaves the same standalone
PE32+ EFI application at `fruityos.efi` for copying to an existing EFI system
partition. The generated application is unsigned, so physical machines must
either have Secure Boot disabled or use a copy signed with a trusted key.

To boot that standalone PE directly through a temporary virtual EFI system
partition, use:

```sh
./run-pe.sh
```

The finished image is always padded to 256 KiB. The booted system itself uses
only a small part of the RAM assigned to QEMU; the larger QEMU default is useful
for development and for the kernel's initial identity map.

To clean generated artifacts:

```sh
./cleanup.sh
```

## Repository layout

| Path | Purpose |
| --- | --- |
| `jabara/` | Jabara's C bootstrap compiler (`jbc`), self-hosted compiler (`jc`), runtimes, tests, and language manual. |
| `pulp/` | The FruityOS kernel, written in Jabara with assembly entry, interrupt, descriptor-table, and context-switch code. |
| `seed/` | NASM bootloaders: `hdseed`, `fdseed`, and the single-source PE32+ `uefiseed`. |
| `peel/` | Jabara userland: Pish, file utilities, archive/compression tools, and native compiler tools. |
| `yuzu/` | The retained Yuzu sources and compatibility toolchain. Files outside this directory use the `.jabara` extension. |
| `scripts/` | Files copied into the initial RAM filesystem, currently `/init.psh`. |
| `initrd/` | Generated staging tree for the initial RAM filesystem. |
| `bin/` | Linux Peel executables produced by the Jabara test suite. |
| `fruityos_hdd.img` | Generated, bootable 256 KiB raw hard-disk image. |
| `fruityos.efi` | Standalone PE32+ UEFI application with the kernel and initrd embedded. |
| `fruityos_uefi.img` | Generated UEFI disk image containing the loader, kernel, and initrd. |

The short READMEs inside individual components are historical notes. This file
describes the integrated system built by the current root `build.sh`.

## Build pipeline

The root build is deliberately simple and uses shell scripts rather than a
make-based build system:

1. `jabara/build.sh` compiles `jbc`, bootstraps `jc`, and produces a second
   self-hosted compiler build.
2. `yuzu/build.sh` rebuilds the Yuzu compatibility programs with Jabara and
   NASM.
3. `peel/build.sh` compiles every Peel application to a FruityOS FAP. It also
   builds Linux versions of Jar and Juicer for use during the build, and adds
   `jc`, `yc`, and `zest` to the FruityOS userland.
4. `seed/build.sh` assembles the hard-disk and floppy boot sectors.
5. `pulp/build.sh` compiles the Jabara kernel as a headerless module, combines
   it with Pulp's assembly, assembles one flat kernel, and compresses it with
   Juicer.
6. The root build creates the initrd archive and uses it for both images. It
   concatenates `hdseed.bin`, `pulp.sys`, and the archive into
   `fruityos_hdd.img`; `uefiseed.asm` embeds the kernel and archive in the
   standalone `fruityos.efi` PE file and packages it as `BOOTX64.EFI` inside
   the FAT16 `fruityos_uefi.img`.

Jabara keeps target runtimes separate from generated program assembly. Linux
programs are combined with `jabara/lib/elf-runtime.asm`; FruityOS programs are
combined with `jabara/lib/fap-runtime.asm`. The compiler only emits the target
load address, the ELF header when requested, program code, allocator, and data.
The `module` format emits neither a load header nor a platform runtime.

## Disk image and boot process

The hard-disk image has no conventional on-disk filesystem:

| Image offset | Contents |
| --- | --- |
| `0x00000` | The 512-byte `hdseed` boot sector, including an MBR-style partition entry and `0xAA55` signature. |
| `0x00200` | Juicer-compressed Pulp kernel (`pulp.sys`). |
| after `pulp.sys` | Uncompressed Jar archive containing the initrd tree. |
| through `0x3ffff` | Zero padding to the fixed 256 KiB image size. |

At boot, the BIOS places the first sector at `0x7c00`. `hdseed` then:

1. reads the complete 256 KiB image into physical memory starting at
   `0x40000`;
2. enables A20 and constructs temporary long-mode page tables at `0x1000`;
3. installs a temporary GDT, enables PAE and long mode, and remaps the legacy
   PIC;
4. decompresses `pulp.sys` to `0x10000`;
5. leaves `RSI` pointing at the initrd archive and jumps to the kernel entry at
   `0x10100`.

The first 256 bytes of the kernel image are its system-call dispatch table, so
the executable entry follows at `kernel + 0x100`. Pulp installs its permanent
descriptor tables and paging, initializes its fixed-block heap, unpacks the
initrd into RAMFS, and launches `/bin/pish.fap` in ring 3. Pish executes
`/init.psh` and then enters its interactive loop.

The UEFI path is implemented entirely in `seed/src/uefiseed/uefiseed.asm`.
That file contains its own DOS and PE32+ headers and also has a packaging mode
that emits the MBR, FATs, directories, and `BOOTX64.EFI` payload. At boot it
reserves FruityOS's fixed physical regions with UEFI boot services, decompresses
Pulp at `0x10000`, copies the initrd to `0x700000`, obtains the final firmware
memory map, calls `ExitBootServices`, installs a temporary identity map, and
jumps to `0x10100`. It also restores the PIC and legacy VGA text state expected
by FruityOS 0.02.

## Memory map

All addresses below are hexadecimal. Ranges are half-open: the ending address
is the first byte not included in the region.

### Kernel and physical layout

| Range or address | Use |
| --- | --- |
| `0x00000500`–`0x0000050a` | IDTR descriptor used while loading the permanent IDT. |
| `0x00001000`–`0x00007000` | Bootstrap long-mode paging structures and scratch space created by Seed. |
| `0x0000f000`–`0x00010000` | Permanent 256-entry IDT. |
| `0x00010000` onward | Decompressed Pulp kernel. The dispatch table occupies `0x10000`–`0x10100`; executable entry is `0x10100`. |
| `0x00040000` | Ring-0 stack top (`RSP0`) and the address at which Seed initially loads the disk image. The stack grows downward; the loaded image occupies addresses above it. |
| `0x00060000` | TSS IST1 stack top used by interrupt gates. This area is reused after the boot image has been unpacked. |
| `0x000b8000`–`0x000b8fa0` | 80×25 VGA text buffer. |
| `0x00100000`–`0x00101000` | PML4. |
| `0x00101000`–`0x00102000` | Page-directory-pointer table. |
| `0x00102000`–`0x00103000` | Page directory. |
| `0x00103000`–`0x00203000` | Page-table array used to identity-map the first 512 MiB and provide per-task application mappings. |
| `0x00400000`–`0x00410000` | Kernel heap pool for allocations up to 32 bytes. |
| `0x00410000`–`0x00420000` | Kernel heap pool for allocations up to 256 bytes. |
| `0x00420000`–`0x00620000` | Kernel heap pool for allocations up to 1024 bytes, including RAMFS file blocks. |
| `0x00700000` onward | UEFI Seed's stable initrd copy during kernel initialization; unused by the BIOS path. |

Pulp initially identity-maps the first 512 MiB as supervisor memory. On a task
switch it replaces page-directory entries 4 through 7, exposing only the
8–16 MiB virtual application window to ring 3. Per-PID saved-register blocks
are addressed by the kernel at `(pid + 2) * 8 MiB`.

### Ring-3 virtual application layout

| Range or address | Use |
| --- | --- |
| `0x00800000`–`0x00801000` | Task state exchange page. Saved registers begin at `0x800000`; flattened argument strings are copied at offset `0x100`. |
| `0x00801000` onward | FAP load address and initial instruction address. FAP assembly uses `org 0x801000`. |
| `0x00900000` | Initial program break. Application heap growth begins here. |
| `0x01000000` | User stack top and exclusive upper limit for `brk`; the stack grows downward. |

Each application receives an 8 MiB virtual window. FruityOS does not currently
enforce a separate heap/stack collision guard inside that window.

## Kernel architecture

Pulp is a compact monolithic kernel. Its initialization order is visible in
`pulp/src/kmain.jabara`: GDT, paging, TSS, IDT, heap, global devices, RAMFS,
then the first user process.

Major subsystems include:

- **Interrupts and exceptions:** a 4 KiB IDT at `0xf000`; CPU exceptions print
  a diagnostic and halt, IRQ0 acknowledges the timer, and IRQ1 translates PS/2
  set-1 keyboard scancodes.
- **Console:** direct 80×25 VGA text output at `0xb8000`, with cursor drawing,
  tab expansion, backspace, newline handling, and scrolling.
- **Paging and privilege:** four-level x86-64 paging, ring-0/ring-3 GDT entries,
  a TSS with `RSP0` and IST1, and `iretq` transitions between kernel and user
  state.
- **Memory allocation:** three fixed-block kernel pools. Requests larger than
  1024 bytes are not serviced by the kernel allocator. User programs use a
  process-local `brk` beginning at 9 MiB.
- **RAMFS:** hierarchical directories, files, `.`/`..` links, absolute and
  current-directory-relative lookup, and 1024-byte chained data blocks. It is
  initialized from the Jar archive in the boot image and is not persistent.
- **Execution:** FAP files are decompressed directly to `0x801000`. Execution
  is monotasking: a child gets a new application mapping, while its parent's
  saved state remains inactive until the child exits.

There is no timer scheduler. The current `fork`, `waitpid`, `dup2`, and `mmap`
system calls are stubs, and IRQ0 only acknowledges the timer interrupt.

## System-call ABI

User programs invoke interrupt `0x84` (`132`) with the call number in `RAX`.
Arguments use the normal x86-64 System V register order. The gate is callable
from ring 3; the assembly handler saves application registers in the task
exchange page, switches to kernel segments, dispatches the call, and returns
with `iretq`.

| `RAX` | Call | Status |
| ---: | --- | --- |
| 0 | `open` | RAMFS file or directory lookup. |
| 1 | `creat` | Creates a file, replacing an existing path. |
| 2 | `close` | Releases an in-memory file descriptor. |
| 3 | `read` | Reads regular-file data. |
| 4 | `write` | Writes a file; descriptors 1 and 2 write to the VGA console. |
| 5–6 | `fgetch`, `fputch` | Single-character descriptor I/O. |
| 7 | `seek` | Sets an absolute file position. |
| 8–9 | `getch`, `putch` | Console keyboard input and VGA output. `getch` returns `-1` until a complete line is available. |
| 10 | `getcwd` | Returns the current RAMFS directory. |
| 11 | `getdents64` | Returns FruityOS directory records used by Peel's `dir`. |
| 12–16 | `rename`, `mkdir`, `rmdir`, `chdir`, `unlink` | RAMFS path operations. |
| 17 | `exec` | Loads a compressed FAP into a child application mapping. |
| 18–20 | `fork`, `waitpid`, `dup2` | Present but currently stubbed. |
| 21 | `brk` | Gets or advances the application break. |
| 22 | `mmap` | Present but currently stubbed. |
| 23 | `exit` | Restores the parent task mapping. |

System-call slot 31 is reserved for the kernel's keyboard path and is not part
of the normal user runtime.

## Initial RAM filesystem

The generated initrd contains:

```text
/
├── bin/
│   ├── pish.fap
│   ├── jc.fap, yc.fap, zest.fap
│   └── Peel utilities
├── lib/
│   ├── elf-runtime.asm
│   └── fap-runtime.asm
├── src/
└── init.psh
```

Jar is a deliberately small archive format: each entry stores a NUL-terminated
path, an eight-byte size, and raw file data. A zero-length path terminates the
archive. Directories are represented by paths ending in `/`. The initrd archive
itself is not Juicer-compressed; individual FAP executables are.

Juicer uses a small LZ-style stream with a 1024-byte history window. Both the
kernel and FAP executables use this format, and Seed/Pulp contain matching
decompression code.

## Shell and userland

Pish is a small command interpreter rather than a POSIX shell. It runs
`/init.psh` at startup, recognizes `cd` and `exit` internally, and searches the
current directory and `/bin` for `.fap` executables or `.psh` scripts. Script
lines beginning with `#` are ignored. Quoting, pipes, redirection, globbing, and
environment variables are not implemented.

The generated `/bin` currently contains:

| Program | Purpose |
| --- | --- |
| `concat` | Concatenate input files into an output file. |
| `copy`, `move`, `del` | Copy, rename, and delete files. |
| `dir` | List directory contents. |
| `echo`, `type` | Print arguments or file contents. |
| `fill` | Fill a file with a requested number of zero bytes. |
| `write` | Interactively write lines to a file. |
| `fred` | FruityOS line editor. |
| `inode` | Display inode information. |
| `mkdir`, `rmdir` | Create and remove directories. |
| `jar` | Create or extract Jar archives. |
| `juicer` | Compress or decompress Juicer streams. |
| `pish` | Interactive shell and script runner. |
| `jc` | Self-hosted Jabara-to-NASM compiler. |
| `yc`, `zest` | Yuzu compiler and assembler compatibility tools. |

## Jabara toolchain

The compiler interface is:

```text
jc elf|fap|module input.jabara output.asm
```

- `elf` uses `org 0x400000` and emits a minimal flat 64-bit ELF header. Append
  `elf-runtime.asm` before assembling with NASM.
- `fap` uses `org 0x801000` and emits a trampoline for the FruityOS flat loader.
  Append `fap-runtime.asm`, assemble with NASM, and optionally compress the raw
  image with Juicer.
- `module` emits headerless assembly with stack-based subroutine environments
  and no target runtime. Pulp and the FruityOS build of `jc` use this mode.

The initrd includes both external runtime files under `/lib`. The full language
tutorial, including records, tagged variables, closures, expressions, and
memory access, is in [jabara/docs/manual.md](jabara/docs/manual.md).

## Testing and debugging

Run the compiler and compatibility regression suite with:

```sh
cd jabara
./test.sh
```

The suite tests the C bootstrap and self-hosted compilers, records and closures,
expected diagnostics, ELF and FAP generation, Juicer round trips, Yuzu
compatibility, and compilation of every Peel program. The resulting Linux Peel
executables are left in the root `bin/` directory.

For source-level machine debugging from the repository root:

```sh
./debug.sh
```

This starts GDB with `debug.gdb`; GDB launches QEMU paused with interrupt and
CPU-reset logging in `log.txt`. Useful fixed entry points include the BIOS boot
sector at `0x7c00` and the Pulp entry at `0x10100`.

## Current limitations

FruityOS is useful as a compact language/OS co-development environment, but its
scope is intentionally narrow:

- x86-64 BIOS or UEFI boot; the console still requires VGA-compatible text
  hardware and keyboard input still requires a PS/2-compatible controller;
- one active user program at a time and no preemptive scheduler;
- volatile RAMFS only, with no post-boot disk access;
- no networking, audio, graphics mode, USB stack, SMP, or ACPI support;
- PS/2 keyboard and VGA text hardware assumptions;
- fixed 256 KiB boot image and fixed application virtual window;
- several Unix-shaped calls are compatibility stubs rather than full
  implementations;
- kernel allocation is limited to the three fixed pools described above.

These constraints are part of the project's current state, not promises about
future compatibility.
