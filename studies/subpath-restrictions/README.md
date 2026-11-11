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

Current checkpoint: all nineteen exact targets and six proofs pass, including
unconditional endpoint preservation, the inclusion, and the object and arrow
formulas. Comparison now selects the requested authored field before expanding
sibling fields; generated Lean retains the original projections and wrappers.
The focused producer-field tests pass. The new comparison rule has passed the
[34-study native portfolio](../topology/validation-2026-11-07.md). Full Python
regression remains pending.

Earlier slow executions of the named and fully expanded arrow statements were
stopped after the replacement passed the independent native oracle. Those earlier
runs are superseded, not successful checks. The generated files here come from
the validated current named-arrow statement.

This study does not yet restrict interval bases, clip interval labels, remove
empty supports, reindex surviving basis vectors or prove the paper's pyramid
extension theorem. See the [design notes](design.md) for the language work that
made named endpoint evidence usable.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Current verifier migration

A later joint-inference probe exposed that the old driver had not migrated its
native expectations to the explicit binding architecture. It extracted display
expressions beginning with `_root_` for declaration lookup and expected raw Lean
arithmetic/equality in places where the specified target retains declared wrappers.
Those failures were recorded, not counted as passes.

The verifier now obtains declaration identities from `native_binding`. Its
independent expected expressions explicitly use the declared Natural, Vertex,
Boolean, field and proposition carriers; natural addition/order/numeral bindings;
generic equality; and the specialized module equality. Local Lean notation keeps
these hand-authored expressions readable and expands directly to the bindings,
without adding aliases. The generated declaration bodies are never used to build
the expected bodies. The canonical comparator still retains constants, implicit
arguments, proof terms and local lets and does not unfold definitions to hide a
mismatch. A negative guard rejects an offset alias whose meaning is definitionally
equal but whose body calls the offset declaration instead of `Fin.natAdd`.

Endpoint proofs now explicitly unfold the declared equality/arithmetic wrappers
before applying the existing finite-index extensionality and associativity proof.
The Clean statements and mathematical construction have not changed. Generated
Lean and TeX have been refreshed with the current compiler.
:::


:::llm gpt-6 2026-11-11 role=assisted

Validation of the repaired verifier passes under both ordinary and isolated joint
routing: the same nineteen exact targets, six proofs, and one rejection of a
definitionally equal alias. These are overlapping checks, not 38 distinct targets.
The regenerated one-page PDF compiled twice without overfull boxes or unresolved
references and was visually inspected without clipped or overlapping text. The
report is retained in `studies/parameterized-literals/compatibility.json` under
`subpath_verifier_repaired`. The active-label implicit-signature gap remains open.
:::
