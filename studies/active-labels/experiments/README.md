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
