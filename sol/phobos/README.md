# Phobos

Phobos is the preserved radical threaded-control version of the Mars x86-64
Sol backend. It is maintained as an independent backend snapshot so later Mars
work can continue without losing this implementation.

Phobos keeps the original `mars_*` internal identifiers deliberately. The
Haruka source files are copied unchanged from the retained Mars version; only
the project directory, build outputs, documentation, and executable name are
Phobos-specific.

```text
phobos input.sol [input.sol ...] output.bin
phobos -o ORIGIN input.sol [input.sol ...] output.bin
phobos -o ORIGIN -M output.map input.sol [input.sol ...]
```

Build a host executable from the repository root with:

```text
bin/pish build-phobos.psh
```

This installs `bin/phobos.elf`. Phobos is intentionally not part of the normal
top-level FruityOS build and is not copied into the initrd, so the existing
`.fap` inventory is unchanged.

## Preserved backend

The snapshot uses the hybrid threaded-native lowering retained after the
radical Mars experiment. It reserves `r12` through `r15` for shared semantic
handlers covering Boolean normalization, compact forward zero-branches, and
compact internal calls. Other operations remain native x86-64.
