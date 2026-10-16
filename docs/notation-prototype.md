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
