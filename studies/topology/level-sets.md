:::llm gpt-6 2026-11-11 role=assisted

# Level sets as interlevel data

The [level-set module](../../library/topology/level_sets.clean) supplies three
Clean-authored definitions: `level problem(X,f,a)`, `level fiber(X,f,a)`, and
`level band(X,f,a,r)`. The [study](LevelSets.clean) checks the set-level
specialization needed for the level well-group setup. No new syntax or native
mathematical adapter is introduced.

```clean
Define level problem(X,f,a):
  Let X: TopologicalSpace
  Let f: ContinuousRealMap(X)
  Let a: Real
  Returns: InterlevelProblem
  Equals: interlevel problem(X,f,endpoints(a,a),no endpoints())
```

`Endpoints` stores endpoints without imposing a strict inequality. Thus the
closed interval with endpoints a,a is the singleton {a}, and selecting no
endpoints gives an empty relative subset. This is a valid specialization of the
data; it does not satisfy the separate strict-endpoint assumption of the current
interlevel two-image candidate. That candidate cannot simply be instantiated to
prove the level-set formula.

The five proved identities establish:

- For any continuous perturbing map g, the ambient set of its perturbed pair is
  the fiber of g at a.
- The expanded ambient set is the inverse image under f of [a-r,a+r].
- The expanded pair has no relative points.
- A shift by t gives the fiber of f at a+t.
- Every perturbing pair has no relative points.

The set identities hold for every real r or t. The mathematical perturbation
radius must separately be nonnegative when constructing bounded perturbations;
this file does not silently add or discard that requirement.

## Lean mapping and acceptance

`level problem` emits the declared interlevel constructor applied to X, f, the
declared endpoint constructor at a,a, and the declared no-endpoints value.
The fiber and band definitions use the declared set-builder, evaluation, equality,
order, arithmetic and conjunction bindings. There is no special level-set parser
rule or privileged mathematical name.

[verify_level_sets.py](verify_level_sets.py) generates
[LevelSets.lean](LevelSets.lean) and [LevelSetsVerified.lean](LevelSetsVerified.lean).
Independent templates check three definition targets and five statement targets.
Statement templates apply the existing constructor-field reduction rule explicitly:
projecting an authored pair constructor selects its preimage field. They do not
use definitional equality to relax canonical target comparison. Five Lean proofs
then establish the mathematical set identities using order antisymmetry,
reflexivity and Boolean simplification.

```sh
LAKE=lake python3 studies/topology/verify_level_sets.py
```

## Remaining well-group obligations

This supplies the level-set input data, not the paper's Theorem 3. The relative
homology objects of pairs with empty relative subsets must still be identified
with the ordinary homology objects through compatible maps. The intended class
of perturbations and the closed-cover/excision hypotheses must be audited before
asserting the two-extreme-perturbation equality in the chosen singular-homology
model. No proof of that equality, or equality between arbitrary callbacks and the
paper's homology theory, is claimed here.
:::


:::llm gpt-6 2026-11-11 role=assisted

Validation: eight canonical targets and five proofs pass. Both the declaration
module and five-result study produce identical legacy/joint Lean text with stable,
matching source fingerprints, including a final check after provenance comments
were added. The 92 corpus proofs pass under joint routing. Evidence is retained
under `level_set_specialization` in
[the compatibility report](../parameterized-literals/compatibility.json).
Reference links and provenance checks pass. The separate full regression and
active-label validation jobs are still running; this module does not close those
compiler acceptance obligations.
:::
