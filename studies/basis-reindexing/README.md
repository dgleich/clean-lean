:::llm gpt-6 2026-11-07 role=assisted

# Explicit equivalences and basis reindexing

This study supplies the foundation needed to restrict an interval basis to a
subpath. It does not yet construct the equivalence between the surviving labels
active at a restricted vertex and the original labels active at its embedding.

Import `library/algebra/basis_reindexing.clean` explicitly. Its dependencies expose
an `Equivalence(I,J)` with forward and backward application and a constructor
requiring both inverse equations. The constructor accepts proof-producing
functions; neither equation is inferred or silently supplied. These interfaces
wrap Mathlib's `Equiv` and `Module.Basis.reindex`, with carriers in Type 0.

```text
Let b: ModuleBasis(K,field,M,I)
Let e: Equivalence(I,J)
Let c = reindex module basis(field,M,b,e)
```

Here `c` is a basis of the same module indexed by `J`. Its vector at `j` is the
original basis vector at `equivalence backward(e,j)`. Consequently the equivalence
passed to this operation must run from the old index type to the new one.
`Statements.clean` states that law and the two inverse laws. The fourth result
checks an identity equivalence authored with Clean functions and reflexivity
evidence, rather than an imported identity definition.

Run `LAKE=lake python3 studies/basis-reindexing/verify.py`. Ten independent
canonical comparisons check the equivalence type binding, constructor, two
applications, authored identity, reindexing wrapper and four full statements.
The comparisons retain explicit instances, wrapper calls and proof terms; they
are stronger than definitional-equality checks. All ten and the four Lean proofs
pass with the pinned dependencies. Seven Python checks cover the call tree,
index carriers, both application directions, reversed equivalences, invalid
inverse evidence, authored identity and explicit imports. No `sorry` or new axioms
are used. `Generated.lean` contains statements; `Verified.lean` adds the oracles
and proofs.

The one-page PDF was compiled twice and inspected; there were no overfull boxes
or unresolved references.

No new surface syntax or compiler implementation was needed for these modules.
The earlier codomain fix remains part of the compiler used to validate them.
The full-suite snapshot started before this study does not include its new files;
these are separate focused checks. The review browser inventory will need a refresh.
:::
