:::llm gpt-6 2026-11-07 role=assisted

# Callable evidence acceptance study

The repository compiler supports this prototype. Its full regression and
native-study validation runs remain pending; passing the focused tests does
not establish complete language conformance. See the
[contract](../../docs/callable-evidence.md) for scope and exact emission rules.

Run `python3 studies/callable-evidence/verify.py`. The verifier produces
Generated.lean, Verified.lean and Statements.tex. Twenty-one independent native
targets cover six definitions and fifteen propositions; fifteen proofs check the result
statements. It compares canonical elaborated types and bodies, not only
mathematical or definitional equality. No native proof search is used to choose
the meaning of an evidence call.

The cases cover direct and named universal assumptions, dependent proof families,
nested application, generic proof fields, proof and function domains, captured
free variables and type scopes, implication application, and saving an assumption
as a local value. Most conclusions are equalities of a constructed proof with
itself: these isolate whether the correct typed evidence term was constructed.
They are language acceptance cases, not new topology results.

The prototype passes the focused regression group; its latest counts and remaining
gates are recorded in the subpath study checkpoint. Ordinary non-condition indices
still reject binders. Higher-order beta reduction with binders in its body remains
unsupported, as do callable views of opaque native condition bodies and automatic
views of negation. Scope/substitution coverage, acceptance-contract documentation,
full-suite validation and the final acceptance audit remain unfinished.

Build the LaTeX specimen twice from the repository root with
`pdflatex -output-directory=/tmp/clean-callable-pdf studies/callable-evidence/latex.tex`
after creating that output directory. The three-page specimen was inspected; the
proof-field description explicitly displays its carrier.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Broader validation result

The first frozen callable-evidence snapshot completed its native portfolio with
32 of 33 studies passing. Diagram maps failed when eager callable classification
attempted to serialize an internal application. The same snapshot's full test
run records a diagram-map setup error and remains in progress. The newer compiler
uses demand-driven call-head classification and selected producer fields; its
native diagram-map check passes all 15 exact targets and six proofs. Its full
regression and portfolio remain pending. See the
[topology acceptance audit](../topology/implementation-status.md); neither run is
being reported as a completed all-green validation.
:::
