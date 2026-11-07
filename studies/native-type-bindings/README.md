:::llm gpt-6 2026-11-07 role=assisted

# Native type adapters retain their declaration scope

Status: isolated prototype, not enabled in main. Apply `prototype.patch` after
the carrier, bound-call, proof-binding, annotation and local-type patches.

The earlier compiler prints a native type's `Means` body inline at every use.
This changes the meaning of an otherwise valid statement:

```text
Type NativeReal():
  Means: Real
  Render latex: \mathbb{{R}}

Result native constant retains scope:
  Attribution: local; constant capture regression; original
  Let Real: Type
  Let x: NativeReal
  Conclude: x = x
```

The old generated binder is `x : Real`, where Lean resolves `Real` to the local
type parameter. The intended type is the real numbers selected by the adapter's
declaration. Both versions compile. `check_capture.py` first verifies compilation,
then requires definitional equality with the independently stated mathematical
meaning. This gate fails on the preceding local-type prototype and passes here.

## Constructive emission rule

Parsing and source syntax are unchanged. For each opaque `Type … Means: …`
declaration, check its ordered parameter telescope and fixed universe as before,
then emit the existing generated declaration as a **noncomputable abbreviation**.
Its declaration-scoped body is the native `Means` expression. Retain the selected
global declaration name, original template and full declaration text in the
checked type metadata.

At a type use, render each checked argument in order and emit the root-qualified
global reference applied to those arguments. Do not insert or substitute the
native body into the caller's scope. Schematically:

```lean
noncomputable abbrev cleanType_NativeReal_id : Type := Real

def statement : Prop :=
  ∀ (Real : Type) (x : _root_.cleanType_NativeReal_id), x = x
```

The actual generated identifier uses the existing deterministic name/body hash;
`id` above is an explanatory placeholder. `_root_` prevents capture even when a
local binder deliberately has the generated declaration's full name.
Rendering rejects changed templates and missing or changed selected declaration
text. Local carrier references continue to emit their own Lean binders; authored
type aliases continue to use checked semantic substitution from the preceding
prototype.

Use an abbreviation rather than an ordinary definition so Lean's instance
synthesis can unfold the type binding. The first experiment with ordinary
definitions failed to synthesize instances such as `LE Natural` and matrix
subtraction. Abbreviations restore the 92 curated corpus proofs. This is a
semantic requirement for the binding's transparency, not a cosmetic spelling.

## Structural arrow interface

The existing declared-arrow interface is an explicit exception to wrapper
application. A type declaration whose checked native template is exactly the
two-argument Lean arrow interface renders an ordinary arrow from its two checked
semantic arguments. Validate its selected native declaration before doing so.
Dependent arrows retain their existing structural Pi emission.

This preserves the existing allowance for proof domains and codomains, and for
higher-sort arrow arguments. A generated helper with parameters `T U : Type`
cannot itself accept propositions as those arguments. For example,
`Function((p),(q))` emits `p → q`, not an application of that helper. There is no
textual substitution into an opaque native body at this use site. Renaming the
Clean arrow constructor does not change this rule; it is not dispatched by the
display name `Function`.

## Independent checks

```sh
LAKE=/home/claude/.elan/bin/lake python studies/native-type-bindings/verify_prototype.py
```

The driver rebuilds a fresh tracked checkout, applies all six patches and strictly
regenerates the parser. It checks eleven canonical native targets: six independent
adapter bodies, four source statements and a deliberate generated-name collision.
The mapping supplies only generated declaration names, never expected bodies.
Six proofs cover the statements and their ordinary mathematical reading. Negative
checks mutate or remove selected bindings. See [PrototypeVerified.lean](PrototypeVerified.lean).

The eight affected Python assertions now expect references to selected global
type declarations rather than inline native bodies. They retain their scope,
universe and argument-order checks. All 274 focused regressions pass, and Lean
checks the 92 regenerated corpus proof fixtures.

## Remaining integration work

This deliberately changes canonical targets to include explicit type-binding
references. Earlier native oracles expecting inline real, natural or vector types
must be migrated with independent adapter-body checks; they are not counted as
passing under this prototype. The local-type prototype's full suite continues
separately and does not validate this additional change.

Native imports are still gathered at the top of the emitted Lean file. This does
not establish per-Clean-module native import/instance isolation. Generated
callable and record references need the same root-qualification audit. Metadata
constructed outside authored declarations still has legacy fallback paths.
Full declaration-owned identity, serialization, operator composition, literal
interpretation, broader study validation and main integration remain open.
:::
