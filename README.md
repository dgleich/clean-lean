# Clean statement prototype

A local prototype for readable mathematical statements, mandatory attribution, LaTeX rendering, and translation to Lean. Start with the [aspirational syntax](docs/aspirational-syntax.md), the [syntax and semantics draft](docs/language-reference.md), the [current prototype specification](docs/spec.md), [decision log](docs/decisions.md), and [rendered specimen](generated/specimen.pdf).

All mathematical vocabulary comes from **explicit Clean imports**. There is no JSON registry, default vocabulary loader, or compatibility switch. A fresh translation environment is empty. Lean dependencies are pinned by `lean-toolchain` and `lake-manifest.json`.

```text
Import "../library/algorithms.clean"
Import "../library/sources.clean"

Result insertion sort length:
    Attribution: mathlib; List.length_insertionSort; specialized
    Let xs: List(Natural)
    Conclude: length(insertionSort(xs)) = length(xs)
```

The [algorithm module](library/algorithms.clean) declares the meaning and rendering of every function used here. It imports [type declarations](library/types.clean). [Source declarations](library/sources.clean) supply bibliography details. The [multiword notation example](examples/notation.clean) uses `insertion sort(xs)` from a separate module; see its [PDF](generated/notation.pdf).

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

Normal translation defines propositions; it does not prove them. The corpus fixture proves all **80 statements, 20 each** in linear algebra, graph theory, analysis, and CLR-aligned undergraduate algorithms against their Mathlib sources. Algorithm coverage is sorting and arithmetic, not a complete CLR formalization. The Stewart proof lives in the sibling `stewart-lean` project; this project's generated Stewart output is a statement.

This workspace shares dependencies with `../stewart-lean` through an ignored `.lake/packages` symlink. No remote repository is configured.

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
