import Mathlib.Data.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.Combinatorics.SimpleGraph.Basic
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Data.List.Sort
import Mathlib.Data.Nat.GCD.Basic

noncomputable def cleanType_469c53b6dafb7a218246  : Type :=
  ℕ

noncomputable def cleanType_107b6641a486642ad8e1  : Type :=
  ℝ

noncomputable def cleanType_2d7f06a08f8ab1e3f46d  : Type :=
  ℂ

noncomputable def cleanType_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable def cleanType_61d617e3f5143c327dd3 (p0 : Nat) (p1 : Nat) (p2 : Type) : Type :=
  Matrix (Fin p0) (Fin p1) p2

noncomputable def cleanType_b5a130b68abf7f0646e8 (p0 : Nat) (p1 : Type) : Type :=
  Fin p0 → p1

noncomputable def cleanType_460956e39f5b9ffca091 (p0 : Nat) : Type :=
  Fin p0

noncomputable def cleanType_7bde0ce024ce143f369b (p0 : Nat) : Type :=
  SimpleGraph (Fin p0)

noncomputable def cleanType_530f2b2df99696550311 (p0 : Type) : Type :=
  List (p0)

noncomputable def cleanType_6e300741358eee425e81 (p0 : Type) : Type :=
  Set (p0)

noncomputable def cleanType_9d746dbeb0e035328deb (p0 : Type) (p1 : Type) : Type :=
  (p0) → (p1)

noncomputable def cleanNotation_6aaed7bf698e562b4aa5  (x0 : List (ℕ)) : List (ℕ) :=
  (List.insertionSort (· ≤ ·)) x0

noncomputable def cleanNotation_51561cc64977417a701c  (x0 : List (ℕ)) : List (ℕ) :=
  (fun l : List ℕ => l.mergeSort (· ≤ ·)) x0

noncomputable def cleanNotation_bb5cb4068b5c2ce6d1ed  (x0 : List (ℕ)) : Prop :=
  List.Sorted (· ≤ ·) x0

noncomputable def cleanNotation_e74b2d2973b6778742ca {T : Type} (x0 : List (T)) (x1 : List (T)) : Prop :=
  List.Perm x0 x1

noncomputable def cleanNotation_6016b9cfd65d60648fc3 {T : Type} (x0 : List (T)) : ℕ :=
  List.length x0

noncomputable def cleanNotation_fc17db7c59c6361dc276  (x0 : ℕ) (x1 : List (ℕ)) : List (ℕ) :=
  List.orderedInsert (· ≤ ·) x0 x1

noncomputable def cleanNotation_8df3385d877a7d8324ae  (x0 : ℕ) (x1 : List (ℕ)) : List (ℕ) :=
  x0 :: x1

noncomputable def cleanNotation_ef3e1617947e64ecf0be {T : Type} (x0 : List (T)) (x1 : List (T)) : Prop :=
  List.Sublist x0 x1

noncomputable def cleanNotation_5c84f457aa0661a1ecbb  (x0 : ℕ) (x1 : List (ℕ)) : ℕ :=
  List.count x0 x1

noncomputable def cleanNotation_afbf80a28ac74f1f01c4  (x0 : List (ℕ)) (x1 : List (ℕ)) : List (ℕ) :=
  List.merge x0 x1 (· ≤ ·)

noncomputable def cleanNotation_4de83e007a08771e4a52  (x0 : ℕ) (x1 : ℕ) : Prop :=
  Nat.Coprime x0 x1

noncomputable def cleanNotation_c5d38a8d9fdadc4bcfb1  (x0 : ℕ) (x1 : ℕ) : ℕ :=
  Nat.gcd x0 x1

noncomputable def cleanNotation_6a337f2a1fee7d9b19ad  (x0 : ℕ) (x1 : ℕ) : ℕ :=
  Nat.lcm x0 x1

noncomputable def cleanNotation_f2524e2a525ed6e98912  (xs : List (ℕ)) : List (ℕ) :=
  List.insertionSort (· ≤ ·) xs


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: mathlib
reference: List.length_insertionSort
relationship: specialized
-/
def insertion_sort_preserves_length : Prop :=
  ∀ (xs : List (ℕ)),
  ((cleanNotation_6016b9cfd65d60648fc3 ((cleanNotation_f2524e2a525ed6e98912 (xs)))) = (cleanNotation_6016b9cfd65d60648fc3 (xs)))

end CleanStatements

example : CleanStatements.insertion_sort_preserves_length := by
  intro xs
  exact List.length_insertionSort (r := (· ≤ ·)) xs
