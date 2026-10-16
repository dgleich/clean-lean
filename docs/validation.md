# Validation of the initial prototype

Validated on 2026-10-16 with Python 3.11.2 and Lean/Mathlib v4.24.0. The pinned Mathlib commit is f897ebcf72cd16f89ab4577d0c826cd14afaafc7.

- All 80 corpus entries parse, with 20 distinct source declarations per subject.
- The separate `generated/VerifiedCorpus.lean` fixture proves all 80 translated propositions using their Mathlib sources. Lean completed with exit code 0. This tests the semantic translation for these examples, not every possible Clean input.
- Generated Lean for the Stewart statement and derived square-matrix extension also type-checks.
- All 54 Python tests pass (rerun before the initial Git snapshot). Context tests additionally cover parameter dependencies, inherited assumptions, nested references, scope, and rendering modes. They cover accepted spelling equivalences, capitalization, required attribution, duplicate/undeclared names, dimensions, type/value separation, local definition scope, extension normalization, logical precedence, negative powers, English logical connectives and type descriptions, readable result titles, title normalization collisions, compact/block attribution equivalence, optional fields, source/declaration validation, quoting and duplicate-field errors, and LaTeX escaping.
- `generated/specimen.pdf` compiles with pdfLaTeX in two passes. It has 13 pages and no overfull boxes. Its opening page was visually inspected. The package resolves `.clean` arguments to generated TeX fragments without shell escape.
- The command-line check and build paths were exercised, including a separate output directory.

The normal Lean backend emits proposition definitions without `sorry` or `axiom`. Corpus proofs are validation fixtures, not an implemented proof language. Successful PDF compilation does not establish mathematical validity; the independent Lean fixtures supply that check for the corpus.

Typechecking beyond the supported fragment, historical attribution accuracy, comprehensive CLR coverage, arbitrary TeX templates, and general parser completeness are not claimed. See the decision log and specification for explicit boundaries.

After the English-rendering and readable-title changes, every generated Lean file was unchanged by SHA-256. The subsequent compact-attribution change modifies Lean docstrings; the 80 corpus proof fixtures were regenerated and checked again.
