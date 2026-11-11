:::llm gpt-6 2026-11-07 role=assisted

# Topology implementation and acceptance audit

This is an audit checkpoint, not a completion claim. The maintained specification
and executable fixtures are authoritative; historical milestone paragraphs and
catalog entries must not be read as a current all-green report.

## Current checkpoint: 2026-11-11

The working compiler, including value-dependent scoped prefixes, has the following
newer evidence. The older
milestone counts below describe their own snapshots and are not cumulative
current-revision validation.

| Area | Current evidence | Still open |
|---|---|---|
| Relative and ordinary homology | [Clean-authored comparison maps](relative-ordinary-comparison.md), with six canonical targets and four inverse/naturality proofs; canonical pair-inclusion maps are used | Level-specific perturbation diagrams and image transport |
| Level-set application | [Three assembled comparisons](level-homology-comparison.md), with four exact targets and three application proofs plus four generic helpers; nesting and zero inclusion are proved, not assumed | Identifying separately named fiber/band spaces, well-group equality and cover/excision |
| Explicit joint API | Scoped proof lambdas, implicit domain recovery and value-dependent argument prefixes; nineteen native targets/proofs in the [evidence driver](../../tools/check_joint_proof_targets.py), 79 API/adapter/checker tests, 462 solver tests and 157 runtime tests | Production routing, general backward contextual recovery and direct-lambda alternative codomain discovery |
| Corpus compatibility | All four documents produce identical legacy/joint text with stable fingerprints; all 92 corpus proofs pass after the latest change | This does not establish general target uniqueness or full regression |
| Full Python discovery | Immutable full jobs are running. The alphabetically first class loads active labels in `setUpClass`, before unittest prints a test name | No full discovery pass at the current revision |
| Complementary Python discovery | A separate immutable `f84aa3b` run contains the other 1,234 tests and logs class setup; it excludes exactly the four `test_active_labels` cases | The run has recorded failures and is still running; it cannot substitute for the preserved full jobs |

The complementary run has exposed two distinct failure classes. The similarity
and BibTeX specimens still use unannotated vector zero, which production numeral
completion cannot infer. This is the previously documented integration gap in
[the literal study](../parameterized-literals/README.md), not a passing example.
Several tests also retain obsolete expectations for pre-module Lean operators,
unquoted source locals, or old LaTeX grouping. The evidence/local-shadowing and
basic precedence assertions have been migrated to explicit native wrapper calls
and quoted locals. Their assertions still check the actual statement body;
finding an imported function declaration alone does not establish call resolution.
The original examples remain unchanged and still fail under production routing.
Updating stale oracles does not fix or waive the missing inference support.

Focused validation after these oracle repairs: 42 tests pass across
`test_callable_evidence`, `test_evidence`, and the three core precedence/grouping
tests. This is Python translation evidence, not a new kernel proof or a full-suite
pass. No parser, elaborator, example, or production-routing change is part of this
repair. The full immutable runs retain their original test versions and results.

The isolated joint-runtime driver now also runs all 42 core theorem tests,
including the unchanged similarity source. Its expanded 157-test run passes.
The core cases check named matrix application and scalar multiplication wrappers,
dependent dimension rejection, local-definition order, metadata and rendering.
The driver retains its two documented positive replacements for legacy inference
limitations; it does not patch production routing outside its own process.
Run `python3 tools/check_joint_runtime.py` to reproduce this scoped result.
This improves migration evidence but does not establish full integration or
discharge the remaining dependent-signature analysis boundaries.

The same regression run exposed an obsolete local-name expectation in
`test_local_conversion`. Its repaired oracle checks that `R` remains a named
local chain complex in both indices of `ChainMap`, and that its `let` precedes
the map binder. All ten local-conversion tests pass after that repair.

The value-dependent-prefix change carries every checked argument interpretation
through later parameter types and the result, instead of rejecting such
dependencies before enumeration. It covers literal and computed dimensions,
dependent proof results, and instantiated chained-call heads. A result expectation
may distinguish literal interpretations; declaration-distinct competitors remain
ambiguous without such a constraint. Prefix checks do not select or default a
child. An unavailable competitor still forces incomplete analysis. See the
[constructive rule](../../docs/spec.md#value-dependent-scoped-argument-prefixes).

Validation comprises a 71-case API/adapter/checker run plus one added global-default
origin case; 462 solver tests; 157 runtime tests; and seventeen exact native
targets with seventeen proofs. Six native pairs are new. The proof-result oracle
checks the existing beta-normalized condition and the retained supplied proof
application separately. Four corpus documents have identical legacy/joint text
under stable fingerprints, and all 92 corpus proofs pass; the record is
`dependent_scoped_prefixes_corpus` in the compatibility report. Full discovery
for the new compiler remains pending; earlier immutable jobs are preserved and
do not validate this change. These checks do not enable production routing.

The separately recorded local/module-resolution mismatch is now repaired. A local
assumption `h: n=n` no longer hides a module function
`h(g: Function(Real,Real)): Real` when completing `h(function(x: Real,0))`.
The scoped path uses the same callability predicate as ordinary elaboration and
the unscoped builder. Callable locals still take precedence, and a local domain
or arity error never retries the module. Parentheses around a bare name normalize
to the same Call node; actual chained Apply nodes always use their checked head.
See [the resolution rule](../../docs/spec.md#scoped-call-local-precedence).

This repair passes 79 API/adapter/checker tests (seven added), 462 solver tests,
157 runtime tests, and nineteen independent native targets with nineteen proofs
(two added pairs). The explicit source-tree tests distinguish grouped bare names
from chained applications. Four corpus documents retain identical legacy/joint
text with stable fingerprints; all 92 corpus proofs pass. The new record is
`scoped_call_resolution_corpus`. Production routing remains unchanged, and full
regression for this compiler remains pending.

The latest comparison optimization makes optional memo snapshots independent of
physical sharing while preserving exact structural values. It passes 114 focused
checks, 462 solver tests, 157 runtime tests, twelve native targets/five proofs,
and the 92-proof corpus. The controlled two-expression case needs one
normalization instead of two, with identical keys. See the
[comparison report](../../docs/comparison-token-cache.md#sharing-independent-comparison-snapshots).
This does not establish full-study throughput or complete regression.

Comparison optimizations preserve the public source recheck and exact target
rules. Controlled fixtures reduce repeated work, but bounded active-label
observations still end without completing the selected declaration. There is no
current end-to-end performance or full active-label validation claim.

The latest corpus/diagnostic records are in
[the scoped compatibility report](../parameterized-literals/compatibility.json).
The new complementary run's authoritative process metadata is
`/tmp/clean-complementary-current.json`, with its log at
`/tmp/clean-complementary-current.log`. These paths identify this session's run,
not portable proof artifacts or a permanent pass result. Empty full-suite logs
alone do not prove import failure, deadlock or termination: class setup can be
running before the first test report.

## Implemented language and module interfaces

| Requirement | Concrete implementation and acceptance evidence | Remaining boundary |
|---|---|---|
| Named fields and constructors | `library/algebra/module_diagrams.clean`, `library/diagrams/interval_bases.clean`; structure, diagram-map and zigzag studies | Carrier-type fields are integrated with bounded universes; general universe polymorphism remains unsupported |
| Dependent callable signatures and indices | Dependent-function, computed-index and inferred-conversion studies; explicit stored implicit arguments | General higher-order conversion and normalization inside binder bodies are not claimed |
| Named conditions usable as evidence | Callable-evidence study: 21 exact targets and 15 proofs; captured scopes and local/module resolution have negative tests | Opaque native conditions do not acquire callable views; broader validation is pending |
| Definition bodies authored in Clean | Topology images/preimages/continuity, relative quotient constructions, well-group intersections, diagram pullbacks, subpaths and clipping | Imported foundations remain explicit; mathematical constructions listed below are still missing |
| Deterministic parsing | Generated grammar with strict LALR/lexer checks, independent source trees, explicit layout and metadata interpreters | Module-declared arbitrary operator syntax is not implemented; handwritten layout and metadata rules still need their own tests |
| Precise selected Lean targets | Canonical native declaration comparisons retain arguments, universes, instances and proof terms; the new basic-identity checker tests four legal source variants | General operator/literal/native-adapter contract and resource-outcome integration remain open acceptance obligations |
| Readable statements and LaTeX | Local names, explicit contexts, conditions and descriptive type metadata; subpath and clipping PDFs compiled twice and inspected | The offline browser refresh and its inventory/UI checks are pending |

The basic identity checker is `LAKE=lake python3 tools/check_basic_targets.py`.
It verifies the normalized statement tree, including attribution, binding and
conclusion, then compares generated declaration types and bodies with independently
written identity statements over the selected Real wrapper, whose body is separately
checked against `ℝ`. Local renaming, keyword case, prose type spelling,
indentation, continuation, grouping and comments cannot change that target.
A definitionally equal alias is deliberately rejected by the canonical comparator.
This is a concrete acceptance slice, not a proof of general elaboration uniqueness.

The acceptance catalog retains historical pending lists where follow-up cases now
implement part of an older obligation. Follow-up links do not erase the newer
case's own limitations or substitute for its outstanding validation.

## Current validation evidence

The [working-compiler binding migration](binding-migration.md) adds 405 exact
native targets and 89 proofs, including two universe rejection checks. Focused
Python validation is scoped in that report. Broader discovery
is still in progress; the older counts below retain their historical scope.


- The pre-callable compiler passed 584 Python tests. That count does not validate
  later compiler changes.
- The first callable-evidence snapshot finished its 33-study native run with 32
  passes and one failure: `studies/diagram-maps/verify.py`. Unnecessary callable
  classification reached an internal application that lacked a supported source
  spelling. Its full Python run also recorded a diagram-map setup error and is
  now stopped as superseded; it must not be reported as passing.
- The newer selected-field snapshot has passed the diagram-map study's 15 exact
  targets and six proofs. Its complete native portfolio has now passed all 34
  studies; see the [durable validation record](validation-2026-11-07.md). Its full
  Python run terminated with status 143 during review collection, without a final
  unittest summary. It is not a passing result.
- Before the latest codomain fix, main passed the subpath study's 19 exact targets
  and six proofs, and the initial clipping study's eight exact targets and three proofs.
  The corrected label-rendering regeneration passes the zigzag study's 46 exact
  targets and six proofs. The 92-proof corpus was checked after the compiler change.
- The known-codomain substitution fix passes 108 focused regressions. The expanded
  clipping study passes 14 exact native targets, three proofs, and seven Python
  checks, including the authored restricted-label record. A new frozen full-suite
  run is pending. The 92-proof corpus recheck and rebased operator prototype
  (16 targets, two proofs) pass; earlier portfolio results do not validate
  this later compiler change.
- Chained application is now implemented. The isolated implementation passes 227
  focused regressions; main passes eight exact targets, five proofs, nine postfix
  tests, parser reproducibility and the 92-proof corpus recheck. The frozen full suite was superseded by a corrected obsolete syntax assertion
  and the generic subtype refactor; a new complete run is still required. This
  does not validate general native-binding uniqueness.
- The active-label study has authored maps and a support record, but its instrumented
  verifier crashed during translation (status 139). That source was superseded by a generic subtype construction, which passes ten
  exact checks, three proofs and five Python tests. The refactored interval
  translation and earlier verifier remain active; the native-oracle arithmetic support and existence theorem now pass separately.
  Full generated interval-target comparison remains pending.
- The browser build using the pre-postfix compiler was stopped as superseded.
  A new build, source-hash validation and UI checks remain pending.

## Mathematical constructions still missing

| Requested theorem | What is real now | What is still missing |
|---|---|---|
| Big Steps, Theorem 9 | Indexed records and ordinary set/function definitions can express its inputs and support predicates | Filtered complex, lazy reduction, the actual algorithm run and its invariants; the two sides must be computed independently |
| Interlevel, Theorem 1 | Explicit diagrams, interval bases, subpath restrictions, endpoint clipping, surviving-label support and restricted label records, and a checked generic basis-reindexing wrapper | Full generated-target comparison for the native-checked surviving active-label equivalence; basis reindexing and compatibility, pyramid construction, exact-diamond basis flips and extension proof |
| Interlevel, Theorem 3 | Actual singular-homology, perturbation and shifted-image foundations; level fibers/bands, explicit emptiness certificates, and assembled relative-to-ordinary comparisons | Named fiber/band identifications, a level-specific naturality/image diagram, and the two-extreme-perturbation formula with justified cover hypotheses |
| Interlevel, Theorem 4 | A translated two-image candidate over actual relative objects; checked supporting inclusion maps | Reverse inclusion and the cover/excision audit; no proof is claimed by translating the candidate |
| Mayer–Vietoris | Graded objects/maps, ordinary/relative chains, [actual inclusion-induced maps with zero composite](mayer-vietoris-maps.md), [binary module sums](module-products.md), and the [checked exact-pair/interior/terminal interface](exact-sequences.md) | The actual cover-based chain sequence and its connecting map, endpoint/augmentation data, excision and the Mayer–Vietoris long-exact-sequence proof; generic chain connecting maps alone do not establish these |

These missing mathematical objects are not supplied by opaque names or assumptions
of the desired conclusion. Conversely, a missing paper proof does not establish a
parser defect. Each new construction should first be attempted with the existing
Clean definitions, conditions, structures and explicit foundation modules; a
failure to express it must be recorded as a language gap with a concrete specimen.
:::

:::llm gpt-6 2026-11-11 role=assisted

The working compiler now supports classifier-declared parameters of records,
native type constructors and aliases at closed higher universes. The
[parameterized record specimen](../universe-classifiers/ParameterizedRecords.clean)
stores a TopologicalSpace under a declared Type-1 carrier parameter. The
[contract](../../docs/classified-parameters.md) records the exact mapping and
validation boundary. This addresses the earlier closed generic-parameter gap;
it does not supply missing topology constructions or general universe polymorphism.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Reconciliation of later study evidence

The earlier mathematical-gap table predates two study milestones and must not be
read as their current implementation inventory. The
[interval-basis restriction study](../interval-basis-restriction/README.md) contains
pointwise basis transport, full restricted-record assembly, four canonical targets,
and proofs of both generated results. The
[active-label study](../active-labels/README.md#current-specialized-validation)
records fifteen exact checks and four proofs against its retained generated
snapshot. Those historical snapshot checks do not validate every subsequent
compiler change. Current full regeneration and Python discovery remain running;
no completion is inferred from their elapsed time.

The working compiler now additionally checks three
[basis transport laws](../basis-reindexing/Composition.clean): composition,
identity, and reversal. Their [driver](../basis-reindexing/verify_composition.py)
passes three independent exact statement targets and three proofs. These laws use
existing explicit modules and Clean-authored equivalence constructions. They
provide algebraic consistency for repeated label transport, without asserting
geometric restriction composition or a pyramid/basis-extension theorem.

The remaining research mathematics still includes basis extension and pyramid
construction, filtered complexes and lazy-reduction invariants, well-group reverse
inclusions and cover/excision, and the Mayer–Vietoris connecting sequence. These
are distinct from unfinished production joint inference and validation.
:::

:::llm gpt-6 2026-11-11 role=assisted

The [algebraic homology sequence study](homology-sequence.md) now exposes
Mathlib's connecting map for a short exact chain sequence. Its two adjacent
composites and induced-map names are authored in Clean, with eighteen
canonical-target comparisons and five native proofs. Three of those proofs
establish range-equals-kernel exactness at the adjacent homology objects. The missing Mayer–Vietoris connecting sequence above refers
to the geometric construction and its identification/exactness, not the absence
of a generic algebraic connecting map. These checks add no new syntax and do not
resolve the broader inference or full-regeneration validation obligations.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Joint inference integration evidence

The solver is now installable through an explicit API and has a translator-facing
error adapter. Default production routing remains unchanged. Closed nominal
higher-universe carriers are supported in the joint path; the exact-sequence,
homology-sequence and Mayer–Vietoris-map drivers passed under isolated joint routing
with 42 canonical targets and 14 proofs. Those are the same algebraic/wrapper claims
as before, not additional geometric paper theorems.

The [inference study](../parameterized-literals/README.md) records native oracles,
corpus comparison, runtime migration checks and remaining contextual/dependent
inference boundaries. In particular, a scalar result expectation may constrain a
directly applied lambda, but an indexed application result must not be used to
invent a constant codomain family. The completed all-topology comparison is recorded below; it does not establish
canonical-target conformance or justify changing production inference routing.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Completed topology text comparison

The historical full sweep completed with identical generated Lean for all 23
result documents (100 results). The old document-only loader could not compare
`Common.clean`, which contains declarations and no results. Its error is preserved
in [the evidence record](../parameterized-literals/compatibility.json).

This sweep ran while revisions from `0bd7da8` through `b388ec9` landed. It has no
source fingerprints and is not evidence for a single immutable compiler revision.
The checker now handles declaration-only modules explicitly, without treating an
invalid result document as a module. Before/after source fingerprints detect
observed changes during a worker and disagreement between the two workers' inputs.
The snapshots cover compiler Python, the driver, repository Clean sources and the
direct input; they do not capture arbitrary external imports or dependency trees,
nor detect an edit restored between samples. Generated text equality remains
separate from the 42 canonical targets and 14 native proofs recorded above.
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

Joint preparation now preserves a directly applied lambda's determined dependent
codomain, including computed indices such as `Vector((k+1),Complex)`. Checked
actual arguments substitute into the family; unresolved literal-bearing actuals
remain incomplete. This is an inference improvement for existing dependent-call
syntax, with two additional independent Lean targets and zero-vector proofs in
the scoped-call driver. It adds no topology theorem or implicit mathematical
binding. Production routing and general contextual recovery remain open.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Concrete open-cover inputs

[Open subsets and certified covers](open-covers.md) now provide Clean records for
subsets with openness evidence and ordered binary covers with explicit coverage
evidence. Coverage and intersection construction are authored in Clean; the only
new native adapter imports Mathlib's `IsOpen.inter`. The proposed Mayer–Vietoris
statement uses `OpenCover(X)` and explicit coefficients. Its geometric sequence
and excision/identification proofs remain missing; supplying its inputs does not
establish exactness or any paper theorem. This adds no language syntax.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Cover maps with the ambient homology target

The [cover-homology study](cover-homology.md) now defines the signed intersection
map and the sum of inclusion-induced maps into H(X), using the certified open-cover
record. These are Clean definitions over the real singular-homology functor; a
continuous subtype inclusion is the only new foundational native adapter. Their
zero composite is proved by functoriality and cancellation, which does not require
openness or coverage. The geometric exactness and connecting-map obligations above
remain open. No language syntax or inference default changes are made.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Active-label joint-routing probe

A frozen `dceffc1` joint-routing run stopped on a checked evidence argument in
`subpaths.clean`. Joint proof-carrier encoding and forward proof-type substitution
now get past that failure. A separate patched snapshot next stops in interval
clipping on a scoped consumer with implicit parameters. Full active-label
regeneration under joint inference therefore remains incomplete. This is a concrete
inference integration gap, separate from the native-checked historical snapshot
and from the mathematical basis-extension theorem.
:::


:::llm gpt-6 2026-11-11 role=assisted

The patched joint snapshot also translates the six subpath statements; its generated
declarations pass Lean and match legacy routing text. The standalone subpath
canonical/proof verifier fails on unresolved target names, body comparisons and two
proof goals. Its older nineteen-target/six-proof pass is historical evidence, not a
current gate. Independent oracle/proof migration and revalidation remain required.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Subpath verifier repair

The [subpath verifier](../subpath-restrictions/README.md#current-verifier-migration)
now uses binding identities for declaration lookup and independent expected terms
with the current explicit wrappers. Its endpoint proofs unfold those wrappers
before finite-index arithmetic. The earlier failing probe is preserved as historical
evidence. This repairs the verifier; no language rule or mathematical statement
was changed. The active-label scoped-implicit inference gap remains separate.
:::


:::llm gpt-6 2026-11-11 role=assisted

Validation of the repaired verifier passes under both ordinary and isolated joint
routing: the same nineteen exact targets, six proofs, and one rejection of a
definitionally equal alias. These are overlapping checks, not 38 distinct targets.
The regenerated one-page PDF compiled twice without overfull boxes or unresolved
references and was visually inspected without clipped or overlapping text. The
report is retained in `studies/parameterized-literals/compatibility.json` under
`subpath_verifier_repaired`. The active-label implicit-signature gap remains open.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Scoped implicit recovery from source annotations

Joint inference now recovers declared implicit parameters from checked argument
types and explicit outer lambda domains. This handles the set-builder shape used
by surviving interval labels, without choosing/defaulting body alternatives. Native
checks cover the set-builder, a checked sibling and an indexed lambda domain.
The source-ordered representative and reconstruction rules are documented in the
[inference study](../parameterized-literals/README.md#scoped-implicit-recovery-from-checked-arguments).

The active-label rerun remains live in its own snapshot. It has no completed result;
this focused implementation does not establish full active-label validation or the
paper's basis-extension theorem. Broader contextual inference and production joint
routing remain open.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Existing callable assumptions in joint scoped calls

A checked universal assumption can now accept a lambda containing literal holes
in the explicit joint path. The solver reads the assumption's source-derived
callable view and emits the original proof applied to the checked argument.
Returned implication evidence can be applied again. Two new independent native
targets/proofs and API boundary tests cover this integration; all 462 solver,
51 API/adapter/checker, 115 runtime tests and 92 corpus proofs pass. The
[specification](../../docs/spec.md#scoped-application-of-existing-evidence) records
the exact boundary: selected-value-dependent results and lambdas built against
proof expectations remain separate gaps. The full active-label snapshot is still
running; geometric basis-extension and Mayer–Vietoris obligations are unchanged.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Level-set specialization

The [level-set module and study](level-sets.md) now specialize interlevel data to
endpoints a,a with no selected endpoints. Clean definitions supply the level
problem, fiber and expanded band. Five supporting identities identify the ambient
fibers for arbitrary perturbing maps, expanded bands, shifted fibers and empty
relative subsets. No additional language syntax is required. Ordinary/relative
homology identification and the two-extreme-perturbation theorem remain separate
mathematical obligations; the strict-endpoint interlevel candidate cannot be
instantiated at a=a.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Algebraic step for empty relative pairs

[Zero chain quotients](zero-chain-quotients.md) now provide the cokernel of a zero
chain map, its projection/reduction maps and their induced homology maps. Nine
independent targets and four inverse-map proofs check the actual Mathlib
construction. This uses existing Clean syntax and one explicit foundational
adapter for Mathlib's cokernel isomorphism. The singular chains of the empty
relative subset, equality transport, compatibility/naturality and the well-group
formula remain separate obligations.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Naturality of zero-quotient comparisons

The [zero-quotient study](zero-chain-quotients.md#compatibility-with-chain-maps)
now has a Clean-authored map between zero quotients and its homology map. Sixteen
canonical targets and nine proofs cover the inverse laws, commuting comparison
squares at the chain and homology levels, and agreement with Mathlib's cokernel
map for a supplied commuting square. No new native adapter or syntax is added.
The actual empty-subspace chain identification and compatible equality transport
remain necessary before applying these results to the level well group.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Empty relative subsets give zero chain inclusions

The [empty-chain study](empty-chains.md) now proves that the actual singular chains
of an empty space form a zero object and that the actual relative chain inclusion
is zero for a pair with empty relative part. Five canonical targets, two Clean-result
proofs and a generic supporting lemma check this concrete construction. The two
foundational conditions import IsEmpty and IsZero explicitly; the relative condition
uses an authored Clean definition. Cokernel transport along the inclusion equality,
its compatibility and the ordinary-homology identification remain open.
:::

:::llm gpt-6 2026-11-11 role=assisted

The [cokernel transport study](cokernel-transport.md) supplies explicit equality
transport and Clean-authored vanishing-map reductions. Its verification scope is
five definition targets, seven statement targets and seven inverse/projection
proofs. This addresses the algebraic equality-transport step; level-set empty-part
certificates, naturality and ordinary-homology identification remain separate
obligations. It adds no syntax or implicit proof synthesis.
:::

:::llm gpt-6 2026-11-11 role=assisted

[Level empty-pair certificates](level-empty-pairs.md) now bridge the set-level
identities to the empty-relative-part premise used by singular chains. Six exact
targets and five proofs cover expanded, perturbed and shifted pair data,
nesting from emptiness, and preservation under explicit certification. This uses
the existing distinction between pair data and certified topological pairs; it
does not add an implicit conversion. Ordinary/relative homology comparison and
naturality still need assembly; the well-group formulas remain unproved.
:::

:::llm gpt-6 2026-11-11 role=assisted

The [singular homology comparison](singular-comparison.md) makes the identity
between the ordinary singular-homology functor and homology of singular chains
explicit in both directions. Its verification scope is six exact targets and
four inverse/naturality proofs. It introduces no syntax or general conversion
rule. Assembly with the vanishing relative quotient, and naturality of that
complete comparison, remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

The [relative-to-ordinary comparison](relative-ordinary-comparison.md) now
composes the vanishing quotient and singular-homology maps entirely in Clean.
Four canonical targets and two inverse proofs (with two generic chain helper
lemmas) pass. The forward map retains explicit zero-inclusion evidence; the
reverse map uses the canonical quotient projection. Naturality for pair
inclusions and a fully assembled level-set application remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

The [relative-to-ordinary study](relative-ordinary-comparison.md) now proves
naturality for the canonical relative homology map of a pair inclusion. Forward
naturality takes both zero-inclusion proofs; backward naturality does not need
these hypotheses. Both retain the explicit commutative chain square. The updated
suite checks six canonical targets, four inverse/naturality proofs and three
generic chain helper lemmas. Complete level-set certificate assembly and the
well-group/excision results remain pending. Multiword display labels remain
unavailable as bare proof arguments; this example uses `sourceZero` and
`targetZero` under the existing single-identifier evidence rule.
:::

:::llm gpt-6 2026-11-11 role=assisted

The [assembled level comparisons](level-homology-comparison.md) now construct
nesting, certification, zero chain inclusion and inverse homology maps for
expanded, perturbed and shifted level pair data. Four canonical targets and
three application proofs (plus four generic helpers) pass. The conclusions use
an existential proof binder followed by a map binder whose type depends on it.
No nesting or zero-inclusion hypothesis is assumed. Named fiber/band-space
identifications, the level-specific perturbation diagram and the well-group
formula remain pending; the target currently uses the actual ambient subspace.
:::
