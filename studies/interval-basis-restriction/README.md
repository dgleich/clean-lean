:::llm gpt-6 2026-11-07 role=assisted

# Restricting an interval basis at one vertex

This study proves the next step after the [active-label correspondence](../active-labels/README.md): a basis indexed by original active labels gives a basis indexed by restricted active labels, with the same underlying vectors.

[Statements.clean](Statements.clean) expresses the result using the existing explicit active-label and basis modules. It assumes an original basis and its vector formula. It does not assume a restricted basis, a label equivalence, or the support evidence needed to construct that equivalence. No new language syntax or Mathlib wrapper is introduced.

[Native.lean](Native.lean) contains the checked arithmetic foundations and a native proof of this result. The proof obtains the value-preserving label equivalence from numerical bounds, applies Mathlib's `Module.Basis.reindex`, then uses its evaluation formula and preservation of labels. In particular, reindexing evaluates the old basis at the **inverse** image of the new label.

Run from the repository root:

```sh
LAKE=lake python3 studies/interval-basis-restriction/verify.py
```

This regenerates [Generated.lean](Generated.lean), containing the statement and its
imported definitions, and [Statements.tex](Statements.tex). [Verified.lean](Verified.lean)
adds three exact canonical target comparisons (the original active set, restricted
active set, and theorem statement) and proves the generated theorem. The proof
also rechecks the arithmetic support and native basis construction. All these
checks pass. No added axioms or `sorry` placeholders are used. The one-page
[PDF specimen](Statements.pdf) was compiled twice and visually inspected.

The statement imports `active_label_sets.clean`, `basis_reindexing.clean`, and
`elements.clean` explicitly. The separate `active_labels.clean` module imports
those set declarations and adds support/maps/equivalence definitions. This keeps
the statement's dependencies small; the proof supplies the equivalence. Full
canonical verification of the latter module's maps remains a separate running
check, not a prerequisite hidden inside this statement.

The proof driver loads the generic subtype foundations into its proof environment
and renders independently authored arithmetic/basis proof templates with that
environment's binding names. An initial attempt copied generated proof text from
a different import order and failed: generated names currently depend on the
binder-allocation context. The corrected driver resolves declared bindings rather
than assuming those generated names are portable. It does not derive expected
mathematical targets from generated statement bodies. Stable module-owned identity
remains a broader compiler task.

For the independent native-only check, run `verify_native.py`. It copies the
tracked arithmetic foundation into `Native.lean`, records the input hash, and
checks its native theorem. Regenerate that foundation with
`studies/active-labels/verify_arithmetic.py` when necessary. This secondary check
alone does not check the Clean target; `verify.py` does.

This is a pointwise basis theorem. Constructing the restricted interval-basis record still requires assembling the vertexwise bases and proving vector vanishing and compatibility along edges. It does not establish the paper's pyramid theorem.
:::
