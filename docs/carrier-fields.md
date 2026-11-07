:::llm gpt-6 2026-11-07 role=assisted

# Carrier fields and projected types — prototype contract

Status: proposed, executable isolated prototype. Main still rejects
carrier fields. This extends closed-universe structures, not universe polymorphism.

```clean
Structure BundledSpace():
  Universe: 1
  Let carrier: Type
  Let topology: Topology(carrier)
  Constructor: bundled space

Result identity continuous:
  Attribution: mathlib; continuous_id; specialized
  Let P: BundledSpace
  Conclude: continuous(P,P,function(x: P.carrier,x))
```

## Syntax and binding

Allow the existing reference-projection production (`name.field` with subsequent
fields) as a type reference, including at the top level of a type annotation.
Remove its separate type-argument alternative to avoid two derivations of the same
path. Type arguments still use the same neutral tree and their declared slot kinds
determine whether a path denotes a type or value. Parenthesized computed indices
retain their expression parse: a checked Type-valued expression denotes a carrier,
a condition denotes its proof type, and other top-level values are rejected.
Parsing never uses the expression's type to select a syntax tree.

Within a structure, a carrier field is an ordinary ordered field whose type is the
explicit imported foundational Type. Subsequent fields may refer to it. Existing
fresh-name, dependency ordering and constructor rules remain. The existing closed
sort check requires Universe at least 1 for such a field; default Universe 0 must
reject it before publication. The carrier ranges over Lean Type 0. Its enclosing
bundle inhabits the explicitly declared universe, so Type-0-only generic interfaces
cannot accept the bundle itself as a carrier.

## Constructive target rule

Check a type-position projection using the ordinary checked field rule. It must
have type Type; a point or topology field is not itself a carrier. Preserve the
explicit native projection term, presentation and a scoped comparison index. Model
this internally as a carrier-type constructor applied to that index; its source
spelling is the authored projection/computation, not an internal marker.

For a named local Type value use its existing local type identity; for `type(T)`
use the checked T. Transparent authored/constructor reductions use the existing
bounded comparison normalization. Otherwise retain the projected carrier type. Carrier computations inherit the
existing computed-index restriction: authored binders remaining after checked
immediate beta contraction are rejected. This does not add general type-level
reduction or higher-order inference.
Its Lean rendering is the selected checked projection term, with explicit structure
parameters. Equality and alpha comparison use the same scoped index discipline as
other dependent values. No coercion from a bundle to its carrier is inserted.

Substitution must carry these type indices through constructor arguments, field
projections, dependent function domains/codomains, Type-value expressions and
inferred type arguments. A type-valued field binds a carrier type for subsequent
field substitution, rather than an ordinary value index. Constructor/application
checks compare complete dependent types and reject points from a different bundle.
Condition naming and LaTeX retain the authored type path; they must not expose the
internal carrier marker. Native projection types/bodies and all selected implicit
arguments require independent canonical-target checks.

This slice does not permit a carrier field ranging over an arbitrary universe,
Type-valued dependent function binders, structural subtyping, automatic TopCat
coercions, or silent instance search in Clean. Explicit Mathlib adapters may use
the checked carrier and topology fields. Full native-adapter policy and module
identity requirements remain unchanged.
:::


:::llm gpt-6 2026-11-07 role=assisted

## Evidence and remaining gates

The [pointed-space study](../studies/carrier-fields/README.md) checks fifteen exact
native targets and five proofs. Its record oracle compares the record sort,
constructor, three projections and Clean constructor wrapper after an explicit
one-to-one renaming of their corresponding declaration identities. All other native
constants, levels, binders and terms remain. Nine additional comparisons cover four
authored helpers and five theorem statements. Wrong carriers, insufficient universes,
forward field dependencies and nontype projections are rejected. Type-position paths,
computed carrier aliases, dependent-function substitution and automatic Condition
labels have separate source checks. The wider isolated run passes 221 tests.

Bare local Type substitutions retain syntax-only renaming; nonlocal checked Type
expressions enter carrier reification. This preserves the earlier hygiene contract
when a renamed local is not yet installed in a semantic environment. The initial
prototype incorrectly reified both, and that regression was corrected.

Before main integration, audit all carrier-type consumers and scoped reification
paths, compose this patch with the operator migration, and rerun the corpus and
relevant studies. General universe-polymorphic functions/bundles and the native
module-scope policy remain separate open requirements. The PDF's readable carrier
alias is authored in Clean and does not introduce an implicit coercion.
:::
