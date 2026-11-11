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
snapshot disables further reuse attempts for the rest of that pool and performs
the ordinary checked comparison. Existing memo entries are cleared; an outer
comparison already in flight cannot store a result after disablement. A later
public comparison receives a new pool and may try again. This is
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

:::llm gpt-6 2026-11-11 role=assisted

## Stop repeated unavailable snapshot attempts

A 20-second diagnostic of current active-label module loading spent 6.970
cumulative seconds in optional snapshot traversal (6,417 root visits). The
per-attempt 512-visit limit still allowed repeated failed attempts in the same
pool. The pool now disables reuse after the first SnapshotUnavailable, clears
existing entries and prevents in-flight outer calls from repopulating the memo.
Ordinary checked comparison continues; failure to build an optional key is not a
semantic failure and cannot select an interpretation.

The new flag belongs only to the transient pool. It is not serialized, retained
on the module Environment after a public comparison, or shared with later calls.
This deliberately trades possible small-term cache hits for a bound on repeated
failed-key overhead. Successful reuse before disablement obeys the same semantic
snapshot and owned-identity rules. Recomputing after disablement adds no new
semantic shortcut; targets and error rules remain unchanged.

Three regression tests cover a single snapshot attempt per disabled pool, fresh
attempts in a new pool, ordinary validation of changed local values, clearing of
prior entries, and suppression of outer storage after nested disablement. The
focused reuse/index/context suites pass 66 tests.

A second 20-second diagnostic spent 3.446 cumulative seconds in snapshot traversal
(3,286 root visits). Both observations ended before module loading completed and
may cover different amounts of work; neither establishes a whole-module speedup
or a validation pass. Logs: `/tmp/clean-whole-topology-diagnostic.log` and
`/tmp/clean-snapshot-stop-diagnostic.log`. A first diagnostic that timed only the
final declaration was explicitly retired because prerequisite loading was not
bounded; `/tmp/clean-topology-diagnostic-retired.json` records that instrumentation
change. Existing validation jobs were not modified by either profile.
:::

:::llm gpt-6 2026-11-11 role=assisted

The current integration run ends with `Failures: []`: strict parser regeneration,
530 Python tests, native target/proof checks and the 92-result proved corpus.
The experimental inference suite separately passes 120 tests and 24 independent
native targets with 24 supporting proofs. Logs:
`/tmp/clean-snapshot-stop-integration.log`,
`/tmp/clean-snapshot-stop-experimental-tests.log`, and
`/tmp/clean-snapshot-stop-experimental-native.log`.

Full discovery and active-label native validation now run on the immutable
`/tmp/clean-snapshot-stop-validation-i8ocpwa5` snapshot. Their logs are
`/tmp/clean-snapshot-stop-full.log` and
`/tmp/clean-snapshot-stop-active-native.log`; neither has completed. The older
b3dc1e9 discovery/native pair, checked-signature discovery and prefix-dimension
discovery were confirmed live, explicitly retired as superseded by this compiler
change, and then confirmed absent. `/tmp/clean-snapshot-stop-retired.json` records
the commands and checkouts. Their incomplete results are preserved, not counted
as passes or treated as failures caused by an observation timeout.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Reusing a freshly checked operator

Comparison normalization extends the existing named-call freshness rule to infix
and prefix operators. Freshness is an internal witness from elaboration in the
same synchronous traversal under fixed declarations and scope; it is never inferred
from a stored `checked_args` field at a public entry point.

Normalize every operand first, retaining the previous rule against publishing
hidden binders as authored arguments. Reuse the checked operator expression only
if it has a selected binding and checked operands, its arity is unchanged, and each
normalized operand agrees in tree, Lean text, LaTeX text, precedence, type, rendered
Lean type and inferred arguments. The selected declaration identity must still
match; otherwise fail. If any operand changes, run ordinary operator selection.
This applies to both prefix and infix presentation, with no token-specific math.

Under the fixed traversal environment, unchanged checked inputs give the same
candidate set, uniquely selected declaration, implicit arguments and output as
reselection. Returning the original checked expression therefore preserves its
comparison and canonical emitted term. The rule is not a cross-call cache and does
not allow an expected return type to resolve ambiguous input signatures. Public
comparison re-elaborates the source, detecting newly added overloads, changed
bindings, mutated operands and changed locals. Optional comparison memo rules are
unchanged.

Regressions check absence of redundant selection, reselection after an authored
operand expands, rejection of changed selected bindings, public prefix/infix
ambiguity, ignored stale operand caches and equal fresh/rechecked encoded index
payloads. The focused comparison suite passes 92 tests. The fixed snapshot also passes
strict parser checks, 550 integration Python tests, 120 experimental inference
tests, and 24 experimental native targets with 24 supporting proofs. Full discovery
and active-label verification remain pending. The remaining native integration
checks and the 92-proof corpus recheck completed with no failures. No whole-topology speedup is claimed.

Older full-discovery and active-label processes were verified live and explicitly
retired as superseded by this comparison change, not treated as passed or as
observation timeouts. Replacement checks use the immutable snapshot
`/tmp/clean-fresh-operator-validation-svfvi51g`. The bounded 20-second diagnostic
also ended before the module finished; it is profiling evidence only.
:::
