:::llm gpt-6 2026-11-07 role=assisted

# Unintegrated comparison experiments

These patches were tested against the compiler at `dcbfe5f`, with the original
interval-specific support record. They are experiments, not main behavior or
completed acceptance evidence. Neither was integrated. Both runs were stopped
when the interval source was refactored into a generic subtype construction.

`call-index-cache.patch` reuses actual-argument index values within one dependent
call. It retains the original caller bindings and bypasses reuse when that scope
changes or a comparison-identity pool is active. An earlier identity-number-only
key was discarded because object identity numbers can be recycled. This final
candidate was not shown to finish the interval verification. Its first broad run
passed 310 tests and failed one obsolete test that rejected call-then-field syntax;
that assertion is now corrected in main. This is not a passing full-suite result.

`stable-call.patch` reuses an already checked call during comparison if every
normalized argument has the same source tree. Changed arguments are still checked.
It passed 312 focused tests, including binder identity and hygiene cases, but did
not finish the interval canonical checks or kernel proofs before being superseded.
Its treatment of scope and retained inference metadata still needs explicit native
acceptance before any integration.

The synchronous diagnostic counted hundreds of thousands of repeated index
normalizations during support-field checking. It did not use the repeated signal
traceback instrumentation involved in the earlier crash. Runs overlapped with
other jobs, so wall times are not a controlled performance comparison. The source
refactor addresses repeated expansion by making the generic sets explicit; its
interval-level validation is still pending.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Tree-only reuse fails a scope regression

The current `stable-call.patch` is unsafe for the normalization API. Check a call
`retain(x)` with `x` targeting `first` of type `A`, then normalize it with `x`
targeting `second` of type `B`. Both argument trees are `Local(x)`. Main rechecks
the call and obtains the current target and type; the patch retains `first` and
`A`. Replacing only the value while retaining type `A` also fails. The two cases
are preserved in `tests/test_comparison_reuse.py` and pass against main.

This is a counterexample to the proposed reuse criterion, not a demonstrated
end-to-end authored-document bug. A replacement optimization must establish
binding/target/type provenance rather than comparing source trees alone.
The combined generic-source experiment was stopped on this correctness evidence;
its timing and unfinished interval run are not acceptance evidence. The original
main interval verifier and translation remain unchanged and running.
:::

:::llm gpt-6 2026-11-07 role=assisted

The current generic-source call-index-only experiment, based on `70ab618`, passes
244 focused Python tests and ten generic-subtype exact checks plus three proofs.
Its interval translation remains incomplete. It does not include alias-description
changes or establish scope-safe caching in every supported context. No compiler
optimization has been integrated.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Fresh checked subtrees prototype

`fresh-subtrees.patch`, based on `9169d78`, records the initially isolated prototype,
now integrated after the audit below. It is not the rejected tree-only cache. It retains typed call arguments as private
`Expr` metadata and introduces a private freshness flag in comparison traversal.
Public comparison entry points and stored local-definition expansion start without
that flag. The flag is set only for synchronous elaboration within the traversal
or for its freshly checked argument children.

Fresh calls may normalize their retained typed arguments instead of elaborating
the source again. A checked call itself is reused only if every normalized argument
still has the same source tree, emitted term, rendered type, checked type,
inferred-argument metadata, presentation and precedence. Changed arguments are
rechecked. This is a proposed within-traversal reuse rule, not a cross-scope cache.
It assumes no semantic environment mutation during the synchronous traversal;
comparison-pool allocation and temporary binder scopes still require careful audit.

The public entry deliberately ignores retained argument metadata. Four regression
cases pass in both main and the prototype: changed caller value, changed caller
type, nested calls with changed bindings, and invalid retained argument metadata.
The wider candidate run passes 282 focused tests (it preceded the two additional
regression cases). Choice passes seven exact targets/three proofs and postfix
passes eight exact targets/five proofs. Generic subtype verification passes ten
exact targets and three proofs. The full interval run remains pending.

A diagnostic generic-module load made 8,900 fresh-bound allocations and took
16.25s, compared with 33,998 allocations and 49.89s for the exact-text cache alone.
Those runs overlapped other work. They are useful profiling evidence, not a
controlled benchmark or proof that the interval bottleneck is solved.

Before integration, audit every path that establishes freshness, preserving the
rule that earlier checked expressions do not become trusted merely because their
source trees are unchanged. In particular, selected record fields can lose typed
argument metadata and must use the recheck path. No new syntax, implicit proof
selection, or change to authored emitted terms is intended by this prototype.
:::

:::llm gpt-6 2026-11-07 role=assisted

The fresh-subtree prototype has now been integrated after the
[freshness-path audit](../../../docs/fresh-checked-subtrees.md). The historical
patch above remains a record of the isolated candidate. Main passes 285 focused
tests, including a twelve-call changed-scope regression: the previous implementation
made 78 module-call checks, while the new rule requires at most twelve and preserves
the current target/type. Choice, postfix and generic native checks pass. The full
suite and interval stress run are still pending. The older tree-only and call-index
cache patches remain unintegrated.
:::
