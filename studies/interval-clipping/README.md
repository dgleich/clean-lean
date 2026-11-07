:::llm gpt-6 2026-11-07 role=assisted

# Clipping interval labels to a finite subpath

This is the coordinate step toward restricting an interval basis. The parent has
vertices 0 through n; the subpath starts at a and has vertices 0 through m.
The embedding sends v to a+v. Clipping sends a parent vertex t to
`min(m,t-a)`, with truncated natural-number subtraction. It is defined even for
vertices outside the subpath. A label with endpoints lower and upper survives
when `lower ≤ a+m` and `a ≤ upper`; merely clamping endpoints would incorrectly
retain labels that miss the subpath entirely.

The definitions are authored in
[library/diagrams/interval_clipping.clean](../../library/diagrams/interval_clipping.clean).
Foundational adapters expose natural-number minimum, its left-bound proof,
subtraction/minimum monotonicity, the ordinary Fin constructor from a non-strict
bound, and definitional Fin order views. No clipping
algorithm or paper-specific definition is imported from Lean.

[Statements.clean](Statements.clean) states three results:

- Clipping is a retraction of the subpath vertex embedding.
- Clipping preserves endpoint order.
- For a surviving interval, membership between its clipped endpoints agrees with
  membership of the embedded vertex in the original interval.

All three include zero-edge subpaths; no positive-length assumption is hidden.
The support result explicitly requires survival. The existing IntervalLabels
structure supplies ordered original endpoints.

Run `LAKE=lake python3 studies/interval-clipping/verify.py`. It checks fourteen
independently authored canonical native targets and three Lean proofs, without
`sorry` or additional axioms. The comparisons retain wrapper constants, arguments,
proof terms and binder order. Seven Python checks cover an independent parse tree,
the changed vertex carrier, wrong carriers, wrong bound evidence and authored
mathematical bodies. The current main regeneration passes all fourteen exact targets and three proofs;
all seven Python checks pass. The one-page PDF was compiled twice and inspected.
The earlier frozen full-suite and native-portfolio jobs do not include this new
study; these are its separate focused checks. The current browser rebuild
includes the added sources, with final inventory and UI validation pending.

`restricted interval labels(I,n,a,m,L)` now constructs an IntervalLabels record
indexed by `Element(I,(surviving interval labels(I,n,a,m,L)))`. Both endpoints are
clipped after selecting the original label. Its ordering field is a Clean
function composing the original ordering evidence with subtraction/minimum
monotonicity. The native oracle checks this constructor body, including its proof
arguments. This required fixing repeated substitution in known dependent
codomains; it did not require a new syntax form.

This study does not yet reindex vertex bases or prove that restricted vectors form
an interval basis. Those are the next mathematical constructions. It does not
prove the pyramid extension theorem. No new surface syntax was needed here.
:::
