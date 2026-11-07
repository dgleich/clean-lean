:::llm 2026-10-23 role=assisted

# Porting with authored Clean definitions

The October 19 checkpoint has 92 proved validation fixtures: 23 statements in each
of linear algebra, graph theory, analysis, and CLR-aligned algorithms. The twelve
new ports reuse source lemmas to exercise authored definitions; there are still
80 distinct Mathlib source declarations. These are adaptations and are tagged
accordingly. Clean itself still authors statements, not proofs.

## Definitions now authored in Clean

- Linear algebra: commutator and matrix square.
- Analysis: square, squared distance, and trigonometric energy. The latter two
  call `square`, exercising composition of Clean definitions.
- Graph theory: common neighbors (replacing its Lean body) and nonadjacency.
- Algorithms: coprimality as `gcd(a,b) = 1` (replacing its Lean body), and a sorting
  certificate as sortedness together with permutation of the input.

See the corresponding `library/*.clean` and `corpus/*.clean` files. Existing
common-neighbor and coprime results also validate the replaced definitions.
One useful failure: Lean dot notation on a coprimality hypothesis stopped finding
methods once its visible type became an equality. Explicitly naming
`Nat.Coprime.lcm_eq_mul` and `Nat.Coprime.dvd_mul_right` fixes the validation proofs
without changing the Clean statement or adding a Lean definition. Definitional
equality alone does not make every Lean surface syntax interchangeable.

## Remaining reasons to return to Lean

| Need exposed by the ports | Missing Clean facility | Next specimen |
| --- | --- | --- |
| Define degree, volume, cut weight | Module-declared binding forms with scoped lambdas and finite domains | Single/double finite sums |
| Define graph conductance | Predicate-bound minimization, finite subsets, explicit empty-domain policy | Ordinary conductance, separately from mu-conductance |
| Define function composition pointwise | Lambda/function-body syntax and bound-variable scope | Continuity of an authored composite function |
| Define insertion sort itself | Pattern matching, recursion, termination and inductive constructors | Insertion followed by insertion sort |
| State generic algebra results | Type parameters, typeclasses, explicit instance/coercion policy | Matrix trace over a general commutative ring |
| Produce full mathematical exposition | LaTeX rendering for definition declarations | Definitions preceding their results |

Existing adapters for sorting, gcd, adjacency, elementary functions, determinant,
and trace remain. No new Lean-body mathematical adapters were introduced in this
checkpoint. Importing primitives is a boundary; implementing higher-level
mathematics in adapters is a gap to remove, not the completion criterion.

## Validation boundary

The Python suite covers declaration forms, field reorder, grouped parameters,
composition, layout, missing/conflicting fields, recursion/forward references,
return mismatch, attribution, and default rendering. The 92 corpus proofs check
that the generated statements follow from the indexed Mathlib lemmas.
`verify_definitions.py` independently specifies three expression trees and three
fully elaborated Lean targets/types, comparing structure without reduction.
Its comparator also rejects changes to binder explicitness and a reducible body.

Those checks do not certify the whole language. Full declaration ASTs,
module-local import isolation, canonical polymorphic/universe handling,
ambiguous/incomplete elaboration, generic operator declarations, and structured
type lowering remain open. The acceptance catalog explicitly retains pending
obligations. Minimum's empty-domain policy is not silently chosen by this work.

Checkpoint checks: 115 Python tests pass with the BibTeX optional dependency; all
92 corpus proofs and the structural-target fixture pass Lean 4.24.0. The 14-page
LaTeX specimen compiled twice with no overfull boxes or unresolved references;
the new analysis and sorting pages were inspected. The HTML reference passed
desktop/mobile, search/filter, anchor, and no-JavaScript checks.


:::

:::llm gpt-6 2026-10-29 role=assisted

## Magnetic forward identity: proof milestone and remaining boundaries

The [magnetic proof project](../studies/magnetic/README.md) now proves the forward
Fourier identity for arbitrary walk lengths. Its phase, adjacency, and unnormalized
Laplacian are Clean `Equals` definitions. Three visible `From Lean` definitions
remain for the degree diagonal, word-profile filter/product/sum, and Fourier sum.
They require finite binders, list enumeration/filtering, and recursion; no parser
extension is claimed here. Proofs inhabit the actual translated Clean propositions.
The pinned source's inverse formula has a checked counterexample at m = 1, so its
odd-length endpoint must be resolved before porting it as a theorem.

:::


:::llm gpt-6 2026-10-29 role=assisted

The later self-contained study supersedes the three `From Lean` boundaries above:
word enumeration, profiles, degree sums, and the Fourier sum are now Clean-authored
using generic finite operations and [typed function expressions](function-expressions.md).
See [the five study artifacts](../studies/magnetic/README.md).
:::

:::llm gpt-6 2026-11-06 role=assisted

## Authored bundle milestone

Finite fixed-carrier records, constructors and dependent projections now work in
Clean. The topology bundle study authors endpoint shifting and path reversal without
Lean bodies. A field's natural dimension and an ordinary function-valued field are
also checked. The remaining representation gaps are records storing their own
carrier types (universes), proof fields/invariants, and dependent function-valued
fields. Projected values are stable indices; equating a separately named alias to
its projection still needs a future definitional-equality/transport policy. None of
these gaps justifies importing a paper-specific mathematical construction wholesale.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Subspaces and a concrete universe requirement

The explicit algebra module can define arbitrary admissible indexed intersections
as actual Submodules in Clean. Carrier projection needed an explicit `Submodule.setLike`
instance: a bare `U.carrier` attempted ambient typeclass synthesis and was replaced
with the fully specified projection. Infimum similarly supplies `Submodule.instInfSet`
explicitly. Canonical target comparisons retain these choices.

The pinned native singular-homology API takes bundled TopCat and coefficient-category
objects. Direct Lean checks confirm TopCat.{0} and ModuleCat.{0,0} K are Type 1.
The current Type binding wrapper's fixed Type-0 result is therefore insufficient.
Explicit universe metadata/type-field semantics are the next language requirement;
substituting an unstructured Type-0 name would not be a valid implementation.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Singular homology carrier interoperability

Actual Mathlib homology objects/maps now compile and satisfy identity/composition
laws through explicit Clean modules. [The study note](../studies/topology/singular-homology.md)
records an actionable gap: a named computed module's ModuleElement type is not
structurally equal to the HomologyClass wrapper. Generic linear-map ranges require
a deterministic computed-index/transparent-alias rule or an explicit typed bridge.
The current native action remains linear in Lean, but its Clean-authored lambda
exposes only an ordinary function. Relative homology and excision are mathematical
construction gaps, distinct from this source-type interoperability problem.
:::

:::llm gpt-6 2026-11-06 role=assisted

The computed-index extension now resolves generic module-map/range composition:
HomologyClass is a transparent Clean alias, and homology image is authored as the
range of the native induced linear map. The earlier carrier-interoperability gap
no longer blocks explicit computations. General local-alias conversion is still
unsupported. Relative homology, exactness/excision and paper constructions remain
open; the range-membership proof is not a well-group characterization.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Explicit evidence and certified records

[Evidence](evidence.md) specifies parenthesized conditions in type position,
ordinary `Evidence` aliases, proof-bearing record fields, and single-identifier
assumption labels usable as explicit proof arguments. This supersedes the earlier
exclusion of proof fields. Matching is structural; direct binder-bearing evidence
requires a named Condition. No implicit proof search or general Sort parameters
are introduced. Certified subset and continuous pair inclusions exercise this map.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Interlevel certificates

The [certification bridge](../studies/topology/interlevel-data.md#certification-bridge-and-an-exposed-language-gap)
now proves existence of a certified expanded pair and certified inclusions of
bounded shifts and perturbations. These results construct proof-bearing records
from the earlier inequalities, preserving all component sets. The continuous
pair maps are available through `pairs.clean`. This does not yet construct relative
homology. Direct Clean composition of certificate constructors exposes a remaining
computed-record projection/reduction gap, recorded in that same report.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Computed record projection

[Computed records](computed-records.md) supersedes the named-base-only restriction.
It specifies constructor-field reduction and explicit, binder-free authored
producer unfolding; other computations retain nominal projections. LaTeX preserves
the authored expression and is excluded from semantic index identity. The interlevel
certificate composition now works in Clean. Implicit/binder-bearing producer
reduction and local-alias conversion remain separate extensions.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Relative object construction

[Relative singular chains and homology](../studies/topology/relative-homology.md) now constructs the
relative chain complex as the cokernel of the inclusion-induced singular chain
map, and applies the homology functor in the selected degree. The definitions are
authored in Clean over generic native chain adapters. Sixteen exact target checks
and four kernel checks pass. Relative induced maps, exactness/excision and the
research theorem proofs remain unfinished; the report distinguishes definition
checks from mathematical theorems and records the computed-index conversion gap.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Induced quotient maps

[Chain squares](../studies/topology/chain-squares.md) now supplies proof-bearing commuting squares,
induced cokernel maps and induced homology maps. The pair-inclusion study proves
that the actual four singular-chain maps form such a square. Seventeen canonical
targets and two kernel-checked proofs cover these interfaces. The square witness
is explicit; packaging the relative functor and converting its computed indices
remain open, as do exactness/excision and the research targets.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Authored definition conversion

[Definition conversion](definition-conversion.md) now permits typed dependent
indices to match eligible binder-free authored expansions. It supersedes the
blanket structural-only rule for those indices. Emitted Lean terms and source
annotations retain their prescribed wrappers; comparison does not rewrite them.
Native adapters, local aliases and the documented ineligible bodies stay opaque.
The relative-map study exercises this rule with named source/target objects and
explicit commutativity evidence, checked against independent native targets.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Well-group intersections

[Well groups](../studies/topology/well-groups.md) now defines the bounded-perturbation image intersection
in Clean, with a single fixed target module. Twenty-four canonical targets and
five new proofs check the definitions, completeness and soundness of certificates,
certificate independence and membership. The study rechecks 15 supporting proofs.
Projected header indices now substitute correctly in dependent record fields.
The extreme-image theorem, exactness/excision and a Clean proof language remain open.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Composing certified pairs

[Pair composition](../studies/topology/pair-composition.md) now supplies Clean-authored identities and composition
with an explicit middle-pair equality. Generic congrArg on field-access lambdas
exposed an index-substitution gap, resolved by checked immediate lambda contraction.
Fifteen exact native targets and six proofs cover the new interfaces. This does not
supply a category instance or the relative-homology functor laws.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Shifted perturbations and images

[Shifted perturbations](../studies/topology/shifted-perturbations.md) now defines the maps f−t and their certified
homology images in Clean. Eleven canonical targets and six proofs check the sign
convention, pair equality, uniform bound, certificate existence/independence and
well-group containment in every shifted image. Twenty supporting proofs are
rechecked. Certificates remain explicit; the reverse extreme-image inclusion and
the closed-cover/excision audit remain open. No new syntax is needed for this slice.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Actual two-image expression and candidate statement

[Extreme images](../studies/topology/extreme-images.md) now authors the two certified extreme images and their
binary intersection. The full equality translates using scalar-field coefficients
in a chosen degree, but is explicitly an unproved singular-homology candidate.
Eighteen exact targets and four new proofs cover the interfaces, existence,
certificate independence and forward inclusion; twenty-six supporting proofs are
rechecked. The source's relative Mayer–Vietoris argument still needs a justified
cover/excision theorem in this model. Automatic assumption naming now handles
record fields such as P.space, with unchanged collision rejection.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Local definitions in dependent indices

[Local definition conversion](local-definition-conversion.md) now saves checked,
binder-free comparison values for local definitions. It supersedes the earlier
blanket local-alias restriction. Emitted Lean lets, authored names and inferred
annotations are preserved; ordinary variables and assumed equalities remain opaque.
The relative-homology specimen checks two exact native propositions and two proofs.
Binder-bearing local definitions and general dependent functions remain open.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Typed dimensions

[Dimension indices](dimension-indices.md) migrates declared Natural slots to the
same checked value-index comparison and substitution mechanism. Local dimension
aliases now work; calls explicitly supply their inferred dimensions. Repeated
consistent inference uses the last occurrence in declared traversal order.
Five canonical targets and four proofs cover readable examples. Generic dependent
functions, broader literal inference and the topology research obligations remain open.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Dependent function type staging and graded objects

[Dependent function types](dependent-function-types.md) specifies the selected
bound-domain form and its intended scope, alpha-equivalence and Lean mapping.
The initial implementation now translates dependent fields and inferred lambdas.
[Graded maps](../library/algebra/graded_maps.clean) are authored records; their
identity and composition are authored Clean definitions using explicit Mathlib
module identity/composition adapters. Eleven canonical target comparisons and
three proofs validate the generated graded-map statements. Type-valued binders,
additional proof/universe acceptance cases, and lambda-bearing producer conversion
remain separate work. The ordinary graded-object study retains its seven targets
and component proof; neither study proves a paper theorem.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Applied producer fields and induced graded homology

[Hygienic producer conversion](hygienic-producer-conversion.md) extends comparison
through explicit authored function-producing definitions and applied fields.
Capture-free substitution includes type annotations and nested binders. Residual
binder-bearing comparison values and shadowed module bindings stay opaque.
Computed-object field calls now serialize using the existing grammar.
The induced graded-homology map is authored in Clean, with four exact native targets
and three functor-law/component proofs. General higher-order conversion, inferred
body parameters, and unapplied family comparison remain outside this profile.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Proof-valued function sorts

[Proof-valued functions](proof-valued-functions.md) extends the explicit arrow
interface to proof operands in both ordinary and bound forms. Proof-sort checking
now follows the codomain of ordinary/dependent arrows, and every Type-parameter
gate rejects these proof families. No lift or general native-sort inference is added.
Ten exact targets, five native sort assertions and five proofs cover finite,
empty/singleton, proof-domain and higher-universe domain examples. General universe
inference and Type-valued binders remain outside the current profile.
:::

:::llm gpt-6 2026-11-06 role=assisted

A negative [universe-boundary probe](proof-valued-functions.md#confirmed-remaining-universe-boundary)
originally confirmed that a Type 1 CoefficientModule carrier could be inferred for a
native wrapper requiring Type 0. Clean accepted that input while Lean rejected the
emitted application. The closed-universe checks below now reject this case in Clean;
the earlier proof-family sort checks alone did not enforce that bound.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Closed universe parameter and field bounds

[Closed-universe checking](closed-universe-checking.md) now enforces the declared
Type 0 carrier bounds in constructor arguments and both callable inference paths.
It computes closed imax levels for ordinary/dependent arrows from declared metadata.
Structures check their fields against the stated result universe before publication.
No target, lift or universe is chosen implicitly. The formerly accepted module-carrier
counterexample is rejected by Clean. Fourteen exact native targets, four sort checks
and three proofs cover supported higher-universe values, arrows and proof fields.
General universe polymorphism and Type-valued binders remain separate work.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Authored families in dependent indices

[Family index comparison](family-index-comparison.md) now materializes a residual
binder-bearing normal tree in one checked scope for its comparison key. Authored
family aliases can agree without changing emitted names or introducing direct
binder syntax in indices. Native bodies, binder-body normalization and general
higher-order conversion remain outside this rule. The graded relative-homology
study checks ten exact targets and five proofs; its constructions are authored in
Clean over generic chain-homology adapters.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Stable saved family keys

[Scoped family keys](scoped-family-keys.md) replaces residual binder-template
comparison with immutable owned/free identity tokens. A private, globally fresh
comparison pool covers expression and dependent type binders; nested comparisons
preserve external binding references and restore allocation context on failure.
Unrelated later locals no longer invalidate saved family indices. Emitted Lean and
existing conversion boundaries remain unchanged. Two exact saved-map propositions
and two proofs cover graded chain and relative homology.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Constant dependent arrows and zigzag bases

[Constant dependent arrows](constant-dependent-arrows.md) specifies symmetric
comparison and callable matching when a checked dependent codomain becomes
constant, while retaining the declared Lean Pi binder. Opaque binder-bearing
producer projections retain their checked form unless a field can be selected.
The [zigzag study](../studies/zigzag-bases/README.md) supplies actual module
diagrams and interval-basis data, with a constructed constant-zigzag example.
Inferred type-parameter helpers avoid new type-as-value syntax. General pyramid
basis extension, higher-order conversion and universe polymorphism remain pending.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Diagram maps use existing syntax

The [diagram-map study](../studies/diagram-maps/README.md) authors a dependent
vertex-map family, its edge-square commutation condition, and certified identity
and composition records. No grammar, inference or emission rule changed. The
existing constructor/projection reduction rule selects component families from
explicit certified producers; exact native oracles preserve that target choice.
Evidence is explicit, with universal identity/composition conditions proved in
Lean. Fifteen exact targets and six proofs cover this interface; it is not an
automatically generated category instance or a pyramid construction.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Shape maps and explicit endpoint transport

The [shape-pullback study](../studies/shape-pullbacks/README.md) uses existing
dependent proof fields, equality adapters and module-declared calls. Shape identity,
composition and diagram reindexing are authored in Clean; the only new native
primitives are Eq.symm, Eq.trans and module-family transport via Mathlib eqToHom.
No grammar, inference or emission rule changed. Twenty-four independent exact
targets and nine proofs cover the interface, including pullback composition.

Short calls infer Type parameters but keep field/shape values explicit. They
retain the existing inferred-body opacity boundary: projected modules from short
and explicit forms may compare differently as computed Clean indices, even when
Lean reduces them to the same module. A negative regression records this open
conversion gap. Arbitrary shape pullbacks do not preserve interval support; actual
subpath restriction needs a chosen inclusion and explicit label reindexing.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Checked inferred arguments in authored conversion

[Inferred-argument conversion](inferred-argument-conversion.md) specifies how
already selected implicit arguments enter hygienic comparison expansion. Named
Type values, type annotations (including dependent types), and natural dimensions
have deterministic source reification. Emitted calls retain the signature
matcher's selected arguments. Compound types used as values remain opaque; this
is not a new type-expression syntax. Native acceptance and full regression status
are recorded in the inferred-conversion study.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Subpath prototype and universal proof families

The isolated type-expression prototype can author a finite subpath inclusion using
explicit Fin offset, bound-cast and equality-cast wrappers, plus Nat association
and monotonicity facts. Its vertex/edge functions, restricted directions and
certified shape map are authored in Clean. Lean checks the two endpoint laws,
including zero-edge subpaths. Its initial inclusion prototype passed eleven exact native targets outside the
repository. Integration as a repository study and the restricted-zigzag acceptance
checks remain pending.

The exercise exposed a separate interface boundary: evidence for a named condition
whose body is universally quantified is not automatically callable as a dependent
proof family. The current shape-map constructor expects the latter. Explicit
Function(e: E,Evidence((...))) certificate arguments work without new native
mathematical bodies; direct use of a named universal certificate needs a precise
proof-elimination or conversion rule. This is recorded as unfinished language work,
not hidden behind a study-specific native adapter. Interval clipping, removal of
empty labels, basis reindexing and the paper's extension theorem remain separate.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Explicit type expressions

[Type expressions](type-expressions.md) adds `type(T)` as a case-insensitive
expression atom containing existing type syntax, with one TypeValue tree and the
resolved Type 0 Lean target. `type` is reserved in expression names. The explicit
foundational Type binding moves into the shared types module. Hygienic substitution,
owned binder comparison, automatic condition naming and editor highlighting cover
the new node. Local type definitions and arbitrary computed types remain rejected.
The earlier compound-type-as-value opacity boundary is superseded; full validation
status is recorded in the type-expression study.
:::


:::llm gpt-6 2026-11-07 role=assisted

## Named endpoint evidence now has a callable view

The [callable-evidence prototype](callable-evidence.md) is integrated after the
preceding compiler passed all 584 tests. Named authored universal conditions can
now supply dependent constructor fields directly. In a separate subpath check,
source- and target-preservation assumptions are passed unchanged to the shape-map
constructor; three exact native targets and one inclusion proof pass. This
removes the need for separate proof-family aliases at that interface.

The new compiler passes 197 focused tests and its own study's 21 exact targets
and 15 proofs. The full regression and 33-study portfolio remain running on a
frozen equivalent snapshot. The subpath arrow check and interval-basis restriction
remain unfinished; this evidence does not prove the paper's extension theorem.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Interval clipping uses existing syntax

The [interval-clipping study](../studies/interval-clipping/README.md) authors
coordinate clamping and surviving-label selection in Clean. Explicit foundational
adapters expose natural minimum, its bound and the Fin constructor. Eight exact
native targets, three proofs and five Python checks pass. No new grammar or
paper-specific Lean definition is required. Clipping alone does not restrict an
interval basis: constructing surviving-label records, reindexing bases and proving
compatibility remain separate mathematical work. The shared IntervalLabels type
now has explicit prose metadata so LaTeX describes a family of ordered labels.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Equivalences for reindexing bases

`library/logic/equivalences.clean` exposes `Equivalence(A,B)`, its constructor from
two functions and inverse evidence, and forward/backward application. Its identity
is authored with Clean functions and equality reflexivity. The algebra reindexing
module wraps `Module.Basis.reindex` with the explicit coefficient field and module.
This makes the needed direction visible: old indices to new indices. Vector
lookup uses the inverse equivalence.

The [study](../studies/basis-reindexing/README.md) checks ten native targets and
four proofs, with seven source/type rejection checks. No new syntax was needed.
The study-specific bijection between surviving active interval labels and original
active labels remains to be constructed; these wrappers do not assume or establish
that bijection, basis compatibility, or the pyramid theorem.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Active-label maps: construction in progress

The [active-label study](../studies/active-labels/README.md) authors the original
and restricted active sets, a support record, both maps, and equivalence assembly
in Clean. Its final existence statement assumes only the subpath bound and interval
labels. The verifier must construct support and inverse evidence; that construction
is not assumed by the theorem. The support record and maps have loaded, but the
full equivalence translation, canonical checks and kernel proofs remain pending.

Two readability/application boundaries surfaced while writing this source:
transparent `Type … Equals:` aliases reject `Describe` metadata, and chained
application was initially unavailable. Chained application is now implemented
under the [postfix contract](postfix-applications.md), including its native oracles
and rendering checks. Alias descriptions now have an implemented presentation slice under the
[alias-description contract](alias-descriptions.md). It preserves transparent
semantics; the full-suite validation remains pending.
:::

:::llm gpt-6 2026-11-07 role=assisted

The active-label support and maps are now factored through the authored generic
`SubtypeRestrictionSupport(A,S,T,U)` construction. Its conditional equivalence
result passes ten exact native checks, three proofs and five Python tests. This
reuses ordinary set/subtype foundations and leaves the interval-specific arithmetic
support construction as an explicit unfinished proof obligation. It does not
weaken the interval existence statement by assuming its desired support record.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Equivalence composition can be authored with proof functions

The [equivalence-operations study](../studies/equivalence-operations/README.md)
constructs inverse and composition directly in Clean, using foundational equality
transitivity, congruence and existing inverse laws. Eight exact targets and three
proofs pass. No new syntax was needed. The nested equality chains are a concrete
readability limitation for future local proof syntax, not a missing ability to
construct the equivalence. Composition renders with parentheses so applying or
inverting it preserves grouping. Interval-specific support remains separately
unverified.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Extracting witnesses from existence evidence

The choice study exposed immediate function applications under existential binders.
Selecting an object with a property of every element further requires an applied
body containing quantifiers. The [proof beta rule](proof-beta-comparison.md) uses
hygienic comparison substitution while preserving emitted targets. Explicit Lean
choice wrappers and authored set helpers now pass seven exact targets and three
proofs. They supply a foundation for consuming existence evidence; they do not
complete the interval-basis restriction or its compatibility proof.
:::

:::llm gpt-6 2026-11-07 role=assisted

## A restricted basis at one vertex

The [restricted-basis study](../studies/interval-basis-restriction/README.md)
now checks three exact native targets and proves the generated Clean statement
constructing the restricted basis from the original basis. The proof uses the
arithmetic label equivalence and Mathlib basis reindexing, and establishes the
vector formula. No additional syntax or wrapper was needed. Factoring the set
declarations into `active_label_sets.clean` lets this statement translate without
loading the expensive equivalence definitions. An explicit element-module import
supplies the value projections. Edge compatibility and assembly into an
interval-basis record remain mathematical work.

Copying generated proof names across import orders failed because binder allocation
can change declaration hashes. The verifier now renders independent proof templates
against its current environment. This fixes the check, not the broader outstanding
module-identity design; generated names must not be treated as a portable API.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Restricted vectors and support are expressible in Clean

The [interval-vector study](../studies/interval-vector-restriction/README.md)
authors the restricted vector family with nested dependent functions. Its return
type refers to the restricted diagram's module at each vertex, while the body
reads the original diagram at the embedded vertex. Existing selected-field
conversion verifies that relationship without a new cast or native definition.
Three exact targets and two generated-statement proofs cover the definition,
evaluation formula, and vanishing outside the restricted intervals. The latter
uses the original vanishing condition and endpoint arithmetic; it does not assume
restricted support.

A fixed English rendering had made the original vanishing hypothesis and restricted
conclusion indistinguishable. The condition now renders its vector and interval
arguments explicitly. The mathematical definition and Lean target are unchanged.
This is a reminder that readable rendering must preserve which objects a statement
concerns. Edge compatibility and assembly with the checked pointwise bases remain
unfinished.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Restriction preserves edge compatibility

The interval-vector study now checks four exact targets and proves three generated
statements, including preservation of directed-edge compatibility. Active source
membership transfers from clipped intervals to the original interval using endpoint
arithmetic and survival of the label. A native helper proves that the two endpoint
transports preserve the action of the original edge map; equality elimination
reduces the helper to that original action. The mathematical vector definition
remains authored in Clean. No new syntax or imported mathematical definition was
needed. The compatibility rendering now identifies its vectors, diagram, and
interval labels so restriction changes are visible in the PDF.

The proof templates are reusable against the current explicit environment,
resolving its generated bindings instead of copying names from another build.
The full interval-basis assembly now passes four exact target checks and proofs
of both the pointwise and assembled restriction statements. Classical choice
selects the vertex bases; their realization, vector vanishing, and edge
compatibility populate the authored record constructor. The resulting vectors
are proved equal to the Clean-authored restricted family. This supersedes the
assembly/compatibility gaps recorded above. Subpath source/target evidence remains
explicit and is separately proved in the subpath study. The paper's extension
and pyramid theorem, full specialized-map validation, and broad compiler checks
remain unfinished.
:::
