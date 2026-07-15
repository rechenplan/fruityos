# System-call ABI

FruityOS applications enter Pulp with interrupt `0x84` (`132`). `RAX` contains
the call number. Arguments use the x86-64 System V register order:

```text
RDI RSI RDX RCX R8 R9
```

The return value is delivered in `RAX`. The interrupt gate is callable from
ring 3. The assembly handler saves user registers in the task exchange page,
switches data segments, loads the target from the dispatch table, and returns
with `iretq`.

## Dispatch table

The first 256 bytes of `pulp.bin` contain 32 eight-byte function pointers.
Executable kernel code begins at offset `0x100`, so Seed jumps to physical
`0x10100` after loading Pulp at `0x10000`.

Slot 31 serves the kernel keyboard path and is not exposed as a normal Pith
call.

## Calls

| `RAX` | Name | Behavior |
| ---: | --- | --- |
| 0 | `open` | Open a RAMFS file or directory. |
| 1 | `creat` | Create a file, replacing an existing path. |
| 2 | `close` | Release an in-memory file descriptor. |
| 3 | `read` | Read bytes from a regular file. |
| 4 | `write` | Write a file; descriptors 1 and 2 write to the console. |
| 5 | `fgetch` | Read one byte from a descriptor. |
| 6 | `fputch` | Write one byte to a descriptor. |
| 7 | `seek` | Set an absolute file position. |
| 8 | `getch` | Poll keyboard input; return `-1` when empty. |
| 9 | `putch` | Write one character to VGA and port `0xE9`. |
| 10 | `getcwd` | Copy the working-directory path to a caller buffer. |
| 11 | `getdents64` | Emit FruityOS directory records. |
| 12 | `rename` | Rename or move a RAMFS entry. |
| 13 | `mkdir` | Create a directory. |
| 14 | `rmdir` | Remove a directory. |
| 15 | `chdir` | Change the working directory. |
| 16 | `unlink` | Remove a file. |
| 17 | `exec` | Decompress and start a FAP in a child task mapping. |
| 18 | `fork` | Stub. |
| 19 | `waitpid` | Stub. |
| 20 | `dup2` | Stub. |
| 21 | `brk` | Return or advance the application program break. |
| 22 | `mmap` | Stub. |
| 23 | `exit` | End the task and restore its parent. |

## File descriptors

Descriptors are kernel-owned in-memory objects. Ordinary descriptors contain an
inode reference and a byte offset. `write` handles standard output and standard
error specially.

`getdents64` emits fixed 83-byte FruityOS records sized for 64-byte inode names.
Applications should use the Pith declarations and Peel implementation instead
of assuming the Linux `dirent64` layout.

## Application startup and exit

A FAP is a Juicer-compressed flat image linked at virtual `0x801000`. `exec`
creates the next 128 MiB task mapping, expands the image there, places flattened
arguments in the exchange page, and transfers to ring 3.

The runtime calls `main(argc, argv)` and invokes `exit` when `main` returns.
Execution is monotasking: the parent resumes only after the child exits.
