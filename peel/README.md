# Peel

Peel is the Jabara-written FruityOS userland. It provides the Pish shell, RAMFS
utilities, Fred editor, Jar archiver, and Juicer compressor.

## Build

The host build produces FAP applications and the Linux packaging tools:

```sh
./build.sh
```

The native `build.psh` uses the bootstrap tools already in the initrd to rebuild
sixteen ordinary applications under `peel/bin`, then copies them into the
running system's `/bin` directory.

Sources are organized as one directory per program under `src/`. Generated host
FAPs are written to `bin/`; native intermediates use `tmp/` in the extracted
checkout.

See [Shell and userland](../docs/userland.md) for commands and formats, and
[Initrd and native rebuild](../docs/initrd-native-build.md) for bootstrap and
installation details.
