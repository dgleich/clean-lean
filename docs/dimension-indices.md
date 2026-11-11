:::llm gpt-6 2026-11-06 role=assisted

# Dimensions use checked value indices

Implemented migration of every declared Natural type-parameter slot from raw
strings to typed expression indices. This removes the dimension-alias exception
recorded in [local definition conversion](local-definition-conversion.md).
It does not add a new mathematical dimension operator or change the grammar.

```clean
Let n: Natural
Let m = n
Let A: Matrix(n,n,Complex)
Let B: Matrix(m,m,Complex)
Conclude: det(A*B) = det(A)*det(B)
```

The [dimension study](../studies/dimensions/Statements.clean) includes this statement,
transpose, explicit literal arguments, and a vector with its dimension stored in
a record. All four statements have native Lean proofs.

## Parsing, checking, and representation

The existing type grammar accepts a numeral, declared name, field reference, or
parenthesized computation in a dimension slot. It constructs that syntax before
consulting the type constructor. The explicit module declaration identifies the
slot as Natural; no Matrix/Vector/Graph name dispatch is added here.

Elaborate the argument in the current earlier-local environment. A decimal literal
receives Natural in this slot, with or without the expression parentheses; an otherwise checked value
must have Natural type. Undeclared names and Real values are rejected. Bare negative
numerals are not type-argument syntax. Parenthesized prefix expressions are checked
through their explicit module declarations like other expressions; a unique
Natural-valued interpretation is allowed. The standard module has no Natural
prefix-minus meaning, so ordinary negative dimensions remain rejected. This rule
does not assign a mathematical meaning to a token or insert a numeric conversion.
Binary Natural subtraction retains its declared truncated semantics. Determined
literal computations such as `(1+1)` are accepted without proving arithmetic
equality to 2. Calls retain their declared types and native-adapter obligations.

Store a DimensionIndex containing the source name/spelling, checked Lean term,
LaTeX, source expression tree, and comparison key. It is a value index with a known
Natural slot, including for simple names and literals. Build its comparison key
using the same checked immediate-lambda preprocessing and bounded authored/local
expansion rules as other value indices. Keep the original term for emission.
No arithmetic evaluation, assumed equality rewriting or native-adapter unfolding
is added. In particular, `n+0` need not compare equal to `n` in Clean.

For substitution in returned types and record fields, substitute the stored tree
and recheck it as a Natural dimension. This preserves the index kind even when
its source is a preceding natural-valued field. An implicit dimension variable
matches only a dimension slot, not an arbitrary expression or type argument.
Dimension equality and hashing use the comparison key under the checked slot;
source spelling and rendering do not choose equality.

## Calls and one target

Signatures containing dimensions now use the existing structured dependent-call
path. Match arguments in declaration order and type-constructor arguments from
left to right. Each repeated inferred dimension must compare equal to the previous
one. The last consistent occurrence supplies the representative term retained
for that inferred argument; this is a specified ordered rule, not search or an
incidental container order. Thus a square-matrix argument with row dimension n
and column dimension m, where m is locally defined as n, selects m for det's one
inferred dimension.

Emit `@wrapper` with all inferred arguments explicitly in declaration order,
followed by authored arguments. Substitute the same selected representatives into
the result type. Preserve authored local lets and their original annotations.
Lean validates the definitional conversions; the compiler inserts no cast or proof.
Existing concrete numeric-argument compatibility for Natural, Real and Complex is
retained on this path. This does not solve generic literal/type inference or the
broader native-adapter elaboration contract.

For a quantified dimension, use the bound Lean local's identity, not its source
name. This repairs a second limitation of storing dimensions as bare strings.
Rendering and automatic assumption labels continue to use the source name.

## Acceptance and remaining work

`tests/test_dimension_indices.py` checks the independent index representation,
equality/hash, representative selection, conflicting dimensions, explicit literals,
authored expansion, arithmetic nonconversion, local aliases, bound identities,
and record-field substitution. Existing dependent-call and local-definition tests
now expect dimensions to use the same typed mechanism.

`studies/dimensions/verify.py` compares five independent native targets without
unfolding away lets or wrapper applications, and proves the four statements.
The corpus, native definition oracles, magnetic study and named-index study cover
previous dimension users. Tests and kernel checks remain evidence for this bounded
contract, not a claim of complete language conformance.

General dependent function types, binder-bearing local conversion, universe
polymorphism and the topology research-theorem obligations remain separate work.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Module-declared prefix values in dimensions

The previous token-based veto on unary minus has been removed. It ran after
Natural type checking and contradicted the explicit-module rule: a module may
declare a Natural-valued prefix callable. Dimension formation now requires the
same unique checked interpretation as any Natural value and then uses the existing
index storage/comparison rule. For example, a module may explicitly define a
truncated opposite with body `0 - x`; `Vector((-n),Real)` then carries that
wrapper application, not an inferred negative integer or a coerced Real.

The parse remains `ComputedIndex(Unary("-",Local("n")))`. Resolve the prefix
through the existing declared overload set using its input signature; reject
ambiguity and non-Natural results. Retain the chosen binding and original term
in the DimensionIndex. Substitution rechecks the retained call through the same
rule. No grammar, implicit conversion, or arithmetic normalization is added.

Six regression cases cover the independent source tree, native spelling, local
alias, payload-only substitution, duplicate meanings and Real-valued rejection.
The existing standard-negative tests remain unchanged. The standalone
`tools/check_dimension_prefix_targets.py` compares three independent native
targets and proves the declared operation's value and two identity examples.
:::

:::llm gpt-6 2026-11-11 role=assisted

Validation in this step: 24 focused dimension/storage tests and 107 experimental
integration tests pass. Three independent exact prefix-dimension targets and
three supporting Lean proofs pass (`/tmp/clean-prefix-dimensions-native.log`).
Full unittest discovery is running from the immutable snapshot
`/tmp/clean-prefix-dimensions-full-w05n2vyi`, with output in
`/tmp/clean-prefix-dimensions-full.log`; it is not a completed pass. Prior snapshot
jobs were confirmed live and were not restarted or counted as successes.
:::

:::llm gpt-6 2026-11-11 role=assisted

The production integration run finished with `Failures: []`: strict parser
regeneration, 527 Python tests, native target/proof checks (including the new
prefix oracle), and the regenerated 92-result proved corpus. Log:
`/tmp/clean-prefix-dimensions-integration.log`. This is scoped integration
evidence; full discovery remains running and is not reported as passing.
:::
