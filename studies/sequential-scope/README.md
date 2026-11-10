:::llm gpt-6 2026-11-07 role=assisted

# Statements between imports and declarations

[Statements.clean](Statements.clean) states reflexivity for an arbitrary carrier
`T`, then declares an unrelated global type named `T`, then imports an absolute-value
wrapper for a second result. The first theorem must still quantify over its own `T`.
The [scope contract](../../docs/sequential-scope.md) specifies snapshots, rendering,
negative cases, and the remaining native import-isolation limitation.

Run from the repository root:

```sh
LAKE=lake python3 studies/sequential-scope/verify.py
```

The driver checks the item order and two independent expression trees, then generates
[Generated.lean](Generated.lean), [Statements.tex](Statements.tex) and
[Verified.lean](Verified.lean). Four canonical comparisons cover the absolute-value
and zero wrappers and both statements; two proofs check reflexivity and Mathlib's
`abs_nonneg`. The [PDF](Statements.pdf) shows both statements.

The initial numeric `0` failed for the deliberately renamed type `Scalar`. Its
replacement, `scalar zero()`, makes that foundation explicit; main's general numeral
interpretation still needs migration. One initial test expected the wrong diagnostic
substring for an unavailable source; the corrected expectation matches the existing
`Unknown attribution source` error. Neither correction changes the scope rule.

This is sequential Clean visibility, not isolated module compilation. The imported
module still uses the existing flattened environment, and emitted Lean imports are
collected at the top of one output file. Later native-instance effects remain an
open conformance obligation; the fixture keeps native imports fixed.
:::

:::llm gpt-6 2026-11-10 role=assisted

## Explicit operator migration

The foundation now imports the explicit standard operator module. Its local
`Scalar` remains a separate declared native type wrapper; the later operations
module declares scalar order explicitly. Equality is the imported polymorphic
condition. No compiler built-in or implicit operator environment was restored.

The native oracle names each declared type/operator wrapper, including the
carrier-of-types wrapper. It compares exact elaborated structures rather than
unfolding all wrappers to make old expectations pass. Four canonical targets and
two proofs pass after migration. The affected inference and scope tests also
pass as a group (29 tests): their fixtures now import the operators they use,
and the inferred natural literal expectation names its declared numeral
constructor instead of expecting a bare Lean digit.

This changes the fixture's explicit environment, not the sequential-scope rule.
The earlier snapshot must still exclude later declarations and imports. The
native-instance isolation limitation above remains open.
:::
