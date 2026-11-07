import Lean
import Mathlib.Topology.Continuous
import Mathlib.Logic.Basic
import Mathlib.Data.Set.Basic
import Mathlib.Topology.Basic

/-!
Basic topology with explicit carrier types and topologies.
   Mathematical preimages, images, composition, and continuity are authored here.
   This first module is restricted to carrier types in Lean Type 0.
-/

noncomputable abbrev cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable abbrev cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable def cleanDefine_equal_59dc0f11ba9b345348cf {T : Type} (x : T) (y : T) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x=y

noncomputable def cleanDefine_conjunction_ae2d24c261b2e4e69e4e  (p : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) (q : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  p ∧ q

noncomputable def cleanDefine_implication_1f3f9e2e944d6a1d3361  (p : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) (q : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (p)), q)

noncomputable def cleanDefine_negation_9dda1c9733c05d83ca6e  (p : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  ¬p

noncomputable abbrev cleanType_Function_12d8de15d2a858a3dd9d (X : Type) (Y : Type) : Type :=
  (X) → (Y)

noncomputable def cleanDefine_equivalent_38494fec3ab77a8922dc  (p : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) (q : (_root_.cleanType_Proposition_ae4a13d2f060407bce35)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  p ↔ q

noncomputable abbrev cleanType_Set_5f6d12891083226ff185 (T : Type) : Type :=
  Set T

noncomputable def cleanNotation_union_dcc6950eff8ce91fc4c5 {T : Type} (A : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) (B : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) : (_root_.cleanType_Set_5f6d12891083226ff185 (T)) :=
  A ∪ B

noncomputable def cleanNotation_intersection_3664aeb82d8ed4eb3723 {T : Type} (A : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) (B : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) : (_root_.cleanType_Set_5f6d12891083226ff185 (T)) :=
  A ∩ B

noncomputable def cleanDefine_subset_c18f8bc50dce9defa00e {T : Type} (A : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) (B : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  A ⊆ B

noncomputable def cleanDefine_member_7c91d8d36d949b553ecb {T : Type} (x : T) (A : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  x ∈ A

noncomputable def cleanDefine_common_part_dac9c8c8052d029840f9 {T : Type} (A : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) (B : (_root_.cleanType_Set_5f6d12891083226ff185 (T))) : (_root_.cleanType_Set_5f6d12891083226ff185 (T)) :=
  (_root_.cleanNotation_intersection_3664aeb82d8ed4eb3723 (A) (B))

noncomputable abbrev cleanType_Topology_2eca621ea710e87cf174 (X : Type) : Type :=
  TopologicalSpace X

noncomputable def cleanNotation_set_of_4fb32c88175b9744c3b0 {X : Type} (condition : (X) → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) : (_root_.cleanType_Set_5f6d12891083226ff185 (X)) :=
  setOf condition

noncomputable def cleanDefine_open_in_f000bc91f65c0f2a1cbd {X : Type} (S : (_root_.cleanType_Set_5f6d12891083226ff185 (X))) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  @IsOpen X t S

noncomputable def cleanDefine_inverse_image_792cdaa85009a045a66a {X : Type} {Y : Type} (f : (X) → (Y)) (S : (_root_.cleanType_Set_5f6d12891083226ff185 (Y))) : (_root_.cleanType_Set_5f6d12891083226ff185 (X)) :=
  (_root_.cleanNotation_set_of_4fb32c88175b9744c3b0 ((fun (clean_bound_0 : X) => (_root_.cleanDefine_member_7c91d8d36d949b553ecb ((f clean_bound_0)) (S)))))

noncomputable def cleanDefine_image_4c730dbe6416046b70ba {X : Type} {Y : Type} (f : (X) → (Y)) (S : (_root_.cleanType_Set_5f6d12891083226ff185 (X))) : (_root_.cleanType_Set_5f6d12891083226ff185 (Y)) :=
  (_root_.cleanNotation_set_of_4fb32c88175b9744c3b0 ((fun (clean_bound_0 : Y) => (@Exists (X) (fun (clean_bound_1 : X) => (_root_.cleanDefine_conjunction_ae2d24c261b2e4e69e4e ((_root_.cleanDefine_member_7c91d8d36d949b553ecb (clean_bound_1) (S))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((f clean_bound_1)) (clean_bound_0)))))))))

noncomputable def cleanDefine_compose_maps_b7e7219a131a4bb5245c {X : Type} {Y : Type} {Z : Type} (g : (Y) → (Z)) (f : (X) → (Y)) : (X) → (Z) :=
  (fun (clean_bound_0 : X) => (g (f clean_bound_0)))

noncomputable def cleanDefine_continuous_between_54f160a3a5874755da39 {X : Type} {Y : Type} (f : (X) → (Y)) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (u : (_root_.cleanType_Topology_2eca621ea710e87cf174 (Y))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Set_5f6d12891083226ff185 (Y))), (_root_.cleanDefine_implication_1f3f9e2e944d6a1d3361 ((_root_.cleanDefine_open_in_f000bc91f65c0f2a1cbd (clean_bound_0) (u))) ((_root_.cleanDefine_open_in_f000bc91f65c0f2a1cbd ((_root_.cleanDefine_inverse_image_792cdaa85009a045a66a (f) (clean_bound_0))) (t)))))

noncomputable def cleanDefine_selected_elements_5caa46d4a1d361644bf9 {X : Type} (S : (_root_.cleanType_Set_5f6d12891083226ff185 (X))) (condition : (X) → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) : (_root_.cleanType_Set_5f6d12891083226ff185 (X)) :=
  (_root_.cleanNotation_set_of_4fb32c88175b9744c3b0 ((fun (clean_bound_0 : X) => (_root_.cleanDefine_conjunction_ae2d24c261b2e4e69e4e ((_root_.cleanDefine_member_7c91d8d36d949b553ecb (clean_bound_0) (S))) ((condition clean_bound_0))))))

noncomputable def cleanDefine_intersection_family_1721413d0723497d2063 {I : Type} {X : Type} (sets : (I) → ((_root_.cleanType_Set_5f6d12891083226ff185 (X)))) : (_root_.cleanType_Set_5f6d12891083226ff185 (X)) :=
  (_root_.cleanNotation_set_of_4fb32c88175b9744c3b0 ((fun (clean_bound_0 : X) => (∀ (clean_bound_1 : I), (_root_.cleanDefine_member_7c91d8d36d949b553ecb (clean_bound_0) ((sets clean_bound_1)))))))



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
  ∀ (S T : (_root_.cleanType_Set_5f6d12891083226ff185 (Y))),
  (_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((_root_.cleanDefine_inverse_image_792cdaa85009a045a66a (f) ((_root_.cleanNotation_intersection_3664aeb82d8ed4eb3723 (S) (T))))) ((_root_.cleanNotation_intersection_3664aeb82d8ed4eb3723 ((_root_.cleanDefine_inverse_image_792cdaa85009a045a66a (f) (S))) ((_root_.cleanDefine_inverse_image_792cdaa85009a045a66a (f) (T))))))

/--
source: topology
reference: image membership
relationship: original
-/
def image_membership : Prop :=
  ∀ (X Y : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (f : (X) → (Y)),
  ∀ (S : (_root_.cleanType_Set_5f6d12891083226ff185 (X))),
  ∀ (y : Y),
  (_root_.cleanDefine_equivalent_38494fec3ab77a8922dc ((_root_.cleanDefine_member_7c91d8d36d949b553ecb (y) ((_root_.cleanDefine_image_4c730dbe6416046b70ba (f) (S))))) ((@Exists (X) (fun (clean_bound_0 : X) => (_root_.cleanDefine_conjunction_ae2d24c261b2e4e69e4e ((_root_.cleanDefine_member_7c91d8d36d949b553ecb (clean_bound_0) (S))) ((_root_.cleanDefine_equal_59dc0f11ba9b345348cf ((f clean_bound_0)) (y))))))))

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
  ∀ («continuity_of_f_from_t_to_u» : (_root_.cleanDefine_continuous_between_54f160a3a5874755da39 (f) (t) (u))),
  ∀ («continuity_of_g_from_u_to_v» : (_root_.cleanDefine_continuous_between_54f160a3a5874755da39 (g) (u) (v))),
  (_root_.cleanDefine_continuous_between_54f160a3a5874755da39 ((_root_.cleanDefine_compose_maps_b7e7219a131a4bb5245c (g) (f))) (t) (v))

/--
source: topology
reference: family intersection membership
relationship: original
-/
def family_intersection_membership : Prop :=
  ∀ (I X : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (sets : (I) → ((_root_.cleanType_Set_5f6d12891083226ff185 (X)))),
  ∀ (x : X),
  (_root_.cleanDefine_equivalent_38494fec3ab77a8922dc ((_root_.cleanDefine_member_7c91d8d36d949b553ecb (x) ((_root_.cleanDefine_intersection_family_1721413d0723497d2063 (sets))))) ((∀ (clean_bound_0 : I), (_root_.cleanDefine_member_7c91d8d36d949b553ecb (x) ((sets clean_bound_0))))))

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

noncomputable def expected_topology_0 (X : Type) : Type := TopologicalSpace X
same_basic_target cleanType_Topology_2eca621ea710e87cf174 expected_topology_0

noncomputable def expected_topology_1 {X : Type} (condition : X → _root_.cleanType_Proposition_ae4a13d2f060407bce35) : _root_.cleanType_Set_5f6d12891083226ff185 X := setOf condition
same_basic_target cleanNotation_set_of_4fb32c88175b9744c3b0 expected_topology_1

noncomputable def expected_topology_2 {X : Type} (S : _root_.cleanType_Set_5f6d12891083226ff185 X) (t : _root_.cleanType_Topology_2eca621ea710e87cf174 X) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := @IsOpen X t S
same_basic_target cleanDefine_open_in_f000bc91f65c0f2a1cbd expected_topology_2

noncomputable def expected_topology_3 {X Y : Type} (f : X → Y) (S : _root_.cleanType_Set_5f6d12891083226ff185 Y) : _root_.cleanType_Set_5f6d12891083226ff185 X := @_root_.cleanNotation_set_of_4fb32c88175b9744c3b0 X (fun x : X => @_root_.cleanDefine_member_7c91d8d36d949b553ecb Y (f x) S)
same_basic_target cleanDefine_inverse_image_792cdaa85009a045a66a expected_topology_3

noncomputable def expected_topology_4 {X Y : Type} (f : X → Y) (S : _root_.cleanType_Set_5f6d12891083226ff185 X) : _root_.cleanType_Set_5f6d12891083226ff185 Y := @_root_.cleanNotation_set_of_4fb32c88175b9744c3b0 Y (fun y : Y => ∃ x : X, _root_.cleanDefine_conjunction_ae2d24c261b2e4e69e4e (@_root_.cleanDefine_member_7c91d8d36d949b553ecb X x S) (@_root_.cleanDefine_equal_59dc0f11ba9b345348cf Y (f x) y))
same_basic_target cleanDefine_image_4c730dbe6416046b70ba expected_topology_4

noncomputable def expected_topology_5 {X Y Z : Type} (g : Y → Z) (f : X → Y) : X → Z := fun x : X => g (f x)
same_basic_target cleanDefine_compose_maps_b7e7219a131a4bb5245c expected_topology_5

noncomputable def expected_topology_6 {X Y : Type} (f : X → Y) (t : _root_.cleanType_Topology_2eca621ea710e87cf174 X) (u : _root_.cleanType_Topology_2eca621ea710e87cf174 Y) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 := ∀ S : _root_.cleanType_Set_5f6d12891083226ff185 Y, _root_.cleanDefine_implication_1f3f9e2e944d6a1d3361 (@_root_.cleanDefine_open_in_f000bc91f65c0f2a1cbd Y S u) (@_root_.cleanDefine_open_in_f000bc91f65c0f2a1cbd X (@_root_.cleanDefine_inverse_image_792cdaa85009a045a66a X Y f S) t)
same_basic_target cleanDefine_continuous_between_54f160a3a5874755da39 expected_topology_6

noncomputable def expected_topology_7 {X : Type} (S : _root_.cleanType_Set_5f6d12891083226ff185 X) (condition : X → _root_.cleanType_Proposition_ae4a13d2f060407bce35) : _root_.cleanType_Set_5f6d12891083226ff185 X := @_root_.cleanNotation_set_of_4fb32c88175b9744c3b0 X (fun x : X => _root_.cleanDefine_conjunction_ae2d24c261b2e4e69e4e (@_root_.cleanDefine_member_7c91d8d36d949b553ecb X x S) (condition x))
same_basic_target cleanDefine_selected_elements_5caa46d4a1d361644bf9 expected_topology_7

noncomputable def expected_topology_8 {I X : Type} (sets : I → _root_.cleanType_Set_5f6d12891083226ff185 X) : _root_.cleanType_Set_5f6d12891083226ff185 X := @_root_.cleanNotation_set_of_4fb32c88175b9744c3b0 X (fun x : X => ∀ i : I, @_root_.cleanDefine_member_7c91d8d36d949b553ecb X x (sets i))
same_basic_target cleanDefine_intersection_family_1721413d0723497d2063 expected_topology_8

noncomputable def expected_topology_9  : Prop := ∀ (X Y : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (f : X → Y) (S T : _root_.cleanType_Set_5f6d12891083226ff185 Y), @_root_.cleanDefine_equal_59dc0f11ba9b345348cf (_root_.cleanType_Set_5f6d12891083226ff185 X) (@_root_.cleanDefine_inverse_image_792cdaa85009a045a66a X Y f (@_root_.cleanNotation_intersection_3664aeb82d8ed4eb3723 Y S T)) (@_root_.cleanNotation_intersection_3664aeb82d8ed4eb3723 X (@_root_.cleanDefine_inverse_image_792cdaa85009a045a66a X Y f S) (@_root_.cleanDefine_inverse_image_792cdaa85009a045a66a X Y f T))
same_basic_target CleanStatements.inverse_image_intersection expected_topology_9

noncomputable def expected_topology_10  : Prop := ∀ (X Y : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (f : X → Y) (S : _root_.cleanType_Set_5f6d12891083226ff185 X) (y : Y), _root_.cleanDefine_equivalent_38494fec3ab77a8922dc (@_root_.cleanDefine_member_7c91d8d36d949b553ecb Y y (@_root_.cleanDefine_image_4c730dbe6416046b70ba X Y f S)) (∃ x : X, _root_.cleanDefine_conjunction_ae2d24c261b2e4e69e4e (@_root_.cleanDefine_member_7c91d8d36d949b553ecb X x S) (@_root_.cleanDefine_equal_59dc0f11ba9b345348cf Y (f x) y))
same_basic_target CleanStatements.image_membership expected_topology_10

noncomputable def expected_topology_11  : Prop := ∀ (X Y Z : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (t : _root_.cleanType_Topology_2eca621ea710e87cf174 X) (u : _root_.cleanType_Topology_2eca621ea710e87cf174 Y) (v : _root_.cleanType_Topology_2eca621ea710e87cf174 Z) (f : X → Y) (g : Y → Z) (_ : @_root_.cleanDefine_continuous_between_54f160a3a5874755da39 X Y f t u) (_ : @_root_.cleanDefine_continuous_between_54f160a3a5874755da39 Y Z g u v), @_root_.cleanDefine_continuous_between_54f160a3a5874755da39 X Z (@_root_.cleanDefine_compose_maps_b7e7219a131a4bb5245c X Y Z g f) t v
same_basic_target CleanStatements.continuous_composition expected_topology_11

noncomputable def expected_topology_12  : Prop := ∀ (I X : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (sets : I → _root_.cleanType_Set_5f6d12891083226ff185 X) (x : X), _root_.cleanDefine_equivalent_38494fec3ab77a8922dc (@_root_.cleanDefine_member_7c91d8d36d949b553ecb X x (@_root_.cleanDefine_intersection_family_1721413d0723497d2063 I X sets)) (∀ i : I, @_root_.cleanDefine_member_7c91d8d36d949b553ecb X x (sets i))
same_basic_target CleanStatements.family_intersection_membership expected_topology_12

-- Agreement with Mathlib is proved, not assumed by the foundation wrappers.
theorem inverse_image_agrees {X Y : Type} (f : X → Y) (S : Set Y) :
    _root_.cleanDefine_inverse_image_792cdaa85009a045a66a f S = f ⁻¹' S := rfl

theorem image_agrees {X Y : Type} (f : X → Y) (S : Set X) :
    _root_.cleanDefine_image_4c730dbe6416046b70ba f S = f '' S := rfl

theorem continuity_agrees {X Y : Type} (f : X → Y)
    (t : TopologicalSpace X) (u : TopologicalSpace Y) :
    _root_.cleanDefine_continuous_between_54f160a3a5874755da39 f t u ↔ @Continuous X Y t u f := by
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

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
