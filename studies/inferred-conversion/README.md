:::llm gpt-6 2026-11-06 role=assisted

# Checked inferred arguments in comparison

[Statements.clean](Statements.clean) exercises the
[inferred-argument conversion rule](../../docs/inferred-argument-conversion.md).
The definitions are authored in Clean. Explicit imports supply the existing
Mathlib foundations and diagram library; no new native mathematical definition
is hidden behind the examples.

```clean
Let N = pull back diagram(field,Q,R,f,M)
Let v: V
Conclude: module identity(field,N.object(v)) = module identity(field,M.object(f.vertices(v)))
```

This short pullback now exposes the same computed module index as the original
diagram's selected object. Inferred named carrier parameters participate in
hygienic expansion. The generated Lean statement still retains the short wrapper
and local let; comparison does not rewrite the emitted theorem.

Other specimens use primitive, function and dependent vector-family types in an
inferred lambda annotation, a computed matrix dimension, and a literal dimension.
In the matrix-entry example, later vertex arguments select n as the dimension
representative, exactly as specified by the existing ordered matcher.

Run `LAKE=lake python3 studies/inferred-conversion/verify.py` from the repository.
The verifier generates [Generated.lean](Generated.lean), [Statements.tex](Statements.tex)
and [Verified.lean](Verified.lean). Four definition targets and six proposition
targets are compared with independently authored Lean targets as canonical raw
expressions, not merely up to definitional equality. Six Lean proofs establish
these elementary identities. No axioms or sorry are introduced.

Integrated validation passes all ten exact targets and six proofs, plus fourteen
focused Python tests and the strict generated-parser check. The PDF compiles twice
and was visually inspected; the reference page passes search, local-link and mobile
width checks. The previous shape-pullback, diagram-map and zigzag studies pass
85 exact targets and 21 proofs, and all 92 corpus proof fixtures pass. The full
Python run completed: 561 tests in 2427.321 seconds, with one obsolete opacity
assertion failing for a subset certificate instantiated at a named carrier. That
assertion now checks the exact constructor tree and target instead. All fifteen
conversion tests pass with the corrected expectation; the follow-up type-expression
snapshot has its own full run in progress. The refreshed browser covers 106 files with zero
translation errors; its source hashes, inventory, navigation, notes, responsive
layout and no-JavaScript fallback have passed validation.

The later [type-expression study](../type-expressions/README.md) removes the
named-local-only boundary for inferred types used as values. Explicit `type(T)`
expressions now cover primitive, compound and dependent carriers. These identities are not
proofs of the paper's interval-basis or pyramid theorems.
:::
