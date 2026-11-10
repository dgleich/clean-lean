:::llm gpt-6 2026-11-10 role=assisted

# Delay comparison-name reservation until a binder is allocated

An isolated optimization of `binder_keys.Pool`; production remains unchanged.
A 15-second diagnostic profile of active-label module loading showed repeated
whole-environment text traversal in `environment_tokens`: 1,922 scans with 9.739
seconds cumulative time in the sampled prefix. The profile was intentionally
interrupted; it is not a failed validation run or a measurement of total load cost.
Neither of the existing full regressions was interrupted or restarted.

The prototype reserves source-tree and caller identities immediately, then scans
the declaration environment just before the first comparison-owned identity is
allocated. It still checks new local scopes at each allocation. It retains the
existing exact text-snapshot validation inside `environment_tokens`; there is no
new global cache or assumption that mutable declarations never change between
comparisons. A later pool observes the then-current environment.

## Why the comparison result is unchanged

The comparison contract requires a fixed explicit environment during one traversal.
If no binder is allocated, no reserved environment token is used: the result has
no comparison-owned identities. If a binder is allocated, the first allocation
sees exactly the same union of environment, source-tree and local tokens as the
eager algorithm. Union order does not matter. Its first fresh name is therefore
unchanged. Subsequent allocations use the same counter and extend the same sets,
so induction gives the same names and ScopedKey. Nested comparisons share the same
pool and reservation state. Mutation of the environment during a traversal is not
introduced as a supported operation by this optimization.

## Evidence

Five independent tests cover collisions in environment/native/source/local text,
new local scope at allocation, a later pool after environment mutation, zero scans
for binder-free comparisons, and one scan per quantified comparison with identical
alpha keys. All five pass. The 108 existing contextual comparison tests also pass.
The initial fixed batch took 11.879 seconds, compared with 22.686 seconds in the
recorded production integration run. These wall times are observations under
concurrent workloads, not a general speedup guarantee.

The lazy 15-second profile proceeds through a different prefix of module loading;
its call counts must not be compared as if it completed the same work. Environment
reservation no longer appears among its top 28 cumulative-time entries. Further
normalization/elaboration costs remain; full active-label load time is unverified.

The pinned reproduction completed with exit 0 on 2026-11-10: 113 tests in
11.649 seconds, ten exact native target checks and five proofs. Existing Lean
unused-variable warnings were nonfatal. A one-second smoke run of the diagnostic
script reported its compiler path and explicitly marked the load incomplete.

## Reproduce

```sh
LAKE=lake python3 studies/lazy-comparison-reservation/verify.py
```

The driver exports pinned baseline `61e83d6e0486fe845a36fa300ac89bb3b2e6063c`, applies only the
stored reservation patch, runs the 113 focused checks, then independently checks
ten native targets and five proofs through the existing contextual/choice drivers.
`profile_load.py --seconds 15` provides the optional bounded diagnostic. Set
PYTHONPATH to the compiler checkout being examined; it prints that path and labels
a cutoff as incomplete. It only interrupts its own diagnostic process and is never
called by the validation driver. It does not infer completion from elapsed time.

This is not production integration, full-suite validation or a topology-paper proof.
:::
