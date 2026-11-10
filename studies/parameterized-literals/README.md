:::llm gpt-6 2026-11-10 role=assisted

# Parameterized zero design

This is a proposed language extension, not an implemented study.
Read the [contract and unresolved inference obligations](../../docs/parameterized-literals.md).

- [Zero.clean.proposed](Zero.clean.proposed) shows exact-zero metadata attached to
  ordinary named vector/matrix constructors. The current compiler does not accept it.
- [NativeExample.lean](NativeExample.lean) checks the intended native constructor
  shapes and two coordinate-zero proofs. It is handwritten, not generated from
  Clean and not a canonical translation oracle.

Run `lake env lean studies/parameterized-literals/NativeExample.lean` from the
repository root to check the native example. That check passes under the pinned
Lean/Mathlib environment. Parsing, attachment eligibility, inferred vector/matrix
zero, default interaction, binding consumers and canonical target checks remain
pending. Completing annotated zeros alone would not complete the required
ordinary form `x != 0`.
:::


:::llm gpt-6 2026-11-10 role=assisted

## Determined-carrier pattern model

`pattern_model.py` executes the proposed direct-recovery matching phases over a
separate symbolic representation. Run:

```sh
python3 -m unittest discover -s studies/parameterized-literals -p test_pattern_model.py -v
```

Twenty tests pass. They cover vector and rectangular/square matrix shapes,
identity-based naming, computed constraints deferred until recovery, invalid
attachment parameters, ordered dependent typing and incomplete/error propagation.
Callbacks stand for already checked type comparison, expression evaluation and
parameter typing; the tests do not establish those callbacks for real Clean.

This is design evidence for one component. It does not parse `Literal`, generate
Lean, infer unannotated zeros, apply defaults, or check the native wrapper. The
compiler imports none of this code. The full extension remains unimplemented.
:::


:::llm gpt-6 2026-11-10 role=assisted

## Joint constraints and simultaneous defaults

`constraint_model.py` explores a finite declaration-row solver with structural
unification and simultaneous defaults. Eighteen tests check operand-order
independence, dimension recovery, unresolved competitors, conflicting defaults,
identity ambiguity and incomplete-analysis propagation. Run both design models:

```sh
python3 -m unittest discover -s studies/parameterized-literals -p 'test_*model.py' -v
```

All 38 tests pass. The model takes already constructed symbolic rows; it does not
extract rows from Clean types, check dependent proof arguments, parse literal
metadata, or emit Lean. It is evidence for the proposed policy, not an implemented
inference feature. See the [detailed policy](../../docs/parameterized-literals.md#executable-joint-constraint-experiment).
:::
