# Yuzu

Yuzu provides the `.yuzu` compiler and assembler toolchain built by FruityOS.

## Build

The root Pish build runs `yuzu/build.psh` after rebuilding Jabara. The stage
writes `byc`, `yc`, and `zest` to `yuzu/out/` using `jabara/out/jc` and
`jabara/out/orgasm`.

The component contains:

- `src/byc/`, the bootstrap compiler source;
- `src/yc/`, the Yuzu compiler sources;
- `src/zest/`, the Zest assembler sources;
- `include/` and `lib/`, target headers and runtime assembly;
- `doc/manual.yuzu`, an executable language introduction.

Peel also builds `yc.fap` and `zest.fap` for FruityOS.
