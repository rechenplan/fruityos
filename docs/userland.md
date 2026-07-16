# Shell and userland

Peel is FruityOS's Jabara-written userland. It contains the Pish shell, RAMFS
utilities, Fred editor, Jar archiver, Juicer compressor, and development tools.

## Pish

Pish is a small command interpreter rather than a POSIX shell. At boot it runs
`/init.psh` and then reads commands interactively. Starting `pish` from an
existing shell creates a nested interactive shell; `exit` returns to its parent.

Pish saves its startup directory as its root. The prompt displays paths relative
to that directory, so the startup directory appears as `/>`. Absolute `cd` paths
are interpreted beneath the saved root, and `cd` refuses to leave it.

Command lookup checks these forms in order:

1. an explicitly named `.fap` in the working directory;
2. the same `.fap` under the saved root's `bin` directory;
3. an explicitly named `.psh` in the working directory;
4. the same `.psh` under the saved root's `bin` directory;
5. the command name plus `.fap`, in the working directory and then the saved
   root's `bin` directory;
6. the command name plus `.psh`, in the working directory and then the saved
   root's `bin` directory.

`cd` and `exit` are built in. Script lines beginning with `#` are ignored.
Arguments are separated by spaces. Scripts receive Bash-style positional
parameters: `$0` is the invoked script name, `$1` through `$9` are arguments,
and `$#` is the number of arguments after `$0`. Pish does not implement `$@`.

Pish does not implement quoting, escaping, general environment variables,
wildcard expansion, pipelines, redirection, command substitution, background
jobs, or shell conditionals.

## Installed applications

| Program | Purpose |
| --- | --- |
| `concat` | Concatenate input files into an output file. |
| `copy` | Copy a file. |
| `del` | Delete a file. |
| `dir` | List directory contents. |
| `echo` | Print arguments. |
| `fill` | Fill a file with a requested number of zero bytes. |
| `fred` | Interactive line editor. |
| `inode` | Display RAMFS inode information. |
| `jar` | Create or extract Jar archives. |
| `jc` | Compile Jabara to NASM-compatible assembly. |
| `juicer` | Compress or decompress Juicer streams. |
| `mkdir` | Create a directory. |
| `move` | Rename or move a file. |
| `orgasm` | Assemble FruityOS and Jabara assembly inputs. |
| `pish` | Run scripts and interactive commands. |
| `rmdir` | Remove a directory. |
| `type` | Print a file. |
| `write` | Interactively write lines to a file. |

The root build copies the selected programs into the initrd. Peel builds only
its own userland sources. Jabara supplies `jc` and Orgasm, while Yuzu supplies
`byc`, `yc`, and `zest` under its own output tree.

## FAP applications

A FruityOS application is linked at virtual origin `0x801000`, assembled as a
flat image, and compressed with Juicer. The `.fap` suffix identifies the
compressed form accepted by `exec`.

The FAP runtime receives flattened arguments from the task exchange page, pushes
`argc` and `argv` using the Jabara stack ABI, calls `main(argc, argv)`, exposes
Pith services through interrupt `0x84`, and exits when `main` returns.

## Jar

Jar stores a directory tree without metadata unused by RAMFS. Each entry has:

```text
NUL-terminated path
unsigned 64-bit content length
content bytes
```

Directory paths end in `/`. An empty path terminates the archive.

## Juicer

Juicer writes literal bytes directly and represents repeated sequences as
backward references within a 1024-byte window. Byte `0xFF` is the control
marker, and the stream includes an explicit end marker.

The same format is decoded by BIOS Seed, UEFI Seed, Pulp's FAP loader, and the
`juicer` userland program.

## Persistence

All userland files live in RAMFS. FruityOS does not read or write the boot disk
after startup. Files created or edited in the shell disappear at reset.
