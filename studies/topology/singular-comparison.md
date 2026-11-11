:::llm gpt-6 2026-11-11 role=assisted

# Singular chain homology and ordinary homology

The existing Clean interfaces name the same Mathlib construction in two ways:
`chain homology(field,singular chains(field,H,X),H.degree)` and
`homology module(field,H,X)`. Mathlib defines `singularHomologyFunctor` by
composing singular chains with the homology functor. Thus their underlying Lean
objects, and the maps induced by continuous functions, agree by unfolding.

The [comparison module](../../library/topology/singular_homology_comparison.clean)
exposes two explicit maps between the named Clean interfaces. Each native body
is the categorical identity of the ordinary singular homology object, with the
supplied field instance. The forward signature is:

```clean
Notation singular homology comparison(field,H,X):
  Let K: Type
  Let field: FieldStructure(K)
  Let H: HomologyTheory(K,field)
  Let X: TopologicalSpace
  Returns: ModuleMap(K,field,(chain homology(field,singular chains(field,H,X),H.degree)),(homology module(field,H,X)))
```

This excerpt omits the native body and rendering, which are in the module. The
reverse signature exchanges the source and target. Neither map transports
along a user-supplied equality or chooses a noncanonical isomorphism.

## Why two explicit adapters?

Clean retains the declared operations and their dependent result indices. This
module does not add a general rule identifying two Clean expressions because
Lean can unfold them to the same expression. The adapter declares precisely
where that foundational identification is used, in each direction. Its unique
Lean body is checked independently, including the explicit field instance and
identity object. This is a standard-functor interface, not a new paper-specific
mathematical definition hidden in Lean.

There is no new syntax or general conversion policy. Future changes to Clean's
conversion rules would still require their own specification and acceptance
checks; these two adapters do not establish that broader capability.

## Statements and validation

[Four Clean statements](SingularComparison.clean) express the two inverse laws
and naturality in both directions for any continuous map `g : ContinuousMap(X,Y)`.
The naturality statements compare the homology map of the induced singular chain
map with the existing ordinary homology linear map. The local chain and module
abbreviations remain lets in Lean.

[The verifier](verify_singular_comparison.py) independently specifies the two
adapter bodies and four statement targets, compares canonical Lean types and
bodies, and checks four proofs. The canonical comparator does not replace its
structural checks with definitional equality. Definitional unfolding is used
inside the mathematical proofs to establish that the two functor interfaces
agree on maps.

```sh
LAKE=lake python3 studies/topology/verify_singular_comparison.py
```

Outputs: [definitions and statements](SingularComparison.lean),
[canonical checks and proofs](SingularComparisonVerified.lean).

## Remaining assembly

These comparisons apply to the ambient singular chains in an empty-relative-part
pair. The [relative-to-ordinary module](relative-ordinary-comparison.md) now composes
them with the vanishing quotient comparison, using explicit zero-inclusion
evidence. The [empty-inclusion theorem](empty-chains.md) and
[level emptiness certificates](level-empty-pairs.md) supply the relevant premises.
Naturality and a complete level-set application remain pending. Neither well-group equality nor
closed-cover/excision follows merely from the ordinary singular-homology bridge.
:::

:::llm gpt-6 2026-11-11 role=assisted

Validation completed: six canonical targets and four inverse/naturality proofs
pass. Legacy and joint elaboration produce identical Lean text for the module
and four-result study under matching stable fingerprints. All 92 corpus proofs
pass under joint routing; evidence is retained as `singular_homology_comparison`
in [the compatibility report](../parameterized-literals/compatibility.json).
The reference HTML IDs/links and provenance checks pass. Full regression,
active-label validation and browser rebuild were separately confirmed live;
these focused checks do not establish their completion.
:::
