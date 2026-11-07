:::llm gpt-6 2026-11-07 role=assisted

# Fresh retained-call comparison

The integrated retained ModuleCall path always rechecked its dependent arguments,
even after the comparison traversal had just elaborated that call and verified
that normalization left every argument unchanged. Ordinary Call nodes already
used the audited [fresh-subtree rule](fresh-checked-subtrees.md). This change gives
retained calls the same rule while still validating their bound declaration.

There is no new syntax, reduction rule, inference policy or cross-invocation cache.
The specified Clean-to-Lean target does not change.

## Preservation rule

Use a previously checked call only when the existing traversal-local freshness
witness is present and all normalized arguments match the freshly checked ones in
source tree, native term, semantic type, rendered native type, inferred arguments,
presentation and precedence. Also compare the retained declaration template with
the current selected binding, even on the reuse path. A changed or missing binding
rejects. Any changed argument forces the normal checker to run again.

Public comparison entries still start without freshness. Mutated stored child
metadata does not grant it. Changed caller values/types are re-elaborated, and
resource-exhaustion exceptions still propagate. The synchronous fixed-environment
assumptions and comparison-pool rules from the existing audit are unchanged.

## Evidence and limits

The deterministic twelve-call retained-expression regression performed 23 callable
checks before this change; it now performs twelve and produces the freshly checked
current target after caller rebinding. This is an operation-count result, not an
end-to-end speedup claim. Seven retained-call tests cover the count, changed caller
values/types, forged retained metadata, changed templates, incomplete checking,
identity validation on the reuse path, and a normalized argument that must trigger
a parent recheck. A 292-test focused run passed before the seventh test was added;
the final seven-test retained-call suite also passes. Twelve exact global-reference
targets and six proofs pass, as do the regenerated 92 corpus proofs.

The active-label load is still slow in `active label equivalence`. The profiling
helper `tools/profile_active_labels.py` prints declaration timings and emits a
stack trace every two minutes without interrupting execution. No claim is made
that this local correction resolves the full normalization cost.

A new complete discovery run collected 739 tests and moved only the active-label
module to the end; no tests were omitted. It has already exposed integration-era
expectation failures (inline native types versus named bindings, Call versus
retained ModuleCall, and binder rejection diagnostics). Its final result is still
pending. Earlier full runs remain live on earlier compiler code and are not
validation of this change. Historical operator patch studies also retain their
pinned implementation unless explicitly updated.
:::
