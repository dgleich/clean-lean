:::llm gpt-6 2026-11-06 role=assisted

# Conversion using checked inferred arguments

This extends comparison of authored Equals definitions, without changing grammar
or emitted calls. In a fixed explicit module environment, call elaboration already
selects its implicit arguments. Retain those checked arguments in declaration
order as comparison metadata; do not infer a second set from the definition body.
The dependent-call matcher and legacy type matcher retain their existing policies,
including the last consistent representative rule for repeated dimension matches.

## Constructive comparison rule

After normalizing explicit actuals through the existing public comparison boundary,
check the call once. For an authored Equals body with no shadowed module names:

1. Bind explicit formals to these checked actuals simultaneously.
2. Visit implicit formals in declaration order. Only those occurring in the body,
   including binder annotations, need substitution.
3. An inferred type in a type annotation is serialized through the existing type
   grammar. Freshen all its dependent binders, with domains before bodies and
   children left to right. Recheck the resulting type in the caller environment;
   require equality to the stored actual type. Insert it simultaneously: never
   replace caller names inside the inserted type using the definition's formals.
4. An inferred type in an expression position must be a named caller local of type
   Type. Reify its Local expression. A primitive or compound type without such a
   local has no expression spelling in this profile; keep the original call opaque.
   Computed indices inside binder annotations count as expression positions too.
5. An inferred natural dimension uses its stored source tree, or the legacy
   dimension spelling parsed by the existing expression grammar. Recheck it as a
   dimension in the caller scope. For stored ValueIndex values require equality
   to the original checked index. Preserve the selected Natural type for literals.
6. Perform the existing hygienic substitution, reserving caller locals, module
   names, body names, actual-expression names and names in inserted types. Allocate
   the least unused clean_conversion_bound_N in traversal order. Inserted actuals
   are never recursively substituted. Re-elaborate and normalize the expansion;
   accept it only if its determined type equals that of the original expression.
   If the entire authored body is one substituted formal, reuse its checked actual
   before normalizing, preserving the already selected type of a numeric literal.

An unavailable source representation retains the checked original call. Ordinary
errors in expansion are not swallowed. Existing shadowing, opaque native adapters,
local-definition caching and residual-binder comparison rules still apply. No
arithmetic simplification, assumption rewrite, native body inspection or search
for another instantiation is introduced. Resource exhaustion is incomplete analysis.

Type reification has two distinct positions: `function(y: T,x)` can substitute
Real, Function(Real,Real), or a dependent vector family for T in its annotation.
But `box value(T,x)` requires a type-valued expression for T; only named Type locals
are currently supported there. Full first-class type expressions remain pending.

## Unique parse and Lean mapping

No source token, production, precedence or AST constructor changes. For example:

```text
pull back diagram(field,Q,R,f,M)
["Call", "pull back diagram", [["Local", "field"], ["Local", "Q"],
 ["Local", "R"], ["Local", "f"], ["Local", "M"]]]
```

The call still emits its declared wrapper with the implicit arguments selected by
its signature matcher. Comparison only permits more checked terms to match; it
never replaces the authored call with its body in the Lean target. A subsequent
call may now accept definitionally equal indices; its existing ordered matcher
still selects one representative. In the matrix-entry specimen, argument B has
matrix size(A) dimensions, but later i,j:Vertex(n) select n for the emitted call.
The native oracle records n explicitly rather than accepting any definitionally
equal target.

Determinism follows from the existing unique source parse, fixed call matcher,
declaration-order substitution, least-unused fresh names, structural type
serialization, and equality/rejection gates. No import iteration, successful Lean
elaboration trial or pretty-printer choice selects a mathematical meaning.

## Acceptance and limitations

The inferred-conversion study checks four definition targets and six proposition
targets against independent native Lean definitions using canonical raw Expr
comparison, including universes and implicit arguments. Six proofs are checked by
Lean. Python cases cover independent source trees, named and unnamed type values,
primitive/compound/dependent annotations, simultaneous substitution, capture,
natural literals and computed dimensions, and both call-checking paths.

These checks cover this rule, not all Lean definitional equality. Native adapters,
compound type expressions used as values and general higher-order conversion remain
outside this slice. The short pullback example does not prove interval restriction
or the pyramid theorem. See the study README for validation status.
:::

:::llm gpt-6 2026-11-07 role=assisted

The later [explicit type-expression rule](type-expressions.md) supersedes the
compound-type-as-value opacity boundary described above. Checked inferred types
now reify to a named local where available or to TypeValue, including dependent
carriers. Other comparison boundaries remain in force.
:::
