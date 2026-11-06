:::llm gpt-6 2026-11-06 role=assisted

# Authored interlevel problem data

[`Interlevel.clean`](Interlevel.clean) now contains seven proved preparatory
results, backed by [`interlevel.clean`](../../library/topology/interlevel.clean).
The [PDF](Interlevel.pdf) includes a notation legend. These definitions are
executable Clean declarations with generated Lean targets, not proposed names.

```clean
Let P: InterlevelProblem
Let h: ContinuousRealMap(P.space)
Let r: Real
Assume radius: r ≥ 0
Assume bounded perturbation(P,h,r)
Conclude: pair included in(P.space,perturbed pair(P,h),expanded pair(P,r))
```

The data follows the setup preceding Theorem 4 of
[Homology and Robustness of Level and Interlevel Sets, p. 17](https://mrzv.org/publications/robustness-interlevelsets/manuscript/).
The endpoint selection specifies the relative boundary. For endpoints a,b, its
four choices select neither endpoint, a, b, or both. The expanded ambient set is
the preimage of [a-r,b+r]; its relative subset is the preimage of the radius-r
bands about the selected endpoints. Shifted pairs use translated intervals and
selected endpoints. Perturbed pairs use a continuous h in place of f. The
pointwise bound is expressed by -r ≤ h(x)-f(x) ≤ r.

## What is authored and what is imported

`EndpointSelection` is an authored record with two Boolean fields. The four named
choices are authored constructor calls. Exhaustiveness is proved by the two finite
Boolean cases. The reusable Boolean type and its two constants live in
`library/logic/booleans.clean`; the older Common module imports that definition
rather than duplicating it. Its existing forward/backward names remain available.

`InterlevelProblem` is an authored Type-1 record containing an ambient TopCat
space, a continuous real-valued map on that space, real endpoints, and the endpoint
selection. The native ContinuousRealMap type explicitly fixes the standard real
topology to `Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace`. The only
new topology adapter is its underlying function projection. A generic module
operation, `evaluate map` in `library/logic/functions.clean`, applies ordinary functions; real-map evaluation is
then authored in Clean through that operation.

Closed intervals, selected endpoints, expanded intervals/bands, both components
of shifted/expanded/perturbed pairs, boundedness, nestedness and componentwise
pair inclusion are authored with existing constructors, conditions, set builders,
functions, inverse images and field references. There is no native interlevel
formula hidden behind a paper-specific Lean name. No new grammar was necessary.

`SpacePairData(X)` contains two subsets of the same carrier. It does **not** contain
or assert an inclusion proof. `nested pair(X,Q)` states that separate condition.
The inclusion results prove nestedness under an explicit ordering assumption.
The data is total even for unordered endpoints or negative r; the results state
the hypotheses they need. Endpoint-inclusion lemmas allow a=b; this does not
silently weaken the paper's strict-endpoint hypothesis in its research theorem.
Two distinct Boolean selections can denote the same subset when a=b.

Space indices still match structurally. Naming a constructed problem P does not
automatically identify P.space with the X used to construct it. The specimen
therefore declares perturbations directly on P.space. General local-alias
conversion and equality transport remain separate language work.

## Evidence and remaining work

`verify_interlevel.py` compares 58 independent canonical native declarations,
including all new imported types, record constructors/projections, authored
formulas, the explicit real topology, and all ten statement types. It proves:

- Exhaustiveness of the four endpoint choices.
- Inclusion of selected endpoints in an ordered interval.
- Nestedness of expanded, shifted and perturbed pairs.
- Inclusion of a bounded shift into the expanded pair, in both components.
- Inclusion of a bounded perturbation into the expanded pair, in both components.
- Existence of a certified expanded pair and certified inclusions for bounded shifts
  and perturbations, retaining all four component sets exactly.

The shift-inclusion result uses every t in [-r,r], not just the extreme shifts.
The perturbation condition quantifies over every point of the ambient space;
it is not defined by testing two distinguished maps. The bounds also make sense
on an empty space. No compactness or excision principle is used in these elementary
set-inclusion proofs. Continuity is retained in the input type for subsequent
homology constructions, though these particular inequalities do not use it.

Certified pair inclusions now exist under these hypotheses. Their data supplies
the continuous component maps from `pairs.clean`; the previously checked commuting
square applies to every such inclusion. A category of pairs, relative chain/homology
constructions, and the intersection defining the well group remain unfinished. The paper's
Theorem 4 is still unproved, as are the other four research targets. No claim about
the two-image characterization or closed-cover excision follows from these lemmas.

Regenerate with `LAKE=lake python3 studies/topology/verify_interlevel.py`.
Compile `studies/topology/latex_interlevel.tex` twice for the PDF. All shared files
carry provenance markers; the mathematical sources retain their own attributions.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Certification bridge and an exposed language gap

`certified_interlevel.clean` authors `certify pair data(X,Q,h)` entirely in Clean.
The proof parameter must be evidence for the actual nesting condition on Q.
The authored condition `has pair data(X,Q,S)` means equality of both component
sets; its rendering “Q represents S” keeps the quantified statements readable.
The existential study results require only ordered endpoints, nonnegative radius,
and the stated shift or perturbation bound. Their Lean proofs construct the
certificates from the seven inclusion lemmas; they do not assume the certificate
or use an axiom. Both source components and both target components are retained.

A desired further authored definition is:

```clean
-- Proposed composition; currently rejected, not an implemented declaration.
Equals: pair inclusion(X,certify pair data(X,S,s),certify pair data(X,T,t),a,b)
```

This needs field projection on computed records and a specified reduction rule:
the first inclusion proof is checked against the ambient fields of the two
computed certificates. Current substitution rejects the projected computations.
Simply accepting the syntax would still leave structural matching unable to
identify those fields with S.ambient and T.ambient. A future extension must specify
which constructor/definition reductions are allowed, their scope and termination,
and canonical Lean targets. No silent fallback to Lean definitional equality has
been added. The verified existential bridge is usable now; that authored direct
composition remains an explicit language gap.
:::
