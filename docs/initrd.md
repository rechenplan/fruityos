# Initial RAM filesystem

The root build creates an initrd staging tree, archives it with Jar, and embeds
that archive in every boot image. Pulp unpacks the archive into a volatile RAM
filesystem during initialization.

## Staging tree

```text
initrd/
├── bin/
│   ├── concat.fap
│   ├── copy.fap
│   ├── del.fap
│   ├── dir.fap
│   ├── echo.fap
│   ├── fill.fap
│   ├── fred.fap
│   ├── inode.fap
│   ├── jar.fap
│   ├── jc.fap
│   ├── jus.fap
│   ├── mkdir.fap
│   ├── move.fap
│   ├── orgasm.fap
│   ├── pish.fap
│   ├── rmdir.fap
│   ├── type.fap
│   └── write.fap
├── lib/
│   └── every jabara/lib/*.asm file
├── src/
├── init.psh
└── pulp.sys
```

`src/` is created as an empty writable directory.

## Kernel entry

All Seed variants scan the Jar records for `/pulp.sys`, decompress it at
physical `0x10000`, and pass the Jar start to Pulp in `RSI`. Pulp installs the
archive entries in RAMFS after its memory and descriptor initialization.

The boot disk is not used after this unpacking step.

## Startup

Pulp starts `/bin/pish.fap` as the first ring-3 process. With no script argument,
Pish opens `/init.psh`. The supplied script contains one command:

```text
echo Welcome to FruityOS 0.05!
```

After the command returns, Pish enters its interactive loop. No compilation or
package installation runs during boot.

## Installed tools

The initrd supplies these program groups:

- shell and editing: `pish`, `fred`, `write`;
- filesystem utilities: `dir`, `mkdir`, `rmdir`, `del`, `copy`, `move`,
  `concat`, `type`, `fill`, `inode`;
- output: `echo`;
- archive and compression: `jar`, `jus`;
- development tools: `jc`, `orgasm`.

The assembly files under `/lib` allow compiler and assembler experiments within
the running RAMFS.

## Jar format

Jar is an uncompressed stream of entries:

```text
NUL-terminated path
unsigned 64-bit content length
content bytes
```

Directory names end in `/`. A zero-length path terminates the archive.

## Volatility

RAMFS is memory-only. Files created, edited, compiled, or deleted during a boot
session disappear when FruityOS resets or powers off.
