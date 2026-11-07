:::llm gpt-6 2026-11-07 role=assisted

# Partial inference without caller-name capture

This regression covers a declaration parameter `n` supplied as caller `m`, while a
separate function argument returns caller `n`. A proof-family argument must prove
`n = m`; it must not be checked as `m = m` merely because a later implicit type is
still unknown. See the [matching contract](../../docs/source-pattern-matching.md).

[Statements.clean](Statements.clean) checks an explicit proof-function
argument, direct universal evidence, and inference of a type from a dependent
function codomain before another parameter determines a later type. Run:

```sh
LAKE=lake python3 studies/partial-codomain-inference/verify.py
```

The driver regenerates [Generated.lean](Generated.lean) and
[Verified.lean](Verified.lean). An independently authored call tree, five exact
native declaration targets, three proofs of the generated statements, and rejection
of wrong evidence pass. The emitted call retains the caller's `n`, the supplied
`m`, and the inferred Real type, with no replacement proof or cast.

The pre-fix compiler failed both original Python regressions: it rejected valid
evidence and accepted the captured equation. Six focused regressions now cover
that case, direct evidence, nested binders, and inference from a function codomain
before a later parameter. The rule applies to existing syntax; no new mathematical
wrapper or surface form is introduced.
:::

:::llm gpt-6 2026-11-07 role=assisted

Validation for the matcher change also passes 228 focused Python tests. The six-case
regression file was then strengthened with an explicit dependent codomain and
rerun successfully. Additional checks pass the 92-proof corpus kernel check, fourteen clipping targets and
three proofs, ten generic-subtype targets and three proofs, and four basis targets
with the pointwise/full restriction proofs. Regenerated tracked Lean artifacts for
those existing studies are unchanged after provenance restoration. The current
full Python run remains pending. Its preceding run was explicitly stopped after
the concrete capture bug was reproduced; it was not counted as a pass.
:::
