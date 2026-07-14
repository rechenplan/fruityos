# Yuzu compatibility

Yuzu is FruityOS's retained predecessor language and toolchain. Current kernel,
userland, and compiler development uses Jabara; the `.yuzu` sources remain here
to preserve the historical compiler and assembler interfaces.

The root build runs `yuzu/build.sh` to produce the `yc` compiler and `zest`
assembler compatibility programs through the current Jabara-based build path.
New sources outside this directory use the `.jabara` extension. Orgasm is the
maintained Jabara assembler and remains command-compatible with the Zest modes
used by FruityOS.

For the active compiler and assembler architecture, see
[Jabara and Orgasm toolchain](../docs/toolchain.md). The Jabara language itself
is documented in the [language manual](../jabara/docs/manual.md).
