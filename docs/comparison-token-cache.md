:::llm gpt-6 2026-11-07 role=assisted

# Caching comparison-pool token scans

This implementation optimization changes no grammar, scope rule, inference policy,
or emitted Lean term. A comparison pool still chooses the least unused
`clean_comparison_identity_N`, reserves it, and records ownership for scoped keys.

At the first fresh-binder allocation, a pool collects the distinct string leaves
reachable from `environment.data` and `environment.notation_definitions`. The
iterative traversal visits each dictionary, list and tuple once per scan, including
dictionary keys and values. Other objects remain ignored. Container identities
are used only for traversal, with references kept alive until the scan ends; they
never enter the cache key. The immutable snapshot is a frozenset of strings.
The environment caches that snapshot and its frozen union of identifier tokens.
Reuse requires exact snapshot equality, not a digest, identity or timestamp.
The implementation assumes synchronous environment access without mutation during
a scan; each later scan reads current contents afresh.

The lexical result is a union: repeated strings and repeated paths to a container
cannot add tokens. Visiting each reachable container once therefore preserves the
complete union. Equal text sets give equal token unions under the fixed identifier
expression. Scanning a deep shared graph no longer expands every path or consumes
Python recursion depth. Reordering, duplicate removal and changes in sharing do
not invalidate a still-correct union. Mutations that change the distinct strings
invalidate the snapshot; mutations preserving that set preserve its token union.

Expression trees, local names, Lean terms and type indices retain their existing
scan rules. A pool still chooses the least unused `clean_comparison_identity_N`,
reserves it and records ownership. Its mutable reserved set, ownership set and
counter are never cached. Induction over allocations consequently gives the same
fresh-name sequence for the same environment and inputs, regardless of cache
warmth or container sharing. Parsing and canonical Lean targets are unchanged.

This is lexical caching only, not caching of expression meanings, inferred types,
proof comparisons or checked subtrees. Binder-free comparisons do not scan the
environment. Allocating pools still scan the reachable graph; this does not resolve
all translation bottlenecks.

## Evidence and reproduction

Seven regressions cover warm reuse, nested mutation, declaration replacement and
deletion, dictionary keys, mutable expression trees, changed local terms/types,
and declaration order. The focused comparison/inference suite passes 285 tests.
Native checks pass eleven declaration-identity targets with changed-proof rejection,
and four interval-basis targets with pointwise and full restriction proofs.
Those are historical scoped checks, not full-suite validation. Full discovery and
the specialized active-label verifier remain pending.

Run `python3 tools/profile_comparison_tokens.py --iterations 100` for a diagnostic
that asserts identical cold/warm fresh names. One run measured 0.0753 seconds cold
and 0.0123 seconds warm. These are pool-allocation timings, not compiler throughput.
Two 30-second sampling profiles of active-label loading observed 608 versus 45
samples in `re.findall`; workloads progressed to different phases and other jobs
were running, so this is evidence of reduced scanning, not a controlled speedup.

## Shared-container scan (2026-11-11)

The generated parser passes strict grammar/lexer checks and the integration
Python suite passes 535 tests. The native integration checks and the 92-proof
corpus recheck subsequently completed with no failures. The focused suite passes 77 tests, and the experimental joint-inference suite
passes 120 tests. Its native verifier passes 24 exact targets and 24 meaning
proofs against this scanner. Full discovery remains pending; these checks do not
establish full topology validation or production joint inference.

Five additional regressions cover single visitation of shared containers,
order/duplicate/sharing independence, mutations between scans, a depth-2000
shared graph, and tuple dictionary keys/native body text. They run alongside
`tests/test_comparison_token_cache.py` and the comparison/inference checks.

A before/after diagnostic used the previous scanner extracted from Git and
asserted equal token sets. Fifty warm scans of the actual operators environment
measured 0.01336 seconds before and 0.01577 after (249 tokens). Five warm scans of
a shared depth-16 graph measured 0.09074 seconds before and 0.000033 after
(one token). These single-run observations show both overhead on a small ordinary
environment and eliminated repeated graph traversal; they are not whole-module
or compiler throughput measurements.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Projection base reuse (2026-11-11)

Comparison normalization now elaborates a projection base once, passes that
fresh checked expression to producer inspection, then normalizes the same base
with the internal fresh flag. Previously the second step elaborated the base
again. The result is used only in this synchronous traversal under the same fixed
environment and locals. No stored Expr payload becomes a cross-call cache.
Public comparison still checks the base source in the current scope, and failed
checking propagates. Producer-field selection, projection reduction and binder
publication rules are unchanged; emitted Lean and LaTeX are not rewritten.

A twenty-second whole active-label loading diagnostic before the change observed
55,082,488 calls (46,377,898 primitive); producer-field inspection appeared 2,024
times and accounted for 1.464 cumulative profiled seconds. Both before and after
observation windows ended without completing translation. Their differing progress
and concurrent jobs do not establish a whole-module speedup. The existing full
production and active-label processes were confirmed live and were not restarted.

A direct before/after comparison loaded the previous normalizer from Git and
normalized an opaque producer projection. Checked tree, Lean, LaTeX and type were
identical. The producer was checked twice before and once after per traversal.
One run of 1,000 traversals took 0.054643 seconds before and 0.027880 after; this is
a small diagnostic, not a compiler throughput claim.

Three regressions check the single base elaboration, changed caller binding, and
propagation of unavailable checking. The focused comparison/structure/payload
suite passes 69 tests. Both comparison reuse suites are now included explicitly
in the integration driver. The integration run completed: strict parser generation, 565 Python tests, all
native integration checks and the 92-proof corpus recheck pass (`Failures: []`).
The experimental inference recheck passes 200 tests and 52 exact native
targets with 52 supporting proofs.

Full discovery and active-label validation run from the immutable snapshot
`/tmp/clean-projection-validation-kj6ncp2q`, based on `b769ef3` plus this patch.
Its conversion module SHA-256 is
`4c1c2982be995862cfb8590be41aab80015b93149d13fbfa02acc774dc9adde7`.
Both are pending. The older fresh-operator snapshot jobs remain live baseline
checks and do not validate this projection change.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Active-label regeneration termination and retry

The projection-snapshot active-label session 83679 returned exit status 143.
Its Python process 229974 was confirmed defunct; the log was empty and its
Generated/Verified artifacts still had their pre-run timestamps. This is a
terminated, incomplete validation, not a successful check. The cause of the
termination was not established. Full Python discovery session 84890 was still
live when checked.

A new invocation uses the same immutable snapshot and conversion hash. A detached
wrapper records its start and child return code in
`/tmp/clean-projection-active-retry.json`, with output in
`/tmp/clean-projection-active-retry.log`. Initial wrapper PID: 233718. The retry
was started only after terminal status was confirmed; it is pending, not passing.
The signature-chain changes in the experimental study do not change this
production compiler snapshot.
:::
