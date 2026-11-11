:::llm gpt-6 2026-11-10 role=assisted

# LAProof in Clean

A mathematical companion to [LAProof](https://www.cs.princeton.edu/~appel/papers/LAProof.pdf),
by Ariel E. Kellison, Andrew W. Appel, Mohit Tekriwal and David Bindel
(ARITH 2023, DOI 10.1109/ARITH58626.2023.00021).

**Status: executable mathematical models and error conditions; the four numbered
paper theorems are drafted, not proved or fully translated.** This is an adaptation
in original explanatory wording, not a reproduction of the paper or its Coq proofs.
The source PDF is not redistributed here.

## Read this first

For a single-file reading view, start with [Paper-expanded.clean](Paper-expanded.clean):
it includes the implemented study definitions beside the explanatory text.
The shorter [Paper.clean](Paper.clean) remains the authored entry point; its
imports are expanded by `build_reading.py`, not maintained as a second copy.
Library imports remain explicit. Neither edition includes the pending IEEE
theorems as executable statements. Then read
[the unimplemented paper theorem targets](Paper.clean.proposed) and follow their
imports into [Models.clean](Models.clean), [Bounds.clean](Bounds.clean) and
[CSR.clean](CSR.clean). Those three modules translate today. The draft deliberately
uses a `.proposed` extension: its IEEE754 import does not exist yet. No dummy
module, axiom, `sorry`, or arbitrary floating operation makes the theorem targets
appear complete.

The intended theorem presentation is compact because its conclusion has a named,
Clean-authored condition:

```clean
Result dot mixed error:
  Attribution: laproof; Theorem 1 (bfDOT); adapted
  Let p,e: Natural
  Assume format: valid format(p,e)
  Let x,y: List(Float(p,e))
  Assume dimensions: list length(x) = list length(y)
  Assume finite vector x: all entries(finite(p,e),x)
  Assume finite vector y: all entries(finite(p,e),y)
  Assume finite output: finite(p,e)(computed dot(x,y))
  Conclude:
    dot accuracy(unit roundoff(p),underflow bound(p,e),
      real vector(x),real vector(y),value(computed dot(x,y)))
```

Here `dot accuracy` is implemented, with explicit existential witnesses and
componentwise bounds. `Float`, `valid format`, `finite` and the floating operations
are pending mathematical interfaces. The snippet is a target, not compilable
standalone Clean. The repeated format parameters are candidates for a bundled
arithmetic structure once its exact semantics are specified.

## What is implemented

- Error accumulation `h` and `g`, unit roundoff and underflow bound, authored in
  Clean. Natural exponents are kept natural; division expresses negative powers.
- Generic list models for DOT, SUM, sVec, VecAdd, VecAXPBY, MV, sMV, GEMV, sMat,
  MatAdd, MM, sMM, MatAXPBY and GEMM, plus a fused dot model. Arithmetic operations
  and the initial accumulator are explicit parameters.
- Exact real versions of the dot, sum and matrix-vector operation; real one- and
  two-norms; the absolute product sum.
- The numerical conclusions of Theorems 1–3 as named conditions, including
  existential perturbations and length-preserving elementwise relations.
- The entry-size condition of Theorem 4, including its auxiliary inequality.
- The floating equivalence relation described in Section IV, parameterized by
  finiteness and real interpretation. It identifies signed zeros by real value
  and groups nonfinite values together. It does not identify their bit patterns.
- A CSR record, validity condition, row-position list and pure fused product.
  Strictly increasing column indices fix row order and exclude duplicate entries.

New native adapters are only generic list primitives: zip, folds, transpose,
length, elementwise predicates, range and total lookup. The paper-specific
mathematical definitions are authored with `Define` and `Condition`.
This study uses explicit existing library imports, not `CleanPapers`.

## Paper coverage and remaining work

| Source | Companion | Status / remaining obligation |
|---|---|---|
| Section I; motivation | This introduction | Original summary; no prose copied |
| (1), rounding relation | `single operation error` | Relation translated; IEEE module must prove it, including rounding mode, valid formats, subnormals, finiteness, overflow and FMA |
| (2)–(3), forward/mixed error | Conditions in Bounds | Instantiated for dot/sum/MV; general abstract framework not formalized |
| (4)–(5), accumulated errors | Models | Translated; two zero-case supporting results proved |
| Theorem 1, (6) | `dot accuracy`; draft result | Conclusion translated; IEEE connection and proof pending |
| (7), expansion and product-bound proof | No formal proof yet | Define perturbation sequences and finite products; prove bounds without dropping higher-order terms |
| (8)–(9), forward bound | Absolute product sum; conservative forward condition | Equation (8) discrepancy unresolved; implication from mixed bound not proved |
| Sparse corollary | Coverage obligation | Support-count definition and sharper error bound pending |
| FMA corollary | Fused model; draft result | Model translated; IEEE FMA connection and bound proof pending |
| Theorem 2, (10) | `sum accuracy`; draft result | Conclusion translated; overflow assumptions and exact summation order need source reconciliation |
| Summation permutation corollary | Coverage obligation | Separate common error bound from equality of computed sums; proof pending |
| Theorem 3, (11) | `matrix vector accuracy`; draft result | Corrected residual dimension; IEEE connection and proof pending |
| Theorem 4, (12) | `safe entry bound`, `safe matrix vector input`; draft result | Input condition translated; finite-result theorem pending |
| Tables I–III | Models | All listed operation shapes represented; norms are exact-real definitions, not floating implementations or error proofs |
| Section III.A–D | Lists, folds and compositional definitions | Translated with explicit empty cases and row-major convention |
| Section III.E, MathComp bridge | Agreement proofs for selected list definitions | No general equivalence to Mathlib matrices or induced-norm bounds yet |
| Figure 1; Listing 1 | CSR record/invariants | General model translated; displayed numeric example and C layout not reproduced |
| Listing 2 | `csr row`, `csr product` | Pure intended algorithm; no C execution theorem |
| Listing 3; Section IV.B | Floating equivalence and obligations below | Memory representation, separation logic, preservation and dense/sparse equivalence pending |
| Sections V–VI; bibliography | Source link and this gap inventory | Related-work prose and bibliography not copied |

The mathematical companion is **not yet an everything-complete port**. The table
is the completion checklist; translated conditions are not counted as proved
paper theorems.

## Recorded adaptation decisions

1. **List lengths and initial values.** Zip truncates to the shorter list, as in
   Coq `combine`. The dot accuracy condition requires equal lengths; matrix
   accuracy requires rectangular rows. A caller supplies the zero accumulator.
   SUM uses a right fold; DOT a left fold. Empty inputs have explicit values.
   The natural expression n-1 saturates at zero; the empty SUM case is an explicit
   extension rather than an interpretation of a negative exponent in h.
2. **Row-major MM.** The page-5 snippet traverses rows of B without a visible
   transpose and does not directly express conventional row-major multiplication.
   Our MM explicitly pairs each row of A with each column of B. This is a
   documented mathematical adaptation, not a claim of literal source equivalence.
   Ragged lists are total inputs but are not covered by a rectangular-matrix claim.
3. **Theorem 3.** An m-by-n product has an m-entry residual, not the printed
   n-entry residual. The displayed page-5 Coq statement also requires length m.
   We treat the matrix perturbation as backward error and residual as forward
   error; the prose by (11) reverses those descriptions.
4. **Equation (8).** Its final two-argument `h` is undefined. We do not silently
   substitute `g` or assert the tighter bound. A separate conservative forward
   condition uses `g(n,n)`, consistent with Theorem 1. Its proof is still pending.
5. **Page-4 bfDOT display.** The perturbed vector is related to `v` in the printed
   indexed clause, inconsistent with Theorem 1's perturbation of the first vector.
   The companion follows the mathematical Theorem 1. Reconcile with upstream Coq
   before claiming an exact port.
6. **Listing 2.** Visual inspection confirms `row4_ptr` and an inner loop resetting
   `h` to zero after assigning the row start. Our row segment starts at its own
   pointer. These observations concern the printed PDF, not the upstream verified
   C implementation, which has not been audited here.
7. **CSR validity.** We require pointer length rows+1, first pointer zero, last
   pointer equal to stored-value length, monotone pointers, matching values/indices,
   in-range columns and strictly ordered columns per row. Total lookup has an
   explicit fallback; correct-use theorems must establish that it is never used
   out of range. Stored zeros are allowed. Input length must equal column count.
8. **No implicit IEEE claim.** Generic arithmetic callbacks are functional models,
   not evidence that arbitrary callbacks implement IEEE. A faithful bridge must
   include exceptional values and signed zeros, and distinguish fused and
   separately rounded arithmetic. Finite outputs and empty dimensions require
   explicit treatment, not casual omission of assumptions.

Source inspected: eight-page author-hosted PDF retrieved 2026-11-10;
SHA-256 `58ad59aea33338e838e955a41e67be4a8bec8c73fa72184b6087da862267d6cd`.
The source observations above were checked against its displayed formulas/listings.

## Language and library findings

No new syntax is needed for the implemented slice: parameterized records,
higher-order functions, named conditions, existential quantifiers and explicit
native imports suffice. `List.Forall₂` is a useful standard-library wrapper:
unlike truncating zip, it enforces equal lengths. A future standard list module
should absorb these generic adapters after canonical-target acceptance review.

The missing IEEE model and separation logic are **mathematical library/proof
obligations**, not automatically parser features. Do not introduce a magic
`IEEE` or `Hoare` keyword. First specify the types, operations, laws and unique
Lean targets. A Clean-authored finite-product proof will exercise existing fold
and induction support; lack of a usable proof language remains distinct from
being able to state the theorem.

For C correctness, the remaining interface must express readable/writable shares,
pointer/array representations, machine-integer dimension bounds, an uninitialized
output buffer, a post-state result related by floating equivalence, preserved
inputs, and the separation-logic frame property. The pure CSR function alone
establishes none of those claims.

## Reproduce

From the repository root:

```sh
python3 studies/laproof/verify.py
python3 studies/laproof/build_reading.py
python3 studies/laproof/verify.py --reading
```

Use the repository's pinned Lean/Mathlib environment; set `LAKE` if necessary.
The `--reading` check rejects a stale reading edition and runs the same seven
supporting proofs against that edition in temporary files. It does not establish
the four numbered paper theorems.

The driver loads the literate `Paper.clean` entry point and regenerates [Generated.lean](Generated.lean) and
[Verified.lean](Verified.lean), checks both, and proves two supporting zero cases
plus five agreement lemmas (dot, sum, row-major MM, fused dot and floating
equivalence). These seven checks do not prove the paper's four theorems. They are
not canonical-target conformance tests for new language syntax; this study adds
no syntax.

[Foundations.clean](Foundations.clean) contains only the two proved supporting
statements. Generated proposition definitions are explicitly distinct from
Lean `theorem` declarations with proofs. The proposed paper file is excluded
from generation until its missing IEEE dependency is implemented.
:::
