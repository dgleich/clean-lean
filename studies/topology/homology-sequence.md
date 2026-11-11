:::llm gpt-6 2026-11-11 role=assisted

# Connecting homomorphisms in Clean

[HomologySequence.clean](HomologySequence.clean) states the two zero-composition
laws adjacent to the connecting map of a short exact sequence of natural-indexed
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

## Validation and scope

Run:

```sh
lake build Mathlib.Algebra.Homology.HomologySequence
python3 studies/topology/verify_homology_sequence.py
```

The driver regenerates [HomologySequence.lean](HomologySequence.lean) and
[HomologySequenceVerified.lean](HomologySequenceVerified.lean). Thirteen
independently authored expected declarations cover the sequence type, five
selectors, constructor, short-exactness condition, connecting map, two authored
composites and two result statements. The comparator checks canonical elaborated
types and bodies. Two additional proofs use Mathlib `δ_comp` and `comp_δ`.
These are exact-target checks and kernel-checked consequences of the imported
foundation; they are not a new proof of Mathlib's snake lemma.

This is not yet the Mayer–Vietoris connecting map. The study still needs the
geometric chain sequence, its short exactness/excision argument, its identification
with the existing inclusion-induced maps, the exactness statements and the
appropriate degree-zero endpoint. Vanishing composites alone do not imply
exactness. No paper theorem is claimed proved by these checks.
:::
