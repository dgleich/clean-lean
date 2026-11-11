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

:::llm gpt-6 2026-11-11 role=assisted

## Fresh application-child reuse

The production application checker now retains the synchronously checked head and
arguments of an Apply expression in disposable `checked_args` metadata, with the
head first. Calls retain their existing argument-only convention. Normalization
uses these children only with the existing traversal-local freshness witness. A
public application comparison re-elaborates the complete saved source before using
its children, so mutated caches and changed caller bindings are not trusted.
An incompatible changed argument type is rejected rather than being paired with a
saved application result type. Missing checking still propagates as unavailable.

The metadata remains excluded from versioned retained-tree serialization and from
semantic comparison snapshots. No parser rule, declaration target or source
representation changes. Beta reduction, hidden-binder publication restrictions,
normalization order and the final type checks retain their existing rules. Audited
consumers either explicitly dispatch on Apply or inspect argument caches only for
Call, ModuleCall, Operator and Unary; the experimental dependency scan may visit
all checked children, including the application head.

An attach attempt using py-spy 0.4.1 was denied by the environment. No live process
was stopped. A separate 20-second cProfile loading diagnostic reached `restricted
active labels`; it observed repeated application elaboration among the comparison
costs. Before/after windows both ended without finishing the module, with 36,248,063
and 28,782,090 calls respectively. They ran amid other jobs and are not throughput
measurements or validation passes.

A controlled comparison loaded the previous normalizer from Git and compared a
12-level opaque application chain. Lean, LaTeX, type and source tree were identical.
Leaf checking fell from 12 to 1 per traversal. One run of 100 traversals measured
0.16555 seconds before and 0.03508 after; this is a small diagnostic, not a claimed
whole-topology speedup. Four production regressions cover single leaf checking,
mutated saved children plus caller rebinding, incompatible changed arguments, and
unavailable checking.

The focused suite passes 69 tests. Integration Python checks pass 569 tests. The
experimental suite passes 374 tests and 97 exact native targets with 97 supporting
proofs. The complete integration driver subsequently passed strict parser checks,
all native integration targets and supporting proofs, and the regenerated 92-proof
corpus (`Failures: []`). Reference HTML IDs/local links and provenance checks pass.

Full discovery and active-label regeneration now also run against immutable snapshot
`/tmp/clean-application-validation-aujg29lh`, based on `0c3f5ba` plus this production
patch. Metadata and file hashes are in `/tmp/clean-application-validation.json`.
The conversion SHA-256 is
`c463ad038581ea1af3bd09467cfa40554da6c08bc14ff744467d49ef8c70356d`.
Detached wrappers record live child PIDs and eventual exit codes in
`/tmp/clean-application-full.json` and `/tmp/clean-application-active.json`. These
are new validation runs for changed compiler code; older live snapshots remain
untouched. None is counted as a completed validation from its running status.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Nested fresh projection bases

`structures.project` records `(base,)` in disposable checked-child metadata only
for a non-reduced projection. A fresh comparison uses this checked base rather
than elaborating its tree again. Public comparison still rechecks that tree;
saved metadata cannot certify freshness. Producer-field selection and normalized
projection reconstruction are unchanged. Reduced constructors do not acquire a
misleading projection child tuple.

Consumer audit: retained binding and contextual emission use checked metadata as
call arguments only for Call/ModuleCall/Operator/Unary. The experimental binder
codec and selected-tree checker explicitly handle Projection bases. Its generic
dependency walker can visit the additional base. Metadata remains excluded from
serialization and semantic snapshots; there is no long-lived freshness cache.

Four regressions cover nested checking, corrupted saved children with changed
caller/type, invalid fields after rebinding, and unavailable checking. A controlled
12-level projection comparison with the previous Git normalizer checks the base
12 times before and once after, with identical Lean, TeX, type and source tree.
One 100-traversal diagnostic measured 0.30756 seconds before and 0.09592 after.
This is not a whole-topology speed claim: a 20-second loading observation still
stopped within `restricted active labels`.

Focused validation passes 91 tests; integration Python checks pass 578 tests.
The experimental suite passes 374 tests and 97 exact native targets with 97
supporting proofs. Reference HTML IDs/local links, provenance and frozen compiler
hashes pass their checks. The complete integration driver also passed strict
parser regeneration, all native integration targets and proofs, and the regenerated
92-proof corpus (`Failures: []`). Full discovery and active-label regeneration
remain pending; the focused/native results do not replace them.
New full discovery and active-label runs use immutable snapshot
`/tmp/clean-nested-projection-validation-hrnvtp2p`, based on `89280fa` plus the
production patch. Its conversion SHA-256 is
`a1fe222ecfc6341cecac145a2f9b539cdafd137d520dafc6ba0e7f6f4a3f87d1`.
Metadata is in `/tmp/clean-nested-projection-validation.json`; the corresponding
`/tmp/clean-nested-projection-full.json` and `-active.json` record PIDs and exits.
Earlier live runs are not restarted or counted as passes. Older operator
active-label process 225099 was observed defunct with no completion log; it is
incomplete evidence, not a successful validation.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Fresh projection result reuse

Public comparison entry for a projection first re-elaborates the complete source
projection in the current environment and scope. Stored types and checked-argument
payloads do not certify that entry. Inside the synchronous traversal, producer-field
selection and base normalization use the freshly checked base. If producer selection
has not supplied a reduced field and the normalized base contains no hidden binder,
compare its tree, emitted expression, rendering, precedence, type, rendered Lean
type and inferred arguments with the checked base. If all are unchanged, return the
freshly checked projection itself. Otherwise reconstruct the projection and its
dependent field type. Hidden-binder and producer-reduction rules remain unchanged.

This avoids repeating dependent field substitution for an unchanged projection.
The witness is restricted to the current traversal under fixed declarations and
scope; no projection cache survives a public call. Failed source checks propagate.
No parsing, conversion equivalence, selected declaration or emitted target changes
are intended. Eight-level unchanged projections have one `project` construction
per level; changed local values/types and normalized bases remain separately tested.
:::


:::llm gpt-6 2026-11-11 role=assisted

Projection-result validation passes: 51 comparison/projection regressions,
462 joint solver tests, 115 joint runtime tests, eight independent canonical Lean
targets (four source and four normalized), and two agreement proofs. All four
corpus documents have identical legacy/joint output with stable matching source
fingerprints; all 92 corpus proofs pass. The reference HTML links/IDs and
provenance checks pass. Corpus evidence and diagnostic scope are retained in
`studies/parameterized-literals/compatibility.json` under
`fresh_projection_results_corpus` and `fresh_projection_results_diagnostics`.

Before this change, the selected `restricted active labels` declaration completed
in the diagnostic; it was not the unresolved bottleneck. A separate 90-second
stack-sampling window reached `active label equivalence` but did not complete.
Its samples showed dependent projection substitution during comparison. These
observations motivated the narrowly scoped reuse above; they are neither an
end-to-end speedup measurement nor full-study validation. The post-change diagnostic also reached `active label equivalence`; its
20-second selected-declaration observation ended without completion (exit 2).
It remains separate from the preserved live validation jobs. Full current
regression and active-label regeneration remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Fresh producer arguments during field selection

A comparison traversal that has freshly checked a projection may pass the checked
producer arguments to field selection. The witness is local to that synchronous
traversal with fixed declarations and lexical scope. A stored `checked_args`
payload does not establish freshness. Direct helper calls without this witness
continue to elaborate source arguments; missing or arity-mismatched payloads also
use that path. Retained module producers still validate their declaration identity.

For a freshly checked constructor, select its already checked field argument.
For an authored producer, substitute its freshly checked explicit arguments into
the frozen body using the existing hygienic substitution. Check the selected
substituted field as before. If selection needs an intermediate producer, check
that producer first and carry freshness only into its immediate selection. The
selected expression is fresh for subsequent comparison normalization.

Public projection comparison still checks the complete source expression,
including unused actual arguments. Implicit-argument reification, shadowing,
hidden-binder handling and dependent field-type checks are unchanged. No parser,
conversion equivalence, inference policy or emitted target changes are introduced;
no checked value is cached across public invocations. Failed checks propagate.
:::

:::llm gpt-6 2026-11-11 role=assisted

Producer-argument validation passes 57 focused comparison/projection tests,
462 joint solver tests and 115 runtime tests. Ten independently specified native
projection/producer targets and three agreement proofs pass. Both elaboration
routes emit identical text for all four corpus documents under stable matching
fingerprints; all 92 corpus proofs pass. Evidence is retained under
`fresh_producer_arguments_corpus` and `fresh_producer_arguments_diagnostic` in
[the compatibility report](../studies/parameterized-literals/compatibility.json).

A controlled five-level argument chain in a producer with an unused lambda field
requires 20 argument checks on baseline `dc3768d` and 10 after this change, with
identical Lean, type and source tree. This is a work-count diagnostic, not an
end-to-end timing claim. The selected active-label declaration still did not
complete during its 20-second observation window (exit 2); snapshots and
comparison normalization remain substantial work. Updated full regression is
pending. Earlier live validation jobs remain preserved and are not counted as
passes. Reference HTML IDs/links and provenance checks pass.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Opaque projections in contextual comparison emission

After normalizing a checked call, comparison-key emission may recognize a
projection child as already stable only when it retains exactly one freshly
checked base and that entire base satisfies the existing stable-opaque test.
That test permits unresolved local values without local definitions, supported
literal leaves and native declared calls/operators with recursively stable
arguments. Authored definitions, local callable applications, hidden binders and
unsupported expression forms remain outside this shortcut.

The projection's field and dependent type were checked during the preceding
normalization. The shortcut only avoids repeating that normalization during
comparison-key emission. It does not alter the emitted accessor or select a
new field. Public comparison still elaborates the full source tree in the
current scope; stored projection/call payloads do not establish freshness.
No cross-invocation cache, new conversion relation or grammar rule is introduced.

For a projection over a stable opaque base there is no authored producer field
or local definition left to expand. Applying the same normalizer again would
retain the same accessor and type. Native parent templates are still checked
against their fresh arguments. This establishes preservation of the comparison
key under the fixed-declaration synchronous-traversal assumption.
:::

:::llm gpt-6 2026-11-11 role=assisted

Opaque-projection validation passes 70 focused comparison/projection tests,
462 joint solver tests and 115 runtime tests. Eleven independently authored native
targets and four agreement proofs pass. Both elaboration routes produce identical
Lean text for all four corpus documents under matching stable fingerprints;
all 92 corpus proofs pass. The report retains this evidence under
`opaque_projection_comparison_corpus` and the controlled diagnostic under
`opaque_projection_comparison_diagnostic` in
[the compatibility report](../studies/parameterized-literals/compatibility.json).

In the controlled fixture, eight enclosing native calls cause nine normalizations
of the opaque projection on baseline `8b35696` and one after the change, with
identical comparison keys. This does not measure full-study throughput. Full
updated-revision regression and complete active-label validation remain pending;
earlier live jobs are preserved. Reference HTML IDs/links and provenance pass.
:::

:::llm gpt-6 2026-11-11 role=assisted

The post-change active-label diagnostic reached the selected declaration but its
20-second observation ended with exit 2 and translation incomplete. It supplies
no full-study completion or speedup claim; the controlled work-count result above
is the measured improvement.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Sharing-independent comparison snapshots

The optional comparison memo's semantic snapshot now interns completed structural
nodes, rather than assigning a distinct key node to every physical object.
Object identity remains a traversal-local optimization only. It is not part of
the resulting key. Mutable objects are reread on every snapshot invocation.

Traverse lists, tuples and the existing explicit dataclass schema in their fixed
field order. Preserve atom type tags, container tags, annotation payloads and all
nontransient fields. After visiting a node's children, look up its exact immutable
structural tuple in a per-snapshot intern table. Reuse its ordinal if equal;
otherwise append it to the canonical node list. Save that ordinal in the separate
object-visit table. Active-object detection still rejects cycles before consulting
the completed-object table. The existing visit budget and unsupported-schema
fallback are unchanged; no digest or object-identity comparison can establish a
semantic cache hit.

For example, a list containing the same `['Local','x']` object twice has the same
snapshot as a list containing two separately allocated equal copies. Changing
only one copy changes the snapshot. Sharing and copying are implementation details,
not new Clean conversion rules. The same immutable structural tuple is interned
only after its children are canonicalized; induction over finite acyclic values
therefore gives the same graph for equal ordered semantic data, independent of
sharing. Distinct atom types, field values, order and container kinds remain
observable. A larger copied graph may exhaust the budget sooner, but that only
prevents caching and does not establish equality or reject a valid comparison.

Memo lifetime, binder-identity restrictions, public source rechecking, declaration
checks and failed-snapshot behavior remain unchanged. No parser, emitted Lean term,
retained-tree serialization version or mathematical equality rule changes. The
snapshot is an ephemeral implementation key, not a published file format.
:::

:::llm gpt-6 2026-11-11 role=assisted

Sharing-independent snapshot validation passes 114 focused comparison tests,
462 solver tests and 157 runtime tests. Twelve exact native targets and five
agreement proofs pass, including the rebuilt-value comparison key. The native
checker now reports counts from its checked declarations instead of a fixed label.
Four corpus documents produce identical legacy/joint Lean under stable input
fingerprints; all 92 corpus proofs pass. Records are stored as
`sharing_independent_snapshots_corpus` and
`sharing_independent_snapshots_diagnostic` in
[the compatibility report](../studies/parameterized-literals/compatibility.json).

A controlled same-pool fixture changes from two normalizations on `63a9686` to
one for two equal expressions with different type-object sharing, with identical
keys and types. An independent 20-second import observation stopped in the subpath
prerequisites before reaching the selected active-label definition. It supplies
no full-study throughput result. Full current-revision discovery and complete
active-label validation remain pending; existing live jobs are preserved.
:::

:::llm gpt-6 2026-11-11 role=assisted

The follow-up observation armed its 20-second window only after entering
`restricted active labels`. It reached that declaration but ended before it
finished; total wall time including prerequisites was 38.55 seconds. The record
is `sharing_independent_snapshots_active_observation` in the compatibility report.
This confirms remaining expensive work in the target rather than an import-only
observation. It still establishes neither completion nor an end-to-end speedup.
:::

:::llm gpt-6 2026-11-11 role=assisted

Computed-index substitution now reuses identical retained sources within one
dependent call, invalidating on every inferred-argument assignment and binder
allocation. The controlled repeated-dimension fixture needs one substitution
instead of three with identical source tree, Lean term and Lean type. A separate
case retains a later comparison-equal local representative in the result type.
Sixty focused tests and fourteen canonical native targets plus five supporting
proofs pass. These are implementation checks, not new topology proofs or evidence
of complete active-label throughput. Full regression remains pending. The exact
rule is in [the specification](spec.md#computed-index-reuse-within-a-dependent-call).
:::

:::llm gpt-6 2026-11-11 role=assisted

The computed-index change also passes the four-document compatibility check:
legacy and joint generated Lean text is identical under stable fingerprints,
and all 92 corpus proofs check. The records are `computed_index_reuse_corpus`
and `computed_index_reuse_diagnostic` in
[the compatibility report](../studies/parameterized-literals/compatibility.json).
:::
