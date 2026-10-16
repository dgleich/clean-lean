# Notation module experiment

The first slice imports `examples/modules/sorting.clean` from `examples/notation.clean`. This branch preserves intermediate commits, including the initial syntax fixture before parser support.

Provisional choices:

- Imports are relative to the importing file. Imports and notation declarations precede results. Imported modules contain definitions only for this slice.
- `Notation` names can contain spaces. Calls still use parentheses and comma-separated arguments; this is not an unrestricted English parser.
- `Let` clauses type every parameter, in header order. `Returns` states the output type. These annotations support the existing Python parser; generated Lean definitions independently check the signature against `Means`.
- `Means` is one Lean expression, not an interpolated text template. Generated wrappers bind its arguments, avoiding textual substitution/capture of Lean variables.
- `Render` is plain English with named argument placeholders. Literal text is escaped for LaTeX; raw TeX templates are outside this slice.
- Duplicate visible names and cyclic imports are errors. Repeated imports of the same file are deduplicated. Qualification and selective exports are deferred.
- Parsing alone does not certify Lean validity. Run Lean on generated output to check meanings and signatures.
- Existing JSON types/functions and source metadata remain for compatibility. This slice removes the hidden insertion-sort mapping from the new example, not the entire registry from the project.

## Implemented and checked

The regular CLI now loads these modules. `python3 -m cleanlang build examples/notation.clean` generates the statement and notation wrapper. The lower-level `core.parse` remains a parser for already-resolved statement text; `modules.load_document` resolves files first.

69 Python tests pass, including 15 module tests. `generated/VerifiedNotation.lean` type-checks and proves the example with only the declared sorting import. Its generator explicitly removes the legacy `insertionSort` entry before loading the example. The 80 existing corpus proofs also pass. The one-page LaTeX specimen compiles in two passes without unresolved references or overfull boxes.

The first proof-fixture commit intentionally records a failing intermediate state; its follow-up fixes the unconditional Matrix scope and missing proof argument.

Remaining limits: signatures must use existing closed registry types; dependent/generic notation parameters, overloads, qualification, type phrase declarations, module provenance metadata, and automatic printed definition sections are not implemented. Imported modules cannot include results yet. `Means` is trusted Lean source, with compilation as a separate step. The CLI retains its legacy project import list for existing results; the dedicated verification fixture demonstrates sorting-only imports. Lean dependencies remain pinned by the existing project lockfiles; there is no additional module package manager.
