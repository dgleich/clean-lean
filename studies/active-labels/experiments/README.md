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
