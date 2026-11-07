:::llm gpt-6 2026-11-07 role=assisted

# Generated globals cannot be captured by locals

Status: isolated prototype after the six patches through native type bindings.
Main is unchanged. This extends root qualification to generated callables,
constructors, record types and projections.

The preceding compiler can translate an authored call to a local function with
the same spelling as its generated global identifier. The Clean source still
resolves the intended module declaration, but the emitted Lean identifier resolves
to the local instead. The regression deliberately creates that local. For an
identity definition, the incorrect statement asserts that an arbitrary local
function fixes every input; the intended statement only uses the module identity.

The same collision affects the explicit dependent-call path and constructors.
A local named after a generated record can also capture its type reference or
the head of a field reference. The previous compiler's projection cases produce
invalid native field notation. The repaired targets retain the selected globals.

## Emission rule

The source grammar, name resolution and semantic argument ordering do not change.
Whenever the compiler emits a reference to one of its selected global declarations,
emit an absolute `_root_` reference, including generated projection and constructor
names. Keep the bare declaration key for definition-table lookup. The ordinary
callable and constructor metadata now exposes that key as `native_binding`; a
consumer need not recover it by splitting rendered Lean text.

| Selected use | Schematic Lean reference |
|---|---|
| Ordinary authored or native callable | `_root_.cleanDefine_name_id x` or `_root_.cleanNotation_name_id x` |
| Explicit dependent callable | `@_root_.cleanDefine_name_id T x` |
| Generated record type | `_root_.cleanStructure_name_id T` |
| Generated constructor wrapper | `@_root_.cleanConstructor_name_id T x` |
| Native record constructor in its wrapper body | `@_root_.cleanStructure_name_id.mk T x` |
| Selected field, including fields used in later field types | `@_root_.cleanStructure_name_id.field T record` |

Here `id` is a placeholder for the existing deterministic suffix, not new source
syntax. User-written local function applications continue to use their selected
local binders. This rule does not qualify every identifier in an opaque user-written
Lean body; that body is checked in its declared parameter scope as before.

## Collision specimens and checks

[Definitions.clean.proposed](Definitions.clean.proposed) supplies a scalar
identity, native square adapter, dependent vector identity, a scalar record and
a record with a dimension-dependent vector field. The verifier obtains their
generated declaration names and authors deliberate same-named local parameters
in [Statements.clean.proposed](Statements.clean.proposed). The long names in this
generated adversarial specimen are not recommended theorem-writing style.

The source also defines an authored function whose parameter collides with an
earlier generated callable. Its body must still call the earlier module function.
Both source documents go through the ordinary loader. Independent neutral parse
oracles cover the dependent call and field-reference syntax.

The native verifier checks twelve exact targets: five declaration bodies, four
Clean statements, a constructor value, a projection and a dependent projection.
Six proofs check the source statements, constructor value and authored-body
behavior. The independent expected terms use an explicit generated-name mapping;
they do not call the translator to produce their expected bodies. See
[PrototypeVerified.lean](PrototypeVerified.lean).

Run the complete isolated check:

```sh
LAKE=/home/claude/.elan/bin/lake python studies/qualified-globals/verify_prototype.py
```

The driver applies seven patches in a fresh tracked checkout, strictly regenerates
the parser, and also runs the preceding native-type binding checks. Its aggregate
scope is 23 exact targets, twelve proofs, 274 focused Python regressions and the
92 regenerated corpus proofs. The prior compiler fails the collision verifier;
the repaired compiler passes. The earlier carrier/module-call capture rejection
also passes and remains in the driver. One existing projection-output assertion changes
to require the `_root_` prefix.

## Remaining scope

The declared-operator experiment must be composed with these binding changes;
its overload and bound-template paths need the same checks. Earlier native
oracles that expected inline type bodies remain unmigrated. Full import/instance
isolation, source-binder spelling/escaping, declaration-owned semantic identities,
serialization and legacy hand-built metadata still require their broader audits.
This step does not claim that all native name-hygiene problems are solved or that
the main compiler is ready for integration.
:::
