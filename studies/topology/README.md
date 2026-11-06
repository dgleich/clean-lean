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
