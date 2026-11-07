:::llm gpt-6 2026-11-07 role=assisted

# Selected-field compiler: native validation checkpoint

All 34 native study verifiers in the frozen selected-field snapshot completed
successfully. This is the compiler implementation committed in `3946c7a`; its
19 Python source files are byte-identical to current main at `c499ec9`. The
snapshot predates the clipping study and later prose metadata correction.

The current clipping study separately passed eight exact targets and three proofs;
its five Python checks passed. After the IntervalLabels prose correction, the
zigzag study was rerun on main: 46 exact targets and six proofs passed. The
92-proof corpus was also checked after the compiler change. The four identity
acceptance variants and the isolated operator prototype have separate checks;
the latter is not integrated main-language syntax.

The full Python run for the selected-field snapshot and the current browser
inventory/UI validation remain pending. The selected-field Python process returned
exit status 143 without a terminal unittest summary; its log ends during
`test_import_navigation_and_fresh_targets`. The termination cause has not been
established, and this is not a passing full-suite result. This report does not claim complete
language conformance or proofs of the research-paper targets.

## Native verifier results

Each command was run with the pinned Lean/Mathlib dependencies. The table records
successful process completion, not merely a log substring. The orchestrator
returned exit status zero and an empty failure list.

| Verifier | Result | Seconds |
|---|---|---:|
| `studies/callable-evidence/verify.py` | PASS | 10.35 |
| `studies/dependent-functions/verify.py` | PASS | 12.51 |
| `studies/dependent-functions/verify_closed_universes.py` | PASS | 12.51 |
| `studies/dependent-functions/verify_homology_maps.py` | PASS | 27.42 |
| `studies/dependent-functions/verify_maps.py` | PASS | 12.52 |
| `studies/dependent-functions/verify_proof_families.py` | PASS | 12.02 |
| `studies/dependent-functions/verify_relative_graded.py` | PASS | 17.88 |
| `studies/dependent-functions/verify_scoped_families.py` | PASS | 21.58 |
| `studies/diagram-maps/verify.py` | PASS | 13.32 |
| `studies/dimensions/verify.py` | PASS | 11.05 |
| `studies/inferred-conversion/verify.py` | PASS | 11.49 |
| `studies/magnetic/verify.py` | PASS | 0.18 |
| `studies/shape-pullbacks/verify.py` | PASS | 12.21 |
| `studies/subpath-restrictions/verify.py` | PASS | 27.98 |
| `studies/topology/verify.py` | PASS | 0.11 |
| `studies/topology/verify_bundles.py` | PASS | 11.04 |
| `studies/topology/verify_chain_squares.py` | PASS | 15.03 |
| `studies/topology/verify_compact_image.py` | PASS | 10.25 |
| `studies/topology/verify_evidence.py` | PASS | 11.63 |
| `studies/topology/verify_extreme_images.py` | PASS | 618.34 |
| `studies/topology/verify_homology.py` | PASS | 8.57 |
| `studies/topology/verify_indices.py` | PASS | 6.95 |
| `studies/topology/verify_interlevel.py` | PASS | 8.61 |
| `studies/topology/verify_local_names.py` | PASS | 15.5 |
| `studies/topology/verify_pair_composition.py` | PASS | 8.11 |
| `studies/topology/verify_paths.py` | PASS | 7.69 |
| `studies/topology/verify_relative.py` | PASS | 17.13 |
| `studies/topology/verify_relative_maps.py` | PASS | 13.4 |
| `studies/topology/verify_shifted_perturbations.py` | PASS | 493.62 |
| `studies/topology/verify_spaces.py` | PASS | 13.22 |
| `studies/topology/verify_subspaces.py` | PASS | 5.77 |
| `studies/topology/verify_well_groups.py` | PASS | 450.5 |
| `studies/type-expressions/verify.py` | PASS | 8.01 |
| `studies/zigzag-bases/verify.py` | PASS | 8.88 |

## Artifact and source reconciliation

All 72 shared `.lean` artifacts under studies agree with the current worktree,
ignoring only provenance comment lines. No generated Lean artifacts needed to be
copied back. This byte comparison is not itself a proof: proof and target-check
coverage is determined by each verifier above. The current TeX metadata intentionally
differs where the interval-label description was corrected.

Compiler source SHA-256 values checked against the frozen snapshot:

| File | SHA-256 |
|---|---|
| `cleanlang/__init__.py` | `d30af58de1f667b7c1d6e0ef8d702ae4be70ac524950b8e701074295000be6f7` |
| `cleanlang/__main__.py` | `8c43271aae25ad6314aa135a7bd4f8335506987dceac129dc0a5a470ba57f719` |
| `cleanlang/attribution.py` | `6bbb9007c80a1957dd5b5753a610a0625c4deeaf2cf02c36e2d94fe415584361` |
| `cleanlang/beta_indices.py` | `75d4ea7b791ec43bd63df441310a77271bf7ed8fa0db720b93a41d07e4bb01c9` |
| `cleanlang/binder_keys.py` | `787d6e1db910294575d07a3a014b8f9a862386b59472f77dd613a9754b157519` |
| `cleanlang/conditions.py` | `509fd03421324b40f52294640947e04cb56f8771c35a4295b2c36fa6f32127da` |
| `cleanlang/conversion.py` | `6c70fb6850bb69b734efaadc8214fab6e05ca617c2f088a1611ed9384811150e` |
| `cleanlang/core.py` | `338505201ad43bed62be246b835e87d2537192fda5c49d63d874e4f0139eb883` |
| `cleanlang/dependent_functions.py` | `5c0c6aa65e4c79b70c7d97369512580aca3fd5dea7214cca25d6a2019ac31681` |
| `cleanlang/generated_parser.py` | `72a21ae43303081e9c0ebe50a862fb802205289aa90b00f505a675385b125fb4` |
| `cleanlang/hygiene.py` | `f2bde923cd480a161eaaab7e6bb1fd2466b5bab8f452e7e83965e6fde4bb72b7` |
| `cleanlang/indices.py` | `b72d93b100641606fa9a369bc992750eef0339f922fbf341705f3a0b8f9e59a5` |
| `cleanlang/inferred_conversion.py` | `d1f233c63326cd05a8dc23c008668737bae0f6418503b131c214fa66b4fd9449` |
| `cleanlang/literate.py` | `a04ffc59ad77f63a669a71ac9ece66023a97557c119c691f2fd967dff658b242` |
| `cleanlang/modules.py` | `154890e9e9add926362568a66410b7fe9dda504ce684e9de52c9f29506b00e37` |
| `cleanlang/proof_types.py` | `d20b0788b3d9728ec37d1452418b8cb30d009f984e097f0056438b645e285651` |
| `cleanlang/structures.py` | `bc76dbc0f5bb1a07a43e39218065cba7390d0aa6a812fc9ad1456c9155dcf3c5` |
| `cleanlang/syntax.py` | `cfc959d1a3a9aac0ab3d3932baf6ac1a26419e7c5016e913a1edd5104db1ca06` |
| `cleanlang/type_values.py` | `cfe09a7895d1a652c07c20b573001cb3c101290a4017fe438195b8ad401b4c7f` |

## Superseded failing snapshot

The older callable-evidence snapshot finished 32 of 33 native studies successfully;
diagram maps failed during unnecessary callable-view serialization. Its full Python
run recorded the corresponding setup error. That Python run was stopped after the
new compiler passed all 34 native studies and while the replacement full Python
run remained active. The stopped run is not a passing full-suite result. It was
superseded because its diagnosed failure was fixed, not because an observation
window expired.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Known-codomain scope and restricted labels checkpoint

`3f0861a` avoids repeating declaration substitution into fully instantiated
dependent codomains. `4b1974c` adds the authored restricted interval-label
constructor and its composed ordering evidence.

- Focused callable/dependent/hygiene/clipping run: 108 tests passed. After adding
  two record-specific cases, the clipping module separately passed all seven tests.
- Expanded clipping native verifier: 14 independently authored exact targets and
  three proofs passed. New targets cover four foundational order adapters, the
  authored ordering evidence, and the constructor with its surviving-label subtype.
- Frozen-source corpus regeneration and Lean check: all 92 proof fixtures passed.
  The corpus matches the tracked artifact apart from provenance and trailing space.
- Rebased isolated operator prototype: strict grammar regeneration, dispatch
  checks, 16 exact targets and two proofs passed. This remains proposed syntax.
- Reference HTML links, search/status controls and mobile width passed.

The fresh full Python run uses `/tmp/clean-codomain-scope`; it has no terminal
summary yet. The browser build uses the corrected compiler and reports per-file
progress; inventory/UI validation remains pending. The preceding browser process
was stopped because its compiler and clipping source were superseded, not because
it exceeded an observation interval.

Current `cleanlang/core.py` SHA256: `2be4a447fec55a878d59b8561b544e528cb387b0b5b8d452952c909ca4564f87`.

The fixed branch applies once every implicit parameter is determined; unresolved
inference still needs a scope audit. Restricted labels do not yet establish
restricted vertex bases or the pyramid extension theorem.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Postfix-application checkpoint

The main parser now accepts repeated argument lists and interleaved field access.
The isolated implementation passed 227 focused regressions. The main tree passes
nine dedicated postfix tests and eight independently authored canonical native
targets with five Lean proofs, including a returned record followed by field
selection and application. Its generated parser passes the strict reproducibility
check. The frozen postfix-source corpus regenerates and checks all 92 proof
fixtures. The source-highlighting text-preservation check and reference HTML
links/search/status/mobile checks pass. The five-example PDF was compiled twice
and inspected on one page.

A new full suite is running from `/tmp/clean-postfix-main`; its compiler snapshot
includes this parser change. The older codomain suite remains a distinct run and
does not validate the new grammar. The pre-postfix browser process was stopped
because its compiler was superseded; a fresh browser inventory remains pending.

The active-label verifier with repeated traceback instrumentation terminated with
status 139 during translation. Its cause is not established. No native proof or
canonical-target check completed in that run. The separate plain translation job
remains active; neither run establishes the active-label existence theorem.

Compiler hashes at this checkpoint:

- `cleanlang/core.py`: `6a1826e627ddfa02665a85857d8cae9ac000a95c2ec783715bd88eaa597d5186`
- `cleanlang/syntax.py`: `13b72d16063542a6fc6216312fdb5fa9ad35a82ef71638643658abe4bad994a0`
- `cleanlang/generated_parser.py`: `87bd2cb7439ce8f00cc330a36fa88c715391707ff3626807385d5b0e3401efe3`

This is another implemented acceptance slice, not complete language conformance.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Generic subtype restriction and superseded runs

The support record and maps are factored into `logic/subtype_restriction.clean`.
Its separate native driver passes ten exact checks (including the constructor's
implicit parameter metadata) and three proofs. Five Python tests pass. The generic
statements' one-page PDF was compiled twice and inspected. The interval-specific
existence theorem is unchanged and still needs completed verification of support
from arithmetic bounds. Its current driver plans fifteen exact checks and four
proofs; those counts remain pending.

The wider focused run exposed an obsolete negative test for `I.lower.other(a).next`,
which is now legal postfix syntax. The updated main structure tests pass all 43
cases, including the independent tree for this form. The previously started frozen
postfix full suite contains that obsolete assertion and the old interval-specific
support source; it was stopped as superseded, not reported as passing. The older
codomain full suite remains a separate live run.

Two comparison experiments remain unintegrated; their patches and results are in
`active-labels/experiments`. One passed 312 focused cases, but neither completed the
interval native checks. Their runs and the original plain interval translation
were stopped when the generic source refactor superseded their input. A newer
interval verifier was stopped after the generic check exposed its obsolete explicit
constructor oracle. The corrected verifier and plain refactored translation remain
pending. The earlier instrumented status-139 crash has no established cause.

The operator prototype also passed its sixteen exact targets and two proofs after
the postfix parser change. This remains an isolated proposal, not main syntax.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Isolated active-label arithmetic

`studies/active-labels/verify_arithmetic.py` passes its native support and existence
proofs using generated generic/clipping foundations and independently authored
native active-set expressions. No full interval canonical comparison is claimed.
The first attempt failed because constructor projections remained opaque to `omega`;
the corrected unfold list passes. Expected-type support record construction also
avoids the invalid explicit call to its implicit constructor parameters.

These fixes are in the full verifier. `--from-generated` can replay the native
checks for an existing artifact without another translation, explicitly labelled
as a snapshot check. The long-running older verifier has its earlier proof code;
its output will need replay with these fixes. The separate plain translation is
still live. Neither has yet emitted the complete interval artifact.

The narrower call-index cache experiment passed 244 focused tests plus ten generic
canonical checks and three proofs. Its interval check is still live and incomplete;
no optimization is integrated. The original tree-only reuse experiment failed two
scope regressions and remains rejected. The current alias-description full-suite
run is also pending, distinct from the older codomain snapshot.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Proof-condition beta and explicit classical choice

The final scoped comparison rule passes 276 focused tests. It uses hygienic
substitution for checked literal applications in proof conditions, including
quantified bodies, and preserves emitted terms. Seven exact choice targets and
three proofs pass, including choice with a universally quantified property.
The existing postfix driver passes eight targets and five proofs; the regenerated
92-statement corpus passes. The choice PDF and reference page checks pass.
A new full-suite run for this rule is pending, separately from the live alias-era
run. The older codomain suite terminated with status 143 and no terminal unittest
summary; its cause is not established and it is not a passing result.

The equality transitivity duplicate in the equivalence module was removed in
favor of the existing equality-chain import. Both import orders pass, along with
seven focused tests and eight native targets/three proofs. No operator-dispatch
or general module-identity completion is claimed by this local conflict repair.

The original interval translation, earlier-proof verifier and call-index-only
experiment remain live. The corrected native interval arithmetic proof is checked,
but the full generated interval artifact is still unavailable for snapshot replay.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Exact-text declaration token cache

The fresh-bound allocator now reuses only the token union of an exactly equal tuple
of immutable generated declaration texts. It rescans current locals/types and
preserves the comparison-pool path. Six targeted tests and 282 wider focused tests
pass in the isolated candidate. Ten exact generic-subtype targets and three proofs
also pass. The diagnostic workload made 33,998 allocation calls in each version;
measured allocation time was 10.75s versus 3.25s. Concurrent total elapsed times
(56.00s versus 49.89s) are not a controlled performance benchmark.

The alias-era and proof-beta-era full suites were stopped as superseded by this
compiler revision, both with status 130 and without a unittest summary. One new
current full suite is running. The older codomain suite previously ended with
status 143 without a summary. None of those incomplete suites is reported green.
The existing interval translation, earlier-proof verifier and call-index experiment
remain live; no interval speedup or completed target comparison is claimed.
:::

:::llm gpt-6 2026-11-07 role=assisted

After integration, main passes seven exact choice targets/three proofs and eight
postfix targets/five proofs. The 92-statement corpus was regenerated and passes the
kernel. The isolated generic generated Lean matches the tracked baseline apart
from provenance comments. The current full suite remains pending.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Fresh-subtree reuse after scope audit

The [audit](../../docs/fresh-checked-subtrees.md) traces the two freshness-producing
paths and the conservative public/stored-value/reduction entries. Main now retains
typed call children and reuses only freshly checked calls with unchanged complete
arguments. It passes 285 focused tests plus 56 scoped-family/evidence tests.
The twelve-call changed-scope regression requires at most twelve module-call
checks, versus 78 in the prior compiler, and preserves the current type/target.
Choice (seven targets/three proofs), postfix (eight/five), and generic subtype
(ten/three) native checks pass. The proof corpus was regenerated and checked.

The declaration-token-cache-only full suite was stopped as superseded, status 130,
without a summary. One new current full suite is running. The isolated interval
verifier uses the now-integrated subtree algorithm and remains live; its source
has not changed. The older plain translation, earlier-proof verifier, and
call-index-only experiment also remain live. No complete interval artifact or
full-suite success is yet claimed.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Comparison-token snapshot cache

The lexical [comparison-token cache](../../docs/comparison-token-cache.md) passes
285 focused tests, eleven declaration-identity targets with changed-body rejection,
and the four interval-basis targets and pointwise/full restriction proofs. Native
regeneration leaves the tracked targets unchanged after provenance restoration.
The isolated operator patch still applies to this source snapshot.

The older plain active-label translation, earlier-proof verifier, call-index
experiment, fresh-subtree interval verifier and pre-cache full Python suite were
explicitly interrupted as superseded. They are not passing runs. A new current
full Python suite and specialized active-label verifier are running; neither has
completed. The latter reaches the specialized equivalence declaration after
checking its generic equivalence and forward/inverse definitions. The interval-basis
restriction proof above uses its separately checked foundation and must not be
confused with completion of that specialized active-label verifier.

A cold/warm pool diagnostic produces identical names. Sampling indicates reduced
regex scanning, but concurrent workloads and differing phases prevent a compiler
speedup claim. The cache retains no semantic or inference results.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Fresh proof-condition traversal

The [fresh-condition audit](../../docs/fresh-condition-comparison.md) adds immediate
checked proof-condition entry points and binary operand metadata to the existing
fresh traversal. Public calls still recheck caller scope. An eight-call regression
falls from sixteen checks to eight; changed-scope and poisoned-metadata cases pass.
The corrected focused command passes 282 tests. An initial command lacked the
fixtures' tests-directory PYTHONPATH and had five import errors; those are not
compiler failures or a passing invocation.

The isolated compiler passes ten generic-subtype exact targets/three proofs and
seven choice targets/three proofs. Main was then updated with the same three
compiler files. The refreshed operator patch applies and its fresh-copy driver
passes strict parser generation, 32 exact targets and three proofs. Its operator
normalization conservatively rechecks operands, retaining declared dispatch; the
main binary-operand fast path is not silently carried across that migration.
The regenerated 92-proof corpus passes direct Lean kernel checking.

The token-cache-only full suite and specialized verifier were explicitly
interrupted as superseded after integrating this change; neither completed.
A new main full suite runs on the current snapshot. The fresh-condition isolated
specialized active-label verifier remains live on the same compiler implementation.
The main interval-basis recheck passes four exact targets and both pointwise/full
restriction proofs; its generated files are unchanged after provenance restoration.
No complete specialized active-label
or full-suite result is claimed. A finite 60-second profile reached the specialized
equivalence at 10.78 seconds versus 16.29 in an earlier concurrent run, but neither
finished it; this is diagnostic evidence only, not a controlled speedup claim.
:::
