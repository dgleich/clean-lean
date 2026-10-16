# Validation after registry removal

Validated on 2026-10-16 with Python 3.11.2 and Lean/Mathlib v4.24.0, pinned to Mathlib commit f897ebcf72cd16f89ab4577d0c826cd14afaafc7.

- All 80 Python tests pass. These include the original statement/attribution/context cases, module imports, generic type/dimension inference, empty environments, missing imports, custom types and sources, and rejection of removed CLI options/files.
- All 80 corpus propositions are proved by `generated/VerifiedCorpus.lean` against their cited Mathlib declarations. Their expressions now use wrappers generated from explicit Clean modules.
- `generated/VerifiedNotation.lean` proves the multiword insertion-sort example. The generated Stewart statement and square-matrix alias example also type-check. Normal generated statements remain proposition definitions, not proofs.
- A negative experiment supplied a syntactically valid notation returning `List(Natural)` but giving `(0 : Nat)` as its `Means`. Clean parsing succeeded and Lean rejected the generated wrapper with the expected type mismatch. Python syntax checking alone is not a Lean validity claim.
- The CLI checks/builds were exercised for all four corpus files and the Stewart, type-alias, notation, and context examples.
- Specimen, context-comparison, and notation PDFs compile in two passes: 13, 2, and 1 pages respectively. Final PDFs have no unresolved-reference markers, and compilation reports no overfull boxes. The notation specimen was visually inspected.
- The repository no longer contains the mathematical registry JSON, its generator, the extension JSON, source/import sidecars, or the legacy CLI flags. Every fresh environment is empty. Authored definition modules and explicit source declarations supply all non-operator vocabulary.

Notation wrappers are noncomputable mathematical definitions when needed; no `sorry` or axioms are introduced. The reference-index JSON contains only generated scholarly provenance, not mathematical meanings. Validation of this corpus does not establish arbitrary Clean input, source attribution accuracy, general parser completeness, or CLR algorithm coverage. Current restrictions, including complex-scalar matrix operations and the absence of generic typeclass syntax, are recorded in `notation-prototype.md`.
