:::llm gpt-6 2026-11-06 role=assisted

# Explicit type expressions — integration draft

Status: isolated implementation prototype, **not supported by the repository
compiler yet**. The inferred-argument-conversion implementation remains the current
contract. This draft removes its compound-type-as-value boundary and supplies the
concrete type arguments needed by finite zigzag restriction constructors.

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

Resolve the enclosed type in the fixed caller scope, then apply the existing
closed-universe Type-parameter gate: its Lean target must inhabit Type 0. Emit that
resolved target directly, with the existing explicit wrapper, index, universe and
instance choices. The expression's type is the parameter sort Type. Its LaTeX is
the enclosed type's ordinary mathematical rendering, without the syntactic marker.

`type(Real)` therefore emits ℝ; `type(Vector(n,Real))` emits `Fin n → ℝ`.
Dependent arrows retain their native Pi binders. A proof type such as
`type((x = x))` is rejected, as is a declared Type 1 module-object carrier.
`type(Proposition)` is different: Prop itself inhabits Type 0 and can be supplied
as a carrier. This distinction follows Lean's sorts, not the displayed word.

At an explicit Type parameter, substitute the checked enclosed type structurally.
Named Type locals retain their current meaning. Calls returning Type, arbitrary
computed type values, Type-valued local definitions and general universe parameters
remain outside this extension. No type inference trial chooses between expression
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

The isolated generated parser passes strict LALR and lexer checks. Eight focused
prototype tests cover the independent tree, universe checks, constructor typing,
inferred compound expansion, nested dimension substitution, dependent comparison
keys and label serialization. The focused regression run passes all 68 tests after
replacing the old zigzag-opacity assertion with an independent expected target
function. The authored projection and its ordinary comparison form are still
checked separately; whole-index comparison now materializes that function.

The native prototype passes five exact targets and two proofs: explicit packing,
inferred packing, a concrete Real constructor, its reduced field equation and an
inferred dependent-carrier equality. These are isolated experiments, not yet
repository acceptance artifacts. Integration requires preserving them, completing this audit,
updating the normative references and acceptance catalog, running the full suite
and corpus, inspecting the rendered specimens, and refreshing the review browser.
No integration or general conformance claim is made by this draft.
:::
