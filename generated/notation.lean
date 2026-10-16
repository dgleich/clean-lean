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

def cleanNotation_4d92afd12b2f2ee349d7 (xs : List (ℕ)) : List (ℕ) :=
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
  ((List.length (cleanNotation_4d92afd12b2f2ee349d7 (xs))) = (List.length xs))

end CleanStatements
