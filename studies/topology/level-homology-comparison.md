:::llm gpt-6 2026-11-11 role=assisted

# Level-pair homology: assembling the certificates and maps

[The three Clean statements](LevelHomologyComparison.clean) assert an ordinary
homology comparison for expanded, perturbed and shifted level pairs. Their
premises are the space, coefficient/degree choice, continuous functions and real
parameters. They do not assume nesting, emptiness or a zero chain inclusion.

Each conclusion first asserts that a nesting proof exists, then asserts that a
map exists from the certified pair's relative homology to ordinary homology of
its ambient subspace. That map is inverse to the already defined canonical
ordinary-to-relative map. The supplied witnesses are constructed in the Lean
proof, not by the Clean translator.

## Dependent evidence in a readable statement

The expanded-pair conclusion uses the existing syntax:

```clean
Let S = expanded pair(level problem(X,f,a),r)
Conclude:
  there exists (nesting: Evidence((nested pair(X,S))),
    there exists (alpha: ModuleMap(K,field,(relative homology(field,H,X,certify pair data(X,S,nesting))),(homology module(field,H,subspace(X,S.ambient)))),
      inverse module maps(field,relative homology(field,H,X,certify pair data(X,S,nesting)),
        homology module(field,H,subspace(X,S.ambient)),alpha,
        ordinary to relative homology(field,H,X,certify pair data(X,S,nesting)))))
```

This is an excerpt; the complete file declares all parameters and attribution.
`nesting` is a proof binder, and `alpha` has a type depending on it through the
certified pair. Lean receives a local `let S`, followed by two nested `Exists`
expressions with these dependencies retained. There is no placeholder pair,
implicit proof search, or post-translation replacement of evidence.

The [inverse-map condition](../../library/algebra/inverse_module_maps.clean)
is authored in Clean as the conjunction of the two composition identities.
It names a common mathematical conclusion without adding native adapters or
new grammar. The existential statement guarantees comparison with the canonical
reverse map; it does not merely assert an unspecified module isomorphism.

## Proof assembly

The generic helper in [the verifier](verify_level_homology_comparison.py) starts
with an empty relative subspace. It constructs nesting by elimination of any
relative point, certifies the pair, proves its relative singular chains are a
zero object, and derives that the actual chain inclusion is zero. It then takes
the Clean-authored relative-to-ordinary map with that equality proof as its
witness and proves both inverse identities through the homology functor.

The three application proofs establish emptiness for their concrete level pair.
They do not rely on an assumed or axiomatized comparison. They work for all real
parameters: no radius sign is needed merely for emptiness of the unselected
relative endpoint set. This is not a claim about well-group theorems at negative
radii.

Four independent canonical targets cover the inverse condition and three
statements. Three application proofs and four generic helpers are kernel checked.
The canonical comparator checks types and bodies, including the nesting proof's
occurrences in the later existential type and conclusion.

```sh
LAKE=lake python3 studies/topology/verify_level_homology_comparison.py
```

Outputs: [statements](LevelHomologyComparison.lean),
[canonical targets and proofs](LevelHomologyComparisonVerified.lean).

## What remains

The comparison target here is the ordinary homology of each constructed ambient
subspace. Identifying it with separately named fiber/band spaces and tracking
images under those identifications remain further application work. The generic
pair-inclusion comparison is already natural, but the study still needs a
level-specific diagram using its actual perturbation inclusions. No two-image
well-group formula or closed-cover/excision theorem is proved here.
:::

:::llm gpt-6 2026-11-11 role=assisted

Validation completed: four exact targets, three level applications and four
generic helper proofs pass. Legacy and joint elaboration produce identical
Lean text for the condition module and three-result study under matching stable
fingerprints. All 92 corpus proofs pass under joint routing. Evidence is retained
under `assembled_level_homology_comparison` in
[the compatibility report](../parameterized-literals/compatibility.json).
Reference HTML IDs/links and provenance checks pass. Full regression, active-label
validation and the browser rebuild remain live and are not counted as complete.
:::
