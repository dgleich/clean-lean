:::llm gpt-6 2026-11-07 role=assisted

# Topology definitions with explicit operator modules

Status: isolated operator compiler, not production integration. This ports the
existing basic topology study onto explicit Logic and Sets declarations. It does
not assert any of the five pending research theorem targets.

The [Topology module](foundations/Topology.clean.proposed) retains the mathematical
bodies from `library/topology/basic.clean`. Its import changes from the broad types
module to the proposed Sets foundation. The Logic module now supplies the explicit
Function arrow interface and an equivalence Condition with `Infix: ↔`.
No new parser rule or operator selection policy is introduced by this migration.
The declared Function arrow interface remains structural, including its
condition-valued codomain in `Function(X,Proposition)`; the set-construction body
oracle checks the resulting `X → Prop` interface through the declared condition
type binding.

## What stays authored in Clean

Inverse image, image, map composition, continuity, selection and indexed-family
intersection remain Clean definitions. Only the topology type, openness and set
construction are new native primitives beyond the shared logic/set foundation.
For example:

```clean
Condition continuous between(f,t,u):
  Let X,Y: Type
  Let f: Function(X,Y)
  Let t: Topology(X)
  Let u: Topology(Y)
  Holds when:
    for every (S: Set(Y),
      open in(S,u) → open in(inverse image(f,S),t))
  Assumption name: continuity of {f} from {t} to {u}
  Render: {f} is continuous from {t} to {u}
```

Here implication resolves to the imported authored Condition. Membership,
conjunction, equality, intersection and equivalence similarly resolve to explicit
module declarations. Stored native references use their root-qualified bindings.
The topology values t and u remain explicit arguments; no ambient instance chooses
which topology the source means. Swapping topologies on different carriers rejects.

## Checked results

[TopologyStatements.clean.proposed](foundations/TopologyStatements.clean.proposed)
contains inverse-image intersection, image membership, continuous composition and
family-intersection membership. Each translates and has a Lean proof. Three
additional agreement proofs identify the Clean inverse image and image with Lean
set operations, and the authored continuity Condition with Mathlib Continuous.

The verifier checks thirteen independent canonical targets: the topology type,
eight primitive/authored callable bodies, and four full statements. The shared
foundation verifier separately checks the Function type and equivalence adapter.
Removing the declared membership operator prevents the authored inverse-image body
from loading; the compiler does not supply its former built-in meaning.

The first agreement-proof run exposed a missing dependency. Mathlib's
`continuous_def` theorem lives in `Mathlib.Topology.Continuous`; the older broad
foundation imports had made it available transitively. The proof harness now
imports that module explicitly. The mathematical Clean definitions continue to
import `Mathlib.Topology.Basic`.

Run the full composed driver from the repository root:

```sh
LAKE=/home/claude/.elan/bin/lake python studies/operator-integration/verify_prototype.py
```

Artifacts: [TopologyVerified.lean](TopologyVerified.lean),
[Topology.tex](Topology.tex), [PDF specimen](TopologySpecimen.pdf).
The PDF was compiled twice and inspected. These results establish migration of
this bounded foundation slice, not conformance of the full language.

## Remaining work

The topology study's bundled spaces, paths, chain complexes, ordinary/relative
homology and well-group modules still need operator/foundation migration and
renewed native oracles. The separate research obligations remain: filtered
complexes and algorithm/reduction constructions, pyramid exact diamonds and basis
extension, well-group image formulas, and Mayer–Vietoris connecting maps,
excision and exactness. The proved interval-basis restriction result is not an
open obligation. Literal interpretation, general algebraic interfaces, broader
universe support and main compiler integration remain language-level work.
:::
