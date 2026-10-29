:::llm gpt-6 2026-10-29 role=assisted

# Parenthesized typed function expressions

This bounded implemented slice supplies an explicit lambda to module-declared
operations such as map, filter, and finite sum. It does not introduce special
mathematical meaning for any of those operation names. The magnetic study uses it
to author the profile and Fourier sum in Clean, without a paper-specific Lean adapter.

```text
function(x: Real, x*x)
map(function(b: Boolean, choose(b,A,real transpose(A))),w)
sum before(m+1,function(k: Natural,
    magnetic phase(2*q*real index(k))*complex matrix(walk profile(A,m,k))))
```

These spellings are an initial practical choice. More natural binding notation
for sums is still proposed; it is not silently accepted by this change.

## Grammar and parse uniqueness

Add this production to the expression `atom` production:

```text
function-expression ::= FUNCTION '(' identifier ':' type-expression ',' expression ')'
FUNCTION            ::= 'function'  (case-insensitive)
```

The keyword is reserved at a call head: a Notation/Define whose entire name is
`function`, ignoring capitalization, is rejected. Multiword names remain normal
calls. Type expressions here use constructor syntax, not prose phrases. Parenthesis
depth uniquely locates the comma separating the type from the body; commas within
nested type constructors do not terminate the type. The body uses the existing
precedence grammar and stops at the matching closing parenthesis. A second body
argument is an error. The whole construct is an atom, with no new precedence rule.
The normalized AST is `['Lambda', binder, canonicalDomainType, bodyTree]`.

Existing parenthesized continuation rules apply. No new indentation scope is
introduced: newlines inside the parentheses continue the expression; tabs remain
forbidden, and full-line comments remain ignored. The comma and closing parenthesis
fix the scope, regardless of indentation. No backtracking or Lean typechecking is
used to select a parse.

## Scope and typing

The binder has one explicit type, resolved before introducing it. It scopes over
only the body. Capturing earlier locals and nesting functions are allowed. Shadowing
visible locals, types, or notation names is rejected in this slice; `function` itself
cannot be a binder. The local environment is restored even if body parsing fails.
The body must have a determined type independent of this binder. A bare numeric
literal body is rejected, since the prototype has not selected its numeric type.
Dependent codomains and inference from an expected return type are not supported.

The explicit environment must have exactly one two-type-parameter declaration
whose Lean template is `({0}) → ({1})`, allowing whitespace differences. Its display
name is immaterial; it can be `Function`, `Mapping`, or another name. No match or
multiple matching declarations is rejected. This is a restricted, syntactic Lean
arrow interface, not an arbitrary Lean-template equivalence test. Aliases resolve
to their existing canonical type before expression typing. Existing local function
application recognizes the same interface and uses the bound Lean term.

## Constructive Lean and LaTeX mapping

Given unique targets for domain T and body e, emit exactly
`fun (fresh : T) => e`, with an explicit binder, replacing references to the source
binder by `fresh` during scoped expression construction. The return type is the
registered arrow family applied to T and the body's type. No coercion, implicit
argument, typeclass instance, or proof argument is introduced by this constructor.
Those already present in T and e retain their existing obligations.

Fresh names are `clean_bound_0`, `clean_bound_1`, … in preorder within an expression.
Skip names appearing in the current local-name set or as identifier tokens in its
emitted terms. Increment after allocation. Nested binders receive distinct names;
sibling closed scopes may use distinct preorder numbers. Bound function calls use
the generated name, not the original spelling. The canonical Lean comparison
ignores binder display names and metadata only; it retains all other constructors,
universes, implicit arguments, and binder information.

LaTeX renders a parenthesized `x ↦ body`. The binder retains the authored display
name; the type remains explicit in Clean and the Lean target. A module-declared
sum rendering can display this function using its normal template.

These rules uniquely determine this constructor's parse and target whenever its
subexpressions have unique targets. They do not repair the older translator's
unresolved general overload/instance/coercion obligations. No whole-language
conformance claim follows from this implementation.

## Acceptance evidence

`tests/test_function_expressions.py` has independent AST/text oracles for identity,
capture, nested function application, deterministic hygiene, alternate arrow names,
and negative cases (shadowing, missing types/bodies, extra arguments, missing or
ambiguous arrow bindings, and undetermined literal types).
`LAKE=/path/to/lake python3 tools/check_function_targets.py` compares three independent
elaborated Lean target/type pairs without reduction or definitional equality.
The magnetic study checks the interaction with nested finite sums, dependent finite
index domains, list mapping/filtering, and the actual translated theorem proofs.

The acceptance catalog records this as a bounded slice. General environment search,
resource-exhaustion reporting, and canonical target checks for every inherited
operator remain pending under the language acceptance contract.
