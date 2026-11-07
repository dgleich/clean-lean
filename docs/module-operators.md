:::llm gpt-6 2026-11-07 role=assisted

# Module-declared operators: migration draft

:::llm gpt-6 2026-11-07 role=assisted

Implementation update: [operators and numerals are now integrated into the working compiler](operator-numeral-integration.md). Earlier isolated-status descriptions below describe the development stages. The curated subject libraries now explicitly import their operators and numeral default. Broader library/test migration and full language-contract conformance remain unfinished.
:::


This is a proposed migration with an isolated executable prototype. The main
compiler does not accept `Infix` or `Prefix` yet. It is not a replacement for the agreed
architecture: declared fixity/precedence, numeral interpretation, stable module
scope and the removal of all mathematical display-name dispatch remain required.

## Authored form and syntax

```clean
Notation scalar addition(x: Scalar,y: Scalar): Scalar:
  Infix: +
  Means: x+y
  Render latex: {x}+{y}
```

The notation remains callable as `scalar addition(x,y)`. `Infix` adds a binary
surface binding to the same declaration; there is no accompanying registry file.
A Define with an Equals body may also carry this metadata, subject to the same
arity and signature restrictions. Its body is checked before publishing the new
binding, so the metadata does not grant recursive visibility.

In the prototype grammar, add case-insensitive `Infix` to FIELD and FIELD_LINE.
The rest of the metadata line is parsed as the existing opaque field payload;
its interpreter requires exactly one existing binary operator token. Repetition,
empty payloads, unknown tokens and extra payload words are rejected. Standard
aliases normalize once: `!=` to `≠`, `<=` to `≤`, `>=` to `≥`, `and` to `∧`,
and `or` to `∨`. Alphabetic aliases are case-insensitive. Metadata is permitted
only on Notation and Define, with exactly two explicit operands.

Expression grammar and precedence remain unchanged in this first prototype.
For example, `x+y = y+x` has exactly this tree before binding:

```text
[Operator, =,
  [Operator, +, [Local,x], [Local,y]],
  [Operator, +, [Local,y], [Local,x]]]
```

Declaring Infix cannot reinterpret this tree or complete a different parse.
The later prefix extension is specified below. Custom operator tokens, postfix
forms and module-declared fixity remain outside
the prototype; they require a subsequent lexical/grammar contract. In particular,
this draft does not discharge the catalog's factorial/postfix examples.

## Binding and constructive target rule

1. Check operands using the existing source grammar and scope. An unresolved
   numeric placeholder is rejected explicitly; there is no fallback to the old
   literal/type-name dispatch in binary operator application.
2. Look up all explicit bindings for the normalized symbol. This is an internal
   symbol-table lookup over imported declarations, not an external registry.
3. Match both operand types against each declaration's parameter patterns using
   one fresh substitution map per candidate. Matching is structural and ordered;
   repeated variables must denote equal types/indices. No coercion, native proof
   search, implicit instance search or result-type preference selects a candidate.
   First-order signatures use structural pattern matching. Dependent signatures
   use the existing checked dependent-call rule with a fresh substitution map and
   a private copy of the caller scope. This includes its ordered dimension/index
   inference and callable-evidence comparison; no new mathematical inference is
   introduced. Keep a successful dependent result rather than checking it again
   after selection.
4. A structural mismatch returns false. A dependent match's direct operand
   mismatch is tagged with that match's identity and may reject only that
   candidate. A mismatch from nested elaboration has a different identity and
   propagates. Unresolved inference, invalid domain/sort analysis and interruption
   also propagate; they are not treated as mismatches.
   Thus one success plus one unfinished candidate is not unique success.
5. Zero matching declarations is a binding error. Two or more is semantic
   ambiguity, even if their native bodies are definitionally equal. There is no
   first-match, specificity, import-order or display-name priority. Names are
   sorted only when formatting the ambiguity diagnostic.
6. For the unique declaration, use its saved dependent-call result, or invoke
   the existing checked callable rule once for a first-order signature. Emit
   that notation's generated Lean wrapper and its selected arguments. Failure
   at this stage is an error, with no fallback to another binding. Retain the
   original Operator source tree as provenance; do not turn binding into parsing.

For scalar addition followed by equality, the target is the selected equality
wrapper applied to two selected addition-wrapper calls. The independent native
oracles compare both the adapter declarations and these application trees, with
all instantiated constants and types retained. They do not use definitional
equality in place of canonical expression equality.

The prototype rejects unsupported arity/signatures before publishing the callable
or operator binding. Reimport of one module retains the module loader's existing
idempotence. Duplicate callable names remain rejected by that loader.

## Rendering

Use the selected notation's explicit Render/Render latex template. Parenthesize
operand renderings using the existing grammar's precedence and associativity:
lower-precedence children are grouped; at equal precedence group the right child
of a left-associative operator or the left child of a right-associative operator.
The operator expression retains its precedence. Thus `x*(y+x)` cannot render as
an ungrouped product followed by addition. Rendering does not select a declaration
or change the emitted Lean expression.

## Guarding authored-body expansion

A checked authored definition records the visible binary-operator bindings just
before publishing its own Infix metadata, if any. The snapshot is the sorted set
of symbol/generated-declaration-identity pairs, including all visible bindings;
candidate insertion order is irrelevant. It is comparison/emission metadata, not
an external registry or a new source declaration.

Before re-expanding an authored body during comparison or producer projection
reduction, require that snapshot to equal the current operator environment. If it
differs, retain the checked wrapper/projection instead of re-elaborating the body.
The original wrapper's checked Lean body is not rewritten. All previous opacity
and shadowing gates still apply. Definitions without this metadata retain their
existing behavior, including generated constructors.

The regression defines `authored sum(x,y)` using the one visible scalar-addition
binding, then adds an overlapping binding. A new `x+y` is ambiguous. The named
`authored sum(x,y)` call still emits the same checked wrapper; comparison keeps
that wrapper rather than attempting the now-ambiguous source expansion. The
native oracle independently checks that wrapper's original addition call.

This is a conservative guard, not full module isolation. Even an unrelated new
operator binding can make an old body opaque and reduce comparison power. It
does not make imports independent of the importer, nor freeze bindings throughout
all substituted proof/type expressions. Producer projection emission also retains
its existing reduction-versus-opacity distinction; identical canonical emissions
across different import environments are not claimed. A complete implementation
needs stable bound identities through typed expressions and module-owned scopes.

## Evidence and integration gates

[The study](../studies/module-operators/README.md) contains a patch, proposed Clean
source and a driver that applies the patch to a temporary copy, regenerates the
parser with strict checks, then runs independent binding and Lean-target fixtures.
The prototype passes thirty-two canonical targets and three proofs. Tests exercise missing
bindings, ambiguous bindings in both orders, invalid arity without partial
publication, unequal operand types, grouping, literals rejected explicitly, and
an interrupted competing candidate. A zero-argument type named Matrix, meaning
Real, behaves exactly like the same declaration named Scalar; it does not trigger
the old matrix-product code. The additional Grid/Column module declares matrix
multiplication, matrix-vector application, scalar multiplication and column
equality. The statement `(A*B)*x = A*(B*x)` selects those meanings with explicit
inferred dimensions and is proved using Mathlib's multiplication/application law.
Wrong dimensions, two dependent matches and foreign/interrupted candidate errors
have separate negative checks.

The refreshed prototype also exercises proof-family operands with declared equality.
It checks natural equality, the proof-family application adapter, and a named call
whose implicit type is inferred only after its dependent evidence argument. Five
additional exact targets preserve the inferred type and all proof arguments.
Incorrect evidence is rejected; candidate reordering preserves a unique target;
two eligible proof-family declarations are rejected as ambiguity. The patch retains
the current declaration-scoped matching rule and tags only its direct mismatch
leaves. This expands the bounded audit but does not close captured-module-scope or
native-adapter policy requirements.

Before main integration:

- Specify and implement numeral interpretations/defaults; migrate the isolated
  unary bindings with the binary foundation.
  Fully remove the old numeric and operator paths; do not add an implicit legacy
  fallback when a declaration is missing.
- Complete the dependent-overload audit beyond the matrix/vector dimension
  fixtures, including proof-family and captured-scope interactions under candidate
  reordering. The existing bounded dependent-call profile remains the boundary;
  general higher-order inference or universes are not claimed.
- Specify module-owned binding identity and import scope. This prototype still
  uses the existing flattened module environment; it is not evidence of module
  independence or a finished one-semantic-space architecture.
- Specify declared syntax/fixity and import-conflict handling separately from
  mathematical overload selection, then regenerate the parser or its explicit
  declaration-driven expression boundary under strict ambiguity checks.
- Port foundational operators into explicit modules, update all canonical native
  oracles for intentional wrapper changes, and run the complete corpus and studies.
- Update editor grammars, reference/browser rendering and automatic assumption-name
  consumers. The isolated prototype has not performed these migration gates.

General native-adapter elaboration and the remaining foundational sort/display-name
coupling also stay open. A passing bounded prototype does not resolve them.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Prefix bindings in the isolated prototype

```clean
Notation scalar opposite(x: Scalar): Scalar:
  Prefix: -
  Means: -x
  Render latex: -{x}

Notation condition negation(p: Proposition): Proposition:
  Prefix: not
  Means: ¬p
  Render latex: \text{{not }}{p}
```

`Prefix` is a case-insensitive metadata field on Notation or Define, parallel to
Infix. Its payload must be exactly `-`, `¬`, or case-insensitive `not`. The last
normalizes to `¬`. Exactly one explicit parameter is required; implicit parameters
remain permitted. Duplicate fields, extra words, unsupported symbols and wrong
arity are errors before publishing a callable. A declaration cannot have both
Prefix and Infix: their respective arity requirements cannot both hold.

This slice adds only FIELD/FIELD_LINE alternatives, with strict parser generation.
Expression grammar remains fixed: minus has the signed-expression production,
and negation the negation production. `-x^y` parses as `-(x^y)`; `(-x)^y` has a
prefix child of power. `not x=y` parses as `not (x=y)`. Unary trees retain the parsed token: `[Unary, -, operand]`,
`[Unary, not, operand]`, or `[Unary, ¬, operand]`. Keyword case normalizes
during parsing; `not` and `¬` select the same prefix table entry. Syntax does not inspect types or
candidate declarations. Separate prefix and infix meanings of `-` are permitted;
`x - -y` selects them at distinct tree nodes. `x--y` still starts a comment.
Custom tokens, precedence declarations and postfix binding remain outside this
prototype and require their own lexical/import-conflict contract.

Check the operand once, then apply the binary prototype's candidate-selection
rule to the prefix table and its one explicit argument. Numeric placeholders
are rejected; there is no hardcoded unary mathematical meaning or native fallback.
Each candidate has private inference state. Direct mismatch rejects that candidate;
nested errors and unfinished analysis propagate. Exactly one successful candidate
is required, including all inferred arguments and evidence. Emit its checked
wrapper application and retain the unary source tree. Comparison normalization
uses this same prefix rule, rather than rebuilding native `-` or `¬` expressions.

Rendering uses the selected declaration's template. Assign minus precedence 7
and negation precedence 5 in the existing rendering scale; parenthesize any operand
with lower or equal precedence. This conservative equality rule groups nested
prefixes and comparisons. Higher-precedence operands remain ungrouped. Rendering
cannot select meaning or alter the target. Both prefix and infix bindings enter
the authored-body scope snapshot. A later prefix-table change therefore makes an
older authored body opaque under the same conservative guard described above.

The independent prefix fixture adds eleven exact targets: five wrapper bodies
and six applications, including an inferred row dimension and nested grouping.
A double-negation proof checks the scalar wrapper. Missing/ambiguous bindings,
reordered candidates, invalid metadata, an interrupted competitor, and changed
prefix scope are rejected or preserved as specified. A scalar call with no `n`
in scope rejects the `Row(n)` candidate by its type constructor alone. Diagnostic
formatting must not elaborate the full unmatched pattern: its uninferred index
is irrelevant once the constructor mismatch has established rejection.

This is still isolated proposed syntax, not a main-compiler feature. It removes
the unary fallback only inside the prototype. The module-isolation limitation
still applies to both tables, and numeral/default interpretation, declared fixity,
foundational sort coupling and full corpus migration remain integration gates.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Composed binding-aware prototype

The [bound-operator study](../studies/carrier-fields/BoundOperators.md) combines the
operator metadata with carrier fields, saved callable identities and checked type
annotations. In that isolated stack, Condition also accepts Infix/Prefix metadata
through the existing shared field grammar and operator validator. Body binding occurs
before publishing the declaration's own operator candidate. Saved operators retain
the selected adapter/template and a separate source-rendering tag; substitution does
not re-run overload selection. The study specifies preserved grouping, callable
implication authored with a forall, negative checks, and remaining migration gates.
Main syntax remains unchanged. The earlier standalone patch keeps its conservative
scope guard; the composed stack can reduce stored module calls through resolved bodies.
:::
