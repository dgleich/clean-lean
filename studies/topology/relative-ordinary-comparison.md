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

[Two Clean results](RelativeOrdinaryComparison.clean) state that the maps are
mutual inverses whenever the chain inclusion vanishes. They name the relative
and ordinary homology objects using local lets, which are preserved in Lean.

[The verifier](verify_relative_ordinary_comparison.py) independently specifies
the two composite definition targets and the two result targets. It compares
canonical Lean types and bodies, and proves both inverse laws. Two generic
chain helper lemmas justify the cokernel reduction/projection identities; the
proofs then apply the homology functor and simplify the explicit singular
comparison identities. No axioms or unfinished proofs are introduced.

```sh
LAKE=lake python3 studies/topology/verify_relative_ordinary_comparison.py
```

Outputs: [definitions and statements](RelativeOrdinaryComparison.lean),
[canonical comparisons and proofs](RelativeOrdinaryComparisonVerified.lean).

## Remaining work

The objectwise relative-to-ordinary maps are now explicit. Naturality for the
existing `relative homology map` of a pair inclusion remains to be proved,
including compatibility of the supplied zero equalities and the commutative
chain square. A complete level-set application must connect the explicit
certificates and maps in its own checked statement. This does not establish
well-group formulas or the closed-cover/excision argument.
:::

:::llm gpt-6 2026-11-11 role=assisted

Validation completed: four exact targets, two inverse proofs and two generic
chain helper lemmas pass. Legacy and joint elaboration produce identical Lean
text for the module and two-result study with matching stable fingerprints.
All 92 corpus proofs pass under joint routing. Evidence is stored under
`relative_ordinary_homology_comparison` in
[the compatibility report](../parameterized-literals/compatibility.json).
Reference HTML IDs/links and provenance checks pass. The separate full regression,
active-label validation and browser rebuild remain live and are not counted as
completed by these focused checks.
:::
