:::llm gpt-6 2026-11-11 role=assisted

# Zero chain quotients and homology

The [module](../../library/algebra/zero_chain_quotients.clean) defines the cokernel
Q of the zero chain map C → D, its projection π: D → Q, and a reduction ρ: Q → D.
The [study](ZeroChainQuotients.clean) proves ρπ = identity and πρ = identity,
and the corresponding two identities after applying homology in degree p.
These are isomorphism laws, not assertions that the two chain complexes are equal.

```clean
Define zero quotient homology forward(field,C,D,p):
  Let K: Type
  Let field: FieldStructure(K)
  Let C,D: ModuleChainComplex(K,field)
  Let p: Natural
  Returns: ModuleMap(K,field,
    (chain homology(field,zero chain quotient(field,C,D),p)),
    (chain homology(field,D,p)))
  Equals: induced chain homology map(field,
    zero chain quotient(field,C,D),D,zero quotient reduction(field,C,D),p)
```

The quotient, projection and both homology maps are Clean-authored compositions
of existing foundations. The only new native operation is the reduction map,
which imports `CategoryTheory.Limits.cokernelZeroIsoTarget.hom` from pinned
Mathlib. The explicit field instance and category of chain complexes of modules
are fixed by the declared parameters. No new parser syntax, implicit registry,
axiom or arbitrary map replaces the standard construction.

## Exact Lean mapping

The quotient emits the declared cokernel adapter at the declared zero chain map.
The projection emits the declared cokernel projection. The reduction emits the
hom component of Mathlib's zero-cokernel isomorphism. Each homology map emits the
existing induced-chain-homology-map adapter at the appropriate chain direction.
The statement targets retain their local names Q, M and N as Lean lets; the
independent expected terms preserve those lets, parameter order, wrappers and
composition order.

[verify_zero_chain_quotients.py](verify_zero_chain_quotients.py) regenerates
[ZeroChainQuotients.lean](ZeroChainQuotients.lean) and
[ZeroChainQuotientsVerified.lean](ZeroChainQuotientsVerified.lean).
It checks seven definition targets and nine statement targets against independent
templates, then proves four inverse laws, four naturality laws, and agreement
with the standard cokernel map. The homology proofs use the actual homology
functor, its map of the cokernel isomorphism, and its composition law.

```sh
LAKE=lake python3 studies/topology/verify_zero_chain_quotients.py
```

## Relationship to level sets

The [level-set study](level-sets.md) shows that the relative subsets are empty.
The remaining topology bridge must prove the corresponding singular-chain
inclusion is zero, transport the cokernel construction along that equality, and
relate the chain-homology model to the ordinary homology interface through
compatible maps. Empty relative subsets alone do not supply those identifications.
The zero-quotient comparison now commutes with arbitrary chain maps and their
induced homology maps. Applying that result to the actual topological inclusions
still requires the compatible empty-subspace and equality-transport bridge.
Neither the level well-group formula nor the interlevel formula is
proved by these algebraic inverse laws.
:::


:::llm gpt-6 2026-11-11 role=assisted

Earlier validation of the inverse-law slice: nine exact targets and four proofs
passed. Its module and four-result study produced identical legacy/joint Lean text under matching stable
source fingerprints. The 92 corpus proofs also pass under joint routing.
Evidence is retained under `zero_chain_quotients` in
[the compatibility report](../parameterized-literals/compatibility.json).
Reference HTML links/IDs and provenance checks pass. The live compiler-regression
and active-label snapshots are separate, incomplete validation evidence.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Compatibility with chain maps

For v: D → F and zero quotients Q(C,D), Q(E,F), the authored map is
π₂ ∘ v ∘ ρ₁. It needs no source-side map C → E and no supplied commuting-square
proof. The induced homology map is authored by applying the existing homology
map operation to this composite.

The new results prove that the projections and reductions commute with these maps,
and that both homology comparison directions commute with the induced maps.
A final result supplies u: C → E and a named square assumption and proves agreement
with Mathlib's standard cokernel map. That proof argument remains explicit in the
canonical Lean target; the definition does not choose or synthesize it.

Thus the added mathematical definitions need no new native adapter or parser rule.
The exact targets retain the declared composition operations, their order, all
complex/module indices and the local lets used to shorten the statements.
:::


:::llm gpt-6 2026-11-11 role=assisted

Expanded validation passes: sixteen canonical targets, nine proofs, identical
legacy/joint generated text for the module and nine-result study under matching
stable fingerprints, and all 92 corpus proofs. The emitted quotient map retains
its specified composite; agreement with `cokernel.map` is proved separately.
The evidence is recorded under `zero_chain_quotient_naturality` in the compatibility
report. The full compiler and active-label validations remain separate live jobs.
:::
