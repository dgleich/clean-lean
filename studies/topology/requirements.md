:::llm gpt-6 2026-11-06 role=assisted

# Topology port: concrete requirements and decisions

This study contains a working foundation and five pending targets. The target
files are review inputs, not successful translations. No theorem is discharged by
assuming its conclusion, postulating its supporting interface, or renaming a Lean
paper-specific implementation.

## Current implementation boundary

The chronological notes below record earlier milestones and their then-open gaps.
The current checked modules now include named/computed indices, dependent calls,
proof-bearing records, fixed universes, bounded definition conversion, ordinary
and relative singular homology, inclusion-induced relative maps, and fixed-target
well-group intersections. See [well groups](well-groups.md) for certificate
completeness and [pair composition](pair-composition.md) for explicit identities
and composition. Immediate binder-free lambda contraction now permits generic
congruArg to produce field-equality evidence entirely through Clean expressions.

Dependent function fields, proof-valued functions, and graded homology objects/maps
are now checked in the [dependent-function study](../dependent-functions/README.md).
Saved graded-family indices are stable under later locals. Still open are general
universe polymorphism, the pyramid and its basis extension, algorithm constructions,
relative functor laws, connecting maps, exactness/excision and the five research
theorem proofs. These mathematical
obligations must not be conflated with merely parsing their proposed signatures.

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
inductives or fields that store carrier types. Proof fields are now supported by
explicit `Evidence` types, including proof-valued dependent functions. The
[zigzag study](../zigzag-bases/README.md) exercises actual vertex bases and their
support/compatibility evidence.
A full pyramid still requires actual diagram and homology definitions, including
any higher-universe and proof-field requirements. Encoding it as an unconstrained name is not a solution.

## Target obligations

| Target | Required data/construction | Proof dependency | Current language/interface status |
|---|---|---|---|
| Big Steps 9 | Finite complex; ordered filtration; boundary; lazy reduction; Algorithm 2 run and accumulated p-simplices | Reduction and transposition invariants; equality with independently computed initial row support | Finite collection and recursive algorithm interfaces remain unfinished; indexed input/output types are supported in the bounded profile |
| Interlevel 1 | Graded relative-homology pyramid and bottom zigzag, fixed interval labels, basis restriction | Basis flip across exact diamonds, compatibility and extension | Indexed records and dependent fields are implemented; [actual zigzag/basis data](../zigzag-bases/README.md) exists, but pyramid and restriction constructions remain missing |
| Interlevel 3 | Thickening, level inclusions, inclusion-induced ranges, perturbation-indexed intersection | Two extreme perturbations and an applicable Mayer–Vietoris intersection lemma | Homology, submodule and perturbation interfaces now exist; the level-set specialization and its theorem have not been assembled |
| Interlevel 4 | Endpoint selection and relative pairs, translated pairs, relative ranges | Relative version of the preceding argument | [TwoImageCandidate.clean](TwoImageCandidate.clean) is a translated singular-homology candidate over actual definitions; reverse inclusion and the cover/excision audit remain open |
| Mayer–Vietoris | Chain-level sequence and connecting maps for an open cover | Excision and the long exact sequence construction | Graded objects/maps are implemented; connecting maps and an authored sequence/exactness interface remain missing |


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

:::llm gpt-6 2026-11-06 role=assisted

## Actual absolute homology interface

[Singular homology](singular-homology.md) now wraps the pinned native functor on
bundled spaces with bundled module coefficients. Identity and composition of its
class action are proved. This replaces the absolute homology availability question
with actual checked interfaces. Relative homology, linear ranges in a shared
ambient module, exactness/excision and the five research targets remain open.
A recorded source-type alias/index gap must be resolved before composing generic
module algebra with the current HomologyClass interface.
:::

:::llm gpt-6 2026-11-06 role=assisted

The computed-index extension now resolves generic module-map/range composition:
HomologyClass is a transparent Clean alias, and homology image is authored as the
range of the native induced linear map. The earlier carrier-interoperability gap
no longer blocks explicit computations. General local-alias conversion is still
unsupported. Relative homology, exactness/excision and paper constructions remain
open; the range-membership proof is not a well-group characterization.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Authored interlevel data

[Interlevel data](interlevel-data.md) now implements all four endpoint selections,
problem records, intervals, expanded/shifted/perturbed pairs, and uniform
perturbation bounds. Their preparatory inclusions are proved. This resolves the
finite-choice and base pair-data requirements using existing syntax. It does not
provide proof-bearing maps of pairs, relative homology, the well-group intersection
or its two-image characterization; those remain open.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Interlevel certificates

The [certification bridge](interlevel-data.md#certification-bridge-and-an-exposed-language-gap)
now proves existence of a certified expanded pair and certified inclusions of
bounded shifts and perturbations. These results construct proof-bearing records
from the earlier inequalities, preserving all component sets. The continuous
pair maps are available through `pairs.clean`. This does not yet construct relative
homology. Direct Clean composition of certificate constructors exposes a remaining
computed-record projection/reduction gap, recorded in that same report.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Relative object construction

[Relative singular chains and homology](relative-homology.md) now constructs the
relative chain complex as the cokernel of the inclusion-induced singular chain
map, and applies the homology functor in the selected degree. The definitions are
authored in Clean over generic native chain adapters. Sixteen exact target checks
and four kernel checks pass. Relative induced maps, exactness/excision and the
research theorem proofs remain unfinished; the report distinguishes definition
checks from mathematical theorems and records the computed-index conversion gap.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Induced quotient maps

[Chain squares](chain-squares.md) now supplies proof-bearing commuting squares,
induced cokernel maps and induced homology maps. The pair-inclusion study proves
that the actual four singular-chain maps form such a square. Seventeen canonical
targets and two kernel-checked proofs cover these interfaces. The square witness
is explicit; packaging the relative functor and converting its computed indices
remain open, as do exactness/excision and the research targets.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Named relative-map interfaces

[Relative maps](relative-maps.md) now authors the relative projections, induced
chain/homology maps and their images using named relative-object indices. The
bounded authored-definition conversion rule resolves the previously recorded
expansion mismatch. Eight canonical targets and three Lean proofs check these
interfaces. Explicit commutativity evidence is still passed; the study proves
that condition universally. Relative functor laws, exactness/excision and the
paper results remain unfinished.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Shifted perturbations and images

[Shifted perturbations](shifted-perturbations.md) now defines the maps f−t and their certified
homology images in Clean. Eleven canonical targets and six proofs check the sign
convention, pair equality, uniform bound, certificate existence/independence and
well-group containment in every shifted image. Twenty supporting proofs are
rechecked. Certificates remain explicit; the reverse extreme-image inclusion and
the closed-cover/excision audit remain open. No new syntax is needed for this slice.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Actual two-image expression and candidate statement

[Extreme images](extreme-images.md) now authors the two certified extreme images and their
binary intersection. The full equality translates using scalar-field coefficients
in a chosen degree, but is explicitly an unproved singular-homology candidate.
Eighteen exact targets and four new proofs cover the interfaces, existence,
certificate independence and forward inclusion; twenty-six supporting proofs are
rechecked. The source's relative Mayer–Vietoris argument still needs a justified
cover/excision theorem in this model. Automatic assumption naming now handles
record fields such as P.space, with unchanged collision rejection.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Readable local names for dependent objects

[LocalNames.clean](LocalNames.clean) names source/target homology modules and chain
complexes once, then uses them in image membership and quotient commutation.
[Local definition conversion](../../docs/local-definition-conversion.md) resolves
the earlier local-alias gap without erasing the Lean lets. Two exact native
proposition comparisons and two proofs check the specimen; [PDF](LocalNames.pdf).
Binder-bearing local definitions and the previously listed research obligations
remain open.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Concrete zigzag data

The [zigzag-bases study](../zigzag-bases/README.md) now defines module diagrams,
oriented finite zigzags and actual interval-basis records in Clean. Its native
checks construct a constant-zigzag basis from a supplied module basis. The pyramid,
diamonds, compatible restrictions/extensions and their existence proofs are still
pending; this example does not establish the paper's Theorem 1.
:::
