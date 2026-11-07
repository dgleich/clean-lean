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

noncomputable def cleanDefine_count_3c8dceecb383306aa88b  (n : ℕ) : ℕ :=
  n

noncomputable def cleanDefine_marker_94abaf6104c673a7a750  (T : Type) : ℕ :=
  0

noncomputable def cleanDefine_mark_vector_216e16cc24d8a16a4dde  (n : ℕ) : ℕ :=
  (@cleanDefine_marker_94abaf6104c673a7a750 (Fin (cleanDefine_count_3c8dceecb383306aa88b (n)) → ℝ))

noncomputable def cleanDefine_keep_law_cbb3656ef0b8271c187f  (n : ℕ) (h : ((∀ (clean_bound_0 : Fin (cleanDefine_count_3c8dceecb383306aa88b (n)) → ℝ), (∀ (clean_bound_1 : ((clean_bound_0 = clean_bound_0))), (clean_bound_1 = clean_bound_1))))) : ((∀ (clean_bound_0 : Fin (cleanDefine_count_3c8dceecb383306aa88b (n)) → ℝ), (∀ (clean_bound_1 : ((clean_bound_0 = clean_bound_0))), (clean_bound_1 = clean_bound_1)))) :=
  h


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: local
reference: dependent annotation binding
relationship: original
-/
def quantified_annotation_retained : Prop :=
  ∀ (n : ℕ),
  ∀ («h» : (∀ (clean_bound_0 : Fin (cleanDefine_count_3c8dceecb383306aa88b (n)) → ℝ), (∀ (clean_bound_1 : ((clean_bound_0 = clean_bound_0))), (clean_bound_1 = clean_bound_1)))),
  ∀ (count : (ℕ) → (ℕ)),
  ((@cleanDefine_keep_law_cbb3656ef0b8271c187f (n) («h»)) = «h»)

end CleanStatements

open Lean Elab Command
private def canonical : Expr → Expr
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj n i (canonical b)
  | e => e
elab "same_basic_target " a:ident b:ident : command => do
  let env ← getEnv
  let some (.defnInfo x) := env.find? a.getId | throwError "Missing actual target"
  let some (.defnInfo y) := env.find? b.getId | throwError "Missing expected target"
  unless x.levelParams == y.levelParams &&
      Expr.equal (canonical x.type) (canonical y.type) &&
      Expr.equal (canonical x.value) (canonical y.value) do
    throwError "Canonical type or value differs"

noncomputable def actual_marker (m : ℕ) (count : ℕ → ℕ) : ℕ := (@cleanDefine_marker_94abaf6104c673a7a750 (Fin (cleanDefine_count_3c8dceecb383306aa88b (m)) → ℝ))
noncomputable def expected_marker (m : ℕ) (count : ℕ → ℕ) : ℕ := @cleanDefine_marker_94abaf6104c673a7a750 (Fin (cleanDefine_count_3c8dceecb383306aa88b m) → ℝ)
same_basic_target actual_marker expected_marker
noncomputable def actual_authored (m : ℕ) (count : ℕ → ℕ) : ℕ := (cleanDefine_mark_vector_216e16cc24d8a16a4dde (m))
noncomputable def expected_authored (m : ℕ) (count : ℕ → ℕ) : ℕ := @cleanDefine_mark_vector_216e16cc24d8a16a4dde m
same_basic_target actual_authored expected_authored
noncomputable def actual_normal (m : ℕ) (count : ℕ → ℕ) : ℕ := (@cleanDefine_marker_94abaf6104c673a7a750 (Fin (cleanDefine_count_3c8dceecb383306aa88b (m)) → ℝ))
noncomputable def expected_normal (m : ℕ) (count : ℕ → ℕ) : ℕ := @cleanDefine_marker_94abaf6104c673a7a750 (Fin (cleanDefine_count_3c8dceecb383306aa88b m) → ℝ)
same_basic_target actual_normal expected_normal
 def actual_nested (m : ℕ) (count : ℕ → ℕ) : Prop := (∀ (clean_bound_0 : Fin (cleanDefine_count_3c8dceecb383306aa88b (m)) → ℝ), (∀ (clean_bound_1 : ((clean_bound_0 = clean_bound_0))), (clean_bound_1 = clean_bound_1)))
 def expected_nested (m : ℕ) (count : ℕ → ℕ) : Prop := ∀ (v : Fin (cleanDefine_count_3c8dceecb383306aa88b m) → ℝ), ∀ (p : v=v), p=p
 same_basic_target actual_nested expected_nested
 def expected_statement : Prop := ∀ (n : ℕ) (h : ∀ (v : Fin (cleanDefine_count_3c8dceecb383306aa88b n) → ℝ), ∀ (p : v=v), p=p) (count : ℕ → ℕ), @cleanDefine_keep_law_cbb3656ef0b8271c187f n h = h
 same_basic_target CleanStatements.quantified_annotation_retained expected_statement
 theorem marker_checked (m : ℕ) (count : ℕ → ℕ) : actual_marker m count = 0 := rfl
 theorem nested_checked (m : ℕ) (count : ℕ → ℕ) : actual_nested m count := by intro v p; rfl
 theorem statement_checked : CleanStatements.quantified_annotation_retained := by intro n h count; rfl

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
