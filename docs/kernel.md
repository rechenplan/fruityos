# Kernel architecture

Pulp is a compact monolithic x86-64 kernel written primarily in Jabara. Assembly
modules provide the dispatch table, entry sequence, privilege transitions,
interrupt stubs, descriptor loading, and machine instructions not emitted
directly by Jabara.

## Initialization

Seed enters Pulp at physical `0x10100` with interrupts disabled and `RSI`
pointing to the initrd Jar. `kmain` initializes:

1. GDT
2. paging
3. TSS
4. IDT
5. fixed-block kernel heap
6. console and keyboard state
7. the `Booting...` message
8. RAMFS from the initrd
9. interrupts
10. `/bin/pish.fap` as the first ring-3 process

Pish executes `/init.psh` and then enters its interactive loop.

## Descriptor tables and interrupts

The GDT contains ring-0 and ring-3 code and data descriptors plus a 64-bit TSS.
The TSS supplies the ring-0 stack used during privilege transitions and IST1 for
interrupt gates.

The IDT occupies one 4 KiB page at `0xf000`. CPU exception handlers print a
diagnostic and stop. IRQ0 acknowledges the timer but does not schedule tasks.
IRQ1 reads PS/2 set-1 keyboard scancodes, translates them, and feeds the kernel
line buffer. The PIC is remapped during `idt_init`.

System calls use the DPL-3 interrupt gate at vector `0x84`. See
[System-call ABI](system-calls.md).

## Paging and execution

Pulp installs its four-level page hierarchy beginning at 1 MiB. The kernel is
identity-mapped through the first 512 MiB as supervisor memory.

Ring-3 programs use an 8–136 MiB virtual window backed by a distinct 128 MiB
physical region for each PID. Pulp switches page-directory entries 4 through
67 and reloads CR3 when changing tasks. Kernel mappings remain fixed.

Saved-register blocks are addressed in kernel space at `(pid + 1) * 128 MiB`.
Execution is monotasking. `exec` creates a child mapping and preserves the
parent state. `exit` restores the parent. The timer does not schedule tasks.

## Kernel heap

The heap contains three fixed-size pools:

- 64 KiB of blocks up to 32 bytes;
- 256 KiB of blocks up to 256 bytes;
- 2.5 MiB of blocks up to 1024 bytes.

Requests larger than 1024 bytes fail. Applications use `brk` instead of these
kernel pools. The user break begins at virtual 9 MiB and grows toward the stack.

## RAMFS

Pulp unpacks the initrd Jar into a volatile hierarchical filesystem.
Directories contain linked inode entries, including `.` and `..`. File contents
use chains of 1024-byte blocks. Path lookup accepts absolute paths and paths
relative to the process working directory.

An inode is 80 bytes:

| Offset | Size | Field |
| ---: | ---: | --- |
| 0 | 64 | NUL-terminated name. |
| 64 | 4 | Inode type. |
| 68 | 4 | Content size. |
| 72 | 8 | Content or child-list pointer. |

Names longer than 63 bytes are truncated and NUL-terminated. RAMFS is not backed
by the boot disk and disappears at reset.

## Console and keyboard

The console writes to the 80×25 color text buffer at `0xb8000`. It implements
cursor display, tabs, backspace, newline, and scrolling. Every character is also
written to I/O port `0xE9`.

Keyboard input is line-buffered. `getch` returns `-1` until a complete input byte
is available. The kernel uses PS/2 keyboard input after boot.

## Physical memory map

Ranges are half-open.

| Range or address | Use |
| --- | --- |
| `0x00000500`–`0x0000050a` | Temporary IDTR descriptor. |
| `0x00001000`–`0x00007000` | Seed paging structures and scratch space. |
| `0x0000f000`–`0x00010000` | Permanent IDT. |
| `0x00010000` onward | Pulp dispatch table and kernel image. |
| `0x00010100` | Pulp executable entry. |
| `0x00040000` | Ring-0 stack top and BIOS image load base. |
| `0x00060000` | TSS IST1 stack top. |
| `0x000b8000`–`0x000b8fa0` | VGA text buffer. |
| `0x00100000`–`0x00101000` | PML4. |
| `0x00101000`–`0x00102000` | Page-directory-pointer table. |
| `0x00102000`–`0x00103000` | Page directory. |
| `0x00103000`–`0x00203000` | Page-table arena. |
| `0x00300000`–`0x00400000` | BIOS payload staging window. |
| `0x00400000`–`0x00410000` | 32-byte heap pool. |
| `0x00410000`–`0x00450000` | 256-byte heap pool. |
| `0x00450000`–`0x007d0000` | 1024-byte heap pool. |
| `0x02000000` onward | UEFI initrd copy during initialization. |

## Ring-3 virtual memory map

| Range or address | Use |
| --- | --- |
| `0x00800000`–`0x00801000` | Task exchange page and flattened arguments. |
| `0x00801000` onward | FAP image and initial instruction address. |
| `0x00900000` | Initial application break. |
| `0x08800000` | User stack top and exclusive `brk` limit. |

There is no separate guard region between the growing heap and descending
stack.
