:::llm 2026-10-23 role=assisted

# Paper definitions and Lean translations

The three paper specimens now have working [Clean statements](../examples/recent-papers.clean), an explicit [Clean vocabulary module](../library/papers.clean), and complete [Lean definitions](../CleanPapers/Definitions.lean). The [generated Lean](../generated/RecentPapers.lean) defines their propositions. It does **not** prove the three paper results. The [PDF](../generated/recent-papers.pdf) presents the statements with their main definitions.

The handwritten syntax in [the earlier gallery](recent-paper-examples.md) remains the design target. The working version uses named operations for sums, existential conditions, and optimization predicates. Those operations resolve through explicit imports to actual definitions; none is an uninterpreted symbol or an assumed paper theorem. Top-level Clean `Define` blocks and general binder syntax remain future language work.

## Magnetic powers and walk profiles

The definition starts with words of length m over two symbols. A forward symbol contributes A; a backward symbol contributes its transpose. `wordProduct` multiplies these factors in their written order. `words` enumerates each word once, and `walkProfile A m k` sums the products of exactly those words with k forward symbols. For example, the length-two, one-forward profile is A Aᵀ + Aᵀ A. The empty product is I, and profiles outside 0 ≤ k ≤ m are zero.

`complexify` casts matrix entries from real to complex. `phase q` is exp(2πiq); `magneticMatrix A q` adds the two phase-scaled matrices. `walkFourierSum A m q` multiplies the inclusive sum over k = 0,…,m by phase(−qm), with summand phase(2qk) times the complexified profile. This realizes the selected forward identity. [Paper, equation (1) and Supplement S.II](https://arxiv.org/html/2506.07343v1).

The working statement is:

```text
Let M = magnetic matrix(A,q)
Conclude: matrix power(M,m) = walk Fourier sum(A,m,q)
```

The vocabulary also exposes `walk profile(A,m,k)` for other statements. Weighted real matrices are allowed; the imported definitions do not silently replace them by binary adjacency matrices. Matrix multiplication stays noncommutative.

## Conductance and the spectral optimization problem

Vertices are `Fin n`, and G is a Lean `SimpleGraph (Fin n)`. Its real adjacency matrix has entry 1 for an edge and 0 otherwise. Degree is the row sum, volume is the sum of degrees over a finite vertex set, and total volume uses all vertices. `cut` sums adjacency entries from S to its complement, counting each crossing edge once.

An admissible cut has positive volume on both sides and satisfies μ vol(G) ≤ vol(S) ≤ (1−μ) vol(G). Its conductance is cut(S) divided by the smaller side volume. `conductance G μ` is the infimum over these admissible values; because the cut domain is finite, this specifies the minimum when the domain is nonempty. Ordinary conductance uses μ = 0.

The Laplacian is diag(degree) minus adjacency. `spectralFeasible` gives the weighted zero-mean constraint, unit degree-weighted squared norm, and both coordinate-magnitude bounds in equation (5). `spectralMinimum` takes the infimum of xᵀLx over this domain. The translated inequality restricts to connected simple graphs, n ≥ 2, 0 < μ ≤ 1/2, and an admissible cut. [Paper, equation (5) and Theorem 3.1](https://arxiv.org/html/2303.11452v3).

Both optimization definitions explicitly return zero for an empty domain. This is a totalization convention, not a claim that an infeasible problem has optimum zero. The statement assumes an admissible cut. The paper's feasible-vector construction explains why its spectral domain is then nonempty; a Lean proof of that implication, of attainment, and of the inequality is outside this statement translation. No existence assumption is concealed in the name “minimum.” The μ = 0 spectral limit is not implemented or claimed here.

## The SDP certificate

The measurement map is represented by a family of symmetric coefficient matrices Bₖ. Define A_B(X)ₖ = ⟨Bₖ,X⟩ using the entrywise Frobenius product. Its adjoint is the explicitly constructed sum Σₖ yₖBₖ. The Lean checks prove the defining adjoint identity against the Euclidean product.

`feasible B b α X` means X is positive semidefinite, its trace is at most α, and A_B(X) = b. `minimizes C B b α Z` includes feasibility of Z and comparison of its objective with every feasible matrix. Thus the theorem quantifies over Z and assumes it minimizes; it never manufactures an optimizer.

`realEigenvalues M` is the set of real r having a nonzero vector v with Mv = rv. `smallestEigenvalue` takes its infimum, with an explicit zero fallback for empty real spectrum. In the statement, n > 0 and the slack matrix is symmetric, the intended domain of the smallest real eigenvalue. The definition does not use an approximate eigensolver. The certificate uses the dual bound ⟨y,b⟩ + α min(λmin(C−A_B*(y)),0). [Paper, Corollary 2, equation (3)](https://arxiv.org/html/2406.10407v3).

The coefficient representation makes linearity explicit without requiring the prototype to express linear-map types over symmetric subspaces. The representation theorem for arbitrary linear maps and the spectral facts that identify the infimum with a least eigenvalue are not proved by this translation. Symmetry, positive dimensions, α ≥ 0, candidate feasibility, and optimizer status are all explicit hypotheses.

## Validation and reproduction

Run these commands from the repository root with the pinned Lean toolchain available:

```sh
lake exe cache get Mathlib.LinearAlgebra.Matrix.PosDef
lake build CleanPapers.Definitions
python3 verify_papers.py
lake env lean generated/RecentPapers.lean
lake env lean generated/CheckedPaperStatements.lean
lake env lean CleanPapers/Checks.lean
pdflatex -interaction=nonstopmode -halt-on-error -output-directory generated latex/recent-papers.tex
pdflatex -interaction=nonstopmode -halt-on-error -output-directory generated latex/recent-papers.tex
```

`verify_papers.py` regenerates Lean, LaTeX, bibliography, and attribution metadata from the authored Clean statements. It also appends independently written proposition checks from [the check template](../tests/lean/paper_statement_checks.lean.inc). Lean proves that each generated proposition is definitionally equal to that independent specification, including its hypotheses and quantifier order. These equality checks do not inhabit the propositions themselves.

[Definition checks](../CleanPapers/Checks.lean) prove the empty-walk cases, the ordered length-two expansion, an out-of-range profile, the measurement adjoint identity, the volume and cut conductance of a single edge, the empty-cut-domain fallback, and equality of the interpolation formula to the paper’s coefficients. The existing 80 Mathlib corpus proofs are separate from these three new paper statements.

## Decisions to revisit

- General sums, set comprehensions, quantifiers, and minimizer phrases should eventually be authored directly in Clean. Their current Lean definitions are explicit dependencies, not a new registry.
- The working Cheeger example calls its spectral value `spectral`. A bare `λ` currently collides with Lean syntax; general identifier hygiene remains required compiler work.
- Scalar/matrix operations inside the paper definitions are resolved by Lean. This change adds no new mathematical name dispatch to the Python compiler; the older core's existing dispatch remains migration debt.
- Real infima provide precise optimization values without choosing an optimizer. Empty-domain fallbacks are documented and excluded from the intended theorem domain, rather than presented as mathematical conventions from the papers.
- A full proof project would additionally prove domain nonemptiness and attainment, the finite-spectrum facts, and the three main results. These are separate from completing their definitions and translating their statements.
