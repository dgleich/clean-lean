:::llm gpt-6 2026-11-10 role=assisted

# Inclusion-induced maps toward Mayer–Vietoris

The [Clean module](../../library/topology/mayer_vietoris_maps.clean) now constructs
actual singular-homology maps from subsets of a topological space. It uses the
existing pinned Mathlib singular-homology functor and the explicitly supplied
coefficient module and natural degree in `HomologyTheory`. No opaque paper-specific
map or assumption of the desired identity is introduced.

For arbitrary subsets U,V of X it defines

- α: H(U ∩ V) → H(U) ⊕ H(V), using the two inclusion-induced maps with a minus
  sign on the second component;
- β: H(U) ⊕ H(V) → H(U ∪ V), using the sum of the two inclusion-induced maps.

The [Clean statement](MayerVietorisMaps.clean) and its
[rendered version](MayerVietorisMaps.pdf) assert β ∘ α = 0. This identity needs
neither openness nor a cover of X: the target is homology of U ∪ V itself.
Exactness does need additional topology, and is not asserted here.

## Authored definitions and imports

`subset homology(field,H,X,S)` abbreviates homology of the subspace S.
`inclusion homology(field,H,X,S,T,h)` uses the actual continuous subset inclusion
with explicit containment evidence h. Both definitions are authored in Clean.

The intersection map is also authored:

```clean
Equals:
  signed pair(inclusion homology(field,H,X,U ∩ V,U,intersection into left(U,V)),
    inclusion homology(field,H,X,U ∩ V,V,intersection into right(U,V)))
```

The union map uses `merge module maps` on the two maps into the union. Four small
foundational adapters expose Mathlib's proofs of intersection/union containment.
These proof arguments determine the continuous inclusion maps; they are not
fresh assumptions added to the result. Existing wrappers supply subspaces,
continuous maps, singular homology, binary products, signs and composition.
No new syntax was needed.

## What is checked

The verifier independently specifies nine native targets: the four containment
proof definitions, four authored constructions, and the proposition β ∘ α = 0.
The targets preserve declared wrappers and explicit proof arguments. `Evidence`
is a source alias for its condition, so the independent oracle uses that condition
directly as the proof type rather than inventing an extra native type wrapper.

The proof first identifies the two continuous composites from U ∩ V to U ∪ V.
Functoriality gives equality of their induced homology maps. Linearity then
cancels the two signed terms. It proves the generated Clean statement and contains
no axiom or `sorry`. The [proof fragment](mayer-vietoris-map-proofs.lean) is included
by the verifier after the generated declarations; it is not a standalone module.

The Python tests independently specify the intersection-map body, including its
sign constructor and containment witnesses. They check both dependent map types,
that mathematical definitions are authored, and rejection of incorrect evidence
or reversed composition.

Reproduce from the repository root:

```sh
LAKE=lake python3 studies/topology/verify_mayer_vietoris_maps.py
PYTHONPATH=tests:. python3 -m unittest test_mayer_vietoris_maps test_module_products test_exact_sequences -v
```

Validation on 2026-11-10: nine exact targets and the composition-to-zero proof
passed. The focused Python batch passed 26 tests in 3.492 seconds. The new study's
native check emitted only the existing unused-variable warning. The existing
92-proof corpus passed Lean checking. The PDF compiled twice and was visually
inspected as one landscape page; only the existing LaTeX package-name warning
remained. Earlier full-suite runs predate this new module and do not validate it.

## Remaining construction

We still need the degree-lowering connecting map, the hypotheses supporting
excision, and the proof that the appropriate image equals the kernel. We also
need to assemble those maps over all degrees into the intended long exact
sequence, including its endpoint. The existing generic sequence condition alone
does not do this. An identification U ∪ V = X must be supplied and transported
explicitly when presenting the theorem with H(X) as its target.
:::
