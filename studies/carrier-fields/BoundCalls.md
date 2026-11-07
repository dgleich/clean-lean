:::llm gpt-6 2026-11-07 role=assisted

# Bound calls in computed indices: isolated repair

[bound-calls.patch](bound-calls.patch) applies after the carrier prototype. It fixes
[the captured carrier counterexample](CapturedCarrier.clean.proposed) without changing
authored syntax or choosing a target using successful Lean checking. Main Clean and
the base carrier patch remain unchanged.

## Constructive rule

The parser still produces `Call(name, arguments)`. When storing a checked computed
index, resolve its call heads in the declaration's checked local environment:

- If the name denotes a local value with Function type, store an application of that
  local reference. Substitution acts on that reference like any other parameter.
- Otherwise store internal `ModuleCall(name, arguments, targetTemplate)`. The template
  is the exact explicit module adapter template already selected by Clean. A same-named
  nonfunction local does not bind a call head.
- Recursively resolve arguments. Substitution changes arguments, never the name or
  target template of a module call. Re-elaboration checks that the current declaration
  still has that template and rejects a changed or missing binding. It invokes the
  module callable directly, bypassing local function lookup only for this head.

This is a semantic annotation on one parsed tree, not a new source constructor or a
second parse. Source/LaTeX spelling remains the authored name. Native targets keep the
existing generated wrapper names and explicit arguments. The template check does not
establish the broader module-owned identity/exports contract or immutable transitive
native environments.

Closed binder-free authored bodies are also stored with these resolved heads, alongside
their original source tree. Bound-call comparison may use that body despite a shadowing
caller local. Ordinary unannotated expressions retain the existing conservative
opacity rule. Unsupported body closure leaves that body opaque; only the specific
unsupported-closure exception is caught, never arbitrary type or resolution failures.

## Consumer coverage and limits

The patch updates expression elaboration, computed-index substitution, native comparison,
source spelling, automatic argument-label spelling, occurrence analysis, hygienic
substitution, and immediate/quantified beta traversals to preserve the internal head.
Local calls become applications, so their parameters remain substitutable. Repeated
substitution must preserve the stored identity. Proof-index storage has its own path
and is **not migrated** by this patch.

Type expressions embedded as source strings remain a structural gap. Plain TypeValue
annotations without call heads retain their current handling; a computed call nested
inside a TypeValue is explicitly rejected by this prototype. Such annotations need
binding-aware structural type storage before integration. This is a known regression
boundary, not a language restriction accepted for the final implementation. Authored
bodies containing TypeValue are not marked closed. Binders also remain outside this
body-closure slice. Projection normalization may keep a bound producer opaque.

## Validation

Run `LAKE=lake python3 studies/carrier-fields/verify_bound_calls.py`. It copies tracked
source, applies both patches, regenerates/checks the grammar, and runs:

- The exact captured-carrier rejection, with no acceptance of parser/import failures.
- Three independently authored native target comparisons and three proofs: a module
  carrier under local shadowing, a genuinely local callable parameter, and a same-name
  nonfunction parameter that must not bind a module call head.
- Changed-target rejection, repeated-substitution identity preservation, exact source
  and bound trees, source/label spelling and occurrence analysis.
- The same wrong/right distinction for computed vector dimensions, and an explicit
  rejection at the still-unsupported nested TypeValue call boundary.
- The carrier study's 21 target checks, six proofs and 221 regression tests.

[BoundCallsVerified.lean](BoundCallsVerified.lean) is the generated native fixture.
The first fixture attempt omitted `noncomputable` on six expected/actual definitions;
Lean rejected code generation. The fixture was corrected without changing proofs.

This repair remains isolated pending structural annotations, proof indices, operator
composition, a complete consumer audit and full corpus/study validation. It does not
establish complete language conformance.
:::
