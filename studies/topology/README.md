:::llm gpt-6 2026-11-06 role=assisted

# Topology study

The study now has a working Clean foundation, generated Lean statements, and
kernel-checked foundation proofs. The five paper/classical theorem targets remain
pending; they are not included in the verified theorem count.

| File | Purpose |
|---|---|
| [comparison.html](comparison.html) | Original side-by-side comparison; historical proposed interfaces |
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
General value-indexed types are the next language change, specified as a bounded
proposal in requirements.md. Paper-specific structures and algorithms still need
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
- The five target theorem interfaces and the generalized value-indexed-type
  proposal are not counted as implemented or verified.
:::
