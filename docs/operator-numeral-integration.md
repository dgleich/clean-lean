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
fixtures still need migration. The module-load survey after the topology import correction terminated with
status 143 before buffered per-module output was returned. It provides no
module-loading success evidence; targeted native verifiers are tracked separately.

Type-position numeral semantics, parameterized numeral carriers, complete native
instance/import isolation and inference scalability remain open. These limits do
not justify implicit compatibility behavior. Unproved research theorems remain
separate from translated statements and verified Mathlib wrappers.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Common module and first topology revalidation

`library/Common.clean` now explicitly imports `operators.clean` and reuses its
carrier declarations instead of maintaining duplicate types without numeral
constructors. Its finite operations and mathematical conditions remain separate
named declarations. All 15 condition tests and 11 quantifier tests pass; the
condition AST oracle now specifies the retained Real numeral constructor, and
the quantifier fixture explicitly imports the mathematical operators it uses.
The six magnetic-study statements parse again; their native proof checks have
not yet been migrated or claimed as passing.

The [topology revalidation report](../studies/topology/binding-migration.md)
records 33 exact targets and 11 proofs across the foundation and named-index
studies after the operator migration. The remaining topology verifiers still
need revalidation. A fresh full regression run follows the Common migration;
its outcome is pending, independently of the earlier failed run.
:::

:::llm gpt-6 2026-11-07 role=assisted

The topology migration now covers five verifiers: foundation, named indices,
paths, record bundles and indexed subspaces. The last three add 92 per-verifier
exact-target checks and 18 proofs. [The migration report](../studies/topology/binding-migration.md)
distinguishes repeated adapter checks and records the next actual failure:
equality of bundled Type-1 spaces is outside the current Type-0 generic equality
signature. This requires explicit library/universe support, not a fallback.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Bundled-space equality and name-scanner correction

The Common-migration full run finished: 668 tests in 582.290 seconds, with 40
failures and 116 errors. Counts differ from the preceding run partly because
failing class setup skips tests, so these totals are not a like-for-like pass rate.

The next working-tree checkpoint adds the explicitly declared
[same-space equality adapter](large-carrier-equality.md), validating 30 exact
native targets and five proofs, plus two incorrect-universe rejection cases.
It also fixes a real Python scope error introduced during numeral integration:
imports of `re` and `ID` inside one `tree_names` branch shadowed their module
bindings throughout the function. Removing those redundant imports restores
name scanning for raw binder and type annotations. No Clean binding or target
rule changes. Tests now explicitly import the operators their fixtures use.

All 44 focused family-comparison, hygienic-substitution and space-equality tests
pass on the working compiler. A direct regression checks the raw annotation,
lambda, quantified and numeral-annotation branches. A fresh full run after these
changes is underway; no full-suite pass is claimed. Proof-valued equality remains
an observed unsupported case, distinct from the now-supported space equality.
:::

:::llm gpt-6 2026-11-10 role=assisted

The full run after the bundled-space and name-scanner changes finished with
692 tests in 1398.891 seconds: 44 failures and 71 errors. This is a failed
regression run, separate from the focused successes. Remaining failures include
fixtures missing explicit operator imports, outdated native expectations and
unsupported carrier cases; each needs diagnosis rather than blanket expectation
replacement.

Four more topology verifiers pass with independent expectations retaining the
declared operators: evidence, homology, local names and chain squares. They add
112 per-verifier canonical checks and 13 proofs. The
[topology report](../studies/topology/binding-migration.md) records ten of eighteen
verifiers revalidated and the eight still pending. This does not establish full
compiler conformance or prove the research theorems.
:::

:::llm gpt-6 2026-11-10 role=assisted

Pair composition adds 24 canonical checks and six proofs, bringing current
topology revalidation to eleven of eighteen verifiers. Its proof parameters and
results retain explicit equality/subset wrappers; native adapter bodies and
extracted proof auxiliaries remain independently checked. This checkpoint changes
verification expectations and generated artifacts, not language semantics.
:::

:::llm gpt-6 2026-11-10 role=assisted

Interlevel and compact image add 79 canonical checks and fourteen proofs to
working-compiler validation, bringing topology to thirteen of eighteen verifiers.
Interlevel retains declared scalar/logical/set operations and a real numeral
constructor in its independent expected terms. Its suffixed oracle notation is
local Lean test notation, not a Clean language extension.

The relative-homology failure additionally exposes the need for
[inferred value parameters](inferred-value-parameters.md): a two-operand equality
for modules must recover their field structure from their types. This is now a
specified proposal with pending acceptance cases, not an implemented feature.
:::

:::llm gpt-6 2026-11-10 role=assisted

The relative-homology obstacle is resolved for its concrete carriers by
[direct inferred values](inferred-value-parameters.md) and two explicit equality
adapters. This is a working compiler change, not a return to builtin equality.
The recovered field is type-checked and explicitly supplied in the Lean target.
Relative homology passes 28 canonical checks and four proofs; additional inference
checks cover computed values, dependent callable arguments and capture/conflict
rejection. Fifty-five focused tests and the 92 corpus proofs pass. The fresh full
regression is still running; the earlier run of the initial inference revision
was deliberately terminated after source changes and is not counted as passing.
:::

:::llm gpt-6 2026-11-10 role=assisted

The inferred-value full run finished with 693 tests, 44 failures and 70 errors.
A subsequent [retained comparison correction](retained-comparison-scope.md)
addresses newly exposed topology conversion inconsistencies. Sixty focused tests,
relative maps' ten canonical targets and three proofs, five native inference
targets and two proofs, and the 92 corpus proofs pass on the corrected compiler.
A fresh full regression and the well-group verifier remain active; neither is
counted as passing. Previous failed full runs remain evidence of unfinished work.
:::

:::llm gpt-6 2026-11-10 role=assisted

Well-group revalidation subsequently completed: 30 canonical targets and five
new proofs pass, along with fifteen supporting proofs. The topology migration
now covers sixteen of eighteen verifiers cumulatively. The fresh full regression
is still pending; no full-suite pass is claimed.
:::

:::llm gpt-6 2026-11-10 role=assisted

Shifted perturbations adds seventeen canonical checks and six proofs, with twenty
supporting proofs rechecked, bringing cumulative topology migration to seventeen
of eighteen verifiers. Its statements retain declared scalar operations and the
real numeral constructor. Extreme images and the full regression are pending.
A separately diagnosed library conflict remains: the logical `equivalence`
declaration collides with the existing type-equivalence constructor in
`library/logic/equivalences.clean`; this needs an explicit naming correction.
:::
