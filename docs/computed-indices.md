:::llm gpt-6 2026-11-06 role=assisted

# Explicit computed indices

Implemented extension of named value indices and dependent calls:

```clean
Type HomologyClass(K: Type, field: FieldStructure(K),
                   H: HomologyTheory(K,field), X: TopologicalSpace):
  Equals: ModuleElement(K,field,(homology module(field,H,X)))

Define homology image(field,H,X,Y,g):
  Let K: Type
  Let field: FieldStructure(K)
  Let H: HomologyTheory(K,field)
  Let X,Y: TopologicalSpace
  Let g: ContinuousMap(X,Y)
  Returns: ModuleSubspace(K,field,(homology module(field,H,Y)))
  Equals:
    module map range(field,homology module(field,H,X),homology module(field,H,Y),
      homology linear map(field,H,X,Y,g))
```

The extra parentheses mark a computation in a type argument. They are an explicit
implementation choice, recorded for review; they are not a new mathematical
operator. A type alias makes ordinary theorem statements much shorter. The alias
expands in Clean and requires no native HomologyClass adapter.

## Grammar and unique parse

The generated grammar extends `type_argument` with `computed_index`:

```ebnf
type_argument = type_ref | NUMBER | index_reference | computed_index ;
computed_index = "(" expression ")" ;
```

Existing type references begin with an identifier; a computed index begins with
an opening parenthesis. The alternatives are syntactically distinct. Inside it,
the existing expression precedence and associativity rules apply. An unmarked
`T(f(x))` remains a neutral type-constructor application; it is never reinterpreted
as a computation because that would type-check. Write `T((f(x)))` instead.

`ModuleElement(K,field,(homology module(field,H,X)))` has the independent tree:

```text
Apply(ModuleElement, [Name(K), Name(field),
  ComputedIndex(Call(homology module, [Local(field), Local(H), Local(X)]))])
```

The header/type-text layer now preserves sequences of opaque type-text pieces
and balanced parenthesized groups, including nested groups that begin with `(`.
It still does not assign mathematical meaning. The type-reference parser resolves
the complete annotation separately. Commas split only at the current parenthesis
depth. Existing continuation, indentation and comment rules are unchanged. There
are no new keywords or editor token classes.

## Scope and typing

This slice permits binder-free expressions: locals, existing calls, stable field
references and field applications, unary operations and binary operations.
Lambdas and quantifiers inside an index are rejected explicitly. Existing expression
restrictions still apply: projections need stable named receivers, and an applied
function used inside an index must remain a named function or field. New local
scopes, general dependent function types and computed carrier-type arguments are
not introduced.

The declared constructor parameter fixes the slot's role. A computed value-index
expression must have exactly that parameter's already-substituted type. A computed
natural dimension must have Natural type. There is no expected-type numeral
coercion: `Vector(3,Real)` retains its existing dimension-literal rule, while
`Vector((3),Real)` fails because the expression numeral has the existing literal
placeholder type. `Vector((next size(n)),Real)` works when that declared function
returns Natural. Computed expressions in a type-valued slot are rejected.

Only previously declared names are visible. A computation cannot introduce a
self-reference or a forward reference. An explicitly parenthesized local or stable
projection normalizes to the same named index as its unparenthesized spelling.
Redundant expression parentheses do not change the normalized tree.

## Constructive translation and substitution

1. Parse once. Elaborate the index expression with the existing expression rules
   and current locals; check its exact expected type. Retain its normalized tree,
   canonical grouped source, translated Lean term and rendering. Stable names and
   projections retain the existing ValueIndex representation.
2. Substitute that Lean term into the imported type template, exactly where the
   value parameter occurs. No generated inference hole or proof search is added.
   Type aliases recursively expand in the same explicit environment.
3. A callable argument that is used as a value index may now be a compound
   expression. Construct its index from the argument's already elaborated tree
   and term instead of requiring a preceding local Let. Type-valued arguments
   still require named carrier locals.
4. For a computed index in a callable signature, replace formal local occurrences
   in its stored tree with the corresponding actual argument trees and already
   inferred type/dimension substitutions. Substitute Function-valued local parameters in call-head position as well.
   As in ordinary expressions, a nonfunction local does not shadow a module
   callable with the same name. Re-elaborate the resulting tree in the caller's
   environment. Never perform textual replacement inside Lean source.
5. Match the resulting indices structurally. Do not invert a computation to infer
   a parameter, unfold a locally defined alias, or invoke Lean definitional
   equality. Inference still comes from preceding structural type matches. An
   uninferred required parameter is an error, not an opportunity to try candidates.
6. Apply this substitution to the return type and to authored record field types.
   For a record projection, preceding field references substitute as projections
   of the same receiver. Emit the same fully explicit wrapper/constructor argument
   order as before. Quantified locals retain their fresh Lean binder targets.

Under a fixed environment these steps specify one operation at every stage.
There is no candidate order, overload search or type-driven parsing choice.
Opaque imported bodies and legacy operator elaboration retain their separately
recorded audit limitations. Exhausted analysis resources do not establish success.

Local aliases remain distinct: after `Let M = homology module(field,H,X)`, the
source type `ModuleElement(K,field,M)` is not automatically interchangeable with
`HomologyClass(K,field,H,X)`. Use the transparent type alias or the same explicit
computed index. This milestone solves generic map/range composition through
computed indices, not general alias conversion or transport.

## Acceptance evidence

`tests/test_computed_indices.py` has independent trees, nested header annotations,
grouping, aliases, wrong slots, wrong ambient indices, forbidden binders, record
fields, function-parameter substitution and binder-hygiene cases.
`studies/topology/verify_homology.py` compares independent native declarations,
including generic module maps/ranges, the transparent class alias's use in
statement types, an authored image definition and a computed dependent record.
`tools/check_computed_targets.py` additionally compares three independently
authored Lean targets for computed natural dimensions and call substitution.
Five actual proofs exercise the homology results. Its canonical comparison retains
instances, universes, argument order and projection indices; reduction proofs do
not replace those comparisons. These are scoped acceptance checks, not a claim
that the whole compiler satisfies every open elaboration obligation.
:::
