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


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/-!
These foundation results exercise the implemented language.
They do not assert the five pending paper theorems.
-/

/--
source: topology
reference: inverse image intersection
relationship: original
-/
def inverse_image_intersection : Prop :=
  ∀ (X Y : Type),
  ∀ (f : (X) → (Y)),
  ∀ (S T : Set (Y)),
  ((cleanDefine_inverse_image_b2385c49c1629ae08495 (f) ((S ∩ T))) = ((cleanDefine_inverse_image_b2385c49c1629ae08495 (f) (S)) ∩ (cleanDefine_inverse_image_b2385c49c1629ae08495 (f) (T))))

/--
source: topology
reference: image membership
relationship: original
-/
def image_membership : Prop :=
  ∀ (X Y : Type),
  ∀ (f : (X) → (Y)),
  ∀ (S : Set (X)),
  ∀ (y : Y),
  ((y ∈ (cleanDefine_image_3f2870b8ed865dc98807 (f) (S))) ↔ (@Exists (X) (fun (clean_bound_0 : X) => ((clean_bound_0 ∈ S) ∧ ((f clean_bound_0) = y)))))

/--
source: topology
reference: continuous composition
relationship: original
-/
def continuous_composition : Prop :=
  ∀ (X Y Z : Type),
  ∀ (t : TopologicalSpace X),
  ∀ (u : TopologicalSpace Y),
  ∀ (v : TopologicalSpace Z),
  ∀ (f : (X) → (Y)),
  ∀ (g : (Y) → (Z)),
  ∀ («continuity_of_f_from_t_to_u» : (cleanDefine_continuous_between_fee422b0843f4b1d9573 (f) (t) (u))),
  ∀ («continuity_of_g_from_u_to_v» : (cleanDefine_continuous_between_fee422b0843f4b1d9573 (g) (u) (v))),
  (cleanDefine_continuous_between_fee422b0843f4b1d9573 ((cleanDefine_compose_maps_b7e7219a131a4bb5245c (g) (f))) (t) (v))

/--
source: topology
reference: family intersection membership
relationship: original
-/
def family_intersection_membership : Prop :=
  ∀ (I X : Type),
  ∀ (sets : (I) → (Set (X))),
  ∀ (x : X),
  ((x ∈ (cleanDefine_intersection_family_21668a57bd46a5fc2395 (sets))) ↔ (∀ (clean_bound_0 : I), (x ∈ (sets clean_bound_0))))

end CleanStatements

-- generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
