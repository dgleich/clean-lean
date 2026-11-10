:::llm gpt-6 2026-11-10 role=assisted

# First typed-literal implementation experiment

**Isolated partial prototype. Not integrated, and not the complete literal design.**
The production compiler still rejects `Literal`. The full target remains ordinary
unannotated mathematics such as `x != 0`, with deterministic inference and a precise
Lean target. This experiment establishes declaration and annotation plumbing first.

```clean
Notation vector zero(n):
  Let n: Natural
  Returns: Vector(n,Complex)
  Means: fun _ => (0 : Complex)
  Literal: 0
  Render latex: 0
```

In the patched checkout, `(0: Vector(n,Complex))` selects this constructor and
emits its fully instantiated native call with the caller's n. A rectangular-matrix
constructor similarly recovers m and n. An ordinary named call remains available.

## Reproduce

```sh
LAKE=lake python3 studies/literal-annotations/verify.py
```

The driver exports baseline `027659500545c3290457a62d96389137879cdc6d` through the
shared study helper, overlays tracked study inputs, applies the patch, regenerates
the parser from the edited grammar with strict checks, checks regeneration, runs
the focused tests, and checks the independent Lean targets. It never edits the
working compiler. Generated parser changes are regenerated, not hand-patched.

## What the experiment implements

- A case-insensitive Literal field in the existing declaration-field grammar.
  The ordinary field AST is parsed once; attachment validation accepts ASCII
  digits only and canonicalizes leading zeros. Duplicate fields remain errors.
- Eligibility checking for a Type-0 carrier result and direct recovery occurrences
  for every constructor formal. Computed-only or absent parameters are rejected.
- Attachment metadata stored on the explicit module callable declaration, after
  its body is resolved. There is no external registry or type-name dispatch.
- Structural matching against a determined annotation type; repeated parameters
  must agree. Recovered arguments are reified in the caller scope. Ordinary
  dependent-call checking validates the resulting type, including computed result
  indices whose parameters were recovered elsewhere.
- Competing exact constructors are ambiguous. Existing all-numeral declarations
  have equal priority; an exact Real-zero declaration does not override Real's
  Numerals attachment. Missing dimensions are never guessed.
- A retained ModuleCall for the selected constructor, checked against its declared
  identity. Changed literal declaration targets reject at selection time.
- Explicit rejection of Literal on Source, Type and Condition declarations.

The source expression AST remains NumeralAnnotation. In this first implementation,
elaboration desugars it to an ordinary retained constructor call. That deliberately
reuses existing native-target, substitution and binding machinery to test the
selection boundary; it does **not** yet implement the proposed BoundLiteral record.

## Validation

The isolated implementation passes 18 focused tests and 51 existing generated-parser,
numeral-search, compact-signature and applied-index tests. The parser generator and
its check mode pass strict LALR/lexer checks. Two independently authored native
expectations compare the generated vector/matrix annotation types and bodies
canonically. Two coordinate-zero proofs pass the pinned Lean kernel.

The focused tests cover renamed carriers, caller/formal dimension names, leading
zeros and capitalization, Define adapters, computed result constraints after direct
recovery, malformed/duplicate fields, invalid attachment contexts, distinct
constructors, exact/all-numeral ambiguity and changed declarations. One fixture
initially installed both a specialized and a general matrix-zero constructor;
its ambiguity was correct. The computed-index success fixture now declares only
its intended constructor, while separate tests preserve ambiguity requirements.

## Required next work

- Preserve the literal's digit, annotation and origin through all retained-binding
  consumers. Currently spelling a retained expression yields the named constructor
  call, and the constructor's Render field supplies LaTeX. The intended literal
  surface form and full annotation presentation are not preserved.
- Specify and implement the complete immutable binding snapshot, including result
  pattern and ordered recovered arguments; audit changed metadata and later scopes.
- Connect the symbolic joint-constraint/default design to real callable signatures,
  dependent types and computed indices. Unannotated `x != 0` is explicitly tested
  as still unsupported in this prototype, not accepted as the final boundary.
- Check all expression consumers and editor highlighting. The added grammar field
  is not accompanied by production editor changes in this isolated experiment.
- Complete negative/native oracles for recovered implicit parameters, proof-valued
  dependencies, aliases, higher universes, resource exhaustion and wider interactions.
- Run full acceptance and topology/corpus validation before any conformance claim.

The patched annotation engine is intentionally not a drop-in production feature.
Its passing checks establish the implemented slice, not completion of
[the parameterized-literal contract](../../docs/parameterized-literals.md).
:::
