:::llm gpt-6 2026-11-11 role=assisted

# Active-label translation diagnostic

The active-label equivalence is still an outstanding topology integration check.
It must not be replaced with an opaque native adapter to avoid its translation cost.

A bounded cProfile observation of `Define active label equivalence` on commit
0b1492f ended after 30 wall seconds, before translation completed. Prerequisites
loaded before the observation began. This is diagnostic evidence, not a validation
pass, termination of any full regression run, or proof that translation diverges.
Concurrent regression processes competed for CPU, so wall times are not a stable
performance benchmark.

The sample recorded 18,756,536 calls, including recursive calls. `_elaborate`
appeared 142,211 times; `_normal_form` 82,113 times; `comparison_key` 10,200 times;
and `index_value` 10,037 times. Their cumulative times overlap and must not be
summed. Retained encoding took about 0.58 cumulative profiler seconds and JSON
encoding about 0.28 seconds. The sampled cost therefore points to repeated
elaboration/comparison work rather than payload encoding alone. This does not
exclude a later encoding bottleneck outside the observation window.

Next investigation: trace repeated dependent-index construction and contextual
comparison through nested authored calls. Reuse must have a synchronous freshness
witness under the same explicit environment and local scope. Persisted metadata,
identity alone, or an earlier successful elaboration cannot justify skipping
validation. Preserve scope changes, retained binding identity, binder hygiene,
and exact native targets in regression tests before integrating a repair.

## Reproduce the observation

From the repository root, in the pinned Python environment:

```sh
python tools/profile_declaration.py library/diagrams/active_labels.clean \
  'Define active label equivalence(I,n,a,m,h,L,v,support,left,right):' \
  --seconds 30 --output /tmp/clean-active-label.prof
```

The tool profiles only the named declaration. Prerequisite loading has no timer.
Exit 2 means the observation window ended or the requested header was not reached;
read the diagnostic. An ordinary translation error retains its traceback. Exit 0
means the selected declaration and module load finished, not that Lean checked
any generated code. The diagnostic never stops another process or changes source.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Immediate index construction reuse

The first implementation change passes an internal freshness witness from
substituted-index elaboration and checked value-index type arguments to index
construction. This avoids re-elaborating an expression immediately after checking
it. Public entry points retain their rechecking behavior. The witness is not
serialized or inferred from cached operands. Dimension negativity checks and
retained declaration identities still run. Grammar and intended Lean terms are
unchanged.

Focused validation passed 46 existing index/storage/comparison/carrier tests,
and a 16-test argument suite including four new cases: identical serialized
results with and without reuse, removal of duplicate root elaboration, scope
changes at public entry points, and changed retained bindings. Full native
integration and a second bounded active-label profile are pending.

Eight historical discovery processes were explicitly terminated as superseded
on 2026-11-11, after inspecting their live process commands and working directories:
choice-conversion, the mutable working-directory contextual run, assumption-block,
composed-language, classifier metadata, classifier syntax, explicit carriers,
and classifier values. All are incomplete, not passes. Six enclosing tool sessions
reported 143; the composed-language and classifier-syntax driver sessions reported
1 after their terminated children. The two newer immutable integration/schema-4
baseline runs were kept. This supersedes earlier descriptions of the eight runs
as live; their logs and checkouts remain available.
:::

:::llm gpt-6 2026-11-11 role=assisted

The integrated parser reproduction and 445 selected Python tests pass after the
reuse change (51.643 seconds for the selected suite). A second 30-second profile
still ended before the active-label equivalence finished. Its 58,133,435 sampled
calls cannot be compared as a speed ratio with the first profile: competing CPU
load changed when obsolete runs were terminated, and neither observation covered
a completed declaration. The new focused regression proves removal of duplicate
root elaboration, not a whole-module speedup.

Full discovery now runs against immutable commit be1579c in a separate checkout.
Native target checks remain in progress; no full conformance claim is made.
:::

:::llm gpt-6 2026-11-11 role=assisted

The native integration run completed successfully: 32 exact target comparisons,
12 supporting proofs, and all 92 corpus proof fixtures passed under the pinned
Lean/Mathlib environment. This includes the actual Mayer–Vietoris inclusion maps
and their zero-composite proof, not the full long exact sequence. The runner ended
with `Failures: []`. Full discovery and completed active-label translation remain
pending. No whole-module performance improvement is claimed.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Already-normalized native operator children

Within one contextual-comparison traversal, a freshly normalized native operator
or prefix application is stable when its retained binding identity still matches,
its declaration is not Clean-authored with `Equals`, and every checked child is
stable. Freshly checked numeral leaves are stable too. Such a subtree goes directly
to comparison emission without another normalization traversal. Emission still
checks the binding and exact native call template. Local definitions, authored
calls, unchecked expressions, and restored caches do not establish stability.
Public comparison re-elaborates its source under the current explicit environment.
This is a work-reuse rule, not a grammar, inference, or Lean-target change.
:::

:::llm gpt-6 2026-11-11 role=assisted

The pre-fix independent traversal-count tests failed: seven nested additions
normalized 28 operator nodes; six nested negations normalized 21. The implementation
now normalizes seven and six respectively, retaining exactly the original native
comparison key in these fixtures. Interaction checks cover authored aliases under
operators and newly competing overloads. This establishes removal of repeated
subtree work, not completion or a speed ratio for the active-label study.

The first focused command named a nonexistent `test_operator_bindings` module and
failed to import it. The corrected command uses `test_declared_standard_operators`;
its result and the broader native check are recorded below when complete.
:::

:::llm gpt-6 2026-11-11 role=assisted

The corrected focused run found an obsolete fixture import: the production
operator test loaded a historical `.proposed` module without classifier metadata.
The test now uses current explicit type/equality declarations and an independently
declared Counting numeral type. Its first migration attempt imported a module
with a conflicting default; the final fixture deliberately imports only types
and declares equality before selecting its default. Historical study sources are
unchanged. All 44 focused checks now pass, including retained numeral-constructor
replay under a different default. Broader integration remains pending.
:::
