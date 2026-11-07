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

noncomputable def cleanDefine_c_a8a394675845e0b7054b  (x : ℝ) : Prop :=
  (x = x)

noncomputable def cleanDefine_retain_proof_00404035e926c5244048  (x : ℝ) (h : ((cleanDefine_c_a8a394675845e0b7054b (x)))) : ((cleanDefine_c_a8a394675845e0b7054b (x))) :=
  h

noncomputable def cleanDefine_retain_local_366abf759034f140be57  (F : (ℝ) → (Prop)) (x : ℝ) (h : ((F x))) : ((F x)) :=
  h

noncomputable def cleanDefine_retain_universal_68d0cb87433626fcb760  (h : ((∀ (clean_bound_0 : ℝ), (cleanDefine_c_a8a394675845e0b7054b (clean_bound_0))))) : ((∀ (clean_bound_0 : ℝ), (cleanDefine_c_a8a394675845e0b7054b (clean_bound_0)))) :=
  h

noncomputable def cleanDefine_specialize_e67d67f497c616ffe83c  (h : ((∀ (clean_bound_0 : ℝ), (cleanDefine_c_a8a394675845e0b7054b (clean_bound_0))))) (x : ℝ) : ((cleanDefine_c_a8a394675845e0b7054b (x))) :=
  (h x)


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: local
reference: module condition under shadowing
relationship: original
-/
def module_proof_retained : Prop :=
  ∀ (x : ℝ),
  ∀ («k» : (x = x)),
  ∀ (c : (ℝ) → (Prop)),
  ((@cleanDefine_retain_proof_00404035e926c5244048 (x) («k»)) = «k»)

/--
source: local
reference: callable parameter substitution
relationship: original
-/
def local_proof_retained : Prop :=
  ∀ (x : ℝ),
  ∀ (c : (ℝ) → (Prop)),
  ∀ («h» : (c x)),
  ((@cleanDefine_retain_local_366abf759034f140be57 (c) (x) («h»)) = «h»)

/--
source: local
reference: quantified module condition
relationship: original
-/
def universal_proof_retained : Prop :=
  ∀ («q» : (∀ (clean_bound_0 : ℝ), (cleanDefine_c_a8a394675845e0b7054b (clean_bound_0)))),
  ∀ (c : (ℝ) → (Prop)),
  ((@cleanDefine_retain_universal_68d0cb87433626fcb760 («q»)) = «q»)

/--
source: local
reference: callable view of a quantified proof
relationship: original
-/
def universal_proof_specialized : Prop :=
  ∀ (x : ℝ),
  ∀ («q» : (∀ (clean_bound_0 : ℝ), (cleanDefine_c_a8a394675845e0b7054b (clean_bound_0)))),
  ∀ (c : (ℝ) → (Prop)),
  ((@cleanDefine_specialize_e67d67f497c616ffe83c («q») (x)) = («q» x))

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

def actual_module (x : ℝ) (c : ℝ → Prop) (k : x=x) := (@cleanDefine_retain_proof_00404035e926c5244048 (x) (k))
def expected_module (x : ℝ) (c : ℝ → Prop) (k : x=x) := @cleanDefine_retain_proof_00404035e926c5244048 x k
same_basic_target actual_module expected_module
def actual_local (x : ℝ) (c : ℝ → Prop) (h : c x) := (@cleanDefine_retain_local_366abf759034f140be57 (c) (x) (h))
def expected_local (x : ℝ) (c : ℝ → Prop) (h : c x) := @cleanDefine_retain_local_366abf759034f140be57 c x h
same_basic_target actual_local expected_local
def actual_universal (c : ℝ → Prop) (q : ∀ z : ℝ, cleanDefine_c_a8a394675845e0b7054b z) := (@cleanDefine_retain_universal_68d0cb87433626fcb760 (q))
def expected_universal (c : ℝ → Prop) (q : ∀ z : ℝ, cleanDefine_c_a8a394675845e0b7054b z) := @cleanDefine_retain_universal_68d0cb87433626fcb760 q
same_basic_target actual_universal expected_universal
def actual_specialize (x : ℝ) (c : ℝ → Prop) (q : ∀ z : ℝ, cleanDefine_c_a8a394675845e0b7054b z) := (@cleanDefine_specialize_e67d67f497c616ffe83c (q) (x))
def expected_specialize (x : ℝ) (c : ℝ → Prop) (q : ∀ z : ℝ, cleanDefine_c_a8a394675845e0b7054b z) := @cleanDefine_specialize_e67d67f497c616ffe83c q x
same_basic_target actual_specialize expected_specialize

theorem module_checked (x : ℝ) (c : ℝ → Prop) (k : x=x) : actual_module x c k = k := rfl
theorem local_checked (x : ℝ) (c : ℝ → Prop) (h : c x) : actual_local x c h = h := rfl
theorem universal_checked (c : ℝ → Prop) (q : ∀ z : ℝ, cleanDefine_c_a8a394675845e0b7054b z) : actual_universal c q = q := rfl
theorem specialize_checked (x : ℝ) (c : ℝ → Prop) (q : ∀ z : ℝ, cleanDefine_c_a8a394675845e0b7054b z) : actual_specialize x c q = q x := rfl

 def expected_statement_module : Prop := ∀ (x : ℝ) (k : x=x) (c : ℝ → Prop), @cleanDefine_retain_proof_00404035e926c5244048 x k = k
 def expected_statement_local : Prop := ∀ (x : ℝ) (c : ℝ → Prop) (h : c x), @cleanDefine_retain_local_366abf759034f140be57 c x h = h
 def expected_statement_universal : Prop := ∀ (q : ∀ z : ℝ, cleanDefine_c_a8a394675845e0b7054b z) (c : ℝ → Prop), @cleanDefine_retain_universal_68d0cb87433626fcb760 q = q
 def expected_statement_specialize : Prop := ∀ (x : ℝ) (q : ∀ z : ℝ, cleanDefine_c_a8a394675845e0b7054b z) (c : ℝ → Prop), @cleanDefine_specialize_e67d67f497c616ffe83c q x = q x
 same_basic_target CleanStatements.module_proof_retained expected_statement_module
 same_basic_target CleanStatements.local_proof_retained expected_statement_local
 same_basic_target CleanStatements.universal_proof_retained expected_statement_universal
 same_basic_target CleanStatements.universal_proof_specialized expected_statement_specialize
 theorem statement_module_checked : CleanStatements.module_proof_retained := by intro x k c; rfl
 theorem statement_local_checked : CleanStatements.local_proof_retained := by intro x c h; rfl
 theorem statement_universal_checked : CleanStatements.universal_proof_retained := by intro q c; rfl
 theorem statement_specialize_checked : CleanStatements.universal_proof_specialized := by intro x q c; rfl

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
