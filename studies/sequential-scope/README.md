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
