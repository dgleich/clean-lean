:::llm gpt-6 2026-11-06 role=assisted

# Relative singular chains and homology

The relative object is now constructed, rather than left as an undeclared name.
For a certified pair Q with relative subset A and ambient subset B, the Clean
module defines the chain map induced by A → B, its cokernel, and the homology of
that cokernel in the chosen degree. The construction uses the subspace topologies
and the supplied inclusion evidence. Both subsets belong to the same explicitly
specified TopCat object.

```clean
Define relative chains(field,H,X,Q):
  Let K: Type
  Let field: FieldStructure(K)
  Let H: HomologyTheory(K,field)
  Let X: TopologicalSpace
  Let Q: TopologicalPair(X)
  Returns: ModuleChainComplex(K,field)
  Equals:
    chain cokernel(field,singular chains(field,H,subspace(X,Q.relative)),
      singular chains(field,H,subspace(X,Q.ambient)),pair chain inclusion(field,H,X,Q))

Define relative homology(field,H,X,Q):
  Let K: Type
  Let field: FieldStructure(K)
  Let H: HomologyTheory(K,field)
  Let X: TopologicalSpace
  Let Q: TopologicalPair(X)
  Returns: CoefficientModule(K,field)
  Equals: chain homology(field,relative chains(field,H,X,Q),H.degree)
```

The new native adapters in `library/algebra/chains.clean` are generic category
operations: the natural-degree module chain-complex type, its morphism type,
cokernel, cokernel projection, composition, zero morphism and homology functor.
`library/topology/relative_homology.clean` additionally imports the native singular
chain functor's object and map actions. The pair inclusion and both relative
constructions are authored with Equals in Clean. No paper-specific Lean definition,
axiom, sorry, or theorem conclusion is imported as a definition.

## Fixed choices and native targets

K is a Type-0 carrier with an explicit Field structure. Coefficients are the
bundled module stored in H, not an implicit default copy of K. The coefficient
category is `ModuleCat.{0} K`; its chain complexes use `ComplexShape.down ℕ`.
ModuleChainComplex has result universe 1. Chain maps have Type-0 carriers.
The native morphism template specifies `Quiver.Hom` on this particular category;
using the bare HomologicalComplex.Hom structure left Lean's generic category
operations underdetermined during the prototype and was corrected before acceptance.

Each adapter installs only the supplied field instance and selects the pinned
ModuleCat/homological-complex instances. The canonical oracle retains the selected
instances and universes. It does not erase them or use definitional equality as
its comparison criterion. Existing checked pair/subspace/coefficient interfaces
are reused by identity. Sixteen independent native targets cover the new types,
operations, authored constructions and four statement propositions.

The verifier also compiles the algebra chain module on its own, so missing imports
cannot be masked by topology imports. The repository still pins Mathlib v4.24.0. The missing
`Mathlib.Algebra.Homology.HomologicalComplexAbelian` compiled locally using:

```sh
lake build Mathlib.Algebra.Homology.HomologicalComplexAbelian
LAKE=lake python3 studies/topology/verify_relative.py
```

A targeted cache fetch failed at the ProofWidgets cloud release; the successful
local build supplies the required dependency without changing the version pin.

## What is verified

- The generic cokernel projection annihilates its defining chain map, by Mathlib's
  `CategoryTheory.Limits.cokernel.condition`.
- Applying the chain homology functor to singular chains agrees definitionally
  with the existing native singular homology functor.
- Relative chains are the cokernel of the authored pair inclusion map.
- Relative homology uses that chain complex and the selected degree.

The last two are definition checks, not new homological-algebra theorems.
The categorical cokernel construction is the chosen model of relative chains;
a separate explicit identification with a concrete degreewise quotient is not
claimed here. No degree shift or negative-degree truncation is silently introduced.

## Remaining interfaces and mathematical work

Maps induced by certified inclusions of pairs still need the commuting chain
square and the generic cokernel-map interface. Functor laws for those relative
maps, connecting maps, exact sequences, excision, perturbation-indexed intersections,
and the paper results remain unfinished. The closed-cover/excision audit still
applies. Defining an object does not prove that its images characterize a well group.

A further source-side limitation remains: `relative chains(...)` and the expanded
`chain cokernel(...)` are different structural computed indices when used as the
endpoints of a ChainMap. Authored non-record definitions do not generally unfold
for index conversion. An explicit conversion rule or an appropriate transparent
interface is needed before interchangeable spellings can be promised. The current
construction avoids assuming such a conversion.

Review [Relative.clean](Relative.clean), [generated Lean](Relative.lean),
[checked Lean and native oracles](RelativeVerified.lean), and [PDF](Relative.pdf).
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
