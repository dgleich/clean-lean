:::llm gpt-6 2026-11-07 role=assisted

# Postfix application and field selection

Implemented in the prototype compiler. Focused and native acceptance checks pass;
full-suite and general language conformance remain separate obligations.

## Readable forms

```text
add offset(n)(m)
support.active(x)(h)
producer(x).field(y).next(z)
(function(x: Natural,x))(n)
```

Each argument list applies the expression immediately to its left. Each `.field`
selects a field of that expression. The operations associate to the left and bind
more tightly than powers, unary minus, and other binary operations. Newline
continuation and indentation rules are unchanged.

## Deterministic syntax rule

The grammar parses `postfix := atom postfix_suffix*`, with suffixes `. ID` and
`( arguments? )`. A reference atom uses the existing `name := ID+` production.
The pure syntax normalizer applies these rules before any environment lookup:

1. A single-word reference starts as `Local(name)`.
2. A multiword reference must have an immediate argument-list suffix. Consume
   that suffix as `Call(name,args)`; otherwise reject the expression. Thus
   `make map(x)` is valid, while bare `make map`, `make map.field`, and
   `(make map)(x)` are not expressions.
3. Fold the remaining suffixes from left to right. A field suffix gives
   `Projection(base,field)`. An argument list on a `Local(name)` gives the
   existing `Call(name,args)` tree. Every other argument list gives
   `Apply(base,args)`.
4. Grouping returns the grouped expression tree. Therefore `f(x)` and `(f)(x)`
   have the same tree, as do `f(x)(y)` and `(f(x))(y)`.

The existing parser-generated name production is shared with assumption labels
and declaration names. A trial with a separate two-or-more-word name production
failed strict LALR generation; it was not integrated. The implemented shared-name
rule passes strict LALR and contextual lexer checks without priorities or default
conflict resolution. The multiword validation above is a syntax rule, never a
choice made from type-checking success.

For example, `f(x)(y)` has exactly this source tree:

```text
Apply(Call("f", [Local("x")]), [Local("y")])
```

Field and call suffixes consume their own delimiters. Each fold has one rule based
on the syntax tree already built, so neither a type environment nor import order
can change the parse. Existing named calls and field applications retain their
previous source trees.

## Constructive Lean mapping

`Call` keeps the existing named-call resolution and declared-argument inference
rules. Callable locals take precedence over same-named module callables. This
change does not add overload selection, inferred currying, or a new fallback.

For `Apply(base,args)`, first elaborate the base and every supplied argument.
Require exactly one argument and a known function type, including the existing
callable view of universal/implication evidence. Compare its domain with the
argument's determined type using the known-type compatibility rule. A mismatch,
nonfunction base, zero arguments, or multiple arguments is an error. For a
dependent function, substitute that checked argument once into its codomain.
Emit the application of the checked base term to the checked argument term:

```lean
-- f : A → B → C, x : A, y : B
(f x) y
-- h : ∀ n : Nat, n = n → n = n
(h n) p
```

The new suffix selects no additional implicit argument, coercion, instance,
universe, or proof. It preserves the terms selected while checking the base and
argument, including the supplied proof `p`. The general obligations for existing
named/native bindings are unchanged; this local rule does not establish their
conformance. An unresolved analysis is not a successful application.

## Every expression consumer

The AST uses existing Call, Apply and Projection constructors. Application,
projection, substitution, scoped binder keys, and comparison normalization keep
those constructors. Source spelling now groups arbitrary application heads, so
source-origin application trees round-trip through condition naming and proof
indices. An internal Apply with a Local head can canonicalize to the existing Call
form; it does not introduce a second source parse.

Proof indices can now preserve an applied function whose body contains another
lambda or quantifier. Those applications remain present in the emitted term and
comparison representation; this is not a new reduction rule inside binder bodies.
The existing checked beta contraction remains limited to its documented cases.
Bare functions in ordinary computed indices still fail the no-binder rule.

LaTeX parenthesizes applied lambda, operator and unary heads. Chained applications
render as successive argument lists. Editor highlighting remains lexical: no new
keyword or punctuation token is added. The callable-family, field, grouping,
condition-spelling and proof-index tests exercise the common source forms.

## Evidence and limits

The [study](../studies/postfix-applications/README.md) checks eight independently
written canonical Lean targets and five proofs. The 227 focused regressions include
nine new postfix cases and the two formerly rejected proof-index cases, now
required to preserve their unapplied binder bodies. Generated grammar reproducibility
is checked. These results do not replace full-suite, corpus, editor and browser
validation, nor the separate active-label construction's unfinished verification.
:::
