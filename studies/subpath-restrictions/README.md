:::llm gpt-6 2026-11-07 role=assisted

# Restricting a finite zigzag to a subpath

[Statements.clean](Statements.clean) imports the explicit
[subpath module](../../library/diagrams/subpaths.clean). A path with n edges has
vertices Fin(n+1); its subpath starts at a and has m edges, with a+m ≤ n. The
edge and vertex embeddings add a to their indices. The orientation of each
subpath edge is inherited from its image in the parent path.

The construction supports m=0 and the final singleton vertex a=n. It does not
require every edge to point in the same direction. The endpoint-preservation
proofs cover both orientations and all lengths satisfying the bound.

All mathematical constructions are authored with Clean Equals bodies. The five
native adapters are Fin.natAdd, Fin.castLE, Fin.cast, Nat.add_assoc and
Nat.add_le_add_right. The vertex embedding explicitly transports its finite bound
along associativity before widening it. Named endpoint conditions can be passed
directly as constructor evidence; duplicate proof-family aliases are unnecessary.

The [arrow module](../../library/diagrams/pullback_arrows.clean) defines the
transported parent arrow in Clean. It composes source transport, the parent arrow
and inverse target transport. The theorem can refer to this definition by name:

```clean
Conclude: restricted zigzag(field,n,a,m,h,d,hs,ht,Z).arrow(e) =
  pull back arrow(field,Q,R,i,Z,e)
```

Q and R are the subpath and parent shapes, and i is their inclusion. The statement
retains the endpoint transports through the explicit arrow definition.

Run `LAKE=lake python3 studies/subpath-restrictions/verify.py` from the repository.
The verifier generates Lean definitions/statements, independently authored native
targets, proofs and TeX. Its current target is nineteen exact comparisons and six
proofs. Exact comparisons retain constants, implicit arguments and proof terms;
they do not merely ask for definitional equality.

Current checkpoint: the version before the arrow extension passed seventeen
exact targets and five proofs, including unconditional endpoint preservation,
existence of the inclusion and the object formula. The current library passes
six structural/negative tests. The expanded arrow verifier is still running, so
the nineteen-target result is pending. Generated artifacts will be committed
when that run finishes; the source snapshot records this intermediate step.

The earlier fully expanded arrow statement is also still being evaluated in an
isolated snapshot. Its elapsed runtime is not evidence of success or failure.
The readable named-arrow statement is a separate source specimen with its own
independent native oracle.

This study does not yet restrict interval bases, clip interval labels, remove
empty supports, reindex surviving basis vectors or prove the paper's pyramid
extension theorem. See the [design notes](design.md) for the language work that
made named endpoint evidence usable.
:::
