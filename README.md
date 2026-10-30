:::llm gpt-6 2026-10-23 role=assisted

# Clean: readable mathematics for Lean

Clean is an experimental language for writing mathematical definitions and theorem
statements in a form you can read aloud. The same source translates to Lean and
renders as LaTeX, with attribution attached to each result.

For example, the determinant of a product is the product of the determinants:

```text
# Import mathematical vocabulary and bibliography entries.
Import "../library/linear_algebra.clean"
Import "../library/sources.clean"

Result determinant product:
    Attribution: mathlib; Matrix.det_mul; specialized
    # Introduce a dimension and two matrices of that size.
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

## More examples, with annotations

Clean supports full-line `#` comments, including inside indented blocks.
Comments explain the source without becoming part of the mathematical statement
or its LaTeX rendering. Put comments on their own lines; trailing comments after
code are not currently supported. Each block below is a separate example, with
import paths relative to `examples/`.

### State hypotheses and name an intermediate expression

A change of basis carries an eigenvector to an eigenvector of the transformed
matrix. Named assumptions make the conditions explicit.

```text
Import "../library/linear_algebra.clean"
Import "../library/sources.clean"

Result similarity transforms eigenvector:
    # Cite just the part of Stewart's theorem being adapted.
    Attribution: stewart2001; Theorem 1.10, page 9; adapted; scope: eigenvector part
    Let n be a natural number
    Let A, S be complex n×n matrices
    Let x be a complex n-vector
    Let μ be a complex number

    # Every assumption has a name for later reference.
    Assume invertibility: det(S) ≠ 0
    Assume nonzero: x ≠ 0
    Assume eigenpair: A*x = μ*x

    # Give the transformed vector a local name.
    Let y = inverse(S)*x
    Conclude:
        y ≠ 0
        and
        (inverse(S)*A*S)*y = μ*y
```

The word `and` joins two claims in one conclusion. Indentation groups the
multiline expression. See the [source example](examples/similarity.clean).

### State a graph property

For an undirected graph, an edge from u to v is also an edge from v to u.

```text
Import "../library/graph_theory.clean"
Import "../library/sources.clean"

Result adjacency symmetry:
    Attribution: mathlib; SimpleGraph.adj_symm; specialized
    Let n: Natural
    Let G: Graph(n)
    # Both vertices belong to the same finite vertex type.
    Let u, v: Vertex(n)
    Assume edge: adjacent(G,u,v)
    Conclude: adjacent(G,v,u)
```

`Let n: Natural` is the compact alternative to `Let n be a natural number`.
The [graph module](library/graph_theory.clean) supplies the meaning of `adjacent`.

### Work with functions and predicates

The composition of two continuous real functions is continuous.

```text
Import "../library/analysis.clean"
Import "../library/sources.clean"

Result continuous composition:
    Attribution: mathlib; Continuous.comp; specialized
    # The two type arguments are the domain and codomain.
    Let f, g: Function(Real,Real)
    Assume hf: continuous(f)
    Assume hg: continuous(g)
    Conclude: continuous(compose(f,g))
```

Here `hf` and `hg` name the two hypotheses. Result names can contain spaces;
the current parser requires each assumption name to be a single identifier.

### Define your own mathematical expressions

Definitions can be written directly in Clean and reused by later definitions.
This block is a definitions module rather than a theorem statement.

```text
Import "../library/types.clean"

Define square(x: Real): Real:
    # Equals gives the definition in Clean.
    Equals: x^2
    # The rendering template substitutes the actual argument for {x}.
    Render latex: ({x})^{{2}}

Define squared distance(x: Real, y: Real): Real:
    # Multiword names work in function calls too.
    Equals: square(x-y)
```

The header declares argument types and a return type. `Render latex` is optional;
its doubled braces preserve literal LaTeX braces. Definitions in one file can be
used in another through an explicit `Import`.

### Give an existing Lean definition a readable interface

When a definition already exists in Lean, `Notation` supplies its Clean spelling,
type, and mathematical rendering. This is another standalone definitions module.

```text
Import "../library/types.clean"

Notation cos(x: Real): Real:
    # Means is a Lean expression, using the declared argument x.
    Means: Real.cos x
    Render latex: \cos({x})
```

Use `Define … Equals:` to author an expression in Clean; use `Notation … Means:`
to expose an existing Lean expression. Both typed headers currently need the final
block colon, including the colon after the return type.

### Share a context across several results

State common objects once when presenting a family of related theorems.

```text
Import "../library/linear_algebra.clean"
Import "../library/sources.clean"

Context complex square matrices:
    Let n be a natural number
    Let A, B be complex n×n matrices

    # Both results inherit the declarations above.
    Result determinant product:
        Attribution: mathlib; Matrix.det_mul; specialized
        Conclude: det(A*B) = det(A)*det(B)

    Result determinant transpose:
        Attribution: mathlib; Matrix.det_transpose; specialized
        Conclude: det(transpose(A)) = det(A)
```

LaTeX can repeat the declarations in each result or show the context once and
explicitly say “Using Context (1).” See the [rendering comparison](generated/contexts.pdf).

### Use readable names for algorithms

This statement says that sorting preserves the number of list elements.

```text
Import "../library/algorithms.clean"
Import "../library/sources.clean"
Import "modules/sorting.clean"

Result insertion sort preserves length:
    Attribution: mathlib; List.length_insertionSort; specialized
    Let xs: List(Natural)
    # Here, insertion sort is one function name, including the space.
    Conclude: length(insertion sort(xs)) = length(xs)
```

This example exposes Mathlib's insertion sort. To explore defining the algorithms
in Clean itself, see the proposed [insertion-sort](examples/proposed/insertion-sort.clean)
and [heapsort](examples/proposed/heap-sort.clean) specimens. Their recursive syntax
is not implemented; [sorting examples and proof status](docs/sorting-examples.md)
explains the distinction and the independent Lean comparison-complexity proof.

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

Three [working Clean statements](examples/recent-papers.clean) now use complete [Lean mathematical definitions](CleanPapers/Definitions.lean): magnetic walk profiles, size-specific conductance, and an SDP certificate. See [definitions, domain choices, and reproduction commands](docs/paper-translations.md), [generated Lean](generated/RecentPapers.lean), and the [PDF](generated/recent-papers.pdf). The magnetic forward identity now has a proof; the Cheeger and SDP statements remain typechecked but unproved. Independent Lean checks also verify their translated shapes.

:::

:::llm gpt-6 2026-10-29 role=assisted

## Magnetic matrices: Clean statements with Lean proofs

The [magnetic formalization](studies/magnetic/README.md) proves the forward
walk-profile/Fourier identity for all walk lengths, Hermitian symmetry, and supporting
results. Read the [Clean definitions](studies/magnetic/Statements.clean),
[annotated statements](studies/magnetic/Statements.clean), [Lean proof](studies/magnetic/Reference.lean),
or [PDF](studies/magnetic/generated/magnetic.pdf). The verification also identifies an odd-length
endpoint counterexample to the pinned v1 inverse formula. The study provides five artifacts, from authored statements to generated Lean proofs. Its Clean source imports the placeholder [Common library](library/Common.clean); the Lean files import only Mathlib.

:::

:::llm 2026-10-23 role=assisted

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


:::llm gpt-6 2026-10-30 role=assisted

Named [conditions](docs/conditions.md) now support readable assumption names:

```text
Condition positive(x: Real):
    Holds when: x > 0
    Assumption name: positivity of {x}

# Within a result declaring x and y:
Assume positive(x), positive(y)
```

See the [working example](examples/conditions.clean). Commas inside function arguments
stay inside the expression; commas outside parentheses separate assumptions.
:::
