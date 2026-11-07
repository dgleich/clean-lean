import Lean
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

/-!
Evidence is an ordinary transparent alias. A parenthesized condition used
   as a type denotes proofs of that condition. This module supplies no proofs.
-/

noncomputable def cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable def cleanType_Natural_469c53b6dafb7a218246  : Type :=
  ℕ

noncomputable def cleanType_Real_107b6641a486642ad8e1  : Type :=
  ℝ

noncomputable def cleanType_Complex_2d7f06a08f8ab1e3f46d  : Type :=
  ℂ

noncomputable def cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable def cleanType_Matrix_61d617e3f5143c327dd3 (p0 : Nat) (p1 : Nat) (p2 : Type) : Type :=
  Matrix (Fin p0) (Fin p1) p2

noncomputable def cleanType_Vector_b5a130b68abf7f0646e8 (p0 : Nat) (p1 : Type) : Type :=
  Fin p0 → p1

noncomputable def cleanType_Vertex_460956e39f5b9ffca091 (p0 : Nat) : Type :=
  Fin p0

noncomputable def cleanType_Graph_7bde0ce024ce143f369b (p0 : Nat) : Type :=
  SimpleGraph (Fin p0)

noncomputable def cleanType_List_530f2b2df99696550311 (p0 : Type) : Type :=
  List (p0)

noncomputable def cleanType_Set_6e300741358eee425e81 (p0 : Type) : Type :=
  Set (p0)

noncomputable def cleanType_Function_9d746dbeb0e035328deb (p0 : Type) (p1 : Type) : Type :=
  (p0) → (p1)

noncomputable def cleanNotation_retain_with_law_adf91aea36c2ba712201 {T : Type} (n : ℕ) (f : (ℕ) → (ℕ)) (h : (clean_pi_bound_0 : ℕ) → ((((f clean_pi_bound_0) = n)))) (z : T) : T :=
  z

noncomputable def cleanNotation_retain_after_family_203f6344a77f67f859f6 {T : Type} {U : Type} (f : (ℕ) → (T)) (z : U) : U :=
  z


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: clean
reference: retain with later inference
relationship: original
-/
def retain_with_later_inference : Prop :=
  ∀ (n m : ℕ),
  ∀ (z : ℝ),
  ∀ («h» : (∀ (clean_bound_0 : ℕ), (n = m))),
  ((@cleanNotation_retain_with_law_adf91aea36c2ba712201 (ℝ) (m) ((fun (clean_bound_0 : ℕ) => n)) ((fun (clean_bound_1 : ℕ) => («h» clean_bound_1))) (z)) = z)

/--
source: clean
reference: retain direct evidence
relationship: original
-/
def retain_direct_evidence : Prop :=
  ∀ (n m : ℕ),
  ∀ (z : ℝ),
  ∀ («h» : (∀ (clean_bound_0 : ℕ), (n = m))),
  ((@cleanNotation_retain_with_law_adf91aea36c2ba712201 (ℝ) (m) ((fun (clean_bound_0 : ℕ) => n)) («h») (z)) = z)

/--
source: clean
reference: infer from dependent codomain
relationship: original
-/
def infer_from_dependent_codomain : Prop :=
  ∀ (n : ℕ),
  ∀ (z : ℝ),
  ((cleanNotation_retain_after_family_203f6344a77f67f859f6 ((fun (clean_bound_0 : ℕ) => n)) (z)) = z)

end CleanStatements

-- generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
