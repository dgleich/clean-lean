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
