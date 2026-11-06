:::llm gpt-6 2026-11-06 role=assisted

<!-- Generated from comparison.html by tools/comparison_markdown.py. -->

[Side-by-side HTML version](comparison.html) · [Current study status](README.md)

# Topology in Clean and Lean

[Read this report as Markdown on GitHub](comparison.md).

**Update:** this original comparison preserves proposed interfaces. See the [working study](README.md) and [current syntax decisions and blockers](requirements.md). Scoped quantifiers, dependent calls, fixed-carrier authored structures with field references, and an authored topology foundation are now implemented; the five target theorems remain pending. Actual bundled spaces and absolute singular homology now have [checked interfaces and functor-law proofs](singular-homology.md). Endpoint choices and perturbation pairs now have [authored definitions and inclusion proofs](interlevel-data.md). The [interlevel two-image candidate](TwoImageCandidate.clean) now translates using implemented definitions; its forward inclusion is proved, while the full equality and homology-model audit remain open. See [the current checked construction](extreme-images.md).

Design report · 5 November 2026 · Clean baseline: commit 460014e

Five theorem comparisons, the definitions behind their notation, and a plan for a standard topology library.

## How to read these comparisons

These are proposed mathematical interfaces and statement shapes, not compiled ports. All five Lean panels use proposed `TopologyStudy` vocabulary that is **not in Mathlib or this repository**. No proof, axiom, or `sorry` is added. The displayed `def … : Prop` follows Clean’s actual statement-only output model; proving it later requires a separate Lean theorem.

Clean panels show the authored form we want. Their standard declaration layout exists, but the paper-specific topology types and functions remain missing. In particular, binder phrases, dependent mathematical types, generic fields, and indexed families below require work. Each source abbreviation in an Attribution line denotes a proposed explicitly imported Source declaration: `bigsteps`, `interlevel`, and `hatcher`. Proposed imports would be `topology/basic.clean`, `topology/homology.clean`, and study-specific persistence modules. The basic topology module and an initial absolute singular homology module now exist. These original panels retain their proposed signatures. Implemented relative homology and the current two-image candidate are linked above; the persistence constructions remain pending.

The comparisons target field coefficients, unreduced homology unless stated otherwise, and continuous real-valued functions. Fix the coefficient field and homological degree explicitly; do not identify vector spaces merely because their dimensions agree.

## Topological Optimization with Big Steps — Theorem 9

The finite algorithmic case: the accumulated critical set equals a row-support filter from the initial lazy reduction. Read together with Algorithm 2 and equation (2), not as a theorem about an arbitrary matrix. [Nigmetov–Morozov, §3.2, p. 7](https://mrzv.org/publications/topological-optimization-big-steps/manuscript/).

### Clean — proposed specimen

```clean
Result increasing death critical set:
  Attribution: bigsteps; Theorem 9; adapted
  Let F: Field
  Let K: OrderedFilteredComplex(F)
  Let p: Natural
  Let L: LazyReduction(K,p)
  Let τ: NegativeSimplex(L)
  Let target: Real
  Assume increase: value(K,τ) < target
  Conclude:
    accumulated critical set(K,L,τ,target) =
      simplices s in p simplices(K)
        satisfying:
          value(K,τ) ≤ value(K,s)
          and value(K,s) ≤ target
          and entry(inverse change basis(L),τ,s) ≠ 0
```

### Lean — statement shape

```lean
-- Proposed types carry the input invariants.
def increasingDeathCriticalSet
    (F : Type u) [Field F]
    (K : OrderedFilteredComplex F) (p : ℕ)
    (L : LazyReduction K p) (τ : NegativeSimplex L)
    (target : ℝ) : Prop :=
  K.value τ.simplex < target →
    accumulatedCriticalSet K L τ target =
      (K.pSimplices p).filter (fun s =>
        K.value τ.simplex ≤ K.value s ∧
        K.value s ≤ target ∧
        L.U τ.simplex s ≠ 0)
```

**Definitions owed:** a finite complex, an explicit total order refining filtration and face order, its boundary matrix, the actual lazy reduction algorithm, and its factorization D = RU with U the inverse of its change-of-basis matrix. An arbitrary factorization is insufficient. `NegativeSimplex` supplies a nonzero reduced column and its pivot partner. `accumulatedCriticalSet` must implement Algorithm 2’s transposition updates, not be defined as the right-hand filter. Use initial values and matrix entries. Later coface adjustments are not additional members of this p-simplex set.

**New syntax:** a finite comprehension with a bound variable and a multiline condition. **Library work:** filtered complexes and reduction state. Recursion and state transitions are a separate language gap. Ties must follow the source algorithm’s declared ordering policy.

## Homology and Robustness — Theorem 1

This concerns a compatible interval basis of the whole graded diagram, extending the given zigzag basis. It is stronger than choosing an unrelated vector-space basis at each vertex. [Bendich–Edelsbrunner–Morozov–Patel, p. 12](https://mrzv.org/publications/robustness-interlevelsets/manuscript/).

### Clean — proposed specimen

```clean
Result level set basis extension:
  Attribution: interlevel; Theorem 1; adapted
  Let F: Field
  Let P: LevelSetPyramid(F)
  Let b: IntervalBasis(bottom zigzag(P))
  Conclude:
    there exists (B: PyramidBasis(P),
      restrict basis(B,bottom zigzag(P)) = b)
```

### Lean — statement shape

```lean
def levelSetBasisExtension
    (F : Type u) [Field F]
    (P : LevelSetPyramid F)
    (b : IntervalBasis P.bottom) : Prop :=
  ∃ B : PyramidBasis P, B.restrictBottom = b
```

**Definitions owed:** construct P from a compact space, a tame continuous function, a chosen interleaving of regular/critical values, and the relative-homology pyramid with its maps. Its interface must include the applicable Mayer–Vietoris diamonds, not the basis-extension conclusion. A pyramid basis records compatible interval generators, including degree changes across connecting maps. Index basis generators by fixed interval labels, or specify equality up to reindexing; the display chooses fixed labels.

**New syntax:** dependent types such as `IntervalBasis(bottom zigzag(P))` and an existential binder. **Library work:** diagrams, restrictions, graded spaces, interval decompositions. Arbitrary diagrams with arbitrary vertex bases do not satisfy this statement.

## Homology and Robustness — Theorem 3

Use images in the homology of the thickened level set. This is not intersection of the underlying level sets. [Source, pp. 16–17](https://mrzv.org/publications/robustness-interlevelsets/manuscript/).

### Clean — proposed specimen

```clean
Result level well group:
  Attribution: interlevel; Theorem 3; adapted
  Let F: Field
  Let X: CompactTopologicalSpace
  Let f: ContinuousMap(X,Real)
  Let p: Natural
  Let a,r: Real
  Assume radius: r ≥ 0
  Conclude:
    level well group(F,p,f,a,r) =
      intersection(
        level image(F,p,f,a+r,a-r,a+r),
        level image(F,p,f,a-r,a-r,a+r))
```

### Lean — statement shape

```lean
def levelWellGroupFormula
    (F : Type u) [Field F]
    (X : Type v) [TopologicalSpace X] [CompactSpace X]
    (f : C(X, ℝ)) (p : ℕ) (a r : ℝ) : Prop :=
  0 ≤ r →
    levelWellGroup F p f a r =
      levelImage F p f (a+r) (a-r) (a+r) ⊓
      levelImage F p f (a-r) (a-r) (a+r)
```

**Interface contract:** both images are subspaces of Hₚ(f⁻¹[a−r,a+r];F). A level image is the range of the inclusion-induced linear map. The well group intersects these ranges over all continuous perturbations h satisfying the pointwise bound |h(x)−f(x)| ≤ r. Its definition must not use the two-extreme-perturbation formula being asserted.

**Formalization issue:** choose a homology theory and establish excision for the closed decompositions used in the proof. The displayed compact-space signature mirrors the paper’s setting; it is a target to audit, not a claim that arbitrary singular homology already validates it. Adding an excision assumption would produce a conditional adaptation and must be labelled as such.

No special “well group” grammar is needed. Module-defined function calls suffice for the statement; defining the functions requires indexed intersections, quantification over maps, and typed inclusion witnesses.

## Homology and Robustness — Theorem 4

The relative version must retain the selected endpoints, rather than treating open and closed intervals interchangeably. [Source, p. 17](https://mrzv.org/publications/robustness-interlevelsets/manuscript/).

### Clean — proposed specimen

```clean
Result interlevel well group:
  Attribution: interlevel; Theorem 4; adapted
  Let F: Field
  Let X: CompactTopologicalSpace
  Let f: ContinuousMap(X,Real)
  Let p: Natural
  Let a,b,r: Real
  Assume endpoints: a < b
  Assume radius: r ≥ 0
  Let E: EndpointSelection(a,b)
  Conclude:
    relative well group(F,p,f,a,b,E,r) =
      intersection(
        shifted pair image(F,p,f,a,b,E,r,r),
        shifted pair image(F,p,f,a,b,E,r,-r))
```

### Lean — statement shape

```lean
def interlevelWellGroupFormula
    (F : Type u) [Field F]
    (X : Type v) [TopologicalSpace X] [CompactSpace X]
    (f : C(X, ℝ)) (p : ℕ) (a b r : ℝ)
    (E : EndpointSelection a b) : Prop :=
  a < b → 0 ≤ r →
    relativeWellGroup F p f a b E r =
      shiftedPairImage F p f a b E r r ⊓
      shiftedPairImage F p f a b E r (-r)
```

**Interface contract:** E selects neither endpoint, just a, just b, or both. Put Xᵣ = f⁻¹[a−r,b+r] and X′ᵣ = the union of f⁻¹[e−r,e+r] over selected endpoints e. A shifted pair at offset t is (f⁻¹[a+t,b+t], f⁻¹(E+t)). Its image lies in Hₚ(Xᵣ,X′ᵣ;F) for t = ±r. The two ranges therefore share exactly the same ambient type. Define the relative well group from all bounded perturbations and their maps of pairs.

The homology/excision issue from Theorem 3 remains. Keep the endpoint selection as data with a finite four-case definition, and prove the pair inclusions. A statement-only API can hide these witnesses for readability only after its elaboration rule uniquely determines them. No four-way overload chosen by proof search is acceptable.

## Mayer–Vietoris: the ordinary homology sequence

Choose the unreduced singular-homology version over a field, for two open subsets covering X. Other versions—relative homology, reduced homology, cohomology—need separate statements. The classical sequence and signs are described in [Hatcher, Algebraic Topology, §2.2, pp. 149–150](https://pi.math.cornell.edu/~hatcher/AT/ATch2.pdf#page=53).

### Clean — proposed specimen

```clean
Result Mayer Vietoris:
  Attribution: hatcher; section 2.2; specialized
  Let F: Field
  Let X: TopologicalSpace
  Let U,V: OpenSubset(X)
  Assume cover: union(U,V) = whole space(X)
  Conclude:
    exact(mayer vietoris sequence(F,X,U,V))
```

### Lean — statement shape

```lean
def mayerVietorisStatement
    (F : Type u) [Field F]
    (X : Type v) [TopologicalSpace X]
    (U V : TopologicalSpace.Opens X) : Prop :=
  (U : Set X) ∪ (V : Set X) = Set.univ →
    ExactSequence (mayerVietorisSequence F X U V)
```

```text
… → Hₙ₊₁(X) → Hₙ(U ∩ V) → Hₙ(U) ⊕ Hₙ(V) → Hₙ(X)
  → Hₙ₋₁(U ∩ V) → … → H₀(U) ⊕ H₀(V) → H₀(X) → 0
```

**Expand the abstraction:** maps out of the intersection send z to (i∗z, −j∗z); the next sends (u,v) to k∗u + ℓ∗v; the connecting maps come from the chain-level construction. Exactness says the image of each arrow equals the kernel of the next. Construct the sequence before proving exactness; do not define `mayerVietorisSequence` as an already-exact object. The positive-degree display terminates at H₀; never implement n−1 by truncated natural subtraction at n=0.

The compact Clean statement needs a library condition `exact`, not built-in arrow-chain grammar. Nice sequence rendering can be a later LaTeX feature. The paper also needs relative pairs and an excisive-cover theorem; the open-cover statement alone does not discharge those uses.

## A standard topology module: proposed layers

| Layer | Definitions to expose | Reason to separate it |
| --- | --- | --- |
| topology/basic.clean | Spaces, underlying types, continuous maps, subspaces, opens, compactness, preimages | Reusable without homology or persistence. |
| algebra/linear_maps.clean | Field modules, linear maps, subspaces, range, kernel, intersection | Images must retain their ambient space and coefficients. |
| topology/homology.clean | Chains, homology, relative pairs, induced maps, connecting maps, exactness | Fix theory, degree, signs, coefficients, and inclusion witnesses. |
| topology/persistence.clean | Graded diagrams, zigzags, interval bases, tame filtrations | Higher-level reusable mathematics; depends on exactness. |
| Study modules | Lazy reduction, Algorithm 2, level-set pyramids, well groups | Paper-specific definitions should not masquerade as standard primitives. |

These are proposed file boundaries, not new existing imports. Define mathematical constructions in Clean wherever possible. Import foundational Lean structures explicitly; do not hide an entire paper behind a `Means: Paper.theorem` adapter.

**Local Mathlib audit:** the pinned Lean version is 4.24.0. The checkout contains `Mathlib/AlgebraicTopology/SingularHomology/Basic.lean` and `Mathlib/Topology/Sheaves/MayerVietoris.lean`. The latter constructs a square of open sets; its filename is not evidence that it supplies the requested long exact singular-homology sequence. No drop-in theorem was identified in this inspection. This is a local inventory, not a claim about every current external Lean project.

## New syntax versus missing mathematics

| Need | Proposed parsing/translation rule | Status |
| --- | --- | --- |
| Existence | `there exists (x: T, E)` binds x only in E; lower to `Exists (fun (x : T) => E)`. | Parenthesized form implemented; mathematical domain definitions remain pending. |
| Finite filtering | `simplices s in S satisfying: …` lowers to a finite filter, binding s only in the condition. | Proposal; prefer a generic filter binder over a simplex-specific keyword. |
| Indexed intersections | Bind the index, its type, and restriction separately; lower to a fixed submodule infimum construction. | Needed to define well groups; spelling undecided. |
| Dependent types | Later argument types may depend on earlier values; fix universe and structure-instance insertion rules. | Named indices implemented; dependent callable signatures and bundles remain pending. |
| Families of spaces/maps | Explicit indexed types and typed restrictions; consistent index transport. | Needed for pyramids and exact sequences. |
| Recursive algorithms | Specify recursion, pattern matching, and termination before translating Algorithm 2. | Open language work. |
| Intersection, homology, exactness | Ordinary module-declared types/functions/conditions. | Library definitions, not new reserved words. |

Before adopting any row, apply the [language acceptance contract](../../docs/language-change-acceptance.md): one AST and one elaborated Lean target under a fixed explicit environment. Test nested binders, shadowing, continuation boundaries, conflicting overloads, coefficient inference, and different ambient homology spaces. Decide finite sets versus arbitrary sets before parsing; do not choose a binder’s meaning by whichever Lean target happens to type-check.

**Suggested implementation order:** first generic spaces and continuous maps; then linear-map images and exactness; then a concrete homology theory and its cover theorem; then well groups and persistence diagrams. Theorem 9 can proceed independently through finite complexes and lazy reduction. The next useful acceptance specimen is an inclusion-induced map with an explicitly typed range: it tests the hidden dependency that Theorems 3 and 4 rely on.

**Validation boundary:** source theorem numbers and surrounding definitions were read from the linked manuscripts. The snippets are not parser tests or Lean compilation results. No library module, grammar extension, or theorem proof is claimed by this report.

:::
