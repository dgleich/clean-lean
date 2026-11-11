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

[clean_rows.py](../../cleanlang/joint_inference/clean_rows.py) bridges parsed expressions and actual imported
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

:::llm gpt-6 2026-11-11 role=assisted

## Literal-valued dimensions

The constructor experiment now also handles `vector cell(2,0)` and
`vector cell((2:Natural),0)`. The constructor fixes the first carrier to Natural;
the second argument selects the complex-vector zero at that checked numeral
index. Neither inference requires a default. Both generate the same canonical
native wrapper application:

```lean
@vectorCellConstructor (naturalNumeral 2)
  (@complexVectorZero (naturalNumeral 2))
```

Native names above are abbreviated. This is a statement about selected term
structure, not a rewrite that replaces the declared numeral wrapper by Lean's
literal 2. The independent native expectations retain both wrapper applications.

Each scalar numeral row now uses the existing checked index-comparison key for
its value equation, just as known caller indices do. No candidate adds a source
representative during enumeration. After unique selection, the materializer
visits selected scalar numeral holes in source order and adds their checked
indices after caller/expected-type representatives. Only a missing representative
is filled; an existing equivalent caller spelling remains preferred. Each stored
numeral retains its selected constructor and inferred/defaulted origin. Exact
literal attachments still require solved arguments; this does not invent a
value equation for an arbitrary dependent call.

Explicit numeral annotations are known checked values and now supply index
representatives as well. A changed visible default cannot reinterpret saved
arguments. A conflicting expected dimension (for example VectorCell(3)) is
rejected. General computed arguments, binder/evidence constraints and exhaustive
candidate validity remain open. This supersedes the earlier limitation for
scalar-numeral dimensions only, not the general dependent-application limitation.
:::

:::llm gpt-6 2026-11-11 role=assisted

Literal-dimension validation: 79 experimental tests pass. Eleven independent
exact native targets and eleven supporting proofs pass, including the raw and
annotated dimension forms (`/tmp/clean-literal-dimension-native.log`). Codec
replay after changing the visible numeral default to Real preserves the selected
Natural argument. Production sources are unchanged in this step; running full
discovery jobs remain separate, incomplete evidence.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Checked computed arguments

A hole-free caller subtree is now elaborated once, then converted by the existing
checked index machinery to its semantic comparison key and retained source
representative. It supplies a rigid value equation, including when the subtree
is a declared call, operator application or record projection. This extends
caller evidence beyond locals and numerals; it does not normalize arbitrary Lean
arithmetic or invert functions.

With the same VectorCell declaration, these expressions work in the experiment:

```clean
vector cell(successor(n),0)
vector cell(D.size,0)
vector cell(n+n,0)
```

The generated zero call receives respectively the retained successor wrapper,
Dimension field projection, or natural-addition wrapper. Explicit expected types
compare these checked indices under existing Clean conversion rules. Distinct
rigid expressions, such as successor(n) and successor(m) for unrelated locals,
are not silently identified. Reordering declarations does not change the target.

Known subtrees are visited in source order before any candidate rows. Their types
are recorded before their values, preserving the established representative
priority. A missing checked index is now incomplete analysis rather than an
unconstrained stand-in for an already known value. Failure to represent a checked
index is also incomplete, so binder/proof limitations are not converted into a
successful inference.

`vector cell(successor(2),0)` remains unresolved: the nested call contains a hole
and is not yet a checked caller subtree. A deferred call-constraint evaluator is
needed to check such applications after their input choices are resolved.
Computed formal declaration indices and exhaustive dependent candidate validity
also remain open. These are substantive obligations before production integration.
:::

:::llm gpt-6 2026-11-11 role=assisted

Checked-computed-argument validation: 85 experimental tests pass, with fourteen
independent exact native targets and fourteen supporting proofs
(`/tmp/clean-computed-dimension-native.log`). The new native checks cover a call,
a projection and an operator as dimensions. A negative test retains the unresolved
status of successor(2) while its literal is still a hole. This changes only the
study adapter, tests and documentation; full production validation jobs remain
separate and incomplete.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Forward deferred constraint model

The symbolic Row model now admits ordered deferred obligations, each with an
output term, input terms and a deterministic forward checker. The checker is
called only with ground inputs. It returns a ground term representing a checked
result, raises NoSolution for a conclusively established mismatch, or raises
Incomplete when the check is unavailable. It must be pure under the fixed
environment and enforce its own checking budget; the symbolic scheduler cannot
bound arbitrary callback computation. This Python callback API is an experimental
model boundary, not Clean syntax, native code, or evidence that the checker itself
is sound.

Saturation first unifies ordinary equations. It then resolves inputs and batches
all ready obligations. Every successful result adds an output equality; these
are unified before the next batch. Completed obligations are removed. No inverse
rule is applied: an equation f(x)=y does not determine x, even when y is known.
A chain of ready computations can determine subsequent dependent indices.

A batch with incomplete checking remains incomplete even if another independent
check rejects it; that conservative priority avoids ordering-dependent results.
A conclusive mismatch with no incomplete check rejects the row. A non-ground or
missing callback result is incomplete. If no remaining obligation is ready,
analysis is incomplete rather than successful or an empty set of solutions.
The scheduler counts obligation visits, including waiting obligations, against
the supplied limit; the existing unification limit applies to each unification
phase. This is not a total runtime budget for the combined solver.

Every row must finish deferred checking before the existing simultaneous-default
analysis runs. A default cannot establish the applicability of a still-unchecked
candidate. Ground checks may remove invalid rows before defaults, so rejected
rows cannot create artificial default restrictions. Distinct valid declaration
rows remain distinct interpretations even when their results agree.

The adapter does not yet emit these obligations. Its call-value placeholders must
be connected to checked argument reconstruction and retained native identities;
all candidate rows need sound checks before selection. Consequently
`vector cell(successor(2),0)` still reports unresolved inference. This commit is
the tested constraint-model prerequisite, not a claim that nested Clean calls or
production inference are implemented.
:::

:::llm gpt-6 2026-11-11 role=assisted

Deferred-model validation: 97 combined experimental tests pass, including twelve
new forward-scheduler tests. The unchanged fourteen native target checks and
fourteen supporting proofs also pass (`/tmp/clean-deferred-model-native.log`).
Those native checks still exercise the adapter without deferred obligations;
they are not evidence for the future Clean-call reconstruction. Production code
is unchanged and full discovery remains outstanding.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Deferred calls in the Clean adapter

The adapter now emits forward obligations for a declared call when every chosen
child has a concrete retained syntax tree. Known caller subtrees and selected
scalar-numeral candidates supply such trees. A nested call combines those trees
using an explicit ModuleCall identity, retaining operator presentation where
applicable. A local with the same name cannot redirect the call.

An obligation waits for its explicit value terms and implicit parameter terms to
be ground. It rechecks the concrete module call through the existing elaborator,
compares checked explicit values and inferred implicit arguments with the solved
terms, and returns the checked result's index-comparison key. Unsupported checking
is incomplete; it is not silently treated as a mismatching candidate. A conclusively
different checked argument is a mismatch. Child obligations precede parent
obligations through these input dependencies, without relying on enumeration order.

For example, these now work without numeral defaults:

```clean
vector cell(successor(2),0)
vector cell(successor(successor(2)),0)
vector cell(n+1,0)
```

Their zero-vector argument receives respectively the checked successor call,
nested successor call, or declared natural-addition call. None requires inverting
those functions. Independent native oracles retain the declared numeral and
callable wrappers, not merely a definitionally equal Lean arithmetic expression.

Each row carries its own reconstruction witnesses; evaluating candidates does
not insert representatives into the caller pool. After selection, scalar-hole
representatives are recorded in source order, then computed-call representatives
in child-before-parent order. Existing equivalent caller/expected-type
representatives retain priority. A witness is rechecked before retention and its
index must agree with the solved output. The witness stores the correspondence
between its concrete numeral positions and original hole positions, so retained
copies preserve simultaneous-default origin markers. The final expression is
still rechecked and its callable choices compared with the selected row.

The operator applicability audit also saturates deferred obligations without
parent result constraints. Expected results must still not select between two
operators with the same valid input signature.

Remaining boundary: exact parameterized literals do not yet supply concrete child
trees until their arguments are reconstructed. Calls consuming such literals
therefore may still have unresolved value variables, and not every dependent
candidate has an applicability obligation. Computed formal indices, general
binders/evidence, hole-bearing projections/applications and production integration
remain open. A test preserves unresolved inference for
`vector cell(length of vector(0),0)` rather than guessing the inner dimension.

A separate probe exposed an existing production restriction: a Natural dimension
formed with unary negation is rejected even if a module supplies a Natural-valued
prefix interpretation. This experiment does not repair that restriction or claim
all declared operator/index combinations are accepted.
:::

:::llm gpt-6 2026-11-11 role=assisted

Deferred-adapter validation: 106 experimental tests pass; seventeen independent
native target comparisons and seventeen supporting proofs pass
(`/tmp/clean-deferred-calls-final-native.log`). New native cases include
successor(2), nested successor calls and n+1 as dimensions. Python checks cover
module binding under local shadowing, conflicting expected indices, codec replay,
and preservation of a defaulted numeral when count(0) is copied into a dependent
zero-vector index. That count(0) acceptance was later superseded by the
[demanded-value check](#demanded-candidate-values-before-selection); count(1) now
covers origin retention, and count(0) has an explicit incomplete regression.
The production compiler is unchanged in this step. Existing
full discovery/active-label processes were confirmed live, not restarted or
counted as successes.
:::

:::llm gpt-6 2026-11-11 role=assisted

The previously reported production veto on Natural-valued prefix dimensions is
now repaired: [dimension checking follows declared prefix meanings](../../docs/dimension-indices.md#module-declared-prefix-values-in-dimensions).
The original `vector cell(-2,0)` probe passes when an explicit Natural-valued
prefix declaration is present. This does not add such a declaration to standard
imports or change the other deferred-inference limitations. The experimental
suite now has 107 passing tests.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Projections from literal-bearing records

The experimental adapter now traverses Projection nodes containing literal holes.
For each base candidate with a known nominal structure identity, it looks up the
field in that structure's checked declaration and substitutes the structure's
symbolic parameters into the checked field type. It does not infer a structural
record type from a field name. A concrete non-record carrier or missing field is
a mismatch; an unresolved carrier remains incomplete.

These examples now materialize without defaults:

```clean
dimension(2).size
vector cell(dimension(2).size,0)
vector cell(2,0).entry
```

Here Dimension has a Natural field named size; VectorCell(n) has an entry field
of type Vector(n,Complex). The existing production projection reducer turns the
first expression into the declared Natural numeral and the last into the declared
complex-vector zero application. The independent native expectations therefore
contain those reduced terms, not a projection artificially preserved in Lean.

If the chosen base has concrete retained syntax, a forward obligation rechecks
the projection and compares its checked result type with the substituted field
type before exposing its checked value index. Literal-origin paths are shifted
through the projection node and selected witnesses follow the same retention
rules as call witnesses. A base that still lacks concrete syntax remains subject
to the earlier selected-expression recheck and general candidate-validity gap.

The source traversal, operator applicability audit, literal reconstruction and
final callable verification all traverse projection bases. Since checking a
projection may reduce away its base, callable verification explicitly rechecks
the original reconstructed base and verifies its choices. Field selection cannot
disambiguate operators with the same valid input signature: a regression constructs
two such operators returning different nominal records and confirms rejection
even when only one record has the requested field.

This slice requires representable nominal carriers/parameters and field types
that depend only on structure parameters. Types depending on preceding field
values remain explicitly incomplete, as does an unresolved nominal carrier.
For example `payload(2,0).data` for a record whose data type is indexed by its
size field is not claimed supported. General dependent projection constraints,
applications, binder/evidence handling and production integration remain open.

Validation: 115 experimental tests pass, with twenty independent exact native
targets and twenty supporting proofs (`/tmp/clean-projection-rows-native.log`).
The latest Python run additionally includes the field-selection/operator-tie
regression. Production sources are unchanged by this step.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Constructor field evidence for dependent projections

Direct nominal constructor fragments now retain their field arguments in declared
field order, after the structure parameters. This evidence is attached only when
the chosen callable is that structure's declared constructor; a function returning
the same carrier does not acquire constructor evidence from its name or native
body. Each field retains its fragment, including symbolic value and nested
constructor evidence.

For a projected field, start with structure-parameter substitution, then supply
only the preceding field values actually referenced by its checked type. Missing
field evidence remains incomplete. A direct constructor projection has the same
symbolic value as its selected field argument, following the existing checked
constructor-reduction rule. Projecting a record-valued argument carries its own
constructor evidence forward, enabling nested projections.

For example, with a record declared as:

```clean
Structure Payload():
  Let size: Natural
  Let data: Vector(size,Complex)
  Constructor: payload
```

`payload(2,0).data` determines the vector index from the size argument, without a
default. `vector cell(payload(2,0).size,0)` and
`box(payload(2,0)).value.data` also work for the corresponding declared constructors.
Native output uses the existing projection reduction, retaining the selected
numeral and vector-zero wrappers. A caller local also named size cannot supply
or override this field evidence.

When a concrete projection witness exists, its deferred type check receives both
structure parameters and required field values. Otherwise the existing final
reconstruction/checking path still applies; this does not close the general
candidate-validity gap. Opaque producers remain incomplete for these dependent
fields, even when their native bodies happen to call the constructor. Computed
formal index expressions, general dependent applications and production integration
remain open. This extends direct references to previous fields; it does not claim
all possible field-dependent types are representable by the symbolic adapter.
:::

:::llm gpt-6 2026-11-11 role=assisted

Constructor-field validation: 120 experimental tests pass, with twenty-four
independent exact native targets and twenty-four supporting proofs
(`/tmp/clean-constructor-field-values-native.log`). New native cases cover literal
and caller-variable sizes, a projected size used in another constructor, and nested
record projections. Rejection tests cover conflicting expected sizes and opaque
record producers. Production sources are unchanged in this step; no full-regression
completion claim is added.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Forward evaluation of computed formal indices

The experimental adapter now handles computed indices in checked callable
parameter/result types and in field-dependent projections when the referenced
value parameters have concrete argument syntax in that candidate row. For example:

```clean
Define padded(n: Natural,x: Vector((n+1),Complex)): Vector((n+1),Complex):
  Equals: x
  Render latex: P({n},{x})

Structure PaddedPayload():
  Let size: Natural
  Let data: Vector((size+1),Complex)
  Constructor: padded payload
```

The experimental expressions `padded(2,0)`, `padded(n,0)` and
`padded payload(2,0).data` select the declared vector-zero wrapper at the
checked index `2+1` or `n+1`. The parser and production elaborator have not
changed; this is an extension of the inference study, not production support
for unannotated parameterized literals.

For each computed index occurrence, create a fresh symbolic index variable and
a forward obligation whose inputs are exactly the referenced formal values in
signature order. The candidate row supplies witness functions for concrete
explicit argument syntax, or for preceding constructor fields. Each witness
retains module bindings and literal-origin paths. Ordinary equations and existing
obligations first determine these input values. Then recheck each witness, compare
its checked index with the solved input, substitute the checked expressions into
the retained formal index, and check the substituted index through the existing
index substitution/reification path. Its comparison key is the obligation's
output. No arithmetic inverse, simplification rule, token dispatch or new
mathematical equality is introduced.

Only a conclusive mismatch may reject a candidate. Missing witnesses, classifier
arguments, unsupported checking or unsolved input values remain incomplete; a
result constraint cannot establish their applicability by itself. Computed
formal indices in exact-literal declarations remain unsupported by the literal
row generator, including competitors that cannot safely be discarded. Implicit
parameters without concrete witness evidence, general dependent applications,
and full candidate-validity checking remain open. At this step projection evidence covered only preceding constructor fields;
the constructor-parameter extension below also retains parameter arguments.

Checking witnesses do not add caller representatives or modify the selected
literal assignment. After selection, replay witnesses in the existing child-first
order with the selected default origins, verify their comparison keys again, and
register their checked values for retained argument construction. This preserves
an authored computed index instead of substituting an arbitrary equal expression.
Caller representatives still have priority; unselected candidates do not choose
emitted spellings. Projection checking now consumes the solved field type as an
input rather than attempting a second unsupported symbolic conversion.

The native oracle independently writes the declared Natural-addition, numeral,
vector-zero and padded wrappers, and checks three new exact targets with three
proofs. It does not obtain expected bodies by translating a second Clean spelling.
Tests additionally check expected-type conflicts, argument-type conflicts,
candidate reordering, default-origin copying into an index, codec replay and an
implicit index that must remain incomplete. These checks do not close the general
production-inference acceptance obligations.

Two interactions delimit this step. `padded(count(1),0)`, for a generic count
returning Natural, preserves the default-origin mark on the scalar argument when
copied into the computed index. With `count(0)`, the available parameterized-zero
competitors lack concrete argument syntax and their computed values remain
unresolved; the adapter reports incomplete before applying a default. Also,
`padded(2,x)` with a conflicting known vector dimension can encounter both a
conclusive computed-index mismatch and an unavailable parent-call check. The
existing batch policy gives incomplete analysis precedence; this step does not
silently discard the unavailable check.

Validation: all 130 experimental tests pass, and the native checker passes 27
independent exact targets and 27 supporting proofs. The production compiler is
unchanged by this study step. Its last integration run completed 550 Python tests,
all native integration checks and the 92-proof corpus recheck; full discovery and
active-label verification are still running against that fixed production snapshot.

:::

:::llm gpt-6 2026-11-11 role=assisted

## Constructor parameters in computed projection types

A direct constructor fragment now retains both its parameter fragments and field
fragments, in their declared order. Parameter names come from the nominal record's
checked declaration; only that declaration's designated constructor supplies this
evidence. Parameter arguments precede field arguments in the existing constructor
signature. No native-body inspection or return-type guessing creates evidence.

```clean
Structure PaddedCell(n: Natural):
  Let data: Vector((n+1),Complex)
  Constructor: padded cell

Structure WrappedCell(n: Natural):
  Let cell: PaddedCell(n)
  Constructor: wrapped cell
```

The experimental adapter now checks `padded cell(2,0).data`,
`padded cell(n,0).data`, and
`wrapped cell(2,padded cell(2,0)).cell.data`. In each case the computed field index
comes from the retained constructor argument, even when a caller variable has the
same spelling as the formal parameter.

Projection forms its symbolic parameter substitution from the base's nominal type
as before. Its concrete witness environment combines retained parameter fragments
with preceding-field evidence; overlapping names are rejected. The existing
forward computed-index obligation checks that these witnesses agree with the solved
symbolic inputs before substitution. Projecting a constructor-valued field carries
that selected field's parameter and field evidence forward, rather than borrowing
the enclosing record's parameters. Literal origins follow the same source paths
through witness replay and retained-tree encoding.

This does not add witnesses for opaque producers. This initial step did not
reconstruct constructor evidence for already elaborated inputs; the extension
below addresses direct checked constructors. Missing evidence is
still incomplete, not a mismatch that can remove a competitor. The production
compiler, grammar and existing Lean mapping are unchanged; general dependent
inference and production integration remain open.

Five regressions cover literal/caller parameters, nested projections, opaque
producer rejection and default-origin/codec preservation. Three additional native
oracles explicitly write the Natural-addition and vector-zero wrappers at their
expected indices; the resulting projection reduces to that zero wrapper under
the existing constructor rule.

Validation: 135 experimental tests pass. The native checker passes 30 independent
exact targets and 30 supporting proofs, including the three new projection cases.
Full production discovery and active-label verification remain pending in their
existing fixed-snapshot jobs; this study-only change does not restart them.

:::

:::llm gpt-6 2026-11-11 role=assisted

## Known constructors inside literal-bearing expressions

The adapter now recovers direct-constructor evidence from already checked,
hole-free input expressions. Thus explicitly annotating an inner constructor's
arguments does not by itself erase evidence needed by an outer projection. For a
holder with a Real marker and a Payload field, the expression

```clean
payload holder(0,payload((2:Natural),(0:Vector(2,Complex)))).payload.data
```

infers the outer marker and preserves the known Payload size/data relationship.
The same construction supports computed parameter indices in an explicitly typed
PaddedCell nested inside a holder, and a known generic cell built with
`generic cell(type(Real),(1:Real))`.

First perform the existing source-order prepass: elaborate each hole-free operand,
reserve its caller type/value representatives, then visit the expected type. The
new evidence pass neither adds representatives nor creates literal holes. It
recognizes only a Call or retained ModuleCall naming the nominal record's own
constructor. A same-named local function is not that constructor. Check the
constructor's captured signature, retained identity where present, and argument
arity; re-elaborate its source arguments in the same fixed scope rather than
trusting stored checked-argument caches. Recurse into directly checked constructor
children, storing admissible value parameter/field fragments in declaration order.

Classifier parameters are not converted into value indices. An already checked
child whose type/index is outside the experimental symbolic fragment contributes
no optional constructor evidence. This does not remove the operand or a competing
candidate: its checked root type/value remain in the ordinary row equations. A
later operation needing the absent evidence still reports incomplete. Signature,
identity and argument-rechecking failures are not silently ignored. A proof
parameter consequently need not become a symbolic index merely to keep its
otherwise checked enclosing constructor usable.

Projection uses this evidence under the same forward substitution, witness replay,
and constructor-reduction rules as literal-bearing constructors. No opaque native
or authored producer body is inspected for hidden constructor calls. Missing
implicit evidence, general dependent applications and production integration
remain separate obligations; this extension does not solve them.

Five regressions cover mixed explicit/inferred fields, computed parameters, opaque
producer rejection, classifier parameters and proof parameters. Three additional
independent native oracles check the two vector projections and the generic Real
projection. The first two supporting proofs use constructor reduction; the Real
numeral proof uses its declared conversion and `simp`.

Validation: all 140 experimental tests pass, and the native checker passes 33
independent exact targets and 33 supporting proofs. The production compiler is
unchanged. Full production discovery and active-label verification remain live
in their existing fixed-snapshot jobs, with no completion claim.

:::

:::llm gpt-6 2026-11-11 role=assisted

## Checked ground witness reconstruction

`witness_model.py` separates reconstruction of a checked parameter value from
selection of a declaration/literal interpretation. The adapter now uses this
resolver when materializing the selected row's recovered parameters and target
types. It uses the existing checked representative table as ordered seeds and
reconstructs nominal types from their declared identities and checked arguments.
Every returned value must agree with the solved symbolic term under `Builder.typ`.
This replaces the previous unchecked dictionary lookup/recursive type assembly;
it does not select new interpretations or relax candidate validity.

The model also supports forward reconstruction plans, preparatory to dependent
calls containing parameterized literals. A plan declares a solved output term,
input terms, a pure checked-value builder, and an explicit priority. At this initial step plans were not generated for those calls by the adapter.
The demand-driven extension below now uses them for checked candidate values;
the previously incomplete `count(0)` examples remain unresolved.

The constructive rule is:

1. Copy the solved binding map for this synchronous reconstruction. Resolve seed
   and plan output terms through that map; unresolved outputs are incomplete.
2. Group entries by exact solved symbolic term. Priorities are nonempty tuples of
   natural integers, compared lexicographically. Duplicate priorities within a
   group are incomplete, including when different variables resolve to the same
   term. Dictionary or declaration enumeration order cannot choose a spelling.
3. For a requested term, require it to be ground. Use its least-priority entry.
   A seed supplies its previously checked representation. A plan recursively
   reconstructs its inputs in declared order, then invokes its builder. If no entry
   exists, a nominal Carrier may be assembled from its argument representatives;
   other missing terms are incomplete.
4. Check the result against the exact solved term. An inconsistent witness, cycle,
   missing input, unresolved term or exhausted budget is incomplete. A failed
   preferred plan does not fall through to another representation. A builder's
   `NoSolution` is converted to incomplete reconstruction, not permission to prune
   a competing declaration.
5. Memoize successes only within this resolver and fixed environment. Each request
   consumes one budget visit, even when it finds a memo entry. Python recursion
   exhaustion is separately reported as incomplete. The limit bounds visits, not
   arbitrary callback runtime or initial input size. No cross-row or cross-public
   cache is introduced.

The current adapter assigns seed priorities in the already specified order:
caller representatives from the prepass, selected scalar witnesses in source order,
then selected computed witnesses in their existing order. It does not register
unselected candidates as caller evidence. Nominal assembly uses the retained type
identity, never its mathematical display spelling. These rules preserve existing
Lean output and literal provenance.

Builders, validators and nominal assembly callbacks must operate on checked values
under fixed declarations and scope. This model does not itself prove their Lean
types or implement their checks. The adapter's current seed/assembly integration
uses its existing checked type/index conversion and independently checked native
oracles. Introducing pre-selection literal/call plans still requires a precise
mapping from each candidate's solved parameters to witnesses, a readiness rule,
retained origins, and exhaustive applicability checking before defaults. Those
requirements remain open; they are not discharged by post-selection reconstruction.

Validation: 158 experimental tests pass, including 18 independent witness-model
cases for priority, aliases, nominal assembly, forward plans, sharing, cycles,
validation failure and resource limits. All 33 existing independent native targets
and 33 supporting proofs pass with the resolver used by materialization. This
checks preservation of the current translated slice, not pre-selection plan
integration or production inference.

:::

:::llm gpt-6 2026-11-11 role=assisted

## Demanded candidate values before selection

`candidate_values.py` connects ground witness reconstruction to the experimental
row solver. A parameterized literal can now be checked as an argument of a call
whose value is needed as a type index, before defaults or declaration selection.
For example, with the existing VectorCell constructor and the Clean-authored
function below:

```clean
Define vector count(n: Natural,x: Vector(n,Complex)): Natural:
  Equals: n
  Render latex: len({x})
```

`vector cell(vector count(n,0),0)`, its literal-dimension version with `2`, and a
nested vector count now translate. An additional fixture uses a deliberately
opaque Lean-backed vector extent to verify that reconstructed dimensions retain
that declared call rather than depending on reduction to a scalar numeral.

Each candidate fragment carries value plans for parameterized literals and calls
or projections without concrete argument syntax. A plan identifies its output
symbol, source path and required literal parameters; call plans additionally
require child recovery parameters and their own inferred parameters. Plans are propagated child before parent.
They do not replace the parsed source tree or create an alternative parse.

For each candidate row, first unify its ordinary equations. A conclusive
contradiction rejects that row. Compute demand from resolved subterms of emitted
carrier/parameter/result terms and inputs to existing forward checks. Activate a
value plan when its resolved output occurs in that demand set, add its required
inputs, and repeat to a fixed point. This is a conservative dependency rule, not
a guarantee that every activated plan is minimally necessary. Keep activated
plans in source child-before-parent order, independent of fixed-point visitation.

Each activated plan becomes an ordinary forward obligation. All required inputs
must be ground under the existing saturation rule. Unify those inputs with the
row's original bindings, preserving aliases. Reconstruct its source subtree with
the candidate's selected numeral/literal/call identities, recheck it through the
existing Clean elaborator, and constrain its output to the checked comparison
index. A known source subtree is rechecked as written. A selected operator is
reconstructed as its retained module call with its original presentation.

Literal reconstruction recovers each signature parameter through the checked
resolver and creates the normal retained BoundLiteral with a checked target type.
Its representative order is: caller evidence, candidate scalar numerals in source
order, existing checked computed witnesses, then grounded candidate value plans
in child-before-parent order. Only plans whose output has a solved term may serve
as reconstruction evidence; their inputs still have to be available. None of
these candidate witnesses is registered as a caller representative. Resource
exhaustion, missing evidence and unavailable checking remain incomplete, not
reasons to drop a competing interpretation. No arithmetic inverse is performed.

Operator applicability auditing uses the same demanded checks on input-constrained
rows, without importing the expected result type. A result constraint therefore
cannot choose between two operators with the same valid input signature. After
selection, replay active value plans with the selected default-origin marks,
verify their output keys again, then register their checked representatives in
the existing retention order. The final expression is rechecked as before.

This closes a concrete earlier checking omission and makes one experimental
boundary stricter: `vector cell(count(0),0)` previously reached defaulting despite
an unmaterialized parameterized-zero competitor. It now reports incomplete because
that competitor's demanded call value depends on unresolved literal parameters.
The retained-origin test uses `count(1)`, whose scalar candidates are checkable,
and a separate regression requires `count(0)` to remain incomplete. Likewise,
`vector cell(length of vector(0),0)` reports incomplete demanded checking rather
than reaching the later underdetermined-selection check. These changes do not
alter production behavior: this adapter is still a study.

This is demand-driven value checking, not proof that every dependent candidate is
fully validated. Computed formal indices that need nonconcrete argument witnesses,
computed exact-literal result patterns, general binder/evidence applications,
opaque field evidence and production integration remain open. Undemanded value
plans are not forced merely to manufacture a ground value; the existing symbolic
constraints and selection rules still govern them. No blanket conformance claim
is made from these examples.

Validation: 167 experimental tests pass. Four new independent native oracles cover
caller/scalar/nested calls and an opaque computed index; all 37 exact targets and
37 supporting proofs pass. Regressions also cover expected-index conflicts,
unknown competitors, declaration-order independence, codec replay and an operator
input tie that the expected dimension must not resolve. Production full discovery
and active-label verification remain in their existing fixed-snapshot jobs.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Checking inferred arguments during candidate reconstruction

Reconstructing a call now checks its inferred implicit arguments against the solved
symbolic candidate, not just the call's resulting value index. This distinction
matters when a function's result ignores an implicit type: equal result values do
not establish that the same Lean instantiation was used.

After recursively reconstructing a selected call/operator's arguments, elaborate
its retained module call in the fixed scope. For every implicit parameter in the
captured signature, require a ground solved candidate argument and an entry in the
checked call's inferred arguments. Convert that checked argument to its symbolic
type/index representation and compare it with the candidate's solved term. Missing
or unresolved evidence is incomplete. A checked unequal argument is a conclusive
mismatch. Only then may the enclosing expression use the reconstructed call.

Dynamic call plans include the recovery parameters carried by every child fragment,
as well as their own implicit parameters. Projection plans include the base's
recovery parameters. Deduplication preserves their specified order. This ensures
that nested reconstruction does not start merely because outer literal parameters
are solved while a child's implicit assignment is still unavailable. Existing
checks on static concrete calls and the operator input-ambiguity audit remain.

For example:

```clean
Define shared vector count(x,y):
  Let n: Natural
  Let x,y: Vector(n,Complex)
  Returns: Natural
  Equals: n
```

With a caller vector `x: Vector(n,Complex)`, the experimental expression
`vector cell(shared vector count(x,0),0)` checks the inferred `n` before using the
call as a dimension. Nesting it inside vector count also checks the child's
implicit assignment. Independent native expectations explicitly apply the shared
count wrapper at `n`; they do not obtain that argument from translated output.

Three new regressions cover the known-vector and nested cases and an intentionally
inconsistent internal implicit-type binding. The latter also checks that removing
the binding reports incomplete; a constant result cannot conceal either failure.
All 170 experimental tests pass, and all 39 independent exact native targets and
39 supporting proofs pass. The production compiler is unchanged. General dependent
candidate validity, computed formal-index witness integration and production
inference remain open; full discovery and active-label checks remain in their
existing fixed-snapshot jobs.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Computed indices from reconstructed arguments

The experimental adapter now applies checked formal-index substitution after
reconstructing literal-valued arguments. For example, given an explicitly declared
`vector extent(n,x): Natural`, the following definition can accept
`dependent copy(n,0,0)`:

```clean
Define dependent copy(n: Natural,x: Vector(n,Complex),y: Vector((vector extent(n,x)),Complex)): Vector((vector extent(n,x)),Complex):
  Equals: y
  Render latex: copy({n},{x},{y})
```

Its schematic Lean application is
`dependentCopy n (complexVectorZero n)
  (complexVectorZero (vectorExtent n (complexVectorZero n)))`.
The native oracle uses the actual declared wrapper identities. It does not replace
`vectorExtent` by its implementation, even when that implementation returns `n`.

For a computed index with missing concrete formal evidence, retain an IndexPlan
containing the checked index template, a fresh output variable, and the ordered
formal-name/symbolic-argument pairs. Its inputs seed the same demand fixed point
as other forward checks. Once all inputs are ground, unify them with the original
row bindings, recover checked representatives, reify them in the fixed caller
scope, and invoke checked index substitution. The resulting checked index supplies
an ordinary output equation. No arithmetic inversion or default-based applicability
is introduced. Missing evidence or resource exhaustion remains incomplete analysis.

Representative priority is caller evidence, scalar candidates in source order,
static computed witnesses, computed index plans in dependency order, then value
plans child-before-parent. Each recovered representative must match its solved
symbolic term. Plans cannot invent a value from an unresolved variable or fall
back after a preferred reconstruction fails. Selected replay repeats the checks,
compares each index with its solved output, and preserves literal origins.

A checked nominal record type can provide a parameter without exposing the
producer's body. Thus an opaque producer of `PaddedCell(2)` can support a field
type depending on `2+1`. A field type depending on an unknown preceding field's
value still lacks evidence: that case remains incomplete, even if a same-named
local variable exists. Direct constructor field evidence remains supported.
This refines the earlier opaque-producer limitation; it does not authorize
unfolding arbitrary producers.

Validation: 177 experimental tests pass, including conflicting expected indices,
codec replay, retained default origins and rejection of unavailable field values.
All 43 independent exact Lean targets and 43 supporting proofs pass. Four new
oracles cover caller/scalar dependent calls, a dependent constructor projection,
and opaque-producer parameter recovery with the original projection retained.
There is no grammar or production compiler change. Classifier-dependent computed
indices, computed exact-literal result patterns, general binder/evidence checking,
exhaustive dependent candidate validity and production integration remain open.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Computed result types of exact literals

The experimental literal adapter now converts a declaration's result type with
the same forward index plans as dependent callable signatures. For example:

```clean
Notation shifted(m: Natural): Matrix(m,(m+1),Complex):
  Means: fun _ _ => (0 : Complex)
  Literal: 7
  Render latex: 7
```

This deliberately artificial literal tests declaration-driven interpretation:
under expected type `Matrix(n,(n+1),Complex)`, `7` selects the declared wrapper
at `n`, schematically Lean `shifted n`. No mathematical meaning is attached to
the digit by the adapter. The direct first dimension recovers `m`; the second
is a checked forward substitution, not an equation solved backwards.

For every literal candidate, convert the captured result template recursively:
nominal carrier constructors and direct formals retain their ordinary constraints;
computed indices introduce IndexPlans with stable source-path identities. Keep
those plans in the fragment. A literal value plan requires both its parameters
and its full result carrier to be ground. Enclosing dependent calls inherit that
readiness requirement, so they cannot reconstruct a literal before its computed
result indices have been checked. Candidate reconstruction and selected emission
use the identical path-based result conversion and the solved representatives.
Retained BoundLiteral emission continues to validate the declared application.

A carrier-shape contradiction can now reject an unrelated computed-result literal
without evaluating its index: a matrix literal does not compete with a vector
literal. An unresolved computed-result candidate with no such contradiction still
blocks selection/defaulting as incomplete. Conflicting checked dimensions reject
the candidate; two valid declarations remain ambiguous. The change refines the
older unconditional rejection at result-template conversion, without introducing
arithmetic inversion, body unfolding, or first-success selection.

The regression suite covers direct recovery, conflicting dimensions, missing
parameters, duplicate interpretations, retained codec replay, unrelated carrier
rejection, and use inside a dependent call whose value becomes a record dimension.
The independent native targets cover the direct literal and that nested call.
Validation: all 183 experimental tests, 45 exact native targets and 45 supporting
proofs pass. Provenance checks pass. Production inference, classifier-dependent computed indices and exhaustive
dependent candidate validity remain unfinished. No parsing rule changes.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Checking determined literal applications before selection

The adapter now checks every fully determined exact-literal application after
forward constraint saturation, including literals whose values are not demanded
by a surrounding type index. Previously those applications could first be checked
during selected emission. A surviving alternative must not avoid telescope
checking merely because only its carrier is needed.

For each row, saturate its ordinary equations and forward obligations. For each
literal value plan whose parameters and complete result carrier are ground,
reconstruct and elaborate its retained application in the fixed environment.
This invokes the existing checked parameter telescope and result annotation
validation. If the output value already has a solved index, compare it too.
Unavailability propagates as incomplete analysis, never as a rejected alternative.
Collect outcomes across determined literals: incomplete checking takes precedence
over a definite mismatch, independent of their visitation order. Definite rejected
rows are discarded before defaults. The input-only operator audit performs the
same checks without expected-result constraints. Selection currently repeats
saturation; avoiding this extra work requires a separately validated immutable
checked-row representation.

This does not validate symbolic families universally. Plans whose parameters or
result carrier remain unresolved retain the existing symbolic/default policy;
their validity remains an explicit integration gap. No success here establishes
that production inference is ready. The production translator still enumerates
scalar numeral interpretations and does not invoke the joint solver.

An attempted earlier placement activated every literal plan as an ordinary forward
obligation. That ran some reconstructions before all dependent computed indices
were available and also changed bare-zero default behavior. The attempted run had
15 errors among 183 tests and is not validation evidence. The implemented phase
checks determined applications only after saturation and leaves the unresolved
family policy visible rather than silently claiming those applications checked.

New regressions observe checked literal application before selection and inject
unavailable telescope checks both for a single interpretation and a competing
interpretation. These verify the failure path independently of retained emission. A two-order
batch regression checks that unavailable checking takes precedence over mismatch.
All 187 experimental tests, 45 exact native targets and 45 supporting proofs pass.
The existing full production and active-label jobs remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Checking determined calls and projections before selection

The post-saturation validity phase now covers every reconstruction plan, including
ordinary calls and projections, rather than exact literals alone. Each plan stores
its symbolic result type. When its reconstruction requirements and result type are
ground, elaborate the expression in the fixed scope and compare the checked result
type with that solved type. If its value already has a solved index, compare that
index as well. Call reconstruction still verifies inferred implicit arguments.
Unresolved plans retain the explicitly incomplete universal-validity coverage of
the preceding entry; this is not a claim about every symbolic candidate.

For example, `vector count(n,0)` returns a Natural and need not supply a dimension
to another expression. It now checks the application before selection, with
schematic Lean target `vectorCount n (complexVectorZero n)`. The same mechanism
covers dynamic projections and constructors; static concrete calls already have
forward checking obligations. Expected-result constraints remain excluded from
operator input auditing. No parser or production inference behavior changes.

The negative tests inject unavailable checking of an otherwise undemanded root
call and a checked result type unequal to the symbolic candidate type. A positive
observation checks that root application elaboration occurs before selection.
The native oracle independently spells the standalone vector-count application.
Validation: all 190 experimental tests, 46 exact native targets and 46 supporting
proofs pass. Provenance checks pass. Production full discovery and active-label
verification remain live and pending in their fixed-snapshot jobs.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Computed indices depending on inferred types

The experimental forward substitution rule now supports a computed index whose
formal argument is an inferred Type-0 carrier. For example:

```clean
Notation carrier extent(T: Type): Natural:
  Means: 2
  Render latex: extent({T})

Define typed vector(x,y):
  Let T: Type
  Let x: T
  Let y: Vector((carrier extent(T)),Complex)
  Returns: Vector((carrier extent(T)),Complex)
  Equals: y
  Render latex: vector({x},{y})
```

`typed vector(n,0)` with `n: Natural` has schematic Lean target
`@typedVector Natural n (complexVectorZero (@carrierExtent Natural))`.
The declared extent wrapper is retained instead of replaced by the numeral 2.
The author writes `carrier extent(type(Natural))` when explicitly supplying a
type value in a computed expression; a bare `Natural` there is not a local value.

Telescope conversion records each classifier parameter's captured checked type,
keyed by the symbolic formal variable (source path, native declaration identity,
and parameter name). Forward index reconstruction resolves that variable to a
checked carrier representative and reifies it using this exact classifier before
substitution. It does not select a classifier by spelling or environment order.
Missing classifier evidence is incomplete. Value-sorted formals retain the previous
checked value reconstruction rule. The source template and unique forward output
equation are unchanged.

A second module-declared classifier `Small` can classify the same Lean universe.
The regression requires a signature declared with `Small` to use that classifier
even while the ordinary `Type` classifier is available. Other tests cover inferred
Natural from a caller value, scalar-literal defaulting, retained codec replay and
missing captured classifier evidence. Three independent native expectations spell
the actual implicit carrier and extent wrappers for the ordinary, defaulted and
alternate-classifier examples.

This closes the inferred Type-0 formal case only. General higher universes,
explicit classifier-valued operands in the experimental fragment builder,
classifier-dependent static-evidence paths, and arbitrary dependent classifiers
remain outside this slice. Unresolved symbolic-family validity and production
integration also remain open; no new syntax or production behavior is claimed.

Validation: 195 experimental tests, 49 exact native targets and 49 supporting
proofs pass. Provenance checks pass. Full production discovery and active-label
verification remain pending in their existing fixed-snapshot jobs.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Explicit carrier operands in dependent inference

The experimental adapter accepts checked Type-0 carrier values as operands, both
explicit type expressions and local carrier variables. For example:

```clean
Define explicit vector(T: Type,x: T,y: Vector((carrier extent(T)),Complex)): Vector((carrier extent(T)),Complex):
  Equals: y
  Render latex: vector({T},{x},{y})
```

`explicit vector(type(Real),1,0)` has schematic Lean target
`@explicitVector Real (realNumeral 1)
  (complexVectorZero (@carrierExtent Real))`.
The explicit carrier constrains the scalar literal to Real without defaulting.
If more than one classifier is available, write `type(Real:Type)` or the intended
alternate classifier explicitly. Passing the wrong classifier is a mismatch even
when both classifiers have Lean body `Type`.

The symbolic converter accepts a closed module-declared classifier for Type-0
carriers as an operand type. It still rejects higher classifier levels. For a
checked carrier-valued expression, recover the carrier through the existing
checked carrier conversion; store that carrier's symbolic type term as the operand
value rather than treating it as a value index. Caller representative collection
retains the checked carrier in source order. Ordinary classifier identities remain
part of operand type equations, so this does not equate different classifiers.

Static computed-index witnesses now accept those checked carrier expressions.
They compare the recovered carrier term with the symbolic formal before the same
checked substitution. Dynamic inferred-type substitution still uses the captured
classifier rule from the preceding entry. Direct checked constructors may retain
Type-0 carrier arguments alongside value arguments; projections can therefore
check field types depending on the carrier parameter. No arbitrary producer body
is unfolded and unknown field values remain unavailable.

The regressions cover explicit Real, an alternate classifier, wrong-classifier
rejection, a caller-local carrier T, and a constructor projection with a field of
type `Vector((carrier extent(T)),Complex)`. Native expectations independently spell
both explicit call variants and the projected vector wrapper. General higher
universes, computed carrier types outside the supported nominal/local fragment,
symbolic-family validity and production integration remain open. No syntax change.

Validation: all 200 experimental tests, 52 exact native targets and 52 supporting
proofs pass. Provenance checks pass. The full production and active-label
fixed-snapshot jobs remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Local function calls in joint inference

The experimental adapter now handles unary calls through checked local Function
values. A local `f: Function(Vector(n,Complex),Real)` constrains `f(0)` to the
vector-zero interpretation, with schematic Lean target
`f (complexVectorZero n)`. For a dependent
`f: Function(k: Natural,Vector((k+1),Complex))`, `f(2)` substitutes the checked
Natural argument into the result index. A call returning Natural can also supply
a subsequent index, as in `vector cell(f(0),0)`.

Resolve a Call head by the existing language rule: a same-named local whose type
is Function supplies the callable; a nonfunction local does not shadow a module
callable. For the local branch require one argument. Convert the checked domain
to its symbolic term and equate it with the argument fragment's type. For a
dependent codomain bind its formal to the argument's symbolic value and use the
existing checked forward-index substitution rule; concrete argument evidence is
retained when available. Record the local choice separately from native module
choices, combine child obligations, and create a value reconstruction plan whose
requirements include the argument and result types.

Reconstruction keeps the local Call and recursively reconstructs its argument;
it does not replace the callback with a module declaration. The post-saturation
application checker validates the determined result type and any solved value
index. Selected emission traverses local-call arguments too, so nested native
call choices are still checked. All interpretation occurs under the fixed checked
caller scope; this adds neither a name registry nor native-body dispatch.

Tests cover domain-driven literal recovery, a dependent result, using a callback
result as a record index, local-function shadowing, nonfunction nonshadowing,
wrong-digit rejection and retained codec replay. Three native targets independently
spell the ordinary, dependent and index-producing callback applications.
General Apply expressions, lambda/binder regions, higher-order dependent carrier
results, callable proof views and unresolved symbolic-family validity remain
outside this slice. Production joint inference remains unimplemented.

Validation: all 209 experimental tests, 55 exact native targets and 55 supporting
proofs pass. Nested local calls and nonfunction locals with no module callable
also have regressions. Provenance checks pass. Production full discovery and
active-label verification remain pending in the projection-reuse snapshot.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Function-valued expressions and application

The experimental adapter now handles the existing Apply syntax, including
`q.map(0)` for a function-valued field and `make map(n,0)(0)` for a function
returned by a call. The callee expression is retained; it is not converted to a
new module name. For a checked field `Function(Vector(n,Complex),Real)`, the
schematic Lean term is `(MapHolder.map n q) (complexVectorZero n)`.
A checked dependent field `Function(k: Natural,Vector((k+1),Complex))` uses the
same forward substitution as a local dependent callback.

If the callee contains no literal holes, elaborate it in the fixed caller scope
and use its checked domain/codomain with the shared unary application rule.
Otherwise enumerate callee and argument fragments jointly. A determined nominal
function carrier supplies its two symbolic type arguments as domain/codomain;
equate the argument type with the domain, retain both fragments' constraints and
witnesses, and add an application value plan. A definite nonfunction carrier
rejects that combination; an unresolved head type is incomplete. The existing row
limit applies to the Cartesian product. Inferred dependent-function heads remain
outside this nominal-carrier rule rather than being treated as nondependent.

Application plans require callee/argument recovery parameters and their types.
Reconstruction preserves Apply with reconstructed head and argument. The
post-saturation checker validates determined applications' types and solved values.
The operator-input audit and selected native-choice validation now traverse both
callee and argument. Thus an expected result cannot hide an operator-input tie
inside `make map(n,r+0)(0)`. Caller representatives are collected in source order,
with a known callee checked before its argument.

Tests cover ordinary and dependent function fields, inferred returned functions,
conflicting expected results, retained codec replay and operator ambiguity inside
the callee. Three independent native oracles spell the field projection and
application wrappers. Lambda/quantifier regions, inferred dependent-function
heads, general callable proof views, universal symbolic-family validity and
production joint inference remain open. No grammar change is introduced.

Validation: all 215 experimental tests, 58 exact native targets and 58 supporting
proofs pass. Provenance checks pass. The projection-reuse full discovery and
active-label validation jobs remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Outermost quantifier and lambda inference

The experimental materialization entry point now accepts an outermost binder or
chain of binders. For example:

```clean
for every (k: Natural,
  there exists (z: Vector(k,Complex), z = 0))
```

The body infers the declared vector-zero wrapper at the bound `k`. Its schematic
Lean target is `∀ k : Natural, ∃ z : Vector k Complex, equal z (complexVectorZero k)`.
For `function (k: Natural, 0)` with expected type
`Function(j: Natural,Vector(j,Complex))`, the target is schematically
`fun k => complexVectorZero k`. These are expressions in the existing grammar,
not new statement forms.

Check the source binder freshness and resolve its domain in the earlier caller
scope. Introduce a temporary checked local with a fresh internal identity and run
body inference in the extended scope. A quantifier constrains the body to the
existing foundational Proposition binding and rejects a different expected result.
For a lambda with a supplied function type, check domain equality and use the
expected codomain; a dependent codomain is substituted with the new checked local.
Without an expected function type, infer the lambda body under the existing rules.

After inferring the body, re-elaborate the entire binder tree through the normal
checker. Retained annotations rebind their captured source references to the
compiler's final binder identities. Temporary checking names must not escape into
the emitted Lean expression. Each nested binder consumes one unit of the adapter
limit; exhausted budget or Python recursion is incomplete analysis. Existing
fresh-name restrictions apply, including caller and module name collisions.

This rule covers outer binder chains only. It does not independently solve binder
arguments nested inside arbitrary call/operator inference regions: those still
need a compositional scoped constraint representation. In particular, it does not
claim to propagate unknown outer candidate types into an embedded lambda by
running a separate solver. `solve`/raw row generation still lacks general binder
fragments; this extension is in `materialize`. Production joint inference and
universal symbolic-family validity remain open.

Regressions cover parsed quantifiers, nested bound dimensions, expected lambda
codomains, retained codec replay, domain/result conflicts, name collisions and
resource exhaustion. Native oracles independently spell a universally quantified
condition, a nested existence statement and a dependent lambda. The existence
statement is proved by choosing the zero vector; the universally nonzero condition
has an equivalence check, not a proof of that false condition.

Validation: 224 experimental tests, 61 exact native targets and 61 supporting
proofs pass. Provenance checks pass. The projection-reuse full discovery and
active-label jobs remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Scope admissibility in the symbolic constraint model

Before embedded binder regions can share candidate constraints, a metavariable
must retain which lexical binder identities its solution is allowed to mention.
The independent constraint model now records `allowed_binders` on each Variable
and `free_binders` on rigid Atoms. These are immutable sets of semantic binder
identities, not source spellings. Carrier dependencies are the union of their
arguments' dependencies. Existing unscoped fixtures use empty sets.

At every unification return boundary, inspect every retained substitution. Traverse
its carrier arguments and follow all bound metavariable aliases; each reachable
rigid atom's free binders must be a subset of the substituted variable's allowed
binders. A violation is a conclusive mismatch. Alias equations must remain in the
binding map: an unresolved alias is not permission to forget the outer variable's
scope restriction. Later unification repeats the check and can expose a previously
unknown forbidden dependency. Tracking visited aliases avoids repeated traversal
within one substitution. A shared visit budget bounds the whole scope scan;
exhaustion is incomplete analysis.

For example, an inner dimension metavariable allowed to mention binder k can be
solved by k. An outer dimension metavariable cannot. Equating the outer variable
with the inner one does not bypass this rule: a later assignment of k to the inner
variable rejects the combined solution in either equation order. A closed solution
can satisfy aliases with different allowed binder sets. Forward-check outputs go
through unification and obey the same rule. Sibling binders named k have distinct
semantic identities and cannot be substituted for one another by spelling.

This is model infrastructure, not completed scoped Clean inference. The adapter
still constructs its current atoms/variables with empty metadata; existing outer
binder materialization uses separate checked scopes. Embedded-expression lowering
must attach verified dependencies, introduce binder identities by lexical position,
and explicitly abstract/discharge bound dependencies when forming dependent
function types. None of that is inferred from Lean strings or demonstrated merely
by this model's tests. Universal symbolic-family validity remains a separate gap.

Ten independent tests cover immutable metadata, permitted inner references, forbidden outer capture,
nested carriers, alias orientation and equation order, later unification, sibling
identity, closed alias solutions, deferred output escape and resource exhaustion.
The scope rule is integrated into the experimental unifier only; no production or
grammar change is made.

Validation: all 234 experimental tests pass. The existing 61 exact native targets
and 61 supporting proofs pass with the scope checker; these do not establish
embedded-binder lowering. Provenance checks pass. Full production and active-label
validation remain pending in the projection-reuse snapshot.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Checked binder dependencies in outer inference scopes

Outer binder materialization now passes an explicit source-name to semantic-binder
identity map to its body builder. Identities use the binder's lexical AST path;
a nested body extends that path by its body-child index. Every newly introduced
constraint variable receives the active binder identities as its allowed set.
The builder checks that mapped binder names are present in its checked scope.

Rigid local carrier terms and checked value indices receive free-binder metadata.
For a value index, reify and comparison-normalize the checked expression in the
fixed scope, then collect retained source references. Also traverse its checked
type, inferred implicit arguments and checked explicit arguments: source spelling
alone would miss an implicit type parameter. Nominal type arguments are traversed
structurally; local carrier references contribute their mapped binder identities.
Unknown representations and unsupported type constructors remain incomplete;
a visit budget bounds dependency analysis. No Lean string search identifies a
binder dependency.

The metadata describes the checked comparison value. An authored `ignore(n)` that
normalizes to a closed Natural zero has the same empty dependency set as that zero.
An opaque `opaque count(item)` retains its declared application: if item has a
bound type T, both item and the inferred T are tracked. Distinct lexical binders
remain distinct even if their source names and temporary Lean names coincide.

These dependencies now reach the scope-admissibility check during outer binder
body inference. A dimension extracted from `Vector(n,Complex)` can solve an inner
metavariable that allows n, but cannot solve an outer one with an empty binder set.
Existing final whole-binder elaboration still rebinds retained annotations and
ensures temporary checking names do not escape.

Comparison dependencies are not permission to move an arbitrary source witness
into another scope. Reification must check that witness in the destination scope;
embedded-region integration still needs explicit binder abstraction, dependency
discharge and scoped representative reconstruction. The current outer-prefix
implementation does not share body metavariables across binder boundaries or
claim that general embedded lambda inference is complete.

Regressions cover lexical dimension dependencies, active permissions, rejected
outer capture, removed unused dependencies, same spelling in different scopes,
implicit carrier dependencies, unsupported representations and resource limits.
The added native oracle quantifies over a carrier T and an item of T, retaining
T as an explicit implicit argument to the declared count wrapper.

Validation: all 241 experimental tests, 62 exact native targets and 62 supporting
proofs pass. Provenance checks pass. Full production and active-label validation
remain pending in the projection-reuse snapshot.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Availability of retained representatives across scopes

The ground witness resolver now separates semantic agreement from availability
of the actual retained expression in a requested binder scope. A request through
a metavariable uses that variable's allowed binder set; a ground-term request uses
the resolver's fixed active set. After obtaining the preferred representative,
including a memo hit, require positive Boolean evidence from the availability
checker. False, unavailable/unknown results and failed checking are incomplete
analysis, not a reason to discard a candidate. The established representative
priority still applies: an unavailable preferred source does not fall through to
a different spelling.

The Clean adapter supplies this checker in both pre-selection reconstruction and
selected emission. Collect the retained source's dependencies without comparison
normalization, including checked types and implicit arguments, and require them
to fit the requested binder set. For a value index, also reify the retained source
under the destination locals after removing unavailable binder names. This keeps
source-expression checking distinct from the normalized dependency analysis used
for semantic constraint terms. Scopes with no tracked binders require no extra
scope transition check.

For example, an authored `ignore(n)` may have the same closed comparison value as
Natural zero. Its retained source still mentions n. The checked representative can
be used inside n's scope, but a request from an outer metavariable fails as
incomplete, even after an inner request populated the memo. The resolver does not
silently replace it by a lower-priority numeral-zero representative. An actually
closed source can be shared across the two scopes.

Six independent resolver tests cover closed meaning versus source availability,
memo narrowing, no fallback, closed-source sharing, failure classification and
positive Boolean evidence. A Clean-backed regression constructs the authored
ignore function and checks the same inner/outer requests using real retained
indices. Existing binder examples still pass whole-binder annotation rebinding.
This establishes representative availability checking, not general embedded
binder constraints or dependent-function abstraction. Production joint inference
and universal symbolic-family validity remain open.

Validation: all 248 experimental tests pass; the existing 62 exact native targets
and 62 supporting proofs pass with scope-aware availability checks. Provenance
checks pass. Full production and active-label runs remain pending in the
projection-reuse snapshot.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Checked dependent functions as rigid carriers

The experimental adapter accepts a fully checked Type-0 dependent function type
as a rigid type atom. Its identity is the checked `type_key`, which abstracts the
bound Lean identity and retains free identities. Thus `Function(k: Natural,
Vector(k,Complex))` and the version with binder `j` agree; different free dimensions
remain distinct. A formal occurring free in the type is explicitly incomplete:
this rule does not solve symbolic dependent function templates.

For example, a structure field `q.map` of type `Function(k: Natural,
Vector((k+1),Complex))` can be passed to `consume(f: Function(j: Natural,
Vector((j+1),Complex)), x: Real)` in `consume(q.map,0)`. The argument constrains
zero to Real. The native check independently spells the field projection, selected
consume wrapper, and Real numeral wrapper; alpha-renaming chooses no new target.

Dependency collection opens the codomain with a fresh checked local, recursively
collects dependencies with the same outer binder identities, and includes the
domain dependencies. The opened local is not an outer dependency. Source and
normalized dependency modes remain separate. Freshness avoids source-name capture;
checking failure or budget exhaustion is incomplete. Caller representatives are
captured only during caller conversion, never installed from candidate templates.

Validation: 255 experimental Python tests pass, and the native driver checks
63 independently expected Lean targets with 63 supporting proofs. Production
full discovery and active-label verification are still running; these focused
results do not establish production conformance.

This changes no grammar and remains experimental. Inferred dependent function
heads, embedded lambda constraints, unresolved dependent templates, universal
symbolic-family validity, and production integration remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Applying inferred expressions with fixed dependent signatures

The experimental adapter carries a checked dependent function signature on each
candidate fragment produced by a module call or structure projection. This is
row-local evidence, not a global representative cache. A signature is retained
only when none of the producer's formal parameters occurs free in it; unresolved
producer-dependent signatures remain incomplete.

For `make dependent(0)(2)`, suppose the declared producer takes Real and returns
`Function(k: Natural,Vector(k,Complex))`. The parsed Apply node is unchanged.
For each head/argument candidate pair, the adapter verifies that the retained
signature's rigid type key equals the head type, equates the argument type with
the checked domain, and substitutes the argument's symbolic value into the
codomain. Computed codomain indices use existing forward checks or IndexPlans;
they do not invert arithmetic. Head and argument equations, witnesses and value
plans remain in the same row. Thus the first numeral is Real, the second Natural,
and the result is a complex vector of dimension two.

Reconstruction retains both the producer call and the final application. A
schematic expanded Lean expression is `(makeDependent (0 : Real)) (2 : Nat)`;
the actual target uses the selected explicit module wrappers. The independently
written native checks cover direct dimensions, computed dimensions, and a
function obtained from an inferred structure constructor's field. For that direct
constructor case the existing projection reduction rule selects the supplied
callback, so the exact target is `callback 2`, not an unreduced projection. Wrong domains
and expected results reject; ordering and codec checks preserve selected syntax.

Validation: 262 experimental Python tests pass; the native driver passes 66
exact-target comparisons and 66 supporting proofs. The initial projection oracle
incorrectly expected an unreduced constructor projection; it was corrected to
the existing specified reduction rule. Full production discovery and active-label
verification remain live and are not counted as passes.

This is fixed-signature application, not inference of arbitrary dependent function
templates or embedded lambda bodies. It adds no grammar rule and does not change
production elaboration. Those broader binder constraints, universal symbolic-family
validity, and production integration remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Forward substitution into dependent function signatures

The experimental adapter now represents a dependent function type containing free
producer formals by a TypePlan. Its output is a type variable; its inputs are the
referenced formal variables in declaration order. When inputs are determined,
the resolver supplies their checked representatives using the existing priority
and scope rules. Classifier parameters use their captured classifier. Checked
capture-avoiding type substitution rebuilds the signature, and its alpha-canonical
rigid key constrains the output. TypePlan outputs are rechecked during retention;
candidate templates do not install global caller representatives.

For example, declare `make offset(n: Natural,x: Real)` returning
`Function(k: Natural,Vector((k+n),Complex))`. Then `make offset(n,0)(2)` has result
`Vector(2+n,Complex)` and retains the producer call followed by application.
The producer parameter can also be a reconstructed expression such as
`count real(0)`. A type parameter works through an explicit classifier expression:
`make constant(type(Real:Type),r,0)(2)` returns a real vector when the declared
producer returns `Function(k: Natural,Vector(k,T))`.

An inferred dependent head retains the checked template, formal terms, concrete
argument evidence where available, and its converted carrier as row-local
metadata. Domain conversion uses producer formals; codomain conversion additionally
binds the function's own argument, shadowing only that binder. The head's metadata
must agree with its converted carrier. Both head and argument constraints remain
in the row; computed indices use forward substitution. The same TypePlan rule
checks dependent function parameter types against supplied function arguments.
There is no inverse inference of a producer parameter from an opaque function-type
key. Undetermined inputs remain incomplete.

Candidate checking now uses a fresh compiler mismatch owner after all literal
interpretations have been assigned. Only a SignatureMismatch bearing that owner
rejects the row. A foreign mismatch, unresolved literals, or unavailable checking
remains incomplete. The previous owner is restored on every exit. This prevents a
known type mismatch from being misclassified as unavailable checking when a type
plan and a call check become ready together; it does not turn arbitrary compiler
errors into candidate rejection. The older `padded(2,x)` test now expects a
rejection: its fixed caller dimension is incompatible with the required dimension,
and the compiler certifies that signature mismatch. The earlier incomplete
expectation recorded a missing diagnostic distinction, not an accepted program.

Validation: 272 experimental Python tests pass, including unresolved formal inputs
and trial-owner restoration. The native driver passes 68 independently expected
Lean targets and 68 supporting proofs. Provenance checks pass. Production full
discovery and active-label verification remain live, not passing results.

No grammar or production behavior changes. Embedded lambda constraints, general
inverse dependent-type inference, universal symbolic-family validity, and production
integration remain pending. Paper proofs are separate obligations.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Chained callable signatures

The experimental adapter now carries callable metadata from an application result
into the next application, for both ordinary and dependent function layers.
Metadata consists of the checked template, its formal substitutions, concrete
argument evidence where available, and the converted result carrier. It is local
to the candidate row and must agree with that row's carrier. No selected source
expression is replaced by an independently chosen representative.

For a declared `nested maps(x: Real)` returning
`Function(n: Natural,Function(k: Natural,Vector((n+k),Complex)))`, the expression
`nested maps(0)(2)(3)` retains the three successive applications and has vector
dimension 2+3. A local callback of the corresponding type supports `f(2)(3)`.
More importantly, a family with type
`Function(j: Natural,Function(v: Vector(j,Complex),Function(k: Natural,Vector((j+k),Complex))))`
supports `f(2)(0)(3)`: the middle layer is ordinary in v, yet its domain depends on
j and its result contains another dependent layer. The zero there is constrained
to the declared complex-vector literal of dimension two.

At each Apply node, domain conversion uses the accumulated formal map. A dependent
layer additionally binds its own argument before converting the codomain; an
ordinary layer preserves the map without inventing a binder. The codomain's
callable template and converted carrier become the next row-local descriptor.
All constraints and value/type plans from earlier applications remain in the row.
Checked local application uses the same propagation rule. Source parsing remains
the existing left-associated postfix application grammar; inference never chooses
a different grouping. Retained reconstruction rechecks every application.

Validation: 279 experimental Python tests pass, along with 71 independently
expected Lean targets and 71 supporting proofs. Production full discovery remains
live. The active-label regeneration terminated with status 143 without new
artifacts and is being rerun; neither run is counted as passing.

The tests cover module producers, local callbacks, computed first arguments,
outer-scope dimensions, wrong second arguments, retained serialization, and a
mixed ordinary/dependent chain. Independent native targets spell each application
and every selected numeral/vector wrapper explicitly. This is not embedded lambda
inference, higher-universe generalization, or inverse inference of hidden type
parameters. Those limits and production integration remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Explicit symbolic binder abstraction

The constraint model now has three additional constructors: `Reference(local,sort)`
for an explicit lexical reference, `Bound(level,sort)` for a de Bruijn reference,
and `Binder(constructor,domain,body,sort)`. Bound level zero refers to the nearest
enclosing binder body. A binder does not bind its domain. Constructor identities
and sorts are retained; different constructors or sorts do not unify. These are
symbolic model nodes, not new Clean source syntax.

To close local ℓ in body B, `abstract(ℓ,D,B)` traverses B with depth zero. It
replaces `Reference(ℓ,s)` by `Bound(depth,s)`. Entering a nested binder's domain
preserves depth; entering its body increments depth. Other lexical references and
already bound references are preserved. An existing bound reference must have
level smaller than the traversal depth. Thus closing n around a nested j binder
produces level one for n and level zero for j, while n in j's domain has level zero.
The caller must supply a checked outer-scope domain and immutable lexical identities.

An opaque atom whose dependency metadata mentions ℓ cannot be structurally
abstracted: its text is not parsed or rewritten. Likewise, an unresolved
metavariable permitted to depend on ℓ requires contextual metavariable substitution
and reports incomplete. A metavariable whose permission set excludes ℓ is safe to
retain, since later solutions must remain independent of that local. These are
explicit representation limits, not evidence that the corresponding mathematics
is invalid.

Before equation decomposition, well-scoping validates bound levels. Malformed
input or an unknown node is incomplete. Binder unification decomposes matching
constructors into domain and body equations. Occurs checks and substitution visit
both children. Every metavariable substitution is checked from its own root:
a bound reference cannot escape into a solution merely because the equation arose
inside a binder. Genuine scope escape is a mismatch. Free references in both the
domain and body must be permitted by the variable's outer scope. Structural
resolution now also preserves the sort of Carrier nodes instead of reconstructing
every carrier with the default type sort.

Validation: all 299 experimental tests pass, including 20 new binder cases. The
existing 71 native target comparisons and 71 supporting proofs also pass as
regressions for the unchanged Clean adapter. Full production discovery and the
active-label regeneration retry are confirmed live and remain pending.

This permits closed binder comparison and inference of scope-independent unknowns
under binders. It does not implement contextual metavariables, opening/instantiation,
embedded lambda constraints, or lowering of these new nodes into checked Clean
expressions. In particular, the Clean adapter still uses its checked dependent
type keys and TypePlans; it does not produce these Binder nodes yet. Native
regression checks exercise that existing adapter, not a claimed native mapping
for the new representation. Production integration remains pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Opening and instantiating symbolic binders

`instantiate(Binder(c,D,B,s),a)` performs structural substitution into B. The
binder and argument must be well scoped at their own roots: a may contain free
lexical references and closed nested binders, but no dangling bound reference.
The caller must separately constrain a's type to D; this operation does not
establish domain typing, choose an overload, or infer an implicit parameter.

Traversal starts at depth zero in B. A bound reference at the current depth is
replaced by a, with an exact sort check. References at smaller depths belong to
nested binders and remain unchanged. A larger depth is malformed for a validated
root binder. Nested domains preserve depth and nested bodies increment it.
Because a is well scoped at its own root, it can be inserted under nested binders
without capturing its free references or changing its internally bound references.
The result is checked for well-scoping again. Opaque atoms and scope-independent
metavariables remain unchanged. The operation preserves constructor identities and
sorts. Resource exhaustion, unknown nodes, and malformed representations are
incomplete; an explicit bound-occurrence sort mismatch rejects.

`open_binder(B,ℓ,s)` instantiates B with `Reference(ℓ,s)`, after checking that ℓ
occurs nowhere free in B's domain or body, including atom dependency metadata and
metavariable permission sets. A nonfresh identity is incomplete rather than
silently renamed. This makes reopening deterministic under a caller-selected fresh
identity and supports reabstracting that identity without capturing an outer one.
An unused binder still requires a well-scoped argument; domain typing remains the
caller's obligation even when there are no bound occurrences to check its sort.

Tests independently specify direct substitution, nested domain/body behavior,
insertion of a closed binder, preservation of an outer free reference, mismatched
sorts, malformed arguments, freshness collisions, and resource failures. A bounded
family of 80 terms checks both abstract/instantiate and open/reabstract round trips.
A separate check verifies commutation with a scope-independent metavariable
substitution. These are executable model properties, not universal proofs or
native Clean-to-Lean target checks.

Validation: all 315 experimental Python tests pass. This addition changes only
the standalone model, tests, and documentation; the native adapter checks were
not rerun for unused helper functions. Full production discovery and active-label
regeneration are confirmed live and remain pending.

The new operations are not yet used by the Clean adapter. Contextual metavariables,
checked lowering, and embedded lambda inference remain the next integration work;
no additional source programs are claimed supported by these model operations.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Checked binder-type bridge

[binder_types.py](../../cleanlang/joint_inference/binder_types.py) connects the symbolic Binder representation to
checked Type-0 Clean types in a fixed explicit environment and caller scope. It is
a separate experiment: the joint row builder and production compiler do not call
it. This is a representation bridge, not a complete conversion or inference
procedure.

Encoding preserves declared native constructor identities. A checked dependent
function is opened with a fresh source local using the compiler's checked
substitution operation. Direct bound index references become lexical Reference
nodes, then structural abstraction closes them into de Bruijn references. Nested
ordinary function layers remain declared Carrier nodes, including domains that
refer to outer binders. Free caller type parameters retain their classifier and
native identity.

Other indices are retained atoms whose identity includes both checked comparison
information and serialized source syntax. This avoids choosing a different source
representative merely because two expressions normalize to the same index. Their
source dependencies must exclude every local opened by the codec. A computed
index such as k+1 under the k binder is incomplete, as is a source expression
mentioning k even if normalization would erase it. Closed computations involving
caller locals, such as n+1 under a separate k binder, are retained and supported.
Thus equality of encoded terms is not a complete test of definitional equality.

Reconstruction resolves constructors through their explicit native identities,
opens binders with fresh lexical references, and rebuilds checked type objects.
It checks constructor arity, captured parameter classifiers, and value-index types
against the declared telescope. Retained indices are reified in the destination
scope. Bound references are never reconstructed by text replacement. The compiler's
existing rendering rule emits arrows for ordinary Function types and dependent
arrows for dependent function types; nonfunction constructors keep their wrappers.

The `apply` operation additionally rechecks an argument's source expression,
compares its type with the reconstructed domain, instantiates the symbolic body,
and reconstructs the resulting type. A certified domain mismatch rejects; missing
source/evidence, unsolved variables, malformed representations, unsupported types,
or exhausted traversal budgets are incomplete.

The native driver independently spells six expected targets: a direct dependent
vector family, nested matrix dimensions, an ordinary function with dependent
domain, a free caller dimension, a retained caller computation, and typed
instantiation. Its initial ordinary-function oracle incorrectly retained a
Function wrapper; the corrected oracle follows the established arrow-rendering
rule rather than weakening the canonical comparator. Python checks cover these
boundaries, freshness collisions, outer type parameters, stale argument source,
wrong domains and malformed index types.

Validation: all 332 experimental Python tests pass. The native driver passes
77 exact target comparisons and 77 supporting proofs: six new bridge checks
and 71 existing adapter checks. Provenance and reference-HTML checks pass. Full
production discovery and active-label regeneration remain live and pending.

Computed bound expressions, contextual metavariables, higher-universe binders,
embedded lambda inference, and integration with joint/production inference remain
pending. The six native checks validate this bridge only, not those missing paths.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Retained computed expressions under type binders

The checked binder-type bridge now supports computed indices containing selected
module calls/operators, ordinary applications, and record projections. For example,
`Function(k: Natural,Vector((k+1),Complex))` retains the declared addition and
numeral wrappers while exposing k as a structural bound reference. Nested
`j+k`, a bound callback `f(k)`, and a bound record projection `p.size` also work.

A checked expression is closed over its selected module bindings first. The codec
captures a template containing its constructor, selected target and presentation,
operand count, and ordered inferred-argument names. Operand expressions, inferred
argument types/indices, and result type become explicit children of an
`IndexExpression` node. Its identity contains no substituted bound-local spelling.
Direct local references and recursive computed operands pass through the existing
binder abstraction rule. Closed operands keep their retained source evidence.
The template is private checked evidence in the codec's fixed environment.

Reconstruction restores operand source trees from checked representatives, invokes
the captured call/application/projection, and checks its result type and every
inferred argument against the reconstructed expected metadata. Changed selected
operations, absent templates, wrong operand counts, or changed inferred/result
types are incomplete. It does not trust an old expression payload. Authored calls
whose mathematical value ignores an argument still retain that argument in their
native target rather than being normalized away for emission.

The symbolic model traverses IndexExpression children during abstraction,
instantiation, substitution, occurs checks, and scope checks. It does **not**
decompose unequal expression nodes as injective constructors during unification.
Their comparison requires checked conversion and is incomplete at the standalone
model boundary. In particular, equality of `ignore(n)` and `ignore(m)` cannot
recover n=m. Exact equal representations may agree, and a whole expression can
be assigned to a metavariable subject to the usual scope constraints. This
separates retained syntax from arithmetic or function-injectivity reasoning.

Seven new independent native targets cover bound addition, nested addition,
callback application, projection, inferred type arguments, an ignored authored
argument, and typed instantiation of a computed index. Existing targets remain
regressions. Python cases additionally check alpha stability, operation changes,
and deliberately altered inferred/result metadata.

Computed indices already reject source binders in the production compiler. The
codec additionally reports incomplete for bound type-value annotations and bound
literal payloads it cannot yet expose structurally. Contextual metavariables,
embedded lambda inference, higher-universe binders, and joint/production integration
remain pending. This is still a separate representation bridge, not a new global
inference policy or a complete definitional-equality procedure.

Validation: 346 experimental Python tests pass, together with 84 independent
native target comparisons and 84 supporting proofs. These include the seven new
computed-index cases above. Production full discovery and active-label regeneration
were confirmed running on 2026-11-11; neither is counted as a completed check.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Type values containing bound indices

The experimental bridge now lowers a checked `BoundTypeValue` inside a computed
index. For example, a declared `count carrier(T: Type): Natural` can occur in
`Function(k: Natural,Vector((count carrier(type(Vector(k,Complex):Type))),Complex))`.
The carrier annotation is traversed structurally, so its reference to k is closed
by the same binder rule as an ordinary index. It is not retained as opaque source
text containing a temporary local name.

Construction uses an IndexExpression with two children: the annotated carrier and
the expression's classifier type. Its private template retains the closed classifier
annotation, classifier snapshot, and explicit/implicit presentation flag. The
carrier annotation is absent from template identity, making bound renaming irrelevant.
Reconstruction decodes the carrier in the fresh binder scope, constructs an Annotation
with exactly its free references, and invokes the existing checked type-value
elaborator. That elaborator verifies the saved classifier snapshot and carrier
universe. The bridge also checks the reconstructed result classifier. No classifier
is reselected by searching the available declarations.

The two independent Lean oracles check the dependent function and its instantiation
at a caller index. They retain the declared carrier-count, vector and scalar wrappers;
the carrier's selected Type classifier is checked during elaboration rather than
emitted as a separate native argument. Python cases check alpha stability, source
preservation, substitution and rejection of a changed classifier declaration.

This extends the preceding computed-index slice; bound literal payloads, contextual
metavariables, embedded lambda inference, higher-universe binder domains and
production/joint integration remain pending. It adds no grammar rule and makes no
claim that arbitrary carrier expressions are supported by the codec.

Validation: 348 experimental Python tests, 86 exact native-target comparisons and
86 supporting proofs pass. The two new native targets check the bound carrier value
and its typed instantiation. Full production discovery and active-label regeneration
remain separate pending checks.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Literal payloads containing bound indices

The experimental checked-type bridge now traverses retained parameterized literals,
including `(0: Vector(k,Complex))` used as an operand inside a computed index under
`Function(k: Natural,...)`. The selected literal is preserved, rather than rerunning
literal selection or converting its retained source to an ordinary call.

For a checked BoundLiteral, the template keeps canonical and authored digits, the
selected declaration name and snapshot, parameter names and visibility in telescope
order, and presentation. Parameter source trees and the carrier annotation are
removed from that template. Each parameter expression becomes a structural child;
ordered recovered implicit arguments and the checked result type follow. These
children use the existing binder abstraction, instantiation and scope rules.

Reconstruction decodes every parameter, rebuilds the saved telescope with those
source trees, and creates a carrier Annotation from the decoded result type and its
free references. Existing literal replay then verifies the declaration snapshot,
digits, telescope, recovered implicit arguments, and result carrier. The bridge
also compares the result type and inferred arguments with its retained children.
Thus a changed literal declaration cannot silently select a new interpretation.
The representation remains non-injective: equality of literal results does not
justify recovering their parameter arguments.

Independent Lean targets cover a vector-zero operand inside a dependent index and
its instantiation at a caller's dimension. Python checks additionally exercise
alpha renaming and changed-declaration rejection. This extends the preceding
annotation slice. Contextual metavariables, conversion of unequal retained terms,
embedded lambda inference, higher-universe binders and joint/production integration
remain pending. This is representation support, not a new literal inference policy.

Validation: 352 experimental Python tests, 88 exact native-target comparisons and
88 supporting proofs pass. Full production validation remains a separate pending
check; these results do not establish production joint-inference conformance.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Outer parameter constraints under dependent binders

The checked type bridge accepts an explicit per-encoding map from caller local
names to symbolic variables. Each name must exist in the fixed caller scope; a
closed Type-0 classifier parameter requires a type variable, and other parameters
require index variables. Higher classifier parameters are incomplete. This map
is supplied by the caller, never inferred from an identifier's spelling.

Direct LocalType and ValueIndex references to mapped outer parameters become the
corresponding variables. Fresh inner binder names avoid caller locals, so the
usual abstraction rule closes only actual inner references. Computed expressions
are traversed when they reference either an opened binder or a mapped formal;
including dependencies in result types and inferred arguments. A fixed operand
whose type depends on an unknown formal currently reports incomplete; it must not
be frozen as an independent atom. Otherwise an opaque index atom could accidentally
hide an unsolved formal. The
mapping is reset on each encode call, and typed application clears it before
encoding the concrete argument.

For example, equating `Function(k: Natural,Vector(k,T))` with
`Function(j: Natural,Vector(j,Complex))` recovers T=Complex. Equating
`Function(k: Natural,Matrix(k,n,Complex))` with
`Function(j: Natural,Matrix(j,3,Complex))` recovers n=3. The bridge's structural
output feeds the existing symbolic unifier; resolving its assignments and decoding
the result rechecks carrier telescopes and retained expression evidence.

An outer n cannot be solved by the inner k: the resulting dangling bound reference
is rejected by scope checking. Computed n+1 exposes n but does not permit inverse
inference. If another constraint supplies n, reconstruction checks the substituted
expression. This is not a contextual metavariable implementation: unknowns allowed
to depend on a binder still need explicit substitutions and scope-aware solving.
Unsolved terms remain incomplete at reconstruction. Symbolic assignments alone do
not certify type correctness; successful checked reconstruction is required.

Two independent native targets cover recovered outer carrier and index parameters.
Python checks include scope escape, wrong formal sorts, missing caller locals and
computed-formal preservation. This connects the binder bridge to the standalone
constraint model. The Clean row builder still uses its existing rigid/forward
representation, and production integration and embedded lambda inference remain
pending; this does not claim either is complete.

Validation: all 358 experimental Python tests pass, with 90 exact native-target
comparisons and 90 supporting proofs. The two new native checks reconstruct solved
dependent types; they do not validate production candidate enumeration.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Recovering parameters from dependent callable arguments

The experimental Clean row builder now uses the binder bridge to derive additional
parameter constraints from a checked dependent function argument. For example:

```clean
Notation read family(f,x):
  Let T: Type
  Let f: Function(k: Natural,Vector(k,T))
  Let x: T
  Returns: T
  Means: x
  Render latex: read({f},{x})
```

With a caller `family: Function(j: Natural,Vector(j,Complex))`, the expression
`read family(family,0)` determines T=Complex and the complex numeral interpretation
without a default. The native oracle checks the complete call, including its
implicit Complex argument and selected numeral wrapper.

For each candidate declaration and dependent parameter whose actual source is
already available, the builder encodes the captured parameter type in a separate
declaration-local scope and the checked argument type in the caller scope. Formal
parameters use that candidate's existing variables. Private atom evidence is
converted to the builder's established comparison terms without registering new
candidate-provided witnesses. This keeps declaration locals distinct from caller
locals and preserves the existing representative priority policy.

The bridge derives equations only at variable positions reached through matching
Binder or nominal Carrier constructors. A proposed outer solution containing a
reference to an enclosing inner binder is not inferred. Computed expressions and
mismatching shapes contribute no reverse equations. Traversal limits remain
incomplete analysis. These equations augment the row's other constraints; they do
not themselves accept the function argument.

The existing forward TypePlan still substitutes every recovered parameter and
checks the complete actual/expected function type before candidate selection.
This matters for computed indices: eagerly adding a full structural equation would
incorrectly block an already-supported offset whose explicit argument determines
its value. Regression tests retain that forward path and keep a hidden, undetermined
offset incomplete. Final callable reconstruction still checks all implicit arguments.

The scope here is checked argument syntax. Inferred function-producing expressions,
embedded lambda bodies, contextual unknowns, and full production integration remain
unfinished. New reverse equations do not create missing value representatives: an
index recovered from a function type still needs independently available checked
evidence for emission. This is the experimental row builder, not production Clean.

Validation: 361 experimental Python tests, 91 exact native-target comparisons and
91 supporting proofs pass. The new whole-call oracle checks inferred Complex and
the selected complex numeral with defaults disabled. Production full discovery and
active-label regeneration were confirmed live separately; neither is counted here.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Caller evidence inside dependent function types

The experimental row prepass now collects checked outer parameter representatives
from caller-owned dependent types. A function of type
`Function(k: Natural,Matrix(k,n,Complex))` can supply both the constraint width=n
and the retained caller expression n needed to emit an inferred width argument.
Likewise a function returning `Vector(k,U)` supplies a caller type parameter U even
when no other argument uses U. This extends the preceding row integration beyond
parameters already represented elsewhere in the expression.

Collection runs only in the caller-capture form of `Builder.typ`, before candidate
enumeration. It visits dependent domains before bodies and nominal type arguments
in declaration order. A dependent body is opened with a fresh checked local; the
set of these traversal-local names is tracked separately from caller binder scopes.
An index or local carrier mentioning an opened local supplies no outer witness.
Closed ValueIndices are re-elaborated in the original caller scope and converted
with the existing checked index operation. LocalType representatives must still
match their caller binding. Other carrier constructors supply no additional
representatives; their absence is not a claim of successful general reconstruction.

Discovered representatives are staged until traversal succeeds, then inserted with
first-witness priority. Existing witnesses retain priority. Candidate declarations
cannot invoke this capture path through structural argument matching: their atom
conversion still uses `typ(...,{})`. Witness scope checks continue to apply during
reconstruction, including memoized lookups. A computed expression involving both an
opened local and a caller local is not split to invent a representative here.

Two complete-call native oracles check an inferred caller dimension and an inferred
caller carrier, each known only through the function argument's type. Additional
Python checks compare alias-first versus plain-name-first collection and ensure
that no traversal-local reference becomes caller evidence. This does not add
contextual metavariables or inferred function-producing argument support, and
production joint inference remains pending.

Validation: 365 experimental Python tests, 93 exact native-target comparisons and
93 supporting proofs pass. These checks cover the experimental caller-evidence path;
they are not a completed production conformance run.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Dependent arguments produced by candidate calls

The experimental row builder now checks available producer syntax through its
owned candidate-validation path before deriving dependent argument constraints.
For example, `read family(make family(0),0)` works without defaults when
`make family` takes a Real and returns `Function(k: Natural,Vector(k,Complex))`,
and `read family` has the generic signature above. The first zero is Real; the
second is Complex, determined through the produced function type.

Previously the bridge directly elaborated each candidate producer. An incompatible
literal assignment, such as a Complex zero passed to the Real producer, raised a
signature exception and aborted enumeration. It now invokes `check_candidate`,
which associates a fresh owner with the checking trial. Only a compiler-certified
signature mismatch belonging to that trial rejects the enclosing candidate row.
Foreign mismatch ownership remains incomplete; other Clean checking errors are
reported as unavailable analysis. No failed competitor is treated as absent merely
because its check is unavailable. The trial restores the previous owner on exit.

This does not independently solve a producer subexpression or apply a default.
It checks the already-selected syntax of that candidate. All child equations,
forward type obligations, and final implicit-argument checks remain in the parent
row. Available producer syntax is supported; producers requiring unresolved
parameterized-literal reconstruction, or embedded lambda inference, remain pending.

The new complete-call native oracle retains both literal wrappers and the inferred
Complex argument. Python regressions cover unavailable checking and reversed
callable declaration order, in addition to the successful nested call. Production
integration remains pending.

Validation: 368 experimental Python tests, 94 exact native-target comparisons and
94 supporting proofs pass. Full production validation remains separate.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Deferred parameter recovery from producer return types

The row experiment now supports a function producer whose parameterized literal
arguments do not yet have retained source syntax. For example:

```clean
Notation make vector family(n: Natural,x: Vector(n,Complex)): Function(k: Natural,Vector(k,Complex)):
  Means: fun _ _ => (0 : Complex)
  Render latex: family({n},{x})
```

`read family(make vector family(n,0),0)` determines the consumer's Complex
parameter without first independently solving the producer. A matrix-family
variant returning `Function(k: Natural,Matrix(k,n,Complex))` recovers the consumer's
width after substituting n, including when the producer call is `(2,0)`.

A ParameterPlan captures the consumer parameter variable, its checked dependent
parameter type and formal-variable map, the checked consumer signature, and the
producer's declared return template with its referenced formal-variable map. Only
variables reached through Binder and nominal Carrier structure are eligible;
variables hidden inside computed expressions are not inverse-inference targets.
Referenced producer formals, in captured order, are the plan's dependencies.

At saturation, ground dependencies are reconstructed using the existing witness
resolver. Checked substitution produces the actual function type, and the binder
bridge derives the consumer equations from that type. Unification resolves the
requested parameter; a still-unsolved output is incomplete. This is a forward
obligation on producer dependencies, not a separate producer candidate search.
The consumer's complete forward TypePlan, all producer argument equations, and
final checked applications remain in the same row. Invalid producer literal
arguments are therefore still rejected even if their declared return type alone
would satisfy the consumer.

Two independent complete-call targets cover a fixed vector-family result and a
matrix-family result whose width comes from a scalar literal. Python checks also
cover a caller width and an invalid producer literal. Contextual metavariables,
embedded lambda inference, reverse inference through computed operations and
production integration remain pending.

Validation: 372 experimental Python tests, 96 exact native-target comparisons and
96 supporting proofs pass. Full production discovery and active-label regeneration
remain separately running checks, not completed evidence for this experiment.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Checked evidence for recovered producer parameters

A deferred producer can now supply the checked expression needed to emit a recovered
consumer parameter. For example, if its return type is
`Function(k: Natural,Matrix(k,(n+1),Complex))`, a consumer's inferred width retains
the selected n+1 expression. Previously the constraint resolved but the witness
resolver had no representative for this new computed width.

The structural argument matcher can return checked evidence beside its equations.
It traverses matching binder domains before bodies and nominal arguments left to
right. At each eligible outer variable it retains the corresponding closed subtree
of the checked actual type. Existing codec atom evidence supplies indices and local
carriers; other closed type subtrees are reconstructed by the checked codec. Any
subtree referring to an enclosing inner binder remains ineligible. Matching still
does not register global candidate representatives.

Each ground ParameterPlan with a non-nominal output contributes a witness plan
after the existing forward index/type plans, in captured plan order. Nominal
carriers retain existing structural assembly: a speculative witness must not mask
a certified type mismatch in a rejected row. Its dependencies remain the producer return
template's referenced formals. Reconstruction repeats checked substitution and
structural matching, choosing the first source occurrence for that formal. The
resolver validates the result against the solved parameter and applies its existing
scope and priority rules. Missing evidence is incomplete; symbolic agreement alone
cannot certify emission. Prior caller, scalar and static witnesses retain priority.

After selection, recovered evidence is rechecked against the solved parameter before
being retained alongside other selected representatives. Thus candidate-local plans
do not install evidence for rejected alternatives. The complete producer argument
and consumer signature checks remain mandatory.

The independent whole-call Lean oracle includes the natural-sum and numeral wrappers
for n+1, the vector-zero producer argument, and the consumer's Real zero. Python
regressions cover the computed-width call and failure when its recovered evidence
is unavailable. Production integration and embedded lambda inference remain pending.

Validation: 374 experimental Python tests, 97 exact native-target comparisons and
97 supporting proofs pass. The new oracle checks the retained computed-width argument;
these results do not establish production joint-inference conformance.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Contextual pattern inversion groundwork

`contextual_terms.py` implements one ground contextual-pattern equation. The standalone operation is now used by the contextual fixed point and selector
described below. It is not connected to the source `Builder` or production
inference. In particular,
embedded lambda arguments remain unsupported; their bodies must not be solved or
defaulted independently of the surrounding call.

The motivating equation is an unknown family applied to a fresh local k whose
required value is Vector(k,Complex). A closed solution must represent dependency
on its argument, so applying it later at j yields Vector(j,Complex), without
retaining k. Ordinary metavariable substitution cannot express this operation.

The interface takes an ordered formal telescope `(name, domain, sort)`, equally
many typed actual locals, a ground structural right side and an explicit immutable
set of allowed free locals. Actuals must be distinct explicit `Reference` nodes;
they may not overlap the allowed-free set. Formal names are also distinct and
fresh relative to that set. Domains may refer only to earlier formals and the
allowed free scope. Repeated/nonlocal actuals are unsupported patterns, not proved
inconsistencies. This is deliberately not general higher-order unification.

For each formal in order, simultaneously substitute prior actual references into
its domain and compare with the checked actual type using the existing ground
unifier. Sort mismatches and incompatible domains reject the equation. Unresolved
actual types and unequal computed indices remain incomplete. Then simultaneously
rename the right side's actual locals to formal locals, checking reference sorts.
Check the original right side against actual locals plus allowed-free scope before
accepting the renamed result. A foreign local merely named like a formal must not
be captured. Also check dependencies against the formal and permitted free scope.
Close the formals
in reverse telescope order using explicit de Bruijn abstraction. The resulting
`Context` binders are model closures, not Clean syntax or emitted Lean binders.
Their domains retain dependencies on preceding arguments.

Applying a solution rechecks the telescope, checks each stored closure domain
against the supplied actual type, and substitutes actual locals in order. It checks
that the result is ground, well-scoped and contains no forbidden free dependency.
Opaque atoms depending on a renamed local cannot be inspected or silently renamed:
they report incomplete. Structural computed expressions are retained verbatim;
no arithmetic inverse is used. Resource or recursion limits also report incomplete.

Seventeen focused tests include explicit expected closed trees, alpha invariance,
permuted names with dependent domains, inner-binder and foreign-formal-name
capture avoidance, allowed
free constants, foreign-local escape, duplicate actuals, opaque and unresolved
right sides, domain/sort mismatches, malformed closure domains, computed expressions
and resource limits. The expanded full experimental suite passes 391 tests, including all seventeen
contextual-pattern cases. Reference HTML IDs/local links and provenance checks
also pass.
These model checks are not canonical Lean-target evidence. A next source integration
must represent contextual occurrences in source-derived joint rows, solve all lambda/body
and surrounding-call constraints together, and recheck the complete selected
Clean expression against independently authored native targets. That work and
production integration remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Shared contextual constraints and forward checks

`contextual_constraints.py` adds a fixed point over ordinary equations, typed
contextual occurrences and existing `Deferred` checks. Its `saturate_contextual`
adapter consumes an ordinary model `Row`'s equations and deferred obligations.
The selector described below now uses this adapter before defaults. The source
Builder still does not construct contextual occurrences.

Each family has a unique string identity, fixed ordered formal telescope, output
sort and allowed-free scope. References denote lexical binding identities, not
merely printed source names. Each occurrence has a unique string identity, refers
to that family, supplies typed explicit local arguments, and has an ordinary
symbolic output. One ground occurrence can determine the family closure; another
use under a different local name then constrains its output through checked
application. All uses must agree. This permits a first family to constrain an
ordinary type variable that unlocks a second family or a forward obligation.

The constructive rule is:

1. Unify the ordinary equations with the existing scope-checked unifier.
2. Resolve each occurrence's domain types, actual types and output. An occurrence
   is ready when its domain/actual types are ground and either its output is ground
   or its family already has a solution. Forward checks are ready when all inputs
   are ground. No ready work with pending dependencies means incomplete.
3. For an unsolved family, invert each ready ground occurrence using the contextual
   pattern operation. Compare all proposed closed solutions; never select the
   first occurrence without checking the others. For a solved family, recheck its
   dependent telescope and instantiate at each ready occurrence's actual locals.
4. Evaluate ready forward checks under the same bindings. As with ordinary Row
   checks, callbacks must be deterministic and pure under the fixed environment.
   Their results must be
   ground, structurally supported and well-scoped. Compare each result against its
   output, and collect its equation together with the contextual output equations.
   Unavailable ready checks dominate mismatches in the batch. If checks succeed,
   jointly unify the collected equations, retain the agreed closures, and repeat.
5. Return the ordinary bindings and contextual closures only when all occurrences
   and forward checks have finished. Row argument determination and exhaustive
   candidate selection remain the caller's obligations, as for ordinary saturation.

The occurrence IDs provide a fixed diagnostic traversal; they do not choose a
permitted interpretation. There is no arithmetic inversion, opaque-atom renaming,
independent lambda-body solve, or default application. Unsupported patterns,
conversion, unresolved cycles and resource exhaustion remain incomplete. A foreign
local cannot escape into an output variable with a smaller permitted scope.

Seventeen new tests cover alpha-renamed sharing, conflicting uses and input-order
permutations, ordinary-to-contextual and contextual-to-ordinary propagation,
multiple-family chains, dependent actual types, unresolved cycles, scope rejection,
sort and identity validation, unavailable-check precedence, computed-expression
boundaries, shared forward-check saturation and resource limits. These are model
checks. Builder integration, contextual occurrence encoding under source binders,
whole-expression native oracles and production joint lambda inference remain
pending; no source syntax or emitted Lean target changes here.

Validation: all 408 experimental tests pass, including the seventeen new cases.
Reference HTML IDs/local links and provenance checks pass. No production compiler
files changed, and no new canonical Lean-target validation is claimed for this
model-only addition. Existing full discovery and active-label snapshot jobs remain
live and pending separately.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Contextual candidate selection and checked callable types

`select_contextual` accepts exhaustively enumerated candidates, each carrying an
ordinary Row, family declarations and contextual occurrences. It saturates each
candidate before applying defaults. A proved inconsistency rejects that candidate;
an incomplete contextual/forward check propagates and prevents selection. The
resulting ordinary bindings become equations in a checked row retaining all
literal carriers and emitted arguments. Contextual domains and outputs are already
ground, so subsequent defaults cannot change their solutions. The existing selector
then applies simultaneous defaults, checks remaining parameter determination and
requires one surviving interpretation. Different declaration candidates remain
ambiguous even when their carrier and meaning coincide.

A private ordinal associates a checked row with its source choice tuple and solved
families. It is never a preference: it is read only after the ordinary selector
establishes uniqueness, then removed from the returned selection. This matters when
two speculative rows have the same source choice tuple but different arguments.
A row rejected by defaults must not be replayed against the selected row's arguments;
that could incorrectly require conversion between unrelated computed expressions.
Eight selection tests cover this case, row-order permutations, ambiguity, invalid
and unresolved contextual competitors, unresolved emitted arguments, defaults,
unfinished enumeration and row limits.

`callable_type` interprets a type-valued contextual telescope using an explicitly
supplied declared function identity. It first reapplies the stored closure at its
formal locals, verifying that its domains agree with its parameter metadata. It
then replaces exactly the outer Context binders with declared function binders;
inner type syntax is unchanged. Non-type results and malformed telescopes are
rejected. The checked binder codec still validates the declaration, domains,
result and retained expression evidence. Three new tests cover this boundary.

The [native driver](check_contextual_types.py) follows selection with this codec
and emits [ContextualTargets.lean](ContextualTargets.lean). Its four independently
authored target types are:

```clean
Function(k: Natural,Vector(k,Complex))
Function(j: Natural,Function(k: Natural,Matrix(j,k,Complex)))
Function(k: Natural,Vector((k+1),Complex))
Function(k: Natural,Matrix(k,n,Complex))
```

The last type retains the caller's n. The computed dimension retains the declared
natural-sum and numeral wrappers. The driver checks exact elaborated type bodies
and four separate interpretation equalities in Lean. These are recovered callable
**type** targets, not lambda bodies or complete calls. Reproduce with:

```sh
LAKE=lake python3 studies/parameterized-literals/check_contextual_types.py
python3 -m unittest discover -s studies/parameterized-literals -p 'test_*.py'
```

The source Builder still needs to enumerate lambda-body and surrounding-call
constraints together, encode contextual occurrences under lexical binders, retain
selected body witnesses and recheck complete expressions. No production grammar or
inference rule changes in this slice. Earlier experimental native cases retain
their own validation scope; these four targets do not supersede them.

Validation: all 419 experimental tests pass, including eight selection cases and
three callable-type conversion cases. The four exact native targets and four
interpretation proofs pass. Reference HTML IDs/local links and provenance checks
pass. No production compiler files changed; the existing full-discovery and
active-label snapshot jobs remain live and pending separately.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Retaining selected scoped bodies

`Builder.retain_selected` reconstructs a supplied selection without invoking the
selector or applying defaults again. Its caller must already have established
exhaustive joint selection; this method alone does not certify that choice. It
validates marker positions and ground arguments, finds exactly one fresh local row
with the supplied choices and argument arity, and independently audits operator
input ambiguity. That audit uses a separate Builder so unselected alternatives
cannot change retained-witness priority. It then rebuilds fresh local rows, checks
selected argument/default equations and all deferred obligations, retains the
selected witnesses, and rechecks the resulting expression and callable identities.
Ordinary `materialize` now selects once and delegates to this boundary.

`ScopedBody` opens one source Lambda/Forall/Exists with its explicit domain, a fresh
checked local and a lexical identity derived from an explicit source path. It
rebinds a known dependent expected codomain to this local. `rows()` exposes body
alternatives without selection or defaults; `retain()` consumes the projected
joint selection, reconstructs that body, and re-elaborates the complete binder so
retained annotations refer to its final compiler binder. A nested binder cannot
reuse an enclosing lexical identity. Caller/source paths must distinguish sibling
scopes. Recursive source-binder enumeration is still a separate missing layer.

Eleven Python tests cover absence of a second selection, externally imposed body
constraints, retained-codec rebinding, sibling lexical identities, bad arity and
default traces, unavailable rows, operator ambiguity, domain changes and stale
scope. `retain_selected` deliberately permits external constraints to determine
its body; rerunning a standalone selection would discard that joint information.

The [scoped-body driver](check_scoped_bodies.py) supplies an explicit consumer
signature, forms the Cartesian product of body and sibling-argument rows, combines
all constraints, selects once, and projects that selection back to each child.
Its [generated native targets](ScopedBodyTargets.lean) check these complete calls:

```clean
consume family(function (k: Natural, 0),0)
apply complex(function (z: Complex, 0),0)
consume shifted family(function (k: Natural, 0),0)
```

The consumers are explicitly declared fixture notations. The first expects
`Function(k: Natural,Vector(k,Complex))`; the third expects a vector of dimension
k+1. In the second, the complex result constraint is added to the joint row,
rather than supplied to the child Builder in advance. The call actually applies
the complex-valued lambda to its selected complex argument. All three bodies and
sibling arguments retain the declaration selected by the shared constraints.
Independent native oracles specify the full calls, literal wrappers, lambda binders
and dimension expressions; separate Lean equalities check their meanings.

Reproduce with:

```sh
LAKE=lake python3 studies/parameterized-literals/check_scoped_bodies.py
LAKE=lake python3 studies/parameterized-literals/check_clean_rows.py
python3 -m unittest discover -s studies/parameterized-literals -p 'test_*.py'
```

This is an explicit scoped-row adapter, not automatic nested-lambda inference in
the source Builder. General enclosing-signature discovery, joint contextual
occurrence construction, nested body enumeration and production integration remain
pending. Existing conditional failures must still be reported as incomplete,
not bypassed by choosing a simpler independently defaulted body.

Validation: all 430 experimental tests pass. The three new full-call canonical
targets and three interpretation proofs pass; the existing 97 native targets and
97 supporting proofs pass after the reconstruction refactor. Reference HTML
IDs/local links and provenance checks pass. Production compiler files are unchanged;
the separately running full-discovery and active-label snapshots remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Automatic direct scoped consumers in the experimental Builder

`Builder.materialize` now recognizes a direct module call with a Lambda/Forall/
Exists argument containing literal holes and invokes `scoped_calls.py`. It reads
the checked declaration signature; fixture code no longer has to provide the
consumer constraints. This is an experimental source path, not production
inference or general contextual signature discovery.

The implemented boundary requires explicit consumer parameters. Their types and
the return type may depend on earlier arguments only when those arguments have
already been checked without literal holes. Thus a known caller dimension or
explicit carrier can specialize a later function type. An inferred earlier number,
implicit consumer parameters, local-function consumers, callable-evidence views,
or a return type depending on an unresolved chosen value remain incomplete. The
path does not independently select an earlier literal to make these dependencies
appear known. Recursive nested-binder construction is also still pending.

Within that boundary the constructive rule is:

1. Validate the module callable's captured signature and arity. Traverse explicit
   parameters in declaration order. Substitute checked earlier values into each
   parameter type; unresolved required dependencies stop with incomplete analysis.
2. Open scoped arguments using that expected type and their source path. Build
   ordinary sibling rows under their expected parameter types. No child invokes a
   selector or defaults. Check and record each hole-free argument for later
   signature substitution; arguments with holes remain unresolved at this stage.
3. Resolve the return type and impose the caller's expected type as an equation.
   Form the bounded Cartesian product of all child alternatives, preserving their
   equations, deferred checks, literal carriers and emitted arguments. Saturate
   every candidate and apply simultaneous defaults only to this combined set.
4. Project the unique selected argument/default trace to each child. Retain scoped
   bodies and siblings through the checked reconstruction boundary. Revalidate the
   consumer declaration, check the complete rebuilt call, and compare its result
   with the selected return type.

Each child Builder has an explicit source-path row namespace. Its unknowns include
that namespace as well as their existing local identity and binder permissions.
This separates sibling literal dimensions even when both use the same declaration
and the same local hole path. Namespaces are also preserved in reconstruction
operator audits and nested materialization. They do not affect emitted Lean names,
source grammar, or the native target. Lexical binder identity and row-variable
identity remain separate concepts.

For example, these now go through `Builder.materialize` directly:

```clean
consume family(function (k: Natural,0),0)
sized(n,function (z: Real,0))
mixed(n,m,function (z: Real,0),0,0)
typed(type(Real),function (z: Real,0),0)
accept(for every (z: Real,z = 0),0)
```

Their consumer declarations are explicit fixtures in
[check_scoped_calls.py](check_scoped_calls.py). The mixed consumer expects vector
arguments of dimensions n and m; its two zeros must not share an inference
variable. The typed consumer takes an explicit carrier followed by a function and
value of that carrier. `sized(2,function (z: Real,0))` remains incomplete because
its earlier numeric argument is not yet a checked hole-free signature input;
this is a tracked inference gap, not a declaration that the call is ill-typed.

Fourteen focused tests cover automatic dependent/computed lambda types, sibling
namespaces and distinct vector dimensions, independent lambda result carriers,
known dimension/carrier substitution, unresolved or implicit inputs, signature
mismatches, retained serialization, absence of child selection, operator ambiguity
and quantified arguments. The [native driver](check_scoped_calls.py) generates
[ScopedCallTargets.lean](ScopedCallTargets.lean), with eight independent complete-call
oracles and eight interpretation proofs. Reproduce with:

```sh
LAKE=lake python3 studies/parameterized-literals/check_scoped_calls.py
python3 -m unittest discover -s studies/parameterized-literals -p 'test_*.py'
```

General implicit/contextual signature recovery must connect the contextual family
model to source-derived occurrences. That work, recursively nested scoped bodies,
local callable consumers and production integration remain outstanding. None may
be replaced by silently solving/defaulting children first.

Validation: all 444 experimental tests pass, including fourteen automatic scoped
consumer cases. Eight new complete-call canonical targets and eight interpretation
proofs pass. The existing 97-target/97-proof suite and three-target/three-proof
explicit scoped-adapter suite also pass after the namespace changes. Reference
HTML IDs/local links and provenance checks pass. Production compiler files are
unchanged, and the separately running full-discovery/active-label snapshots remain
live and pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Recursive scoped expression preparation (experimental)

The scoped consumer experiment now recursively prepares module-call arguments and
binder bodies. It supports nested lambdas when the enclosing explicit signature
determines their callable types, nested quantifiers, a scoped call inside another
call, and a scoped call inside a lambda body. For example:

```clean
nested(function (a: Real,function (b: Real,0)),0)
wrapped(inner(function (a: Real,0),0))
body(function (a: Real,inner(function (b: Real,0),0)),0)
```

The existing parser determines each syntax tree before inference. Preparation
recurses on that tree: an ordinary expression exposes its checked rows; a binder
opens one fresh source-path local and exposes its recursively prepared body rows;
a module call forms the Cartesian product of its recursively prepared argument
rows. Each call appends its checked result term and expected-type equation.
Binder rows describe the body, not an inferred whole-function type; the whole
binder expectation is already fixed by its consumer. No function-type inference
is claimed at this boundary.

Only the outer selector defaults and selects. Reconstruction projects the selected
argument and default-marker slices into the same prepared child rows, retains
literal witnesses, then re-elaborates each whole binder/call. A product ordinal
associates a selected row with its children; it is never an ambiguity tie-breaker.
Child budgets decrease on recursion, Cartesian products are bounded, and recursion
exhaustion reports incomplete analysis. Scope identities and row-variable namespaces
follow source paths, including nested body and argument positions.

Implicit consumers, dependencies on unresolved earlier values, local callable
consumers, scoped expressions under unsupported operators, and general contextual
signature recovery still need integration. Production inference is unchanged.
The focused tests forbid independent child selection and cover nested lambda,
quantifier, call and retained-codec cases. The native driver includes three new
independently written complete Lean targets and interpretation proofs.
Validation: the full experimental suite passed 448 tests before the two additional
negative cases; the final focused suite passes 31 tests, including resource
exhaustion and ambiguity inside a nested call body. Eleven complete-call canonical
Lean comparisons and eleven interpretation proofs pass. The existing 97-target/97-proof
suite and three-target/three-proof scoped adapter suite also pass. Production full-discovery
and active-label snapshot processes remain live; these results do not substitute
for their pending completion.

:::

:::llm gpt-6 2026-11-11 role=assisted

## Local scoped consumers and explicit application (experimental)

The experimental scoped path also accepts a local callable or an explicit
application whose head has no unresolved literal holes. Examples, with explicit
local types:

```clean
-- h: Function(Function(Real,Real),Real)
h(function (a: Real,0))
-- h: Function(k: Natural,Function(Function(Real,Vector(k,Complex)),Real))
h(n)(function (a: Real,0))
-- h: Function(Proposition,Real)
h(for every (a: Real,a = 0))
```

The parser already distinguishes `Call` from `Apply`. Each local or explicit
application consumes exactly one argument; `h(n,f)` is not an alternative spelling
for curried application. Module-declared notation retains its explicit declared
arity. A local call checks its `Local` head; `Apply` checks its supplied head tree.
Both read the domain from that checked callable type and recursively prepare the
single argument using that domain as expectation. A dependent codomain is
substituted only using a checked hole-free argument; a hole-bearing argument on
which the codomain depends reports incomplete analysis. Ordinary codomains need
no substitution. The existing joint product, outer selection, trace projection
and whole-expression recheck then apply unchanged. The checked head type is
revalidated during reconstruction.

`h(n)(function (a: Real,0))` works because `h(n)` has a determined dependent
result type. `h(2)(function (a: Real,0))` remains incomplete: its head contains an
unresolved literal. More generally, a scoped application whose head itself needs
joint inference is not solved separately. Proof-type callable views and general
implicit/contextual discovery remain pending. This extends experimental source
coverage only; it adds no grammar and changes no production inference rule.

Six focused cases cover local lambdas, quantified arguments, dependent checked
heads, unresolved heads, local arity rejection and retained serialization. Three
additional independent full-expression Lean targets check local heads and their
interpretations. The consumer itself is universally quantified in these native
checks; its mathematical behavior is not assumed.
Validation: all 456 experimental tests pass, including 37 scoped tests. All fourteen
scoped canonical Lean targets and fourteen interpretation proofs pass. Provenance,
reference HTML IDs/local links and whitespace checks pass. The production compiler
is unchanged; the separately confirmed live full-discovery and active-label runs
remain pending.

:::

:::llm gpt-6 2026-11-11 role=assisted

## Joint preparation of function-producing heads (experimental)

The scoped application experiment now prepares a hole-bearing `Call` or `Apply`
head recursively when its result type follows from its checked explicit signature
without selecting any argument. Examples:

```clean
-- h: Function(Function(Real,Real),Function(Complex,Real))
h(function (a: Real,0))(0)
-- h: Function(Complex,Function(Function(Real,Real),Real))
h(0)(function (a: Real,0))
-- factory(f: Function(Real,Real)): Function(Complex,Real)
factory(function (a: Real,0))(0)
```

Typed call preparation returns candidate rows, a reconstruction operation and a
checked result type. This type is independent of the still-unselected argument
alternatives: implicit signature parameters and dependencies on unresolved actual
values still block preparation. For `Apply`, a prepared head occupies source path
`(1,)`; arguments occupy `(2,i)`. The head rows are the first factor in the same
Cartesian product as the outer argument rows. All carriers, equations, deferred
checks and selected arguments remain in that product until the single outer
selection. Recursion decreases the preparation budget.

Reconstruction first projects the selected trace into the head, rechecks its
result type against the prepared type, and inserts its retained syntax into the
outer `Apply`. It then rechecks the complete application. Ordinary checked heads
continue to use their existing type and whole-expression recheck. Product order
only records provenance and positions; it cannot resolve competing meanings.

This supersedes the blanket hole-free-head restriction of the preceding stage.
Heads whose result depends on unresolved actuals, directly applied source lambdas
without a determined callable type, proof-type callable views and general implicit
signature recovery remain incomplete. For example, the dependent `h(2)(...)`
case still requires joint value-dependent type recovery. No syntax or production
inference change is claimed.

Six additional tests cover local and module heads, a nonscoped literal-bearing
head, retained serialization, ambiguity within a head and resource exhaustion.
Three independent complete Lean targets cover both head orders and the module
factory, with interpretation proofs. Head preparation never calls the independent
selector, and the tests assert this for the curried local example.
Validation: all 462 experimental tests pass, including 43 scoped cases. Seventeen
independent scoped Lean targets and seventeen interpretation proofs pass. Provenance,
HTML IDs/local links and whitespace checks pass. The production full-discovery and
active-label snapshot processes are still confirmed live; their completion remains
pending and is not inferred from these experimental checks.

:::

:::llm gpt-6 2026-11-11 role=assisted

## Installable joint completion API

The maintained implementation now lives in `cleanlang/joint_inference/`; this
study retains its experiments, tests and native target drivers. There is one
implementation, with package-relative internal imports. Historical development
notes above retain their experimental status; moving code does not discharge
inference or conformance gaps.

```python
from cleanlang.joint_inference import complete, Incomplete
value = complete(parsed_tree, environment, locals, expected_type,
                 limit=4096, use_default=True)
```

`complete` accepts an already parsed expression tree and a fixed explicit environment
and local scope. It returns the checked retained `Expr`. `Incomplete`, `NoSolution`,
`Ambiguous` and `Underdetermined` are exported analysis outcomes; underlying binding
or source errors remain compiler errors. Invalid resource limits are rejected.
The caller's scope dictionary is copied. This API neither parses source nor
changes `Expressions.elaborate` or the ordinary numeral completion entry point.
An incomplete joint solve is propagated, never retried under the old inference
policy. The ordinary no-hole elaborator remains the checker for retained candidates.

The package includes all nine implementation modules and its API in built wheels.
Tests and native drivers import the package directly, with no study-path loader or
second implementation. The scoped driver now exercises `complete` for all seventeen
canonical targets and interpretation proofs. Production default routing remains
pending compatibility and full inference coverage; no fallback based on which
solver succeeds is an acceptable integration policy.

Validation: 462 solver tests, four dedicated API tests and seventeen native scoped
comparisons/proofs pass after relocation. A wheel built with `uv build --wheel`
was installed to a fresh temporary target; from `/tmp`, with only that target on
`PYTHONPATH`, both a dimensioned vector zero and a recursive local application
passed. Explicit library source files were supplied by absolute path; this check
does not claim that the standard library itself is bundled in the wheel.
After relocation, the existing 97-target/97-proof suite, four contextual-type
targets/proofs and three scoped-adapter targets/proofs also pass: 121 canonical
Lean comparisons and 121 supporting proofs across the four native drivers.
Provenance and reference HTML IDs/local links pass. The old production validation
snapshot processes remain confirmed live; their results are still pending.

:::

:::llm gpt-6 2026-11-11 role=assisted

## Document compatibility and structural contradiction pruning

`tools/check_joint_compatibility.py` loads each input in two isolated subprocesses:
one uses legacy numeral completion, the other routes every hole-bearing expression
to the packaged joint API. Hole-free expressions retain the ordinary checked
elaborator. A failed joint load is recorded, never retried with legacy completion.
Reports distinguish incomplete analysis, no solution, ambiguity, underdetermination,
other errors and worker failures. Generated-source hashes are diagnostic comparisons,
not independently authored canonical-target oracles. A zero-hole document offers
no evidence about numeral inference even if its output agrees.

The first corpus run found a row-limit failure on `sin(x)^2 + cos(x)^2 = 1`.
Callable child fragments included already-contradictory scalar combinations, so
the parent Cartesian product exceeded the budget before checking those equations.
The solver now unifies each completed callable fragment's structural equations
before returning it to its parent. It drops only `NoSolution` fragments; success
or `Incomplete` retains the fragment unchanged for the enclosing solve. It does
not evaluate deferred callbacks, select a carrier, apply a default or use an
expected parent result during pruning.

This preserves the accepted interpretations: the parent adds constraints to a
child's conjunction, and adding constraints cannot satisfy an already-refuted
conjunction. Scope, occurs and rigid-constructor contradictions are refutations;
unavailable computed-index conversion is not. Surviving candidates still undergo
the full solver, operator ambiguity audit, simultaneous defaults and retained
reconstruction. Existing Cartesian and solver limits remain enforced.

After the fix, all four curated corpus documents (92 results) produce identical
Lean source under isolated legacy and joint routing. This includes 19 hole-bearing
completion calls; the graph-theory document has none. All 92 generated corpus
proofs also pass under joint routing. The dedicated API regression checks the
trigonometric expression without defaults, and all 462 solver tests plus five API
tests pass.

Topology compatibility remains incomplete. `CompactImage.clean` agrees, while
`ExactSequences.clean`, `HomologySequence.clean` and `MayerVietorisMaps.clean` stop
at higher-universe carrier encoding, first encountered in `object(n+1)`. These are
solver coverage gaps, not missing topology theorems or syntax ambiguities. Default
production routing therefore remains unchanged.

Reproduce:

```sh
LAKE=lake python3 tools/check_joint_compatibility.py --verify-corpus --output /tmp/joint-corpus.json
python3 tools/check_joint_compatibility.py studies/topology/CompactImage.clean studies/topology/ExactSequences.clean studies/topology/HomologySequence.clean studies/topology/MayerVietorisMaps.clean --output /tmp/joint-topology.json
```

The second command intentionally exits nonzero for incomplete compatibility.
`--verify-corpus` regenerates the tracked corpus proof fixture and checks it with
the pinned Lean environment. Completed per-document observations are saved as the
run proceeds; an unfinished report is not proof that remaining inputs pass.
The [recorded report](compatibility.json) retains the initial failure, successful
corpus comparison/proof check, and the topology incomplete-analysis observations.

The existing 97 canonical target comparisons and 97 supporting proofs also pass
after pruning. These supplement the 92 corpus proofs; they do not validate the
currently incomplete higher-universe topology cases.

:::

:::llm gpt-6 2026-11-11 role=assisted

## Closed higher-universe nominal carriers

The joint solver now accepts nominal carriers whose declarations have any closed
positive Lean `Sort` level. A carrier declared with `Universe: 1` therefore remains
in `Type 1`, rather than being rejected by the former Type-0-only guard. Ordinary
function carriers recursively retain their declared domain and codomain identities,
including higher-universe codomains. This handles `object(n+1)` when `object`
returns an explicitly declared module object or another closed nominal carrier.

The symbolic `type` sort is a category of constraint terms, not Lean `Type 0`.
A nominal `Carrier` retains its declaration binding identity and all arguments;
the fixed declaration supplies its closed universe. Distinct carrier declarations
remain distinct even when both are higher-universe types. Ground reconstruction
still uses checked declarations and ordered argument validation. The encoding adds
no universe metavariable, cumulative coercion or implicit universe choice. Non-Type
constructors, unresolved universe levels, higher local carrier variables, higher
classifier operands/parameters and general higher dependent binders retain their
existing explicit incomplete-analysis boundaries.

All three previously blocked topology documents now produce the same generated
Lean under legacy and joint routing: `ExactSequences.clean`,
`HomologySequence.clean` and `MayerVietorisMaps.clean`. The compatibility report
retains both the earlier failures and this newer result. This removes that specific
integration blocker; it does not prove the full geometric Mayer–Vietoris theorem.

The API tests cover closed nominal results in `Type 1` and `Type 2`, rejection of a
lower expected carrier, and continued incomplete analysis for higher-classifier
inference. Independently authored native targets for `object(n+1)` at both universe
levels compare exact elaborated bodies and prove their ordinary application meaning.
All 462 solver tests and eight API tests pass; the two native targets/proofs pass.

`tools/run_joint_driver.py` runs an existing validation driver in a process with
joint routing for every hole-bearing expression. It preserves the ordinary
no-hole checker and never retries a failed joint solve under legacy inference.
It restores routing and command-line arguments on exit. This is a validation tool,
not a production mode or a fallback policy. Reproduce the higher-carrier checks and
the existing topology native checks with:

```sh
LAKE=lake python3 tools/check_joint_higher_targets.py
LAKE=lake python3 tools/run_joint_driver.py studies/topology/verify_exact_sequences.py
LAKE=lake python3 tools/run_joint_driver.py studies/topology/verify_homology_sequence.py
LAKE=lake python3 tools/run_joint_driver.py studies/topology/verify_mayer_vietoris_maps.py
```

These drivers regenerate their existing tracked study artifacts. Production default
routing remains unchanged pending wider compatibility and inference coverage.
Joint-routed topology native validation passed: fifteen exact-sequence targets and
eight proofs, eighteen homology-sequence targets and five proofs, and nine
Mayer–Vietoris-map targets with one composition-to-zero proof. These 42 targets
and 14 proofs supplement the two new universe targets/proofs. Regeneration also
refreshes stale ExactSequences Lean fixtures to the existing quoted-identifier
bindings; the paired legacy/joint document comparison remains identical.

:::

:::llm gpt-6 2026-11-11 role=assisted

## Direct lambda application with a common determined codomain

A scalar compatibility probe exposed the formerly incomplete expression:

```clean
(function(x: Natural,x+1))(2)
```

The joint path now opens the lambda and prepares its body rows without selecting
or defaulting them. Each row is saturated using its existing constraints; refuted
rows are removed, while incomplete checks propagate. Every remaining body result
type must be ground and reconstructible from checked caller representatives and
nominal declarations. All those types must agree, and their retained source
references must not depend on the lambda's own local binder. This establishes a
common ordinary function type from the explicit domain and checked codomain.
It does not select a body interpretation.

The original body rows and reconstruction operation then enter the enclosing
application product alongside its argument rows. Only the outer selector chooses
literal interpretations and applies simultaneous defaults. Reconstruction retains
the lambda, including its selected body syntax, and checks the whole application;
it does not emit a beta-reduced replacement. Operator-input ambiguity in the body
still blocks selection, even if every operator alternative returns the same type.

Unknown or competing codomains, unresolved type representatives and codomains that
retain the bound local remain incomplete. In particular, a bare-zero body with
unresolved parameterized-zero alternatives is not defaulted independently to force
a common codomain. General dependent/contextual lambda-result inference remains a
separate integration obligation. No parser or default production routing change.

The API tests cover the example with independent child selection forbidden,
domain mismatch, preserved operator ambiguity and an unresolved-codomain boundary.
An additional test compares 29 small scalar expressions against a flat exhaustive
literal-assignment oracle, including negative and ambiguous cases. The native
scoped driver adds an independently authored exact lambda-application target and a
proof that this particular closed application equals three.
Validation: all 462 solver tests and thirteen API tests pass, including the
29-expression exhaustive comparison. All eighteen scoped canonical Lean targets
and eighteen interpretation proofs pass. The broader topology compatibility sweep
remains running; completed entries are observations only, not a completed suite.

:::

:::llm gpt-6 2026-11-11 role=assisted

## Translator-facing joint error boundary

`cleanlang.numeral_inference.complete_joint` adapts the packaged solver to the
translator's error interface while leaving `complete` as the existing default.
Hole-free inputs use the ordinary checked elaborator and expected-type check.
Hole-bearing inputs invoke the joint API once; a failure is never retried under
legacy inference. The returned retained expression is unchanged.

| Joint outcome | Translator-facing outcome |
|---|---|
| `Incomplete` | `IncompleteNumeralAnalysis`, preserving the cause |
| `NoSolution` | `CleanError` identifying inconsistent numeral interpretation |
| `DefaultConflict` | `CleanError` identifying conflicting simultaneous defaults |
| `Ambiguous` | `CleanError`; final interpretation count when available |
| `Underdetermined` | `CleanError` identifying unresolved interpretation parameters |

`DefaultConflict` is a structured `NoSolution` subtype. `Ambiguous.interpretations`
is populated only after exhaustive saturation/default processing leaves multiple
fully determined rows; it is not a count of an interrupted search. Operator-audit
ambiguity without a complete row count retains its explanatory diagnostic.
The adapter does not match diagnostic strings to decide an outcome.

No-solution and default failures are not converted into a trial-owned
`SignatureMismatch`: doing so could incorrectly authorize a surrounding checker to
discard a competing candidate. Existing owned mismatches from checking assigned
expressions and foreign checking errors retain their identities. The adapter does
not change an enclosing trial owner. The lower-level joint API still exposes its
analysis exception classes directly.

`tools/run_joint_driver.py` now routes through this translator-facing entry point.
`tools/check_joint_runtime.py` runs 115 regression cases in one isolated process:
113 original tests are unchanged; two obsolete limitation expectations are replaced
by named positive checks for a long determined binder and inferred vector zero.
Neither case is skipped. The ordinary default-route tests remain unchanged.

The 115-case runtime slice passes, as do nineteen API/adapter tests and the thirteen
legacy numeral tests under ordinary routing. The adapter tests check retained target
agreement, complete ambiguity counts, incomplete propagation without fallback,
no forged trial ownership, and preservation of assigned-expression mismatch owners.
This is a migration boundary, not a switch of the production default or proof of
full compatibility.
All 462 solver tests also pass with the structured exception metadata. The ongoing
full topology sweep is separate and remains incomplete; default-routing completion
is not inferred from this bounded regression slice.

:::

:::llm gpt-6 2026-11-11 role=assisted

## Expected scalar results for directly applied lambdas

A direct lambda application may use a checked closed nullary nominal expected
result type to constrain its body before the enclosing joint solve. For example,
checking `(function(x: Natural,0))(2)` against `Real` checks the lambda against
`Function(Natural,Real)`. The body's zero is inferred as Real and its argument as
Natural; neither is independently selected or defaulted. The same rule applies
when an explicit module parameter supplies that result expectation.

The propagation rule is deliberately limited to `Type` carriers with no arguments.
It does not infer a codomain family from one application result. In particular,
an expected `Vector(n,Complex)` must not force an otherwise unresolved lambda to
return a constant dimension n: a dependent codomain would need contextual recovery.
For indexed/local/dependent expectations, preparation uses the existing independent
common-codomain discovery, then checks the enclosing result. Thus a lambda body
whose module signature already determines `Vector(n,Complex)` still works, while
a bare-zero body with that indexed expectation remains incomplete.

The expected type only contributes constraints. The existing body operator audit
still rejects two overloads accepting the same inputs, even if their result types
differ and only one matches the expectation. Captured source references and the
common-codomain check remain unchanged. There is no grammar change and the default
translator is not switched.

Five API cases cover Real context without inner selection, a module-provided
context, rejection of constant-codomain guessing, independently determined indexed
results, and preservation of operator-input ambiguity. Two additional independent
Lean targets check the Real and Complex lambda applications, with interpretation
proofs. The scoped native driver now has twenty target/proof pairs.
Validation: all 462 solver tests and 24 API/adapter tests pass on the final guarded
rule. Twenty scoped canonical targets and twenty interpretation proofs pass.
Reference HTML IDs/local links and provenance checks pass. The full topology sweep
remains live on its final input and is not yet a completed compatibility result.

:::


:::llm gpt-6 2026-11-11 role=assisted

## Completed topology sweep and comparison input checks

The earlier full sweep has now completed: all 23 topology result documents,
containing 100 results, generated identical Lean under legacy and joint routing.
`Common.clean` was the only non-comparison because the former loader required
results. The complete historical observations are retained in
[compatibility.json](compatibility.json), including that error. The run spanned
changes from `0bd7da8` through `b388ec9`; it is accumulated diagnostic evidence,
not a single-revision acceptance gate.

`tools/check_joint_compatibility.py` now recognizes declaration-only modules and
emits their definitions. It still rejects malformed result documents. Workers
fingerprint compiler Python, this driver, repository `library`/`corpus`/`studies`
Clean sources and the direct input before and after translation. A changed sample,
different worker snapshots, or missing fingerprints cannot count as agreement.
These hashes exclude external import closures and dependency trees and cannot
detect a transient edit restored between samples; they are not filesystem isolation.

Six harness tests cover nonempty module emission, malformed-document rejection,
mutation invalidation, different worker inputs despite matching output, missing
historical fingerprints, and edits to an external direct input. These tests check
the quality of the report, not mathematical correctness. The default translator
continues to use legacy inference, and unresolved contextual/dependent inference
boundaries remain open.
:::


:::llm gpt-6 2026-11-11 role=assisted

A fresh comparison with source fingerprints passes for `Common.clean`,
`ExactSequences.clean`, `HomologySequence.clean` and `MayerVietorisMaps.clean`:
one declaration-only module and eleven results, with identical generated text
and matching unchanged source samples in both workers. The report is retained in
`studies/parameterized-literals/compatibility.json` under
`topology_fingerprinted_modules_and_sequences`. This check translates statements;
it does not rerun their proofs or establish canonical-target equality.
:::


:::llm gpt-6 2026-11-11 role=assisted

The four corpus documents also pass the updated comparison with matching unchanged
source samples: 92 result statements generate identical text. This fresh run does
not use `--verify-corpus`; the earlier 92 proof checks remain separately recorded.
The new `corpus_fingerprinted` report must not be read as rerunning those proofs.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Direct lambda applications with dependent results

Given an explicit declaration `indexed zero(k: Natural,z: Real)` returning
`Vector(k,Complex)`, the joint API now accepts:

```clean
(function(k: Natural,indexed zero(k,0)))(n)
```

The body determines the family before application. Its zero is Real from the
module signature; the result is `Vector(n,Complex)`. A declaration returning
`Vector((k+1),Complex)` similarly yields `Vector((n+1),Complex)`. The generated
Lean retains `(fun k => indexedZero k realZero) n`; it does not beta-reduce the
source application or guess a constant result type.

Common-codomain discovery uses each ordinary body's own computed-index evidence.
The existing dependent-function abstraction and checked-argument substitution
provide the unique type. All alternatives still join the enclosing solve without
child selection or defaults. Distinct or unresolved families remain incomplete.
In particular, replacing the actual `n` with an unresolved `2` remains incomplete:
recovering a selected value for subsequent dependent substitution is separate work.

Four API regressions cover direct and computed families, alpha-renaming, expected
result mismatch, and the unresolved-argument boundary. Two independent native
lambda-application targets and two zero-vector proofs extend the scoped driver.
No grammar or production-default change is made.
:::


:::llm gpt-6 2026-11-11 role=assisted

Validation of the dependent-codomain change: 462 solver tests, 34 joint API/adapter/
compatibility-checker tests, and the 115-case runtime migration suite pass. The
scoped native driver passes 22 independent canonical targets and 22 interpretation
proofs. HTML IDs/local paths and provenance checks pass. These bounded checks do
not establish general contextual inference or completion of the topology papers.
:::
