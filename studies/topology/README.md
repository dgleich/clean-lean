:::llm gpt-6 2026-11-06 role=assisted

# Topology study

The study now has a working Clean foundation, generated Lean statements, and
kernel-checked foundation proofs. The five paper/classical theorem targets remain
pending; they are not included in the verified theorem count.

| File | Purpose |
|---|---|
| [comparison.md](comparison.md) | GitHub-readable theorem comparisons; historical proposed interfaces |
| [comparison.html](comparison.html) | Same comparison with side-by-side panels |
| [requirements.md](requirements.md) | Current decisions, precise next-slice design, blockers and proof obligations |
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
binders; see [their contract](../../docs/value-indexed-types.md). Dependent callable
signatures and the broader design in requirements.md remain pending. Paper-specific structures and algorithms still need
real definitions; the proposed files do not manufacture those definitions.

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
not a canonical-expression comparison or a new language-conformance claim.
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
wrapper targets, four canonical statement targets, and four proofs. Regenerate
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
intersections; [SubspacesVerified.lean](SubspacesVerified.lean) checks 19 canonical
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

Run `LAKE=lake python3 studies/topology/verify_homology.py` for 31 independent
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
