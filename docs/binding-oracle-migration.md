:::llm gpt-6 2026-11-07 role=assisted

# Migrating binding expectations after integration

The reordered full discovery run exposed sixteen failing checks before it aborted
at a timed stack dump. Focused reruns establish the causes and corrections below.
All 161 tests across the twelve affected modules pass after migration. This is not
a completed full-suite result.

## Preserve exact checks under the new target rules

Native type uses now name their root-qualified abbreviations. Expected vector,
scalar, lambda-domain, submodule and chain-map targets use an explicit binding-name
mapping. The identity, custom Count and submodule checks independently assert the
native adapter body as well as its use. No check replaces canonical or structural
comparison with mere definitional equality.

Local type parameters use LocalType. In the subspace-carrier check, the expected
set carrier is the local V binder rather than a module type merely spelled V.
Generated callable table lookup uses `native_binding`, not a token split from the
root-qualified emitted term. The homology-map test now uses that declared key.

An expanded authored certificate retains a ModuleCall with its selected constructor
template. Its expected tree now checks that retained binding and all arguments.
Local chain-map tests check the full `(K) (field) (R) (S)` application rather than
looking for obsolete whitespace around inline type bodies. Quantified-vector tests
still require the fresh native dimension binder and reject the source spelling.

## Restore the intended index diagnostic

A noncondition index that contains a bare binder must fail the existing
`Computed indices do not introduce binders` rule. Closing module calls first had
raised a lower-level UnclosedBinding error before that rule ran. The structural
binder check now runs after the existing immediate beta contraction and before
module-call closing. Closing does
not introduce binder constructors: it selects call heads, preserves arguments and
stores checked type annotations. Accepted terms and their target rules are
unchanged; unsupported binder input receives its specified diagnostic again.
Three existing rejection tests (applied, computed and family indices) check this
boundary without broadening their accepted error messages.

## Validation state and diagnostic failures

The first seven affected modules pass 119 tests; the remaining five pass 42.
The 739-test discovery run was moved past active-label loading without omitting
any tests, but it terminated with exit 139 during a timed faulthandler stack dump.
The separate active-label profiler and the earlier instrumented main-tree full
run also terminated with exit 139 while dumping stacks. Some dumped frame names
and line numbers were corrupt. The underlying native crash cause is not established;
none of these aborted jobs counts as a completed validation run.

Core dumps are retained locally outside the repository. The profiling helper now
uses ordinary per-declaration timings by default and an opt-in Python-thread stack
sampler (`--stack-every 120`), rather than an asynchronous faulthandler timer. The
replacement profiler is active and has produced a valid Python stack sample.
The earlier uninstrumented five-patch full run remains active separately.

A new current-compiler run collects all 739 tests without timed stack dumping.
Only the active-label and review modules are moved to the end; no tests are skipped.
Its completion and further failures remain pending. Subsequent reports must inspect
the running process/log rather than infer success from the focused repairs here.
:::
