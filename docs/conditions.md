:::llm gpt-6 2026-10-30 role=assisted

# Conditions and grouped assumptions

A condition names a mathematical statement without assuming it holds. `Assume`
introduces a hypothesis that a condition holds. Ordinary authors need neither a
`Returns: Proposition` annotation nor a declaration of the underlying logical sort.

```text
Condition symmetric(A):
    Let n: Natural
    Let A: Matrix(n,n,Real)
    Holds when: A = real transpose(A)
    Assumption name: symmetry of {A}

Condition positive(x: Real):
    Holds when: x > 0
    Assumption name: positivity of {x}

Assume symmetric(A), symmetric(B)
Assume positive(x), chosen bound: y > x
```

The last two lines belong inside a result or context. Each item becomes a separate
hypothesis. The first line gets labels “symmetry of A” and “symmetry of B” and Lean
identifiers `symmetry_of_A` and `symmetry_of_B`. An explicit label overrides the
naming template for that item only. A labeled conjunction remains one hypothesis.

## Grammar and parsing

The [EBNF extension](../grammar/conditions.ebnf) and these rules are normative for
this bounded feature. **It does not generate the current parser.** The parser is
handwritten Python; the grammar is a specification fragment, not a complete grammar
for a parser generator. Existing expression, type, lexical, layout, and module
productions remain defined in the language reference. Syntax tests check their
agreement but do not prove it. A generated parser would require consolidating those
productions and their lexical/layout boundary into a machine-readable grammar.

Keywords and field names are case-insensitive. Condition names and variables are
case-sensitive: `symmetric(A)` and `Symmetric(A)` are different names. Headers end
with a colon. Arguments are either all bare names with corresponding `Let` fields,
or all `name: Type` arguments with no `Let` fields. Empty parameter lists use the
expanded form. Mixed forms, trailing parameter commas, an explicit result suffix,
and `Returns` fields are errors. A condition has exactly one `Holds when` or
`From Lean` body. `Equals` is not a Condition field. Duplicate fields are errors.

`Holds when` accepts an inline expression or an aligned indented expression block.
`From Lean` uses the existing inline opaque Lean-body boundary. Render and optional
attribution fields follow existing definition rules. Names become visible only
after their bodies have been processed; recursion and forward references are not
introduced. Expanded parameter declarations retain their relative order; other
fields may reorder. Implicit dimensions/types must precede explicit parameters
and be inferable from argument types, as for `Define`.

For `Assume`, scan balanced parentheses and split only at **depth-zero commas**.
Then split each item at a depth-zero colon, if present, into label and expression.
Multiple such colons are errors. Labels consist of identifier words separated by
spaces. Each expression is parsed independently by the existing expression grammar.

Thus `Assume related(A,B), accepted(function(x: Real, x > 0))` has two items:
commas and the colon within parentheses belong to expressions. Commas are not an
expression operator. No current unparenthesized expression form requires a comma.
A future tuple, binder, or quantifier using commas must protect them with parentheses
in this position or explicitly revise this grammar. Semicolon separation is rejected.

A trailing depth-zero comma requests continuation of an `Assume` clause. Outside
open parentheses, the next content line must be indented at least two more spaces;
comments and blank lines can intervene. A trailing comma with no following item,
empty items, and unbalanced parentheses are errors. An `Assume` with no trailing
comma or unfinished expression ends at its newline. Continuations starting with a
condition call whose name is also a keyword remain ordinary expressions.

The balanced scan uniquely determines list boundaries and label boundaries before
name lookup or typechecking. The existing expression parse determines each item;
Lean elaboration never chooses between list parses.

## Names and scope

Unlabeled items must have a root `Call` node resolving to a `Condition` declaration.
Redundant grouping parentheses do not change that node. Comparisons, conjunctions,
negations, local function calls, and ordinary `Notation` calls need explicit labels.

`Assumption name` is an optional opaque one-line template. Placeholders may name
only explicit parameters, never implicit dimensions or unknown names. Nonempty format specs
and conversions are rejected; doubled braces represent literal braces. The default
is the declared name followed by its explicit argument placeholders in parentheses,
separated by comma-space. There is no grammatical guessing of “symmetry” from
“symmetric.” Templates are expanded without executing code.

Argument display strings are constructed from the parsed AST, not original source,
LaTeX, or Lean text:

- Local: its identifier; decimal: remove leading zeroes, leaving `0` for zero.
- Call: `name(arg1, arg2)` recursively.
- Unary: `(operator argument)`; binary: `(left operator right)` using normalized AST
  operators, including their existing logical-symbol normalization.
- Lambda: `function(name: CanonicalType, body)`; canonical types use constructor names
  and comma-separated arguments without spaces, per the existing type AST.

After substitution, trim and collapse whitespace to single spaces. Empty labels are
errors. To obtain the Lean identifier, replace runs of whitespace/underscores by
one underscore, preserve Unicode word characters, and encode each other character
as `_u` + lowercase hexadecimal Unicode code point + `_`. Prefix `h_` if the result
is empty or starts with a digit. Every emitted hypothesis binder is quoted as
`«identifier»`, so reserved Lean words cannot change its parse. For example the
identifier `symmetry_of_A` is emitted as `«symmetry_of_A»`; these denote the same
Lean name. Explicit labels use the same conversion.

Reject collisions of these identifiers with other assumptions or local objects in
the result, including inherited contexts, in either declaration order. Equal display
labels necessarily collide too; authored labels matching a local name are also rejected.
Punctuation encoding can collide with literal escape-looking text, such as `+` and
`_u2b_`; these are errors too. Do not append suffixes. Equal normalized source
expressions collide; mathematically equivalent but syntactically different expressions
need not. Authors can provide explicit distinct labels when necessary.

Hypothesis labels do not enter mathematical expression scope. They name evidence,
not conditions. Proof-reference syntax is outside this feature. Local statement
abbreviations remain unsupported; their diagnostic must not recommend `Assume`,
which would change meaning. Context expansion counts emitted hypotheses, not source
lines, and preserves their order and labels in both LaTeX context modes.

## Constructive Lean mapping and limits

A `Condition` uses the same parameter bindings as `Define`, with fixed logical
return sort `Prop`. `Holds when` must typecheck as a condition; its existing unique
expression target is the body. `From Lean` supplies a Lean expression checked against
that signature by Lean. Rendering and naming metadata cannot alter the definition.
The normalized signature and body are retained in `condition_tree` and definition
metadata. Generated definition identifiers reuse the existing deterministic definition
naming rule; a condition does not introduce an axiom or a proof.

Each assumption maps, in source order, to `∀ («name» : translated_condition), …`.
Grouping them on one source line adds no conjunction constructor. The list's normalized
representation is the ordered Clause sequence `(assume, identifier, label, expressionAST)`;
source lines are diagnostic metadata only. Labels are not available to later expressions.

The implementation currently reuses the prototype's canonical `Proposition` type
binding supplied by the explicitly imported standard module. This inherited display-name
coupling is migration debt; arbitrary renaming of that binding is not implemented.
The binding must actually map to Lean `Prop`, which is checked at declaration time.
The new declaration does not claim to fix existing general overload, implicit-argument,
universe, instance, or coercion uniqueness gaps. `From Lean` targets retain the existing
unresolved general acceptance obligations. No whole-language conformance is claimed.

## Checks and examples

[examples/conditions.clean](../examples/conditions.clean) demonstrates authored
conditions, grouped assumptions, a context, and comma continuation.
[tests/test_conditions.py](../tests/test_conditions.py) includes independent AST and
name expectations, context ownership, nested commas/colons, keyword names, collisions,
invalid declarations, and labels excluded from expression scope.
`LAKE=lake python3 tools/check_condition_targets.py` compares independent elaborated
Lean type/value structures for authored and imported conditions and a grouped theorem
statement. Canonical comparison ignores binder names/metadata only, without reduction.

The magnetic study imports the temporary [Common.clean](../library/Common.clean)
library for standard types, finite operations, and the imported Hermitian condition.
Its paper-specific definitions stay in `Statements.clean`. The emitted Lean files
still expand those dependencies and import only Mathlib.
:::

:::llm gpt-6 2026-10-30 role=assisted

The syntax review identified and checked depth-zero separators, keyword-named calls
across continuation, context expansion counts, and proof-label scope. Those interaction
fixes are covered by regression tests. The [PDF specimen](../generated/conditions.pdf)
shows both repeated assumptions and explicit context references. Reproduce with:

```sh
python3 -m cleanlang lean examples/conditions.clean -o generated/Conditions.lean
python3 -m cleanlang latex examples/conditions.clean -o generated/conditions.tex
lake env lean generated/Conditions.lean
pdflatex -interaction=nonstopmode -halt-on-error -output-directory generated latex/conditions.tex
pdflatex -interaction=nonstopmode -halt-on-error -output-directory generated latex/conditions.tex
```
:::
