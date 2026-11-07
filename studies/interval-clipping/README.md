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
The three new foundational adapters expose natural-number minimum, its left-bound
proof, and the ordinary Fin constructor from a non-strict bound. No clipping
algorithm or paper-specific definition is imported from Lean.

[Statements.clean](Statements.clean) states three results:

- Clipping is a retraction of the subpath vertex embedding.
- Clipping preserves endpoint order.
- For a surviving interval, membership between its clipped endpoints agrees with
  membership of the embedded vertex in the original interval.

All three include zero-edge subpaths; no positive-length assumption is hidden.
The support result explicitly requires survival. The existing IntervalLabels
structure supplies ordered original endpoints.

Run `LAKE=lake python3 studies/interval-clipping/verify.py`. It checks eight
independently authored canonical native targets and three Lean proofs, without
`sorry` or additional axioms. The comparisons retain wrapper constants, arguments,
proof terms and binder order. Five Python checks cover an independent parse tree,
the changed vertex carrier, wrong carriers, wrong bound evidence and authored
mathematical bodies. The current main regeneration passes all eight exact targets and three proofs;
all five Python checks pass. The one-page PDF was compiled twice and inspected.
The earlier frozen full-suite and native-portfolio jobs do not include this new
study; these are its separate focused checks. The current browser rebuild
includes the added sources, with final inventory and UI validation pending.

This study does not yet construct the restricted IntervalLabels record indexed
by surviving labels, reindex vertex bases, or prove that restricted vectors form
an interval basis. Those are the next mathematical constructions. It does not
prove the pyramid extension theorem. No new surface syntax was needed here.
:::
