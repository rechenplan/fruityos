# Yuzu

Yuzu provides the `.yuzu` compiler and assembler toolchain built by FruityOS.

## Build

The root invokes the same component build for host and target:

```text
cd yuzu
build.psh $platform
build.psh fruityos-x86_64
```

Yuzu owns and writes `byc`, `yc`, and `zest` beneath `yuzu/out/$1/`. Peel does
not build or stage Yuzu artifacts.

The component contains:

- `src/byc/`, the compatibility compiler source;
- `src/yc/`, the Yuzu compiler sources;
- `src/zest/`, the Zest assembler sources;
- `include/` and `lib/`, target headers and runtime assembly;
- `doc/manual.yuzu`, an executable language introduction.
