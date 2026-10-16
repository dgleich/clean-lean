# Clean theorem statements

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

One declaration occupies one physical line. Use four spaces inside a result and eight inside attribution or conclusion blocks. Tabs and arbitrary indentation are errors. Blank lines and full-line `#` comments are allowed. An indented conclusion may span several lines; those lines form one expression, so `and` must appear explicitly. Version 0.1 does not support implicit continuation of other clauses, semicolon-separated mathematical statements, or inline comments. Semicolons are permitted as field separators inside compact attribution clauses.

The leading keyword is case-insensitive: `let`, `Let`, and `LET` are equivalent, as are `Define` and `define`. This rule also applies to `Result`, `Theorem`, `Assume`, `Conclude`, attribution field names, and logical `and`, `or`, `not`. Variable names and registry function names are case-sensitive. Type constructor spellings and aliases are registered explicitly; prose type patterns match without regard to case.

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

Use `Let x: Vector(n, Complex)` or `Let x be a Vector(n, Complex)` instead. The language does not silently interpret that rejected form as naming a type. Type aliases belong in the extension registry.

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

Shared source metadata lives in `sources.json` (overridable with `--sources`). Each source has a `kind` (`lean`, `book`, or `other`), a short citation `label`, a `title`, and optional author, year, publisher, version, revision, and URL. A Lean source also names a reference index. The supplied `corpus/references.json` maps declaration names to exact file/line URLs and revisions. The validator rejects unknown source keys, unknown Lean declarations, and revision mismatches. Book references are free-text locators; this prototype does not check their bibliographic accuracy.

An original result can reference a registered local source of kind `other` and use an internal locator; do not invent a published source. Mathematical provenance and formalization authorship remain distinct. Extra metadata is retained, even when it is not printed.

LaTeX shows a short citation beside each result title, such as `[Mathlib]` or `[Stewart 2001, Theorem 1.10, page 9]`. Mathlib citations link to the specific declaration. Full source information is listed once in `generated/references.tex`. This file lists the project's registered sources, including unused entries, so partial builds cannot accidentally remove another fragment's bibliography. Raw paths, revisions, and relationship labels are not repeated under each result. Explicit scope, changes, and notes remain visible as short qualifications; adaptations are marked as such.

Structured output retains both the authored `attribution` and the `resolved_attribution`, including shared source details and the precise declaration URL. The corpus catalog also preserves source excerpts and topics. CLR alignment remains topical; no edition-specific theorem numbers or pages are claimed.

## Expressions

The initial implementation supports names, natural numerals, parenthesized expressions, registered function calls, application of declared unary functions, unary minus, and logical negation. Binary operations include arithmetic, equality and comparisons, conjunction, disjunction, implication, equivalence, membership, subset, set union/intersection, and divisibility.

Precedence, from low to high: equivalence; implication; disjunction; conjunction; comparisons/membership; addition/subtraction/set operations; multiplication/division; powers. Powers and implication associate to the right. Use parentheses around chained or mixed comparisons; comparison chains are not supported. Powers bind more tightly than unary minus: `-x^2` means `-(x^2)`. Write `(-x)^2` for the other grouping.

Operand types choose the meaning of `*`: scalar multiplication, matrix–matrix multiplication, or matrix–vector multiplication. Matrix dimensions and fields must agree. `Vector * Vector` is not guessed to mean an inner product; add an explicit registered function for such operations. Lean performs the final type check. The prototype's local checks are deliberately narrower than Lean elaboration and cannot validate every algebraic structure.

Function names such as `det`, `inverse`, and `continuous` are registered, with signatures and separate Lean/LaTeX templates. The prototype does not parse unrestricted mathematical English, binders such as `for every`, explicit existential quantifiers, summation notation, lambdas, structures, or typeclass assumptions. These are natural next extensions suggested by a broader corpus.

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

A JSON registry defines canonical constructors, their parameter kinds, and rendering templates. Constructor parameters are either `dimension` or `type`. Phrase entries map explicit regular-expression patterns to constructors. Unrecognized or ambiguous phrases are errors.

Libraries can derive an alias by expansion into a canonical type:

```json
{
  "types": {
    "SquareMatrix": {
      "args": ["dimension", "type"],
      "canonical": "Matrix({0},{0},{1})"
    }
  },
  "phrases": [
    {
      "pattern": "square complex matrices of order (?P<n>\\w+)",
      "type": "SquareMatrix({n},Complex)"
    }
  ]
}
```

Pass this file with `--registry examples/extensions.json`. The alias normalizes to Matrix before expression checking, so existing operations such as determinant work without special cases. Cyclic aliases and duplicate registrations are rejected.

A new canonical constructor instead supplies `args`, `lean`, and `latex` fields. That registration must refer to an existing Lean type or one provided by an imported library. The registry does not invent a mathematical construction merely by giving it a name. Refinement types and new inductive definitions remain future work.

Function signatures use placeholders such as `$n` and `$K` to relate dimensions and scalar types across arguments. Templates use `{0}`, `{1}`, etc. for arguments; literal LaTeX braces are doubled. Registry files are trusted library configuration, not a sandbox for untrusted templates.

## LaTeX rendering

Both backends consume the same parsed structure. Each successive `Let` clause becomes a sentence ending in a period, in a single paragraph. We interpret “conjoined with periods” as sentence separation rather than silently merging declarations with “and.” Multiple names declared on one line remain together. Assumptions retain their labels; the conclusion is displayed; a short citation accompanies the title, and any explicit qualifications follow in smaller type.

The default rendering prefers English wherever it describes the mathematical argument. Logical connectives render as “and,” “or,” “if and only if,” “implies,” and “not,” rather than logical symbols. Membership, subset, and divisibility render as “belongs to,” “is a subset of,” and “divides.” Predicates use phrases such as “is continuous,” “is sorted,” and “is adjacent to.” Standard mathematical operations and relations such as multiplication, powers, equality, and inequalities retain their notation.

Typed declarations render as prose, for example “Let n be a natural number” and “Let A and S be n×n matrices over ℂ.” The type registry supports `prose` and `prose_plural` templates alongside its mathematical `latex` template. Extension types without a prose template fall back to “an element of” or “elements of” followed by the type. Both singular and plural declarations are supported. These presentation rules do not change the Lean interpretation.

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

Contexts may nest. Put their `Let`, `Define`, and `Assume` clauses before their child results or contexts. Each nesting level adds four spaces. Inner declarations cannot shadow inherited names. Only needed inherited object declarations and local definitions are retained, including their dependencies; all inherited assumptions are retained. Thus the example's result quantifies over n, A, B, without an unused C.

`\CleanInput[contexts=expanded]{examples/determinants.clean}` repeats required declarations and all inherited assumptions within each result. This is the default. `contexts=referenced` prints numbered contexts and explicitly states “Using Context (1)” in each affected result. Nested contexts cite their ancestors. Both modes have the same Lean meaning. See `latex/contexts.tex` and `generated/contexts.pdf`. Parameterized assumption-set templates are not implemented.

## Definitions modules (initial prototype)

Clean will combine explicitly imported definitions modules with Lean-backed mathematical definitions. A module will associate readable names with Lean expressions and presentation rules; Lean will check meaning and types. Rendering rules cannot supply mathematical meaning. Imports must expose dependencies, conflicting names must require disambiguation, and project dependencies must be pinned.

The existing JSON registries currently provide function meanings, types, type phrases, and renderings. For example, `insertionSort(xs)` maps to `List.insertionSort (· ≤ ·) xs` for natural-number lists. This dependency is essential, not cosmetic. An initial implementation supports relative Clean imports, Lean imports, and typed notation declarations; see [notation prototype](notation-prototype.md). Most mappings still reside in JSON; exact `Import` and `Notation` syntax is provisional. Naming Mathlib's implementation does not define or verify CLR pseudocode.
