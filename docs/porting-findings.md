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
