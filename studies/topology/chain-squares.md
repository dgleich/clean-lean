:::llm gpt-6 2026-11-06 role=assisted

# Chain squares and induced quotient maps

`library/algebra/chain_squares.clean` defines a commuting chain square as an
authored record with four explicitly fixed corner complexes, four chain maps,
and a proof field. Its orientation is:

```text
C ──source──▶ D
│            │
left         right
│            │
▼            ▼
E ──target──▶ F
```

The evidence states `right ∘ source = target ∘ left`. The constructor requires
that exact evidence; the opposite equality is not silently substituted. Fields
are actual maps and proof terms, not independent conditions about unspecified
maps. All objects use the same explicit field and module category.

The native `chain cokernel map` wrapper imports Mathlib's `cokernel.map`. The
authored `square quotient map` passes the record fields and its commutativity
proof to that wrapper. Its domain is the cokernel of S.source and its codomain is
the cokernel of S.target. The first study theorem proves that this map commutes
with the two cokernel projections, using `cokernel.π_desc`.

The generic `induced chain homology map` wraps the native homology functor's map
operation. `square homology map` is authored in Clean by applying it to the
quotient map in an explicit natural-number degree. Its result is a genuine
ModuleCat morphism between the homology modules of the two cokernels.

## From topological pair inclusions

`library/topology/pair_chain_squares.clean` authors the two vertical maps by
applying the singular-chain functor to the already constructed continuous maps
of ambient and relative subsets. Its transparent `PairChainSquare` type alias
fixes all four corners to the corresponding singular-chain complexes.

```clean
Result pair inclusion induces a chain square:
  Attribution: topology; singular chain functor applied to pair inclusions; original
  Let K: Type
  Let field: FieldStructure(K)
  Let H: HomologyTheory(K,field)
  Let X: TopologicalSpace
  Let Q: PairInclusion(X)
  Conclude:
    there exists (S: PairChainSquare(K,field,H,X,Q), square represents pair inclusion(field,H,X,Q,S))
```

`Square represents pair inclusion` is an authored Condition specifying all four
map fields, not just the corner complexes. The proof constructs this square,
rewrites with the singular-chain functor's composition law, and uses equality of
the two underlying continuous inclusion composites. It does not assume the
commutativity it is meant to establish. The generic square quotient/homology map
operations then apply to the resulting witness.

## Validation and limits

`verify_chain_squares.py` compares 17 independently authored native targets:
the record, constructor, all five projections (including the proof), native
cokernel/homology map adapters, authored maps/condition and both statement types.
It retains instances, universes and proof arguments in canonical comparison.
Both study proofs are kernel-checked. Python tests reject incorrect directions,
exchanged maps/evidence, mismatched ambient spaces and inconsistent degrees.
The existing relative verifier also checks the standalone chain module.

This supplies the generic map construction needed for relative homology and
proves that certified pair inclusions have suitable chain squares. It is not yet
a fully packaged relative-homology functor on a category of pairs. Clean currently
exposes the square witness explicitly. Identifying a witness's cokernel indices
with the separately named relative-chain objects still needs source-side index
conversion or explicit transport; no hidden rewriting by the representation
condition is performed. Functor laws for the packaged relative maps, connecting
maps, exactness, excision, and the well-group results remain unfinished.

Regenerate with `LAKE=lake python3 studies/topology/verify_chain_squares.py`.
Review [Clean statements](ChainSquares.clean), [generated Lean](ChainSquares.lean),
[checked Lean](ChainSquaresVerified.lean) and [PDF](ChainSquares.pdf).
:::

:::llm gpt-6 2026-11-06 role=assisted

## Named relative-map interfaces

[Relative maps](relative-maps.md) now authors the relative projections, induced
chain/homology maps and their images using named relative-object indices. The
bounded authored-definition conversion rule resolves the previously recorded
expansion mismatch. Eight canonical targets and three Lean proofs check these
interfaces. Explicit commutativity evidence is still passed; the study proves
that condition universally. Relative functor laws, exactness/excision and the
paper results remain unfinished.
:::
