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
zero-vector index. The production compiler is unchanged in this step. Existing
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
and full candidate-validity checking remain open. Projection evidence currently
covers preceding constructor fields, not computed references to structure
parameters whose argument fragments are not retained on the projected base.

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
