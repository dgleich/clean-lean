:::llm gpt-6 2026-11-07 role=assisted

# Caching comparison-pool token scans

This implementation optimization changes no grammar, scope rule, inference policy,
or emitted Lean term. A comparison pool still chooses the least unused
`clean_comparison_identity_N`, reserves it, and records ownership for scoped keys.

Each pool collects an immutable tuple of all string leaves in `environment.data`
and `environment.notation_definitions`. Traversal includes dictionary keys and
values and recursively visits lists and tuples, exactly as the previous scanner
did. Other objects remain ignored. The environment retains this tuple together
with its frozen union of identifier tokens. Reuse requires exact tuple equality;
it never depends on a digest, object identity, collection length, or timestamp.
The implementation assumes the existing synchronous environment access model.

Equal tuples give equal token unions under the fixed identifier expression.
Copying that union into a new pool therefore gives the same reserved environment
names as scanning again. Expression trees are scanned anew for each pool. Local
names, Lean terms and type indices are rescanned on allocation as before. The
pool's mutable reserved set, ownership set and counter are never cached. Thus an
induction over allocations gives the same fresh-name sequence with cold or warm
cache state. Nested edits, deletion and replacement change the snapshot whenever
they change its strings. Reordering can cause an unnecessary rescan, not a change
in the token union or generated names.

This is lexical caching only. It does not cache expression meanings, inferred
types, proof comparisons or checked subtrees. It still traverses environment
strings on every pool creation and does not solve the entire translation bottleneck.

## Evidence and reproduction

Seven regressions cover warm reuse, nested mutation, declaration replacement and
deletion, dictionary keys, mutable expression trees, changed local terms/types,
and declaration order. The focused comparison/inference suite passes 285 tests.
Native checks pass eleven declaration-identity targets with changed-proof rejection,
and four interval-basis targets with pointwise and full restriction proofs.
The current full Python suite and specialized active-label verifier remain pending.

Run `python3 tools/profile_comparison_tokens.py --iterations 100` for a diagnostic
that asserts identical cold/warm fresh names. One run measured 0.0753 seconds cold
and 0.0123 seconds warm. These are pool-allocation timings, not compiler throughput.
Two 30-second sampling profiles of active-label loading observed 608 versus 45
samples in `re.findall`; workloads progressed to different phases and other jobs
were running, so this is evidence of reduced scanning, not a controlled speedup.
:::
