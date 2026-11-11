:::llm gpt-6 2026-11-11 role=assisted

# Comparison reuse within one binder pool

This is a comparison-work optimization, not new authored syntax or a new
Clean-to-Lean translation rule. It must preserve the complete existing comparison
result, including owned versus free binder identities. It does not normalize
emitted theorem terms or select a new overload.

A synchronous comparison runs under fixed module declarations. Its internal
binder pool is shared with nested comparisons and discarded at the public root.
Nested comparisons of calls, operators, applications and projections may reuse
an earlier successful result from this same pool. Atomic expressions are cheap
to recompute and are not stored.

The memo key contains an exact ephemeral semantic graph snapshot of the source tree,
input type, input native spelling, and all local names and values sorted by name,
plus the pool's complete owned-identity set. This includes local definitions and
local carrier information. Snapshot fields follow the explicit retained-value
schema, but the snapshot is not the JSON persistence format. Each object is
visited once per snapshot and repeated references use traversal ordinals.
Shared and copied representations may miss reuse; different semantic graphs
cannot collide. Primitive atoms include their Python type, distinguishing booleans
from integers. Cycles and unknown schema shapes make the optional key unavailable. Mutable values are read
again on each snapshot; the visitor retains references during traversal so object
IDs cannot be recycled. No object address enters the returned key.
It does not rely on object identity, unchecked cached
operands, or diagnostic source spelling alone. Disposable caches remain excluded
according to the retained-value codec contract.

Snapshot construction stops after 512 visits. An unavailable or over-budget
snapshot bypasses reuse and performs the ordinary checked comparison. This is
not the semantic analysis budget: it cannot reject an input, resolve ambiguity,
or turn an incomplete semantic check into success. The limit bounds optional
optimization overhead, while normal elaboration retains its existing rules.

Storage is permitted only after checked normalization succeeds and only when the
pool's owned set has not changed during that computation. In particular, a hidden
binder allocation prevents storage even if its name is absent from the returned
term. Allocation before a subsequent comparison changes the key. Exceptions and
incomplete analyses do not store a result. At 256 entries the memo is cleared;
eviction changes work, never meaning. Nothing is serialized or retained on the
module environment after the public comparison returns.

The declarations are fixed during this synchronous operation, as in existing
per-call index reuse. This is not a cache that may be shared across edits,
module imports, separate public comparisons, or concurrent mutation of an
Environment. Each public comparison starts with a fresh pool and rechecks source
and declaration identity. Internal pool injection in the tests models nesting;
it is not a public persistent-cache API.

Under these preconditions, a key hit repeats the same deterministic computation
with the same semantic inputs and no omitted binder-allocation effect. Its result
is therefore the earlier checked result; no candidate is removed or prioritized.
The constructive native target remains the existing declared call with its
checked arguments. This does not resolve broader inference or proof obligations.

The focused tests check normalization once for repeated nested comparisons,
in-place local changes, ownership changes, allocations during computation,
uncached failures, and fresh validation across public comparisons. Existing
hygiene, conversion and dependent-call cases remain part of validation. The first snapshot used full JSON encoding and passed 94 focused tests, but
its 30-second active-label profile spent 21.512 cumulative seconds in encoding.
The current graph snapshot removes repeated traversal of shared values and passes
97 focused tests, including mutable graph snapshots and primitive distinctions.
The first integration run passed 489 Python tests and the complete native batch;
it predates the graph snapshot and is not final-implementation validation.
The unbounded graph profile still spent 19.876 cumulative seconds in the visitor
within its 30-second observation. This motivated the 512-visit fallback; neither
profile establishes a completed active-label translation or a speedup. The graph
variant passed 494 integration tests before the budget fallback was added.
The final bounded variant passes 99 focused tests. Its integration runner
(`/tmp/clean-bounded-memo-integration.log`) completes strict parser reproduction,
496 Python tests, 57 exact native targets, 30 supporting proofs and all 92 corpus
proofs, ending with `Failures: []`. Full discovery and the active-label
native verifier run from immutable commit `b3dc1e9` in
`/tmp/clean-bounded-memo-full-u2dezlb3`; logs are
`/tmp/clean-bounded-memo-full.log` and
`/tmp/clean-bounded-memo-active-native.log`. Those two long-running checks remain pending at this checkpoint.
The previous binder-repair discovery, old operator-repair active-label verifier,
and unbounded JSON-snapshot active-label verifier were confirmed live and explicitly
retired as superseded. Their command/checkout records are in
`/tmp/clean-bounded-memo-retired.json`; none is counted as passing.
This document does not claim a whole-module speedup.
:::
