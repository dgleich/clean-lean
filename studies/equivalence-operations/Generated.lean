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
import Mathlib.Logic.Equiv.Defs

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

noncomputable def cleanNotation_evaluate_map_fc8e4f20170606ffe807 {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) : Y :=
  f x

noncomputable def cleanType_Equivalence_58fcab11d3757c8990fc (A : Type) (B : Type) : Type :=
  A ≃ B

noncomputable def cleanNotation_equivalence_9dc94fc17e20833d2fb8  (A : Type) (B : Type) (f : (A) → (B)) (g : (B) → (A)) (left : (clean_pi_bound_0 : A) → ((((g (f clean_pi_bound_0)) = clean_pi_bound_0)))) (right : (clean_pi_bound_1 : B) → ((((f (g clean_pi_bound_1)) = clean_pi_bound_1)))) : A ≃ B :=
  Equiv.mk f g left right

noncomputable def cleanNotation_equivalence_forward_ebd1d090984645228598 {A : Type} {B : Type} (e : A ≃ B) (x : A) : B :=
  e x

noncomputable def cleanNotation_equivalence_backward_e72e31c61ebe95923018 {A : Type} {B : Type} (e : A ≃ B) (y : B) : A :=
  e.symm y

noncomputable def cleanDefine_identity_equivalence_65a44dab62957ae3bb79  (A : Type) : A ≃ A :=
  (@cleanNotation_equivalence_9dc94fc17e20833d2fb8 (A) (A) ((fun (clean_bound_0 : A) => clean_bound_0)) ((fun (clean_bound_1 : A) => clean_bound_1)) ((fun (clean_bound_2 : A) => (@cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (A) (clean_bound_2)))) ((fun (clean_bound_3 : A) => (@cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (A) (clean_bound_3)))))

noncomputable def cleanNotation_equality_transitivity_c07bfb0511d1038a5d7c {A : Type} (x : A) (y : A) (z : A) (first : ((x = y))) (second : ((y = z))) : ((x = z)) :=
  Eq.trans first second

noncomputable def cleanNotation_equivalence_left_inverse_11e59bbc8370041c7173 {A : Type} {B : Type} (e : A ≃ B) (x : A) : (((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (e) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (e) (x)))) = x)) :=
  e.symm_apply_apply x

noncomputable def cleanNotation_equivalence_right_inverse_15f9381536a3ab5b0038 {A : Type} {B : Type} (e : A ≃ B) (y : B) : (((cleanNotation_equivalence_forward_ebd1d090984645228598 (e) ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (e) (y)))) = y)) :=
  e.apply_symm_apply y

noncomputable def cleanDefine_inverse_equivalence_9d2c632ec2cd0aa310b1 {A : Type} {B : Type} (e : A ≃ B) : B ≃ A :=
  (@cleanNotation_equivalence_9dc94fc17e20833d2fb8 (B) (A) ((fun (clean_bound_0 : B) => (cleanNotation_equivalence_backward_e72e31c61ebe95923018 (e) (clean_bound_0)))) ((fun (clean_bound_1 : A) => (cleanNotation_equivalence_forward_ebd1d090984645228598 (e) (clean_bound_1)))) ((fun (clean_bound_2 : B) => (@cleanNotation_equivalence_right_inverse_15f9381536a3ab5b0038 (A) (B) (e) (clean_bound_2)))) ((fun (clean_bound_3 : A) => (@cleanNotation_equivalence_left_inverse_11e59bbc8370041c7173 (A) (B) (e) (clean_bound_3)))))

noncomputable def cleanDefine_compose_equivalences_0a2a6c58628a77a61305 {A : Type} {B : Type} {C : Type} (e : A ≃ B) (f : B ≃ C) : A ≃ C :=
  (@cleanNotation_equivalence_9dc94fc17e20833d2fb8 (A) (C) ((fun (clean_bound_0 : A) => (cleanNotation_equivalence_forward_ebd1d090984645228598 (f) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (e) (clean_bound_0)))))) ((fun (clean_bound_1 : C) => (cleanNotation_equivalence_backward_e72e31c61ebe95923018 (e) ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (f) (clean_bound_1)))))) ((fun (clean_bound_2 : A) => (@cleanNotation_equality_transitivity_c07bfb0511d1038a5d7c (A) ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (e) ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (f) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (f) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (e) (clean_bound_2))))))))) ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (e) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (e) (clean_bound_2))))) (clean_bound_2) ((@cleanNotation_equality_congruence_3e3f32efa32223213c0e (B) (A) ((fun (clean_bound_3 : B) => (cleanNotation_equivalence_backward_e72e31c61ebe95923018 (e) (clean_bound_3)))) ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (f) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (f) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (e) (clean_bound_2))))))) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (e) (clean_bound_2))) ((@cleanNotation_equivalence_left_inverse_11e59bbc8370041c7173 (B) (C) (f) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (e) (clean_bound_2))))))) ((@cleanNotation_equivalence_left_inverse_11e59bbc8370041c7173 (A) (B) (e) (clean_bound_2)))))) ((fun (clean_bound_4 : C) => (@cleanNotation_equality_transitivity_c07bfb0511d1038a5d7c (C) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (f) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (e) ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (e) ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (f) (clean_bound_4))))))))) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (f) ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (f) (clean_bound_4))))) (clean_bound_4) ((@cleanNotation_equality_congruence_3e3f32efa32223213c0e (B) (C) ((fun (clean_bound_5 : B) => (cleanNotation_equivalence_forward_ebd1d090984645228598 (f) (clean_bound_5)))) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (e) ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (e) ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (f) (clean_bound_4))))))) ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (f) (clean_bound_4))) ((@cleanNotation_equivalence_right_inverse_15f9381536a3ab5b0038 (A) (B) (e) ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (f) (clean_bound_4))))))) ((@cleanNotation_equivalence_right_inverse_15f9381536a3ab5b0038 (B) (C) (f) (clean_bound_4)))))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: mathlib
reference: Equiv.symm_apply_apply
relationship: adapted
-/
def inverse_equivalence_evaluation : Prop :=
  ∀ (A B : Type),
  ∀ (e : A ≃ B),
  ∀ (y : B),
  ((cleanNotation_equivalence_forward_ebd1d090984645228598 ((cleanDefine_inverse_equivalence_9d2c632ec2cd0aa310b1 (e))) (y)) = (cleanNotation_equivalence_backward_e72e31c61ebe95923018 (e) (y)))

/--
source: mathlib
reference: Equiv.trans_apply
relationship: adapted
-/
def composed_equivalence_evaluation : Prop :=
  ∀ (A B C : Type),
  ∀ (e : A ≃ B),
  ∀ (f : B ≃ C),
  ∀ (x : A),
  ((cleanNotation_equivalence_forward_ebd1d090984645228598 ((cleanDefine_compose_equivalences_0a2a6c58628a77a61305 (e) (f))) (x)) = (cleanNotation_equivalence_forward_ebd1d090984645228598 (f) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (e) (x)))))

/--
source: mathlib
reference: Equiv.symm_apply_apply
relationship: adapted
-/
def composed_equivalence_round_trip : Prop :=
  ∀ (A B C : Type),
  ∀ (e : A ≃ B),
  ∀ (f : B ≃ C),
  ∀ (x : A),
  ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 ((cleanDefine_compose_equivalences_0a2a6c58628a77a61305 (e) (f))) ((cleanNotation_equivalence_forward_ebd1d090984645228598 ((cleanDefine_compose_equivalences_0a2a6c58628a77a61305 (e) (f))) (x)))) = x)

end CleanStatements

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
