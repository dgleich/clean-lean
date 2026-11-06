:::llm gpt-6 2026-11-06 role=assisted

# Topology port: concrete requirements and decisions

This study contains a working foundation and five pending targets. The target
files are review inputs, not successful translations. No theorem is discharged by
assuming its conclusion, postulating its supporting interface, or renaming a Lean
paper-specific implementation.

## Working foundation

`library/topology/basic.clean` defines inverse image, image, selection,
intersection of an indexed family, composition, and continuity in Clean. Its only
new imported primitives are the topology structure, openness, and set construction.
Carrier types, functions, and sets come from the existing explicit types module.

This is the chosen first representation:

```clean
Let X,Y: Type
Let t: Topology(X)
Let u: Topology(Y)
Let f: Function(X,Y)
Assume continuous between(f,t,u)
```

Topologies are explicit values. Distinct topologies on the same carrier must not
be silently identified. The generated openness adapter uses `@IsOpen X t S`, so
no implicit instance chooses t. Continuity is the authored condition that every
open set has an open inverse image. Its agreement with Lean Continuous is proved.
The first slice fixes carriers to Lean Type 0, without universe inference across
an unspecified collection of universes.

Nested universal/existential quantifiers are now specified and implemented in
[the quantifier contract](../../docs/quantifiers.md). Other binding operations need
less new syntax than the original report suggested:

```clean
selected elements(S,function(x: X, acceptable(x)))
intersection family(function(i: I, sets(i)))
```

These use ordinary declarations and the existing lambda form. `selected elements`
returns an arbitrary Set, not a Finset; an executable finite selection needs its
own finite-set module. `intersection family` is the set of elements belonging to
every indexed set. Empty index types correctly yield the universal set. An indexed
intersection of homology subspaces needs a submodule version, not a coercion that
forgets the ambient module.

**Decision:** do not add `simplices … satisfying` or `intersection over` to the
parser yet. The first is paper-specific. The second can be a future readable alias,
but it needs a module-declared binder interface and exactly the same scope as its
lambda expansion. Their mathematical operations are already expressible.

## Next language slice: arbitrary named type indices

**Status update:** constructor declarations, named value arguments, theorem
binders, aliases and prose normalization are now implemented; see the
[precise implemented contract](../../docs/value-indexed-types.md). Callable
substitution now works under the [named-argument contract](../../docs/dependent-calls.md).
Arbitrary mathematical expressions as indices remain pending.
The design below originally identified the restriction to type and natural-number arguments.
It blocks `IntervalBasis(Z)` where Z is a diagram value and `Subspace(V)` where V
is a bundled vector-space value.

Use the existing constructor/header shape and extend its parameter kinds:

```clean
Type Subspace(V: VectorSpace(F)):
  Means: ... explicit foundational Lean template ...
  Render latex: ...
```

That example also requires F to be introduced as an earlier parameter; it is not a
standalone declaration. A full signature must bind every dependency in order,
for example `Type Subspace(F: Field, V: VectorSpace(F)):`. No free F is inferred.
This spelling is a proposal, not an executable declaration.

The bounded extension should use these rules:

1. Constructor arguments remain the existing syntactic trees: constructor
   applications, names, and numerals. The parser does not distinguish a type name
   from a value name by consulting the environment. No general mathematical
   expression is added inside a type application in this slice.
2. A declared parameter has an explicit type. Resolve parameter types left to
   right; later parameter types may mention earlier parameters. For an argument
   expected to be a value, require a previously bound local name of exactly the
   instantiated parameter type. Preserve existing explicitly typed natural
   numerals. Reject nested calls in value-argument positions in this slice.
3. Normalize type applications to a constructor identity plus ordered arguments.
   Tag each elaborated argument as TypeArgument or ValueIndex. A ValueIndex stores
   the resolved local identity and Lean term, not a printable name. Do not identify
   two locals because an assumed equality relates them.
4. Substitute arguments into all later parameter types and the Lean template in
   declaration order. Preserve capture-free local identities. For a constructor
   C with template L, the target is the single instantiated L; no search through
   candidate coercions or imported instances is allowed. Any required structure
   instance must appear explicitly in the foundational template.
5. Generalize callable result signatures too: a result type may refer to an
   explicit earlier argument value. At a call, substitute the actual typed term
   into the result type. An ordinary local definition binds that resulting value
   before it can be used as a named type index. Reject escape of a bound index.
6. Equality of indices in this bounded profile is identity after the prescribed
   substitution, not arbitrary theorem proving or first-success unification.
   Require an explicit transport operation when distinct indices must be related.

The readable way to avoid general expressions inside types is already familiar:

```clean
Let Z = bottom zigzag(P)
Let b: IntervalBasis(Z)
```

The types and functions in this example are still pending. A compound expression
such as `IntervalBasis(bottom zigzag(P))` remains outside the bounded extension;
its future admission must update the grammar rather than reinterpret existing
constructor syntax using type-checking success.

Acceptance oracles must cover: two distinct diagram values of the same type;
wrong ambient spaces; earlier/later index references; nested quantified indices;
indices after a local definition; conflicting names; no instance-dependent
reinterpretation; escaped binder indices; and canonical Lean types with explicit
universe/structure arguments. Tests must compare raw elaborated structure, not
just definitional equality. The implemented subset has executable checks in `tests/test_value_indices.py`
and `verify_indices.py`. This does not establish the broader callable or
universe-polymorphic extension.

## Bundles and authored structures

The proposed paper signatures use bundled fields, modules, diagrams, and bases.
They must become actual definitions. Foundational Lean bundles may be explicitly
imported, with the selected carrier and operations fixed in their templates.
This is not permission to import a paper's whole mathematical construction.

For statements, first implement the indexed-type slice above against a small real
bundle. Fixed-carrier, nonrecursive authored records are now implemented in the
[structure contract](../../docs/structures.md), with dependent fields, explicit
constructors and scoped projections. A general universe-polymorphic record/inductive
declaration remains a separate feature:
it needs ordered dependent fields, constructor and accessor generation, universes,
and positivity rules. `Structure Name(parameters):` is specified explicitly; it does not include recursive
inductives, proof fields or fields that store carrier types.
A full pyramid still requires actual diagram and homology definitions, including
any higher-universe and proof-field requirements. Encoding it as an unconstrained name is not a solution.

## Target obligations

| Target | Required data/construction | Proof dependency | Language blocker |
|---|---|---|---|
| Big Steps 9 | Finite complex; ordered filtration; boundary; lazy reduction; Algorithm 2 run and accumulated p-simplices | Reduction invariants, transposition invariants, equality with initial row-support filter | Finite collection module, recursive algorithms, indexed input/output types |
| Interlevel 1 | Graded relative-homology pyramid and bottom zigzag, fixed interval labels | Basis flip across exact diamonds, compatibility and restriction | Indexed types, authored diagram structures; existence itself now works |
| Interlevel 3 | Thickening, level inclusions, inclusion-induced ranges, perturbation-indexed intersection | Two extreme perturbations and the applicable Mayer–Vietoris intersection lemma | Homology/submodule interfaces and their dependencies; quantification itself now works |
| Interlevel 4 | Endpoint selection and relative pairs, translated pairs, relative ranges | Relative version of the preceding argument | Same interfaces plus finite case data and relative homology |
| Mayer–Vietoris | Chain-level sequence and connecting maps for an open cover | Excision and the long exact sequence construction | Indexed groups/maps, graded sequence structures |

The target snippets specify expected interfaces, not sufficient definitions. For
Theorem 9, the two sides must be computed independently: never define accumulated
critical set as the row-support formula. For Theorem 1, PyramidBasis must encode
compatible interval generators, not arbitrary bases at each vertex. For Theorems
3 and 4, all images must have one explicitly identical ambient homology type.

## Mathematical conventions that must survive the port

- Use field coefficients for the paper comparisons; select the field and module
  structures explicitly. Finite rank alone is not an identification of vector spaces.
- Preserve grading and degree shifts. Ordinary homology ends at degree zero;
  natural-number subtraction must not turn the next degree into zero again.
- For Mayer–Vietoris, begin with ordinary singular homology and an open cover.
  Fix the intersection-to-sum map as `(i*, -j*)` and the sum-to-union map as `k*+l*`.
- Before applying that theorem to the papers' closed decompositions, establish the
  required excision result or select and justify a different homology framework.
  Compactness alone is not silently converted into an open-cover hypothesis.
  This is a mathematical audit obligation, not missing surface syntax.
- Fix the diagram index set and interval labels before equality of restricted
  bases is stated. If reindexing is needed, express that equivalence explicitly.
- Perturbations are continuous maps with the pointwise uniform bound. Their
  support maps and ambient spaces belong to the definition of the well group;
  the two-extreme-perturbation formula belongs only to its theorem.

These are implementation decisions and proof obligations recorded for review.
The study does not claim to have resolved the closed-cover homology audit or
proved any of the five target theorems.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Explicit algebra foundation milestone

The [linear-space module](../../library/algebra/linear_spaces.clean) now supplies
field/additive/module structures, subspaces, carriers, infima, and a Clean-authored
intersection over an admissible index set. The result remains a Submodule with the
same explicit scalar and ambient structures. Four algebraic results are proved;
see the [foundation inventory](mathlib-foundations.md). This discharges the basic
subspace/intersection interface requirement, but not linear image maps, homology,
relative pairs, perturbations, excision or the five target theorem proofs.
:::
