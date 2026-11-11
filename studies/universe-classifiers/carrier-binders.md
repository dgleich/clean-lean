:::llm gpt-6 2026-11-11 role=assisted

# Dependent functions that bind types

The isolated classifier stack now accepts a declared classifier as a dependent
function domain. [CarrierFunctions.clean](CarrierFunctions.clean) defines a
single callable that accepts a type and then an element of that type:

```clean
Define identity family():
  Returns: Function(A: LargeTypes,Function(x: A,A))
  Equals: function(A: LargeTypes,function(x: A,x))
```

Here `LargeTypes` explicitly classifies Lean Type 1. The generated native result
type is `(A : LargeTypesNative) → A → A`; the body is `fun A x => x` with
fresh compiler binder names. `LargeTypesNative` denotes the module's native
classifier abbreviation. Function domains retain this wrapper, as ordinary
value binders do; the primitive `Type 1` convention for generic declaration
parameters remains a separate existing rule.

## Syntax, binding and translation

No grammar production or token changes. The existing `bound_type_arguments`
production parses `Function(A: C,B)` into a binder name, a domain type and a
codomain type. The independent source-tree test fixes the nested shape explicitly.
Colon, comma, parentheses, keyword capitalization and layout rules are unchanged.
Acceptance now extends the existing semantic domain check; type-checking does not
choose between competing syntax trees.

1. Resolve C in the outer explicit environment. If C is a declared classifier,
   preserve its resolved identity and classified level.
2. Require a fresh A under the existing binder-freshness rule. Assign one fresh
   native binder using the existing deterministic allocator.
3. Resolve B in the extended scope. A used as a type becomes a LocalType carrying
   that binder, classifier identity and exact closed level. Other local references
   remain free. Classifier aliases use their resolved identity.
4. If B depends on A, retain DependentFunctionType. Otherwise use the existing
   ordinary-arrow representation. Emit the domain wrapper and resolved codomain
   using existing dependent-arrow rendering. The resulting sort is computed by
   the existing Lean Pi rule, including the impredicative proof codomain case.
5. Application checks the supplied argument against the declared classifier;
   substitute the checked carrier in the codomain without changing its universe
   or classifier identity. No visible-classifier search or implicit lift occurs.
   Substitution refreshes inner binders to avoid capturing free names.
6. Lambda inference uses the same representation and substitution rule. Alpha
   comparison abstracts native binder identities while preserving classifier and
   universe metadata. Version-2 storage preserves the resulting LocalType fields.

Callable declaration dispatch must retain any DependentFunctionType structurally,
including nested occurrences with no value indices. The old string-pattern path
would turn the dependent return type into an unresolved `$dependentFunction` key.
The patch routes those signatures through the existing structural call checker;
it does not infer a signature by trying alternate Lean elaborations.

These rules determine one source tree and one native term under a fixed declared
environment and the existing binder allocator. They rely on the existing arrow
binding, substitution and canonical-target contracts; they do not establish all
remaining native-environment freshness obligations.

## Evidence and limits

Ten focused tests pass (3.899 seconds): independent syntax tree, alpha equality
and hash, preserved classifier distinction, inferred lambda, no-argument authored
family application, wrong classifier rejection, Type-0 support, capture avoidance,
version-2 storage and binder freshness. Two independent canonical Lean targets
check the authored family and its topology-space theorem; the theorem is proved
by reflexivity. [CarrierFunctionTargets.lean](CarrierFunctionTargets.lean) contains
the generated definitions, oracles and proof.

The two earlier rejection fixtures are deliberately migrated: Type-0 and higher
classifier binders now have positive acceptance cases. Other freshness and scope
rejections remain. The expanded dependent-function/structure/conversion/storage run passed 158 tests
in 53.969 seconds before the final independent source-tree case was added; the
final focused ten-case run passed separately. The fresh pinned reproduction
completed successfully: 287 selected tests (115.826 seconds), ten binder tests
(3.292 seconds), 29 storage/index tests (23.938 seconds), strict parser checks
and all native suites. Full regression remains pending. Reproduce the complete stack
with `python3 studies/universe-classifiers/verify.py --carrier-binders`; that flag
also enables version-2 storage. Production remains unchanged.

The optional [computed-carrier composition](computed-carriers.md) now adds higher
computed/projected carriers and dependent record fields. General higher
record-parameter and type-constructor handling remain separate work. This family example does not prove any homology, well-group
or numerical-analysis theorem. Full regression and production integration remain
unfinished.
:::
