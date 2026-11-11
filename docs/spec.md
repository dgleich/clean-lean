:::llm 2026-10-23 role=assisted

# Clean theorem statements

:::llm gpt-6 2026-11-07 role=assisted

Implementation update: [operators and numerals are now integrated into the working compiler](operator-numeral-integration.md). Earlier isolated-status descriptions below describe the development stages. The curated subject libraries now explicitly import their operators and numeral default. Broader library/test migration and full language-contract conformance remain unfinished.
:::


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

One declaration occupies one physical line. Tabs are forbidden everywhere. Each block increases indentation by at least two spaces relative to its parent. Sibling clauses align at the same column, and a dedent must return to an established enclosing column. Widths may differ between blocks; two, three, four, or more spaces are valid. Blank lines and full-line `--` comments are allowed. An indented conclusion may span several lines; those lines form one expression, so `and` must appear explicitly. Clean expressions continue automatically inside open parentheses or after a trailing operator. Outside parentheses, a continuation is indented at least two spaces beyond its first physical line; inside a `Conclude:` expression block, aligned expression lines are also allowed. Continuation indentation does not create scope. A complete expression ends at the newline: an operator on the next line alone does not request continuation. No backslash is needed. Blank lines and full-line comments may occur during continuation. Lean `Means` bodies, rendering fields, and metadata remain single-line opaque fields. Semicolon-separated mathematical statements remain unsupported. Comments follow the lexical rules below. Semicolons are permitted as field separators inside compact attribution clauses.

The leading keyword is case-insensitive: `let`, `Let`, and `LET` are equivalent, as are `Define` and `define`. This rule also applies to `Result`, `Theorem`, `Assume`, `Conclude`, attribution field names, and logical `and`, `or`, `not`. Variable names and notation names are case-sensitive. Type constructor spellings and aliases are registered explicitly; prose type patterns match without regard to case.

Result titles may be English words separated by spaces, for example `Result determinant left swap:`. The Lean identifier is generated as `determinant_left_swap`; the displayed LaTeX title is “determinant left swap.” Capitalization is preserved. Repeated spaces and underscores normalize to a single word separator, and collisions between generated identifiers are errors. Existing underscored titles remain accepted and display as words. Titles are word-based in this version; arbitrary punctuation is not supported. Generated metadata records both `name` (Lean identifier) and `title` (display text).

Object names remain Unicode identifiers. Assumption labels may contain identifier words; declared conditions can supply automatic labels. A declaration cannot reuse an earlier name within the same result. Multiple objects may be introduced together; each gets the specified type, rather than forming a collection. Every dimension must already be declared as a natural number, or be a numeral. Universal quantification is implicit in typed object declarations.

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

An assumption asserts a condition. Explicit labels remain supported:

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

`Import BibTeX` imports bibliography metadata only. Paths resolve relative to the containing Clean file; imports may appear between top-level results and may also appear in imported definition modules. Sources become available only to subsequent statements. Keywords are case-insensitive. Each BibTeX citation key becomes an attribution source key with its original spelling, including punctuation such as `Stewart:2001`. Clean attribution lookup remains case-sensitive. Existing `Source` declarations remain available.

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
square, and commutator plus the compact cosine signature, and generates exact elaborated Lean body/type comparisons.
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

### Compact signatures

Both `Notation` and `Define` accept typed headers as an alternative:

```text
Notation cos(x0: Real): Real:
  Means: Real.cos x0
  Render latex: \cos({x0})

Define squared distance(x: Real, y: Real): Real:
  Equals: square(x-y)
```

These normalize to the existing name-only header plus typed `Let` clauses and
`Returns`. No body `Let` or `Returns` is allowed in the compact form. All header
parameters must be individually typed; grouped names, partial annotations, and
`::` are rejected. The last colon opens the block. Nested type constructors and
parenthesized continuation are supported. Use the expanded form for implicit
parameters. See the [formal rule](language-reference.md#compact-declaration-signatures-implemented).
The analysis module now provides compact `cos`, `square`, and `squared distance`
examples. Equivalent forms produce identical wrapper names and Lean text;
independent normalized signature/body-tree checks and four canonical Lean-target
checks cover the bounded fixtures. General language conformance remains pending.


:::

:::llm gpt-6 2026-10-29 role=assisted

## Typed function expressions

The bounded `function(x: T, expression)` form is implemented. Its grammar, scope,
hygiene, constructive translation, and acceptance limits are specified in
[function expressions](function-expressions.md). It supplies a lambda to ordinary
module-declared operations; it does not add special sum, map, or filter semantics.


:::llm gpt-6 2026-10-30 role=assisted

## Conditions and assumption lists

Top-level `Condition` declarations and comma-separated `Assume` lists are implemented.
The normative [condition contract](conditions.md) and [executable grammar](../grammar/clean.lark)
specify fixed condition results, `Holds when`, imported `From Lean` bodies, name templates,
continuation, collision checks, and the unique expansion into ordered Lean hypotheses.
The grammar now generates the parser; see [generation and checking](generated-parser.md).
:::

:::llm gpt-6 2026-11-05 role=assisted

## Comment lexing (implemented)

Before continuation or layout processing, scan physical lines left to right, with
an initially empty block stack. Tabs remain errors everywhere, including comments.
Outside quoted text and opaque fields, reserve the pairs `--`, `/-`, and `-/`
before mathematical token recognition, with no surrounding-space requirement.
`--` consumes the rest of the physical line, including any apparent block markers.
`/-` pushes a block opener; inside a block only `/-` (push) and `-/` (pop) have
special meaning. Other text, including quotes and `--`, is ignored there.
An unmatched `-/` or a nonempty stack at EOF is an error with its physical line.
After the outermost closer, ordinary scanning resumes immediately on the same line.
`/--` and `/-!` now select documentation at physical-line boundaries, as specified
in [literate text](literate-text.md); they are not ordinary discarded comments.

Outside comments, double quotes pair within each physical line, protecting comment
markers; there is no backslash escape convention. At the start of a logical field
on a physical line (preceded only by spaces or masked comments), `Means:`,
`From Lean:`, `Render:`, and `Render latex:` select an opaque payload through the
end of that line. Its characters are left to the embedded language, including
comment markers and quotes. Put Clean comments about these fields on separate
lines. Other fields, including attribution, support comments.

```clean
Let x: Real -- the variable used below
Let y: /- another scalar -/ Real
/- An explanation spanning lines.
   /- A nested explanation. -/
   Continue here. -/
Assume positive(x), positive(y) -- two named assumptions
```

Each comment character becomes an ASCII space; every newline is preserved.
This prevents token concatenation and retains physical line and column positions.
Layout and continuation run on this masked text: a block's newline does not itself
request continuation, and code after a leading block is indented at its actual
column. Prefer leading explanations on their own lines when introducing clauses.
For example, `Let x:/- note` followed by `-/ Real` does not silently join the lines;
write a single-line block or use an otherwise permitted expression continuation.
Blank masked lines have no layout effect.

Write subtraction followed by negation as `x - -y` or `x - (-y)`; `x--y` starts a
comment. A division followed by a negative operand similarly needs separation:
`x / -y` or `x / (-y)`. Reserved comment pairs cannot be redefined by imports.
`#`, `#=`, `=#`, and `%` have no comment meaning; mathematical support for these
symbols is a separate notation feature, not supplied by this change.

This deterministic scan has no mathematical AST constructor and no Lean term:
the parse and fully elaborated target are exactly those of the masked source
under the same explicit environment. The generated grammar consumes that masked
source; no parser-table change is required. Its uniqueness obligations are
unchanged by comment text.

:::

:::llm gpt-6 2026-11-05 role=assisted

## Literate text (implemented first slice)

`Text:`, tagged `Text latex:` / `Text typst:`, and equivalent triple-quoted blocks
carry published prose. Lean-style `/-! … -/` is free prose; `/-- … -/` attaches to
a declaration. There is no `Section:` declaration: headings belong inside prose.
The [normative contract](literate-text.md) defines exact delimiters, placement,
attachment, erasure to mathematical Lean terms, and current rendering limits.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Nested quantified conditions

The implemented forms `for every (x: T, P)` and `there exists (x: T, P)`
introduce a typed local scoped to the parenthesized condition. See the
[quantifier contract](quantifiers.md) for grammar, reservations, binding,
Lean targets, universe limits, and acceptance checks. Type-valued theorem
parameters require the explicit foundational `Type() -> Type` binding.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Named value indices in types

Constructor syntax remains `Name(argument,...)`. Type declarations may now use
ordered value parameters, such as `Type Element(X: Type, S: Set(X)):`.
Previously declared names can supply those indices in theorem binders and
quantifier domains. See [named value indices](value-indexed-types.md) for the
neutral parse tree, typing and Lean map, prose normalization, and explicit limits.
Dependent callable signatures follow the later section below; no type-checked reinterpretation
of an ambiguous parse is permitted.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Dependent callable signatures

[Dependent calls](dependent-calls.md) extend existing Notation, Define, and
Condition declarations to named value-indexed argument/result types. There is no
new surface syntax. Parameter types match structurally; actual named indices are
substituted into the result; generated calls explicitly pass all inferred type and
dimension parameters. Computed indices must first be bound with Let. The first
checked wrappers expose subtype values, constant/reversed paths, and path composition.
General expression indices, Pi-valued functions and universes remain pending.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Authored structures and field references

[Structures](structures.md) specifies `Structure Name(parameters):`, typed Let
fields, an explicit `Constructor: readable name`, and scoped access `P.field`.
Fields may depend on earlier fields. Constructor calls pass header parameters and
fields in order. Field-valued functions support `P.map(x)`. Stable field references
can be dependent type arguments and natural dimensions. No proof fields, carrier-type
fields, recursive records, inheritance or implicit coercions are included yet.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Fixed universes for imported bundles

`Universe: n` on an imported Type or authored Structure fixes its Lean result sort.
See [fixed universes](fixed-universes.md) for the grammar, default normalization,
translation and acceptance checks. TopCat spaces and continuous maps now have an
explicit Clean module, with authored diagrams and five verified statements.
General universe polymorphism and carrier-type record fields remain pending.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Explicit computed indices

[Computed indices](computed-indices.md) extends a value/dimension argument with
an explicitly parenthesized, binder-free expression. It also permits compound
actual value arguments in dependent calls. Substitution works on expression trees;
matching remains structural, with no local-alias unfolding or inversion of
computations. This supersedes the earlier requirement to name every computed
index first. Type-valued arguments remain named carriers.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Explicit evidence and certified records

[Evidence](evidence.md) specifies parenthesized conditions in type position,
ordinary `Evidence` aliases, proof-bearing record fields, and single-identifier
assumption labels usable as explicit proof arguments. This supersedes the earlier
exclusion of proof fields. Matching is structural; direct binder-bearing evidence
requires a named Condition. No implicit proof search or general Sort parameters
are introduced. Certified subset and continuous pair inclusions exercise this map.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Computed record projection

[Computed records](computed-records.md) supersedes the named-base-only restriction.
It specifies constructor-field reduction and explicit, binder-free authored
producer unfolding; other computations retain nominal projections. LaTeX preserves
the authored expression and is excluded from semantic index identity. The interlevel
certificate composition now works in Clean. Implicit/binder-bearing producer
reduction and local-alias conversion remain separate extensions.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Authored definition conversion

[Definition conversion](definition-conversion.md) now permits typed dependent
indices to match eligible binder-free authored expansions. It supersedes the
blanket structural-only rule for those indices. Emitted Lean terms and source
annotations retain their prescribed wrappers; comparison does not rewrite them.
Native adapters, local aliases and the documented ineligible bodies stay opaque.
The relative-map study exercises this rule with named source/target objects and
explicit commutativity evidence, checked against independent native targets.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Immediately applied functions in indices

[Applied-function indices](applied-function-indices.md) permits checked immediate
lambda contraction during dependent index construction when body and argument
are binder-free. Original call arguments remain in emitted Lean; index annotations
use the prescribed contraction. This resolves generic congrArg on record-field
functions without admitting bare lambdas, quantifiers or general local-alias conversion.
There is no grammar change or implicit proof search.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Automatic names for structural condition arguments

[Condition naming](conditions.md#structural-arguments-in-automatic-labels) now
covers projections, field applications and nested quantified arguments. The label
is a deterministic spelling of the elaborated expression's normalized source tree;
existing punctuation encoding and collision rejection are unchanged. No new syntax
or implicit hypothesis is introduced. Native statement checks and independent
binder-name tests cover compactness of P.space.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Local definitions in dependent indices

[Local definition conversion](local-definition-conversion.md) now saves checked,
binder-free comparison values for local definitions. It supersedes the earlier
blanket local-alias restriction. Emitted Lean lets, authored names and inferred
annotations are preserved; ordinary variables and assumed equalities remain opaque.
The relative-homology specimen checks two exact native propositions and two proofs.
Binder-bearing local definitions and general dependent functions remain open.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Typed dimensions

[Dimension indices](dimension-indices.md) migrates declared Natural slots to the
same checked value-index comparison and substitution mechanism. Local dimension
aliases now work; calls explicitly supply their inferred dimensions. Repeated
consistent inference uses the last occurrence in declared traversal order.
Five canonical targets and four proofs cover readable examples. Generic dependent
functions, broader literal inference and the topology research obligations remain open.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Dependent function type staging and graded objects

[Dependent function types](dependent-function-types.md) specifies the selected
bound-domain form and its intended scope, alpha-equivalence and Lean mapping.
The initial semantic implementation now supports bound value domains, alpha-equivalent
types, capture-free substitution, dependent application/lambda inference and graded
map fields. The study includes eleven exact native graded-map targets and three
proofs. Inference rejects any bound local escaping into a free implicit argument.
Type-valued binders remain unsupported; the contract records the remaining proof,
universe and naming acceptance cases. The earlier ordinary-function graded objects
still have seven canonical targets and their component proof.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Applied producer fields and induced graded homology

[Hygienic producer conversion](hygienic-producer-conversion.md) extends comparison
through explicit authored function-producing definitions and applied fields.
Capture-free substitution includes type annotations and nested binders. Residual
binder-bearing comparison values and shadowed module bindings stay opaque.
Computed-object field calls now serialize using the existing grammar.
The induced graded-homology map is authored in Clean, with four exact native targets
and three functor-law/component proofs. General higher-order conversion, inferred
body parameters, and unapplied family comparison remain outside this profile.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Proof-valued function sorts

[Proof-valued functions](proof-valued-functions.md) extends the explicit arrow
interface to proof operands in both ordinary and bound forms. Proof-sort checking
now follows the codomain of ordinary/dependent arrows, and every Type-parameter
gate rejects these proof families. No lift or general native-sort inference is added.
Ten exact targets, five native sort assertions and five proofs cover finite,
empty/singleton, proof-domain and higher-universe domain examples. General universe
inference and Type-valued binders remain outside the current profile.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Closed universe parameter and field bounds

[Closed-universe checking](closed-universe-checking.md) now enforces the declared
Type 0 carrier bounds in constructor arguments and both callable inference paths.
It computes closed imax levels for ordinary/dependent arrows from declared metadata.
Structures check their fields against the stated result universe before publication.
No target, lift or universe is chosen implicitly. The formerly accepted module-carrier
counterexample is rejected by Clean. Fourteen exact native targets, four sort checks
and three proofs cover supported higher-universe values, arrows and proof fields.
General universe polymorphism and Type-valued binders remain separate work.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Authored families in dependent indices

[Family index comparison](family-index-comparison.md) now materializes a residual
binder-bearing normal tree in one checked scope for its comparison key. Authored
family aliases can agree without changing emitted names or introducing direct
binder syntax in indices. Native bodies, binder-body normalization and general
higher-order conversion remain outside this rule. The graded relative-homology
study checks ten exact targets and five proofs; its constructions are authored in
Clean over generic chain-homology adapters.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Stable saved family keys

[Scoped family keys](scoped-family-keys.md) replaces residual binder-template
comparison with immutable owned/free identity tokens. A private, globally fresh
comparison pool covers expression and dependent type binders; nested comparisons
preserve external binding references and restore allocation context on failure.
Unrelated later locals no longer invalidate saved family indices. Emitted Lean and
existing conversion boundaries remain unchanged. Two exact saved-map propositions
and two proofs cover graded chain and relative homology.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Constant dependent arrows and zigzag bases

[Constant dependent arrows](constant-dependent-arrows.md) specifies symmetric
comparison and callable matching when a checked dependent codomain becomes
constant, while retaining the declared Lean Pi binder. Opaque binder-bearing
producer projections retain their checked form unless a field can be selected.
The [zigzag study](../studies/zigzag-bases/README.md) supplies actual module
diagrams and interval-basis data, with a constructed constant-zigzag example.
Inferred type-parameter helpers avoid new type-as-value syntax. General pyramid
basis extension, higher-order conversion and universe polymorphism remain pending.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Diagram maps use existing syntax

The [diagram-map study](../studies/diagram-maps/README.md) authors a dependent
vertex-map family, its edge-square commutation condition, and certified identity
and composition records. No grammar, inference or emission rule changed. The
existing constructor/projection reduction rule selects component families from
explicit certified producers; exact native oracles preserve that target choice.
Evidence is explicit, with universal identity/composition conditions proved in
Lean. Fifteen exact targets and six proofs cover this interface; it is not an
automatically generated category instance or a pyramid construction.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Shape maps and explicit endpoint transport

The [shape-pullback study](../studies/shape-pullbacks/README.md) uses existing
dependent proof fields, equality adapters and module-declared calls. Shape identity,
composition and diagram reindexing are authored in Clean; the only new native
primitives are Eq.symm, Eq.trans and module-family transport via Mathlib eqToHom.
No grammar, inference or emission rule changed. Twenty-four independent exact
targets and nine proofs cover the interface, including pullback composition.

Short calls infer Type parameters but keep field/shape values explicit. They
retain the existing inferred-body opacity boundary: projected modules from short
and explicit forms may compare differently as computed Clean indices, even when
Lean reduces them to the same module. A negative regression records this open
conversion gap. Arbitrary shape pullbacks do not preserve interval support; actual
subpath restriction needs a chosen inclusion and explicit label reindexing.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Checked inferred arguments in authored conversion

[Inferred-argument conversion](inferred-argument-conversion.md) specifies how
already selected implicit arguments enter hygienic comparison expansion. Named
Type values, type annotations (including dependent types), and natural dimensions
have deterministic source reification. Emitted calls retain the signature
matcher's selected arguments. Compound types used as values remain opaque; this
is not a new type-expression syntax. Native acceptance and full regression status
are recorded in the inferred-conversion study.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Explicit type expressions

[Type expressions](type-expressions.md) adds `type(T)` as a case-insensitive
expression atom containing existing type syntax, with one TypeValue tree and the
resolved Type 0 Lean target. `type` is reserved in expression names. The explicit
foundational Type binding moves into the shared types module. Hygienic substitution,
owned binder comparison, automatic condition naming and editor highlighting cover
the new node. Local type definitions and arbitrary computed types remain rejected.
The earlier compound-type-as-value opacity boundary is superseded; full validation
status is recorded in the type-expression study.
:::


:::llm gpt-6 2026-11-07 role=assisted

## Callable evidence and scoped condition indices

The implemented [callable-evidence contract](callable-evidence.md) specifies how
an identifier-labelled assumption of a universal condition or implication can
be called with existing expression syntax. The selected proof term is applied
directly; no replacement evidence or cast is generated. Named authored conditions
may expose their function type through the specified hygienic conversion rule.
Opaque native condition bodies remain opaque.

Condition-valued type arguments retain scoped binder syntax, allowing the ordinary
Evidence alias to accept universal conditions. Other computed indices retain their
binder restriction. Captured proof locals cannot be rebound implicitly. Known
function types compare recursively under fresh binders, including nested proof
families. A callable local takes precedence over a same-named module callable;
a local arity or type error does not select the module callable instead.

The [study](../studies/callable-evidence/README.md) records validation and remaining
gates. This prototype's integration is not a completed conformance claim.
:::

:::llm gpt-6 2026-11-07 role=assisted

Comparison of a checked producer projection now first selects the requested field
through authored Equals wrappers, before normalizing sibling constructor fields.
The ordered selection, inference reuse, type gates and opacity rules are specified
in [hygienic conversion](hygienic-producer-conversion.md#selecting-producer-fields-before-sibling-normalization).
Source parsing and emitted projection terms are unchanged. This is an implemented
prototype with broad regression validation pending.
:::

:::llm gpt-6 2026-11-07 role=assisted

The [module-operator migration draft](module-operators.md) proposes Infix metadata
on existing Notation/Define declarations. Its parser and binder are exercised in
an isolated patch, not enabled syntax. Literal policy, the wider dependent-overload audit,
declared fixity and module scope remain integration gates; existing main-compiler
operator dispatch is not presented as the completed architecture.
:::

:::llm gpt-6 2026-11-07 role=assisted

For dependent function matching with all implicit parameters determined, compare
instantiated codomains as caller-scoped known types, without applying declaration
substitution twice. The constructive rule and remaining inference boundary are
in [callable evidence](callable-evidence.md#comparing-instantiated-dependent-codomains).
Parsing and emitted application arguments are unchanged.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Postfix application

[Postfix application and field selection](postfix-applications.md) specifies the
left-to-right suffix fold, the syntax-only multiword-reference guard, existing
Call versus Apply normalization, known-function application and proof-index
spelling. The implemented generated grammar accepts `f(x)(y)` and interleaved
field selections. This preserves existing named-call trees and introduces no
inferred currying or overload policy. Focused acceptance passes; broad validation
and general conformance remain pending.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Transparent alias prose

`Type … Equals:` now accepts optional `Describe` and `Describe plural` fields.
These customize typed `Let` prose while preserving the expanded semantic type
and exact Lean target. Only the outer authored alias supplies wording; missing
forms fall back to the expanded type. Context pruning never retains mathematical
parameters merely for prose. See the [alias description contract](alias-descriptions.md)
for deterministic instantiation, scope, fallback and acceptance boundaries.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Beta comparison inside proof conditions

Proof-condition comparison now contracts checked immediate lambda applications
inside quantified conditions, using hygienic substitution even when bodies or
arguments contain binders. It preserves emitted terms and does not reduce inside
unapplied lambda bodies. The ordinary computed-index rule is unchanged. The
[proof beta contract](proof-beta-comparison.md) specifies traversal, scope, exact
native targets and remaining checks; it supersedes earlier blanket statements
that all quantified bodies remain opaque to beta comparison.
:::

:::llm gpt-6 2026-11-07 role=assisted

Dependent callable inference obeys the
[declaration-scoped matching rule](source-pattern-matching.md). Original expected
patterns retain declaration scope throughout recursive matching; caller arguments
are substituted simultaneously only at comparison leaves. This prevents capture
while later implicit parameters remain uninferred, without changing grammar or
ordered Lean argument emission.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Sequential root declarations and imports

Root imports and declarations may occur between results or Context blocks. Each
block retains the Clean environment visible at its position; later imports cannot
supply earlier missing Clean names or attribution sources. Lean/LaTeX statement
rendering uses that snapshot. The complete rule, native-import limitation and exact
acceptance evidence are in [sequential-scope.md](sequential-scope.md). No nested
imports or module-owned native scopes are introduced by this change.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Outstanding local type identity failure

The [type-identity study](../studies/type-identity/README.md) records a failure
of the unique-target requirement: a local type named Real currently becomes the
module's real-number type during rendering. Local references must resolve before
module aliases, retain their binding identity, and remain distinct from module
types during substitution. These requirements are not yet implemented throughout
the compiler. The study's acceptance gates intentionally fail; compiling the
generated Lean statement does not establish that its meaning was preserved.
:::

:::llm gpt-6 2026-11-07 role=assisted

The [isolated local-type repair](../studies/type-identity/Prototype.md) distinguishes
local carrier references from module types, stores checked alias bodies and
parameter telescopes, and preserves those distinctions through substitution,
annotation reification and rendering. It changes no source grammar. Main remains
unrepaired; native adapter scope, operator composition and broader identity
conformance remain open.
:::

:::llm gpt-6 2026-11-07 role=assisted

The [native type binding experiment](../studies/native-type-bindings/README.md)
emits root-qualified references to declaration-scoped reducible abbreviations
instead of copying opaque type bodies into caller scopes. The declared structural
arrow interface remains structural, including proof-valued arguments. This is an
isolated change to the specified Lean target, not a source grammar change or a
claim that earlier inline-type oracles still pass.
:::

:::llm gpt-6 2026-11-07 role=assisted

The subsequent [qualified-global experiment](../studies/qualified-globals/README.md)
extends absolute native references to generated callables, record types,
constructors and projections. Local applications remain local. It checks both
authored bodies and theorem uses against deliberate generated-name collisions;
source grammar is unchanged and main integration remains pending.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Compose operator selection with binding identity

The isolated [operator integration study](../studies/operator-integration/README.md)
combines declared operators with the seven binding repairs. A concrete module type
cannot match a same-spelled local carrier. Known sort mismatches reject only the
candidate; incomplete checks and foreign dependent mismatches propagate. Selection
requires exactly one applicable declaration, independent of candidate order.
Retained ModuleCalls keep their selected root-qualified target and presentation.
The neutral grammar still determines the parse before candidate checking.
Twenty-six exact targets and four proofs cover this slice. Production integration,
explicit foundation migration, numeric literals and broader operator/corpus
oracles remain pending; earlier built-in regression counts do not apply here.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Integrate binding repairs

The working compiler now implements the seven repairs through qualified globals.
[Binding integration](binding-integration.md) records their constructive rules and
validation boundaries: carrier-field type projections, retained module/proof calls,
semantic annotations, distinct local type parameters, checked alias bodies,
declaration-scoped native type abbreviations and root-qualified generated globals.
These supersede earlier statements above that the repairs are only isolated.
Canonical target changes require explicit oracle migration. Declared operators
and numeric-literal policy remain separate, unfinished integration work. Full
regression/study validation and general identity/import isolation remain open.
:::

:::llm gpt-6 2026-11-07 role=assisted

The [module numeral draft](module-numerals.md) proposes a carrier-owned Numerals
adapter and explicitly typed integer atoms as a first migration step. It is not
accepted as conforming. Its isolated study now checks the grammar, ASCII validation and declaration-owned
native adapters and explicitly annotated applications. Bound numeral atoms retain
the selected identity through substitution and comparison; the draft specifies
the consumer and rendering rules. Full integration and complete native isolation
remain pending, as does broader type-position numeral inference; defaults have
an isolated prototype below. The historical display-name-based
Natural default is not the final architecture.
:::

:::llm gpt-6 2026-11-07 role=assisted

The [contextual numeral completion rule](numeral-inference.md) defines exhaustive
closed-carrier assignment for expression-position numerals. It parses once,
checks all assignments, accepts exactly one, and propagates incomplete analysis
and unowned errors. Declared return types constrain definition bodies. Inferred
numerals retain their selected constructor while rendering without an explicit
type annotation. This is isolated implementation evidence; default integration, type-position
migration, native isolation and main integration remain open.
:::

:::llm gpt-6 2026-11-07 role=assisted

The [explicit numeral default rule](numeral-defaults.md) adds the top-level
`Default numerals: Counting` declaration. Imports combine equal canonical
bindings idempotently and reject conflicts. Completion checks every assignment
before applying simultaneous default restrictions; it never overrides determined
types or incomplete analysis. Defaulted atoms retain their constructor and render
with visible type annotations. This is isolated implementation, with main
integration and broader native/type-position obligations still pending.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [inferred value parameter proposal](inferred-value-parameters.md) records a
newly exposed topology requirement: binary equality of parameterized Type-1
modules/chain complexes needs the field structure inferred from operand types.
Current implicit parameters remain restricted to Type and Natural. The proposal
keeps existing syntax and specifies direct-index recovery, telescope type checks,
repeated-index agreement, deterministic representation selection and explicit Lean
arguments. It is not implemented or accepted as conforming; its canonical and
interaction checks are pending in the acceptance catalog. This does not add
general universe/sort polymorphism or implicit proof search.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [inferred-value parameter rule](inferred-value-parameters.md) now has a working
implementation. A typed Let absent from a callable header may bind a value when
it precedes explicit operands and occurs directly in an operand's type index.
The matcher recovers the first agreed index in the specified traversal, checks
its dependent type, rechecks the full operand telescope and supplies every Lean
argument explicitly. It does not invert computed patterns or search for proofs.
Type/Natural inference retains its previous representation rule. Existing fresh
binder restrictions remain in force. Syntax productions, layout and highlighting
are unchanged; the acceptance catalog records the new semantic slice and its
remaining conformance obligations. Explicit same-module and same-chain-complex
operators now use this capability in the algebra modules.
:::

:::llm gpt-6 2026-11-10 role=assisted

[Retained comparison after later operators](retained-comparison-scope.md) corrects
three retained-body scope gates and aligns direct operator operands with named
calls at the hidden-binder boundary. A checked retained body remains available
after later operator declarations for named calls and eligible record projection;
identity validation and existing shadowing/opacity rules still apply. A normalized
operand containing a binder is not published as a new authored call argument.
No grammar or native unfolding rule changes. Focused evidence and outstanding
full validation are recorded in the report and acceptance catalog.
:::

:::llm gpt-6 2026-11-10 role=assisted

[Condition-index inference](../studies/inferred-conditions/README.md) extends the
specified direct-index rule to a proof type whose formal condition is exactly a
retained local implicit parameter. The actual condition is rechecked with the
binder-aware proof-index rules, must have the declared type, and is supplied
explicitly in the Lean target. Repeated occurrences agree and retain the first
representation; computed formal conditions are not inverted. The isolated patch
adds an explicit proof-equality module and authors implication as a universal
condition over evidence, using existing syntax. No display-name or arrow-token
semantic dispatch is added. Production integration and broader regression remain
pending; focused and canonical results are recorded in the study.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [condition-inference slice](../studies/inferred-conditions/README.md) is now
integrated. A formal proof-condition index that is exactly a local implicit
parameter recovers the actual checked condition, including quantified conditions.
The caller's scope and declared parameter type are rechecked; repeated occurrences
must agree, the first agreed representation is emitted explicitly, and computed
formal conditions are not inverted. The explicit `logic/proof_equality.clean`
module declares equality of evidence. Standard implication is now authored in
Clean as universal quantification over evidence, using the existing callable view.
No grammar, layout, highlighting, display-name dispatch or proof search is added.
Full conformance and the remaining native isolation/universe obligations stay open.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [local numeral-search experiment](../studies/numeral-pruning/README.md)
proposes exhaustive child-assignment pruning before parent combinations. It
preserves all viable child interpretations and applies defaults only to complete
root solutions. Binder regions remain atomic. The resource boundary becomes a
fixed limit on local combinations at each search node; unfinished checks still
propagate as incomplete. The study specifies the compositionality assumptions
and unresolved interaction checks. It also authors finite-vertex order using
natural coordinate order. Neither change is integrated; source grammar and
highlighting are unchanged.
:::

:::llm gpt-6 2026-11-10 role=assisted

[Projection dependency closure](../studies/projection-dependencies/README.md)
proposes instantiating only the transitive predecessors needed by a selected
field's checked type. The full structure declaration is still validated; required
carriers, value indices and proof dependencies are substituted in declaration
order. The emitted root-qualified projection is unchanged, and no cross-scope
cache is added. The pinned isolated driver checks 55 tests, four canonical targets
and two proofs independently of numeral pruning. Production integration and
broader annotation/capture/native-isolation obligations remain open.
:::

:::llm gpt-6 2026-11-10 role=assisted

[Projection dependency closure](../studies/projection-dependencies/README.md) is
now integrated. Projection instantiates the selected field and the transitive
predecessors occurring in its checked type, in declaration order. The full
structure telescope remains checked at declaration time; required carrier,
function, value and proof dependencies are retained. The emitted projection and
its argument order are unchanged. No shared caller-scope cache or grammar change
is introduced. Fifty-five focused checks pass on the working compiler. Broader
native/topology/corpus validation and full regression remain pending.
:::

:::llm gpt-6 2026-11-10 role=assisted

## Traversal-local operator operands

A checked condition may reuse its checked operand expressions only during the
same synchronous elaboration in the same environment and local scope. This is
an internal witness, not a property inferred from an Expr having metadata.
Public comparison/index entry points and stored expressions do not acquire it.
For fresh infix/prefix comparison, normalize the checked operands; preserve the
original operand if normalization exposes a hidden binder; then rerun the normal
overload selection on the resulting operands. For nonfresh input, elaborate the
source operands before that process. No operator selection is bypassed.

For fresh condition binding, recursively close checked Call, ModuleCall, Operator
and Unary arguments. A selected operator becomes a retained ModuleCall carrying
its checked name, declaration identity and presentation. Validate retained and
selected identities against the current declaration before retaining them.
Other constructors use the existing checked binding path; entering a binder does
not inherit a witness for a different scope. Public binding still checks source
operators. No cross-call cache is introduced.

The syntax tree, overload policy and emitted Lean term are unchanged. This rule
changes repeated checking, not the set or priority of interpretations. The
existing deterministic traversal and overload-ambiguity checks still apply;
incomplete analyses propagate. Seven freshness tests and 75 related binding,
proof and inference tests pass in isolation. Three independent canonical Lean
condition/evidence targets pass. Full working-checkout validation is pending.
:::

:::llm gpt-6 2026-11-10 role=assisted

## Local exhaustive numeral completion

The [numeral-search rule](../studies/numeral-pruning/README.md#search-rule) is now
integrated. For ordinary expression nodes, enumerate every successful child
assignment in fixed AST order, then check all combinations at the parent. Never
apply child defaults. Child checking receives no contextual expected type under
the current checker; a future bidirectional checker must revisit this pruning
argument. The complete root receives expected-type filtering and simultaneous
default restrictions. Keep every successful assignment, even at the same type.

Binder bodies remain atomic exhaustive regions with their own scope. The fixed
resource limit caps each visited node's local Cartesian product after filtering,
not the raw global assignment count. Exceeding it is incomplete analysis, never
permission to choose a default. Hole-free children are still checked; an invalid
sibling cannot suppress unknown-name or incomplete errors. Only search-owned
signature mismatches eliminate assignments; other errors propagate, and the
previous owner is restored on every exit. The emitted result is a fully rechecked
whole expression. Source parsing, precedence, declared carrier identities and
operator-selection ambiguity rules are unchanged.

The zigzag module separately declares vertex order through natural coordinates.
Its exact wrapper target is checked along with a nine-numeral expression.
Thirteen focused tests, three canonical targets and three proofs pass directly;
broader regression and study validation remain pending. Parameterized literal
carriers and full native environment isolation are not solved by this change.
:::

:::llm gpt-6 2026-11-10 role=assisted

[Parameterized exact literals](parameterized-literals.md) are a proposed next
step for ordinary vector/matrix zero. The design attaches `Literal: 0` to a named
constructor and specifies an explicit-annotation target as a fully applied call
with parameters recovered from its result pattern. It does not add a registry or
special-case type names. The joint constraint/default calculus for unannotated
uses remains an acceptance blocker. This is not implemented or claimed fully
specified; the current closed-carrier numeral rules are unchanged.
:::


:::llm gpt-6 2026-11-10 role=assisted

The proposed [parameterized-literal result-pattern calculus](parameterized-literals.md#determined-carrier-pattern-calculus)
now defines direct parameter recovery, first-occurrence representatives,
telescope-order checking and deferred computed-index obligations. An isolated
symbolic model passes twenty tests. This is design evidence only: production
pattern construction, declaration checking, binding and joint inference remain
unimplemented. No existing Clean syntax or literal interpretation changes.
:::


:::llm gpt-6 2026-11-10 role=assisted

The [contextual family-key experiment](../studies/contextual-family-comparison/README.md)
specifies a proposed comparison-only congruence step: validate the original checked
call shell, retain inferred arguments, and insert child comparison templates without
re-elaborating expanded children as dependent actuals. The ordinary hidden-binder
guard and emitted Lean remain unchanged. This is an isolated prototype, not an
integrated rule; full validation and consumer/resource audits remain pending.
:::


:::llm gpt-6 2026-11-10 role=assisted

The [parameterized-literal selection experiment](parameterized-literals.md#executable-joint-constraint-experiment)
now models finite declaration rows, sorted structural unification, unresolved
competitors and simultaneous defaults. Eighteen new symbolic tests pass. This
clarifies a proposed selection policy; production row extraction, dependent
constraints, resource accounting and canonical target checks remain blockers.
No production literal behavior changes.
:::


:::llm gpt-6 2026-11-10 role=assisted

An [isolated typed-literal experiment](../studies/literal-annotations/README.md)
adds the Literal declaration field and selection for determined annotations. It
regenerates the parser with strict checks and validates explicit vector/matrix
constructor targets. It currently desugars to ordinary retained ModuleCall nodes,
so literal-surface preservation, the full binding snapshot, unannotated inference,
consumer coverage and broader validation remain pending. This is not integrated
or a conformance claim for the full parameterized-literal proposal.
:::


:::llm gpt-6 2026-11-10 role=assisted

The [retained-literal proposal](parameterized-literals.md#retained-literal-representation-proposed-next-step)
now distinguishes saved constructor selection from literal-surface preservation.
It requires all ordered actuals, a checked carrier annotation, origin/spelling,
synchronized substitution and a faithful versioned encoding. A consumer audit is
recorded. The first annotation experiment tests retained-call behavior only. A
[second isolated experiment](../studies/literal-retention/README.md) implements an
in-memory BoundLiteral, preserving annotated spelling and updating constructor
actuals and the checked carrier together during substitution. Its replay checks
the saved declaration rather than reselecting. Portable serialization, a complete
environment snapshot, joint inference and full consumer coverage remain blockers;
production behavior is unchanged.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [retained-literal scope experiment](../studies/literal-retention/README.md#binder-and-record-follow-up)
requires every freshened function/quantifier binder to enter the substitution
scope with its checked domain, including ordinary textual domains. Body annotations
and constructor actuals use that same fresh binder; an unrelated free actual must
remain free. The isolated implementation now checks this rule through dependent
function, quantified condition and record-field examples. Production integration
and the wider acceptance obligations remain pending.
:::

:::llm gpt-6 2026-11-10 role=assisted

The working compiler now uses the [contextual call congruence rule](proof-beta-comparison.md#integrated-contextual-call-congruence).
After fresh checking and ordered normalization, it validates a fixed native call
shell and inserts comparison templates for its explicit arguments. Implicit
arguments and declaration identity stay fixed; the templates are never elaborated
as authored arguments. The existing hidden-binder barrier and emitted expressions
remain unchanged. This resolves the recorded choice-helper comparison boundary;
full regression and broader dependent-context audits remain separate obligations.
:::

:::llm gpt-6 2026-11-10 role=assisted

`library/logic/type_equality.clean` now supplies explicit equality/inequality
conditions on Type-0 carriers. This uses existing condition, Type-parameter and
operator rules; it adds no parser production, universe inference rule or native
special case. See [the carrier-equality contract](type-expressions.md#explicit-carrier-equality-module).
Generic equality on arbitrary higher-universe values remains unsupported.
:::

:::llm gpt-6 2026-11-10 role=assisted

An [isolated reservation optimization](../studies/lazy-comparison-reservation/README.md)
defers the environment-token scan until the first comparison binder allocation.
The fixed-environment comparison contract is unchanged: all environment, tree and
local tokens must be reserved before choosing the first fresh name. For a pool
that allocates no binder, the scan is unnecessary. The study records the equivalence
argument and collision/count tests; production remains eager pending integration.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [retained-value codec experiment](../studies/bound-tree-codec/README.md#version-1-data-contract)
uses a versioned envelope and closed explicit record tags to preserve checked
annotations, local/module type distinctions, retained indices and captured scopes.
It is an isolated data representation, not a new source grammar or an environment
loader. Decoding grants no freshness or validity: restored trees must be checked
against the explicit environment. Integration into index storage remains pending.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [isolated index-storage boundary](../studies/bound-tree-codec/README.md#index-payload-authority)
now stores versioned checked-tree payloads for computed, dimension and proof
indices. Tree retrieval decodes the payload rather than trusting the optional
`resolved` cache; old raw-list JSON and unsupported versions reject. This makes
payload authority deterministic and preserves checked annotations after cache
removal. Production integration and complete decoded-record validation remain open.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [exact-sequence foundation](../studies/topology/exact-sequences.md) uses existing
explicit modules, dependent records, callable signatures and conditions. `exact(f,g)`
is an authored condition with field and module parameters recovered from map types.
`ModuleSequence.arrow(n)` has domain object(n+1) and codomain object(n); `exact pair
at(field,S,n)` checks the two arrows around object(n+1). `exact sequence interior`
quantifies those pairs and deliberately makes no degree-zero endpoint assertion.
This adds no new syntax or builtin equality/zero/sequence rule. The actual
Mayer–Vietoris construction and proof remain separate mathematical obligations.
:::

:::llm gpt-6 2026-11-10 role=assisted

The separate authored condition `exact sequence ending in zero(field,S)` is
`exact sequence interior(field,S) and onto(S.arrow(0))`. Here `onto(f)` means
that every codomain element has a preimage. It adds exactness at degree zero
without storing a zero object in the sequence record. The explicit zero-map
adapter uses the supplied field instance and Mathlib's zero linear map.
The checked criterion identifies exactness before that map with surjectivity;
interior exactness alone continues to make no endpoint claim.
:::

:::llm gpt-6 2026-11-10 role=assisted

Binary coefficient-module products are explicit imports from
`library/algebra/module_products.clean`. `module product(field,M,N)` has carrier
M × N and is rendered as the binary direct sum. `left inclusion` and `right
projection` have that same declared product as their middle module. Native bodies
install only the supplied field and use Mathlib's product module and linear maps.
The range/kernel and onto conditions remain authored Clean definitions. This
adds no syntax or automatic coercion; the actual Mayer–Vietoris maps remain open.
:::

:::llm gpt-6 2026-11-10 role=assisted

Module-map pairing and merging are explicit Mathlib adapters with different
signatures: pairing shares a domain; merging shares a codomain and adds the two
images. `signed pair(f,g)` is authored in Clean as pairing f with the negative
of g. Its implicit field and module arguments come from checked map types.
The signed-square result uses the supplied equality h ∘ f = k ∘ g to prove
[h,k] ∘ (f,−g) = 0. It asserts composition-to-zero, not exactness. Independent
native targets cover the adapters, authored body and theorem statement.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [named-assumption block prototype](../studies/assumption-blocks/README.md)
specifies one labelled expression beneath `Assume name:` in a Result or Context.
It normalizes to the existing inline assumption before semantic processing;
physical lines do not imply conjunction or a list. Top-level comma lists in this
named block reject; nested call/binder commas retain their ordinary meaning.
The pinned prototype regenerates the strict parser and checks independent trees
and a native target. Production integration remains pending. The study documents
layout, header diagnostic locations, uniqueness and the exact desugaring rule.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [inclusion-induced topology maps](../studies/topology/mayer-vietoris-maps.md)
are authored in `mayer_vietoris_maps.clean` using existing subset, continuous-map,
homology and module-product interfaces. The target is homology of the union,
not implicitly the ambient space. The checked statement asserts composition of
the signed intersection map with the union map is zero for arbitrary subsets.
It does not assert exactness, a connecting map, or excision without hypotheses.
The four new native primitives provide explicit set-containment evidence;
all four mathematical map/module constructions are Clean definitions.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [stable comparison-argument prototype](../studies/stable-comparison-arguments/README.md)
restricts repeated-normalization reuse to freshly checked native-call trees whose
leaves are plain locals without normal expressions or decimals. Authored definitions,
binders, projections, applications and operators remain on the existing path.
The root is still rechecked and normalized, and every materialized call still
validates its declaration identity and native template. The private reuse witness
is synchronous and does not survive the comparison. Production remains unchanged.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [combined language study](../studies/composed-language/README.md) applies the
literal, storage, comparison and named-assumption prototypes together on one
pinned baseline. It regenerates the strict parser and includes cross-feature
examples of retained vector zeros in named/inherited assumption blocks with
dependent record dimensions. These checks validate only the isolated composition;
production integration, full-suite results, stored-record semantic validation and
the remaining universe/native-environment obligations are still pending.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [closed-universe classifier proposal](../studies/universe-classifiers/README.md)
distinguishes the universe of an ordinary object from a declaration whose elements
are carrier types. `Classifies: k` and `type(T : C)` have an isolated syntax prototype;
declaration validation is now prototyped, while carrier elaboration remains pending.
The proposal specifies exact closed levels,
explicit native correspondence, alias identity and ambiguity between classifier
candidates. It audits the current Type-0 assumptions across inference, local types,
dependent fields/callables, conversion and storage. Native feasibility examples
are not translator conformance evidence. General universe polymorphism remains
outside this proposed closed-level mechanism.
:::

:::llm gpt-6 2026-11-10 role=assisted

The closed-universe classifier study now includes isolated declaration validation
and a resolved metadata query. Classifies requires a closed declaration, explicit
successor Universe, the corresponding primitive Type body and no Numerals.
Transparent aliases preserve the native classifier identity; ordinary types do
not become classifiers because of their name or universe. Three independent
native declaration targets cover levels 0–2. Carrier binding, type-value
elaboration, inference, storage and production integration remain pending.
:::

:::llm gpt-6 2026-11-10 role=assisted

The classifier study now prototypes generic implicit carrier arguments at closed
higher universes. Local carriers retain level and classifier identity; matching
requires the exact declared level, substitution checks it, and comparison keys
preserve it. A checked topology specimen uses generic retain/equality operations
and a Clean-authored composition, with five exact native targets and a reflexivity
proof. A document-token omission for Classifies was discovered and repaired.
Explicit carrier arguments, higher computed carriers, type values, dependent
carrier fields/callables and storage migration remain incomplete; this is isolated
validation, not production integration or full classifier conformance.
:::

:::llm gpt-6 2026-11-10 role=assisted

The classifier prototype now accepts explicit local carrier arguments. Callable
parameter types resolve through declared metadata, including arbitrarily named
level-zero classifiers. Both explicit and implicit generic parameters lower to
primitive Type k; ordinary theorem binders and declared return types retain their
native wrappers. Explicit arguments must have the selected classifier identity,
and later arguments must inhabit the supplied carrier. This changes the canonical
domain of old explicit Type parameters; two independent dispatch oracles are
migrated accordingly. First-class higher type expressions, inferred higher-type
reification, dependent carrier fields/callables and storage remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

The classifier study now elaborates type(T : C) and type(T) in isolation. Explicit
selection requires a closed declared classifier at T's exact level; unannotated
selection enumerates and alias-deduplicates all visible classifiers at that level,
requiring exactly one without expected-type or order-based selection. BoundTypeValue
retains checked carrier/classifier annotations, a classifier declaration snapshot,
and presentation. Replay validates that identity without reselection; substitution
changes only the carrier annotation. Reification of an inferred carrier uses its
formal declared classifier. Explicit LaTeX retains the classifier annotation.
See studies/universe-classifiers/type-values.md for the constructive mapping,
consumer audit and native oracles. Plain JSON replay without checked annotations
rejects; codec migration, higher carrier fields/callables and integration remain
pending. These language checks do not prove missing paper theorems.
:::

:::llm gpt-6 2026-11-11 role=assisted

Classifier prototype refinement: dependent-call substitution reifies inferred
carrier arguments with their formal declared classifier before substituting into
value indices, computed indices and dependent callable types. Explicit actuals
and inner scope bindings override inferred bindings; direct carrier positions
retain Type substitution. Visible competing classifiers do not change this rule.
Retained carrier annotations must account for all free references, and those
references must remain in scope; the retained classifier annotation is closed.
These checks are implemented in the isolated type-values patch, not production.
:::

:::llm gpt-6 2026-11-11 role=assisted

The isolated classifier/storage composition uses clean-bound-tree version 2.
LocalType encodes its universe and classifier identity explicitly; version 1
rejects without an environment-based migration fallback. BoundTypeValue retains
its checked annotations and tuple snapshot through the existing tagged encoding.
Stored index payloads are authoritative over cached trees and must be re-elaborated.
See studies/universe-classifiers/storage.md for the schema and validation boundary.
This does not change production storage or claim full environment freshness.
:::

:::llm gpt-6 2026-11-11 role=assisted

The optional classifier/carrier-binder composition accepts existing dependent
function syntax with a declared classifier domain. A type binder retains the
classifier identity and level in LocalType; application substitutes only a
matching checked carrier. Function domains retain their declared wrappers, and
alpha comparison, fresh binder allocation and capture avoidance use the existing
rules. Callable signatures containing DependentFunctionType always use structural
dispatch, even without value indices. No grammar or token change is introduced.
See studies/universe-classifiers/carrier-binders.md for the constructive rule,
independent syntax/native evidence and remaining limits. Production is unchanged.
:::

:::llm gpt-6 2026-11-11 role=assisted

The optional computed-carrier composition extends existing carrier-expression
semantics to every declared closed classifier level. ComputedCarrier explicitly
stores its checked index, level and classifier identity. Substitution elaborates
the substituted index and checks that identity before extracting the carrier;
annotation validation also rejects a stale stored native target. Record projection
detects preceding carrier fields by classifier metadata, not the name Type.
Version-3 payloads encode this record explicitly; older versions reject. See
studies/universe-classifiers/computed-carriers.md for the exact constructive rule,
schema and independent native checks. Production and general record-parameter
inference remain outside this isolated extension.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Current compiler integration

The working compiler now implements the literal/assumption/classifier/carrier
rules described in the preceding isolated-study updates, including version-3
stored index payloads. Their earlier deployment labels are historical. See
[language-integration.md](language-integration.md) for installed scope, conflict
resolutions, validation evidence and remaining obligations.

Literal constructor arguments recovered from target types use each formal
parameter's declared classifier when reified, both on initial selection and on
retained replay. They do not rerun visible-classifier selection. A type annotation
on fresh type(T) still cannot select among competing classifiers. The independent
cross-feature regression and payload tests fix this distinction explicitly.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Payload schema version 4

Version 4 supersedes version 3 in the working compiler. The stored Expr schema
omits checked_args, and stored computed/dimension/proof indices omit resolved.
Those fields are disposable caches and decode to None. All other semantic fields
remain; older versions and explicitly supplied removed fields reject. Encoding
never traverses the omitted caches. See [payload-cache-policy.md](payload-cache-policy.md)
for the deterministic representation rule, tests and remaining performance limits.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Fresh index construction

Index construction may reuse operands immediately elaborated in the same explicit
module environment and local scope. The internal freshness witness is passed only
by substituted-index construction and the checked value-index type-argument path.
Dimension validation, retained callable identities, and comparison normalization
remain mandatory. Public index construction defaults to rechecking the source;
stored metadata and disposable caches never provide this witness. No parse,
inference rule, persisted schema, or intended Lean target changes. See
[active-label-performance.md](active-label-performance.md) for validation status.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Already-normalized native operator children

Within one contextual-comparison traversal, a freshly normalized native operator
or prefix application is stable when its retained binding identity still matches,
its declaration is not Clean-authored with `Equals`, and every checked child is
stable. Freshly checked numeral leaves are stable too. Such a subtree goes directly
to comparison emission without another normalization traversal. Emission still
checks the binding and exact native call template. Local definitions, authored
calls, unchecked expressions, and restored caches do not establish stability.
Public comparison re-elaborates its source under the current explicit environment.
This is a work-reuse rule, not a grammar, inference, or Lean-target change.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Actual-index reuse within one dependent call

A dependent call can retain a constructed explicit-argument index for later
occurrences of the same formal parameter within that call. Reuse requires an
empty shared-binder scope, exactly the entry local names and objects, and the same
comparison pool with unchanged owned identities. The original objects are held
strongly for the call's lifetime. Construction must also leave the pool unchanged
before an entry is stored. Temporary binder scopes and pool allocations bypass
reuse. Substitution-dependent and computed formal indices are not cached by this
rule. Declaration data remain fixed during synchronous matching; the cache is
local to that invocation and is discarded on return or error.

The first occurrence still performs full public index construction. A subsequent
call, even with identical source spelling, constructs its indices afresh. Nothing
is persisted or inferred from stored caches. Grammar, ambiguity rejection and
intended Lean targets are unchanged. See [active-label-performance.md](active-label-performance.md)
for focused and native validation status.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Classified record and type-constructor parameters

Generic carrier parameters of records, native type constructors and aliases are
selected by their declared classifier metadata, including higher closed levels
and renamed classifiers. The formal slot fixes the level; visible-classifier
search is not used. Generic binders emit Type k, and arguments and stored fields
retain explicit universe checks. Existing grammar is unchanged. See the
[classified-parameter contract](classified-parameters.md) for syntax trees,
constructive translation, arrow compatibility boundary and validation limits.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Quoted native result identifiers

Emit every normalized result identifier as a quoted Lean identifier, preserving
its Name and namespace rather than renaming keywords. This fixes accepted titles
such as `Result example`. Title parsing, normalization/collision rejection and
LaTeX display remain unchanged. See [result-identifiers.md](result-identifiers.md)
for the constructive lexical rule, native oracles and remaining binder audit.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Quoted source binders and references

User-written statement binders, local definitions and declaration parameters now
emit the same quoted Lean identifier at binding and reference sites. Scope keys,
source trees, normalized names and LaTeX labels are unchanged. Opaque native
payloads are not rewritten. See [binder-identifiers.md](binder-identifiers.md) for
the constructive rule, identifier audit, native checks and hash migration note.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Comparison reuse within one synchronous scope

Nested comparisons may reuse checked results within their shared binder pool,
under fixed declarations, exact semantic source/type/local snapshots and unchanged
owned identities. No allocation-producing comparison is stored. Cache eviction
and the atomic-expression exclusion affect work only. Public comparisons retain
fresh validation. See [comparison-reuse.md](comparison-reuse.md) for the precise
preconditions, unchanged target rule, tests and pending performance evidence.
:::
