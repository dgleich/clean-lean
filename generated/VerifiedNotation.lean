import Mathlib.Data.List.Sort

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

example : CleanStatements.insertion_sort_preserves_length := by
  intro xs
  exact List.length_insertionSort (r := (· ≤ ·))
