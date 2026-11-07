:::llm gpt-6 2026-11-07 role=assisted

# Isolated local type repair

**Current status:** the seven binding repairs are now in the working compiler.
See the [integration report](../../docs/binding-integration.md) for current
validation and remaining gates. The account below records the isolated experiment;
default patch drivers reconstruct its pinned baseline, not the current compiler.


Status: implemented in `local-types.patch`, on top of the carrier, bound-call,
proof-binding and checked-annotation patches. **Not enabled in main.** The
original [counterexample](README.md) remains a failing gate for main and for the
earlier four-patch stack.

Run the reproducible check from the repository root:

```sh
LAKE=/home/claude/.elan/bin/lake python studies/type-identity/verify_prototype.py
```

The driver copies tracked source into a temporary checkout, applies the five
patches, regenerates the strict parser and checks its output. It runs the original
identity gates, the preservation checks, the prior carrier/annotation/proof
verifiers and 274 focused Python regressions. It does not apply the composed
operator patch. The generated native specimen is [PrototypeVerified.lean](PrototypeVerified.lean).

## Binding and translation rule

Source grammar and neutral syntax trees are unchanged. A bare type name still
parses as `Name(name)`. Under a fixed checking environment:

1. If the original source name selects a local value of type `Type`, return a
   `LocalType` containing that source name and its already selected Lean binder.
   Perform this step before module alias lookup.
2. Otherwise resolve the explicit module alias/type table as before, checking
   constructor arguments in order. A module constructor remains an ordinary
   `Type` object and cannot compare equal to a `LocalType`.
3. Local rendering uses its stored Lean binder. Local carrier types inhabit
   `Type 0`; they do not inherit a same-named module's universe, function-type
   interface or prose description.
4. Substitution replaces only local type references selected by a declaration's
   parameter map. Module constructor heads remain fixed; substitution recurses
   through arguments. Dependent matching keeps source patterns separate from
   already substituted actual types. Local-type comparison keys abstract the
   stored Lean binder when comparing alpha-renamed dependent types.
5. Implicit notation patterns mark actual local type parameters, not every
   matching word in a displayed type. The simple matcher rejects a local type
   against a concrete module constructor with the same name.

For the regression specimen, the selected local Lean binder is `Real`, so the
result is exactly `∀ (Real : Type) (x : Real), x = x`. The module's real-number
type still renders as `ℝ` when explicitly selected before that local exists.
The independent native oracle distinguishes these two targets.

## Stored aliases and annotations

An authored type alias now stores its checked declaration-scoped body and an
ordered parameter telescope. Instantiation substitutes checked actuals into that
body. The display-oriented `canonical` template remains available, but authored
aliases do not reconstruct semantic types by formatting and reparsing it.
Type and structure declarations likewise retain checked parameter types for
validating dependent arguments. Failed recursive alias checking retains the
explicit cycle diagnostic and does not publish the incomplete alias.

For example, a module declaration `Type FixedReal(): Equals: Real` remains the
module's real-number type even inside a result containing `Let Real: Type`.
Conversely, `Type IdentityType(T: Type): Equals: T` instantiated with the local
`Real` retains that local carrier. Constant aliases with unused type parameters
are covered too.

Checked annotations record free local type references from semantic objects.
They do not discover new references from module display names in a later scope.
Reification of an inferred type constructs a checked annotation directly.
Binder-name reservation includes a local type's selected Lean identity.
Two existing test fixtures now construct explicit local references instead of
using `Type("X")` as an informal stand-in for both locals and module types.

## Evidence and limits

The new checks cover the original eight gates, eleven preservation cases and four
independent exact native targets: a local carrier statement, a quantified carrier,
a fixed module alias under a same-named local, and module-type reification.
The native specimen also proves three generated statements. The prior carrier,
proof-binding and annotation verifiers remain required, not superseded by these
small checks.

The fresh-checkout driver passed with the ten initial preservation cases; the
additional local LaTeX check and the four native targets passed in the final leaf
run. The isolated compiler also regenerated all 92 curated corpus proof fixtures,
and Lean checked the resulting file. The [LaTeX specimen](Prototype.pdf) was
compiled twice and visually inspected. These bounded checks do not replace the
full study migration. The older main full suite completed with 724 passing tests
and one outdated diagnostic expectation, subsequently corrected and checked
separately. The isolated compiler's full-suite run remains pending and is not
counted as a pass.

This representation distinguishes locals from module type constructors and
retains the existing selected Lean binder identity. It is **not** a complete
module-owned identity or serialization design. Local substitution maps still use
the source formal names within their checked scopes. Arbitrary cross-environment
identity comparison is not justified by this patch. Legacy hand-built metadata
without checked templates still has a textual fallback; this is migration debt.

Opaque native adapter templates may contain unqualified Lean names. Preventing a
later Lean binder from capturing those names remains an independent requirement;
these fixtures use the explicit `ℝ` template. A subsequent [native binding experiment](../native-type-bindings/README.md)
addresses opaque type adapters with root-qualified abbreviations and changes the
canonical target rule. It is not part of this five-patch stack. Operator composition, full corpus
and study validation, universe polymorphism and main integration remain pending.
No topology paper theorem is proved merely by repairing these type references.
:::
