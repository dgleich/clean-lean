:::llm gpt-6 2026-11-10 role=assisted

# Combined language integration study

Status: an isolated combined checkout, **not production integration**.
This study checks whether the separately tested candidate changes can coexist on
one fixed compiler/library baseline. It does not replace the broader goal with a
claim about only the cases already passing.

Baseline: `45cf68e49450dd14a343f1c569c3d97471828f70`.
The driver uses `tools/study_checkout.py`, copies the retained-value codec, and
applies these patches in order:

1. Explicit literal annotations.
2. Retained literal declarations, actual arguments and checked annotations.
3. Versioned index storage, with serialized payloads authoritative over caches.
4. Delayed comparison-name reservation.
5. Reuse of freshly checked stable native comparison arguments.
6. Named assumption expression blocks.

The generated parser is rebuilt from the combined grammar with strict LALR and
lexer checks. The driver does not concatenate generated parsers or bypass a
conflict. The two comparison optimizations are independent of the storage codec:
neither grants freshness to a deserialized tree or trusts public metadata.
The stable-native predicate does not classify retained literals as native calls;
those continue through their existing declaration/annotation validation.

## Cross-feature specimen

[Interactions.clean](Interactions.clean) includes:

```clean
Result explicit vector zero assumption:
  Attribution: local; identity; original
  Let n: Natural
  Let v: Vector(n,Complex)
  Assume zero:
    v = (0: Vector(n,Complex))
  Conclude: v = (0: Vector(n,Complex))
```

The zero adapter is explicitly imported from the retained-literal interface module.
A second statement inherits an assumption block from a Context and uses a zero
whose dimension is projected from a dependent record. Both remain experimental
source forms in this checkout; the production compiler does not yet accept them.

The new Python tests check selected literal identity and actual arguments under
both blocks, context inheritance, and retention inside an encoded proof-index
payload after its optional resolved cache is removed. They also ensure this
composition does not silently enable unannotated vector-zero inference.
The two independent native proposition oracles retain the selected vector-zero
wrapper and projected dimension. Their proofs use the given hypotheses.

## Validation evidence

On 2026-11-10 the initial combined reproduction passed strict parser generation
and its reproducibility check, then 353 Python tests in 48.823 seconds. Nine native
verifiers passed 56 exact targets and 24 proofs, covering literals, dependent
records, payload-only indices, contextual comparison, choice, assumption blocks,
exact sequences, module products, and actual inclusion-induced homology maps.

The four newly added cross-feature Python checks passed separately in 0.217
seconds in that same combined checkout; their two exact native targets and two
proofs also passed. Thus the selected evidence totals 357 tests, 58 exact native
targets and 26 proofs, with the separate-run scopes explicit. The 92-proof corpus
also passed. Only existing native unused-variable warnings were reported.

A fresh reproduction using the expanded driver and `--full` has been started.
Its full discovery result is pending. Existing production/contextual/assumption
validation processes were left running; no observation timeout was treated as
completion and none was restarted to obtain a cleaner result.

## Reproduce

```sh
LAKE=lake python3 studies/composed-language/verify.py
```

Use the pinned parser development dependencies. By default the checkout is
removed after selected checks. To retain a new checkout and also run unrestricted
full test discovery:

```sh
LAKE=lake python3 studies/composed-language/verify.py --directory /tmp/clean-combined-review --full
```

The directory must be new or empty. The driver reports all selected-check
failures rather than silently dropping a failed verifier; parser generation
failure stops before semantic checks. The `--full` run has no automatic timeout.
It is not evidence of success until the process returns with its actual result.

## Remaining integration requirements

Production integration and full-suite results remain outstanding. The codec's
structural decoder is not a complete semantic validator for arbitrary stored
records. Exact retained-literal declaration snapshots still need their broader
native-environment contract, and unannotated joint operator/literal inference
remains unsupported. General universe and adapter-isolation obligations are not
resolved by combining these patches. Editor/browser coverage of the new syntax
is still pending. Missing mathematical constructions and paper proofs retain
their separate entries in the topology implementation audit.
:::
