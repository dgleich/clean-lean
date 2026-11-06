:::llm gpt-6 2026-11-06 role=assisted

# A translated two-image candidate, with the forward inclusion proved

The [candidate](TwoImageCandidate.clean) now uses implemented definitions throughout.
Its generated Lean is a proposition definition, not a theorem, axiom or proof hole.
The [supporting study](ExtremeImages.clean) has four proved results: membership in
a binary submodule intersection, existence of extreme certificates, independence
from their choice, and containment of the well group in the two-image intersection.

```clean
Let K: Type
Let field: FieldStructure(K)
Let p: Natural
Let H = scalar homology(K,field,p)
Let P: InterlevelProblem
Let r: Real
Assume compact space(P.space)
Assume endpoints: P.interval.lower < P.interval.upper
Assume radius: r ≥ 0
Assume nesting: nested pair(P.space,expanded pair(P,r))
Let E: ExtremePerturbations(K,field,H,P,r,nesting)
Conclude: relative well group(field,H,P,r,nesting) = extreme pair image(field,H,P,r,nesting,E)
```

This is the candidate's body; its source file includes attribution and a visible
unproved-status notice. H is constructed with the scalar field itself as its
coefficient module in degree p. This fixes the coefficient choice explicitly. The scalar module is a thin ModuleCat.of adapter; the
homology-theory constructor application is authored in Clean.

ExtremePerturbations stores certificates for f−r and f+r, represented using the
existing shifted-perturbation operation at r and −r. Its proof fields enforce those
identities. The extreme image is an authored binary intersection in the same fixed
relative-homology module as the well group. Its definition uses the generic
submodule infimum of the set containing the two subspaces.

The nesting evidence and certificate bundle are explicit. Prior proofs establish
expanded-pair nesting under the endpoint/radius hypotheses; the new existence
proof supplies the extreme bundle. Certificate independence ensures that choosing
a different valid bundle gives the same intersection. No implicit proof search or
choice operator is part of the translation.

## Source audit and unresolved mathematics

The paper states the two-image formula in Theorem 4 and derives its reverse
inclusion using Lemma 2, an intersection-of-images consequence of relative
Mayer–Vietoris exactness. Its construction uses closed interlevel decompositions.
See [the manuscript, Lemma 2 and Theorem 4](https://mrzv.org/publications/robustness-interlevelsets/manuscript/).

Our concrete model is ordinary singular homology. Applying the cited argument
requires a suitable excision/cover theorem for those actual decompositions; that
has not been established here. Compactness is retained as a hypothesis, not used
as an automatic replacement for the missing cover condition. The candidate is
therefore a model-specific statement awaiting both a mathematical audit and a
proof. Whether the current hypotheses are sufficient in this model remains unresolved.

## Syntax issue resolved by this example

`Assume compact space(P.space)` exposed a missing case in automatic hypothesis
naming. The implementation now spells projection arguments, field applications,
and nested quantifiers deterministically from their normalized source trees.
The human label is `compactness of P.space`; the Lean binder is
`«compactness_of_P_u2e_space»`. Existing collision rejection remains in force.
See the [naming contract](../../docs/conditions.md#structural-arguments-in-automatic-labels).
Compactness is an ordinary explicit Condition wrapper for CompactSpace with the
bundled topology supplied. Assuming it does not install a hidden typeclass instance.

## Review and reproduce

- [Proved helper statements](ExtremeImages.clean), [generated Lean](ExtremeImages.lean),
  and [PDF](ExtremeImages.pdf).
- [Unproved candidate](TwoImageCandidate.clean), [generated proposition](TwoImageCandidate.lean),
  and [PDF with status notice](TwoImageCandidate.pdf).
- [Native target comparisons and helper proofs](ExtremeImagesVerified.lean).

Run `LAKE=lake python3 studies/topology/verify_extreme_images.py`.
It checks eighteen canonical targets, proves four new statements, and rechecks
twenty-six supporting proofs. The candidate receives an exact proposition-target
comparison only. There is deliberately no proof of its equality in the verified
file. The broader pyramid/basis, algorithm, relative functor, exactness/excision
and research-theorem work remains unfinished.
:::
