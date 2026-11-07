import Lean
import Mathlib.Topology.Continuous
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

noncomputable abbrev cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable abbrev cleanType_Natural_469c53b6dafb7a218246  : Type :=
  ℕ

noncomputable abbrev cleanType_Real_107b6641a486642ad8e1  : Type :=
  ℝ

noncomputable abbrev cleanType_Complex_2d7f06a08f8ab1e3f46d  : Type :=
  ℂ

noncomputable abbrev cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable abbrev cleanType_Matrix_61d617e3f5143c327dd3 (p0 : Nat) (p1 : Nat) (p2 : Type) : Type :=
  Matrix (Fin p0) (Fin p1) p2

noncomputable abbrev cleanType_Vector_b5a130b68abf7f0646e8 (p0 : Nat) (p1 : Type) : Type :=
  Fin p0 → p1

noncomputable abbrev cleanType_Vertex_460956e39f5b9ffca091 (p0 : Nat) : Type :=
  Fin p0

noncomputable abbrev cleanType_Graph_7bde0ce024ce143f369b (p0 : Nat) : Type :=
  SimpleGraph (Fin p0)

noncomputable abbrev cleanType_List_530f2b2df99696550311 (p0 : Type) : Type :=
  List (p0)

noncomputable abbrev cleanType_Set_6e300741358eee425e81 (p0 : Type) : Type :=
  Set (p0)

noncomputable abbrev cleanType_Function_9d746dbeb0e035328deb (p0 : Type) (p1 : Type) : Type :=
  (p0) → (p1)

noncomputable abbrev cleanType_Topology_2eca621ea710e87cf174 (X : Type) : Type :=
  TopologicalSpace X

noncomputable def cleanNotation_set_of_2c71fd475f49a65bd03e {X : Type} (condition : (X) → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) : (_root_.cleanType_Set_6e300741358eee425e81 (X)) :=
  setOf condition

noncomputable def cleanDefine_open_in_2f000176928f8b3f5fc4 {X : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  @IsOpen X t S

noncomputable def cleanDefine_inverse_image_eb657a3c1d0219ea719b {X : Type} {Y : Type} (f : (X) → (Y)) (S : (_root_.cleanType_Set_6e300741358eee425e81 (Y))) : (_root_.cleanType_Set_6e300741358eee425e81 (X)) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : X) => ((f clean_bound_0) ∈ S))))

noncomputable def cleanDefine_image_869a575587985294ee29 {X : Type} {Y : Type} (f : (X) → (Y)) (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) : (_root_.cleanType_Set_6e300741358eee425e81 (Y)) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : Y) => (@Exists (X) (fun (clean_bound_1 : X) => ((clean_bound_1 ∈ S) ∧ ((f clean_bound_1) = clean_bound_0)))))))

noncomputable def cleanDefine_compose_maps_b7e7219a131a4bb5245c {X : Type} {Y : Type} {Z : Type} (g : (Y) → (Z)) (f : (X) → (Y)) : (X) → (Z) :=
  (fun (clean_bound_0 : X) => (g (f clean_bound_0)))

noncomputable def cleanDefine_continuous_between_3b927933ead621e0bfe9 {X : Type} {Y : Type} (f : (X) → (Y)) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (u : (_root_.cleanType_Topology_2eca621ea710e87cf174 (Y))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Set_6e300741358eee425e81 (Y))), ((_root_.cleanDefine_open_in_2f000176928f8b3f5fc4 (clean_bound_0) (u)) → (_root_.cleanDefine_open_in_2f000176928f8b3f5fc4 ((_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b (f) (clean_bound_0))) (t))))

noncomputable def cleanDefine_selected_elements_b4d39602cd1cf697afb5 {X : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (condition : (X) → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) : (_root_.cleanType_Set_6e300741358eee425e81 (X)) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : X) => ((clean_bound_0 ∈ S) ∧ (condition clean_bound_0)))))

noncomputable def cleanDefine_intersection_family_7482d46b5fb61bd1ecae {I : Type} {X : Type} (sets : (I) → ((_root_.cleanType_Set_6e300741358eee425e81 (X)))) : (_root_.cleanType_Set_6e300741358eee425e81 (X)) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : X) => (∀ (clean_bound_1 : I), (clean_bound_0 ∈ (sets clean_bound_1))))))


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
  ∀ (X Y : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (f : (X) → (Y)),
  ∀ (S T : (_root_.cleanType_Set_6e300741358eee425e81 (Y))),
  ((_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b (f) ((S ∩ T))) = ((_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b (f) (S)) ∩ (_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b (f) (T))))

/--
source: topology
reference: image membership
relationship: original
-/
def image_membership : Prop :=
  ∀ (X Y : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (f : (X) → (Y)),
  ∀ (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))),
  ∀ (y : Y),
  ((y ∈ (_root_.cleanDefine_image_869a575587985294ee29 (f) (S))) ↔ (@Exists (X) (fun (clean_bound_0 : X) => ((clean_bound_0 ∈ S) ∧ ((f clean_bound_0) = y)))))

/--
source: topology
reference: continuous composition
relationship: original
-/
def continuous_composition : Prop :=
  ∀ (X Y Z : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))),
  ∀ (u : (_root_.cleanType_Topology_2eca621ea710e87cf174 (Y))),
  ∀ (v : (_root_.cleanType_Topology_2eca621ea710e87cf174 (Z))),
  ∀ (f : (X) → (Y)),
  ∀ (g : (Y) → (Z)),
  ∀ («continuity_of_f_from_t_to_u» : (_root_.cleanDefine_continuous_between_3b927933ead621e0bfe9 (f) (t) (u))),
  ∀ («continuity_of_g_from_u_to_v» : (_root_.cleanDefine_continuous_between_3b927933ead621e0bfe9 (g) (u) (v))),
  (_root_.cleanDefine_continuous_between_3b927933ead621e0bfe9 ((_root_.cleanDefine_compose_maps_b7e7219a131a4bb5245c (g) (f))) (t) (v))

/--
source: topology
reference: family intersection membership
relationship: original
-/
def family_intersection_membership : Prop :=
  ∀ (I X : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (sets : (I) → ((_root_.cleanType_Set_6e300741358eee425e81 (X)))),
  ∀ (x : X),
  ((x ∈ (_root_.cleanDefine_intersection_family_7482d46b5fb61bd1ecae (sets))) ↔ (∀ (clean_bound_0 : I), (x ∈ (sets clean_bound_0))))

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

noncomputable def expected_topology_binding_0  : Type 1 := Type
same_basic_target cleanType_Type_c1fed1af64ab6f12e0ed expected_topology_binding_0

noncomputable def expected_topology_binding_1  : Sort 1 := Prop
same_basic_target cleanType_Proposition_ae4a13d2f060407bce35 expected_topology_binding_1

noncomputable def expected_topology_binding_2 (X : Type) : Type := Set X
same_basic_target cleanType_Set_6e300741358eee425e81 expected_topology_binding_2

noncomputable def expected_topology_binding_3 (X Y : Type) : Type := X → Y
same_basic_target cleanType_Function_9d746dbeb0e035328deb expected_topology_binding_3

noncomputable def expected_topology_binding_4 (X : Type) : Type := TopologicalSpace X
same_basic_target cleanType_Topology_2eca621ea710e87cf174 expected_topology_binding_4

noncomputable def expected_topology_binding_5 {X : Type} (condition : X → _root_.cleanType_Proposition_ae4a13d2f060407bce35) : _root_.cleanType_Set_6e300741358eee425e81 X := setOf condition
same_basic_target cleanNotation_set_of_2c71fd475f49a65bd03e expected_topology_binding_5

noncomputable def expected_topology_binding_6 {X : Type} (S : _root_.cleanType_Set_6e300741358eee425e81 X) (t : _root_.cleanType_Topology_2eca621ea710e87cf174 X) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := @IsOpen X t S
same_basic_target cleanDefine_open_in_2f000176928f8b3f5fc4 expected_topology_binding_6

noncomputable def expected_topology_binding_7 {X Y : Type} (f : X → Y) (S : _root_.cleanType_Set_6e300741358eee425e81 Y) : _root_.cleanType_Set_6e300741358eee425e81 X := @_root_.cleanNotation_set_of_2c71fd475f49a65bd03e X (fun x : X => f x ∈ S)
same_basic_target cleanDefine_inverse_image_eb657a3c1d0219ea719b expected_topology_binding_7

noncomputable def expected_topology_binding_8 {X Y : Type} (f : X → Y) (S : _root_.cleanType_Set_6e300741358eee425e81 X) : _root_.cleanType_Set_6e300741358eee425e81 Y := @_root_.cleanNotation_set_of_2c71fd475f49a65bd03e Y (fun y : Y => ∃ x : X, x ∈ S ∧ f x = y)
same_basic_target cleanDefine_image_869a575587985294ee29 expected_topology_binding_8

noncomputable def expected_topology_binding_9 {X Y Z : Type} (g : Y → Z) (f : X → Y) : X → Z := fun x : X => g (f x)
same_basic_target cleanDefine_compose_maps_b7e7219a131a4bb5245c expected_topology_binding_9

noncomputable def expected_topology_binding_10 {X Y : Type} (f : X → Y) (t : _root_.cleanType_Topology_2eca621ea710e87cf174 X) (u : _root_.cleanType_Topology_2eca621ea710e87cf174 Y) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := ∀ S : _root_.cleanType_Set_6e300741358eee425e81 Y, @_root_.cleanDefine_open_in_2f000176928f8b3f5fc4 Y S u → @_root_.cleanDefine_open_in_2f000176928f8b3f5fc4 X (@_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b X Y f S) t
same_basic_target cleanDefine_continuous_between_3b927933ead621e0bfe9 expected_topology_binding_10

noncomputable def expected_topology_binding_11 {X : Type} (S : _root_.cleanType_Set_6e300741358eee425e81 X) (condition : X → _root_.cleanType_Proposition_ae4a13d2f060407bce35) : _root_.cleanType_Set_6e300741358eee425e81 X := @_root_.cleanNotation_set_of_2c71fd475f49a65bd03e X (fun x : X => x ∈ S ∧ condition x)
same_basic_target cleanDefine_selected_elements_b4d39602cd1cf697afb5 expected_topology_binding_11

noncomputable def expected_topology_binding_12 {I X : Type} (sets : I → _root_.cleanType_Set_6e300741358eee425e81 X) : _root_.cleanType_Set_6e300741358eee425e81 X := @_root_.cleanNotation_set_of_2c71fd475f49a65bd03e X (fun x : X => ∀ i : I, x ∈ sets i)
same_basic_target cleanDefine_intersection_family_7482d46b5fb61bd1ecae expected_topology_binding_12

noncomputable def expected_topology_binding_13  : Prop := ∀ (X Y : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (f : X → Y) (S T : _root_.cleanType_Set_6e300741358eee425e81 Y), @_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b X Y f (S ∩ T) = @_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b X Y f S ∩ @_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b X Y f T
same_basic_target CleanStatements.inverse_image_intersection expected_topology_binding_13

noncomputable def expected_topology_binding_14  : Prop := ∀ (X Y : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (f : X → Y) (S : _root_.cleanType_Set_6e300741358eee425e81 X) (y : Y), y ∈ @_root_.cleanDefine_image_869a575587985294ee29 X Y f S ↔ ∃ x : X, x ∈ S ∧ f x = y
same_basic_target CleanStatements.image_membership expected_topology_binding_14

noncomputable def expected_topology_binding_15  : Prop := ∀ (X Y Z : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (t : _root_.cleanType_Topology_2eca621ea710e87cf174 X) (u : _root_.cleanType_Topology_2eca621ea710e87cf174 Y) (v : _root_.cleanType_Topology_2eca621ea710e87cf174 Z) (f : X → Y) (g : Y → Z) (_ : @_root_.cleanDefine_continuous_between_3b927933ead621e0bfe9 X Y f t u) (_ : @_root_.cleanDefine_continuous_between_3b927933ead621e0bfe9 Y Z g u v), @_root_.cleanDefine_continuous_between_3b927933ead621e0bfe9 X Z (@_root_.cleanDefine_compose_maps_b7e7219a131a4bb5245c X Y Z g f) t v
same_basic_target CleanStatements.continuous_composition expected_topology_binding_15

noncomputable def expected_topology_binding_16  : Prop := ∀ (I X : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (sets : I → _root_.cleanType_Set_6e300741358eee425e81 X) (x : X), x ∈ @_root_.cleanDefine_intersection_family_7482d46b5fb61bd1ecae I X sets ↔ ∀ i : I, x ∈ sets i
same_basic_target CleanStatements.family_intersection_membership expected_topology_binding_16

namespace TopologyFoundationProofs

-- Agreement with independently named Lean constructions.
theorem inverse_image_agrees {X Y : Type} (f : X → Y) (S : Set Y) :
    cleanDefine_inverse_image_eb657a3c1d0219ea719b f S = f ⁻¹' S := rfl

theorem image_agrees {X Y : Type} (f : X → Y) (S : Set X) :
    cleanDefine_image_869a575587985294ee29 f S = f '' S := rfl

theorem continuity_agrees {X Y : Type} (f : X → Y)
    (t : TopologicalSpace X) (u : TopologicalSpace Y) :
    cleanDefine_continuous_between_3b927933ead621e0bfe9 f t u ↔ @Continuous X Y t u f := by
  letI : TopologicalSpace X := t
  letI : TopologicalSpace Y := u
  change (∀ S : Set Y, IsOpen S → IsOpen (f ⁻¹' S)) ↔ Continuous f
  exact continuous_def.symm

theorem inverse_image_intersection : CleanStatements.inverse_image_intersection := by
  intro X Y f S T
  rfl

theorem image_membership : CleanStatements.image_membership := by
  intro X Y f S y
  rfl

theorem continuous_composition : CleanStatements.continuous_composition := by
  intro X Y Z t u v f g hf hg
  change ∀ S : Set Z, @IsOpen Z v S → @IsOpen X t ((g ∘ f) ⁻¹' S)
  intro S hS
  exact hf (g ⁻¹' S) (hg S hS)

theorem family_intersection_membership : CleanStatements.family_intersection_membership := by
  intro I X sets x
  rfl

end TopologyFoundationProofs

-- generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
