:::llm gpt-6 2026-11-06 role=assisted

# Maps and images of relative homology

The [relative-map module](../../library/topology/relative_maps.clean) now authors
relative chain projections, inclusion-induced relative chain maps, homology maps,
and their images in Clean. Their signatures use the named relative-chain and
relative-homology objects introduced earlier. The generic cokernel/homology bodies
match those signatures by the bounded [definition-conversion rule](../../docs/definition-conversion.md).

The readable condition `pair chain commutes(field,H,X,Q)` states the equality of
the two actual singular-chain composites. A Lean proof establishes it for every
certified pair inclusion. Definitions take this evidence explicitly:

```clean
Define relative homology map(field,H,X,Q,h):
  Let K: Type
  Let field: FieldStructure(K)
  Let H: HomologyTheory(K,field)
  Let X: TopologicalSpace
  Let Q: PairInclusion(X)
  Let h: Evidence((pair chain commutes(field,H,X,Q)))
  Returns: ModuleMap(K,field,(relative homology(field,H,X,Q.source)),(relative homology(field,H,X,Q.target)))
  Equals:
    induced chain homology map(field,relative chains(field,H,X,Q.source),relative chains(field,H,X,Q.target),
      relative chain map(field,H,X,Q,h),H.degree)
```

The earlier square-existence witness is no longer required merely to name the
source and target objects. Evidence is still an explicit argument: Clean has not
acquired a tactic language or automatic access to the accompanying Lean proofs.
The remaining statements bind h for that purpose; the first statement proves
that the required condition holds, so it is not a new mathematical restriction
on pair inclusions.

The image is the ordinary range of the resulting module map in exactly the
homology of Q.target. Its membership theorem is checked through the generic
module-range definition. The quotient projection naturality theorem is checked
using Mathlib's cokernel universal property. None of these statements assumes
its own conclusion.

`verify_relative_maps.py` independently compares eight exact native targets:
five authored interfaces and three statement propositions. It kernel-checks
commutativity, quotient naturality and image membership. It preserves named
relative-object wrappers in expected signatures; acceptance does not substitute
expanded types merely because they compile.

Functor identity/composition laws for these relative maps, a category-of-pairs
interface, connecting morphisms, exactness, excision and the paper results remain unfinished. Perturbation-family
intersections are now implemented in the [well-group study](well-groups.md). Distinct named target
pairs still have distinct indices unless the bounded conversion rule identifies
their authored expressions. No arbitrary equality transport or closed-cover
excision is silently supplied.

Review [Clean statements](RelativeMaps.clean), [generated Lean](RelativeMaps.lean),
[proofs and target oracles](RelativeMapsVerified.lean), and [PDF](RelativeMaps.pdf).
Regenerate with `LAKE=lake python3 studies/topology/verify_relative_maps.py`.
:::
