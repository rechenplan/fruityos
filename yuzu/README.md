# Yuzu

Yuzu provides the `.yuzu` compiler and assembler toolchain built by the FruityOS
root pipeline.

## Build

```sh
./build.sh
```

The script recreates `yuzu/bin/` and invokes:

```text
src/byc/build.sh
src/yc/build.sh
src/zest/build.sh
```

The component contains:

- `src/byc/`, the C bootstrap compiler;
- `src/yc/`, the Yuzu compiler sources;
- `src/zest/`, the Zest assembler sources;
- `include/` and `lib/`, target headers and runtime assembly;
- `doc/manual.yuzu`, an executable language introduction.

The Jabara compiler accepts the Yuzu sources used by this repository. Peel also
builds `yc.fap` and `zest.fap` for FruityOS.

See [Jabara, Orgasm, and Yuzu toolchains](../docs/toolchain.md) for the complete
host and FAP build paths.
