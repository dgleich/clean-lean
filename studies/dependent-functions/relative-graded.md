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

:::llm gpt-6 2026-11-06 role=assisted

## Native validation checkpoint

The ten exact targets and five new proofs pass. An initial oracle used inferred
arrow notation for chain maps; canonical comparison rejected its differing type
structure even though the proofs compiled. The independent oracle now specifies
Quiver.Hom and its category instance explicitly, matching the declared interface.
No weakening to definitional equality was used for these comparisons.

The existing 92-proof corpus, four induced-homology targets/three proofs, fourteen
closed-universe targets/four sort checks/three proofs, ten proof-family targets/five
sort checks/five proofs, and eight relative-map targets/three proofs also pass.
The strict generated-parser check and the new independent syntax-tree comparison
pass. The focused conversion run passes 59 tests, including the additional
quantifier-kind case. The PDF compiles twice without overfull boxes and has been
visually inspected; reference search, local links and mobile width checks pass.
The regenerated browser contains 92 files and zero translation errors; search,
declaration navigation, imports, notes/export, responsive layout and no-JavaScript
fallback checks pass.
:::

:::llm gpt-6 2026-11-06 role=assisted

The full regression suite passed all 513 tests in 994 seconds. The additional
quantifier-kind test, added after that run began, is included in the 59 passing
focused tests above. No implementation changes followed those checks. A separate
negative probe confirms the saved-scope freshness limitation documented in the
[comparison contract](../../docs/family-index-comparison.md#confirmed-remaining-scope-boundary);
this milestone does not claim scope-independent alpha keys.
:::
