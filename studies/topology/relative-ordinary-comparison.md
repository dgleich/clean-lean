:::llm gpt-6 2026-11-11 role=assisted

# Relative-to-ordinary homology comparison

[The module](../../library/topology/relative_ordinary_comparison.clean) composes
the checked quotient and singular-homology comparisons into two Clean-authored
maps. It adds no native adapters and no new syntax.

For a certified pair `Q : TopologicalPair(X)`, the forward map
`relative to ordinary homology(field,H,X,Q,h)` goes from its relative homology
to ordinary homology of its ambient subspace. The supplied evidence `h` states
that the actual chain inclusion from the relative subspace to the ambient
subspace is zero. The map first applies the vanishing-quotient homology map,
then the singular-homology comparison.

The reverse map `ordinary to relative homology(field,H,X,Q)` first uses the
inverse singular-homology comparison and then the homology map of the canonical
cokernel projection. This direction requires no zero-inclusion hypothesis.

## Explicit premise and use with empty relative parts

The forward map's premise is:

```clean
Let h: Evidence((pair chain inclusion(field,H,X,Q) = zero chain map(field,singular chains(field,H,subspace(X,Q.relative)),singular chains(field,H,subspace(X,Q.ambient)))))
```

This is intentionally the equality needed by the previously declared transport
operation. No tactic or hidden rule supplies it during translation. For an empty
relative part, the [empty-chain study](empty-chains.md) proves precisely this
equality. The [level-pair study](level-empty-pairs.md) supplies emptiness and
certification results for level constructions. A proof author can pass those
proofs explicitly; the module does not silently synthesize the chain equality.

The definitions use existing `module composition` in forward order: its first
map is applied first. Both the intermediate chain-homology object and the final
ordinary-homology object are explicit. Clean retains these declared bodies; it
does not replace the composite with a native isomorphism or an arbitrary inverse.

## Statements and checks

[Four Clean results](RelativeOrdinaryComparison.clean) state that the maps are
mutual inverses whenever the chain inclusion vanishes and commute with the
existing relative homology maps of pair inclusions. They name the relative
and ordinary homology objects using local lets, which are preserved in Lean.

[The verifier](verify_relative_ordinary_comparison.py) independently specifies
the two composite definition targets and the four result targets. It compares
canonical Lean types and bodies, and proves both inverse laws and both naturality laws. Three generic
chain helper lemmas justify the cokernel reduction/projection identities and
reduction naturality for the canonical cokernel map; the proofs then apply the
homology functor and simplify the explicit singular comparison identities. No axioms or unfinished proofs are introduced.

```sh
LAKE=lake python3 studies/topology/verify_relative_ordinary_comparison.py
```

Outputs: [definitions and statements](RelativeOrdinaryComparison.lean),
[canonical comparisons and proofs](RelativeOrdinaryComparisonVerified.lean).

## Remaining work

The comparison is natural for the existing `relative homology map` of a pair
inclusion. The forward naturality statement retains the supplied commutative
chain square and both zero-inclusion proofs; it requires no additional equality
between those proofs. The reverse naturality statement holds without either
zero-inclusion hypothesis. It uses the canonical cokernel projection identity.

A complete level-set application must still connect the explicit emptiness,
certification and inclusion-zero proofs to these maps in its own checked
statement. Well-group formulas and closed-cover/excision remain unproved.

## Readability boundary encountered

Assumption labels containing several words are display labels; the current
[evidence specification](../../docs/evidence.md) only binds single-identifier
labels as expression-level proof arguments. Accordingly the naturality example
uses `sourceZero` and `targetZero`. Writing `source zero` as a bare argument is
rejected by the grammar. This study does not change that policy or implicitly
resolve a display label to a Lean identifier. Supporting readable references to
multiword labels would require a specified, unambiguous expression form and its
own acceptance checks.
:::

:::llm gpt-6 2026-11-11 role=assisted

Initial inverse-only validation: four exact targets, two inverse proofs and two generic
chain helper lemmas pass. Legacy and joint elaboration produce identical Lean
text for the module and two-result study with matching stable fingerprints.
All 92 corpus proofs pass under joint routing. Evidence is stored under
`relative_ordinary_homology_comparison` in
[the compatibility report](../parameterized-literals/compatibility.json).
Reference HTML IDs/links and provenance checks pass. The separate full regression,
active-label validation and browser rebuild remain live and are not counted as
completed by these focused checks.
:::

:::llm gpt-6 2026-11-11 role=assisted

Naturality validation: six canonical targets, four comparison proofs and three
generic chain helper lemmas pass. Both elaboration routes produce identical
Lean text for the module and the updated four-result study under matching stable
fingerprints. All 92 corpus proofs pass under joint routing; evidence is retained
under `relative_ordinary_naturality` in the compatibility report linked above.
HTML IDs/links and provenance checks pass. The full regression, active-label
validation and browser rebuild remain live and are not counted as passed.
:::
