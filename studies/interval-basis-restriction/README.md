:::llm gpt-6 2026-11-07 role=assisted

# Restricting an interval basis at one vertex

This study proves the next step after the [active-label correspondence](../active-labels/README.md): a basis indexed by original active labels gives a basis indexed by restricted active labels, with the same underlying vectors.

[Statements.clean](Statements.clean) expresses the result using the existing explicit active-label and basis modules. It assumes an original basis and its vector formula. It does not assume a restricted basis, a label equivalence, or the support evidence needed to construct that equivalence. No new language syntax or Mathlib wrapper is introduced.

[Native.lean](Native.lean) contains the checked arithmetic foundations and a native proof of this result. The proof obtains the value-preserving label equivalence from numerical bounds, applies Mathlib's `Module.Basis.reindex`, then uses its evaluation formula and preservation of labels. In particular, reindexing evaluates the old basis at the **inverse** image of the new label.

Run from the repository root:

```sh
LAKE=lake python3 studies/interval-basis-restriction/verify_native.py
```

The driver checks the Clean statement's syntax, copies the tracked arithmetic foundation into the standalone Lean file, records its input hash, and checks the native proof with Lean. The arithmetic source can first be regenerated with `studies/active-labels/verify_arithmetic.py`. Generated symbol lookup requires a unique binding; the mathematical theorem and proof are independently authored.

**Validation boundary:** syntax and the native theorem pass. Clean name binding, type checking, translation, and comparison against the native theorem remain pending. The full active-label translation is still running; this native check does not replace that bridge. There are no added axioms or `sorry` placeholders.

This is a pointwise basis theorem. Constructing the restricted interval-basis record still requires assembling the vertexwise bases and proving vector vanishing and compatibility along edges. It does not establish the paper's pyramid theorem.
:::
