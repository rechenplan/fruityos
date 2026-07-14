# Shell and userland

Peel is FruityOS's Jabara-written userland. It contains the Pish shell, file and
directory utilities, the Fred editor, and the Jar and Juicer build tools.

## Pish

Pish is a small command interpreter, not a POSIX shell. At initial startup it
runs `/init.psh` and then reads commands interactively.

Search order for a command is:

1. an explicitly named `.fap` in the current directory;
2. the same `.fap` below `/bin`;
3. an explicitly named `.psh` in the current directory;
4. the same `.psh` below `/bin`;
5. the command name with `.fap` appended, current directory then `/bin`;
6. the command name with `.psh` appended, current directory then `/bin`.

`cd` and `exit` are built into Pish. Lines beginning with `#` are ignored in
scripts. Arguments are separated by spaces.

Pish does not implement quoting, escaping, environment variables, wildcard
expansion, pipelines, redirection, command substitution, background jobs, or
shell conditionals. Build scripts therefore consist of simple commands and
directory changes.

## Installed applications

| Program | Purpose |
| --- | --- |
| `concat` | Concatenate input files into an output file. |
| `copy` | Copy a file. |
| `del` | Delete a file. |
| `dir` | List directory contents. |
| `echo` | Print arguments. |
| `fill` | Fill a file with a requested number of zero bytes. |
| `fred` | Interactive FruityOS line editor. |
| `inode` | Display RAMFS inode information. |
| `jar` | Create or extract Jar archives. |
| `juicer` | Compress or decompress Juicer streams. |
| `mkdir` | Create a directory. |
| `move` | Rename or move a file. |
| `pish` | Run scripts and interactive commands. |
| `rmdir` | Remove a directory. |
| `type` | Print a file. |
| `write` | Interactively write lines to a file. |
| `jc` | Compile Jabara to NASM-compatible assembly. |
| `orgasm` | Assemble the subset used by Jabara and FruityOS. |

The initial initrd does not contain this entire table. It begins with the nine
bootstrap FAPs documented in [Initrd and native rebuild](initrd-native-build.md)
and compressed Jabara compiler assembly, then installs the sixteen newly built
ordinary applications into `/bin`. FruityOS assembles `jc` before starting the
native build; the resulting `jc` and bootstrap `orgasm` tools remain in place.
Host builds also produce `yc.fap` and `zest.fap` compatibility artifacts under
`peel/bin`, but they are not required for the native OS build and are therefore
not placed in the initrd.

## FAP applications

A FruityOS application is compiled at virtual origin `0x801000`, combined with
`jabara/lib/fap-runtime.asm`, assembled as a flat binary, and normally compressed
with Juicer. The `.fap` suffix denotes the compressed form consumed by `exec`.

The runtime receives flattened arguments from the task exchange page, calls the
program's `main(argc, argv)`, exposes Pith calls through interrupt `0x84`, and
exits when `main` returns.

## Jar

Jar is intentionally simpler than tar or ZIP. It stores enough information to
recreate a directory tree in RAMFS without metadata that FruityOS does not use.
Creation walks the requested tree; extraction creates directories and files in
archive order.

Entry representation:

```text
NUL-terminated path
unsigned 64-bit content length
content bytes
```

A directory has a trailing slash and no regular-file payload. An empty path
marks end of archive.

## Juicer

Juicer represents literals directly and repeated byte sequences as backward
references within a 1024-byte window. The format reserves byte `0xFF` as its
control marker and includes an explicit end marker. It favors a very small
decoder over high compression ratios.

The same stream format is decoded by:

- BIOS Seed while loading Pulp;
- UEFI Seed while loading Pulp;
- Pulp while executing a FAP;
- `/bin/juicer.fap` while extracting the source snapshot.

## Persistence

All userland files live in RAMFS. FruityOS does not read or write the boot disk
after startup. Created files, edited sources, and the native `/bin` replacement
are volatile.
