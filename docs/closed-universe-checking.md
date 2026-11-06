:::llm gpt-6 2026-11-06 role=assisted

# Checking closed universe bounds

The source checker now rejects the confirmed mismatch between a Type 1 module
carrier and the Type 0 carrier parameter of the equality-reflexivity wrapper.
Higher-universe objects remain usable as values at their declared types and as
operands of the explicitly granted arrow interface. No lift is inserted.

## Declared metadata and one closed sort

There is no grammar change. `Universe: n` retains its existing nonnegative decimal
syntax and selects the native result sort Type n. Native Type declarations now
store their chosen level explicitly even when it is the default. The defaults and
emitted wrapper signatures are unchanged: ordinary bindings default to Type 0;
the existing native `Means: Type` interface defaults to Type 1. Authored structures
also retain their explicit/default result level. Transparent aliases keep their
parameter contracts and resolve before result-sort classification.

For an already checked type T, compute s(T), the closed natural level such that
its Lean target inhabits Sort s(T):

| Checked type | Selected sort level |
| --- | --- |
| ProofType(P), including resolved evidence aliases | 0 |
| Native type or structure declared with Universe n | n + 1 |
| A resolved local/formal carrier introduced with `T: Type` | 1 |
| Ordinary or dependent arrow D → C, with s(C) = 0 | 0 |
| Ordinary or dependent arrow D → C, with s(C) > 0 | max(s(D), s(C)) |

The arrow rule is Lean's imax for closed levels. It is recognized by the same
explicit module template as function application, not by its display name.
Unregistered checked type leaves are the existing Type 0 carrier variables;
source type resolution must already have rejected undeclared names. This helper
is not an unchecked-name elaborator. An unresolved numeric placeholder is not a
carrier variable and cannot supply a closed sort. A still-unresolved alias is an
internal precondition error, not a guessed universe.

The checker does not inspect an opaque Means body to infer a better universe.
Its declared interface supplies the level, and Lean validation remains responsible
for verifying that native implementation against that interface. Arbitrary invalid
native declarations do not constitute a valid fixed environment.

## Type-parameter gates

A parameter declared `T: Type` fixes its carrier to Lean Type 0, so a candidate
must have s(T) = 1. All three existing inference paths enforce this condition:

1. Type/alias/structure constructor type arguments, before alias expansion;
2. Legacy polymorphic callable matching;
3. Dependent-call inference of an implicit Type carrier.

Prop (level 0) retains its existing proof-type rejection. Higher levels produce a
Type 0 versus Type n diagnostic. Unresolved numeric carriers produce an unresolved
universe diagnostic. There is no search for a coercion, lift, alternative instance,
or different carrier. Unused actual type arguments are checked too.

The native arrow interface is the existing explicit exception for its own domain
and codomain operands. It accepts their checked sorts and computes imax; it is not
an application of the closed demonstration wrapper. A differently named constructor
with the arrow template has the same grant, whereas a product template does not.
An authored alias with Type parameters still checks those parameters before
expanding its arrow body; aliases do not silently widen their declared bounds.

This is a check of declared bounds, not a claim that the corresponding construction
is impossible in Lean at higher levels. General universe-polymorphic source
parameters are still a separate language feature.

## Structure fields

After resolving fields and the declared Universe u, check each field type F in
source order and require s(F) ≤ u + 1. Reject an oversized field before publishing
the structure or its constructor. The checker never raises the declared universe
automatically. Higher-level value parameters alone do not raise a record's result
universe; the field types determine whether the stated result bound is valid.

A module object field requires a Type 1 record. A function from modules to natural
numbers also requires Type 1, despite its small codomain. In contrast, a proof
field `(M : ModuleCat K) → M = M` has sort Prop and fits in a Type 0 record. The
existing carrier-type-field restriction remains unchanged; this check does not
introduce dependent type-valued fields.

## Deterministic target and acceptance

Accepted declarations keep their original native targets, explicit Universe values,
wrapper applications, instances and argument order. Rejections do not emit a
replacement target or publish a partial callable. Sort arithmetic is structural
and closed; no elaboration candidate search or native body normalization occurs.
Resource exhaustion remains incomplete analysis, not a successful universe check.

[ClosedUniverses.clean](../studies/dependent-functions/ClosedUniverses.clean) contains
an authored Type 1 module holder, a Type 0 proof-law holder, ordinary authored
operations on module objects, and a constant function with a large domain and small
codomain. Fourteen independent canonical targets and four native sort assertions
check the records, constructors, projections, operations and three statements.
All three statements have kernel-checked proofs. The native checker compares theorem
projection bodies as well as their types; it does not use proof irrelevance to
replace canonical-target comparison.

`tests/test_closed_universes.py` checks the original failing definition, both
polymorphic inference paths, constructor/alias bounds, the arrow grant, mixed-size
function types, proof-field impredicativity, structure publication on failure,
explicit higher native levels and unresolved literals. Existing proof-family,
structure and default-universe tests remain applicable.

General universe parameters, Type-valued dependent binders, native-sort inference,
and broader resolved-name/shadowing work remain open. This closes the documented
Type 1-to-Type 0 inference gap for the existing closed interfaces.
:::
