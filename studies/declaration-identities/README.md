:::llm gpt-6 2026-11-07 role=assisted

# Declaration identity across preceding imports

This executable acceptance slice distinguishes generated spelling from declaration
meaning. [Family.clean](Family.clean) declares a dependent proof-family identity
function and a record containing such a family. The driver loads that same file
in two fresh environments: alone, and after [Unrelated.clean](Unrelated.clean),
which consumes compiler binder names but does not supply names used by Family.

Run from the repository root:

```sh
LAKE=lake python3 studies/declaration-identities/verify.py
```

[Verified.lean](Verified.lean) contains both generated environments and separately
authored native oracles. Eleven exact checks pass:

- Two comparisons of the family identity's type and body against the native oracle,
  and one direct comparison between the environments.
- For each record, four comparisons covering its type, raw constructor type,
  projection type/body, and explicit Clean constructor wrapper type/body.

Independent syntax checks cover the structure header and dependent field annotation.
The emitted spellings differ in this fixture. The targets still agree after the
contract's bound-variable normalization and the explicit declaration mapping below.
A kernel-valid alternative proof-family body is rejected by the exact comparison;
proof irrelevance and definitional equality do not replace structural comparison.

## Identity mapping used here

The authored declaration `FamilyRecord` in the same source file identifies the
record in both environments. For each environment, the fixture maps that record
constant to `ExpectedRecord` and its raw `mk` constructor to `ExpectedRecord.mk`.
Those are the only renamed constants. Projection nodes rename their record owner
through the same map. Binder display names and metadata are removed. Application
structure, universes, binder kinds, types, ordinary constants, and proof arguments
are retained. Record field projections are Lean theorem declarations in this
example; their proof bodies are compared as well as their types.

The constructor and projection comparisons validate the mapped declaration's
shape and bodies. Merely giving two wrappers the same display name would not make
these checks pass. The driver selects bindings from the explicit Clean environment;
it does not infer correspondence from hash suffixes or allow arbitrary renaming.

## Limits

This is a bounded environment-invariance check for one dependent callable and one
record. It does not establish general module-owned scope, portable generated
identifiers, operator isolation, universe-polymorphic bundles, or the full canonical
declaration-graph contract. It does not permute an import past a declaration that
uses it. The unrelated import is deliberately absent from the checked declarations'
mathematical dependencies. No compiler behavior or identifier algorithm changes.
:::
