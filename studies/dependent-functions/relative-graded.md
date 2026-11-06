:::llm gpt-6 2026-11-06 role=assisted

# Graded relative homology

[RelativeGraded.clean](RelativeGraded.clean) connects the degree-indexed interface
to relative homology. The [algebra module](../../library/algebra/graded_chain_homology.clean)
authors homology in every natural degree and its induced graded map. It uses existing
Mathlib chain-homology adapters and adds a generic identity-chain-map binding.

The [topology module](../../library/topology/graded_relative_homology.clean) defines
its graded relative object by applying that construction to the existing relative
chain complex. Its map applies graded chain homology to the existing induced quotient
chain map. Both definitions are authored entirely with `Equals:`.

```clean
Define graded relative homology(K,field,H,X,P):
  Let K: Type
  Let field: FieldStructure(K)
  Let H: HomologyTheory(K,field)
  Let X: TopologicalSpace
  Let P: TopologicalPair(X)
  Returns: GradedModule(K,field)
  Equals: graded chain homology(K,field,relative chains(field,H,X,P))
```

H still packages coefficients and a selected degree for compatibility with the
existing ungraded interface. The graded object uses H's coefficient chain complex
and contains all natural degrees; H.degree selects the component that equals the
previous `relative homology` object. This work does not change the coefficient model
or add negative homological degrees.

A pair-inclusion map takes one explicit `pair chain commutes` certificate. That is a
chain-level condition, so the same certificate defines the map in every degree.
The certificate is not an assumption of the desired homology identity. The earlier
relative-map study proves that this condition holds for certified pair inclusions.

The verifier independently compares five interface targets and five proposition
targets. Proofs establish the chain-map component formula, graded chain-homology
identity and composition, and the two selected-degree relative component formulas.
These are functor laws at the chain-complex level. They do not establish that the
pair-inclusion construction preserves identity/composition, a category of pairs,
relative excision, Mayer–Vietoris exactness, or any research-paper equality.

The port required [family index comparison](../../docs/family-index-comparison.md).
Its generated signatures keep the readable graded-relative names even though the
body uses their graded-chain implementation. No extra cast, equality assumption or
paper-specific native definition makes these indices agree.

Review [generated Lean](RelativeGraded.lean), [exact oracles and proofs](RelativeGradedVerified.lean),
and the [PDF](RelativeGraded.pdf). Regenerate with
`LAKE=lake python3 studies/dependent-functions/verify_relative_graded.py`.
:::
