:::llm gpt-6 2026-11-06 role=assisted

# Hygienic conversion of applied producer fields

This extends comparison-only definition conversion to authored producers containing
functions. It enables this authored definition:

```clean
Define graded homology map(K,field,X,Y,g):
  Let K: Type
  Let field: FieldStructure(K)
  Let X,Y: TopologicalSpace
  Let g: ContinuousMap(X,Y)
  Returns: GradedMap(K,field,
    (graded singular homology(K,field,X)),
    (graded singular homology(K,field,Y)))
  Equals: graded map(K,field,
    graded singular homology(K,field,X),graded singular homology(K,field,Y),
    function(p: Natural,homology linear map(field,scalar homology(K,field,p),X,Y,g)))
```

The component type expected by the constructor refers to the graded objects' fields;
the supplied function returns a map between the underlying homology modules.
Comparison now recognizes these types as equal after selecting and applying the
component fields. No special graded-homology dispatch or native implementation of
this definition is added.

## Syntax and source serialization

No grammar production changes. The existing tree for `build(x).component(p)` is:

```text
["Apply", ["Projection", ["Call", "build", [["Local", "x"]]], "component"],
  [["Local", "p"]]]
```

Computed-index serialization now accepts an Apply whose head is a Projection of a
computed object, as well as an existing named reference. A Projection of an Apply
is grouped: `(build(x).component(p)).value(q)`. That grouping is required by the
existing grammar, which permits field arguments only at the end of a projection
chain. A direct application of an arbitrary computed function is still outside
this surface syntax. These rules select one reparsable spelling without consulting
types or trying alternative parses.

## Simultaneous hygienic substitution

The helper operates on an already checked authored body and checked actual Exprs.
It substitutes explicit parameter trees simultaneously; it never substitutes again
inside an inserted actual tree. Ordinary field labels and module-call heads are
preserved. A formal function parameter in call-head position becomes a local Call
or an Apply of its supplied argument, according to the existing tree constructors.

Traverse domains before bodies, children left-to-right. For every expression binder
(Lambda, Forall, Exists), first substitute its domain, allocate a fresh source name,
then traverse its body with the old binder mapped to that fresh Local. The domain
is outside the binder's scope. Perform the same operation for BoundTypeApply nodes
inside type annotations. Type syntax is parsed structurally; source-word replacement
in strings or opaque Lean is forbidden.

Allocate `clean_conversion_bound_N` using the least unused nonnegative N, advancing
one counter for this traversal. Reserve caller locals, module type/alias/callable
names, names in the original body (including type annotations), and all actual
argument trees. Newly allocated names are immediately reserved. Thus no inserted
free reference can become bound, no original bound reference can become free, and
nested binders remain distinct. The checked expanded expression is re-elaborated
under the fixed caller environment.

If an argument cannot be serialized in a type annotation (for example, an unapplied
lambda as a computed index), retain the original wrapper. This is an explicit
representation boundary, not a search for another interpretation. Other elaboration
errors are not suppressed. The later [inferred-argument conversion rule](inferred-argument-conversion.md)
reifies checked inferred parameters where their existing source forms permit it;
it supersedes the original blanket opacity of inferred-parameter references.

## Ordered comparison and opacity boundaries

1. Traverse the original checked expression using the existing ordered normalizer.
   An authored Equals body may contain binders, subject to the rules above.
2. Inside projection evaluation, an expanded constructor may expose a function
   field. Normalize that selected expression. For an Apply, normalize its head and
   arguments, then use the existing immediate-lambda contraction rule: the body and
   actual must be binder-free, and re-elaboration must preserve the determined type.
   Continue normalization on a contracted result.
3. Do not let residual binders enter string comparison keys. At the public
   comparison boundary, if the result tree still contains Lambda, Forall or Exists,
   retain the original checked expression. Calls normalize each actual through
   this public boundary before rebuilding their dependent signature. Thus a graded
   object passed as a type index retains its authored wrapper; only its selected,
   applied component can expose the homology expression.
4. A binder-free local definition retains its frozen comparison value. Re-enter
   that value for further projection/application comparison only if its initial
   normalization exposed residual binders and there are no shadowed module names.
   In that case store the original checked value with an explicit deferred-expansion
   flag; otherwise retain the completed comparison value without reprocessing it.
   A normalized result containing a binder is never cached as an expanded local
   value. Lambda-authored local definitions remain opaque.
5. If a caller local function shadows a module callable, or a caller type variable
   shadows a module type/alias, do not expand authored bodies. Do not reinterpret a
   frozen local comparison value under those new bindings either. This conservative
   boundary prevents accidental rebinding until resolved module identities are
   carried throughout comparison ASTs. Such names do not select another expansion.
6. Means/From Lean adapters stay opaque. No eta rule, extensionality, arithmetic
   identity, equality-assumption rewrite or proof search is added.

The rule is constructive and ordered. Definitions cannot recurse or refer forward;
substitution does not inspect native bodies. Lambda contraction is restricted to
checked binder-free bodies/actuals. Duplication can be expensive; exhaustion is
incomplete analysis, not an equality/inequality result. This extension does not
claim general Lean definitional equality, conversion of unapplied function families,
or complete higher-order normalization.

## Exact Lean target and acceptance

Comparison leaves emitted definitions, calls and annotations unchanged. In the
induced map above, the signature contains the authored graded-homology calls;
the body contains the graded-map constructor and the original lambda calling the
homology-map adapter. No casts, beta-expanded signature, or equality evidence is
inserted. The earlier explicit-constructor projection emission rule is unchanged.

`tests/test_hygienic_conversion.py` checks independent substitution trees, capture,
simultaneous insertion, dependent domains, nested type binders, call heads versus
field labels, quantifiers, generated-name collisions, computed-field round trips,
opaque unapplied families, local aliases and module shadowing. Existing conversion,
index, graded-object and dependent-function tests remain applicable.

[HomologyMaps.clean](../studies/dependent-functions/HomologyMaps.clean) is translated
by `verify_homology_maps.py`. Four independently authored canonical targets retain
all wrappers, universes, instances, domains and bodies. Three kernel-checked proofs
establish the component formula and the identity/composition laws. The proof block
uses a finite one-million-heartbeat budget after the default budget exhausted during
composition; that earlier attempt was incomplete, not a proof. These are functor
laws for existing Mathlib singular homology, not proofs of the research-paper targets.
:::

:::llm gpt-6 2026-11-06 role=assisted

The later [family-index comparison rule](family-index-comparison.md) supersedes
only the blanket opacity of residual binders at the final index-key boundary.
Internal callable reconstruction and local caching retain the boundaries above.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Demand-driven call-head classification

Substitution asks whether a checked actual is callable only when the original
formal occurs as a Call head, including calls inside type annotations. Copying a
Local value does not require a callable view. A traversed binder's replacement
remains a call head by the existing binder rule. Classification is memoized only
within one substitution invocation; no environment-dependent result survives it.
All actual trees still reserve fresh names, including unused actuals. Traversal,
simultaneous insertion, emitted terms and fresh-name allocation are unchanged.

The regression fixtures check value-only substitution without callable inspection,
repeated callable/noncallable heads, calls in condition annotations and unused
actuals reserving binder names. This avoids unnecessary condition unfolding but
does not solve the subpath arrow's repeated dependent normalization: an isolated
20-second profile still exhausted its diagnostic budget. That diagnostic is
incomplete analysis, not acceptance evidence for the arrow theorem.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Selecting producer fields before sibling normalization

Implemented prototype: when comparing a projection of an already checked call,
first attempt to select its field through authored producers. This supersedes
step 2's unconditional normalization of the whole base before field selection.
It does not change source projection emission in `structures.project`.

1. Preserve the existing shadowed-module guard. Only a checked Call returning a
   declared structure participates. Native definitions and other expression forms
   return no selection and use the previous comparison procedure.
2. For the structure's generated constructor, select the field argument at its
   declaration-order position after the explicit structure parameters. Elaborate
   that argument. The original constructor application was already checked, so
   this does not permit ill-typed unselected arguments.
3. For an authored Equals producer, elaborate its explicit actuals and take its
   implicit actuals from the checked call's stored inference metadata. Reify only
   required implicit formals using the existing inferred-argument rule. Perform
   simultaneous hygienic substitution over the entire body, retaining reservation
   and traversal of all argument and binder names.
4. If the substituted body is the expected constructor Call, select its field
   before elaborating sibling fields. Otherwise elaborate the substituted body,
   require its determined type to equal the producer's type, and repeat selection
   through that checked expression. Authored declarations have no recursive or
   forward references; native producers remain opaque.
5. Accept a selected field only when its determined type equals the original
   projection's type, then apply the existing normalizer to that field. An absent
   selection or unrepresentable substitution uses the previous comparison path.
   Other elaboration errors remain errors; no alternative meaning is searched.

No grammar, AST or emitted Lean call changes. The rule specifies a single ordered
comparison procedure, including checked inference, declaration positions, hygienic
fresh names and type-equality gates. It neither inspects native bodies nor adds
proof search, arithmetic rewriting or a cache. The subpath study's nineteen
independent canonical targets and six proofs pass under this rule. Focused tests
cover selected fields, untouched emissions, shadowing, opaque native producers,
capture and rejection of an invalid unselected constructor argument. Full-suite
and broader native validation of this optimization remain pending.

The earlier subpath executions were stopped after this replacement passed the
independent oracle. They were superseded, not counted as completed validations.
:::
