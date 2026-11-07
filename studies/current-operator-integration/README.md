:::llm gpt-6 2026-11-07 role=assisted

# Operators and numerals on the current binding implementation

This integration patch applies to `f2b8a100765f2e871babc5ddb82330a76607dc59`,
which already contains the seven binding repairs, fresh retained-call comparison,
and the restored structural-index diagnostics. It does not replay the historical
binding patches. The working compiler is unchanged while library migration is pending.

Run `python studies/current-operator-integration/verify.py` in the parser development
environment with the pinned Lean dependencies installed. The driver exports the
specified commit, applies the combined patch, regenerates the parser with strict
checks, and runs independent native target checks. Its temporary checkout isolates
both sources and generated outputs. The `.lake` dependency directory is shared.

## Integration corrections

The historical operator patch conflicted at the retained-call implementation.
The integrated version preserves current identity validation and checked-argument
reuse, while retaining operator presentation metadata. Checked native arguments
must not be replaced by their original source syntax during binding closure.

For an operator expression, elaborate it first and recursively close the children
of that checked tree. In particular, closing `1=1` under `Default numerals: Counting`
retains Counting numeral constructors. Reusing this closed expression in a separately
constructed Real-default environment keeps those constructors. A fresh `1=1` there
selects Real. Both environments import the same declarations explicitly.

A raw Decimal reaching binding closure without prior elaboration is rejected.
Closure is not a second opportunity to infer its meaning. Normal expression
elaboration completes digits before binding; a direct raw `equal(1,1)` closure
request must therefore fail. This boundary makes the distinction testable.

The retained-call freshness fixture now explicitly declares equality with `Infix: =`.
The original fixture relied on the built-in equality dispatch being removed by
this migration. Its identity-mutation, changed-argument and incomplete-analysis
assertions remain intact.

## Validation and remaining work

Direct checks on the combined current-base checkout passed:

- Defaults: 8 exact native targets and 4 proofs.
- Contextual inference: 15 targets and 4 proofs.
- Explicit/inferred numeral consumers: 19 targets and 2 proofs.
- Explicit Mathlib foundations: 38 targets and 6 proofs, including dependent
  matrix dimensions, import order and missing-operator rejection.
- Seven retained-call freshness regressions after the explicit equality migration.
- Retained numeral scope and unresolved-Decimal closure checks.

These are 80 distinct target cases and 16 proofs, not a complete language
conformance claim. A fresh reconstruction passed the complete driver, including strict parser
regeneration and 24 parser/freshness regressions. Full working-compiler regression runs remain
separate and have not been reported as passing.

Before applying this to the working compiler, migrate the library and corpus to
explicit operator declarations and numeral constructors/defaults. The old modules
cannot rely on display-name dispatch or an implicit Natural default. Type-position
numerals, parameterized numeral carriers, the finite assignment budget, and full
native import/instance isolation remain documented limitations. No research theorem
is proved by this integration.
:::
