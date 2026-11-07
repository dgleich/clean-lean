:::llm gpt-6 2026-11-07 role=assisted

# Explicit numeral parser and declaration steps

Status: isolated parser and native declaration prototype. The working compiler is
unchanged. Neither compiler implements numeral expression binding yet.
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
patches and this parser patch:

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

Next steps are annotation binding and retained native identities in expressions,
every expression consumer, LaTeX, and independent full application targets.
Expected-type propagation and module-declared defaults remain a later required
step before ordinary unannotated numerals can migrate to this architecture.
:::
