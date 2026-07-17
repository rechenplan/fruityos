# Luna and Terra

Luna and Terra are planned x86 backends for Sol.

## Luna

Luna targets 16-bit x86 real mode and emits a flat binary.

Its target profile is expected to select:

```text
word_bits    = 16
word_bytes   = 2
address model = real-mode segmented x86
output       = raw flat binary
```

The difficult part is not arithmetic; it is realizing Sol's flat abstract
addresses and explicit `ip` semantics over real-mode segmentation. Luna must
define whether a Sol address is an offset within a selected segment, a packed
segment:offset value, or another constrained model. That decision belongs to
Luna, not Sol.

## Terra

Terra targets 32-bit x86 protected mode and emits a flat binary.

Its expected profile is:

```text
word_bits    = 32
word_bytes   = 4
address_bits = 32
byte_order   = little endian
output       = raw flat binary
```

Terra should be simpler than Luna because a flat 32-bit address space maps
naturally onto protected-mode x86.

## Shared requirements

Both backends must preserve the same Sol-level behavior as Mars:

- canonical comparisons;
- alias-safe three-operand lowering;
- next-Sol-instruction `ip`;
- target-word stack movement;
- target-width wrapping arithmetic;
- explicit byte access;
- direct raw binary emission.

A Sol program is not automatically portable merely because all three backends
accept it. Constants, address range, stack depth, object layout, and overflow
may depend on the selected word width. Haruka should make target dependence
visible where it matters.
