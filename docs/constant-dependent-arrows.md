:::llm gpt-6 2026-11-06 role=assisted

# Constant dependent arrows and diagram data

Implemented slice; grammar and source ASTs are unchanged. A dependent function
whose checked codomain is independent of its parameter compares as an ordinary
function. This matters for a constant diagram: the declared arrow has type
`Function(e: E, ModuleMap(K,field,(object(Q.source(e))),(object(Q.target(e)))))`,
but supplying a constant object family makes both modules independent of `e`.

## Constructive comparison rule

Compute the codomain's existing normalized type key in the current outer scope.
If it contains no free identity token for this dependent binder, use the ordinary
function key `(type, constructor, (domain-key, codomain-key))`. Otherwise use the
existing Pi key, abstracting that binder and preserving outer free tokens.
Constructor identities must agree. This is a structural free-token test on the
checked comparison key, not a textual occurrence check or a Lean elaboration trial.
Nested owned tokens remain distinct from free tokens. Equality is symmetric;
constant dependent arrows use the same hash as the corresponding ordinary type.

When matching a callable argument, either representation may occur on either
side. Match domains first. Instantiate dependent codomains at the same fresh
checked local; leave ordinary codomains unchanged. Match the resulting codomains
under existing inference rules, including the prohibition against an inferred
parameter escaping with the fresh bound local. A genuinely varying codomain
cannot match an unrelated constant type. Inference cannot select a different AST.

Emission retains the declared dependent binder and original checked expressions.
Comparison does not rewrite a declaration into an ordinary arrow. Consequently
there is one source-directed emitted term; exact Lean acceptance checks compare
elaborated terms, not merely terms that are definitionally equal.

## Opaque producers and projections

When normalizing a projection, normalize its base first. If that base still
contains a binder, use the existing constructor/projection reduction rule. If no
field can be selected, retain the original checked projection unchanged. Do not
construct new dependent indices from the opaque producer's hidden binders.
Selected fields can still participate in the existing application contraction.
This extends the existing bounded opacity policy; it does not normalize inside
arbitrary binders or unfold native bodies.

## Library use and remaining boundaries

`library/algebra/module_diagrams.clean` supplies shapes, module-valued diagrams,
and a Clean-authored constant diagram. `library/diagrams/zigzags.clean` specializes
them to a finite line with independently oriented edges. The interval-basis module
supplies actual vertex bases, labelled vectors, ordered endpoints and compatibility
evidence. See [the checked study](../studies/zigzag-bases/README.md).

Compound type expressions still cannot be supplied as arbitrary value arguments.
Helpers with inferred `Type` parameters make `shape(source,target)` and
`constant diagram(field,Q,M)` possible using existing inference. Authored helper
bodies referring to inferred type parameters can remain opaque to conversion.
Conditions used as evidence indices are named declarations; direct quantified
binder expressions in computed indices remain rejected. No new parser syntax or
implicit mathematical vocabulary is introduced here.

## Acceptance

`tests/test_constant_pi.py` covers equality, hashing, nested scopes, both matching
directions, genuine dependency rejection and incompatible diagram arrows.
`studies/zigzag-bases/verify.py` independently writes the native types and bodies of
the diagram records and constructions, compares canonical elaborated expressions,
and proves six study statements. Constructor and projection checks include field
order and dependent result types. The pinned Lean/Mathlib environment is unchanged.
:::
