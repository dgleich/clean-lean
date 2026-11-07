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
import Mathlib.Topology.Path
import Mathlib.Logic.Equiv.Defs

/-!
Basic topology with explicit carrier types and topologies.
   Mathematical preimages, images, composition, and continuity are authored here.
   This first module is restricted to carrier types in Lean Type 0.
-/

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

noncomputable def cleanType_Element_f6cf8dd1e8f2bae54be4 (X : Type) (S : Set (X)) : Type :=
  {x : X // x ∈ S}

noncomputable def cleanType_Path_3fdd593c9b34e872c4b4 (X : Type) (t : TopologicalSpace X) (x : X) (y : X) : Type :=
  @Path X t x y

noncomputable def cleanNotation_element_value_44c9341f476da5cce234 {A : Type} (S : Set (A)) (x : {x : A // x ∈ S}) : A :=
  x.val

noncomputable def cleanNotation_element_membership_e14f01f6635e1d17b47e {A : Type} (S : Set (A)) (x : {x : A // x ∈ S}) : (((@cleanNotation_element_value_44c9341f476da5cce234 (A) (S) (x)) ∈ S)) :=
  x.property

noncomputable def cleanNotation_element_from_membership_9c436f2be1ab5193d023 {A : Type} (S : Set (A)) (x : A) (h : ((x ∈ S))) : {x : A // x ∈ S} :=
  Subtype.mk x h

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

structure cleanStructure_SubtypeRestrictionSupport_532604da216b8be379c4 («A» : Type) («S» : Set («A»)) («T» : Set («A»)) («U» : Set ({x : «A» // x ∈ «S»})) : Type where
  «survives» : (clean_pi_bound_2 : {x : «A» // x ∈ «T»}) → ((((@cleanNotation_element_value_44c9341f476da5cce234 («A») («T») (clean_pi_bound_2)) ∈ «S»)))
  «active» : (clean_pi_bound_3 : {x : «A» // x ∈ «T»}) → ((((@cleanNotation_element_from_membership_9c436f2be1ab5193d023 («A») («S») ((@cleanNotation_element_value_44c9341f476da5cce234 («A») («T») (clean_pi_bound_3))) ((«survives» clean_pi_bound_3))) ∈ «U»)))
  «original» : (clean_pi_bound_4 : {x : {x : «A» // x ∈ «S»} // x ∈ «U»}) → ((((@cleanNotation_element_value_44c9341f476da5cce234 («A») («S») ((@cleanNotation_element_value_44c9341f476da5cce234 ({x : «A» // x ∈ «S»}) («U») (clean_pi_bound_4)))) ∈ «T»)))

noncomputable def cleanConstructor_subtype_restriction_support_8ee6e29af4e962041af1 («A» : Type) («S» : Set («A»)) («T» : Set («A»)) («U» : Set ({x : «A» // x ∈ «S»})) («survives» : (clean_pi_bound_2 : {x : «A» // x ∈ «T»}) → ((((@cleanNotation_element_value_44c9341f476da5cce234 («A») («T») (clean_pi_bound_2)) ∈ «S»)))) («active» : (clean_pi_bound_3 : {x : «A» // x ∈ «T»}) → ((((@cleanNotation_element_from_membership_9c436f2be1ab5193d023 («A») («S») ((@cleanNotation_element_value_44c9341f476da5cce234 («A») («T») (clean_pi_bound_3))) ((«survives» clean_pi_bound_3))) ∈ «U»)))) («original» : (clean_pi_bound_4 : {x : {x : «A» // x ∈ «S»} // x ∈ «U»}) → ((((@cleanNotation_element_value_44c9341f476da5cce234 («A») («S») ((@cleanNotation_element_value_44c9341f476da5cce234 ({x : «A» // x ∈ «S»}) («U») (clean_pi_bound_4)))) ∈ «T»)))) : cleanStructure_SubtypeRestrictionSupport_532604da216b8be379c4 («A») («S») («T») («U») :=
  @cleanStructure_SubtypeRestrictionSupport_532604da216b8be379c4.mk «A» «S» «T» «U» «survives» «active» «original»

noncomputable def cleanDefine_restrict_element_59f6b42ec525561d636b  (A : Type) (S : Set (A)) (T : Set (A)) (U : Set ({x : A // x ∈ S})) (support : cleanStructure_SubtypeRestrictionSupport_532604da216b8be379c4 (A) (S) (T) (U)) (x : {x : A // x ∈ T}) : {x : {x : A // x ∈ S} // x ∈ U} :=
  (@cleanNotation_element_from_membership_9c436f2be1ab5193d023 ({x : A // x ∈ S}) (U) ((@cleanNotation_element_from_membership_9c436f2be1ab5193d023 (A) (S) ((@cleanNotation_element_value_44c9341f476da5cce234 (A) (T) (x))) (((@cleanStructure_SubtypeRestrictionSupport_532604da216b8be379c4.«survives» (A) (S) (T) (U) (support)) x)))) (((@cleanStructure_SubtypeRestrictionSupport_532604da216b8be379c4.«active» (A) (S) (T) (U) (support)) x)))

noncomputable def cleanDefine_restore_element_71bd276d129662e28a41  (A : Type) (S : Set (A)) (T : Set (A)) (U : Set ({x : A // x ∈ S})) (support : cleanStructure_SubtypeRestrictionSupport_532604da216b8be379c4 (A) (S) (T) (U)) (y : {x : {x : A // x ∈ S} // x ∈ U}) : {x : A // x ∈ T} :=
  (@cleanNotation_element_from_membership_9c436f2be1ab5193d023 (A) (T) ((@cleanNotation_element_value_44c9341f476da5cce234 (A) (S) ((@cleanNotation_element_value_44c9341f476da5cce234 ({x : A // x ∈ S}) (U) (y))))) (((@cleanStructure_SubtypeRestrictionSupport_532604da216b8be379c4.«original» (A) (S) (T) (U) (support)) y)))

noncomputable def cleanDefine_subtype_restriction_equivalence_75a86bdee10893b3cdb8  (A : Type) (S : Set (A)) (T : Set (A)) (U : Set ({x : A // x ∈ S})) (support : cleanStructure_SubtypeRestrictionSupport_532604da216b8be379c4 (A) (S) (T) (U)) (left : (clean_pi_bound_5 : {x : A // x ∈ T}) → ((((@cleanDefine_restore_element_71bd276d129662e28a41 (A) (S) (T) (U) (support) ((@cleanDefine_restrict_element_59f6b42ec525561d636b (A) (S) (T) (U) (support) (clean_pi_bound_5)))) = clean_pi_bound_5)))) (right : (clean_pi_bound_6 : {x : {x : A // x ∈ S} // x ∈ U}) → ((((@cleanDefine_restrict_element_59f6b42ec525561d636b (A) (S) (T) (U) (support) ((@cleanDefine_restore_element_71bd276d129662e28a41 (A) (S) (T) (U) (support) (clean_pi_bound_6)))) = clean_pi_bound_6)))) : {x : A // x ∈ T} ≃ {x : {x : A // x ∈ S} // x ∈ U} :=
  (@cleanNotation_equivalence_9dc94fc17e20833d2fb8 ({x : A // x ∈ T}) ({x : {x : A // x ∈ S} // x ∈ U}) ((fun (clean_bound_0 : {x : A // x ∈ T}) => (@cleanDefine_restrict_element_59f6b42ec525561d636b (A) (S) (T) (U) (support) (clean_bound_0)))) ((fun (clean_bound_1 : {x : {x : A // x ∈ S} // x ∈ U}) => (@cleanDefine_restore_element_71bd276d129662e28a41 (A) (S) (T) (U) (support) (clean_bound_1)))) (left) (right))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: subtype
reference: original element round trip
relationship: original
-/
def restore_a_restricted_element : Prop :=
  ∀ (A : Type),
  ∀ (S T : Set (A)),
  ∀ (U : Set ({x : A // x ∈ S})),
  ∀ (support : cleanStructure_SubtypeRestrictionSupport_532604da216b8be379c4 (A) (S) (T) (U)),
  ∀ (x : {x : A // x ∈ T}),
  ((@cleanDefine_restore_element_71bd276d129662e28a41 (A) (S) (T) (U) (support) ((@cleanDefine_restrict_element_59f6b42ec525561d636b (A) (S) (T) (U) (support) (x)))) = x)

/--
source: subtype
reference: selected element round trip
relationship: original
-/
def restrict_a_restored_element : Prop :=
  ∀ (A : Type),
  ∀ (S T : Set (A)),
  ∀ (U : Set ({x : A // x ∈ S})),
  ∀ (support : cleanStructure_SubtypeRestrictionSupport_532604da216b8be379c4 (A) (S) (T) (U)),
  ∀ (y : {x : {x : A // x ∈ S} // x ∈ U}),
  ((@cleanDefine_restrict_element_59f6b42ec525561d636b (A) (S) (T) (U) (support) ((@cleanDefine_restore_element_71bd276d129662e28a41 (A) (S) (T) (U) (support) (y)))) = y)

/--
source: subtype
reference: value preserving equivalence
relationship: original
-/
def supported_sets_correspond : Prop :=
  ∀ (A : Type),
  ∀ (S T : Set (A)),
  ∀ (U : Set ({x : A // x ∈ S})),
  ∀ (support : cleanStructure_SubtypeRestrictionSupport_532604da216b8be379c4 (A) (S) (T) (U)),
  (@Exists ({x : A // x ∈ T} ≃ {x : {x : A // x ∈ S} // x ∈ U}) (fun (clean_bound_0 : {x : A // x ∈ T} ≃ {x : {x : A // x ∈ S} // x ∈ U}) => (∀ (clean_bound_1 : {x : A // x ∈ T}), ((@cleanNotation_element_value_44c9341f476da5cce234 (A) (S) ((@cleanNotation_element_value_44c9341f476da5cce234 ({x : A // x ∈ S}) (U) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (clean_bound_0) (clean_bound_1)))))) = (@cleanNotation_element_value_44c9341f476da5cce234 (A) (T) (clean_bound_1))))))

end CleanStatements

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
