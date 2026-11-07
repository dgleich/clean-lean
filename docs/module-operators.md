:::llm gpt-6 2026-11-07 role=assisted

# Module-declared binary operators: migration draft

This is a proposed migration with an isolated executable prototype. The main
compiler does not accept `Infix` yet. It is not a replacement for the agreed
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
Custom operator tokens, postfix forms and module-declared fixity remain outside
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

## Evidence and integration gates

[The study](../studies/module-operators/README.md) contains a patch, proposed Clean
source and a driver that applies the patch to a temporary copy, regenerates the
parser with strict checks, then runs independent binding and Lean-target fixtures.
The prototype passes fifteen canonical targets and two proofs. Tests exercise missing
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

Before main integration:

- Specify and implement numeral interpretations/defaults and unary bindings.
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
