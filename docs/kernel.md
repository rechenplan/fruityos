# Kernel architecture

Pulp is a compact monolithic x86-64 kernel written primarily in Jabara. Small
assembly modules supply the initial dispatch table, privilege transitions,
interrupt stubs, descriptor loading, and instructions not represented directly
by the language.

## Initialization

Seed enters Pulp at physical `0x10100` with interrupts disabled and `RSI`
pointing to the initrd. `kmain` initializes subsystems in this order:

1. GDT
2. paging
3. TSS
4. IDT
5. fixed-block kernel heap
6. global console and keyboard state
7. RAMFS unpacking
8. interrupt enablement after the BIOS load buffer is no longer needed
9. `/bin/pish.fap` as the first ring-3 process

Pish opens `/init.psh`, executes it, and then enters its interactive loop.

## Descriptor tables and interrupts

The GDT contains ring-0 and ring-3 code/data descriptors plus a 64-bit TSS.
The TSS supplies the ring-0 stack used during privilege transitions and IST1
for interrupt gates.

The IDT occupies one 4 KiB page at `0xf000`. CPU exception handlers print a
diagnostic and stop. IRQ0 acknowledges the timer but does not schedule tasks.
IRQ1 reads PS/2 set-1 keyboard scancodes, translates them, and feeds the kernel
line buffer. The PIC is remapped to the conventional protected-mode vectors by
both Seed paths.

System calls use the DPL-3 interrupt gate at vector `0x84`; details are in
[System-call ABI](system-calls.md).

## Paging and privilege

Pulp installs its permanent four-level page hierarchy beginning at 1 MiB. The
kernel is initially identity-mapped through the first 512 MiB as supervisor
memory. Ring-3 programs see an 8–136 MiB virtual window backed by a distinct
128 MiB physical region for each PID.

On a task switch, Pulp changes page-directory entries 4 through 67 and reloads
CR3. Kernel mappings remain stable while the application window changes.
Saved-register blocks are addressed in kernel space at `(pid + 1) * 128 MiB`.

Execution is monotasking rather than scheduled. `exec` creates a child mapping
and preserves the parent state. `exit` restores the parent. There is no timer
scheduler and the Unix-shaped `fork` and `waitpid` calls are currently stubs.

## Kernel memory allocation

The heap contains three fixed-size pools:

- 64 KiB of blocks up to 32 bytes;
- 256 KiB of blocks up to 256 bytes;
- 2.5 MiB of blocks up to 1024 bytes.

Allocations larger than 1024 bytes are rejected. The 256-byte pool is sized for
RAMFS inodes with 64-byte names; the 1024-byte pool stores file data blocks.
Applications do not allocate from these pools. Their runtime uses `brk`, which
starts at virtual 9 MiB and may grow toward the user stack.

## RAM filesystem

The kernel unpacks the initrd Jar into a volatile hierarchical filesystem.
Directories contain linked inode entries including `.` and `..`. File contents
use chains of 1024-byte blocks. Lookup supports absolute paths and paths relative
to the current directory.

An inode is 80 bytes:

| Offset | Size | Field |
| ---: | ---: | --- |
| 0 | 64 | NUL-terminated name. |
| 64 | 4 | Inode type. |
| 68 | 4 | Content size. |
| 72 | 8 | Content or child-list pointer. |

Names longer than 63 bytes are truncated and NUL-terminated. The enlarged name
field is required for generated sources such as `fap-module-runtime.asm` in the
packaged repository.

RAMFS is not backed by the boot disk after startup. Every change, including the
native `/bin` installation, is lost at reset.

## Console and keyboard

The console writes directly to the 80×25 color text buffer at `0xb8000`. It
handles cursor display, tabs, backspace, newline, and scrolling. Each character
is also mirrored to I/O port `0xE9` for emulator diagnostics.

Keyboard input is line-buffered. `getch` returns `-1` while no complete input is
available. Pish spins until a character becomes available. There is no USB HID
or firmware-input fallback after boot.

## Physical memory map

Ranges are half-open; the ending address is not included.

| Range or address | Use |
| --- | --- |
| `0x00000500`–`0x0000050a` | Temporary IDTR descriptor. |
| `0x00001000`–`0x00007000` | Seed paging structures and scratch space. |
| `0x0000f000`–`0x00010000` | Permanent IDT. |
| `0x00010000` onward | Pulp kernel; dispatch table then entry at `0x10100`. |
| `0x00040000` | Ring-0 stack top and BIOS image load base. |
| `0x00060000` | TSS IST1 stack top. |
| `0x000b8000`–`0x000b8fa0` | VGA text buffer. |
| `0x00100000`–`0x00101000` | PML4. |
| `0x00101000`–`0x00102000` | Page-directory-pointer table. |
| `0x00102000`–`0x00103000` | Page directory. |
| `0x00103000`–`0x00203000` | Page-table arena. |
| `0x00300000`–`0x00400000` | Stable BIOS payload staging window during initialization. |
| `0x00400000`–`0x00410000` | 32-byte heap pool. |
| `0x00410000`–`0x00450000` | 256-byte heap pool. |
| `0x00450000`–`0x007d0000` | 1024-byte heap pool. |
| `0x02000000` onward | Stable UEFI initrd copy during initialization. |

## Ring-3 virtual memory map

| Range or address | Use |
| --- | --- |
| `0x00800000`–`0x00801000` | Task exchange page and flattened arguments. |
| `0x00801000` onward | FAP load and initial instruction address. |
| `0x00900000` | Initial application break. |
| `0x08800000` | User stack top and exclusive `brk` limit. |

The current kernel does not place a separate guard region between a growing
heap and descending stack.
