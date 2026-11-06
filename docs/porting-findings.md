:::llm 2026-10-23 role=assisted

# Porting with authored Clean definitions

The October 19 checkpoint has 92 proved validation fixtures: 23 statements in each
of linear algebra, graph theory, analysis, and CLR-aligned algorithms. The twelve
new ports reuse source lemmas to exercise authored definitions; there are still
80 distinct Mathlib source declarations. These are adaptations and are tagged
accordingly. Clean itself still authors statements, not proofs.

## Definitions now authored in Clean

- Linear algebra: commutator and matrix square.
- Analysis: square, squared distance, and trigonometric energy. The latter two
  call `square`, exercising composition of Clean definitions.
- Graph theory: common neighbors (replacing its Lean body) and nonadjacency.
- Algorithms: coprimality as `gcd(a,b) = 1` (replacing its Lean body), and a sorting
  certificate as sortedness together with permutation of the input.

See the corresponding `library/*.clean` and `corpus/*.clean` files. Existing
common-neighbor and coprime results also validate the replaced definitions.
One useful failure: Lean dot notation on a coprimality hypothesis stopped finding
methods once its visible type became an equality. Explicitly naming
`Nat.Coprime.lcm_eq_mul` and `Nat.Coprime.dvd_mul_right` fixes the validation proofs
without changing the Clean statement or adding a Lean definition. Definitional
equality alone does not make every Lean surface syntax interchangeable.

## Remaining reasons to return to Lean

| Need exposed by the ports | Missing Clean facility | Next specimen |
| --- | --- | --- |
| Define degree, volume, cut weight | Module-declared binding forms with scoped lambdas and finite domains | Single/double finite sums |
| Define graph conductance | Predicate-bound minimization, finite subsets, explicit empty-domain policy | Ordinary conductance, separately from mu-conductance |
| Define function composition pointwise | Lambda/function-body syntax and bound-variable scope | Continuity of an authored composite function |
| Define insertion sort itself | Pattern matching, recursion, termination and inductive constructors | Insertion followed by insertion sort |
| State generic algebra results | Type parameters, typeclasses, explicit instance/coercion policy | Matrix trace over a general commutative ring |
| Produce full mathematical exposition | LaTeX rendering for definition declarations | Definitions preceding their results |

Existing adapters for sorting, gcd, adjacency, elementary functions, determinant,
and trace remain. No new Lean-body mathematical adapters were introduced in this
checkpoint. Importing primitives is a boundary; implementing higher-level
mathematics in adapters is a gap to remove, not the completion criterion.

## Validation boundary

The Python suite covers declaration forms, field reorder, grouped parameters,
composition, layout, missing/conflicting fields, recursion/forward references,
return mismatch, attribution, and default rendering. The 92 corpus proofs check
that the generated statements follow from the indexed Mathlib lemmas.
`verify_definitions.py` independently specifies three expression trees and three
fully elaborated Lean targets/types, comparing structure without reduction.
Its comparator also rejects changes to binder explicitness and a reducible body.

Those checks do not certify the whole language. Full declaration ASTs,
module-local import isolation, canonical polymorphic/universe handling,
ambiguous/incomplete elaboration, generic operator declarations, and structured
type lowering remain open. The acceptance catalog explicitly retains pending
obligations. Minimum's empty-domain policy is not silently chosen by this work.

Checkpoint checks: 115 Python tests pass with the BibTeX optional dependency; all
92 corpus proofs and the structural-target fixture pass Lean 4.24.0. The 14-page
LaTeX specimen compiled twice with no overfull boxes or unresolved references;
the new analysis and sorting pages were inspected. The HTML reference passed
desktop/mobile, search/filter, anchor, and no-JavaScript checks.


:::

:::llm gpt-6 2026-10-29 role=assisted

## Magnetic forward identity: proof milestone and remaining boundaries

The [magnetic proof project](../studies/magnetic/README.md) now proves the forward
Fourier identity for arbitrary walk lengths. Its phase, adjacency, and unnormalized
Laplacian are Clean `Equals` definitions. Three visible `From Lean` definitions
remain for the degree diagonal, word-profile filter/product/sum, and Fourier sum.
They require finite binders, list enumeration/filtering, and recursion; no parser
extension is claimed here. Proofs inhabit the actual translated Clean propositions.
The pinned source's inverse formula has a checked counterexample at m = 1, so its
odd-length endpoint must be resolved before porting it as a theorem.

:::


:::llm gpt-6 2026-10-29 role=assisted

The later self-contained study supersedes the three `From Lean` boundaries above:
word enumeration, profiles, degree sums, and the Fourier sum are now Clean-authored
using generic finite operations and [typed function expressions](function-expressions.md).
See [the five study artifacts](../studies/magnetic/README.md).
:::

:::llm gpt-6 2026-11-06 role=assisted

## Authored bundle milestone

Finite fixed-carrier records, constructors and dependent projections now work in
Clean. The topology bundle study authors endpoint shifting and path reversal without
Lean bodies. A field's natural dimension and an ordinary function-valued field are
also checked. The remaining representation gaps are records storing their own
carrier types (universes), proof fields/invariants, and dependent function-valued
fields. Projected values are stable indices; equating a separately named alias to
its projection still needs a future definitional-equality/transport policy. None of
these gaps justifies importing a paper-specific mathematical construction wholesale.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Subspaces and a concrete universe requirement

The explicit algebra module can define arbitrary admissible indexed intersections
as actual Submodules in Clean. Carrier projection needed an explicit `Submodule.setLike`
instance: a bare `U.carrier` attempted ambient typeclass synthesis and was replaced
with the fully specified projection. Infimum similarly supplies `Submodule.instInfSet`
explicitly. Canonical target comparisons retain these choices.

The pinned native singular-homology API takes bundled TopCat and coefficient-category
objects. Direct Lean checks confirm TopCat.{0} and ModuleCat.{0,0} K are Type 1.
The current Type binding wrapper's fixed Type-0 result is therefore insufficient.
Explicit universe metadata/type-field semantics are the next language requirement;
substituting an unstructured Type-0 name would not be a valid implementation.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Singular homology carrier interoperability

Actual Mathlib homology objects/maps now compile and satisfy identity/composition
laws through explicit Clean modules. [The study note](../studies/topology/singular-homology.md)
records an actionable gap: a named computed module's ModuleElement type is not
structurally equal to the HomologyClass wrapper. Generic linear-map ranges require
a deterministic computed-index/transparent-alias rule or an explicit typed bridge.
The current native action remains linear in Lean, but its Clean-authored lambda
exposes only an ordinary function. Relative homology and excision are mathematical
construction gaps, distinct from this source-type interoperability problem.
:::

:::llm gpt-6 2026-11-06 role=assisted

The computed-index extension now resolves generic module-map/range composition:
HomologyClass is a transparent Clean alias, and homology image is authored as the
range of the native induced linear map. The earlier carrier-interoperability gap
no longer blocks explicit computations. General local-alias conversion is still
unsupported. Relative homology, exactness/excision and paper constructions remain
open; the range-membership proof is not a well-group characterization.
:::
