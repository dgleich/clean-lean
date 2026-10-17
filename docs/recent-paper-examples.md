# Recent paper results in aspirational Clean

These three specimens use David Gleich's papers to test the experience of writing Clean. They are source-based syntax proposals, **not parsed statements or Lean proofs**. Paper-specific mathematical modules and the proposed summation, quantifier, set, and optimization syntax are not implemented. No theorem is added to the verified Mathlib corpus.

The selection came from the [author's publication list](https://dgleich.com/publications). Bibliographic references below pin the versions actually consulted. This is a small varied sample, not a claim to cover every recent paper.

## Magnetic graph matrix powers

Huang, Gleich, and Li, *Powers of Magnetic Graph Matrix: Fourier Spectrum, Walk Compression, and Applications*, arXiv:2506.07343v1 (2025), Supplement S.II, Theorem 1, forward direction and equation (17). The specimen uses the matrix form of the forward identity; it does not assert the inverse-reconstruction part. [Source](https://arxiv.org/html/2506.07343v1).

```text
Result magnetic powers encode walk profiles:
    Attribution: magnetic2025; Supplement S.II, Theorem 1; adapted; scope: forward transform

    Let n be a positive natural number
    Let A be a real n×n matrix
    Let m be a natural number
    Let q be a real number

    Let M = exp(2*π*i*q)*A + exp(-2*π*i*q)*transpose(A)
    Let Φ = walk profile(A)

    Conclude:
        M^m = exp(-2*π*i*q*m) *
            (sum for k from 0 to m of exp(4*π*i*q*k)*Φ(m,k))
```

**Required meaning:** `Φ(m,k)` sums ordered products of `m` factors, each `A` or `transpose(A)`, with exactly `k` factors equal to `A`; the empty product is the identity. Products retain their order. `i` and `π` are imported constants. [Definition and forward identity](https://arxiv.org/html/2506.07343v1).

**Syntax pressure:** the summation binds `k` only within its body. A named function-valued object `Φ` should be as easy to use as a scalar local definition. Matrix multiplication and scalar multiplication must resolve through imported declarations. The continuation after `=` and `*` needs an explicit layout rule; this specimen proposes continuation only inside an already indented expression block, not automatic continuation of unrelated clauses.

## A size-specific Cheeger inequality

Huang and Gleich, *A Cheeger Inequality for Size-Specific Conductance*, arXiv:2303.11452v3, revised July 2026, Theorem 3.1. This specimen restricts to connected unweighted simple graphs, excludes μ=0, and makes admissible-set existence explicit. [Theorem](https://arxiv.org/html/2303.11452v3), [version record](https://arxiv.org/abs/2303.11452v3).

```text
Result size-specific Cheeger inequality:
    Attribution: cheeger2026; Theorem 3.1; adapted

    Let G be a finite simple graph
    Let μ be a real number
    Assume connected: G is connected
    Assume nontrivial: G has at least two vertices
    Assume size range: 0 < μ and μ ≤ 1/2
    Assume admissible size:
        there is a set S of vertices of G such that
            μ*volume(G) ≤ volume(G,S)
            and
            volume(G,S) ≤ (1-μ)*volume(G)

    Let φ = conductance(G,μ)
    Let φ₀ = conductance(G)
    Let λ = spectral minimum(G,μ)
    Let t = μ^2/(μ^2 + 1/2 - μ)

    Conclude:
        ((t*φ + (1-t)*φ₀)^2)/4 ≤ λ
        and
        λ ≤ 2*φ
```

**Required meaning:** `volume` sums degrees; `conductance(G,μ)` is the minimum cut conductance under the displayed volume constraint. `spectral minimum` means equation (5), not an ordinary eigenvalue: minimize `xᵀLx` with `xᵀd=0`, `xᵀDx=1`, and `sqrt(μ/((1-μ)*volume(G))) ≤ |x_v| ≤ sqrt((1-μ)/(μ*volume(G)))` for every vertex. Here `d`, `D`, and `L` are the degree vector, degree matrix, and Laplacian. [Definitions](https://arxiv.org/html/2303.11452v3).

**Syntax pressure:** existential assumptions deserve a readable binding form; `S` must not escape its assumption. The local `t` exposes the interpolation and keeps the conclusion readable. The two inequalities use explicit “and” rather than silently assigning semantics to a comparison chain. A paper-specific name such as `spectral minimum` must resolve to a real definition in an imported module, not a prose placeholder that the compiler pretends to understand.

## A suboptimality certificate for trace-bounded SDPs

Huang and Gleich, *Suboptimality bounds for trace-bounded SDPs enable a faster and scalable low-rank SDP solver SDPLR+*, arXiv:2406.10407v3, revised June 2026, Corollary 2, equation (3). The specimen makes feasibility and the optimizer explicit and names the dual lower bound `d`. [Source](https://arxiv.org/html/2406.10407v3).

```text
Result trace bound gives a suboptimality certificate:
    Attribution: sdplr2026; Corollary 2, equation (3); adapted

    Let n, m be positive natural numbers
    Let C, X be real symmetric n×n matrices
    Let A be a linear map from SymmetricMatrix(n,Real) to Vector(m,Real)
    Let b, y be real m-vectors
    Let α be a nonnegative real number

    Let F = {Z: SymmetricMatrix(n,Real) | Z ⪰ 0 and trace(Z) ≤ α and A(Z) = b}
    Assume feasible candidate: X belongs to F
    Let X⋆ be a minimizer of ⟨C,Z⟩ over Z in F

    Let δ = smallest eigenvalue(C - adjoint(A)(y))
    Let d = ⟨y,b⟩ + α*min(δ,0)

    Conclude: ⟨C,X⟩ - ⟨C,X⋆⟩ ≤ ⟨C,X⟩ - d
```

**Required meaning:** matrix inner products are Frobenius inner products; vector inner products are Euclidean. `adjoint(A)` uses these products. The optimizer declaration binds an arbitrary minimizing matrix, including its membership in `F`; it does not select one canonically. [Problem setup and certificate](https://arxiv.org/html/2406.10407v3).

**Syntax pressure:** set comprehension binds `Z` inside the set; the optimization phrase binds a separate `Z` inside its objective. Neither escapes. A minimizer phrase needs a precise rule: it can elaborate to an object with explicit feasibility and minimality assumptions. A separate existence theorem would justify introducing such an object without assumptions in a proof language. We should not hide choice or existence behind a convenient phrase. The long feasible-set line is the least pleasant part of this specimen and motivates an indented set/constraint form.

## What these examples suggest

The statement shell survives all three examples: objects, named assumptions, useful local names, then a claim. The missing language features are primarily **binding forms**, not more hard-coded mathematical types.

| Proposed form | Binding contract to specify | Status |
| --- | --- | --- |
| `sum for k from 0 to m of ...` | Finite inclusive index range; `k` local to summand | Aspirational |
| `there is a set S ... such that ...` | Existential binder; `S` local to proposition | Aspirational |
| `{Z: T | P}` | Set comprehension; `Z` local to predicate | Aspirational |
| `a minimizer of ... over Z in F` | Bound objective variable plus an arbitrary minimizer and its hypotheses | Aspirational |
| Function-valued local names | Imported operation returning a function; ordinary typed application thereafter | Beyond current unary-function support |
| `⟨C,X⟩`, `⪰`, and paper-specific phrases | Explicit imported notation with typed meanings | Modules not implemented |
| Mathematical subscripts/stars in names | Readable names with hygienic internal identifiers | Lexical policy needs extension |

The imports for these specimens must eventually provide the types, operations, phrases, literal/coercion rules, and source declarations. We deliberately do not add pretend import paths to non-existent mathematical modules. The specimens remain in documentation until those modules and binding forms exist. Their source keys can be declared using the existing `Source` form, with these pinned URLs:

- `magnetic2025`: Yinan Huang, David F. Gleich, Pan Li; [arXiv:2506.07343v1](https://arxiv.org/abs/2506.07343v1).
- `cheeger2026`: Yufan Huang, David F. Gleich; [arXiv:2303.11452v3](https://arxiv.org/abs/2303.11452v3).
- `sdplr2026`: Yufan Huang, David F. Gleich; [arXiv:2406.10407v3](https://arxiv.org/abs/2406.10407v3).

These are adapted statements, not verbatim quotations. Full paper text and PDFs are not copied into the repository. The displayed mathematical formulas were compared with the cited versions; no claim of formal verification is made.
