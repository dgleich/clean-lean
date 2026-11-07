:::llm gpt-6 2026-11-07 role=assisted

# Declared operators and numerals in the working compiler

The working compiler now includes the current-base operator/numeral integration.
Mathematical operators resolve only through explicit module declarations.
Expression-position numerals use declared carrier constructors, exhaustive
contextual completion, and optional explicit defaults. The detailed constructive
rules remain in [module operators](module-operators.md), [numeral bindings](module-numerals.md),
[contextual completion](numeral-inference.md), and [defaults](numeral-defaults.md).
This is implementation progress, not full language-contract conformance.

## Explicit standard vocabulary

`library/types.clean` declares numeral constructors for Natural, Real and Complex.
Importing it alone supplies neither arithmetic operators nor a default carrier.
`library/operators.clean` imports those types and declares the supported logic,
scalar arithmetic/order, matrix/vector arithmetic, pointwise real function arithmetic,
set operations, list/set membership and natural divisibility. It explicitly declares
`Default numerals: Natural`. The four curated subject modules import this vocabulary.

For example, after `Import "../library/operators.clean"`, `1` selects Natural,
while `x+1` with `x: Real` selects Real through the signature constraints. Matrix
multiplication and matrix-vector application use different declarations attached to
`*`, with dependent dimensions checked before selection. Reversing the declaration
list does not change a uniquely selected meaning. Missing and ambiguous meanings
remain errors. No implicit fallback to a display-name-based operator is retained.

The module currently lists concrete Real and Complex matrix/vector operations.
General coefficient-carrier operations require explicit algebraic structure evidence;
this implementation does not insert that evidence silently. The broad shared module
is an initial standard-library migration, not a final modularization of Mathlib.

## Binding and native validation

Operator closure retains the checked operand trees. Bound numeral constructors
therefore survive reuse in a different default scope. Raw unresolved Decimal
nodes are rejected at the closure boundary. Native targets retain root-qualified
constructor names and primitive natural literal payloads.

The 92 corpus statements translate with these declarations. Their proof generator
unfolds numeral constructors and applies `Nat.cast_zero` / `Nat.cast_one` before
using the existing Mathlib proof terms. Those cast laws are propositional facts;
we do not claim that Real/Complex casts are definitionally the old numeral syntax.
The optional normalization step tolerates statements without numeral occurrences;
the subsequent proof term must still close the goal.

Ten focused standard-import, dependent-overload, numeral-scope and retained-call
freshness tests passed, as did 17 generated-parser regressions. Lean checked all
92 generated corpus proofs (unused simp-argument warnings remain). The strict
generated parser was rebuilt. The four subject Lean/TeX/metadata outputs were
regenerated. The 15-page specimen compiled twice without box or unresolved-reference
warnings; selected pages were visually inspected. Its separate Stewart section
still uses the previously generated fixture and is not part of this validation.

The previous full runs (historical binding stack and pre-operator working compiler)
were explicitly terminated when this implementation superseded their source versions.
Neither was counted as passing. The fresh full run finished: 641 tests, 48 failures and 336 errors. It exposes
unmigrated fixtures and modules; no full-suite pass is claimed. After that run,
`library/topology/basic.clean` was changed to explicitly import the operator module.
The separate `Common.clean`, downstream topology exact-target oracles and older
fixtures still need migration. A module-load survey is running after the topology
import correction; loading alone does not certify its Lean targets.

Type-position numeral semantics, parameterized numeral carriers, complete native
instance/import isolation and inference scalability remain open. These limits do
not justify implicit compatibility behavior. Unproved research theorems remain
separate from translated statements and verified Mathlib wrappers.
:::
