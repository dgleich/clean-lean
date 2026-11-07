:::llm gpt-6 2026-11-07 role=assisted

# Restricting interval vectors

[The module](../../library/diagrams/interval_restriction.clean) defines restricted
vectors in Clean. At a restricted vertex `v` and a surviving label `j`, it takes
the original vector at the embedded vertex `a+v` and the underlying label of `j`.
Its dependent return type is the carrier of the **restricted diagram's** module
at `v`. The existing authored-projection conversion checks that this is the same
module as the original diagram's module at `a+v`. No new cast, native mathematical
body, or language syntax is introduced.

[Statements.clean](Statements.clean) states the evaluation formula and preservation
of vanishing outside the clipped intervals. Source and target preservation for the
subpath are explicit evidence parameters, as in the existing
[subpath construction](../subpath-restrictions/README.md).

Run from the repository root:

```sh
LAKE=lake python3 studies/interval-vector-restriction/verify.py
```

[Generated.lean](Generated.lean) is the translated statement file.
[Verified.lean](Verified.lean) adds independently written expected targets for the
vector definition and both statements, then proves both generated statements.
All three exact comparisons and both proofs pass. The value formula is definitional;
vanishing follows from the original support condition and the arithmetic of clipped
endpoints. No axiom or `sorry` is added, and no restricted support condition is
assumed.

The [PDF](Statements.pdf) renders both statements. The vanishing condition now
names the vector family and interval family, so the original hypothesis and
restricted conclusion are visibly different. This changes presentation only;
its Clean definition and Lean target are unchanged.

Combined with the [pointwise basis construction](../interval-basis-restriction/README.md),
this supplies the vectors and their support for an interval-basis restriction.
Assembly of the vertexwise bases and proof of edge compatibility remain unfinished.
Neither this study nor the pointwise result proves the paper's pyramid theorem.
:::
