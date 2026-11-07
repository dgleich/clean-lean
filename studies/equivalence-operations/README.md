:::llm gpt-6 2026-11-07 role=assisted

# Inverse and composition of equivalences

Import `library/logic/equivalence_operations.clean` to construct inverse and
composite equivalences in Clean. For `e: Equivalence(A,B)` and
`f: Equivalence(B,C)`, `compose equivalences(e,f)` has type `Equivalence(A,C)`:
apply `e` first, then `f`. The LaTeX form is `(f ∘ e)`, including parentheses
so subsequent application or inversion has the same meaning.

```text
Let e: Equivalence(A,B)
Let f: Equivalence(B,C)
Let g = compose equivalences(e,f)
Let h = inverse equivalence(g)
```

Both constructions use `Define … Equals:`. Their forward/backward functions and
inverse-law evidence are written in Clean. The module imports foundational
wrappers for `Equiv`, function application and congruence, and imports the existing `Eq.trans` wrapper from `equality_chains.clean`. It
declares wrappers for `Equiv.symm_apply_apply` and `Equiv.apply_symm_apply`. It does
not import Mathlib's composition or inverse construction as an opaque body.
Carriers remain in Lean `Type 0`, as in the existing equivalence module.

This is an example of writing proof-producing functions using the existing
language. The nested transitivity and congruence expressions are verbose; they
are a useful readability specimen for future local proof syntax. This module
adds no new grammar or implicit proof search.

`Statements.clean` states inverse evaluation, composite evaluation and a composite
round trip. `Generated.lean` contains their generated definitions and statements;
`Verified.lean` additionally contains independent exact-target oracles and proofs.
The inverse evaluation statement prints the same notation on each side because
both the inverse construction and backward evaluation conventionally use the
inverse superscript. The Clean source distinguishes the two operations.

Validation with the pinned dependencies:

- `LAKE=lake python3 studies/equivalence-operations/verify.py`: eight exact
  elaborated target comparisons and three kernel-checked proofs pass.
- Seven focused Python tests pass: carrier inference, composition order, inverse
  direction, both inverse-law proposition types, authored construction bodies,
  and joint imports with the equality-chain module in either order.
- The one-page PDF is compiled twice and inspected. No unresolved references or
  overfull boxes remain.
- The 92-statement proof corpus was regenerated and kernel-checked successfully.
  Reference links, search, mobile width and the no-JavaScript fallback pass.

The exact comparisons check the four new definition bodies and shared transitivity body and all three theorem
statements. They include the explicit proof terms rather than checking only
extensional equality to Mathlib's constructions. No axioms or `sorry` are added.
The global suite and review-browser refresh remain pending separately; this
study does not establish general language conformance or the interval-label theorem.
:::
