:::llm gpt-6 2026-11-07 role=assisted

# Fresh condition comparison

This extends the [fresh-subtree audit](fresh-checked-subtrees.md), without changing
syntax, comparison reduction rules, inferred arguments or emitted Lean expressions.
It is not a cache across scopes or invocations.

A binary expression retains the two checked operands in nonsemantic `checked_args`
metadata. A fresh traversal can normalize these operands directly, then reconstruct
the binary expression using the existing operator checker. At a public entry the
metadata is ignored: its source children are elaborated in the current scope.
Stored local-definition values still enter without freshness.

The proof-index path has an internal `_fresh` parameter, defaulting to false.
Only the following compiler sites supply true:

- A computed proof-type expression just elaborated by `Environment.type`.
- A condition-valued type argument just parsed and checked against its expected type.
- The implication sides and universal codomain just elaborated in `callable_view`.
- A substituted proof condition just elaborated in its combined captured/caller scope.

`callable_view` also marks its immediate elaborate-then-normalize traversal fresh.
Other public `proof_type`, proof-index and comparison calls retain the conservative
default. Internal flags are implementation invariants, not authored language features.
The synchronous fixed-environment assumptions of the earlier audit still apply.

Proof-index beta contraction and quantified comparison preparation either return
the original checked expression or synchronously elaborate and type-check their
replacement. Both preserve freshness when their input is fresh; neither grants
freshness to a stale input. The index comparison can therefore pass the witness
into normal traversal. Binder materialization remains unchanged and re-elaborates
the complete comparison tree with its scoped identity pool.

The preservation argument is induction on the fresh traversal: retained children
come from the just-completed check, recursively normalized children enter the same
operator checker, and calls retain the earlier unchanged-argument guard. Public
inputs and stored values cannot acquire this witness from metadata alone. Output
terms stored in proof indices still come from the original checked condition;
only comparison construction avoids redundant work.

## Evidence

The eight-call condition regression required sixteen named-call checks before this
change and eight afterward. Three further regressions cover changed caller values
and types, poisoned public operand metadata, and nested Boolean expressions under
a changed scope. These are operation-count and semantic checks, not timing claims.
The focused run passes 282 tests. Native verification passes ten exact generic
subtype targets and three proofs, plus seven choice targets and three proofs.
An initial test invocation omitted the tests directory from PYTHONPATH and failed
five fixture imports; the corrected complete focused invocation passes.
The refreshed isolated operator driver passes strict parser generation, 32 exact
targets and three proofs. The regenerated 92-proof corpus passes the Lean kernel.
The main interval-basis check passes four exact targets and pointwise/full
restriction proofs, with unchanged generated artifacts after provenance restoration.
The full Python suite and specialized active-label verification remain pending.
A finite active-label profile reaches the specialized equivalence sooner but does
not finish it; this is not evidence that the stress bottleneck is resolved.
:::
