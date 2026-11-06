:::llm gpt-6 2026-11-06 role=assisted

# Scoped quantified conditions

This implemented slice adds nested universal and existential quantification.
It is subject to the [language acceptance contract](language-change-acceptance.md);
the independent checks below establish a bounded slice, not general conformance.

```clean
for every (x: Real, there exists (y: Real, x = y))
there exists (x: Real, positive(x)) and positive(a)
```

## Grammar and deterministic scope

```ebnf
universal   = FOR EVERY "(" identifier ":" type_ref "," expression ")" ;
existential = THERE EXISTS "(" identifier ":" type_ref "," expression ")" ;
atom        = … | universal | existential ;
```

FOR, EVERY, THERE, EXISTS are individually reserved expression words, ignoring
case. The existing FUNCTION and logical keywords remain reserved. A keyword needs
a non-word boundary: `everywhere` remains an identifier. The two-word introducers
require ordinary token separation. A declaration name cannot contain a reserved
binder word. Type constructors still use the existing type grammar.

The comma after the type begins the body. Constructor argument commas are enclosed
in their own parentheses. The matching final parenthesis ends the body. Exactly
one typed variable is introduced; repeat the construct for several variables.
No trailing comma, omitted type, prose type phrase, or unparenthesized shorthand
is accepted. Quantifiers are atoms, so `there exists (x: T, P) and Q` places Q
outside the binder. `there exists (x: T, P and Q)` places Q inside it.

All existing expression precedence rules apply inside the body. Parenthesized
continuation applies across lines; indentation does not change binder scope.
`Assume first: for every (x: T, P), second: Q` has two hypotheses because only the
comma after the matching closing parenthesis is at depth zero. Keywords and
punctuation are recognized before lookup; types never choose a parse.

The pure syntax ASTs are `['Forall', name, typeSpelling, body]` and
`['Exists', name, typeSpelling, body]`. The elaborated AST replaces type spelling
by its canonical type while retaining the source binder name.

## Binding and typing

Resolve the domain in the enclosing environment, then introduce a fresh local.
Reject shadowing of visible locals, type names, aliases, and callable names.
The variable scopes over the body only. Nested binders may refer to earlier
variables in their domains wherever the existing type language supports that
relationship, for example `Vector(n,Real)`. The body must have logical type Prop;
Boolean values are not coerced. Restore the environment even after a failed body.

A quantifier returns the foundational Proposition type. In this prototype its
explicit module binding must be `Proposition() -> Prop`, as for Condition.
This inherited name-based coupling remains migration debt. Quantifiers do not
require a Function type binding; lambdas used inside their bodies still do.

The topology module explicitly declares `Type() -> Lean Type` so theorem-level
`Let X: Type` can introduce a carrier. Its generated wrapper has type `Type 1`,
not `Type`. Thus this profile quantifies over Type 0 carriers. It does not silently
claim universe-polymorphic topology. Generic type variables may appear in later
parameter types; user-selected universe levels remain outside this slice.

## Constructive Lean map

With uniquely resolved domain A and condition P, the targets are:

```lean
∀ (fresh : A), P
@Exists A (fun (fresh : A) => P)
```

Allocate `clean_bound_k` in preorder, starting with zero for each expression.
Skip names present in the enclosing source environment or occurring in its Lean
terms. Source references map to these locals, including references inside nested
domain types and lambda domains. This renaming is essential: a source `n` bound
by the quantifier must not survive as a free `n` in `Fin n`.

Universal quantification constructs a dependent function proposition.
Existential quantification uses Lean Exists, never a pair, a Boolean test, or a
chosen witness. Its domain is explicit; its universe is determined by that domain.
No instance search is introduced by either logical constructor. Domain and body
elaboration retain their existing obligations. Arbitrary value-indexed type
applications and dependent function codomains are not introduced here.

## LaTeX and authoring choice

Render `for every` and `there exists` in English, the variable and domain in math,
and parentheses around the complete quantified condition. Preserve body scope.
Do not use a caret for conjunction. Name and provenance handling are unchanged.

The parenthesized spelling is a recorded implementation choice, not a claim that
it is the final nicest prose syntax. The earlier `there exists B: T such that …`
spelling is not an alias. A future prose spelling needs an explicit body-ending
rule and must normalize to the same AST; it cannot rely on visual indentation or
successful type checking to decide where the predicate stops.

## Checks

- `tests/test_quantifiers.py`: independent AST, scope, capture, grouped assumptions,
  dependent domain renaming, keyword capitalization, negative syntax/type cases,
  explicit foundational binding, topology module loading, and English rendering.
- `tools/check_quantifier_targets.py`: six independently authored canonical Lean
  targets, comparing elaborated types, universes and expression structure after
  binder-name normalization. Includes quantified carriers and dependent dimensions.
- `tools/generate_parser.py --check`: strict generated grammar/lexer validation.
- `studies/topology/verify.py`: four real foundation propositions and proofs, plus
  agreement with Lean preimage, image, and continuity.

The general overloaded-operator/implicit-argument uniqueness audit remains open.
No resource failure may be reported as conformance success.
:::
