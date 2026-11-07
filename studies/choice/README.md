:::llm gpt-6 2026-11-07 role=assisted

# Using an existence proof in a Clean definition

Import `library/logic/choice.clean` to extract a witness using Lean's classical
choice foundation. A nonempty set example reads:

```text
Let A: Type
Let S: Set(A)
Assume inhabited: there exists(x: A,x ∈ S)
Conclude: choose element(S,inhabited) ∈ S
```

`choose element` and its membership evidence are authored in Clean. The two
foundational wrappers expose `Classical.choose` and `Classical.choose_spec`.
Choice is noncomputable; this is not an algorithm for searching a set.

The other specimens test a condition given as an applied function and a condition
containing a universal quantifier. These are needed when selecting a mathematical
object together with properties of its elements. They exposed the scoped beta
comparison gap, now addressed by the [comparison contract](../../docs/proof-beta-comparison.md).

`LAKE=lake python3 studies/choice/verify.py` passes seven exact target/type
comparisons and three proofs. Ten focused Python tests pass. `Generated.lean`
contains the translated definitions/statements; `Verified.lean` adds independent
native oracles and proofs. The final rule passes 276 focused tests, the existing
eight-target/five-proof postfix study, and the regenerated 92-statement proof
corpus. The PDF was compiled twice and inspected without layout/reference errors.
Reference links/search/mobile/no-JavaScript and strict parser checks pass. The
full suite and review-browser snapshot refresh remain pending.
:::
