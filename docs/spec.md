# Clean theorem statements

This document describes the current prototype. The accepted next-language rules allow interleaved top-level imports, parser-state continuation, and reordered fields in top-level `Define` declarations; these are specified in [the language reference](language-reference.md) and are not yet fully implemented. The proposed next language contract is [Clean syntax and semantics draft](language-reference.md); its new syntax is not implemented or yet fully agreed.

All language changes are subject to the [unique-parse and unique-Lean-target acceptance contract](language-change-acceptance.md). This prototype’s existing tests do not establish full conformance.

Clean is a provisional name for an indentation-sensitive mathematical statement language. Version 0.1 prioritizes readable theorem declarations and LaTeX output. Lean output provides a precise interpretation of the statement. Proof authoring is outside this version.

A `.clean` file contains named `Result` or `Theorem` blocks, optionally grouped inside `Context` blocks. Each block has mandatory attribution, introduces its objects and assumptions, and ends with a conclusion. Keywords accept any capitalization; names of mathematical objects remain case-sensitive.

## Example

```text
Result similarity transforms eigenvector:
    Attribution: stewart2001; Theorem 1.10, page 9; adapted; scope: eigenvector part
    Let n be a natural number
    Let A, S be complex n×n matrices
    Let x be a complex n-vector
    Let μ: Complex
    Assume invertibility: det(S) ≠ 0
    Assume nonzero: x ≠ 0
    Assume eigenpair: A*x = μ*x
    Let y = inverse(S)*x
    Conclude:
        y ≠ 0
        and
        (inverse(S)*A*S)*y = μ*y
```

## Layout and names

One declaration occupies one physical line. Tabs are forbidden everywhere. Each block increases indentation by at least two spaces relative to its parent. Sibling clauses align at the same column, and a dedent must return to an established enclosing column. Widths may differ between blocks; two, three, four, or more spaces are valid. Blank lines and full-line `#` comments are allowed. An indented conclusion may span several lines; those lines form one expression, so `and` must appear explicitly. Clean expressions continue automatically inside open parentheses or after a trailing operator. Outside parentheses, a continuation is indented at least two spaces beyond its first physical line; inside a `Conclude:` expression block, aligned expression lines are also allowed. Continuation indentation does not create scope. A complete expression ends at the newline: an operator on the next line alone does not request continuation. No backslash is needed. Blank lines and full-line comments may occur during continuation. Lean `Means` bodies, rendering fields, and metadata remain single-line opaque fields. Semicolon-separated mathematical statements and inline comments remain unsupported. Semicolons are permitted as field separators inside compact attribution clauses.

The leading keyword is case-insensitive: `let`, `Let`, and `LET` are equivalent, as are `Define` and `define`. This rule also applies to `Result`, `Theorem`, `Assume`, `Conclude`, attribution field names, and logical `and`, `or`, `not`. Variable names and notation names are case-sensitive. Type constructor spellings and aliases are registered explicitly; prose type patterns match without regard to case.

Result titles may be English words separated by spaces, for example `Result determinant left swap:`. The Lean identifier is generated as `determinant_left_swap`; the displayed LaTeX title is “determinant left swap.” Capitalization is preserved. Repeated spaces and underscores normalize to a single word separator, and collisions between generated identifiers are errors. Existing underscored titles remain accepted and display as words. Titles are word-based in this version; arbitrary punctuation is not supported. Generated metadata records both `name` (Lean identifier) and `title` (display text).

Object and assumption names remain Unicode identifiers, with underscores allowed. A declaration cannot reuse an earlier name within the same result. Multiple objects may be introduced together; each gets the specified type, rather than forming a collection. Every dimension must already be declared as a natural number, or be a numeral. Universal quantification is implicit in typed object declarations.

## Objects and local definitions

These declarations are equivalent:

```text
Let A, S be a Matrix(n, n, Complex)
Let A, S be Matrices(n, n, Complex)
Let A, S be complex n×n matrices
Let A, S: Matrix(n, n, Complex)
```

They introduce two arbitrary matrices. Similarly, `Let x be a complex n-vector` and `Let x: Vector(n, Complex)` introduce an arbitrary vector.

`Let y = inverse(S)*x` defines a fresh local value. An optional `Define y = inverse(S)*x` spelling is implemented as a revisitable convenience, not a distinct semantic operation. Type expressions on the right side of this definition form are rejected:

```text
Let x = Vector(n, Complex)   # invalid (shown here for explanation)
```

Use `Let x: Vector(n, Complex)` or `Let x be a Vector(n, Complex)` instead. The language does not silently interpret that rejected form as naming a type. Type aliases are introduced by explicit `Type ... Equals:` declarations in imported modules.

Definitions are local to a result and ordered: later clauses may use earlier names. An unannotated numeric literal in a local definition defaults to Natural in this prototype. More sophisticated inference is deferred.

## Assumptions and conclusions

An assumption is a labelled proposition:

```text
Assume nonzero: x ≠ 0
Assume eigenpair: A*x = μ*x
```

`Assume` is not interchangeable with `Let`: it explicitly documents a hypothesis. `Conclude` supplies the proposition asserted under the declared parameters and assumptions. There is exactly one final conclusion per result. Compound conclusions use explicit logical connectives.

Version 0.1 has no proof blocks and therefore no mechanism for introducing arbitrary assumptions inside proofs. Future proof syntax must preserve logical scope.

## Attribution

Every result requires a source and a reference. The compact form is:

```text
Attribution: <source>; <reference> [; <relationship>] [; <field>: <value>]…
```

The brackets denote optional grammar, not literal characters. Examples:

```text
Attribution: mathlib; Matrix.det_mul_left_comm
Attribution: mathlib; Matrix.det_mul_left_comm; direct
Attribution: mathlib; Matrix.det_mul_left_comm; specialized
Attribution: stewart2001; Theorem 1.10, page 9; adapted; scope: eigenvector part
Attribution: stewart2001; Theorem 1.10, page 9; note: "One source; two claims"
```

A bare relationship tag, when supplied, must follow the reference and precede named fields. Supported relationships are `direct`, `specialized`, `adapted`, and `original`. If omitted, the relationship remains **unspecified**; it is not inferred from the source or syntax. Scope is optional too. Named fields such as `scope:`, `changes:`, and `note:` may follow in any order. Duplicate fields, empty fields, unknown bare tags, and repeated attribution clauses are errors. Double-quote values containing semicolons. Escaped double quotes and backslashes are supported inside quoted values; ordinary apostrophes are preserved.

The equivalent expanded block is:

```text
Attribution:
    source: mathlib
    reference: Matrix.det_mul_left_comm
    relationship: specialized
```

`declaration:` and `location:` are accepted aliases for `reference:` in block syntax. Supplying more than one of these fields is an error. Source keys and references retain their case; attribution keywords and relationship tags are case-insensitive.

Shared source metadata is introduced by `Source` declarations in explicitly imported Clean modules, such as `library/sources.clean`. Fields include kind, label, title, author, year, version, revision, and URL. A Lean source names a generated declaration-reference index relative to its module. The validator rejects unknown source keys, unknown indexed Lean declarations, and revision mismatches. Book references are free-text locators; bibliographic accuracy is not automatically checked.

An original result can reference a declared local source of kind `other` and use an internal locator; do not invent a published source. Mathematical provenance and formalization authorship remain distinct. Extra metadata is retained, even when it is not printed.

LaTeX shows a short citation beside each result title, such as `[Mathlib]` or `[Stewart 2001, Theorem 1.10, page 9]`. Mathlib citations link to the specific declaration. Full source information is listed once in `generated/references.tex`. This file lists the explicitly imported sources, including unused entries, so partial builds cannot accidentally remove another fragment's bibliography. Raw paths, revisions, and relationship labels are not repeated under each result. Explicit scope, changes, and notes remain visible as short qualifications; adaptations are marked as such.

Structured output retains both the authored `attribution` and the `resolved_attribution`, including shared source details and the precise declaration URL. The corpus catalog also preserves source excerpts and topics. CLR alignment remains topical; no edition-specific theorem numbers or pages are claimed.

## BibTeX sources

```text
Import BibTeX "references.bib"

Result similarity preserves eigenvectors:
  Attribution: stewart2001; Theorem 1.10, page 9; adapted
  ...
```

`Import BibTeX` imports bibliography metadata only. Paths resolve relative to the containing Clean file; imports precede results and may also appear in imported definition modules. Keywords are case-insensitive. Each BibTeX citation key becomes an attribution source key with its original spelling, including punctuation such as `Stewart:2001`. Clean attribution lookup remains case-sensitive. Existing `Source` declarations remain available.

Install the optional parser with `python3 -m pip install -e '.[bibtex]'`. The importer uses [Pybtex](https://docs.pybtex.org/api/parsing.html) rather than approximating BibTeX with regular expressions. Braced and quoted values, string macros, concatenation, numeric years, author lists, and common LaTeX accents are supported. Source labels default to the citation key. Titles and people become plain text for Clean’s escaped LaTeX output; original fields, entry type, people, filename, and a content digest remain in structured metadata. Unknown TeX commands remain text; preambles are not executed or injected into LaTeX output.

Every imported entry currently requires a title. Book entries map to source kind `book`; other entries map to `other`, retaining their original entry type. URL and DOI fields are preserved. A citation locator such as “Theorem 1.10” is still authored on the result: importing a bibliography does not verify that locator or prove the theorem.

Repeated imports of the same canonical path are idempotent. A duplicate source key from another file or an explicit `Source` declaration is an error, even if the metadata matches. Parsing errors and collisions reject the whole bibliography import. Pybtex also rejects duplicate BibTeX entries and duplicate fields; its duplicate-entry detection is case-insensitive within a bibliography. `crossref` and BibLaTeX `xdata` inheritance are explicitly rejected in this first implementation. Those policies, richer labels, and selective imports can be revisited.

See [the working specimen](../examples/bibtex.clean) and its [bibliography](../examples/bibliography/references.bib).

## Expressions

The initial implementation supports names, natural numerals, parenthesized expressions, imported notation calls, application of declared unary functions, unary minus, and logical negation. Binary operations include arithmetic, equality and comparisons, conjunction, disjunction, implication, equivalence, membership, subset, set union/intersection, and divisibility.

Precedence, from low to high: equivalence; implication; disjunction; conjunction; comparisons/membership; addition/subtraction/set operations; multiplication/division; powers. Powers and implication associate to the right. Use parentheses around chained or mixed comparisons; comparison chains are not supported. Powers bind more tightly than unary minus: `-x^2` means `-(x^2)`. Write `(-x)^2` for the other grouping.

Operand types choose the meaning of `*`: scalar multiplication, matrix–matrix multiplication, or matrix–vector multiplication. Matrix dimensions and fields must agree. `Vector * Vector` is not guessed to mean an inner product; add an explicit declared notation for such operations. Lean performs the final type check. The prototype's local checks are deliberately narrower than Lean elaboration and cannot validate every algebraic structure.

Function names such as `det`, `inverse`, and `continuous` are declared in explicit modules, with typed Lean meanings and LaTeX renderings. The prototype does not parse unrestricted mathematical English, binders such as `for every`, explicit existential quantifiers, summation notation, lambdas, structures, or typeclass assumptions. These are natural next extensions suggested by a broader corpus.

## What is equivalent in Lean

| Clean | Lean interpretation |
| --- | --- |
| `Result determinant left swap:` | Identifier `determinant_left_swap`; LaTeX title “determinant left swap” |
| `Let n: Natural` | Universally quantified parameter `(n : ℕ)` |
| `Let x be a complex n-vector` | `(x : Fin n → ℂ)` |
| `Let A, S be complex n×n matrices` | `(A S : Matrix (Fin n) (Fin n) ℂ)` |
| `Assume h: P` | Named proof parameter `(h : P)` |
| `Let y = expression` | Local `let y := expression` within the statement scope |
| `Conclude Q` | Conclusion `Q` under those parameters, hypotheses, and local definitions |
| `A*x` for matrix A and vector x | `A *ᵥ x` |
| `μ*x` for scalar μ and vector x | `μ • x` |
| `inverse(S)` | `S⁻¹` with the matrix type known |
| `and` | `∧` |
| Attribution | Docstring and structured JSON metadata; not a logical hypothesis |

For example, the proposition underlying the Stewart declaration is:

```lean
∀ (n : ℕ) (A S : Matrix (Fin n) (Fin n) ℂ)
  (x : Fin n → ℂ) (μ : ℂ),
  ∀ (invertibility : S.det ≠ 0) (nonzero : x ≠ 0)
    (eigenpair : A *ᵥ x = μ • x),
  let y := S⁻¹ *ᵥ x
  y ≠ 0 ∧ (S⁻¹ * A * S) *ᵥ y = μ • y
```

The initial translator emits `def result_name : Prop := ...`. This defines the proposition; it does not prove or assume its truth. It emits neither `axiom` nor `sorry`. A theorem proof could later inhabit that proposition. Separate corpus validation fixtures supply proofs by applying the referenced Mathlib lemmas; they are not part of the Clean proof language.

The local `let` remains inside the quantifiers, preserving dependency order. It must not become a new arbitrary parameter. This distinction matters when a later assumption refers to that local value.

## Extensible types and type phrases

All types, aliases, phrases, and function meanings come from explicit Clean imports. The translation environment starts empty. No JSON registry or compatibility loader exists.

```text
Import "modules/square-matrices.clean"
```

That module can contain:

```text
Import "../../library/linear_algebra.clean"

Type SquareMatrix(n: Natural, K: Type):
    Equals: Matrix(n,n,K)

Phrase square complex matrices of order (?P<n>\w+) => SquareMatrix({n},Complex)
```

Aliases normalize before expression checking, so existing operations apply without parser changes. Unknown types, cyclic aliases, and duplicate names fail. New types use `Means`, `Render latex`, and optional `Describe`/`Describe plural` fields. Notations use typed `Let` parameters, `Returns`, a Lean `Means` expression, and either English `Render` or `Render latex`. See [the module specification](notation-prototype.md) for syntax, generics, and limitations.

## LaTeX rendering

Both backends consume the same parsed structure. Each successive `Let` clause becomes a sentence ending in a period, in a single paragraph. We interpret “conjoined with periods” as sentence separation rather than silently merging declarations with “and.” Multiple names declared on one line remain together. Assumptions retain their labels; the conclusion is displayed; a short citation accompanies the title, and any explicit qualifications follow in smaller type.

The default rendering prefers English wherever it describes the mathematical argument. Logical connectives render as “and,” “or,” “if and only if,” “implies,” and “not,” rather than logical symbols. Membership, subset, and divisibility render as “belongs to,” “is a subset of,” and “divides.” Predicates use phrases such as “is continuous,” “is sorted,” and “is adjacent to.” Standard mathematical operations and relations such as multiplication, powers, equality, and inequalities retain their notation.

Typed declarations render as prose, for example “Let n be a natural number” and “Let A and S be n×n matrices over ℂ.” Type declarations support `Describe` and `Describe plural` fields alongside `Render latex`. Extension types without a prose template fall back to “an element of” or “elements of” followed by the type. Both singular and plural declarations are supported. These presentation rules do not change the Lean interpretation.

Build `.clean` files with the Python translator, then use:

```latex
\usepackage{latex/clean}
\CleanInput{corpus/analysis.clean}
```

The supplied package reads the generated `.tex` fragment. It does not parse `.clean` inside TeX or require shell escape. A `.clean` argument resolves to the preprocessed file under `generated/`; it does not trigger preprocessing. A future build-tool integration could run that step automatically. This two-stage design keeps parsing and validation in one place.

## Collection scope

The initial local collection has 20 results each in linear algebra, graph theory, analysis, and CLR-aligned algorithms. They are deliberately approachable specializations, not a representative survey of all of Mathlib. Linear algebra focuses on matrices; graph theory uses finite simple graphs; analysis covers elementary real functions and continuity; algorithms covers sorting and number-theoretic invariants.

Missing stress cases include eigenvalue perturbation, rank/nullity, integrals, quantified convergence, asymptotic complexity, shortest paths, dynamic programming, and algorithm termination. The next corpus expansion should add those shapes rather than only more identities.

## Shared contexts (implemented)

```text
Context complex square matrices:
    Let n: Natural
    Let A, B, C: Matrix(n,n,Complex)
    Result determinant product:
        Attribution: mathlib; Matrix.det_mul; specialized
        Conclude: det(A*B) = det(A)*det(B)
```

Contexts may nest. Put their `Let`, `Define`, and `Assume` clauses before their child results or contexts. Each nesting level adds at least two spaces, with aligned siblings. Inner declarations cannot shadow inherited names. Only needed inherited object declarations and local definitions are retained, including their dependencies; all inherited assumptions are retained. Thus the example's result quantifies over n, A, B, without an unused C.

`\CleanInput[contexts=expanded]{examples/determinants.clean}` repeats required declarations and all inherited assumptions within each result. This is the default. `contexts=referenced` prints numbered contexts and explicitly states “Using Context (1)” in each affected result. Nested contexts cite their ancestors. Both modes have the same Lean meaning. See `latex/contexts.tex` and `generated/contexts.pdf`. Parameterized assumption-set templates are not implemented.

## Definitions modules

Explicit modules now supply all mathematical names and bibliographic sources. The JSON registry and associated loaders/CLI flags have been removed. Lean checks generated typed wrappers for the declared meanings. See [the module specification](notation-prototype.md) and `library/` for the complete migration and known limits. The core expression grammar still supplies standard operators; importing notation does not implement a new algorithm or prove its properties.

## Semantic authority (agreed direction)

All mathematical meanings should be declared in modules, including operator overloads and numeral interpretation. The compiler must not assign mathematical behavior based on names such as `Natural`, `Matrix`, or `Vector`. Generic parsing and binding machinery resolves imported declarations; Lean supplies semantic type checking. See the final section of [the module specification](notation-prototype.md) for the architectural boundary and outstanding migration. The current name-based checks and operator dispatch described above are prototype behavior, not the target architecture.

## Paper definition modules

The [paper translation specimens](paper-translations.md) use the existing module syntax to expose fully defined Lean operations for walk profiles, graph conductance and its spectral optimization problem, and SDP certificates. Their working Clean source uses named operations where the proposed general binder syntax is not yet implemented. Top-level `Define` is now implemented for the bounded slice below; the paper optimization definitions still need binders. The three generated propositions and independent statement-shape checks compile; proofs of the three main results are separate work.

### Long expression example

```text
Import "../library/linear_algebra.clean"
Import "../library/sources.clean"

Result determinant transpose:
  Attribution: mathlib; Matrix.det_transpose
  Let n: Natural
  Let A: Matrix(n,n,Complex)
  Let B = transpose(
      A
  )
  Conclude: det(B) =
    det(A)
```

New clauses cannot supply missing operands for an unfinished expression. Errors identify physical source lines; a continued expression is attached to its first line.

## Authored definitions: current implementation slice

`Define` is available in definition modules and in a document prelude. It shares
call resolution with `Notation`, and does not require a new registry or a Lean
implementation body:

```text
Define squared distance(x, y):
  Returns: Real
  Let x, y be Real
  Equals:
    square(x-y)
```

Imports must first supply `Real` and `square`. Parameters retain their source
order; all nonparameter fields may move. `Returns` and exactly one of `Equals`
or `From Lean` are required. Grouped parameters and `be` work in both `Define`
and `Notation`. Definitions can return propositions as well as values.
`Equals` accepts an inline expression or an aligned explicit expression block;
`From Lean` currently accepts an inline Lean term only. Its specified block form
is still unimplemented and rejected. Definition attribution is optional, compact,
and resolved against explicit sources. Expanded attribution is not implemented
here. Rendering is optional and defaults to the English name applied to arguments.
There is no standalone LaTeX rendering of definition declarations yet.

The compiler collects fields, resolves parameter types in order, resolves the
return type in the complete parameter scope, and translates the body in that same
scope. It installs the callable name only afterward. Forward references and
recursion are rejected. Existing implicit dimension/type inference restrictions
from `Notation` still apply. Mathematical operator dispatch and literal inference
remain prototype debt; this feature does not add new name-based dispatch.

A fixed declaration header and field labels determine one declaration structure.
Exactly one implementation field selects the lexical mode; field order never
selects meaning. An `Equals` block is delimited by its indentation and contains
one expression under the existing precedence grammar. Its tree translates
constructively by the existing expression rules into a typed, noncomputable Lean
`def`; calls refer to earlier generated declaration identities. Lean elaborates
the entire telescope, result, and body. This gives a deterministic prototype
translation, **not yet a proof of global canonical-target uniqueness**: the
existing inference/overload and module-scope gaps still apply.

`verify_definitions.py` checks independent expression trees for square, matrix
square, and commutator and generates exact elaborated Lean body/type comparisons.
These preserve binder explicitness, universe and instance arguments, and proof
terms; only metadata and binder display names are erased. Comparator guards
reject an implicit/explicit binder change and a beta-reducible alternative.
Full declaration AST checks and ambiguous/incomplete-elaboration checks remain
pending in the acceptance catalog. See [porting findings](porting-findings.md).

### Readable generated Lean identifiers

Type, notation, and authored-definition wrappers use
`cleanType_<stem>_<id>`, `cleanNotation_<stem>_<id>`, and
`cleanDefine_<stem>_<id>`. The stem preserves ASCII letters, digits, underscores,
and case; each space becomes `_`. Every other character becomes `_u<hex>_`, with
its lowercase Unicode code point and no leading zero padding, so the resulting
identifier is safe ASCII (for example `μ` becomes `_u3bc_`).
The identifier suffix retains the existing first 20 lowercase hexadecimal digits
of SHA-256 over UTF-8 `name + body`, using the resolved authored name and emitted
Lean signature/body passed to wrapper generation. This is deterministic, with no
randomness or import-order counters. Spaces and underscores can share a stem but
the original name participates in the fingerprint. A generated identifier already
present in the same environment is rejected rather than overwritten.

For example, `Define squared distance(x, y)` emits a wrapper beginning
`cleanDefine_squared_distance_`; `Type Real()` emits `cleanType_Real_` followed by
its fingerprint. Calls use the complete generated identifier. This changes target
constant names only, not Clean grammar, scope, or mathematical bodies. Existing
result names such as `determinant_product` are unchanged. Fingerprints are build
identifiers, not permanent public API names; changing a body or a referenced
wrapper identity can change the suffix. The structural target checks still apply
and do not treat arbitrary unfolding as an acceptable renaming.
