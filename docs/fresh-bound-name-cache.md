:::llm gpt-6 2026-11-07 role=assisted

# Caching the declaration-name scan

This is an implementation optimization with no grammar, scope, or Lean-target
change. `fresh_bound` still chooses the least available `clean_pi_bound_N`, avoiding
identifiers in every generated declaration and in the current locals and their
rendered types. A live comparison-identity pool still owns allocation when present.

The compiler caches only the union of identifier tokens scanned from generated
declaration texts. Each environment retains one pair: an immutable tuple of those
texts and a frozen token set. Reuse requires exact tuple equality. Adding, deleting,
reordering, or changing a text causes recomputation when the tuple changes. No
hash-only, length-only, timestamp, or object-address comparison selects reuse.
Current local names, targets and rendered types are rescanned on every allocation.

The invariant is direct: equal tuples of immutable strings have equal token unions.
The current local token set is then combined with that same union, so the least
available integer and resulting Lean name are unchanged. The cached set cannot be
mutated, and an environment cannot borrow another environment's cache. The pool
path returns before touching the cache, preserving its fresh-allocation side effects.

This does not cache checked calls, expression meanings, proof comparisons, or
inference results. The earlier tree-only checked-call reuse experiment remains
rejected because it could retain a stale caller target/type.

## Evidence

Six tests compare cold and warm allocation, text addition/replacement/deletion,
changed local targets/types, changed type renderings, declaration order, and active
pool ownership. The wider isolated run passes 282 focused tests. The generic
subtype study passes ten exact target checks and three proofs with this change.
Further main native regressions and the current full-suite run are recorded in
the topology validation log; incomplete full suites are not passing evidence.

In single instrumented, concurrently running loads of the generic subtype module,
allocation was called 33,998 times in both versions. Time measured inside allocation
fell from approximately 10.75 seconds to 3.25 seconds; total elapsed time was 56.00
and 49.89 seconds respectively. These are diagnostics, not controlled benchmark
claims. The interval stress translation remains incomplete, and this change is
not claimed to eliminate its repeated comparison work.

Run `python3 tools/profile_scope_allocation.py` for the same workload in the current
checkout, or pass `--root` pointing to another checkout. The profiler reports
measurements only; timing cannot influence translation or choose a target.
:::
