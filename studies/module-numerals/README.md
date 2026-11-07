:::llm gpt-6 2026-11-07 role=assisted

# Explicit numeral parser step

Status: isolated parser-only prototype. The working compiler is unchanged and
neither compiler currently implements the proposed numeral adapter binding.
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
by the semantic declaration interpreter.

Reproduce from the pinned historical baseline plus the eight operator/binding
patches and this parser patch:

```sh
python studies/module-numerals/verify_prototype.py
```

The driver strictly regenerates and checks the parser, runs the eleven new
syntax tests, and runs the 17 existing generated-parser tests. A fresh checkout
passed both suites and strict generation/reproducibility checks on 2026-11-07. It does not validate
the main compiler or a numeral-to-Lean translation. The separate
[native payload probe](../operator-integration/NumeralPayloadProbe.lean) checks the
specified primitive Nat payload mechanism only.

Next steps are declaration-owned adapters, annotation binding and retained native
identities, every expression consumer, LaTeX, and independent full native targets.
Expected-type propagation and module-declared defaults remain a later required
step before ordinary unannotated numerals can migrate to this architecture.
:::
