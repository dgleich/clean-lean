:::llm gpt-6 2026-11-06 role=assisted

# Authored structures and field references

This implemented slice adds finite, nonrecursive records to Clean. A structure
names one nominal Lean type, an explicitly named constructor, and fields scoped
to that type. It does not add global accessor names, inheritance, coercions,
recursive inductives, field defaults, record update, or proof synthesis.

## Source worth writing

```clean
Structure Endpoints():
  Let lower,upper: Real
  Constructor: endpoints
  Describe: a pair of real endpoints

Condition ordered endpoints(I):
  Let I: Endpoints
  Holds when: I.lower < I.upper

Define shifted endpoints(I,s):
  Let I: Endpoints
  Let s: Real
  Returns: Endpoints
  Equals: endpoints(I.lower+s,I.upper+s)
```

This is endpoint data, not a claim that lower < upper. The condition is explicit
where required. A later interval module must add endpoint inclusion/exclusion
choices and the precise set or relative-pair interpretation.

Dependent fields use exactly the earlier field names:

```clean
Structure BasedPath(X: Type):
  Let topology: Topology(X)
  Let start,finish: X
  Let path: Path(X,topology,start,finish)
  Constructor: based path

Let P: BasedPath(X)
-- P.path has type Path(X,P.topology,P.start,P.finish).
```

The carrier X remains an explicit parameter. The constructor takes X followed by
all fields in declaration order: `based path(X,t,x,y,p)`. A record value is
introduced with the ordinary `Let P = ...`. Dot notation reads a field; a field
containing an ordinary Function may be applied as `P.map(x)`.

## Grammar and layout

The authoritative generated grammar is `grammar/clean.lark`. Add:

```ebnf
structure_header = "Structure" identifier "(" [ parameters ] ")" ":" ;
structure_body   = (typed_let | structure_metadata)+ ;
structure_metadata = "Constructor:" callable_name
                   | "Render latex:" template
                   | "Describe:" template
                   | "Describe plural:" template ;
projection       = atom ("." identifier)+ [ "(" [ arguments ] ")" ] | atom ;
index_reference  = identifier ("." identifier)+ ;
type_argument    = type_ref | unsigned_integer | index_reference ;
```

The fragment above describes the structure-specific semantic subset of the common
`declaration` grammar: non-structure fields accepted by the common document grammar
are rejected during structure validation. Constructor values must themselves parse
as ordinary callable names. Metadata is collected independent of its position;
parameter and field order is significant. Exactly one Constructor is required.
Render/Describe fields are optional and use header parameters as placeholders.
At least one field is required. A final header colon is required, as for current
Type headers. Keywords accept flexible capitalization; field names are case-sensitive.

Projection binds more tightly than exponentiation. `P.inner.lower` is left-associated.
`P.map(x)` parses as Apply(Projection(Local(P),map),[Local(x)]), regardless of the
field's type. `f(x)` retains its existing named Call tree. Parentheses around a local
normalize away. A trailing dot requests continuation under the existing indentation
rules; parentheses also permit continuation. Tabs, comments and docstrings retain
their existing rules. An attached docstring documents the structure declaration,
not each generated projection separately.

The type grammar admits field references only as arguments, not as constructor
heads. `Path(X,P.topology,P.start,P.finish)` has one constructor tree with three
Projection arguments. `P.carrier` is not a type annotation in this slice. Neither
`f(x).field` as a type index nor arbitrary arithmetic in type arguments is added.
Field-call results cannot be immediately projected again; name the result first.

The literal dot is a new mathematical-expression delimiter. Decimal literals were
not supported previously and are still not introduced. Lean module names and
opaque Lean bodies retain their own lexical rules.

## Binding, nominal identity, and universes

Resolve header parameters left to right with explicit types. Resolve each field
Let type before binding any name in its group. Field types may mention header
parameters and earlier fields. Names must be fresh relative to preceding fields,
parameters, and visible type/alias names; generated Lean constructor/recursor
names `mk`, `rec`, `recOn`, and `casesOn` cannot be field names. Constructor names
must be fresh callable names distinct from visible types/aliases and the new type.

Do not install the new type until field validation finishes. Thus recursion and
forward references fail, including cycles through the structure currently being
declared. Re-importing a module uses the existing explicit import identity rule.
Two independently declared record names remain distinct even with identical fields.
No structural subtyping or hidden coercion is performed.

The generated declaration is explicitly in Lean Type 0. Header carrier parameters
range over Type 0; a field of type Type is rejected with a higher-universe diagnostic.
An opaque imported field type must also fit this declared sort when Lean checks the
module. Source-only `cleanlang check` cannot certify opaque Lean universe obligations.
A bundle containing its own carrier, such as a universe-polymorphic bundled space,
remains a separate extension. Fixed-carrier bundles already work.

`Assume` fields/proof fields are not admitted. Mathematical hypotheses remain named
conditions in the theorem. A field declared Proposition would store a proposition,
not a proof of a specified condition. Do not use it to fabricate an invariant.

## Constructive Lean map

For ordered parameters p and fields f:

1. Emit a fresh deterministic nominal Lean `structure` declaration with those
   parameter types and ordered dependent field types, explicitly targeting Type.
   Quote generated binder/field identifiers so a Lean keyword cannot change parsing.
   Lean 4.24.0's ordinary structure elaborator generates its single constructor,
   projections and recursors. No deriving handlers or additional instances are emitted.
2. Register its Clean type constructor with the existing ordered type/value/dimension
   parameter kinds. The Lean type template applies the generated structure constant
   to every parameter explicitly. Optional display templates do not affect this map.
3. Emit a noncomputable constructor wrapper whose explicit parameters are all header
   parameters followed by all fields. Its body is `@Record.mk` applied to that list.
   Constructor calls use the structural dependent-call procedure even for a record
   with no dependent fields. No parameter is silently inferred for a constructor.
4. Resolve a projection by the receiver's exact canonical record type and exact
   field name. The receiver must be a stable reference: Local or a chain of
   Projections rooted at Local. Computed receivers require a preceding Let.
   Instantiate header parameters from the receiver's type. Traverse fields in order,
   substituting every earlier field dependency with its projection from that same
   receiver. Emit `@Record.field` with header parameters and the receiver explicitly.
5. Represent projected value/dimension indices by the complete reference path, the
   corresponding bound Lean projection, and its LaTeX representation. No dependency
   is replaced with a free source-spelled field name. A quantified record's projections
   refer to its fresh bound Lean local. Nested record references retain the whole path.
6. Extend dependent-call index arguments from named locals to stable field references.
   Type argument checking uses the same projection rule. A record's natural-valued
   field may supply a dimension, for example `Vector(V.size,Real)`. Matching remains
   exact structural reference equality, never equality through hypotheses/conversion.
7. For Apply on a function field, require the explicitly imported ordinary arrow
   binding and one compatible domain argument. Emit ordinary Lean function application;
   the codomain is the field's instantiated function codomain. Dependent Pi-valued
   fields are not added by this rule.

Explicit type-valued callable parameters now also use structural substitution,
even when their signatures have no ValueIndex. This is necessary for an authored
operation `reversed bundle(X,P)` to work equally with a caller's carrier Y. Legacy
nondependent calls with only implicit types remain unchanged.

An example target, using a schematic stable record identifier, is:

```lean
structure BasedPathRecord (X : Type) : Type where
  topology : TopologicalSpace X
  start : X
  finish : X
  path : @Path X topology start finish

-- Source: P.path
@BasedPathRecord.path X P
-- Type: @Path X P.topology P.start P.finish
```

## Uniqueness and rejection boundaries

The strict generated grammar fixes field-access precedence and scope without any
type information. IndexReference is disjoint from type application at its first
dot/open parenthesis. A field call has a distinct Apply tree; it cannot be reparsed
as a global callable with a dotted name. Structure headers use a distinct document
keyword and grammar entry point. Metadata duplicates are errors.

After parsing, a nominal receiver type selects one record declaration. Its field
name selects exactly one ordered field; substitution is one structural traversal.
Constructor argument positions and explicit parameter targets are fixed. No
candidate search, import-order override, or successful Lean elaboration selects
an alternative. Wrong receiver types, missing fields, wrong endpoint/topology
indices, mismatched carriers, and computed receivers/indices are explicit errors.
Resource failure remains incomplete analysis rather than uniqueness evidence.

The exact Lean command elaborator and opaque imported type/body behavior inherit
the project's general conformance audit. The fixed-sort record fragment and its
oracles are not a claim of whole-language conformance or universe generality.

## Acceptance evidence

- `tests/test_structures.py`: independent projection and field-call trees, projected
  index trees, constructors, dependent/nested fields, natural dimensions, wrong
  receiver/field/index cases, nominal distinction, binder hygiene, function fields,
  explicit carrier substitution, declaration ordering, layout and doc attachment.
- `studies/topology/Bundles.clean`: six actual statements with generated Lean, LaTeX,
  and kernel-checked proofs. Endpoint shifting and path reversal are authored in Clean.
- `studies/topology/verify_bundles.py`: independent native records and definitions;
  canonical comparisons of structure types, constructor signatures/shapes, projection
  types/bodies, wrapper types/bodies and theorem statements. The fixed name map relates
  oracle record identities to generated identities; it does not erase field order,
  indices, instances, universes, binder kinds, or mathematical operations.
- Generated strict parser/lexer checks, existing corpus proofs, path/index specimens,
  editor scopes, reference/browser checks and typeset specimen inspection.

The acceptance catalog records the inherited and deliberately unimplemented boundaries.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Explicit computed indices

[Computed indices](computed-indices.md) extends a value/dimension argument with
an explicitly parenthesized, binder-free expression. It also permits compound
actual value arguments in dependent calls. Substitution works on expression trees;
matching remains structural, with no local-alias unfolding or inversion of
computations. This supersedes the earlier requirement to name every computed
index first. Type-valued arguments remain named carriers.
:::
