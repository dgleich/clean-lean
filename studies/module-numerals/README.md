:::llm gpt-6 2026-11-07 role=assisted

# Explicit module-owned numeral prototype

Status: isolated parser, native declaration and explicit expression prototype. The
working compiler is unchanged. A fourth patch prototypes contextual inference; a fifth adds explicit defaults.
The normative proposal and remaining target obligations are in
[the module numeral draft](../../docs/module-numerals.md).

The patch adds `(NUMBER: type_ref)` as an atom and Numerals as an opaque metadata
field. It reuses NUMBER rather than introducing an overlapping lexer token.
The syntax-tree constructor rejects non-ASCII digit spellings and retains
leading zeros. No integer conversion or name/type lookup occurs during parsing.
Existing unannotated NUMBER syntax is unchanged.

Eleven focused tests independently specify trees for annotations, operators,
nested type syntax, grouping, calls and lambda binders. They check layout
continuation, metadata capitalization/duplicate rejection, unsupported expression
casts and signs inside the annotation, and a 5000-digit token. A guard confirms
that elaboration reports the unimplemented binding instead of silently selecting
an old default. A type declaration with Numerals is likewise not yet accepted
by the parser-only stack’s declaration interpreter. The driver checks that
boundary before applying the separate adapter patch.

Reproduce from the pinned historical baseline plus the eight operator/binding
patches and the five numeral patches:

```sh
python studies/module-numerals/verify_prototype.py
```

The driver strictly regenerates and checks the parser, runs the eleven new
syntax tests, and runs the 17 existing generated-parser tests. A fresh checkout
passed both suites and strict generation/reproducibility checks on 2026-11-07. These syntax checks do not validate
the main compiler or a numeral expression’s Lean target. The separate
[native payload probe](../operator-integration/NumeralPayloadProbe.lean) checks the
specified primitive Nat payload mechanism only.

The subsequent `adapters.patch` attaches a separate native constructor to each
closed Type-0 Means declaration carrying Numerals. It records its native name,
body, payload and carrier identity. Aliases resolve to their original carrier;
two carriers with the same native body own different constructors. Syntactically
unsupported metadata is rejected before publishing a declaration. Opaque native
payload types are checked by Lean, as for Means; Python emission alone is not
validation. Even a proof-valued opaque Means body is rejected by the native
Type-0 signature.

`verify_adapters.py` checks independent carrier/constructor types and bodies for
Real, Nat and a renamed Real carrier, zero-value proofs, and kernel rejection of
wrong payload and carrier types. The initial zero-proof attempt used `rfl`, which
failed for Real casts; the proof now explicitly simplifies the constructor.
No exact-target oracle was weakened. A fresh reconstruction passed on 2026-11-07:
28 syntax tests, six exact native targets, three zero proofs and two expected
kernel rejections.

The third patch, `expressions.patch`, implements explicit numeral binding and its
expression consumers. It also fixes opaque payload comment handling and updates
the isolated editor rules. `Expressions.clean.proposed` contains independently
readable declarations and theorem specimens; `ExpressionsVerified.lean` includes
native target oracles and proofs. Nineteen target comparisons and two proofs pass
on the directly patched checkout. Consumer checks cover substitution, beta/index
comparison, JSON index reconstruction, quantifiers, automatic-name collisions,
imported aliases, local shadowing, changed bindings and generated-name capture.
The translated 5000-digit case is not claimed kernel-checked. Native Emacs scope
execution is unavailable; portable browser and native Vim scopes pass.

The driver applies each patch in order, checks the earlier rejection boundaries
before enabling the next layer, and finally runs all four operator regression
leaves. Fresh full-driver reproduction passed on 2026-11-07: 28 parser tests,
105 exact native targets and 22 proofs (six targets/three proofs for adapters,
nineteen/two for expressions, and eighty/seventeen for operator regressions), plus
two expected native rejection cases. The historical and working-compiler full
regression processes remain running; neither is claimed to pass here.

`Expressions.pdf` is the current rendered specimen, including a separate page for defaults. The LaTeX document compiled
twice and was visually inspected: type annotations remain visible, with no
clipping, overfull boxes or unresolved references. The existing package-path
warning is unchanged. Rebuild with:

```sh
pdflatex -output-directory=/tmp studies/module-numerals/latex.tex
pdflatex -output-directory=/tmp studies/module-numerals/latex.tex
```

Copy `/tmp/latex.pdf` to `Expressions.pdf` when regenerating the tracked specimen.

The fourth patch, `inference.patch`, completes unannotated expression-position
numerals by exhaustive carrier assignment. `Common.clean.proposed` now holds the
shared wrappers. `Inference.clean.proposed` uses ordinary `x + 1`, nested sums,
renamed Counting numerals, named conditions and expected definition return types.
The [inference specification](../../docs/numeral-inference.md) records the precise
scope, owned-mismatch rule, conservative ambiguity policy and 4096-trial bound.
Fresh reconstruction of all four layers passed on 2026-11-07: 28 parser tests,
120 distinct exact-target cases and 26 proofs across the staged stack. The nineteen
explicit-expression targets and two associated proofs are additionally repeated
after inference is enabled. The fourth layer contributes fifteen exact targets
and four proofs; all operator regressions pass on the final inference stack.

The inference-stage specimen contained six statements on one page. It compiled twice and was
visually inspected with no clipping, unresolved references or box warnings.
Inferred numerals print without type annotations; explicit annotations remain
visible. The leading-zero assumption cases intentionally retain their source digits.
Native unused-variable and LaTeX package-path warnings are unchanged.

The fifth patch, `defaults.patch`, introduces `Default numerals: Counting` as
an explicit module declaration. [The policy](../../docs/numeral-defaults.md)
defines idempotent imports, conflict rejection, sequential scope and simultaneous
restriction of already-valid assignments. `Defaults.clean.proposed` exercises
plain arithmetic, type constraints and explicit annotations. Direct verification
passes eight exact native targets, four proofs and a public-CLI Lean compile.
Fresh full-driver reconstruction passed on 2026-11-07: 128 distinct exact-target
cases and 30 proofs across the staged stack, with inference and explicit-expression
cases repeated after enabling defaults. Strict generation/reproducibility and all
17 generated-parser regressions also pass after the new directive is added.
The original eleven numeral syntax cases pass at their parser-only boundary.
The final operator regression leaves all pass. The two earlier full-discovery
processes remain running and are not counted as passing validation.

The final PDF has two pages and ten statements. Both pages were inspected after
two LaTeX runs; there are no box warnings, clipped statements or unresolved
references. The existing package-path warning remains.

Default-selected atoms display type annotations in LaTeX; the convention is not
silently omitted when a theorem is extracted. Context-based compact presentation
remains future work.

Next steps include broad consumer regression, constraint pruning, main integration
and complete native identity/import/instance isolation.
Type-position dimension-literal migration remains a separate obligation.
:::
