:::llm gpt-6 2026-10-23 role=assisted

# Clean: readable mathematics for Lean

Clean is an experimental language for writing mathematical definitions and theorem
statements in a form you can read aloud. The same source translates to Lean and
renders as LaTeX, with attribution attached to each result.

For example, the determinant of a product is the product of the determinants:

```text
Import "../library/linear_algebra.clean"
Import "../library/sources.clean"

Result determinant product:
    Attribution: mathlib; Matrix.det_mul; specialized
    Let n be a natural number
    Let A, B be complex n×n matrices
    Conclude: det(A*B) = det(A)*det(B)
```

`Let` introduces the objects; `Conclude` states the claim. `Attribution` records
where the result comes from—here, Mathlib's determinant theorem, specialized to
complex matrices. The two imports supply the mathematical vocabulary and source
details. Import paths in this example are relative to a file in `examples/`.

For a result with hypotheses, use named `Assume` clauses. The
[eigenvector example](examples/similarity.clean) shows how an eigenvector changes
under a change of basis, using phrases such as `Let x be a complex n-vector` and
`Assume eigenpair: A*x = μ*x`.

Clean currently translates **statements, not proofs**. The repository includes
92 statements checked against their Mathlib proofs, along with exploratory
examples that show where the language still needs work.

See the [typeset examples](generated/specimen.pdf),
[Clean-to-Lean reference](docs/clean-to-lean.html), or
[language specification](docs/spec.md). For the direction of the design, see
[aspirational syntax](docs/aspirational-syntax.md).

:::

:::llm 2026-10-23 role=assisted

## Try it

Python 3.10+ is sufficient for the core translator. BibTeX imports use an optional dependency: install with `python3 -m pip install -e ".[bibtex]"`. Run from this directory:

```sh
python3 -m cleanlang check corpus/*.clean
python3 -m cleanlang build corpus/*.clean examples/similarity.clean examples/extension.clean examples/notation.clean
python3 -m cleanlang build examples/determinants.clean
python3 -m cleanlang lean examples/notation.clean
python3 -m unittest discover -s tests -v
```

`check` validates supported Clean syntax and signatures. It does not run Lean. Generated wrappers allow Lean to check each declared `Means` expression, including parameter and return types.

For [BibTeX attribution](docs/spec.md#bibtex-sources), use `Import BibTeX "references.bib"`; see [the specimen](examples/bibtex.clean). Citation keys become source keys. This imports bibliography data, not mathematical definitions.

## Lean checking

The project pins Lean and Mathlib v4.24.0. With elan/Lake installed, obtain the pinned dependencies using `lake build`; use `lake exe cache get` for Mathlib's precompiled modules when needed.

```sh
python3 verify_corpus.py
python3 verify_notation.py
lake env lean generated/VerifiedCorpus.lean
lake env lean generated/VerifiedNotation.lean
lake env lean generated/similarity.lean
lake env lean generated/extension.lean
```

Normal translation defines propositions; it does not prove them. The corpus fixture proves all **92 statements, 23 each** in linear algebra, graph theory, analysis, and CLR-aligned undergraduate algorithms against their Mathlib sources. Algorithm coverage is sorting and arithmetic, not a complete CLR formalization. The Stewart proof lives in the sibling `stewart-lean` project; this project's generated Stewart output is a statement.

## Recent paper statements

Three [working Clean statements](examples/recent-papers.clean) now use complete [Lean mathematical definitions](CleanPapers/Definitions.lean): magnetic walk profiles, size-specific conductance, and an SDP certificate. See [definitions, domain choices, and reproduction commands](docs/paper-translations.md), [generated Lean](generated/RecentPapers.lean), and the [PDF](generated/recent-papers.pdf). These three statements are typechecked, not proved; independent Lean checks verify their translated shapes.

## LaTeX

The [clean.sty package](latex/clean.sty) inputs generated fragments, not raw Clean syntax. No shell escape is required. Compile each specimen twice:

```sh
pdflatex -interaction=nonstopmode -halt-on-error -output-directory generated latex/specimen.tex
pdflatex -interaction=nonstopmode -halt-on-error -output-directory generated latex/specimen.tex
```

The same commands apply to `latex/contexts.tex` and `latex/notation.tex`. Context rendering is selected explicitly with `\CleanInput[contexts=expanded]{examples/determinants.clean}` or `contexts=referenced`. Expanded is the default; referenced results always say which context they use. See the [comparison](generated/contexts.pdf).

## Files and workflow

Every language change must satisfy the [hard acceptance requirements](docs/language-change-acceptance.md): a unique parse and a precise, unique fully elaborated Lean target. [AGENTS.md](AGENTS.md) requires grammar and translation rules, a uniqueness argument, and independent test oracles. The [initial acceptance cases](tests/acceptance/language-contract.json) are pending; existing regression tests do not certify the prototype.

- `library/*.clean`: authored types, notations, phrases, imports, and sources.
- `examples/modules/square-matrices.clean`: a derived type alias and prose phrase.
- `corpus/*.clean`: statements with explicit imports.
- `corpus/catalog.json`, `corpus/references.json`: generated scholarly provenance, not mathematical definitions or function mappings.
- `generated/`: Lean, TeX, metadata, and small reviewable PDFs.
- `build_corpus.py`: recreates corpus statements and provenance at the pinned Mathlib revision.

See [AGENTS.md](AGENTS.md) for Git rules: retain a linear local history of intermediate steps, including failing states. Checks document progress; they do not gate commits. Do not squash history or publish without explicit authorization.

See [recent-paper specimens](docs/recent-paper-examples.md) for source-based aspirational statements beyond the verified corpus.

## Limits

See [module syntax and limitations](docs/notation-prototype.md). Clean remains a statement-language prototype: it has no proof language, unrestricted mathematical English, general dependent-type inference, or Lean typeclass declaration syntax. The initial matrix operation module uses complex scalars; composition uses real functions. Imported modules currently contain definitions, not results. See [THIRD_PARTY.md](THIRD_PARTY.md) for attribution and licensing.

Authored `Define … Equals:` now supports reusable Clean expressions and predicates.
The corpus has 92 statements (23 per subject; 80 distinct Mathlib source lemmas).
See [porting findings and next gaps](docs/porting-findings.md). Run
`python3 verify_definitions.py` followed by
`lake env lean generated/VerifiedDefinitions.lean` for the bounded structural
translation checks, in addition to the existing corpus checks.

## Review and editor support

Open the [local review workspace](docs/review.html) to browse highlighted Clean
files beside their generated Lean, follow imports, and export review notes.
See the [review walkthrough](docs/review-workflow.md) and
[VS Code / Emacs / Vim setup](editors/README.md). Rebuild the offline snapshot with
`python3 tools/build_review.py`; highlighting does not certify parsing or proofs.

## Authored sorting examples

See [sorting examples and proof status](docs/sorting-examples.md) for proposed Clean insertion sort and heapsort, and an independent Lean proof of heapsort comparison complexity.

## Provenance

This human-directed prototype includes LLM-authored code and text. See [provenance and source boundaries](PROVENANCE.md), including the distinction between generated adaptations and upstream mathematics. Historical commits predate the retrospective tags.
