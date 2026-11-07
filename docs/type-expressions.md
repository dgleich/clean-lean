:::llm gpt-6 2026-11-06 role=assisted

# Explicit type expressions

Status: implemented prototype; full integration validation is in progress. This
rule extends inferred-argument conversion with explicit compound type values and
supplies concrete type arguments needed by finite zigzag restriction constructors.

## Authored form and unique parse

```clean
pack(type(Real),x)
pack(type(Vector(n,Real)),v)
pack(type(Function(k: Natural,Vector(k,Real))),f)
```

Add the atom production `TYPE_VALUE "(" type_ref ")"`, where TYPE_VALUE is the
case-insensitive reserved expression word `type`. Exclude this word from expression
identifiers, including words in callable names, using the same lexical policy as
`function`. Keep TYPE_ID unchanged: type annotations continue to use declared type
names. Thus `type(Real)` is never a module call and `Vector(n,Real)` without the
marker is not reinterpreted as a type after failed expression elaboration.

The normalized AST is `["TypeValue", canonical_type_spelling]`, using the existing
type grammar and structural spelling, as binder domain annotations already do.
For example, `TYPE(Vector(n, Real))` has the unique tree
`["TypeValue", "Vector(n,Real)"]`. Comments, layout and continuations use existing
parenthesis rules. Prose type descriptions are not accepted inside this form.
A type constructor remains explicitly module-declared; this marker adds no
mathematical names, imports, constructor resolution or overload selection.

Reserving `type` is a compatibility change. No current authored callable in library
or studies was found with that word; this does not establish compatibility with
external files. A callable named `type` or containing that word will be rejected,
not silently reassigned another meaning.

## Meaning and target

Require the explicit foundational Type binding to Lean Type, with declared
universe 1. Move that existing declaration from topology/basic.clean to the shared
types.clean module; this makes the meta-sort metadata available independently of
topology. An absent or differently bound meta-sort is an error. In particular,
Type itself cannot instantiate a parameter restricted to Type 0.

Resolve the enclosed type in the fixed caller scope, then apply the existing
closed-universe Type-parameter gate: its Lean target must inhabit Type 0. Emit that
resolved target directly, with the existing explicit wrapper, index, universe and
instance choices. The expression's type is the parameter sort Type. Its LaTeX is
the enclosed type's ordinary mathematical rendering, without the syntactic marker.

`type(Real)` therefore emits ℝ; `type(Vector(n,Real))` emits `Fin n → ℝ`.
Dependent arrows retain their native Pi binders. Type-valued operands support
only equality and disequality among the built-in operators. Arithmetic, order,
powers and unary operators on them are rejected, including on named Type locals.
Other constructions must use explicitly declared functions. A proof type such as
`type((x = x))` is rejected, as is a declared Type 1 module-object carrier.
`type(Proposition)` is different: Prop itself inhabits Type 0 and can be supplied
as a carrier. This distinction follows Lean's sorts, not the displayed word.

At an explicit Type parameter, substitute the checked enclosed type structurally.
Named Type locals retain their current meaning. At an explicit Type parameter,
a call returning Type is rejected even when it computes a known type. Such calls
may still be ordinary expressions in contexts that already accept Type-valued
terms, such as equality; this rule does not make them usable as carrier annotations
or as explicit Type arguments. Type-valued local definitions and general universe
parameters remain outside this extension. No type inference trial chooses between expression
and type syntax. `type(marker(3))` is a type-constructor lookup, never evaluation
of a Natural-returning function.

## Substitution and comparison obligations

TypeValue is a scoped syntax constructor, not an opaque string. Every substitution
must parse its payload as type syntax, descend into computed indices, freshen
BoundTypeApply binders and insert actuals simultaneously. Use the existing least
unused name policy, reserving both expression and type names. Do not recursively
substitute inside inserted actual types. Preserve and recheck their determined
meaning in the caller scope.

Inferred types now reify to a named Type local when one exists, otherwise to a
checked TypeValue. No private alias is added to the environment. Authored Equals
conversion can consequently expand constructors instantiated at primitive,
compound and dependent carriers. Existing shadowing and native-opacity gates stay.

BoundTypeApply nodes inside TypeValue must participate in binder detection.
Whole-index comparison must materialize their fresh native binding identities in
the existing owned comparison pool. A later local named clean_pi_bound_0 cannot
change the comparison key of a saved dependent type argument. Nested expression
binders and computed indices inside the type obey the same ownership contract.

Emission follows the existing projection policy. Calls retain their declared
wrappers; a projection of an explicit binder-free authored constructor producer
may reduce during elaboration. For example, if real box(x) is such a producer,
its `.value` can emit x. This is not a license to compare native targets only up to
definitional equality: the independently authored oracle must select that x.

## Consumer audit before integration

- Grammar, generated parser, syntax spelling and independent trees; keyword/name
  collision rejection, case variants and line continuations.
- Expression elaboration, Type-argument checking, structural dependent substitution
  and closed-universe rejection.
- Hygienic authored expansion, constructor projection reduction, immediate-lambda
  contraction and index substitution, including dimensions inside TypeValue.
- Binder detection, owned comparison identities and saved-local comparison under
  later source/generated-name collisions.
- Automatic Condition names: serialize `type(T)` with canonical structural type
  spelling; pass it through existing punctuation encoding and collision rejection.
- LaTeX, reference HTML and VS Code/Emacs/Vim lexical highlighting. These display
  changes cannot select a different type or imply an unproved theorem.
- Update old opacity tests to independently specified equalities where this rule
  intentionally enables expansion. Preserve negative scope and universe cases.

## Current prototype evidence and remaining gates

The isolated generated parser passes strict LALR and lexer checks. Nineteen focused
prototype tests cover the independent tree, universe checks, constructor typing,
inferred compound expansion, nested dimension substitution, dependent comparison
keys, local type-definition rejection, meta-sort inference and actual automatic
assumption names with alias collision rejection. The focused regression run passes
all 82 tests after
replacing the old zigzag-opacity assertion with an independent expected target
function. The authored projection and its ordinary comparison form are still
checked separately; whole-index comparison now materializes that function.

The native prototype passes eight exact targets and three proofs: explicit packing,
inferred packing, concrete Real, vector and dependent-family constructors, their reduced field
equations and an inferred dependent-carrier equality. The
[type-expression study](../studies/type-expressions/README.md) preserves these
acceptance artifacts. The normative references and acceptance catalog are updated.
The final focused run passes 116 tests, and the 92 corpus proof fixtures pass the
Lean kernel. The final specimen compiled twice and its single-page layout was inspected.
The review browser refresh remains to be completed for this snapshot.

All 32 study verification scripts passed in the integration copy. Its generated
artifacts differ from the previous checked artifacts only in the position or
presence of the foundational Type declaration; those 61 Lean files have been
refreshed. This portfolio preceded the final Type-valued operator rejection guard;
the final study and focused tests separately cover that guard. The integration-copy
full suite completed 581 tests with one obsolete certificate-opacity assertion
failing; that assertion was already corrected in the main checkout before its
current full run began. No other failures were reported. The final full
suite and browser build are still running, so neither is reported as passing.
This slice does not claim general universe polymorphism or callable universal evidence.
:::
