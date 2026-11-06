:::llm gpt-6 2026-11-06 role=assisted

# Actual shifted perturbations and their images

The [real-map module](../../library/topology/real_maps.clean) wraps Mathlib's
constant continuous real maps and pointwise addition. Translation by a constant
is authored in Clean. The
[shifted-perturbation module](../../library/topology/shifted_perturbations.clean)
then defines the perturbation associated with a translated interval:

```clean
Define shifted perturbation(P,t):
  Let P: InterlevelProblem
  Let t: Real
  Returns: ContinuousRealMap(P.space)
  Equals: translate real map(P.space,P.map,-t)
```

The minus sign is intentional. The preimage of [a,b] under f−t equals the preimage
of [a+t,b+t] under f. The same statement holds for every endpoint selection,
including neither or both endpoints. The pair-equality theorem proves both set
components, rather than only comparing their names or the ambient interval.

A shift t with −r ≤ t ≤ r gives a perturbation bounded by r. For ordered interval
endpoints and r ≥ 0, it therefore has a CertifiedPerturbation in the fixed expanded
target pair. The certificate-existence proof reuses the checked completeness
result for all bounded perturbations; it does not assume the well-group theorem.

The image interface is now implemented:

```clean
shifted pair image(field,H,P,r,nesting,t,C,represents)
```

C is a CertifiedPerturbation with the fixed target indexed by P, r and nesting.
The explicit proof represents states that C.data.map is shifted perturbation(P,t).
The result is the existing perturbation homology image of C. Its type is exactly
the same ambient ModuleSubspace as relative well group(field,H,P,r,nesting).
The proof parameter is intentionally unused in the underlying range computation:
it identifies the shift represented by the certificate. Native Lean may report
that unused argument as a linter warning. It remains in the precise interface.

The independence theorem proves that two certificates representing the same shift
give equal images. The LaTeX image notation displays C explicitly so that this
equality does not look like a tautology. No arbitrary choice operator, paper-specific Lean definition,
or hidden proof search is introduced. A future proof-elaboration interface could
remove certificate plumbing from authored statements; that convenience is not
implemented here. Simply dropping represents would incorrectly allow an image
of an unrelated perturbation to be labelled as the shift t.

The [six statements](ShiftedPerturbations.clean) cover the pointwise value,
uniform bound, pair equality, certificate existence, certificate independence,
and membership of every well-group element in every certified shifted image.
Taking t=r and t=−r gives containment in both extreme images. This is one direction
of the proposed characterization; it does not prove the reverse inclusion or
resolve the closed-cover/excision issue for the paper's homology model.

Review [generated Lean](ShiftedPerturbations.lean),
[proofs and canonical targets](ShiftedPerturbationsVerified.lean), and
[typeset statements](ShiftedPerturbations.pdf). Regenerate with
`LAKE=lake python3 studies/topology/verify_shifted_perturbations.py`.
The verifier checks eleven independent canonical targets, six new proofs, and
rechecks twenty supporting proofs. It uses the pinned Lean/Mathlib versions;
Mathlib.Topology.ContinuousMap.Algebra was compiled locally without upgrading them.

The proposed paper statements remain in Targets.clean.proposed until their
hypotheses and homology framework are justified. Shifted image is no longer an
undefined mathematical operation, but a theorem using it still needs the explicit
certificate arguments above. No proof of any of the five research targets is claimed.
:::
