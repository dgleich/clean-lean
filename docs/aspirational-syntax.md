:::llm 2026-10-23 role=assisted

# Clean as mathematics you want to write

Clean should be a pleasant place to write mathematics in a plain text editor. The source should communicate the statement before anyone compiles it, generates a PDF, or knows Lean. Its formal rules should make that experience dependable.

The examples below are **aspirational design specimens**, not a promise that the current parser accepts every form. Existing choices and new proposals are distinguished at the end. The companion [syntax and semantics draft](language-reference.md) defines the machinery that must support this experience; it must not make compiler convenience the standard of good prose.

## A theorem should look like a theorem

```text
Import "linear algebra.clean"
Import "sources.clean"

Result similarity transforms eigenvectors:
    Attribution: stewart2001; Theorem 1.10, page 9; adapted; scope: eigenvector part

    Let n be a natural number
    Let A, S be complex n×n matrices
    Let x be a complex n-vector
    Let μ be a complex number

    Assume invertibility: det(S) ≠ 0
    Assume nonzero vector: x ≠ 0
    Assume eigenpair: A*x = μ*x

    Let y = inverse(S)*x

    Conclude:
        y ≠ 0
        and
        (inverse(S)*A*S)*y = μ*y
```

The imports above stand for explicitly declared library modules, not built-in names. A reader should immediately recognize the objects, hypotheses, and claim. The attribution is compact. English assumption labels explain why each hypothesis is present. Blank lines group ideas without carrying hidden mathematical meaning. The local name `y` removes distracting repetition.

This example deliberately keeps mathematical notation such as `*`, `≠`, and `=`. Readability does not mean replacing familiar mathematics with verbose function calls, nor does it mean accepting arbitrary English and guessing its interpretation.

## Short results should stay short

```text
Result determinant product:
    Attribution: mathlib; Matrix.det_mul; specialized
    Let n be a natural number
    Let A, B be complex n×n matrices
    Conclude: det(A*B) = det(A)*det(B)
```

No generated identifiers, typeclass arguments, or rendering instructions belong in an ordinary statement. An author should not need to know how `Matrix` or `det` translates to Lean in order to use an imported library.

Both of these declarations remain welcome:

```text
Let x be a Vector(n, Complex)
Let x: Vector(n, Complex)
```

They have the same meaning. The first reads as a sentence; the second is compact mathematical notation. The language should not punish either preference. A declaration using `be` should work wherever a typed `Let` works, including inside a notation definition.

## Shared context should remove repetition visibly

A proposed reusable-context form is:

```text
Context complex square matrices:
    Let n be a natural number
    Let A, B, C be complex n×n matrices

Result determinant product:
    Use complex square matrices
    Attribution: mathlib; Matrix.det_mul; specialized
    Conclude: det(A*B) = det(A)*det(B)

Result determinant left swap:
    Use complex square matrices
    Attribution: mathlib; Matrix.det_mul_left_comm; specialized
    Conclude: det(A*(B*C)) = det(B*(A*C))
```

`Use` is a proposed active-voice clause, not an implemented keyword. It makes the dependence visible in each result without repeating all the declarations. LaTeX can expand the context or say “Using Context (1),” as already agreed. The nested-context form remains another possible authoring form.

Reusable contexts need a binding rule: this proposal instantiates their declarations freshly in each result, rejects conflicting local names, and preserves dependencies and all hypotheses. Parameters, renaming, and combining contexts need further design. This specimen does not silently authorize textual inclusion or name capture.

## Library definitions should also be readable

Most authors will consume mathematical libraries; some will extend them. Both experiences matter.

```text
Import Lean Mathlib.Data.List.Sort
Import "lists.clean"

Notation insertion sort(xs):
    Let xs be a list of natural numbers
    Returns: a list of natural numbers
    Means: List.insertionSort (· ≤ ·) xs
    Render: insertion sort of {xs}
```

The readable name, its inputs and result, its precise Lean meaning, and its presentation are adjacent. Lean syntax is confined to the explicit boundary where a library author connects the two languages. It does not appear in every theorem that uses insertion sort.

For operators, a more readable candidate than `Syntax: infix "*"` is a written pattern:

```text
Notation matrix vector product(A, x):
    Let m, n be natural numbers
    Let A be a complex m×n matrix
    Let x be a complex n-vector
    Returns: a complex m-vector
    Write: A*x
    Syntax group: multiplication
    Means: Matrix.mulVec A x
```

`Write` and `Syntax group` are **new proposals**. The pattern identifies operands and operator spelling. An explicitly imported syntax group supplies shared precedence, associativity, and structural presentation. Overloads of multiplication must agree on that syntax contract. The group does not supply the mathematical meaning; `Means` does. The definition of syntax groups and their import/export behavior remains to be specified.

This puts the familiar mathematical spelling in front of the author and moves numeric binding powers into a shared library declaration. It must remain the same notation mechanism used for call syntax, rather than becoming a separate privileged matrix feature.

## Plain text is a primary output

Generated LaTeX is valuable, but an attractive PDF does not compensate for unpleasant source. A `.clean` file should work well in an editor, a code review, an email excerpt, or a book manuscript draft.

The authoring requirements are:

- **Read aloud naturally.** `Let`, `Assume`, and `Conclude` should explain what the author is doing. Labels and titles use English words.
- **Preserve mathematical economy.** Familiar expressions remain compact. Avoid wrappers whose only purpose is to expose backend details.
- **Keep explicitness close to its purpose.** Imports identify vocabulary; assumptions state hypotheses; attribution identifies a source. Repeat none of these merely because the translator finds repetition convenient.
- **Offer equivalent readable and compact forms.** `be` and `:` introduce the same typed declaration. Such equivalences must be specified, not maintained as unrelated parser exceptions.
- **Keep meaning visible.** A context dependency must be named. Overload ambiguity must produce an explanation, not a guess. A hidden default must not change the theorem.
- **Support ordinary editing.** Whitespace can separate ideas; indentation carries scope; keywords accept flexible capitalization. Diagnostics should quote the mathematical phrase and source line before exposing generated Lean details.
- **Let libraries share the burden.** A type phrase, operation, or display convention is introduced once and imported. Common theorem authors should not write regular expressions or TeX templates.

These requirements apply to handwritten source, not just a pretty-printer's output. We should judge the actual text an author must maintain.

## Readability checks for proposed syntax

Before accepting a feature, write a small specimen set and assess it alongside its formal rules:

1. A five-line result with attribution.
2. A longer theorem with named assumptions and local definitions.
3. Several results sharing a context.
4. A new operation introduced by a library author.
5. The same statements in prose-type and colon-type styles.
6. A deliberately mistaken statement and the diagnostic its author sees.

Questions for each specimen: Can a mathematically trained reader identify the objects and claim without knowing Lean? Is the source unnecessarily repetitive? Does a spelling conceal a dependency? Can an author predict grouping? Is a simple edit likely to change an unrelated meaning? Does the error message help repair the mathematical statement?

A feature that passes elaboration tests but makes these specimens harder to read needs redesign. Conversely, attractive prose with ambiguous semantics is not an acceptable shortcut. Formal precision and readable source are joint acceptance criteria.

## Status and choices

| Feature | Status |
| --- | --- |
| Active `Let`, `Assume`, `Conclude`; `be`/colon alternatives; compact attribution; English titles | Established direction, partly implemented |
| English assumption labels and consistent typed-let forms inside notation declarations | Target behavior; current parser is narrower |
| Reusable context with `Use` | New surface-syntax proposal; current implementation uses nested contexts |
| `Write: A*x` and named syntax groups | New alternative to numeric operator fields; requires semantic and grammar design |
| Plain text readability as a first-class acceptance requirement | Explicit user requirement |
| Lean only at explicit library boundaries | Target authoring experience; precise bridge syntax remains revisitable |

The formal grammar is a draft, not a reason to freeze its first spelling. We should settle representative source examples together with their binding and elaboration rules, then implement both.

## Examples from recent papers

The [recent-paper specimens](recent-paper-examples.md) apply this style to magnetic graph matrices, a size-specific Cheeger inequality, and a trace-bounded SDP certificate. They expose the need for readable summation, existential, set-comprehension, and optimization binders. These examples are aspirational, not compiler-supported or Lean-verified.

## Agreed definition and import forms

These forms record the parsing choices accepted on 2026-10-19; top-level `Define` is not yet implemented. Imported names in this specimen stand for explicitly supplied mathematical modules.

```text
Import "real matrices.clean"

Define volume(G, S):
  Returns: Real
  Let n: Natural
  Let G: Graph(n)
  Let S: VertexSet(n)
  From Lean: GraphDefinitions.volume G S

Import "complex matrices.clean"
Import BibTeX "references.bib"

Define magnetic matrix(A, q):
  Render latex: M({A},{q})
  Let n: Natural
  Let A: Matrix(n,n,Real)
  Let q: Real
  Returns: Matrix(n,n,Complex)
  Equals:
    exp(2*π*i*q)*A +
      exp(-2*π*i*q)*transpose(A)
```

The first imported module must explicitly supply the referenced Lean definition and types. The second import adds vocabulary only for following declarations; it cannot affect the earlier `volume` definition. Parameter types depend on earlier parameters. `Returns` and `Render latex` need not follow parameter declarations, because these fields are collected before semantic checking.

Alternatively, the magnetic definition can be imported through a checked adapter in a module with the required Lean import:

```text
Import Lean CleanPapers.Definitions

Define magnetic matrix(A, q):
  Let n: Natural
  Let A: Matrix(n,n,Real)
  Let q: Real
  From Lean:
    CleanPapers.magneticMatrix A q
  Returns: Matrix(n,n,Complex)
  Render latex: M({A},{q})
```

These magnetic declarations are alternatives, not two declarations of the same name in one scope. Both have the same signature and are used as `magnetic matrix(A,q)`. The adapter snippet also requires explicit Clean imports for its types. A definition has exactly one implementation field. Attribution on definitions is currently an optional policy; attribution on results remains required.

With declared factorial and addition notation, newline behavior is:

```text
Let count = n!
Let total = count +
  extra
```

Factorial completes its operand and therefore ends the first definition at the newline. Addition still requires an operand and continues. A spelling cannot be imported as both infix and postfix; the conflict is diagnosed at the import, not guessed from operand types later.
