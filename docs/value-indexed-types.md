:::llm gpt-6 2026-11-06 role=assisted

# Named values as type arguments

Clean keeps the ordinary mathematical spelling `Basis(V)`, `Path(X,x,y)`, or
`IntervalBasis(Z)`. The constructor declaration determines what each argument
means. Parsing does not guess whether an argument is a type or a value.

**Implemented scope:** type declarations with ordered, explicitly typed parameters;
theorem/context binders and quantifier domains using earlier named values; type
aliases; module-declared prose phrases; Lean and LaTeX output. Dependent callable signatures are now supported under the
[named-argument rules](dependent-calls.md); stable field references are also supported by [structures](structures.md).
[Explicit computed indices](computed-indices.md) now support parenthesized binder-free expressions; arbitrary binder-bearing indices remain unsupported.

## Syntax: one constructor tree

The existing generated grammar already provides this shape:

```ebnf
type_ref       = identifier [ "(" [ type_arguments ] ")" ] ;
type_arguments = type_argument { "," type_argument } ;
type_argument  = type_ref | unsigned_integer ;
```

Parentheses match structurally. Commas separate arguments at their own parenthesis
depth. No trailing comma, operator expression, or multiword constructor head is
accepted. Single-word names and nested applications parse without consulting types:

```text
IntervalBasis(Z)
  → Apply("IntervalBasis", [Name("Z")])

Path(X,x,y)
  → Apply("Path", [Name("X"), Name("x"), Name("y")])

Function(X,Element(X,S))
  → Apply("Function", [Name("X"), Apply("Element", [Name("X"),Name("S")])])
```

The normalized syntax API is `cleanlang.syntax.type_tree`. A nullary head with
empty parentheses normalizes to the same Name as a bare head. Syntax names are
not yet classified as type arguments or value indices. `Path(X,x,y)` can have a
valid parse and still have the wrong number of arguments for the imported Path.
That is a type error, not a reason to search for another parse.

The first actual path binding is explicit about topology:

```clean
Type Path(X: Type, t: Topology(X), x: X, y: X):
  Means: @Path X t x y
  Render latex: \operatorname{{Path}}_{{{t}}}({x},{y})
  Describe: a path from ${x}$ to ${y}$ in ${X}$ with topology ${t}$
  Describe plural: paths from ${x}$ to ${y}$ in ${X}$ with topology ${t}$
```

It requires four arguments, `Path(X,t,x,y)`. It does not silently choose a topology
on X. The three-argument Path used in discussion was illustrative vocabulary, not
this module's signature. A future bundled-space module could expose three
arguments, provided the topology is fixed by that explicit bundle.

## Parameters and dependencies

Resolve constructor parameters left to right. Each parameter has an explicit
constructor-style type and a fresh name. Its type may refer to earlier parameters,
never itself or later parameters. There are three parameter classes:

- Type-valued parameters, such as X, receive a type expression.
- Natural dimensions retain the existing named-natural or numeral rule.
- Other value parameters receive exactly one earlier local identifier whose type
  matches the instantiated parameter type.

The first two classes retain the prototype's existing Type/Natural conventions;
removing that name-based coupling is still general language work. The new value
class does not dispatch on names such as Path, Basis, or Diagram.

For example, this declaration is implemented in the topology indexed module:

```clean
Type Element(X: Type, S: Set(X)):
  Means: {x : X // x ∈ S}
  Render latex: {S}
  Describe: an element of ${S}$
  Describe plural: elements of ${S}$
```

`Element(X,S)` first resolves X, then checks that S has type Set(X). It denotes a
point accompanied by evidence of membership, not the set S itself. No implicit X
is inferred for `Element(S)`: that shorter spelling would need an explicit future
constructor-inference rule or a bundled-set interface.

## Constructive elaboration

Let the declared parameter list be `(p₁:A₁, …, pₖ:Aₖ)` with Lean template L.
For each supplied argument, in order:

1. Instantiate Aᵢ using already resolved arguments. Template substitution operates
   on whole parameter identifiers, not substrings.
2. For a type parameter, resolve the existing type-expression tree. For a value
   parameter, look up the supplied local and require exact structural type equality.
   No coercion, theorem search, or assumed equality is used to repair a mismatch.
3. Store a value index as `ValueIndex(sourceName, leanLocal, latexName)`. Together
   with its constructor and other arguments this forms the canonical Clean type.
   Distinct local names remain distinct indices even if a local definition or
   hypothesis establishes their equality. This deliberately conservative slice
   does not perform definitional-equality unification of indices.
4. Instantiate L with the ordered type targets and stored value terms. The binding
   declares all foundational structure instances explicitly; the Path template
   contains its topology argument. No ambient topology search is introduced.

Fresh quantifier names are preserved inside indices. For example:

```clean
for every (x: X, there exists (p: Path(X,t,x,x), p=p))
```

lowers to the shape:

```lean
∀ (clean_bound_0 : X),
  @Exists (@Path X t clean_bound_0 clean_bound_0)
    (fun (clean_bound_1 : @Path X t clean_bound_0 clean_bound_0) =>
      clean_bound_1 = clean_bound_1)
```

The index must refer to that bound endpoint, never to a free source-spelled x.
Rendering substitutes argument trees, never arbitrary matching text inside the
Lean template. Existing universe restrictions remain: the foundational carrier
binding ranges over Lean Type 0. This is not a general universe-polymorphic API.

## Local definitions and rejected expression indices

A named local definition is accepted as an index:

```clean
Let T = inverse image(f,S)
Let x: Element(X,T)
```

The generated Lean declaration retains the local `let T`, then binds x at the
corresponding subtype. The constructor does not inspect T's body to decide its
meaning. A reference to an undeclared T is an error.

This slice rejects `Element(X,inverse(S))` as a non-name value argument, even
though its nested application syntax is parsable. `Element(X,S ∩ T)` is rejected
by the type grammar itself. Use a named local expression first. No parsing choice
is made using whether a candidate Lean term elaborates successfully.

Within `Let p,q: Path(X,t,x,y)`, resolve the common type before introducing either
new variable. Neither p nor q can be used to justify their own type.

## Prose and LaTeX

Constructor application syntax is reserved: a leading identifier followed by `(`
is parsed structurally, without trying Phrase mappings. This prevents a module
phrase from changing the meaning of `Path(...)`.

Other type phrases use the existing explicit Phrase declarations. For example:

```clean
Phrase paths? from (?P<x>\w+) to (?P<y>\w+) in (?P<X>\w+) with topology (?P<t>\w+) => Path({X},{t},{x},{y})

Let p be a path from x to y in X with topology t
Let p: Path(X,t,x,y)
```

These two declarations resolve to the same canonical type. The optional leading
article is removed; fixed phrase text matches case-insensitively, while captured
identifiers retain their case. Full matches only are considered. More than one
matching phrase is an ambiguity error **before type checking**, even if only one
candidate would type-check. Phrase normalization precedes ordinary type checking.

A future module can declare `interval basis of Z → IntervalBasis(Z)` in the same
way once its diagram and basis definitions exist. This does not introduce
“interval basis” into the core grammar.

The constructor's Describe template renders a declaration as prose; Render latex
renders the type when it occurs in a mathematical expression. Both receive the
same ordered arguments. Neither changes the type's meaning. In particular the
path declaration prints “Let p be a path from x to y in X with topology t.”

## Boundaries and acceptance

Definitions, notations, and conditions with value-indexed argument/result types
are now supported by the [dependent-call contract](dependent-calls.md). That
extension requires named arguments for positions used as indices and structural
substitution throughout the signature.
Similarly, no Basis, IntervalBasis, or SpanningTree construction is invented here.
Those require real mathematical definitions in their modules.

Validation consists of:

- `tests/test_value_indices.py`: independent neutral ASTs, malformed syntax,
  unresolved/wrong-type dependencies, declaration order, different ambient sets,
  type aliases, prose equivalence/case/ambiguity, reserved constructor syntax,
  nested quantifier capture, and indexed callable parameter support.
- `studies/topology/verify_indices.py`: four independent canonical Lean statement
  oracles and four proofs, including a constant path witness and a named preimage.
- Strict generated-parser checks, full regression tests, and typeset specimens.

These checks do not close the project's general elaboration uniqueness audit.
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
