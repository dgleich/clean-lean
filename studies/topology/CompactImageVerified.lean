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
import Mathlib.Topology.Compactness.Compact

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

noncomputable def cleanDefine_compact_in_301821979e6d65a95bf1 {X : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  @IsCompact X t S


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/-!
A continuous image of a compact set is compact.
Both topologies are explicit; no separation assumption is needed.
-/

/--
source: mathlib
reference: IsCompact.image
relationship: adapted
-/
def continuous_image_of_a_compact_set : Prop :=
  ∀ (X Y : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))),
  ∀ (u : (_root_.cleanType_Topology_2eca621ea710e87cf174 (Y))),
  ∀ (f : (X) → (Y)),
  ∀ (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))),
  ∀ («continuity_of_f_from_t_to_u» : (_root_.cleanDefine_continuous_between_3b927933ead621e0bfe9 (f) (t) (u))),
  ∀ («compactness_of_S_in_t» : (_root_.cleanDefine_compact_in_301821979e6d65a95bf1 (S) (t))),
  (_root_.cleanDefine_compact_in_301821979e6d65a95bf1 ((_root_.cleanDefine_image_869a575587985294ee29 (f) (S))) (u))

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

noncomputable def expected_compact_adapter {X : Type} (S : _root_.cleanType_Set_6e300741358eee425e81 X) (t : _root_.cleanType_Topology_2eca621ea710e87cf174 X) : _root_.cleanType_Proposition_ae4a13d2f060407bce35 :=
  @IsCompact X t S
same_basic_target cleanDefine_compact_in_301821979e6d65a95bf1 expected_compact_adapter
noncomputable def expected_compact_statement : Prop :=
  ∀ (X Y : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (t : _root_.cleanType_Topology_2eca621ea710e87cf174 X) (u : _root_.cleanType_Topology_2eca621ea710e87cf174 Y) (f : X → Y) (S : _root_.cleanType_Set_6e300741358eee425e81 X),
    @_root_.cleanDefine_continuous_between_3b927933ead621e0bfe9 X Y f t u → @_root_.cleanDefine_compact_in_301821979e6d65a95bf1 X S t →
    @_root_.cleanDefine_compact_in_301821979e6d65a95bf1 Y (@_root_.cleanDefine_image_869a575587985294ee29 X Y f S) u
same_basic_target CleanStatements.continuous_image_of_a_compact_set expected_compact_statement

namespace CompactImageProofs

-- Independently written mathematical target in native Mathlib vocabulary.
def nativeStatement : Prop :=
  ∀ (X Y : Type) (t : TopologicalSpace X) (u : TopologicalSpace Y)
    (f : X → Y) (S : Set X),
    @Continuous X Y t u f → @IsCompact X t S → @IsCompact Y u (f '' S)

-- This is a mathematical equivalence check, not a canonical Expr oracle.
theorem statement_agrees :
    CleanStatements.continuous_image_of_a_compact_set ↔ nativeStatement := by
  constructor
  · intro h X Y t u f S hf hS
    exact h X Y t u f S ((@continuous_def X Y t u f).mp hf) hS
  · intro h X Y t u f S hf hS
    exact h X Y t u f S ((@continuous_def X Y t u f).mpr hf) hS

theorem continuous_image_of_a_compact_set :
    CleanStatements.continuous_image_of_a_compact_set := by
  apply statement_agrees.mpr
  intro X Y t u f S hf hS
  letI : TopologicalSpace X := t
  letI : TopologicalSpace Y := u
  exact hS.image hf

end CompactImageProofs

-- generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
