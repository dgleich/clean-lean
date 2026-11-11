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
It checks five definition targets and four statement targets against independent
templates, then proves the four inverse laws. The homology proofs use the actual
homology functor's map of the cokernel isomorphism.

```sh
LAKE=lake python3 studies/topology/verify_zero_chain_quotients.py
```

## Relationship to level sets

The [level-set study](level-sets.md) shows that the relative subsets are empty.
The remaining topology bridge must prove the corresponding singular-chain
inclusion is zero, transport the cokernel construction along that equality, and
relate the chain-homology model to the ordinary homology interface through
compatible maps. Empty relative subsets alone do not supply those identifications.
Naturality with respect to the inclusion maps used by well groups also needs to
be checked. Neither the level well-group formula nor the interlevel formula is
proved by these algebraic inverse laws.
:::


:::llm gpt-6 2026-11-11 role=assisted

Validation: nine exact targets and four inverse laws pass. The module and
four-result study produce identical legacy/joint Lean text under matching stable
source fingerprints. The 92 corpus proofs also pass under joint routing.
Evidence is retained under `zero_chain_quotients` in
[the compatibility report](../parameterized-literals/compatibility.json).
Reference HTML links/IDs and provenance checks pass. The live compiler-regression
and active-label snapshots are separate, incomplete validation evidence.
:::
