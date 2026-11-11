:::llm gpt-6 2026-11-11 role=assisted

# Singular chains of an empty space

The [module](../../library/topology/empty_chains.clean) exposes the foundational
conditions `empty space(X)` and `zero chain complex(field,C)`. The first means
`IsEmpty X.carrier`; the second means that C is a zero object in the category of
module chain complexes. It is not an equality with a specially chosen zero complex.
The condition `empty relative part(X,Q)` is authored in Clean by applying
`empty space` to the relative subspace of Q.

The [two Clean results](EmptyChains.clean) state:

```clean
Result empty space has zero singular chains:
  Attribution: empty_chains; singularChainComplexFunctorIsoOfTotallyDisconnectedSpace; adapted
  Let K: Type
  Let field: FieldStructure(K)
  Let H: HomologyTheory(K,field)
  Let X: TopologicalSpace
  Assume empty space(X)
  Conclude: zero chain complex(field,singular chains(field,H,X))
```

The second result says that the actual relative-to-ambient singular-chain
inclusion of a topological pair is the zero chain map when its relative part is
empty. It uses the same pair-chain-inclusion definition as the existing relative
homology construction. No alternative or opaque inclusion is substituted.

## Mathematical proof

Mathlib identifies the singular chain complex of a totally disconnected space
with an alternating constant complex on the coproduct of coefficient objects
indexed by the space. An empty space is totally disconnected, and its empty
coproduct is a zero object. Componentwise chain-map extensionality shows that the
alternating constant complex is zero. Transport across Mathlib's isomorphism
then proves the singular-chain claim. Every map out of this zero object equals
the zero map, giving the relative inclusion result.

This uses the concrete singular-chain functor with H's coefficient module. H's
degree is not needed for a statement about the entire chain complex. The proof
covers degree zero as well as positive degrees; it does not rely on the weaker
vanishing of positive homology for a totally disconnected space.

## Translation and validation

[verify_empty_chains.py](verify_empty_chains.py) regenerates
[EmptyChains.lean](EmptyChains.lean) and [EmptyChainsVerified.lean](EmptyChainsVerified.lean).
Five independent canonical targets check the three conditions and two statements,
including the concrete chain complexes, inclusion, zero map and explicit field.
Lean checks both Clean-result proofs and the generic empty-chain lemma above.
No new language syntax or proof-search rule is introduced. Both foundational
conditions are explicit native imports; the relative condition is Clean-authored.

```sh
LAKE=lake python3 studies/topology/verify_empty_chains.py
```

## Remaining bridge

The inclusion-zero theorem supplies the hypothesis needed to compare the relative
chain cokernel with the [zero cokernel](zero-chain-quotients.md). That comparison
still requires transporting the cokernel along the proven equality, preserving
its projection and induced maps, and connecting the chain-homology object to the
ordinary-homology interface. The level-set data must supply the appropriate empty
relative-part certificates. These results do not yet prove that whole natural
identification, either well-group formula, or the closed-cover/excision argument.
:::


:::llm gpt-6 2026-11-11 role=assisted

Validation: five independent targets, two Clean-result proofs and the generic
supporting lemma pass. The module and two-result study produce identical
legacy/joint Lean text under matching stable fingerprints. All 92 corpus proofs
pass under joint routing. Evidence is retained under `empty_singular_chains` in
[the compatibility report](../parameterized-literals/compatibility.json).
Reference HTML links/IDs and provenance checks pass. The separate full regression,
active-label validation and browser rebuild remain live and incomplete.
:::
