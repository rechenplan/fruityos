# Sol migration plan

The migration introduces Sol and its backends without destabilizing the current
bootstrap chain.

## Fixed boundary

Peel is not part of the Sol migration.

- Peel continues to use Orgasm exactly as it does now.
- Peel source and build scripts are not modified for Sol.
- Orgasm is not converted into Mars and is not repurposed as a Sol backend.
- Existing stage0 work that depends on Orgasm remains independent until a
  separately designed transition says otherwise.

## Repository layout

The intended project layout is:

```text
sol/
    README.md
    ir.md
    syntax.md
    backend-contract.md
    pluto.md
    pluto-encoding.md
    mars/
        ... Jabara source ...
    luna/
        ... future backend ...
    terra/
        ... future backend ...

haruka/
    ... future language frontend ...
```

Documentation may keep `mars.md`, `luna-terra.md`, and `haruka.md` at the Sol
root while implementations live in their own directories.

## Phase 1: establish Sol

- Freeze the name and responsibility split.
- Keep Sol width-neutral and encoding-neutral.
- Define the semantic operation set and textual version marker.
- Define the backend contract.
- Remove obsolete documentation that treats the IR as a processor ISA.

## Phase 2: complete Mars

- Implement Mars in Jabara under `sol/mars/`.
- Parse textual Sol and emit x86-64 bytes directly.
- Use two-pass layout and symbol resolution.
- Preserve `ip`, aliasing, division, stack, and comparison semantics.
- Support multiple source files and raw flat output.
- Exercise large inputs without retaining one permanent record or closure per
  instruction.
- Keep Peel and Orgasm untouched.

## Phase 3: validate the semantic suite

- Build a target-independent Sol test corpus.
- Execute Mars output through a small x86-64 harness where practical.
- Compare memory, registers, control flow, and raw data layout.
- Add origin, relocation, malformed-source, and overflow tests.

## Phase 4: build Haruka

- Create Haruka as a separate frontend.
- Lower Haruka language constructs to Sol.
- Do not describe this as rewriting Jabara.
- Continue using Jabara where useful for implementing the toolchain.

## Phase 5: add Luna and Terra

- Define Luna's real-mode address model.
- Implement 16-bit target-width lowering.
- Implement Terra's 32-bit protected-mode lowering.
- Run the shared semantic suite at each target width.

## Phase 6: implement Pluto

- Freeze a Pluto profile and native encoding after measurements from real Sol
  programs.
- Implement a reference interpreter.
- Implement the FPGA core.
- Compare committed state between the interpreter and RTL.

## Documentation rename

The old project directory and documents should be replaced by `sol/`. Processor
architecture and encoding material moves under the Pluto name. Backend-specific
x86 material moves under Mars, Luna, or Terra. Frontend material moves under
Haruka.

The migration should not leave mixed terminology in active documentation.
Historical notes may retain old names only when clearly marked as archival.
