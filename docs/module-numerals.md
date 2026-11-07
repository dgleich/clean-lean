:::llm gpt-6 2026-11-07 role=assisted

# Module-owned numeral interpretation: first migration step

Status: proposed, with an isolated parser-only implementation; not accepted as conforming. The working compiler
still has display-name-based numeral handling. The [parser study](../studies/module-numerals/README.md)
checks the annotation grammar, ASCII validation and metadata syntax but explicitly
rejects numeral binding. The isolated declared-operator
prototype rejects unresolved numeral operands. This proposal defines an explicit
first step; it does not settle the implicit/default inference required for the
broader corpus migration.

## Authored declarations and use

```clean
Type Real():
  Means: Real
  Numerals: fun n : Nat => (n : Real)
  Render latex: \mathbb{{R}}

Notation real addition(x: Real,y: Real): Real:
  Infix: +
  Means: x+y
  Render latex: {x}+{y}

Result adding a specified numeral:
  Attribution: local; numeral example; original
  Let x: Real
  Conclude: x + (1: Real) = (1: Real) + x
```

This is proposed source; the isolated parser can read its syntax, but the
declaration interpreter still rejects the Numerals field. Equality also needs an explicit imported declaration;
its availability is not implied by the example. `Nat` in the Numerals payload is
native Lean syntax, just as identifiers in Means are native Lean syntax. It is
not an implicit Clean import or a mathematical meaning assigned to a Clean name.
A module author could attach the same field to a differently named carrier.

For this first step, Numerals is optional metadata on a closed, zero-parameter
Type declaration with a Means body and native result sort Type 0. Its payload is
one native Lean expression of type `Nat → T`, where T is that declaration's
native type wrapper. Parameterized carriers, locally bound carriers and
proof-valued carriers are outside this step. Reject duplicate Numerals fields,
empty payloads, or this field on another declaration kind. The field keyword is
case-insensitive; its native payload follows the existing opaque field/layout
rules. No new string interpolation or native-expression parser is introduced.

The constructor is attached to the resolved declaration identity. It is not a
search over all constructors returning a definitionally equal Lean type. It has
no priority and cannot be selected by import order. Explicit imported aliases
may refer to the carrier through the existing alias-expansion rule; they do not
publish another interpretation. A local type binder shadowing the carrier name
must not fall back to the module declaration.

## Grammar and parse boundary

Add one atom production, schematically:

```text
numeral_annotation := "(" NUMBER ":" type_ref ")"
ASCII validation   := full-match [0-9]+ on the NUMBER spelling
```

The resulting source tree is `NumeralAnnotation(digits, type_tree)`, retaining
the digit spelling and the existing type tree. This is not a general expression
cast. `(x: Real)` and `(-1: Real)` do not enter this production. The proposed
negative spelling is `-(1: Real)`, using an imported prefix operator. Grouped
expressions without a colon retain their existing parse.

The colon distinguishes this atom from a parenthesized expression: the current
ordinary expression grammar has no infix colon. Type arguments, computed indices
and condition annotations are parsed by the existing type grammar, not by a
second interpretation selected through type checking. Layout continuation still
comes from the surrounding parentheses. `1.5`, signs inside the digit token, and
non-ASCII digits are rejected by this production. Leading zeros are accepted:
the tree retains `001`, while the numeral value is the natural number 1.

Reuse the existing NUMBER token; do not introduce an overlapping lexer token.
The syntax-tree constructor validates its spelling against ASCII `[0-9]+` before
publishing a NumeralAnnotation tree. Failure is a syntax error, before type
checking. The existing broader NUMBER token remains unchanged elsewhere. This
makes the new accepted spellings precise without incidental lexer priorities or
an unrelated change to dimension syntax.

## Constructive translation

1. Parse once. Resolve `type_tree` under the existing explicit module/local scope.
2. Require the resulting closed module carrier to own a Numerals attachment.
   Do not inspect native definitional equality to choose another carrier.
3. Let `T` be its root-qualified native type wrapper and `C` its distinct,
   declaration-owned numeral adapter. Generate the adapter with native signature
   `C (digits : Nat) : T := (payload) digits`. The callable identity and payload
   must be retained in checked/bound expressions as with other native adapters.
4. Convert the digit sequence to its mathematical nonnegative integer value
   without consulting the mathematical environment. Emit `C (nat_lit n)`, where n is that value in canonical ASCII decimal
   notation, with no leading zeros except for zero itself. The payload target is
   `Lean.Expr.lit (.natVal n)`. The independent acceptance oracle must inspect
   this structure rather than relying on ordinary overloaded numeral syntax.
5. The result has exactly type T. Operator selection now receives a checked
   operand of T; it neither changes its interpretation nor inserts a coercion.

Thus `(001: Real)` and `(1: Real)` have different source spellings but the same
selected adapter and payload value. Two distinct module carriers that unfold to
Lean Real still have distinct numeral adapters. A generated-name collision in a
caller scope cannot capture either T or C: both references are root-qualified.

LaTeX prints the supplied digits with a visible type annotation, e.g.
`(1 : \mathbb{R})`. Do not silently erase an author's explicit disambiguation.
Whether an optional later presentation mode may hide uniquely inferable
annotations requires a separate rendering rule.

## Acceptance work before implementation is claimed

Required executable cases include independently written source trees and native
adapter/application targets, with every argument and instantiated constant kept.
Test zero, leading zeros, a multi-digit value, renamed carriers, explicit imports,
aliases, shadowing, two carriers with the same native body, and caller locals
named after both generated adapters. Verify named calls and infix/prefix uses
select the same interpretations. Check wrong payload types, missing attachments,
parameterized/local carriers, duplicate metadata, malformed annotations, and
unsupported digit spellings. Re-run strict parser generation and ambiguity tests;
update all expression consumers, including binding closure, substitution,
comparison, automatic assumption names and both renderers.

The native import/instance-isolation and declaration-identity obligations of the
existing native-adapter contract still apply. Passing a simple numeral example
does not discharge them. The [native payload probe](../studies/operator-integration/NumeralPayloadProbe.lean)
checks primitive literals for zero, one, 123 and a large integer, and rejects
ordinary overloaded numeral syntax as a different canonical target. Run it with
`lake env lean studies/operator-integration/NumeralPayloadProbe.lean`. This only
checks the proposed payload mechanism. The isolated parser study checks eleven
syntax cases, including ASCII validation and binding-phase separation. Adapter,
application, expression-consumer, rendering and main-integration acceptance remain
pending.

## Still needed for the final architecture

The desired everyday form remains `x + 1`, not mandatory annotations everywhere.
Expected-type propagation, generic overload constraints, unannotated standalone
numerals, negative literals, and module-declared defaults need an additional
constructive policy. D20's historical Natural default cannot remain a privilege
of that display name. In particular, `1 + 2`, `x + 1`, overloaded calls receiving
`1`, and `(1 + 2) + x` must each have a specified unique target or an explicit
ambiguity error under a fixed environment. Do not use first-success elaboration
or quietly apply this draft's explicit rule as an implicit-default policy.
:::
