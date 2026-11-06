:::llm gpt-6 2026-11-06 role=assisted

# Mathlib foundations used by the topology study

The project remains pinned to Mathlib v4.24.0, revision
`f897ebcf72cd16f89ab4577d0c826cd14afaafc7`. This inventory describes that checkout,
not the current Mathlib main branch. Imported foundations have real mathematical
definitions; a name in a proposed paper interface is not automatically an import.

## Implemented algebra interface

[library/algebra/linear_spaces.clean](../../library/algebra/linear_spaces.clean)
imports the existing foundational type/set/lambda vocabulary and
`Mathlib.LinearAlgebra.Span.Basic`. It declares:

| Clean object | Native Lean meaning |
|---|---|
| `FieldStructure(K)` | `Field K` |
| `AdditiveGroup(V)` | `AddCommGroup V` |
| `ModuleStructure(K,f,V,a)` | `@Module K V f.toSemiring a.toAddCommMonoid` |
| `LinearSpace(K,f,V)` | Clean-authored record with addition and module-action structures |
| `Subspace(K,f,V,L)` | `@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action` |
| `subspace carrier(f,L,U)` | Explicit `SetLike.coe` using `Submodule.setLike` for those structures |
| `subspace infimum(f,L,S)` | Explicit `sInf` using `Submodule.instInfSet` for those structures |

The carrier K is distinct from its field structure f. Likewise, the carrier V is
distinct from the chosen additive and module structures in L. Values of the same
underlying carrier can support different structures; the API preserves that
choice in the types. No globally selected field/module instance is installed by
the Clean declarations. Foundational parent projections such as `f.toSemiring`
are elaborated in the pinned Lean environment and checked in canonical targets.

The constructor `linear space(K,f,V,a,m)` requires an actual Mathlib module
structure m over the supplied field and additive structures. This is not a record
of arbitrary operations without their axioms. The imported Mathlib structures
already contain their algebraic laws. Clean-authored proof fields remain a distinct
language requirement.

## Authored definitions and checked results

Membership and subspace inclusion are authored in Clean from the carrier operation.
The indexed intersection is also authored in Clean:

```clean
Define intersection of subspaces(f,L,A,spaces):
  Let K,V,I: Type
  Let f: FieldStructure(K)
  Let L: LinearSpace(K,f,V)
  Let A: Set(I)
  Let spaces: Function(I,Subspace(K,f,V,L))
  Returns: Subspace(K,f,V,L)
  Equals:
    subspace infimum(f,L,
      set of(function(U: Subspace(K,f,V,L),
        there exists (i: I, i ∈ A and U = spaces(i)))))
```

The result is a Submodule of the same ambient space, not a set that has forgotten
its linear structure. It is an intersection over an arbitrary admissible index set
A, not merely a finite collection. With no admissible indices, every ambient vector
belongs to the intersection. More admissible indices give a smaller intersection.

[Subspaces.clean](Subspaces.clean) states these four results using a shared context.
[SubspacesVerified.lean](SubspacesVerified.lean) contains 19 independent canonical
checks of imported interfaces, the authored record and definitions, and theorem
statements, followed by four proofs. The comparison keeps explicit instances,
universes, dependency indices and field order; it does not use definitional equality
as a replacement for target comparison. Tests reject mixed scalar structures and
mixed ambient linear-space bundles even if their underlying carrier types coincide.

Run `LAKE=lake python3 studies/topology/verify_subspaces.py` to regenerate and check.

## What this supplies for well groups

A well-group construction needs a family of images inside one fixed homology space
and a precise set of admissible perturbations. The indexed intersection operation
now exists with the required ambient-space discipline. Its membership and upper-bound
lemmas can be reused after that family is actually defined.

This does not identify perturbations, build relative homology maps, or establish
that two extreme perturbations suffice. The two-image characterization must remain
a theorem, not the definition of the intersection. The paper targets remain pending.

## Remaining foundational work

- Continuous-map and homology objects/maps need explicit bindings at their actual
  universe levels. Mathlib's singular-homology source in this pin is
  `Mathlib/AlgebraicTopology/SingularHomology/Basic.lean`; its main interface is the
  categorical `AlgebraicTopology.singularHomologyFunctor`, with coefficient-category,
  coefficient-object, topological-space and degree parameters. Direct Lean checks
  confirm `TopCat.{0} : Type 1` and `ModuleCat.{0,0} K : Type 1` (with its ring
  structure supplied). Thus the current Type-0 wrapper-result restriction is a
  concrete blocker for exposing these bundled objects. Their caches have been
  installed at the existing pinned revision; no upgrade is needed.
- Linear-map images/ranges and their shared scalar structure need the next algebra
  interface. The current module supplies subspaces and infima, not image maps.
- Relative homology, the required excision hypotheses, and the relevant exact
  sequence must be audited against the pinned implementation. The mere presence
  of a file named MayerVietoris in the sheaf library does not supply the classical
  singular-homology theorem used by the papers.
- User-authored proof fields, carrier-containing bundles and the universe/type-field
  interface remain language work. Explicit fixed carriers let this algebra layer
  make progress without claiming those features are already implemented.

No library version has been upgraded and no research theorem has been postulated.
:::
