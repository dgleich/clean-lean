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

noncomputable def cleanNotation_evaluate_map_fc8e4f20170606ffe807 {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) : Y :=
  f x

structure cleanStructure_PointedSpace_4b97411f5be9affa2443  : Type 1 where
  «carrier» : Type
  «topology» : TopologicalSpace «carrier»
  «point» : «carrier»

noncomputable def cleanConstructor_pointed_space_63873b521438f4b6aaf3 («carrier» : Type) («topology» : TopologicalSpace «carrier») («point» : «carrier») : cleanStructure_PointedSpace_4b97411f5be9affa2443 :=
  @cleanStructure_PointedSpace_4b97411f5be9affa2443.mk «carrier» «topology» «point»

noncomputable def cleanDefine_carrier_of_2a99826e44642f4a6809  (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) : Type :=
  (@cleanStructure_PointedSpace_4b97411f5be9affa2443.«carrier» (P))

noncomputable def cleanDefine_constant_map_ba4ce9b813550272149f  (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) : (((@cleanStructure_PointedSpace_4b97411f5be9affa2443.«carrier» (P)))) → (((@cleanStructure_PointedSpace_4b97411f5be9affa2443.«carrier» (P)))) :=
  (fun (clean_bound_0 : ((@cleanStructure_PointedSpace_4b97411f5be9affa2443.«carrier» (P)))) => (@cleanStructure_PointedSpace_4b97411f5be9affa2443.«point» (P)))

noncomputable def cleanDefine_bundle_continuous_f264edce70c3d7b32602  (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) (Q : cleanStructure_PointedSpace_4b97411f5be9affa2443) (f : (((@cleanStructure_PointedSpace_4b97411f5be9affa2443.«carrier» (P)))) → (((@cleanStructure_PointedSpace_4b97411f5be9affa2443.«carrier» (Q))))) : Prop :=
  (cleanDefine_continuous_between_fee422b0843f4b1d9573 (f) ((@cleanStructure_PointedSpace_4b97411f5be9affa2443.«topology» (P))) ((@cleanStructure_PointedSpace_4b97411f5be9affa2443.«topology» (Q))))

noncomputable def cleanDefine_selected_point_f1237f289da6a1fdd675  (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) : ((@cleanStructure_PointedSpace_4b97411f5be9affa2443.«carrier» (P))) :=
  (@cleanStructure_PointedSpace_4b97411f5be9affa2443.«point» (P))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: local
reference: equality reflexivity
relationship: original
-/
def point_equality : Prop :=
  ∀ (P : cleanStructure_PointedSpace_4b97411f5be9affa2443),
  ∀ (x : ((@cleanStructure_PointedSpace_4b97411f5be9affa2443.«carrier» (P)))),
  (x = x)

/--
source: local
reference: Mathlib continuous_const
relationship: specialized
-/
def constant_map_continuous : Prop :=
  ∀ (P : cleanStructure_PointedSpace_4b97411f5be9affa2443),
  (@cleanDefine_bundle_continuous_f264edce70c3d7b32602 (P) (P) ((@cleanDefine_constant_map_ba4ce9b813550272149f (P))))

/--
source: local
reference: authored carrier reduction
relationship: original
-/
def carrier_alias : Prop :=
  ∀ (P : cleanStructure_PointedSpace_4b97411f5be9affa2443),
  ∀ (x : ((cleanDefine_carrier_of_2a99826e44642f4a6809 (P)))),
  ((cleanNotation_evaluate_map_fc8e4f20170606ffe807 ((fun (clean_bound_0 : ((@cleanStructure_PointedSpace_4b97411f5be9affa2443.«carrier» (P)))) => clean_bound_0)) (x)) = x)

/--
source: local
reference: constructor projection
relationship: original
-/
def constructor_point : Prop :=
  ∀ (T : Type),
  ∀ (t : TopologicalSpace T),
  ∀ (x : T),
  (x = x)

/--
source: local
reference: dependent return substitution
relationship: original
-/
def selected_point_projection : Prop :=
  ∀ (Q : cleanStructure_PointedSpace_4b97411f5be9affa2443),
  ((@cleanDefine_selected_point_f1237f289da6a1fdd675 (Q)) = (@cleanStructure_PointedSpace_4b97411f5be9affa2443.«point» (Q)))

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

structure ExpectedPointedSpace : Type 1 where
 carrier : Type
 topology : TopologicalSpace carrier
 point : carrier
noncomputable def expected_constructor (carrier : Type) (topology : TopologicalSpace carrier) (point : carrier) : ExpectedPointedSpace :=
 @ExpectedPointedSpace.mk carrier topology point

noncomputable def expected_carrier (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) : Type := @cleanStructure_PointedSpace_4b97411f5be9affa2443.carrier P
noncomputable def expected_constant (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) : P.carrier → P.carrier := fun x => @cleanStructure_PointedSpace_4b97411f5be9affa2443.point P
noncomputable def expected_continuous (P Q : cleanStructure_PointedSpace_4b97411f5be9affa2443) (f : P.carrier → Q.carrier) : Prop :=
 @cleanDefine_continuous_between_fee422b0843f4b1d9573 P.carrier Q.carrier f P.topology Q.topology
noncomputable def expected_selected (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) : P.carrier := @cleanStructure_PointedSpace_4b97411f5be9affa2443.point P
same_basic_target cleanDefine_carrier_of_2a99826e44642f4a6809 expected_carrier
same_basic_target cleanDefine_constant_map_ba4ce9b813550272149f expected_constant
same_basic_target cleanDefine_bundle_continuous_f264edce70c3d7b32602 expected_continuous
same_basic_target cleanDefine_selected_point_f1237f289da6a1fdd675 expected_selected

def expected_point_equality : Prop := ∀ (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) (x : P.carrier), x = x
def expected_constant_continuous : Prop := ∀ (P : cleanStructure_PointedSpace_4b97411f5be9affa2443), cleanDefine_bundle_continuous_f264edce70c3d7b32602 P P (cleanDefine_constant_map_ba4ce9b813550272149f P)
def expected_carrier_alias : Prop := ∀ (P : cleanStructure_PointedSpace_4b97411f5be9affa2443) (x : cleanDefine_carrier_of_2a99826e44642f4a6809 P),
 @cleanNotation_evaluate_map_fc8e4f20170606ffe807 P.carrier P.carrier (fun y : P.carrier => y) x = x
def expected_constructor_point : Prop := ∀ (T : Type) (t : TopologicalSpace T) (x : T), x = x
def expected_selected_projection : Prop := ∀ (Q : cleanStructure_PointedSpace_4b97411f5be9affa2443), cleanDefine_selected_point_f1237f289da6a1fdd675 Q = Q.point
same_basic_target CleanStatements.point_equality expected_point_equality
same_basic_target CleanStatements.constant_map_continuous expected_constant_continuous
same_basic_target CleanStatements.carrier_alias expected_carrier_alias
same_basic_target CleanStatements.constructor_point expected_constructor_point
same_basic_target CleanStatements.selected_point_projection expected_selected_projection

theorem point_equality_checked : CleanStatements.point_equality := by intro P x; rfl
theorem constant_continuous_checked : CleanStatements.constant_map_continuous := by
 intro P
 letI : TopologicalSpace P.carrier := P.topology
 change ∀ S : Set P.carrier, IsOpen S → IsOpen ((fun _ : P.carrier => P.point) ⁻¹' S)
 intro S hS
 exact hS.preimage continuous_const
theorem carrier_alias_checked : CleanStatements.carrier_alias := by intro P x; rfl
theorem constructor_point_checked : CleanStatements.constructor_point := by intro T t x; rfl
theorem selected_projection_checked : CleanStatements.selected_point_projection := by intro Q; rfl

private def carrierCanonical (names : List (Name × Name)) : Expr → Expr
 | .const n us => .const ((names.find? (fun p => p.1 == n)).map Prod.snd |>.getD n) us
 | .proj n i b => .proj ((names.find? (fun p => p.1 == n)).map Prod.snd |>.getD n) i (carrierCanonical names b)
 | .lam _ t b i => .lam Name.anonymous (carrierCanonical names t) (carrierCanonical names b) i
 | .forallE _ t b i => .forallE Name.anonymous (carrierCanonical names t) (carrierCanonical names b) i
 | .letE _ t v b n => .letE Name.anonymous (carrierCanonical names t) (carrierCanonical names v) (carrierCanonical names b) n
 | .app f a => .app (carrierCanonical names f) (carrierCanonical names a)
 | .mdata _ b => carrierCanonical names b
 | e => e

run_cmd do
 let env ← getEnv
 let names : List (Name × Name) := [(`cleanStructure_PointedSpace_4b97411f5be9affa2443, `ExpectedPointedSpace), (`cleanStructure_PointedSpace_4b97411f5be9affa2443.mk, `ExpectedPointedSpace.mk), (`cleanStructure_PointedSpace_4b97411f5be9affa2443.carrier, `ExpectedPointedSpace.carrier), (`cleanStructure_PointedSpace_4b97411f5be9affa2443.topology, `ExpectedPointedSpace.topology), (`cleanStructure_PointedSpace_4b97411f5be9affa2443.point, `ExpectedPointedSpace.point)]
 let checks : List (Name × Name) := [(`cleanStructure_PointedSpace_4b97411f5be9affa2443, `ExpectedPointedSpace), (`cleanStructure_PointedSpace_4b97411f5be9affa2443.mk, `ExpectedPointedSpace.mk), (`cleanStructure_PointedSpace_4b97411f5be9affa2443.carrier, `ExpectedPointedSpace.carrier), (`cleanStructure_PointedSpace_4b97411f5be9affa2443.topology, `ExpectedPointedSpace.topology), (`cleanStructure_PointedSpace_4b97411f5be9affa2443.point, `ExpectedPointedSpace.point), (`cleanConstructor_pointed_space_63873b521438f4b6aaf3, `expected_constructor)]

 for (a,b) in checks do
  let some x := env.find? a | throwError "Missing actual {a}"
  let some y := env.find? b | throwError "Missing expected {b}"
  unless x.levelParams == y.levelParams && Expr.equal (carrierCanonical names x.type) (carrierCanonical names y.type) do
   throwError "Carrier declaration type differs: {a}"
  match x, y with
  | .defnInfo dx, .defnInfo dy =>
    unless Expr.equal (carrierCanonical names dx.value) (carrierCanonical names dy.value) do
     throwError "Carrier declaration body differs: {a}"
  | .inductInfo _, .inductInfo _ => pure ()
  | .ctorInfo _, .ctorInfo _ => pure ()
  | _, _ => throwError "Carrier declaration kinds differ: {a}"

-- generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
