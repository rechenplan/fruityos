# System-call ABI

FruityOS applications enter the kernel with interrupt `0x84` (`132`). `RAX`
contains the call number. Arguments use the normal x86-64 System V order:
`RDI`, `RSI`, `RDX`, `RCX`, `R8`, and `R9`. The return value is delivered in
`RAX`.

The interrupt gate is callable from ring 3. The assembly handler saves user
registers in the task exchange page, switches data segments, obtains the target
from the dispatch table at kernel offset zero, and returns with `iretq`.

## Dispatch table

The first 256 bytes of `pulp.bin` contain 32 eight-byte function pointers.
Executable kernel code starts at offset `0x100`. Seed therefore jumps to
physical `0x10100`, while user runtimes invoke the table indirectly through
interrupt `0x84`.

Slot 31 is reserved for the kernel keyboard path and is not exposed as a normal
Pith call.

## Calls

| `RAX` | Name | Current behavior |
| ---: | --- | --- |
| 0 | `open` | Opens a RAMFS file or directory. |
| 1 | `creat` | Creates a file, replacing an existing path. |
| 2 | `close` | Releases an in-memory file descriptor. |
| 3 | `read` | Reads bytes from a regular file. |
| 4 | `write` | Writes a file; descriptors 1 and 2 write to the console. |
| 5 | `fgetch` | Reads one byte from a descriptor. |
| 6 | `fputch` | Writes one byte to a descriptor. |
| 7 | `seek` | Sets an absolute file position. |
| 8 | `getch` | Polls line-buffered keyboard input; returns `-1` when empty. |
| 9 | `putch` | Writes a character to VGA and debug port `0xE9`. |
| 10 | `getcwd` | Copies the current RAMFS path to the caller's buffer. |
| 11 | `getdents64` | Emits FruityOS directory records for `dir`. |
| 12 | `rename` | Renames or moves a RAMFS entry. |
| 13 | `mkdir` | Creates a directory. |
| 14 | `rmdir` | Removes a directory. |
| 15 | `chdir` | Changes the current directory. |
| 16 | `unlink` | Removes a file. |
| 17 | `exec` | Decompresses and starts a FAP in a child task mapping. |
| 18 | `fork` | Compatibility stub. |
| 19 | `waitpid` | Compatibility stub. |
| 20 | `dup2` | Compatibility stub. |
| 21 | `brk` | Returns or advances the application program break. |
| 22 | `mmap` | Compatibility stub. |
| 23 | `exit` | Ends the current task and restores its parent. |

## File descriptors

Descriptors are kernel-owned in-memory objects. Standard output and error are
handled specially by `write`; ordinary descriptors track an inode and current
offset. Descriptor state is not a POSIX process table and is not inherited
through a functional `fork`, because process duplication is not implemented.

`getdents64` uses fixed 83-byte FruityOS records sized for 64-byte inode names.
Applications should use the Pith declarations and Peel implementation rather
than assume Linux `dirent64` layout.

## Application startup and exit

A FAP is a Juicer-compressed flat image linked at virtual `0x801000`. `exec`
creates the next 128 MiB task mapping, expands the image at that address, places
flattened arguments in the exchange page, and transfers to ring 3. The runtime
calls `main` and invokes `exit` when it returns.

Because execution is monotasking, the parent does not continue concurrently.
Its register state and address-space selection are restored when the child
exits.
