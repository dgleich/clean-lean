:::llm gpt-6 2026-11-06 role=assisted

# A well group defined in Clean

The [module](../../library/topology/well_groups.clean) defines the relative well
group as the intersection of the images of all certified bounded perturbations.
It uses ordinary relative singular homology with an explicit coefficient module
and degree in H. The problem P bundles the space, continuous real map, interval,
and endpoint selection. This is the intersection definition, not the paper's
Theorem 4 identifying it with the intersection of two extreme images.

```clean
Define relative well group(field,H,P,r,nesting):
  Let K: Type
  Let field: FieldStructure(K)
  Let H: HomologyTheory(K,field)
  Let P: InterlevelProblem
  Let r: Real
  Let nesting: Evidence((nested pair(P.space,expanded pair(P,r))))
  Returns: ModuleSubspace(K,field,(relative homology(field,H,P.space,perturbation target(P,r,nesting))))
  Equals:
    intersection of module family(field,relative homology(field,H,P.space,perturbation target(P,r,nesting)),
      function(C: CertifiedPerturbation(K,field,H,P,r,nesting),perturbation homology image(field,H,P,r,nesting,C)))
```

Every image lives in exactly the same target module, the homology of the expanded
pair. The target depends on P, r and its fixed nesting evidence; it does not depend
on the perturbation certificate. The comparison machinery identifies authored
pair-constructor expansions while preserving named objects in generated signatures.

A PerturbationCertificate stores a continuous map, its boundedness proof, and
proofs that its pair is nested and included in the expanded pair. A
CertifiedPerturbation adds the commuting chain-square proof needed for the induced
relative homology map. These are proof-bearing records, not arbitrary data that
assert the desired well-group theorem. Their constructors are generated from Clean
Structure declarations. The homology images and intersection are authored Equals
bodies. Only the generic submodule infimum operation is a new native adapter.

The Lean proofs check:

- Membership in a module-family intersection means membership in every member.
  This also specifies the empty-family case: every element belongs.
- For ordered endpoints and nonnegative radius, every bounded continuous
  perturbation has a certificate (with a fixed expanded-pair nesting proof).
- Every certificate supplies a bounded perturbation.
- Certificates with the same continuous map give the same homology image.
- Membership in the well group means membership in every perturbation image.

Completeness prevents the explicit evidence requirements from silently shrinking
the family under the stated hypotheses. Certificate independence uses Lean's proof
irrelevance; it does not assume images are equal. Expanded-pair nesting is proved
in the supporting interlevel study, but remains an explicit argument in Clean.
The definition is total even outside the completeness theorem's hypotheses; no
unconditional assertion that its certificate family is nonempty is made.

The construction exposed a translator bug: a field type using a projected header
parameter, such as ContinuousRealMap(P.space), did not substitute P when accessing
a record instantiated at Q. The fix uses the existing structural index-substitution
rule. There is no grammar change or additional inference policy.

Review [statements](WellGroups.clean), [generated Lean](WellGroups.lean),
[proofs and independent native oracles](WellGroupsVerified.lean), and
[typeset statements](WellGroups.pdf). Regenerate with
`LAKE=lake python3 studies/topology/verify_well_groups.py`.
The verifier compares 24 canonical targets, checks five new proofs, and rechecks
15 supporting proofs. Canonical comparisons retain proof arguments, instances,
universes and named wrappers.

Relative functor laws, connecting maps, exactness, excision, and the paper's
extreme-image characterization remain unfinished. Clean still has no proof language
for constructing these evidence values internally; the accompanying proofs are in
Lean. This milestone removes the missing intersection definition, not those proof
or mathematical gaps.
:::
