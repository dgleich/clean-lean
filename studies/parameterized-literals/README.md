:::llm gpt-6 2026-11-10 role=assisted

# Parameterized zero design

This directory preserves design experiments. Explicit annotated literals are now
implemented, with [standard vector/matrix zeros](../../docs/standard-zeros.md).
Unannotated inference remains outside production. The new Clean-signature adapter
below is experimental, not a replacement production elaborator.
Read the [contract and unresolved inference obligations](../../docs/parameterized-literals.md).

- [Zero.clean.proposed](Zero.clean.proposed) shows exact-zero metadata attached to
  ordinary named vector/matrix constructors. Its historical rejection comments
  predate production annotation support; use the current standard-zero examples.
- [NativeExample.lean](NativeExample.lean) checks the intended native constructor
  shapes and two coordinate-zero proofs. It is handwritten, not generated from
  Clean and not a canonical translation oracle.

Run `lake env lean studies/parameterized-literals/NativeExample.lean` from the
repository root to check the native example. That check passes under the pinned
Lean/Mathlib environment. Parsing, attachment eligibility, inferred vector/matrix
zero, default interaction, binding consumers and canonical target checks remain
pending. Completing annotated zeros alone would not complete the required
ordinary form `x != 0`.
:::


:::llm gpt-6 2026-11-10 role=assisted

## Determined-carrier pattern model

`pattern_model.py` executes the proposed direct-recovery matching phases over a
separate symbolic representation. Run:

```sh
python3 -m unittest discover -s studies/parameterized-literals -p test_pattern_model.py -v
```

Twenty tests pass. They cover vector and rectangular/square matrix shapes,
identity-based naming, computed constraints deferred until recovery, invalid
attachment parameters, ordered dependent typing and incomplete/error propagation.
Callbacks stand for already checked type comparison, expression evaluation and
parameter typing; the tests do not establish those callbacks for real Clean.

This is design evidence for one component. It does not parse `Literal`, generate
Lean, infer unannotated zeros, apply defaults, or check the native wrapper. The
compiler imports none of this code. The full extension remains unimplemented.
:::


:::llm gpt-6 2026-11-10 role=assisted

## Joint constraints and simultaneous defaults

`constraint_model.py` explores a finite declaration-row solver with structural
unification and simultaneous defaults. Eighteen tests check operand-order
independence, dimension recovery, unresolved competitors, conflicting defaults,
identity ambiguity and incomplete-analysis propagation. Run both design models:

```sh
python3 -m unittest discover -s studies/parameterized-literals -p 'test_*model.py' -v
```

All 38 tests pass. The model takes already constructed symbolic rows; it does not
extract rows from Clean types, check dependent proof arguments, parse literal
metadata, or emit Lean. It is evidence for the proposed policy, not an implemented
inference feature. See the [detailed policy](../../docs/parameterized-literals.md#executable-joint-constraint-experiment).
:::


:::llm gpt-6 2026-11-11 role=assisted

## Rows from actual Clean declarations

[clean_rows.py](clean_rows.py) bridges parsed expressions and actual imported
Clean signatures into the joint constraint model. This closes the earlier gap
where tests supplied all symbolic equations by hand. It does not change the
production parser, numeral completion or operator selector.

The adapter handles the experimental fragment of ordinary literals, declared
operators, prefixes and named calls, with already-checkable subexpressions and
Type-0 nominal carrier patterns. For example, both `x != 0` and `0 != x`, with
x a complex n-vector, select the imported complex-vector-zero declaration and
recover the same caller dimension n. `A = 0`, for a real m-by-n matrix, recovers
both dimensions in order. No vector, matrix or constructor display name chooses
mathematical meaning; declarations supply carrier and callable identities.

### Construction and selection

1. Parse with the production expression grammar; do not use typing to select a
   parse. Before enumerating declarations, visit already-checkable subexpressions
   in source order and collect their checked carrier/index representatives. Visit
   an explicit expected type afterward. Candidate enumeration cannot choose the
   emitted spelling of a caller index by being visited first.
2. Each declaration occurrence gets fresh type or value metavariables identified
   by source path, declaration binding and formal name. Known carrier heads use
   their native declaration identities. Caller dimensions are rigid comparison
   keys, not natural numbers to enumerate. Unsupported computed formal indices,
   proof/derived carrier constraints, higher classifier levels or binder regions
   raise Incomplete. They are not discarded as refuted competing declarations.
3. Every unannotated numeral contributes all visible closed Numerals declarations
   and matching exact Literal declarations. A literal row retains every constructor
   parameter needed by its eventual native invocation, even if unresolved.
4. Combine child rows with every applicable syntactic callable candidate. Equate
   formal input types with child types and explicit formal values with available
   child values. Add a root expected-type equation when supplied. Preserve all
   rows until the structural solver and simultaneous default rule account for
   them. The finite row bound reports Incomplete rather than accepting an early
   successful row. Arbitrary semantic exceptions are not treated as mismatches.
5. After selecting a full assignment, audit operator subtrees under those fixed
   literal choices and carrier assignments, without parent result constraints.
   An expected result cannot break a tie between operators accepting the same
   inputs. Unresolved input applicability remains incomplete. This retains the
   production operator policy instead of adding return-type overload selection.

The materializer recovers the selected row's bindings, builds
retained BoundLiteral/BoundNumeral nodes with explicit declaration identities,
ordered actuals and checked carrier annotations, then runs the existing elaborator.
It checks that every emitted callable agrees with the selected row. Carrier/type
representatives come from the fixed caller context, not a new lookup by printed
mathematical name. The source parse stays unchanged; only the checked internal
representation binds literal meaning.

A useful negative example is `0*x = x`: with the currently imported operations,
scalar multiplication and matrix application can both interpret that zero. The
model reports ambiguity instead of preferring the scalar meaning. Two distinct
zero constructors also remain ambiguous despite identical native bodies.

### Checks and limitations

Run from the repository root:

```sh
PYTHONPATH=. python3 -m unittest discover -s studies/parameterized-literals -p 'test_*.py' -v
python3 studies/parameterized-literals/check_clean_rows.py
```

The 56 design/adapter tests pass: the existing 38 symbolic tests plus 18 tests
using actual Clean declarations. The new checks cover operand order, rectangular
recovery, renamed carriers, default restrictions, unresolved families, candidate
order, row exhaustion, unsupported competitors, operator input ambiguity and
retained parameter identity.

[JointTargets.lean](JointTargets.lean) is generated by the native checker. Five
independently authored canonical targets and five meaning proofs pass: two vector
inequalities, two matrix equalities and Real addition of zero. The initial Real
proof incorrectly expected a declared Nat-to-Real numeral constructor to reduce
all the way to Real zero by definitional equality. Unfolding the declared wrappers
and using simplification fixes that proof; the exact-target comparator and all
expected targets are unchanged.

The following still block production integration:

- Binder bodies, dependent function/application/projection constraints, computed
  formal indices and evidence arguments need constructive row-generation rules.
- Formal classifier resolution currently reads signature source in the fixed
  environment. Retained declaration-bound telescope metadata needs a complete
  audit before this can support all alias/shadowing cases.
- Default origins now survive materialization for the supported fragment, as
  specified below. General dependent-default interactions remain unimplemented.
- Known non-local values may supply types while their value equations remain
  deferred. Recovering a parameter without a checked representative is incomplete.
- Checking one selected row through the old elaborator does not prove that every
  symbolic candidate corresponds to a fully valid dependent application. Production
  selection needs that correspondence or exhaustive checked candidate validation
  before discarding or committing to interpretations.
- Native import isolation, universes, all existing expression consumers and full
  production regression are still separate acceptance obligations.

The original similarity and BibTeX examples still fail production unannotated
vector-zero inference. No source rewrite or switch to this adapter conceals that.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Retaining default origins

`select_with_trace` now returns an immutable selection containing declaration
choices, resolved arguments, the ordered default-restricted literal positions,
and the default carrier when a restriction was used. The existing `select` API
returns the choices/arguments view of that same computation. It does not run a
second heuristic or infer origins after selection.

Restrictions are still calculated simultaneously from the complete pre-default
solution set. A uniquely determined carrier does not acquire a default marker
merely because a default is visible. Conflicting restrictions, unresolved
competitors and duplicate constructors retain their existing error behavior.
No trace is returned until selection has succeeded uniquely.

The adapter maps the recorded position ordinals to the original Decimal paths.
Its materializer writes `defaulted` at exactly those retained numeral/literal
nodes; other newly resolved holes are `inferred`. Explicitly annotated literals
were never holes and retain their existing explicit form. The saved constructor
identity and arguments determine the native term, while the origin determines
whether the mathematical rendering displays the chosen carrier.

Examples with the standard Natural default:

| Source | Retained origin |
|---|---|
| `0` | defaulted Natural |
| `0 = 0` | both positions defaulted Natural |
| `r + 0`, r Real | inferred Real |
| `0` with expected Real | inferred Real |
| `0 = (0: Natural)` | inferred left operand; explicit right operand |
| `x != 0`, x a complex vector | inferred vector zero |

The experimental materializer accepts defaults by default. Passing
`use_default=False` deliberately retains the previous unresolved-family check.
A round-trip test changes the visible default to Real after saving a defaulted
Natural numeral; replay preserves its Natural constructor, origin and rendering.
A competing exact Natural-zero constructor is still ambiguous with the Natural
Numerals constructor: a default supplies no constructor-priority rule.

All 65 design/adapter tests pass. The native checker now compares seven exact
targets and proves seven meaning statements, adding standalone Natural zero and
its reflexive equality to the earlier five examples. This verifies the retained
terms for these specimens, not production integration or the unresolved
candidate-validity and dependent-constraint obligations listed above.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Declaration-time callable signatures

The compiler now retains the checked parameter types, their visibility and
classifier identities, and the result type when a notation, definition, condition
or structure constructor is declared. This is internal metadata, not new syntax.
The experimental joint-literal adapter consumes it; production call elaboration
and retained-literal serialization are unchanged.

For each typed Let group, resolve its type in the preceding scope exactly once,
then bind every name in the group to that checked type. Capture parameters in
scope insertion order. In notation declarations, header parameters are explicit
and preceding non-header parameters implicit; generated constructors make all
parameters explicit. A classifier descriptor is the existing resolved native
classifier identity and universe level, or absent for a value parameter. The
result is the already checked Returns type (or constructed structure type).

For example, with a declared Type-0 classifier Small, `Let Small,T: Small`
binds both names as types. Separate `Let Small: Small` and `Let T: Small`
bind a type and then a value of that type. Re-reading the grouped declaration
as successive independent type strings is incorrect. The corresponding Lean
binder shapes are `(Small T : Type)` and `(Small : Type) (T : Small)`;
these are explanatory expansions, not the actual named wrapper targets.

Consumers require the captured descriptor and validate its source signature,
native binding/template/declaration and classifier metadata. Missing or changed
metadata is an error (incomplete analysis in the experimental adapter), never a
request to reinterpret source text. This does not deeply freeze retained type
graphs or support arbitrary environment mutation: declarations remain fixed
during checking. The descriptor is not a persistence or security boundary.

There is no new parse choice or Lean target choice: capture records the output
of the existing declaration rules, and row variables use its native identity,
parameter name and expression path. The experiment still needs general dependent
constraints, candidate validity checking and production integration. Constructor
telescopes can now be inspected uniformly; general constructor row materialization
is not claimed.
:::

:::llm gpt-6 2026-11-11 role=assisted

Validation for checked signatures: 68 experimental design/adapter tests pass;
89 focused signature/classifier/structure/adapter tests pass (these suites
overlap). The seven exact joint targets and seven supporting proofs still pass.
A separate 26-test module/definition run passes after updating an old identity
fixture to the already specified quoted-binder spelling. The original failure
was also reproduced on the earlier b3dc1e9 snapshot.

Full unittest discovery is running on the immutable
`/tmp/clean-checked-signatures-full-eq0dfjs_` snapshot, with output in
`/tmp/clean-checked-signatures-full.log`. That snapshot precedes the identity
fixture repair and final documentation edits; it is not a completed regression
pass. Older bounded-comparison full discovery and active-label native validation
were confirmed live and were not restarted or counted as successes.
:::

:::llm gpt-6 2026-11-11 role=assisted

The working-compiler integration run finished with `Failures: []`: strict parser
regeneration, 501 existing Python integration tests, native target/proof checks,
and the regenerated 92-result proved corpus. The eight new signature tests were
run separately in the focused suite; the integration runner now includes them
for subsequent runs. Log: `/tmp/clean-checked-signatures-integration.log`.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Constructor rows and caller index values

The experimental adapter now accepts nominal structure carriers using their
existing declared native structure identities. Constructor call rows use the
same checked signatures as other callables; there is no constructor-name or
mathematical-type dispatch. For example:

```clean
Structure VectorCell(n: Natural):
  Let entry: Vector(n,Complex)
  Constructor: vector cell
```

With a caller parameter `n: Natural`, the expression `vector cell(n,0)` supplies
the dimension through its first argument. Its second argument selects the declared
complex-vector zero. It materializes to the wrapper call
`@vectorCellConstructor n (@complexVectorZero n)` (native names abbreviated).
`scalar cell(0)` for a record with one Real field similarly selects the Real
numeral constructor. These use existing source grammar; production unannotated
literal inference remains unchanged.

Before row enumeration, known local values and retained scalar numerals are
converted to checked indices. Their comparison keys provide rigid value equations;
their checked indices provide representatives when reconstructing a selected
literal's arguments. Collection follows source order, visiting a known operand's
type before its value, then the expected type after all operands. First occurrence
wins only the source spelling of an already equal index, never its meaning or
constructor. Candidate enumeration cannot add these caller representatives.

For a local definition `k = n`, `vector cell(k,0)` can meet expected type
`VectorCell(n)` and still emit `k` as the zero constructor argument. Expected
`VectorCell(m)` with unrelated m is rejected. Constructor order does not alter
the selected spelling. A dimension supplied by an unresolved literal, general
computed argument or projected argument still needs more work: this is not a
complete dependent-application solver. Unsupported candidate constraints must
remain incomplete rather than be dropped. The existing selected-row recheck
still does not establish that every candidate was valid before selection.

The native checker now contains nine exact target comparisons and nine supporting
proofs, including the Real and dimensioned-vector constructor calls and their
entry projections. These are constructor/literal specimens, not paper theorems.
:::

:::llm gpt-6 2026-11-11 role=assisted

Constructor-row validation: 73 experimental tests pass; nine exact native targets
and nine supporting proofs pass (`/tmp/clean-constructor-rows-native.log`). The
first scalar-entry proof attempt used `rfl`, which did not discharge the declared
Real numeral conversion. Explicit simplification of the constructor and numeral
wrapper proves the same statement; the independent canonical target was unchanged.
This step changes only the experimental adapter and its documentation/checks.
Production integration evidence remains the preceding checked-signature run;
the still-running full discovery jobs are not counted as passes.
:::
