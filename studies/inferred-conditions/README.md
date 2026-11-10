:::llm gpt-6 2026-11-10 role=assisted

# Recovering a condition from a proof operand

Status: isolated prototype; not yet integrated. This extends direct value inference
to condition indices. It adds no grammar, layout, keyword, or editor spelling.
It does not implement general sort polymorphism or proof search.

A proof already carries the condition it proves. Clean can recover that condition
from its type to support an explicitly imported mathematical definition:

```clean
Import "library/logic/proof_equality.clean"

Define condition of(h):
  Let p: Proposition
  Let h: Evidence(p)
  Returns: Proposition
  Equals: p
```

The new library module declares this concrete equality interface:

```clean
Condition same evidence(h,k):
  Let p: Proposition
  Let h,k: Evidence(p)
  Infix: =
  From Lean: h = k
  Render latex: {h}={k}
```

For `h,k: Evidence(p)`, `h=k` and `same evidence(h,k)` have the same
explicit Lean target. With generated names abbreviated, the adapter and use are:

```lean
noncomputable def sameEvidence {p : Prop} (h k : p) : Prop := h = k
-- Application with every argument supplied:
@sameEvidence p h k
```

These are readable Lean equivalents. The independent native checker compares
canonical declaration bodies and types, including the generated Proposition
wrapper, and supplies no inferred metavariable for `p`.

## Constructive rule

The existing signature parser and typed telescope rules apply unchanged. A
condition index counts as a direct occurrence of implicit parameter `p` exactly
when its retained expression tree is `Local(p)`. An occurrence inside conjunction,
a named application, negation, or another computed condition is insufficient.
The declaration checker does not normalize a computed formal condition into a
pattern variable or attempt to invert that expression.

Match formal and actual operand types in header order, visiting their indices
left to right. At a direct implicit occurrence, retain the corresponding actual
condition index, including its bound expression tree and comparison information.
Repeated occurrences must agree by the existing condition comparison; the first
agreed representation is retained. A shared comparison binder may not escape
into an inferred argument. Other type structure must match normally.

Re-elaborate the retained condition expression in the caller's current scope and
recompute its proof-condition index, using the same binder-aware comparison as
explicit evidence types. Verify that it still agrees with the recorded index and
that its type is the declared condition type after prior telescope substitutions.
This differs from ordinary computed value indices: a condition may contain
`for every` or `there exists`. It does not permit arbitrary computed value indices
to introduce binders. Recheck all explicit operand types after recovery.

Emit the selected declaration's root-qualified Lean constant, supplying the
checked condition expression before the explicit operands. All eligible operator
adapters are still considered; distinct applicable meanings remain ambiguous.
No proof irrelevance is added to Clean's condition comparison. Lean can prove
that two proofs of the same condition are equal, but Clean does not identify
different conditions merely because they have proofs.

## Binding, rendering, and limits

A recovered condition keeps its selected module references. Later imports cannot
retarget a retained equality call. Fresh public elaboration rechecks the current
scope and does not trust cached inferred arguments. A condition moved across an
incompatible caller scope is rejected. The existing hidden-binder normalization
boundary remains: an authored `condition of(h)` can remain as a named call when
its recovered argument contains a quantifier.

LaTeX continues to show the authored operands and equality. The inferred condition
is already expressed by the operand types; it adds no assumption or prose clause.
The proof-equality module imports operators and evidence explicitly. Importing
only the evidence module does not add equality, and importing scalar operators
does not silently add proof equality.

The isolated checks cover signature and expression trees, exact explicit
application spelling, independent canonical types/bodies, quantified conditions,
computed conditions with first-occurrence preservation, changed caller bindings,
poisoned metadata, wrong types, non-direct or absent occurrences, escaping binders,
conflicting conditions, explicit imports, retained calls and competing operators.
General universe/sort polymorphism, complete native import isolation, and full
regression conformance remain unfinished. The prototype also authors the standard implication in Clean:

```clean
Condition implication(x,y):
  Let x,y: Proposition
  Infix: →
  Holds when: for every (h: (x),y)
  Render latex: {x}\text{{ implies }}{y}
```

The existing callable view can inspect this authored quantified body. An opaque
native declaration that merely uses the arrow token is still not assumed to be
an implication. No display-name or operator-token semantic dispatch is added.
The native oracle verifies that the authored body is canonically the ordinary
Lean implication and that applying its evidence emits the local application.

Isolated validation: 58 focused tests pass (12 new condition-inference tests,
29 callable-evidence tests, and 17 existing inference/binding/name tests). Seven
independent canonical Lean checks and four proofs pass. The complete production
regression is still running on the preceding revision; these results are not
full-regression or full-conformance claims.
:::

:::llm gpt-6 2026-11-10 role=assisted

## Reproduce and integrate

Run `python3 studies/inferred-conditions/verify.py` with the project's Python
dependencies installed and `LAKE` pointing to the pinned lake executable if
needed. The driver exports commit `5525280d571a63e2fd122f627ed069878b51703a`,
applies the reviewed patch in a temporary checkout, and runs the 58 focused tests
and seven canonical checks with four proofs. It leaves production sources intact.
Sixteen successfully translated callable-evidence specimens were also checked
individually by Lean during development; this supplemental run is not part of
the driver and does not claim proofs of the specimen statements.

Integration is pending completion of the running production regression. Apply
the compiler/library/test changes, classify the three new source files in the
provenance inventory, migrate this status to implemented-slice, and rerun affected
native/topology/corpus checks and full regression. Do not apply this patch to the
older historical binding-study baseline or describe isolated results as passing
production checks. The proof-equality module is explicit; other tests that require
it still need to import it. General proof-sort equality inference remains outside
this concrete interface.
:::

:::llm gpt-6 2026-11-10 role=assisted

Additional isolated validation: the existing curated corpus was regenerated using
this patch, and all 92 proof fixtures passed Lean. A complete eighteen-verifier
topology run is now in progress against the same isolated compiler/library.
Neither result replaces production full-regression completion or integration.
:::
