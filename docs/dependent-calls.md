:::llm gpt-6 2026-11-06 role=assisted

# Dependent callable signatures

This implements the next bounded slice of [named value indices](value-indexed-types.md).
Notations, authored definitions, and conditions can accept and return types that
contain named value indices. This original bounded profile is extended by [explicit computed indices](computed-indices.md). Binder-bearing expression indices, dependent function-valued
results (Pi types), implicit value indices, and universe-polymorphic APIs are still
outside this slice. Existing nondependent call translation remains unchanged.

## Readable specimen

```clean
Import "../library/topology/indexed.clean"

Notation reverse path(t,x,y,p):
  Let X: Type
  Let t: Topology(X)
  Let x,y: X
  Let p: Path(X,t,x,y)
  Returns: Path(X,t,y,x)
  Means: @Path.symm X t x y p
  Render latex: {p}^{{-1}}
```

X is inferred structurally from the argument types. The topology and endpoints are
explicit, so two topologies on X cannot be silently interchanged. This deliberately
verbose foundational wrapper is usable now; a bundled-path interface is separate
library work. The ordinary compact header is also accepted when all parameters
are explicit. Implicit parameters still require the expanded declaration form.

An authored definition can call this operation twice and return the original path
type. Conditions can compare paths with exactly the same endpoint and topology
indices. These are ordinary declarations, not special Path behavior in the parser.

## Syntax, scope, and evaluation order

No grammar, token, layout, capitalization, or precedence rules change. Headers
and typed Let fields use the existing generated grammar. Calls still normalize to
`Call(name, arguments)`; `reverse path(t,x,y,p)` has four Local argument trees.
Type annotations use the neutral constructor grammar. Parsing does not inspect
indices or ask which candidate type-checks. Existing duplicate-name rejection
ensures that a call name denotes one visible declaration.

Resolve declaration parameter types in order. An index can name only an earlier
parameter. Header arguments must appear in their declared order. Leading omitted
parameters remain restricted to Type and Natural and must occur in argument types.
All definition bodies are checked before publishing the new name: no recursion or
forward-reference semantics are added. Nonparameter metadata fields retain their
existing ordering freedom.

For a signature containing any ValueIndex, retain its resolved structural types,
ordered implicit parameters, ordered explicit parameters, and resolved return type.
This structured telescope is additional semantic data, not another grammar.
The existing signature tree remains the public declaration tree.

## Constructive substitution and target

1. Elaborate every argument expression using the existing expression rules. Check
   arity against the one resolved callable. This does not choose an overload.
2. Match declared parameter types against argument types in declaration order.
   An implicit type variable receives the structurally corresponding Type. An
   implicit dimension receives the corresponding dimension identifier/numeral.
   Repeated occurrences must agree exactly. Other constructor identities, arities,
   and recursively corresponding arguments must match.
3. A declared ValueIndex referring to explicit parameter p is replaced with the
   actual p argument's local identity, Lean term, and LaTeX name. Require that
   argument's syntax tree to be Local whenever it is used as an index. The
   restriction applies whether the use is in another parameter or the result.
   A parenthesized local normalizes to Local and is accepted. A call or arithmetic
   expression must first be named with a local Let. A non-indexed argument may
   itself be a nested call, such as a reversed path.
4. Explicit type-valued arguments substitute their named carrier. Explicit natural
   dimensions used in dependent signatures substitute their named local. Implicit
   dimensions remain inferable from argument types. All actual argument types must
   match; numeric-literal defaulting/coercion is not performed on this new path.
5. Substitute the same identities throughout the return type. Equality of indices
   is the existing ValueIndex equality, not proof search or Lean definitional
   equality. A separately named alias is a different index in this bounded profile.
6. Emit `@wrapper` with **every** implicit argument in declaration order, followed
   by every explicit argument in header order. Render inferred type arguments with
   the current binding environment, so a quantified carrier uses its fresh Lean
   binder. No Lean inference hole is introduced for a callable parameter.

The reversal call has this shape:

```lean
@reversePathWrapper X t x y p
-- result type: @Path X t y x
```

The generated wrapper itself has the fully stated signature and source-declared
Lean implementation. Its readable generated identifier follows existing naming
rules. The pinned Lean/Mathlib environment elaborates that body; opaque adapters
inherit the project's general elaboration audit limitations. This slice does not
claim to remove those limitations. Explicit foundational instances are written in
the adapter (`@Path.symm X t x y p`), and their exact elaborated use is tested.

## Rejections and hygiene

- A path with endpoints x,y is rejected where y,x is required, even if an assumption
  says x=y. A different topology is rejected even when its carrier agrees.
- Conflicting inferred carriers/dimensions fail instead of selecting the first one.
- Missing/unbound dependencies and malformed type syntax retain their earlier
  binding/syntax errors. Wrong arity and mismatched indices are call type errors.
- `constant path(t,choose point(S))` requires a preceding named local.
- A lambda whose return type contains its own bound endpoint is rejected by the
  existing nondependent Function restriction. No index may escape that scope.
- Nested quantified endpoints retain their renamed Lean locals inside both the
  callable target and the returned type. A nested call never replaces those with
  the declaration's original parameter spelling.
- Duplicate callable names continue to fail during module loading. No candidate
  enumeration, imported instance search, or successful Lean elaboration is used
  to repair a Clean mismatch or choose a parse.

Structural traversal has one case for a Type, ValueIndex, or dimension, and every
binder has one resolved identity. Each substitution is determined by its declared
parameter position or the unique structural match. Thus this additional rule has
one result or an error; it introduces neither syntactic nor substitution search.
Resource failure and inherited elaboration uncertainty are not uniqueness evidence.

## Evidence and remaining scope

`tests/test_dependent_calls.py` covers neutral call syntax, ordered substitution,
wrong ambient indices, inferred-carrier conflicts, nested calls, authored definitions,
conditions, named-expression restriction, quantified carriers/endpoints, and lambda
escape rejection. `studies/topology/verify_paths.py` compares five generated wrapper
types/bodies and four statement types/bodies with independently authored canonical
Lean targets, then checks four proofs. Wrapper dependencies use the compared
wrapper identities; no body is validated merely by comparing two pretty-printers.

No new lexical spellings require editor grammar changes. The standard generated
parser, regression tests, old named-index checks, and theorem corpus remain checks.
The acceptance catalog stays partial because the general body/type elaboration
contract, universe polymorphism, and arbitrary expression indices remain open.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Structure extension

The [structure contract](structures.md) extends the named-index rule to stable
field references, e.g. `reverse path(P.topology,P.start,P.finish,P.path)`.
Projected dimensions retain their Lean projection rather than becoming a source
name. Explicit type-valued parameters also trigger structural substitution; this
fixes carrier renaming for authored bundle operations. Computed index arguments
still require a preceding Let. The original Local-only description above records
the first milestone and is superseded on these points.
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
