:::llm gpt-6 2026-11-11 role=assisted

# Connecting homomorphisms in Clean

[HomologySequence.clean](HomologySequence.clean) states the two zero-composition
laws and three exactness laws adjacent to the connecting map of a short exact sequence of natural-indexed
chain complexes over a field. The explicit
[homology sequence module](../../library/algebra/homology_sequences.clean)
wraps the pinned Mathlib `CategoryTheory.ShortComplex.ShortExact.δ` construction.
The two composites themselves are authored with Clean `Define` blocks.

For a short exact sequence A → B → C, the map has type
δ : H(C,n+1) → H(A,n). The checked laws say that δ followed by the induced
A → B map vanishes, and the induced B → C map followed by δ vanishes.
The field structure and the proof of short exactness are explicit arguments.
`Evidence` is a transparent alias for proofs of a condition; it creates no proof.
The constructor for a short chain sequence requires evidence that its two chain
maps compose to zero. That evidence alone does not establish short exactness.

```clean
Let K: Type
Let field: FieldStructure(K)
Let S: ChainShortSequence(K,field)
Let n: Natural
Assume h: short exact chain sequence(field,S)
```

Within this context, `connecting homology map(field,S,h,n)` imports the native
construction at indices `(n+1,n)` and supplies `rfl` for the chain-shape relation.
The native equivalent, with the field instance installed, is:

```lean
CategoryTheory.ShortComplex.ShortExact.δ h (n+1) n rfl
```

The native primitive is foundational homological algebra. This study introduces
no syntax, implicit module, display-name dispatch or paper-specific Lean body.
The degree shift is fixed in the module declaration, not guessed by elaboration.

## Exactness in the authored interface

The three conclusions are:

```clean
exact(connecting homology map(field,S,h,n),
      sequence first homology map(field,S,n))
exact(sequence first homology map(field,S,n),
      sequence last homology map(field,S,n))
exact(sequence last homology map(field,S,n+1),
      connecting homology map(field,S,h,n))
```

The first and last homology maps are Clean-authored definitions of the induced
maps of `S.f` and `S.g`. `exact` is already a Clean-authored condition, expressing
that the first map's range equals the second map's kernel. The first and middle
laws apply at every natural degree, including zero; the last law concerns the
last complex at degree n+1. No degree-zero terminal surjectivity claim is added.
The proof of short exactness remains a hypothesis, not a supplied geometric proof.

For a rendered reading view, see [the one-page specimen](HomologySequence.pdf).
It was compiled twice and visually checked, with no overfull boxes or unresolved
references. Its generated fragment is [HomologySequence.tex](HomologySequence.tex).

## Validation and scope

Run:

```sh
lake build Mathlib.Algebra.Homology.HomologySequence Mathlib.Algebra.Homology.ShortComplex.ModuleCat
python3 studies/topology/verify_homology_sequence.py
pdflatex -output-directory=/tmp studies/topology/HomologySequenceSpecimen.tex
pdflatex -output-directory=/tmp studies/topology/HomologySequenceSpecimen.tex
```

The driver regenerates [HomologySequence.lean](HomologySequence.lean) and
[HomologySequenceVerified.lean](HomologySequenceVerified.lean). Eighteen
independently authored expected declarations cover the sequence type, five
selectors, constructor, short-exactness condition, connecting map, two authored
composites, two authored induced-map names and five result statements. The comparator checks canonical elaborated
types and bodies. Five proofs use Mathlib `δ_comp`, `comp_δ` and the three `homology_exact` lemmas.
The exactness proofs bridge categorical exactness to Clean’s authored
range-equals-kernel condition using `Exact.moduleCat_range_eq_ker`.
Five Python tests also check the call tree, degree orientation, evidence ownership
and rejection of a noncomposable degree choice. These are exact-target checks and kernel-checked consequences of the imported
foundation; they are not a new proof of Mathlib's snake lemma.

This is not yet the Mayer–Vietoris connecting map. The study still needs the
geometric chain sequence, its short exactness/excision argument, its identification
with the existing inclusion-induced maps, the exactness statements and the
appropriate degree-zero endpoint. Vanishing composites alone do not imply
exactness. No paper theorem is claimed proved by these checks.
:::
