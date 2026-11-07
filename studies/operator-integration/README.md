:::llm gpt-6 2026-11-07 role=assisted

# Declared operators with repaired bindings

Status: isolated eight-patch prototype. The production compiler is unchanged.
This composes declared operators with local-type identity, declaration-scoped
native type abbreviations and root-qualified generated globals.

## Constructive selection rule

Parsing produces the neutral Operator or Unary tree using the fixed grammar's
precedence and associativity. Candidate types never select a parse. For that
fixed tree and explicit declaration environment, check every declared candidate.
Zero applicable declarations is an error; exactly one selects that declaration;
more than one is semantic ambiguity, even when their bodies are definitionally
equal. Candidate iteration order cannot select a winner.

A concrete module type cannot match a locally bound type merely because their
names have the same spelling. This holds recursively inside parameterized types.
A generic Type-0 parameter requires a carrier in Lean Type 0: a known different
sort makes that candidate inapplicable. Unknown sort information, resource
exhaustion and errors from nested checks are not evidence of inapplicability.
Dependent matching can suppress only a mismatch tagged by that candidate's own
check. Foreign mismatches propagate.

Once selected, retain the declaration, checked native template and presentation
in the bound ModuleCall. Substitution instantiates that retained call instead of
running overload selection again. References to selected generated globals remain
root-qualified. Rendering shares precedence-aware grouping between named calls,
fresh operators and retained calls. These rules construct one target within this
slice; they do not resolve the broader universe, literal or instance policies.

## Specimens and validation

[Saved.clean.proposed](Saved.clean.proposed) tests equality, authored implication,
proof parameters, quantified annotations and later competing declarations.
[Dispatch.clean.proposed](Dispatch.clean.proposed) tests concrete versus local
types, type-valued operands, proof operands and dependent witnesses. Its meanings
for `^` and prefix `-` are deliberately synthetic dispatch tests, not mathematical
notation recommendations.

```sh
LAKE=/home/claude/.elan/bin/lake python studies/operator-integration/verify_prototype.py
```

The driver rebuilds from tracked source, applies the seven binding patches and
this composition patch, and strictly regenerates/checks the parser. Do not also
apply the older composed-operators patch. The original saved/dispatch checks comprise 26 exact Lean targets and four
kernel-checked proofs. The subsequent [explicit foundations](foundations/README.md)
now add 38 exact targets and six proofs. The [topology migration](topology-migration.md)
adds thirteen targets and seven proofs, making 77 targets and seventeen proofs
in the driver. Expected native bodies and selected uses
are independently written with explicit generated-name mappings. The semantic
checks cover candidate-order reversal, ambiguous equal-bodied declarations,
wrong dependent witnesses, same-spelled local carriers, interrupted analysis and
foreign mismatch propagation. Saved-expression checks cover frozen overloads,
authored implication and parenthesized LaTeX rendering.

The first dispatch oracle run failed three exact comparisons because its expected
terms used raw Lean Type instead of the declared native type abbreviation. The
expectations now follow the explicit wrapper rule; no equality check was weakened.

See [SavedVerified.lean](SavedVerified.lean),
[DispatchVerified.lean](DispatchVerified.lean) and [Saved.tex](Saved.tex).
The one-page [PDF specimen](Specimen.pdf) was compiled twice and visually checked
for grouping, missing symbols and overflow. Rebuild it from the repository root
with `pdflatex -output-directory=/tmp studies/operator-integration/Specimen.tex`.

## Remaining integration gates

The old standalone operator targets and the broader existing regression/corpus
suite have not been migrated to this combined stack. The 274 focused tests and
92 corpus proofs recorded for qualified globals exercised built-in operators;
those counts do not validate this compiler. Explicit operator foundation modules
and literal interpretation must be migrated before integration. Numeral operands
currently reject with an explicit unsupported-policy error. General universe-
polymorphic equality, source-binder escaping and native import isolation remain
open. Dedicated generated-name collision tests for fresh overloaded calls are
still needed on this stack. The existing saved-expression tests do not replace
that obligation. No claim of full language conformance is made.
:::
