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
