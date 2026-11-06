:::llm gpt-6 2026-11-06 role=assisted

# Local definitions in dependent indices

Implemented bounded extension of [definition conversion](definition-conversion.md).
A local `Let M = relative homology(field,H,X,Q.source)` can now be used as the
ambient module in `ModuleElement(K,field,M)` or in `module map value(field,M,N,f,x)`.
The latter accepts a map whose original signature used the defining expression.
The [working specimen](../studies/topology/LocalNames.clean) names its modules and
chain complexes once and uses those names in later formulas.

## Parsing and scope

There is no new grammar. `Let name = expression` and its existing `Define` synonym
still bind a fresh name after elaborating their right-hand side. Forward references,
self references, shadowing, type-valued local definitions and local condition
abbreviations remain rejected. Context clauses are flattened in the specified order
before elaboration, so an inherited local definition obeys the same rule.

## Deterministic comparison rule

At a local definition, compute its comparison value in the environment of earlier
declarations. If its checked expression tree contains Lambda, Forall or Exists,
leave the local opaque. Otherwise apply the existing ordered comparison normalizer.
Save the result only when its type equals the checked right-hand side's type.
The resulting expression is frozen with the local binding; later declarations
cannot change it. This cache contains a checked expression, not source text to be
reinterpreted in a different scope.

When comparison normalization encounters a Local node, use its saved comparison
value if present; otherwise retain the local. Existing projection, argument and
operator traversal then applies. A local function call normalizes its head as well
as its argument, allowing `Let f = g` to compare `f(x)` with `g(x)`. A lambda-defined
local function remains opaque in this bounded profile. Native adapters stay opaque:
`Let M = native construction(...)` matches that wrapper application, without
inspecting its Lean body. Ordinary typed variables and equality hypotheses do not
supply comparison values. No mathematical equality search is performed.

Earlier local definitions may be used by later ones. The ordered declarations and
acyclic authored-module definitions make this a finite deterministic expansion;
resource exhaustion must still be reported as incomplete analysis. Comparison
keys and their hashes use the resulting term under the existing typed-slot rules.
The rule extends comparison, not the grammar or the set of inferred instances.

## Exact Lean target and presentation

The translator still emits an explicit Lean `let` with the original checked type
and original right-hand side. Subsequent authored occurrences use the local name.
It does not replace them with their comparison values. Inferred annotations retain
the expressions selected when they were inferred; they are not rewritten to use
recently introduced abbreviations. Lean validates their definitional conversion.
No casts, implicit evidence, tactics or proof search are inserted.

LaTeX and automatic assumption labels also retain the authored local name. The
comparison value is not a presentation tree. Existing constructor-projection
reduction remains its separately specified operation.

`tests/test_local_conversion.py` checks conversion, preserved annotations, chained
aliases, projection, function-call heads, naming, rejected self references and
absence of equality-assumption rewriting. `verify_local_names.py` independently
specifies two native propositions, including every let and inferred type, and
compares their canonical elaborated expressions without delta/zeta reduction.
It also proves their image-membership and quotient-map-commutation conclusions.
These proofs concern existing constructions, not any unproved research theorem.

This rule applies to typed value-index comparison. The older bare-natural dimension
slots (for example `Vector(n,Real)`) still compare their stored dimension names;
they do not yet use this comparison-value mechanism. Migrating those legacy slots
is a separate tracked gap, not evidence that two differently named dimensions differ
mathematically.

Binder-bearing local bodies, native definitional equality, arbitrary dependent
function types and universe-polymorphic inference remain outside this extension.
:::
