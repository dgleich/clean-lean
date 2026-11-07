:::llm gpt-6 2026-11-07 role=assisted

# Carrier fields in a pointed topological space

This isolated prototype authors a bundle with its own carrier, topology and point
in [Bundle.clean.proposed](Bundle.clean.proposed). Subsequent fields depend on the
carrier field. The six [statements](Statements.clean.proposed) use `P.carrier`,
a readable authored `carrier of(P)` alias, dependent return types and an explicit
constructor. Constant-map continuity uses the existing Clean-authored
`continuous between` definition and its explicit Mathlib foundations.

Run from the repository root:

```sh
LAKE=lake python3 studies/carrier-fields/verify_prototype.py
```

The driver copies tracked source, applies [prototype.patch](prototype.patch), and
regenerates/checks the parser strictly, then runs the native fixture and the
221-test regression selection. Main Clean is unchanged. The checked native
fixture is [PrototypeVerified.lean](PrototypeVerified.lean); the rendered statements
are available as [PDF](Statements.pdf) and [TeX](Statements.tex).

Twenty-one exact targets cover the record, constructor and three projections, the Clean
constructor wrapper, five authored helper definitions, the dependent family record and its projections, and six statement targets.
The record oracle renames only the explicitly paired record/constructor/projection
identities; it retains universes, native constants, dependent types and bodies.
Six proofs include constant-map continuity. Further checks cover parsed type paths,
parenthesized computed carriers, automatic Condition names, Type-value and dependent
function substitution, different-carrier rejection, insufficient universe, and
forward field references. The wider isolated suite passes 221 tests with two
intentional policy updates: computed carrier arguments are accepted and the default
small universe now fails through the general universe check.

An initial broader run found that promoting bare local type renaming into semantic
reification broke the existing syntax-only hygiene operation. The prototype now
retains the original local-renaming route and reifies only nonlocal carrier
expressions. The corrected 221-test run passes. Other fixture corrections used a
fresh lambda binder, imported Evidence explicitly, and matched the existing universe
diagnostic. These did not weaken negative checks.

The [contract](../../docs/carrier-fields.md) gives the parse and translation rules.
Main integration and full corpus/study validation remain required. The expanded
[consumer audit](Audit.md) records a confirmed callable-capture failure that blocks
integration. A subsequent [bound-call repair](BoundCalls.md) fixes the counterexample
in isolation. The [proof-binding extension](ProofBindings.md) also preserves module
conditions in saved and quantified proof types. The [annotation extension](AnnotatedTypes.md)
retains semantic types and reconnects their free local references during binder renaming.
Operator composition, the wider identity audit and integration remain open.
Composition with module operators passes five additional exact targets
and three proofs; run `python3 studies/carrier-fields/verify_operators.py`. This is fixed Type-0 carriers in
an explicitly higher-universe record; it is not general universe polymorphism,
implicit carrier coercion or a replacement for all existing TopCat-based interfaces.
:::
