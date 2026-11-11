:::llm gpt-6 2026-11-11 role=assisted

# Broader validation and remaining example failures

The selected integration checks do not cover all production tests. Full discovery
on immutable commit 403ef42 remains pending at the active-label module. A separate
supplementary run on the same checkout selects all 96 other top-level test modules,
excluding only `test_active_labels` and `test_review`. Those two remain in the live
complete-discovery run; they are not declared passed, waived or removed. The
supplementary run completed: 1,054 tests in 390.099 seconds, with 17 failures and
19 errors (exit 1). There is
no passing full-regression result.

Reproduce the supplementary run from that checkout with the pinned Python/parser
and BibTeX dependencies:

```sh
PYTHONPATH=.:tests python - <<'PY'
from pathlib import Path
import subprocess, sys
names = [p.stem for p in sorted(Path('tests').glob('test_*.py'))
         if p.stem not in {'test_active_labels', 'test_review'}]
raise SystemExit(subprocess.run(
    [sys.executable, '-m', 'unittest', *names, '-v']).returncode)
PY
```

The original log is `/tmp/clean-supplementary-discovery.log`. This is an additional
same-process test run, not a replacement for full discovery or native target checks.
The immutable checkout is not edited when a failure is repaired in the working tree.

## Repaired compatibility fixtures

- `test_binding_identity` imported a historical pre-classifier `.proposed` module.
  Its local carrier named Real therefore was not a declared carrier, invalidating
  the test setup. The production test now imports a current explicit fixture with
  a classified Type, a module alias and the authored real identity function.
  Local/module collision and wrong-carrier rejection assertions are unchanged.
  Historical study inputs are unchanged.
- The projected-condition naming test concluded `P = P` for a higher-universe
  InterlevelProblem without declaring an applicable equality. Its fixture now
  explicitly declares that specialized equality. The same conclusion, projected
  assumptions, collision checks and independent expected naming trees remain.
- The dimension-index representation test expected the pre-codec bare JSON array.
  Its independent expected data now includes the specified version-4 envelope;
  it still checks the exact Local/m tree and existing name, target and comparison.

All 25 tests in those three modules pass together after the repairs. The failing
immutable supplementary run is not retroactively described as passing.

## Real language/library gap retained

`examples/similarity.clean` and `examples/bibtex.clean` use `x ≠ 0` and `y ≠ 0`
for complex vectors. The current standard linear-algebra module does not declare
a vector-zero literal, and unannotated numeral completion enumerates closed scalar
numeral carriers, not parameterized exact-literal constructors inferred jointly
with operators. These examples fail with `No consistent numeral interpretation`.
The BibTeX parser itself is not the cause of its checked-in specimen failure.
Many basic theorem tests consequently fail before reaching their intended checks;
remaining independent failures must be reviewed after this gap is addressed.

The specimens remain unchanged. Rewriting them to a different expression would
conceal the missing authored form. Next work must provide an explicit module-owned
vector-zero construction and specify deterministic joint operator/literal
elaboration, with independently expected targets, competing-constructor and
operator ambiguity tests, scope tests, and resource-exhaustion reporting. No
vector-name dispatch, implicit registry, first-success choice, or native Lean
inference may fill this gap. Annotated exact literals are already implemented but
do not by themselves make the unannotated examples work.

## Retired processes

After checking their live commands and working directories, the unified integration,
schema-4, fresh-index and stable-operator discovery runs and the old cache-omission
diagnostic were explicitly terminated as superseded. All five enclosing sessions
returned 143. Their incomplete logs/checkouts remain; none is a pass or evidence of
divergence. The actual-index baseline, current classified-parameter discovery,
earlier direct active-label verifier were retained. The supplementary run was
allowed to finish and returned its failing summary.
This updates earlier documents that described the retired runs as live.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Native result-name failure

A native check of the repaired projected-condition fixture exposed a separate
compiler defect. `Result example` is accepted Clean, but emission writes
`def example : Prop :=`; Lean rejects the reserved word as an unescaped identifier.
The generated fixture fails before its attempted reflexivity proof. This is not a
successful proof or a defect in the specialized equality declaration. Its log is
`/tmp/clean-projection-fixture.log` and the generated source is
`/tmp/clean-projection-fixture.lean`.

The repair must specify deterministic Lean identifier escaping, preserve the
normalized declaration name and all references, and add native keyword/collision
cases. Renaming the accepted fixture would conceal the defect. Audit other
user-derived native identifiers as part of that repair. This is an actual violation
of the accepted-input-to-Lean-target requirement, not an optional presentation change.

The 36 unsuccessful tests in the immutable run comprise four type-identity failures,
one stored-dimension representation failure, one projected-condition error, and
30 errors/failures in the basic Clean/BibTeX suites. The first six are addressed by
the three fixture migrations, validated in the separate 25-test run. The remaining
basic suites and the newly discovered native keyword failure remain unresolved.
The original 1,054-test result stays failed; complete discovery still includes the
two pending heavy modules and has no final result.
:::

:::llm gpt-6 2026-11-11 role=assisted

The [result-title escaping repair](result-identifiers.md) now makes the original
projected-condition native specimen compile and its reflexivity proof pass.
All normalized result identifiers are quoted without renaming. A separate native
probe confirms that keyword local-object names still require binder/reference
repair. The vector-zero inference failure is unchanged; the historical failing
supplementary summary above is not relabelled as passing.
:::

:::llm gpt-6 2026-11-11 role=assisted

The [binder/reference quoting repair](binder-identifiers.md) now covers the
keyword local-object defect, declaration parameters, local definitions and their
references. Nine independent native targets and five supporting proofs pass;
475 integration tests and a further 69 binding/module/universe tests pass.
These scoped results do not replace the failed historical broad run or establish
full regression success. Vector-zero inference remains open.
:::
