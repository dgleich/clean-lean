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
was compiled twice and inspected. Expected native expressions are shared literal
oracles in `verify.py`; they are not derived from generated targets.

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
patches and their limited results. No compiler optimization was adopted. Constructing
and reindexing the actual interval bases, then proving vector compatibility and the
pyramid theorem, remains subsequent mathematical work.
:::
