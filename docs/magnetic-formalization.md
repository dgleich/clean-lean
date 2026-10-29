:::llm gpt-6 2026-10-29 role=assisted

# Magnetic matrices: formalization and a source boundary case

The forward walk-profile/Fourier identity now has a Lean proof for every finite
real square matrix, every natural walk length, and every real potential. The
[Clean statements](../examples/magnetic.clean) translate to propositions that are
actually proved in [VerifiedMagnetic.lean](../generated/VerifiedMagnetic.lean).
They are not merely checked for well-formedness.

Start with the [Clean definitions](../library/magnetic.clean), then the
[Lean proof](../CleanPapers/Magnetic.lean). The original magnetic statement in the
three-paper gallery is also proved in
[VerifiedMagneticOriginal.lean](../generated/VerifiedMagneticOriginal.lean).
Its positive-dimension hypothesis is unnecessary; the new statement allows n = 0.

The source is Huang, Gleich, and Li,
[*Powers of Magnetic Graph Matrix: Fourier Spectrum, Walk Compression, and Applications*,
arXiv:2506.07343v1](https://arxiv.org/html/2506.07343v1),
equation (1), Supplement S.II equation (17), and the forward part of Theorem 1.
This is a first formalized portion of that paper, not a formalization of every result.

## Definitions and conventions

Write `phase(q) = exp(2πiq)`. For a real matrix A, the magnetic adjacency is
`M(A,q) = phase(q) A + phase(-q) Aᵀ`, after embedding its entries into the complex
numbers. Matrices have labelled vertices `Fin n`. Signed weights, diagonal entries,
and dimension zero are permitted for the algebraic identities and Hermitian results.

A Boolean word selects A or Aᵀ at each position. Its product preserves the written
order. The walk profile Φ(A,m,k) is the sum of products of all length-m words with
exactly k forward choices. The empty product is the identity, and an empty sum is
zero. Matrix multiplication itself sums over intermediate vertices. This implements
the ordered-products definition of the profile; it is not a commutative binomial
coefficient times a single product.

The proved identity is

\[
M(A,q)^m = e^{-2\pi iqm}\sum_{k=0}^{m}e^{4\pi iqk}\,\Phi(A,m,k).
\]

The unnormalized Laplacian added here is `L(A,q) = D(A) - M(A,q)`, where
`D(A)[i,i] = sum_j (A[i,j] + A[j,i])`. Self loops contribute twice to this degree.
This is an explicitly chosen supporting convention. The paper also discusses
normalized matrices; no normalization or isolated-vertex convention is silently
substituted here. Positive semidefiniteness, normalized Laplacian spectral results,
and frustration bounds are not proved in this first portion.

## What is proved

| Clean result | Lean evidence |
| --- | --- |
| Magnetic powers encode walk profiles | `magnetic_power_fourier`, all m, n, q, A |
| Magnetic adjacency is Hermitian | `magneticMatrix_hermitian` |
| Magnetic Laplacian is Hermitian | `magneticLaplacian_hermitian` for the D − M convention above |
| Zero potential symmetrizes adjacency | `magneticMatrix_zero` |
| Two-step mixed walk profile | `walkProfile_two_one`: A Aᵀ + Aᵀ A |
| Odd-length inverse endpoint counterexample | `inverse_v1_length_one_fails`, described below |

The proof first expands into ordered words, proves the scalar phase of each word,
then regroups the finite list by forward count, preserving multiplicity. It factors
out the common phase to obtain the Fourier expression. No numerical sampling,
added paper axiom, `sorry`, or `native_decide` is used. The main proof's reported
axioms are Lean/Mathlib's standard `propext`, `Classical.choice`, and `Quot.sound`.

The generated verification file also proves that Clean's authored phase,
adjacency, and Laplacian agree with the independently written Lean definitions.
It then proves each actual generated proposition. The generator checks two
independently written expression trees. These are useful checks for this example;
they do not close the language-wide canonical-target acceptance obligations.

## An inverse-formula issue in the pinned v1

Equation (24) of v1 displays a reduced inverse formula. At m = 1 its sum from 1
to floor(m/2) is empty, and the remaining sample is q₀ = 0. For k = 1 it would
therefore reconstruct A as `(A + Aᵀ)/2`.

Take the directed single edge

\[
A=\begin{pmatrix}0&1\\0&0\end{pmatrix}.
\]

Its profile Φ(A,1,1) is A, whose (0,1) entry is 1. The displayed inverse expression
has (0,1) entry 1/2. Lean proves the matrices unequal, and the sixth Clean result
states that same counterexample. This is a check of the displayed formula at a
specific permitted input, not a claim about every reconstruction method or any
later manuscript version.

For an ordinary real-input DFT of length m+1, odd m makes the transform length even;
its Nyquist endpoint needs separate treatment. Resolving that endpoint and specifying
which potential samples are retained is the next inverse-transform task. We have
not silently amended the source or labelled an unproved corrected formula as proved.
The forward identity remains valid.

## What is authored in Clean, and what still needs Lean

`magnetic phase`, `magnetic adjacency`, and `magnetic Laplacian` use `Define … Equals:`.
Their bodies are Clean expressions built from explicit imported primitives.
The exponential, real-to-complex embedding, transpose, and Hermitian predicate use
ordinary `Notation … Means:` interfaces to Lean operations.

Three definitions use visible `From Lean` boundaries:

- `magnetic degree matrix`: finite row sums and a diagonal constructor;
- `walk profile`: recursive word enumeration, ordered products, and filtering;
- `walk Fourier sum`: a finite indexed sum with a bound variable.

These are language gaps, not opaque or assumed mathematical facts: their full
bodies are in `CleanPapers/Definitions.lean` and `CleanPapers/Magnetic.lean`.
Removing the boundaries needs specified binder and recursion constructs with
unique parse and elaborated-target rules. This change adds no parser syntax,
registry, or name-based mathematical dispatch.

The detailed proofs remain Lean because Clean currently has no proof language.
The next useful Clean port is the finite-sum/word machinery, followed by a corrected
inverse-transform statement and proof.

## Reproduce

Use the pinned Lean 4.24.0 / Mathlib environment from the repository root:

```sh
lake build CleanPapers.Magnetic
python3 verify_magnetic.py
lake env lean generated/VerifiedMagnetic.lean
lake env lean generated/VerifiedMagneticOriginal.lean
pdflatex -interaction=nonstopmode -halt-on-error -output-directory generated latex/magnetic.tex
pdflatex -interaction=nonstopmode -halt-on-error -output-directory generated latex/magnetic.tex
python3 tools/provenance.py --apply
python3 tools/build_review.py
python3 tools/provenance.py
```

The [PDF specimen](../generated/magnetic.pdf) renders all six statements. The
[offline browser](review.html) shows the Clean source and translated propositions;
it does not run the proof checker itself.
