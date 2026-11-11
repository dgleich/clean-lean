:::llm gpt-6 2026-11-06 role=assisted

# Topology study

The study now has a working Clean foundation, generated Lean statements, and
kernel-checked foundation proofs. The five paper/classical theorem targets remain
pending; they are not included in the verified theorem count.

The new [exact-pair and sequence-interior module](exact-sequences.md) provides
authored exactness conditions, a dependent sequence record, nine exact native
checks and three supporting/agreement proofs. It does not construct Mayer–Vietoris.

See the [implementation and acceptance audit](implementation-status.md) for the
current interface inventory, failed and pending validation, and the separate
mathematical construction obligations. Historical counts below describe their
individual milestones.

| File | Purpose |
|---|---|
| [comparison.md](comparison.md) | GitHub-readable theorem comparisons; historical proposed interfaces |
| [comparison.html](comparison.html) | Same comparison with side-by-side panels |
| [requirements.md](requirements.md) | Current decisions, precise next-slice design, blockers and proof obligations |
| [SingularComparison.clean](SingularComparison.clean) | Explicit natural comparison of chain and ordinary singular homology; [scope](singular-comparison.md) |
| [LevelEmptyPairs.clean](LevelEmptyPairs.clean) | Empty relative data, nesting and certification for level pairs; [scope](level-empty-pairs.md) |
| [CokernelTransport.clean](CokernelTransport.clean) | Equality-dependent cokernel transport and inverse homology maps; [scope](cokernel-transport.md) |
| [EmptyChains.clean](EmptyChains.clean) | Empty-space singular chains and the zero relative inclusion; [proof scope](empty-chains.md) |
| [ZeroChainQuotients.clean](ZeroChainQuotients.clean) | Inverse comparison maps for zero cokernels and their homology; [scope](zero-chain-quotients.md) |
| [LevelSets.clean](LevelSets.clean) | Level-set specialization: fibers, bands and empty relative subsets; [mapping and proof scope](level-sets.md) |
| [Common.clean](Common.clean) | Explicit topology import and source declarations |
| [Foundations.clean](Foundations.clean) | Four implemented foundation statements |
| [basic.clean](../../library/topology/basic.clean) | Clean-authored images, preimages, continuity, selection and family intersection |
| [Generated.lean](Generated.lean) | Generated foundation definitions and statement propositions |
| [Verified.lean](Verified.lean) | Generated statements plus four proofs and three agreement proofs |
| [Foundations.pdf](Foundations.pdf) | Typeset foundation statements with English quantifiers |
| [Targets.clean.proposed](Targets.clean.proposed) | Five pending authored targets, intentionally not a `.clean` module |
| [Targets.lean.proposed](Targets.lean.proposed) | Corresponding proposed Lean signatures, not compilable targets |

The implemented syntax is specified in [quantifiers](../../docs/quantifiers.md).
Named value-indexed types now work in constructor declarations and theorem
binders; see [their contract](../../docs/value-indexed-types.md). Named-field
structures and dependent callable signatures are now implemented in bounded slices;
the [Clean-to-Lean reference](../../docs/clean-to-lean.html) records their current
scope. The [zigzag-bases study](../zigzag-bases/README.md) supplies actual diagrams,
interval bases, six proved statements and a constructed constant example. The
broader design in requirements.md remains incomplete: in particular, the pyramid
and its basis-extension theorem still need constructions and proofs. Historical
proposed files do not manufacture those definitions.

From the repository root:

```sh
python3 -m cleanlang check studies/topology/Foundations.clean
python3 studies/topology/verify.py
lake env lean studies/topology/Verified.lean
python3 tools/check_quantifier_targets.py
pdflatex -output-directory=/tmp studies/topology/latex.tex
pdflatex -output-directory=/tmp studies/topology/latex.tex
```

Copy `/tmp/latex.pdf` to `studies/topology/Foundations.pdf` after regeneration.
The PDF target is generated from Foundations.clean. The verification script has
no `sorry`, axioms, or imported paper-specific theorem stubs.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Validation at this milestone

- 214 Python tests pass, including strict generated-parser checks.
- Six independent canonical quantifier targets and three lambda targets match.
- Lean checks four foundation proofs, three agreement proofs, and the existing
  92-theorem corpus.
- LaTeX compiles twice; the one-page foundation specimen was visually inspected.
- VS Code/TextMate, Vim, and the offline browser checks pass. Emacs grammar and
  tests are updated, but Emacs is unavailable here, so its runtime check is pending.
- The five target theorem interfaces and dependent callable support are not
  counted as implemented or verified.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Named-index parsing specimen

[ValueIndices.clean](ValueIndices.clean) uses actual Element and Path declarations
from [indexed.clean](../../library/topology/indexed.clean). It includes prose and
constructor spellings, nested quantified endpoints, and a named preimage index.
[ValueIndices.lean](ValueIndices.lean) is the generated statement file;
[ValueIndicesVerified.lean](ValueIndicesVerified.lean) contains four independent
canonical target comparisons and four proofs. These are foundation specimens,
not the five paper theorems. [ValueIndices.pdf](ValueIndices.pdf) shows their rendering.

Run `LAKE=lake python3 studies/topology/verify_indices.py` to regenerate and check.
The remaining callable boundary is deliberate and produces an explicit error.
`IntervalBasis` still needs its mathematical diagram and basis definitions.
:::

:::llm gpt-6 2026-11-06 role=assisted

The comparison Markdown is generated from the HTML source. After editing the
report, run `python3 tools/comparison_markdown.py`; check synchronization with
`python3 tools/comparison_markdown.py --check`. All eleven code panels are
preserved, with stacked Clean/Lean panels and Markdown tables for GitHub.

The named-index milestone passes 230 Python tests, four additional canonical Lean
statement comparisons and proofs, existing quantifier/lambda target checks, and
the 92-theorem corpus. The typeset named-index specimen compiles and the offline
browser checks pass. Dependent callable signatures remain outside this milestone.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Continuous images of compact sets

[CompactImage.clean](CompactImage.clean) states an actual topology theorem:
a continuous image of a compact set is compact. It uses Clean-authored image and
continuity definitions and explicitly imports Mathlib's compactness definition
through [compactness.clean](../../library/topology/compactness.clean).

[CompactImage.lean](CompactImage.lean) is generated from that source;
[CompactImageVerified.lean](CompactImageVerified.lean) adds a kernel-checked proof
using `IsCompact.image` and an equivalence proof against an independently written
native Mathlib statement. This equivalence is a mathematical agreement check,
not a canonical-expression comparison. The verifier now additionally checks the
compactness adapter and full statement against two independently authored exact
targets. This does not establish general language conformance.
No new syntax is introduced. The paper-specific targets remain pending.

Regenerate and check with:

```sh
LAKE=lake python3 studies/topology/verify_compact_image.py
```
:::

:::llm gpt-6 2026-11-06 role=assisted

## Dependent path operations

[Paths.clean](Paths.clean) uses [paths.clean](../../library/topology/paths.clean)
to state subtype membership, reversal twice, existence of constant paths, and
composition of paths. The wrappers use actual Mathlib definitions; reverse twice
is authored in Clean. [PathsVerified.lean](PathsVerified.lean) checks five canonical
type bodies, five wrapper targets, four statement targets, and four proofs. Regenerate
with `LAKE=lake python3 studies/topology/verify_paths.py`.

Dependent callable signatures are now implemented under the
[named-argument contract](../../docs/dependent-calls.md), superseding the older
milestone notes above. Structures, general expression indices and homology interfaces
remain work under the [implementation goal](../../docs/implementation-goal.md).
:::

:::llm gpt-6 2026-11-06 role=assisted

[Paths.pdf](Paths.pdf) renders the four path/subtype results. Run
`pdflatex -output-directory=/tmp studies/topology/latex_paths.tex` twice and copy
`/tmp/latex_paths.pdf` to `studies/topology/Paths.pdf` after regeneration.
The dependent-call milestone passes 252 Python tests, the canonical wrapper and
statement comparisons, four path proofs, existing indexed/compactness specimens,
and the 92-proof corpus. The LaTeX specimen has been compiled and inspected.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Authored bundles and scoped fields

[Bundles.clean](Bundles.clean) contains six implemented results: constructor
projections, order preservation under endpoint shifts, a path with its declared
endpoints, reversal twice, function-field application, and a dimension-dependent
vector field. [bundles.clean](../../library/topology/bundles.clean) authors endpoint
and path bundles, shifting, and reversal in Clean.

[Bundles.lean](Bundles.lean) is generated from Clean.
[BundlesVerified.lean](BundlesVerified.lean) adds 31 independent canonical comparisons
of records, constructors, projections, definitions and statements, plus six proofs.
No proposed research theorem is assumed. [Bundles.pdf](Bundles.pdf) is the typeset
specimen. Regenerate with:

```sh
LAKE=lake python3 studies/topology/verify_bundles.py
pdflatex -output-directory=/tmp studies/topology/latex_bundles.tex
pdflatex -output-directory=/tmp studies/topology/latex_bundles.tex
```

Copy `/tmp/latex_bundles.pdf` to `studies/topology/Bundles.pdf` after regeneration.
The [structure contract](../../docs/structures.md) records the fixed-carrier scope;
proof fields, carrier-containing structures and general universes remain pending.
:::

:::llm gpt-6 2026-11-06 role=assisted

The authored-bundle milestone passes 283 Python tests, 31 canonical comparisons,
six new proofs, and the existing 92-proof corpus. Strict generated-parser checks,
VS Code/TextMate, Vim, the offline browser, and the maintained reference checks pass.
The PDF compiles without overfull lines and was inspected. Emacs runtime validation
remains pending because Emacs is not installed.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Linear-space foundations for well groups

The [Mathlib foundation inventory](mathlib-foundations.md) describes the explicit
field/module/subspace interface and its remaining homology obligations.
[Subspaces.clean](Subspaces.clean) authors four results about admissible indexed
intersections; [SubspacesVerified.lean](SubspacesVerified.lean) checks 22 canonical
targets and four proofs. The indexed intersection itself is authored in Clean in
[linear_spaces.clean](../../library/algebra/linear_spaces.clean). These are genuine
algebraic ingredients, not proofs of the two-extreme-perturbation characterization.

Regenerate with `LAKE=lake python3 studies/topology/verify_subspaces.py`.
[Subspaces.pdf](Subspaces.pdf) is generated by compiling
`studies/topology/latex_subspaces.tex` twice and copying `/tmp/latex_subspaces.pdf`.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Actual spaces and singular homology

[Spaces.clean](Spaces.clean) and [SpacesVerified.lean](SpacesVerified.lean) exercise
actual TopCat spaces and bundled continuous maps. [Homology.clean](Homology.clean)
and [HomologyVerified.lean](HomologyVerified.lean) add actual singular homology
classes, an authored coefficient/degree bundle and an authored induced map.
[The interface note](singular-homology.md) explains precise native meanings and
computed-index integration and the remaining relative-homology gaps.

Run `LAKE=lake python3 studies/topology/verify_homology.py` for 38 independent
canonical comparisons and five proofs. [Homology.pdf](Homology.pdf) is generated
from `latex_homology.tex`, compiled twice. These results do not prove any of the
five research targets.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Interlevel problem data and preparatory inclusions

[Interlevel.clean](Interlevel.clean), [InterlevelVerified.lean](InterlevelVerified.lean)
and [Interlevel.pdf](Interlevel.pdf) now provide actual endpoint selections,
problem data and expanded/shifted/perturbed pairs. Seven inclusion results have
proofs, with 53 independent canonical targets. [The interface note](interlevel-data.md)
explains the distinction between raw pair data and a certified map of pairs.
The relative homology and well-group characterization remain unfinished.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Certified inclusions

[Evidence.clean](Evidence.clean) exercises explicit assumption proofs, proof-bearing
records, native subset inclusion and continuous maps between subspaces. Run
`LAKE=/path/to/lake python3 studies/topology/verify_evidence.py` for canonical target
checks and four kernel-checked proofs. [Evidence.lean](Evidence.lean) contains generated
statements; [EvidenceVerified.lean](EvidenceVerified.lean) adds native oracles and
proofs. The inclusion square commutes; relative homology itself is still pending.
See [the syntax contract](../../docs/evidence.md) for the bounded evidence rules.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Interlevel certificates

The [certification bridge](interlevel-data.md#certification-bridge-and-an-exposed-language-gap)
now proves existence of a certified expanded pair and certified inclusions of
bounded shifts and perturbations. These results construct proof-bearing records
from the earlier inequalities, preserving all component sets. The continuous
pair maps are available through `pairs.clean`. This does not yet construct relative
homology. Direct Clean composition of certificate constructors exposes a remaining
computed-record projection/reduction gap, recorded in that same report.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Computed record milestone

The [computed-record contract](../../docs/computed-records.md) now permits the
previously rejected certificate composition in Clean. The bundle verifier checks
36 canonical targets and ten proofs; the interlevel verifier checks 61 targets and
twelve proofs. The new examples distinguish reduced authored constructor fields
from opaque native-adapter fields. PDFs retain the authored expressions.
Implicit-parameter/binder-bearing producer unfolding, local-alias conversion,
relative homology and the research theorem proofs remain unfinished.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Relative object construction

[Relative singular chains and homology](relative-homology.md) now constructs the
relative chain complex as the cokernel of the inclusion-induced singular chain
map, and applies the homology functor in the selected degree. The definitions are
authored in Clean over generic native chain adapters. Sixteen exact target checks
and four kernel checks pass. Relative induced maps, exactness/excision and the
research theorem proofs remain unfinished; the report distinguishes definition
checks from mathematical theorems and records the computed-index conversion gap.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Induced quotient maps

[Chain squares](chain-squares.md) now supplies proof-bearing commuting squares,
induced cokernel maps and induced homology maps. The pair-inclusion study proves
that the actual four singular-chain maps form such a square. Seventeen canonical
targets and two kernel-checked proofs cover these interfaces. The square witness
is explicit; packaging the relative functor and converting its computed indices
remain open, as do exactness/excision and the research targets.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Named relative-map interfaces

[Relative maps](relative-maps.md) now authors the relative projections, induced
chain/homology maps and their images using named relative-object indices. The
bounded authored-definition conversion rule resolves the previously recorded
expansion mismatch. Eight canonical targets and three Lean proofs check these
interfaces. Explicit commutativity evidence is still passed; the study proves
that condition universally. Relative functor laws, exactness/excision and the
paper results remain unfinished.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Well-group intersections

[Well groups](well-groups.md) now defines the bounded-perturbation image intersection
in Clean, with a single fixed target module. Twenty-four canonical targets and
five new proofs check the definitions, completeness and soundness of certificates,
certificate independence and membership. The study rechecks 15 supporting proofs.
Projected header indices now substitute correctly in dependent record fields.
The extreme-image theorem, exactness/excision and a Clean proof language remain open.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Composing certified pairs

[Pair composition](pair-composition.md) now supplies Clean-authored identities and composition
with an explicit middle-pair equality. Generic congrArg on field-access lambdas
exposed an index-substitution gap, resolved by checked immediate lambda contraction.
Fifteen exact native targets and six proofs cover the new interfaces. This does not
supply a category instance or the relative-homology functor laws.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Shifted perturbations and images

[Shifted perturbations](shifted-perturbations.md) now defines the maps f−t and their certified
homology images in Clean. Eleven canonical targets and six proofs check the sign
convention, pair equality, uniform bound, certificate existence/independence and
well-group containment in every shifted image. Twenty supporting proofs are
rechecked. Certificates remain explicit; the reverse extreme-image inclusion and
the closed-cover/excision audit remain open. No new syntax is needed for this slice.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Actual two-image expression and candidate statement

[Extreme images](extreme-images.md) now authors the two certified extreme images and their
binary intersection. The full equality translates using scalar-field coefficients
in a chosen degree, but is explicitly an unproved singular-homology candidate.
Eighteen exact targets and four new proofs cover the interfaces, existence,
certificate independence and forward inclusion; twenty-six supporting proofs are
rechecked. The source's relative Mayer–Vietoris argument still needs a justified
cover/excision theorem in this model. Automatic assumption naming now handles
record fields such as P.space, with unchanged collision rejection.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Readable local names for dependent objects

[LocalNames.clean](LocalNames.clean) names source/target homology modules and chain
complexes once, then uses them in image membership and quotient commutation.
[Local definition conversion](../../docs/local-definition-conversion.md) resolves
the earlier local-alias gap without erasing the Lean lets. Two exact native
proposition comparisons and two proofs check the specimen; [PDF](LocalNames.pdf).
Binder-bearing local definitions and the previously listed research obligations
remain open.
:::

:::llm gpt-6 2026-11-06 role=assisted

## All-degree relative interface

[Graded relative homology](../dependent-functions/relative-graded.md) now packages
relative homology and its induced map in all natural degrees, using Clean-authored
definitions over relative chains. The selected-degree components agree with the
existing interfaces. Ten exact targets and five proofs cover the definitions and
graded chain-homology laws; pair-functor laws and exactness/excision remain open.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Explicit operator migration prototype

The [isolated migration](../operator-integration/topology-migration.md) now
rechecks this study's four original foundation results using declared Logic and
Sets operators. Mathematical definition bodies stay authored in Clean. Thirteen
exact targets and seven proofs cover that slice; the production files here and
the larger homology/well-group modules are not yet migrated. The agreement harness
now explicitly imports Mathlib.Topology.Continuous for continuous_def.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Working-compiler topology binding checks

The [binding migration report](binding-migration.md) records 405 exact native
targets and 89 proofs across all eighteen topology verifiers,
plus 23 focused Python tests. These checks run on the integrated compiler;
declared-operator integration and broader native-study migration remain pending.
:::

:::llm gpt-6 2026-11-10 role=assisted

## Exact sequences and binary module sums

The [exact-sequence study](exact-sequences.md) supplies authored range/kernel,
interior and terminal conditions. The [binary module product study](module-products.md)
adds the middle module needed for binary sums, with checked inclusion/projection
maps and supporting exactness/surjectivity proofs. These are reusable foundations;
the actual Mayer–Vietoris construction remains incomplete.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [inclusion-induced map study](mayer-vietoris-maps.md) now constructs the two
maps through H(U) ⊕ H(V) from actual continuous subset inclusions, and proves their
composite is zero. The connecting map and exactness remain open.
:::
