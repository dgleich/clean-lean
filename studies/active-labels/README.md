:::llm gpt-6 2026-11-07 role=assisted

# Active labels at a restricted vertex

This construction connects clipped interval labels to basis reindexing. The old
index type consists of labels active at the embedded vertex `a+v`. The new index
type consists of surviving labels active at the restricted vertex `v`: a label,
evidence of survival, and evidence of activity.

## Checked generic construction

`library/logic/subtype_restriction.clean` works with three explicit sets: `S` and
`T` in a carrier `A`, and `U` in the subtype `Element(A,S)`. Its support record has
three membership obligations:

- Each element of `T` belongs to `S`.
- That element, paired with its survival evidence, belongs to `U`.
- The underlying value of each element of `U` belongs to `T`.

Both maps preserve underlying values. Their definitions and equivalence assembly
are authored in Clean. The only imported operations are subtype value/membership,
subtype construction, and the ordinary equivalence interface. The inverse laws
follow by subtype extensionality, with no additional assumptions.

`Generic.clean` states the two inverse laws and existence of a value-preserving
equivalence given the explicit support record. Run
`LAKE=lake python3 studies/active-labels/verify_generic.py`: ten exact checks and
three Lean proofs pass. The constructor oracle checks implicit parameter metadata
as well as the dependent field types. Five Python checks cover carriers, wrong-set
evidence, direction, field layout and authored bodies. The one-page `Generic.pdf`
was compiled twice and inspected. Expected generic native expressions are independently authored in
[GenericOracle.lean.in](GenericOracle.lean.in); they are not derived from generated
targets. The interval driver retains a separate pending oracle.

## Checked arithmetic construction

Run `LAKE=lake python3 studies/active-labels/verify_arithmetic.py`. This loads the
Clean-authored generic construction and interval-clipping foundations, then proves
support and the value-preserving equivalence for the independently authored native
old/new active-set expressions from `verify.py`. The generated `Arithmetic.lean`
passes the Lean kernel. The support evidence is derived from numerical bounds;
it is not assumed. No axioms or `sorry` are added.

The first run exposed two proof issues: the raw support constructor's parameters
are implicit, and the interval-label constructor wrapper must be unfolded before
`omega` can see endpoint arithmetic. The checked version uses expected-type record
construction and includes that wrapper in its unfold list. Both fixes are now in
the full verifier.

This isolates mathematical correctness from the remaining translation bottleneck.
It does **not** compare the full generated interval definitions/statements against
the native oracle: that bridge remains pending. `Arithmetic.lean` is a native-oracle
check, not a replacement for `Statements.clean` or its requested verification.

## Interval translation remains in progress

`library/diagrams/active_labels.clean` instantiates the generic construction with
the surviving set, original active set, and restricted active set. Its type aliases
keep authored signatures shorter. Transparent aliases now support optional
`Describe` metadata under the [alias contract](../../docs/alias-descriptions.md).

The final interval existence theorem assumes only a subpath bound and ordered
interval labels. It does **not** assume support or inverse laws. Its verifier must
construct support from numerical bounds and then instantiate the checked generic
maps. The isolated native construction passes; full interval verification is not complete. The updated verifier specifies
fourteen canonical body/type comparisons and one constructor-type comparison,
plus four proof obligations; these are pending checks, not passing counts.

The initial interval-specific support record and maps loaded, but its instrumented
verifier crashed during translation with status 139. The cause is not established.
That source and its plain translation job were superseded by the generic refactor.
An interval run carrying the old explicit-constructor oracle was also stopped once
the generic native check demonstrated that the constructor parameters are implicit.
The interval verifier started before the latest proof fixes and the plain
refactored translation remain running. Their eventual artifacts can be checked
with the updated proof driver, without repeating translation.

Once `Generated.lean` exists, run `LAKE=lake python3 studies/active-labels/verify.py
--from-generated` to replay canonical comparisons and corrected proofs for that
artifact. The driver requires exactly one generated binding for each referenced
name. Snapshot mode does not claim to regenerate or validate changed Clean sources;
the default mode still translates first. The replay path has not yet had a complete
interval artifact to check. Its binding lookup was checked against `Arithmetic.lean`.

[Comparison experiments](experiments/README.md) preserve two unintegrated compiler
patches and their results. The fresh-subtree rule has now been integrated after
its [scope audit](../../docs/fresh-checked-subtrees.md); the earlier tree-only
reuse and call-index cache patches remain unintegrated.
A separate [declaration-token scan cache](../../docs/fresh-bound-name-cache.md)
preserves the existing fresh-name rule and is now implemented. The [restricted-basis study](../interval-basis-restriction/README.md) now checks a
pointwise basis construction and full interval-basis restriction, including four
exact Clean target comparisons and proofs of both generated statements. Its
assembly uses separately checked vanishing and edge-compatibility results. The
pyramid theorem and the full canonical check of this module's specialized maps
remain unfinished.
:::

:::llm gpt-6 2026-11-10 role=assisted

## Current generic verification

The generic driver has been migrated to the explicit native wrapper model.
It substitutes only declaration identifiers into independently authored expected
expressions. The oracle retains the declared set, element, equivalence, membership,
equality and carrier-of-types wrappers, and distinguishes implicit native carrier
parameters from authored explicit carrier parameters. Constructor parameter
metadata is still compared structurally; the check was not weakened to
normalization or definitional equality.

The old driver failed on root-qualified identifier lookup and on expected raw Lean
types/relations. The migrated driver now passes all ten canonical comparisons and
three round-trip/equivalence proofs and five related Python tests directly on
the current compiler. The regenerated
one-page Generic PDF builds in two passes and has been inspected. No Clean
mathematical definition or theorem assumption was changed for this migration.

The current full regression and interval-specific translation are separate live
jobs. Their outcomes are pending; historical references above to earlier running
jobs are not evidence about these new runs. The current interval source still
must produce its complete Generated.lean artifact before its specialized canonical
expectations and arithmetic proofs can be migrated and checked.
:::

:::llm gpt-6 2026-11-10 role=assisted

## Current arithmetic support proof

The arithmetic driver has also been renewed on the current compiler. Its proof
unfolds the explicitly declared membership, conjunction, natural arithmetic,
vertex order and numeral adapters. It then uses Lean `change` to state each
natural-number obligation explicitly and derives `v.val ≤ m` from `v.isLt`.
The derived inequality is not a new hypothesis. `omega` checks the three
support fields, and subtype extensionality supplies the inverse laws.

The reusable proof is in [ArithmeticSupport.lean.in](ArithmeticSupport.lean.in).
Regenerating [Arithmetic.lean](Arithmetic.lean) with `verify_arithmetic.py` passes
the Lean kernel for support existence and the native active-label equivalence
existence theorem. No axiom, placeholder proof or added support assumption is used.
These are proofs for the driver's independently authored native old/new active-set
expressions. They still do not establish equality with every specialized generated
Clean target; that comparison awaits the full interval translation and its oracle
migration. The generic Clean theorem comparison above is separately checked.

The failed initial rerun left the declared operations opaque to the arithmetic
tactic. Unfolding alone still left the proof unsuccessful; explicitly checking the
natural goal shapes and deriving the vertex bound made all three obligations
close. Only the proof driver and its generated artifact changed. The compiler,
Clean definitions and mathematical theorem assumptions remained fixed throughout.
:::

:::llm gpt-6 2026-11-10 role=assisted

## Prepared specialized target expectations

[ActiveOracle.lean.in](ActiveOracle.lean.in) independently specifies the five
specialized definitions (old/new active sets, restriction, restoration and
assembled equivalence) and three theorem propositions using the explicit native
wrapper identities. Natural index arithmetic retains the declared addition and
numeral constructors. Expected terms are not extracted from generated bodies.

`LAKE=lake python3 studies/active-labels/verify_expected.py` first regenerates and
checks the arithmetic foundation, then type-checks these prospective targets and
proves both round trips and existence for their native definitions. All three
preview proofs pass. The existence proof reuses the checked arithmetic theorem;
it introduces no support assumption.

This is **not** a canonical comparison with the specialized Clean output. The
preview maps its specialized names to its own independently authored definitions,
so it checks the consistency and mathematics of the expected side only. The
remaining acceptance step must map those names to the corresponding generated
Clean declarations and compare both types and bodies structurally, then run the
proofs against the generated theorem propositions. The current full translation
is still running and has not yet produced its complete artifact. This preview
does not replace or restart that run.
:::
