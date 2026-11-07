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
import Mathlib.Topology.Basic

/-!
Evidence is an ordinary transparent alias. A parenthesized condition used
   as a type denotes proofs of that condition. This module supplies no proofs.
-/

/-!
Basic topology with explicit carrier types and topologies.
   Mathematical preimages, images, composition, and continuity are authored here.
   This first module is restricted to carrier types in Lean Type 0.
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

noncomputable def cleanType_Topology_2eca621ea710e87cf174 (X : Type) : Type :=
  TopologicalSpace X

noncomputable def cleanNotation_set_of_25534029a1fdae044ce8 {X : Type} (condition : (X) → (Prop)) : Set (X) :=
  setOf condition

noncomputable def cleanDefine_open_in_04a39275b76e933d604a {X : Type} (S : Set (X)) (t : TopologicalSpace X) : Prop :=
  @IsOpen X t S

noncomputable def cleanDefine_inverse_image_b2385c49c1629ae08495 {X : Type} {Y : Type} (f : (X) → (Y)) (S : Set (Y)) : Set (X) :=
  (cleanNotation_set_of_25534029a1fdae044ce8 ((fun (clean_bound_0 : X) => ((f clean_bound_0) ∈ S))))

noncomputable def cleanDefine_image_3f2870b8ed865dc98807 {X : Type} {Y : Type} (f : (X) → (Y)) (S : Set (X)) : Set (Y) :=
  (cleanNotation_set_of_25534029a1fdae044ce8 ((fun (clean_bound_0 : Y) => (@Exists (X) (fun (clean_bound_1 : X) => ((clean_bound_1 ∈ S) ∧ ((f clean_bound_1) = clean_bound_0)))))))

noncomputable def cleanDefine_compose_maps_b7e7219a131a4bb5245c {X : Type} {Y : Type} {Z : Type} (g : (Y) → (Z)) (f : (X) → (Y)) : (X) → (Z) :=
  (fun (clean_bound_0 : X) => (g (f clean_bound_0)))

noncomputable def cleanDefine_continuous_between_fee422b0843f4b1d9573 {X : Type} {Y : Type} (f : (X) → (Y)) (t : TopologicalSpace X) (u : TopologicalSpace Y) : Prop :=
  (∀ (clean_bound_0 : Set (Y)), ((cleanDefine_open_in_04a39275b76e933d604a (clean_bound_0) (u)) → (cleanDefine_open_in_04a39275b76e933d604a ((cleanDefine_inverse_image_b2385c49c1629ae08495 (f) (clean_bound_0))) (t))))

noncomputable def cleanDefine_selected_elements_be59cb3b891978bdf75e {X : Type} (S : Set (X)) (condition : (X) → (Prop)) : Set (X) :=
  (cleanNotation_set_of_25534029a1fdae044ce8 ((fun (clean_bound_0 : X) => ((clean_bound_0 ∈ S) ∧ (condition clean_bound_0)))))

noncomputable def cleanDefine_intersection_family_21668a57bd46a5fc2395 {I : Type} {X : Type} (sets : (I) → (Set (X))) : Set (X) :=
  (cleanNotation_set_of_25534029a1fdae044ce8 ((fun (clean_bound_0 : X) => (∀ (clean_bound_1 : I), (clean_bound_0 ∈ (sets clean_bound_1))))))

noncomputable def cleanNotation_equality_congruence_3e3f32efa32223213c0e {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) (y : X) (h : ((x = y))) : (((f x) = (f y))) :=
  congrArg f h

noncomputable def cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db {X : Type} (x : X) : ((x = x)) :=
  Eq.refl x

noncomputable def cleanDefine_add_offset_64e525b1dc4d2d6ca49f  (n : ℕ) : (ℕ) → (ℕ) :=
  (fun (clean_bound_0 : ℕ) => (n + clean_bound_0))

structure cleanStructure_FunctionBox_f36cb5b67645168b3311  : Type where
  «action» : (ℕ) → ((ℕ) → (ℕ))

noncomputable def cleanConstructor_curried_box_c2617ee768e607932105 («action» : (ℕ) → ((ℕ) → (ℕ))) : cleanStructure_FunctionBox_f36cb5b67645168b3311 :=
  @cleanStructure_FunctionBox_f36cb5b67645168b3311.mk «action»

noncomputable def cleanDefine_boxed_offset_e619d4b26dd2ab68188f  (n : ℕ) : (ℕ) → (cleanStructure_FunctionBox_f36cb5b67645168b3311) :=
  (fun (clean_bound_0 : ℕ) => (@cleanConstructor_curried_box_c2617ee768e607932105 ((fun (clean_bound_1 : ℕ) => (fun (clean_bound_2 : ℕ) => (((n + clean_bound_0) + clean_bound_1) + clean_bound_2))))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: postfix
reference: returned function
relationship: original
-/
def returned_function_application : Prop :=
  ∀ (n m : ℕ),
  (((cleanDefine_add_offset_64e525b1dc4d2d6ca49f (n)) m) = (n + m))

/--
source: postfix
reference: curried local
relationship: original
-/
def curried_local_application : Prop :=
  ∀ (f : (ℕ) → ((ℕ) → (ℕ))),
  ∀ (n m : ℕ),
  (((f n) m) = ((f n) m))

/--
source: postfix
reference: curried field
relationship: original
-/
def curried_field_application : Prop :=
  ∀ (p : cleanStructure_FunctionBox_f36cb5b67645168b3311),
  ∀ (n m : ℕ),
  ((((@cleanStructure_FunctionBox_f36cb5b67645168b3311.«action» (p)) n) m) = (((@cleanStructure_FunctionBox_f36cb5b67645168b3311.«action» (p)) n) m))

/--
source: postfix
reference: applied lambda
relationship: original
-/
def applied_identity_function : Prop :=
  ∀ (n : ℕ),
  (((fun (clean_bound_0 : ℕ) => clean_bound_0) n) = n)

/--
source: postfix
reference: returned record field
relationship: original
-/
def interleaved_returned_field : Prop :=
  ∀ (n m x y : ℕ),
  ((((@cleanStructure_FunctionBox_f36cb5b67645168b3311.«action» (((cleanDefine_boxed_offset_e619d4b26dd2ab68188f (n)) m))) x) y) = (((n + m) + x) + y))

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

def expected_returned : Prop := ∀ (n m : ℕ), (cleanDefine_add_offset_64e525b1dc4d2d6ca49f n) m = n+m
def expected_local : Prop := ∀ (f : ℕ → ℕ → ℕ) (n m : ℕ), (f n) m = (f n) m
def expected_field : Prop := ∀ (p : cleanStructure_FunctionBox_f36cb5b67645168b3311) (n m : ℕ), (p.action n) m = (p.action n) m
def expected_lambda : Prop := ∀ (n : ℕ), (fun x : ℕ => x) n = n
def expected_interleaved : Prop := ∀ (n m x y : ℕ), ((cleanDefine_boxed_offset_e619d4b26dd2ab68188f n) m).action x y = n+m+x+y
same_basic_target CleanStatements.returned_function_application expected_returned
same_basic_target CleanStatements.curried_local_application expected_local
same_basic_target CleanStatements.curried_field_application expected_field
same_basic_target CleanStatements.applied_identity_function expected_lambda
same_basic_target CleanStatements.interleaved_returned_field expected_interleaved
noncomputable def actual_quantified (a b : Real) (h : a=b) : ((((fun (clean_bound_0 : ℝ) => (∀ (clean_bound_1 : ℝ), (clean_bound_0 = clean_bound_1))) a) = ((fun (clean_bound_2 : ℝ) => (∀ (clean_bound_3 : ℝ), (clean_bound_2 = clean_bound_3))) b))) := (@cleanNotation_equality_congruence_3e3f32efa32223213c0e (ℝ) (Prop) ((fun (clean_bound_0 : ℝ) => (∀ (clean_bound_1 : ℝ), (clean_bound_0 = clean_bound_1)))) (a) (b) (h))
noncomputable def expected_quantified (a b : Real) (h : a=b) : (fun t : Real => ∀ u : Real, t=u) a = (fun t : Real => ∀ u : Real, t=u) b := @cleanNotation_equality_congruence_3e3f32efa32223213c0e Real (Prop) (fun t : Real => ∀ u : Real, t=u) a b h
same_basic_target actual_quantified expected_quantified
noncomputable def actual_nested (a b : Real) (h : a=b) : ((((fun (clean_bound_0 : ℝ) => (fun (clean_bound_1 : ℝ) => (clean_bound_0 + clean_bound_1))) a) = ((fun (clean_bound_2 : ℝ) => (fun (clean_bound_3 : ℝ) => (clean_bound_2 + clean_bound_3))) b))) := (@cleanNotation_equality_congruence_3e3f32efa32223213c0e (ℝ) ((ℝ) → (ℝ)) ((fun (clean_bound_0 : ℝ) => (fun (clean_bound_1 : ℝ) => (clean_bound_0 + clean_bound_1)))) (a) (b) (h))
noncomputable def expected_nested (a b : Real) (h : a=b) : (fun t : Real => fun u : Real => t+u) a = (fun t : Real => fun u : Real => t+u) b := @cleanNotation_equality_congruence_3e3f32efa32223213c0e Real (Real → Real) (fun t : Real => fun u : Real => t+u) a b h
same_basic_target actual_nested expected_nested
def actual_dependent (h : ∀ x : ℕ, x=x → x=x) (n : ℕ) (p : n=n) : n=n := ((h n) p)
def expected_dependent (h : ∀ x : ℕ, x=x → x=x) (n : ℕ) (p : n=n) : n=n := (h n) p
same_basic_target actual_dependent expected_dependent
theorem checked_returned_function_application : CleanStatements.returned_function_application := by unfold CleanStatements.returned_function_application; intros; rfl
theorem checked_curried_local_application : CleanStatements.curried_local_application := by unfold CleanStatements.curried_local_application; intros; rfl
theorem checked_curried_field_application : CleanStatements.curried_field_application := by unfold CleanStatements.curried_field_application; intros; rfl
theorem checked_applied_identity_function : CleanStatements.applied_identity_function := by unfold CleanStatements.applied_identity_function; intros; rfl
theorem checked_interleaved_returned_field : CleanStatements.interleaved_returned_field := by unfold CleanStatements.interleaved_returned_field; intros; rfl

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
