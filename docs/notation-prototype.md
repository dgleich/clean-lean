# Explicit definitions modules

The earlier compatibility prototype is superseded. The JSON registry, its generator, extension JSON, source sidecar, project import sidecar, and their CLI flags have been deleted. `Environment()` starts with no types, functions, phrases, aliases, sources, or imports. The environment is only an internal symbol table populated from authored module declarations.

## Imports and meanings

Imports are relative to the importing file and precede results. Modules can import other modules. Cycles and duplicate visible definitions fail; repeated imports of the same file are deduplicated. Each CLI input gets an isolated environment. Conflicting definitions across combined CLI outputs fail too.

```text
Import "../../library/types.clean"
Import Lean Mathlib.Data.List.Sort

Notation insertion sort(xs):
    Let xs: List(Natural)
    Returns: List(Natural)
    Means: List.insertionSort (· ≤ ·) xs
    Render: insertion sort of {xs}
```

`Means` is a Lean expression using the declared binders, not a text substitution template. Each notation emits a typed Lean wrapper. Those wrappers are `noncomputable def` because mathematical expressions may use operations with no executable code, such as real logarithm. This does not introduce axioms or prove result statements. Running Lean checks the signature and meaning; the Python `check` command alone does not.

Multiword names use explicit parentheses. Ordinary names are case-sensitive; declaration keywords and field labels are case-insensitive. `Render` escapes literal English for LaTeX and substitutes named arguments. `Render latex` permits authored TeX with named placeholders; literal braces must be doubled. Specify exactly one rendering form.

Implicit type and dimension parameters are declared before call arguments and must occur in argument types so they can be inferred:

```text
Notation length(xs):
    Let T: Type
    Let xs: List(T)
    Returns: Natural
    Means: List.length xs
    Render latex: \lvert {xs}\rvert
```

## Types and phrases

Types are explicit declarations too. `Natural` and `Type` in parameter-kind positions describe dimension and type parameters; they do not implicitly import any document-level vocabulary.

```text
Type Vector(n: Natural, K: Type):
    Means: Fin n → K
    Render latex: {K}^{{{n}}}
    Describe: a vector of length ${n}$ over ${K}$
    Describe plural: ${n}$-vectors over ${K}$

Type SquareMatrix(n: Natural, K: Type):
    Equals: Matrix(n,n,K)

Alias Matrices: Matrix
Phrase complex (?P<n>\w+)-vectors? => Vector({n},Complex)
```

`Means` type expressions get independent Lean checking definitions; `Equals` aliases normalize to an already introduced Clean type. Type declarations must precede their use. `Describe` fields control English type descriptions. Phrases use explicit regular-expression patterns with named captures; this syntax is provisional, not unrestricted natural-language parsing.

Types currently inhabit `Type`, with `Proposition` represented by Lean's `Prop`. Universe-polymorphic declarations and typeclass binders are future work. Matrix operations in the migrated library specialize to complex scalars, and function composition to real functions. Lists retain generic element types; matrices and graphs retain symbolic dimensions.

## Sources

Bibliography metadata also comes from imports:

```text
Source stewart2001:
    Kind: book
    Label: Stewart 2001
    Author: G. W. Stewart
    Title: Matrix Algorithms, Volume II: Eigensystems
    Year: 2001
    Publisher: SIAM
```

Lean sources can name a `References` file relative to their module. The corpus reference index is generated provenance (declaration locations and revisions), not a function/type registry. It does not define mathematical meaning.

## Verification and remaining work

All 80 Python tests pass, including empty-environment and removed-option checks. The 80 corpus proof fixtures and the explicit notation proof are checked against generated wrappers. The generators are `verify_corpus.py` and `verify_notation.py`.

Imported modules contain declarations only; result imports, qualified names, selective exports, overloading, richer dependent types, automatic printed definition sections, and source spans for generated Lean errors remain future work. `Means` and raw TeX are trusted author input. Dependencies use the existing Lean/Lake pins; there is no extra package manager.

Historical Git commits retain the initial syntax sketch, compatibility implementation, failing proof check, and its repair. The subsequent removal commit intentionally records the migration before tests and generated outputs were updated.
