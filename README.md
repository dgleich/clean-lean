# Clean statement prototype

A local prototype for readable mathematical declarations, mandatory attribution, LaTeX rendering, and statement translation to Lean. Start with the [specification](docs/spec.md), the [decision log](docs/decisions.md), and the [rendered specimen](generated/specimen.pdf).

The corpus has **80 statements, 20 each** in linear algebra, graph theory, analysis, and CLR-aligned undergraduate algorithms. Each has an exact Mathlib source reference. Algorithms currently means sorting and number-theoretic supporting results, not a complete CLR formalization. No remote repository is configured.

## Compact attribution

```text
Attribution: mathlib; Matrix.det_mul_left_comm
Attribution: stewart2001; Theorem 1.10, page 9; adapted; scope: eigenvector part
```

Source keys resolve through `sources.json`; `--sources` selects another registry. Relationship and named fields are optional. The expanded block form remains available. LaTeX uses short citations and a shared reference list; exact provenance stays in JSON metadata.

## Try it

Python 3.10+ is sufficient; the translator has no external Python dependencies. Run from this directory:

```sh
python3 -m cleanlang check corpus/*.clean
python3 -m cleanlang build corpus/*.clean examples/similarity.clean
python3 -m cleanlang latex examples/similarity.clean
python3 -m cleanlang lean examples/similarity.clean
python3 -m cleanlang build --registry examples/extensions.json examples/extension.clean
python3 -m unittest discover -s tests -v
```

Build LaTeX with a standard installation containing amsmath, amssymb, hyperref, and geometry:

```sh
pdflatex -interaction=nonstopmode -halt-on-error -output-directory generated latex/specimen.tex
pdflatex -interaction=nonstopmode -halt-on-error -output-directory generated latex/specimen.tex
```

The [clean.sty package](latex/clean.sty) accepts `\CleanInput{corpus/analysis.clean}` (or `\CleanInput{generated/analysis}`). It reads the generated TeX, not raw `.clean` files. No shell escape is needed.

## Lean checking

The project pins Lean and Mathlib v4.24.0. With elan/Lake installed, set up dependencies using `lake update`. To download only the needed precompiled modules, pass the modules listed in `imports.json` to `lake exe cache get`.

```sh
python3 verify_corpus.py
lake env lean generated/VerifiedCorpus.lean
lake env lean generated/similarity.lean
```

Normal translator output is a **definition of a proposition**, not a proof. The separate `VerifiedCorpus.lean` fixture checks the curated 80 statements against actual Mathlib proofs. The Stewart example's checked proof is maintained in the sibling `stewart-lean` project; its generated Clean output is only a statement.

This workspace initially shares the already-installed dependency directory with `../stewart-lean` via an ignored `.lake/packages` symlink. A fresh checkout can use `lake update` to obtain its own dependencies.

## Files

- `sources.json`: shared bibliography and source kinds.
- `corpus/references.json`: declaration lookup with exact Mathlib URLs.
- `corpus/*.clean`: the readable statements.
- `corpus/catalog.json`: source revision, declaration, URL, source excerpt, topic, and validation proof term for each entry.
- `generated/*.lean`, `*.tex`, `*.metadata.json`: backend output and attribution metadata.
- `cleanlang/registry.json`: type constructors, prose phrases, and function signatures/renderings.
- `examples/extensions.json`: deriving a square-matrix type alias without parser changes.
- `build_corpus.py`: reproduces the curated corpus from a pinned local Mathlib checkout.
- `build_registry.py`: reproduces the built-in registry.

To refresh source references, run `python3 build_corpus.py --mathlib /path/to/mathlib4` at the pinned revision. Changing the revision requires rechecking all statements and proofs. Mathlib source excerpts retain their provenance; see [THIRD_PARTY.md](THIRD_PARTY.md).

## Limits

This is a statement-language prototype, not a general Lean frontend. It has registered functions and type patterns, basic arithmetic and logic, and simple type/dimension checks. It does not yet parse explicit quantifiers, lambdas, summations, arbitrary dependent types, proof scripts, or unrestricted mathematical English. See the spec and decision log for exact rules and remaining choices.

## Development

See [AGENTS.md](AGENTS.md) for local Git workflow and validation rules. Keep a linear history of intermediate steps, including unfinished or failing states. Record validation status; passing checks are not a prerequisite for a commit. Do not squash away those steps or publish without explicit authorization.

Shared contexts are implemented: compare the [source](examples/determinants.clean) and [two rendering modes](generated/contexts.pdf). Use `\CleanInput[contexts=expanded]{examples/determinants.clean}` or `contexts=referenced`; references to contexts are always explicit.

The agreed next architectural step is explicit Clean definitions modules backed by Lean definitions. The first import/notation slice now works; JSON registries still supply existing types and legacy functions. See [prototype details](docs/notation-prototype.md).

Try the explicit module example:

```sh
python3 -m cleanlang build examples/notation.clean
python3 verify_notation.py
lake env lean generated/VerifiedNotation.lean
```

The [sorting module](examples/modules/sorting.clean) supplies the meaning of the readable name used in [this result](examples/notation.clean). The [rendered example](generated/notation.pdf) shows its English rendering. `check` validates Clean syntax and supported types; running Lean separately checks `Means` and the generated signatures.
