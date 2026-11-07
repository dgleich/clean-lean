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
import Mathlib.Topology.Category.TopCat.Basic

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

noncomputable def cleanType_TopologicalSpace_d66be29262ccb5d89e3b  : Type 1 :=
  TopCat.{0}

noncomputable def cleanType_Point_9d395db6c3916b4d8815 (X : TopCat.{0}) : Type :=
  (TopCat.carrier X)

noncomputable def cleanType_ContinuousMap_1146b39bc8bc0eb23b61 (X : TopCat.{0}) (Y : TopCat.{0}) : Type :=
  (@ContinuousMap X.carrier Y.carrier X.str Y.str)

noncomputable def cleanNotation_topological_space_f914ed39b3c4b34a458d  (X : Type) (t : TopologicalSpace X) : TopCat.{0} :=
  @TopCat.of.{0} X t

noncomputable def cleanNotation_space_topology_b2730f9844c3dbcbb1b2  (X : TopCat.{0}) : TopologicalSpace (TopCat.carrier X) :=
  TopCat.str X

noncomputable def cleanNotation_underlying_continuous_map_46ba25e3bbb7fb81de27  (X : TopCat.{0}) (Y : TopCat.{0}) (f : (@ContinuousMap X.carrier Y.carrier X.str Y.str)) : ((TopCat.carrier X)) → ((TopCat.carrier Y)) :=
  @ContinuousMap.toFun X.carrier Y.carrier X.str Y.str f

noncomputable def cleanNotation_continuous_value_e0e5252f52b24d976ca2  (X : TopCat.{0}) (Y : TopCat.{0}) (f : (@ContinuousMap X.carrier Y.carrier X.str Y.str)) (x : (TopCat.carrier X)) : (TopCat.carrier Y) :=
  @ContinuousMap.toFun X.carrier Y.carrier X.str Y.str f x

noncomputable def cleanNotation_identity_continuous_map_315ac9c43278079f1ecf  (X : TopCat.{0}) : (@ContinuousMap X.carrier X.carrier X.str X.str) :=
  @ContinuousMap.id X.carrier X.str

noncomputable def cleanNotation_compose_continuous_maps_5b97f65ef52a877965dc  (X : TopCat.{0}) (Y : TopCat.{0}) (Z : TopCat.{0}) (g : (@ContinuousMap Y.carrier Z.carrier Y.str Z.str)) (f : (@ContinuousMap X.carrier Y.carrier X.str Y.str)) : (@ContinuousMap X.carrier Z.carrier X.str Z.str) :=
  @ContinuousMap.comp X.carrier Y.carrier Z.carrier X.str Y.str Z.str g f

structure cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75  : Type 1 where
  «source» : TopCat.{0}
  «target» : TopCat.{0}
  «arrow» : (@ContinuousMap «source».carrier «target».carrier «source».str «target».str)

noncomputable def cleanConstructor_topological_diagram_3fd3e4e646daf54240f0 («source» : TopCat.{0}) («target» : TopCat.{0}) («arrow» : (@ContinuousMap «source».carrier «target».carrier «source».str «target».str)) : cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75 :=
  @cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.mk «source» «target» «arrow»

noncomputable def cleanDefine_identity_diagram_d9f548f51d6a44697707  (X : TopCat.{0}) : cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75 :=
  (@cleanConstructor_topological_diagram_3fd3e4e646daf54240f0 (X) (X) ((@cleanNotation_identity_continuous_map_315ac9c43278079f1ecf (X))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: mathlib
reference: ContinuousMap.id_apply
relationship: adapted
-/
def continuous_identity_fixes_each_point : Prop :=
  ∀ (X : TopCat.{0}),
  ∀ (x : (TopCat.carrier X)),
  ((@cleanNotation_continuous_value_e0e5252f52b24d976ca2 (X) (X) ((@cleanNotation_identity_continuous_map_315ac9c43278079f1ecf (X))) (x)) = x)

/--
source: mathlib
reference: ContinuousMap.comp_apply
relationship: adapted
-/
def continuous_composition_acts_pointwise : Prop :=
  ∀ (X Y Z : TopCat.{0}),
  ∀ (f : (@ContinuousMap X.carrier Y.carrier X.str Y.str)),
  ∀ (g : (@ContinuousMap Y.carrier Z.carrier Y.str Z.str)),
  ∀ (x : (TopCat.carrier X)),
  ((@cleanNotation_continuous_value_e0e5252f52b24d976ca2 (X) (Z) ((@cleanNotation_compose_continuous_maps_5b97f65ef52a877965dc (X) (Y) (Z) (g) (f))) (x)) = (@cleanNotation_continuous_value_e0e5252f52b24d976ca2 (Y) (Z) (g) ((@cleanNotation_continuous_value_e0e5252f52b24d976ca2 (X) (Y) (f) (x)))))

/--
source: mathlib
reference: ContinuousMap.id_comp
relationship: adapted
-/
def identity_on_the_target_preserves_a_continuous_map : Prop :=
  ∀ (X Y : TopCat.{0}),
  ∀ (f : (@ContinuousMap X.carrier Y.carrier X.str Y.str)),
  ((@cleanNotation_compose_continuous_maps_5b97f65ef52a877965dc (X) (Y) (Y) ((@cleanNotation_identity_continuous_map_315ac9c43278079f1ecf (Y))) (f)) = f)

/--
source: topology
reference: identity diagram projections
relationship: original
-/
def identity_diagram_has_its_declared_spaces : Prop :=
  ∀ (X : TopCat.{0}),
  let D : cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75 := (cleanDefine_identity_diagram_d9f548f51d6a44697707 (X));
  (((@cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.«source» (D)) = X) ∧ ((@cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.«target» (D)) = X))

/--
source: topology
reference: dependent diagram field
relationship: original
-/
def diagram_supplies_its_continuous_map : Prop :=
  ∀ (D : cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75),
  (@Exists ((@ContinuousMap (@cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.«source» (D)).carrier (@cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.«target» (D)).carrier (@cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.«source» (D)).str (@cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.«target» (D)).str)) (fun (clean_bound_0 : (@ContinuousMap (@cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.«source» (D)).carrier (@cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.«target» (D)).carrier (@cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.«source» (D)).str (@cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.«target» (D)).str)) => (clean_bound_0 = (@cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.«arrow» (D)))))

end CleanStatements

noncomputable def cleanType_Zero_43e3aaa4ea3cc1535513  : Type :=
  Nat

noncomputable def cleanType_One_84f2c011d1cfaa45ee03  : Type 1 :=
  Type

noncomputable def cleanType_Two_3be28f8951d97abf6ed8  : Type 2 :=
  Type 1

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `SpaceOracle.Diagram then return `cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75
  if n == `SpaceOracle.spaceType then return `cleanType_TopologicalSpace_d66be29262ccb5d89e3b
  if n == `SpaceOracle.pointType then return `cleanType_Point_9d395db6c3916b4d8815
  if n == `SpaceOracle.mapType then return `cleanType_ContinuousMap_1146b39bc8bc0eb23b61
  if n == `SpaceOracle.bundle then return `cleanNotation_topological_space_f914ed39b3c4b34a458d
  if n == `SpaceOracle.topology then return `cleanNotation_space_topology_b2730f9844c3dbcbb1b2
  if n == `SpaceOracle.underlying then return `cleanNotation_underlying_continuous_map_46ba25e3bbb7fb81de27
  if n == `SpaceOracle.value then return `cleanNotation_continuous_value_e0e5252f52b24d976ca2
  if n == `SpaceOracle.identity then return `cleanNotation_identity_continuous_map_315ac9c43278079f1ecf
  if n == `SpaceOracle.compose then return `cleanNotation_compose_continuous_maps_5b97f65ef52a877965dc
  if n == `SpaceOracle.diagram then return `cleanConstructor_topological_diagram_3fd3e4e646daf54240f0
  if n == `SpaceOracle.identityDiagram then return `cleanDefine_identity_diagram_d9f548f51d6a44697707
  if n == `SpaceOracle.levelZero then return `cleanType_Zero_43e3aaa4ea3cc1535513
  if n == `SpaceOracle.levelOne then return `cleanType_One_84f2c011d1cfaa45ee03
  if n == `SpaceOracle.levelTwo then return `cleanType_Two_3be28f8951d97abf6ed8
  match n with
  | .str p s => return .str (canonicalName p) s
  | .num p i => return .num (canonicalName p) i
  | .anonymous => return .anonymous
private def canonical : Expr → Expr
  | .const n u => .const (canonicalName n) u
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj (canonicalName n) i (canonical b)
  | e => e
elab "same_target " a:ident b:ident : command => do
  let env ← getEnv
  let some x := env.find? a.getId | throwError "Missing actual target"
  let some y := env.find? b.getId | throwError "Missing expected target"
  unless x.levelParams == y.levelParams && Expr.equal (canonical x.type) (canonical y.type) do
    throwError "Canonical type differs: {a} vs {b}"
  match x,y with
  | .defnInfo x,.defnInfo y =>
    unless Expr.equal (canonical x.value) (canonical y.value) do
      throwError "Canonical body differs: {a} vs {b}"
  | .ctorInfo x,.ctorInfo y =>
    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&
        canonicalName x.induct == canonicalName y.induct do
      throwError "Constructor shape differs"
  | .inductInfo x,.inductInfo y =>
    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&
        x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do
      throwError "Structure shape differs"
  | _,_ => throwError "Unexpected declaration kinds"

namespace SpaceOracle
noncomputable def levelZero : Type := Nat
noncomputable def levelOne : Type 1 := Type
noncomputable def levelTwo : Type 2 := Type 1
noncomputable def spaceType : Type 1 := TopCat.{0}
noncomputable def pointType (X : TopCat.{0}) : Type := TopCat.carrier X
noncomputable def mapType (X Y : TopCat.{0}) : Type :=
  @ContinuousMap X.carrier Y.carrier X.str Y.str
noncomputable def bundle (X : Type) (t : TopologicalSpace X) : TopCat.{0} := @TopCat.of.{0} X t
noncomputable def topology (X : TopCat.{0}) : TopologicalSpace X.carrier := TopCat.str X
noncomputable def underlying (X Y : TopCat.{0}) (f : @ContinuousMap X.carrier Y.carrier X.str Y.str) :
  X.carrier → Y.carrier := @ContinuousMap.toFun X.carrier Y.carrier X.str Y.str f
noncomputable def value (X Y : TopCat.{0}) (f : @ContinuousMap X.carrier Y.carrier X.str Y.str)
  (x : X.carrier) : Y.carrier := @ContinuousMap.toFun X.carrier Y.carrier X.str Y.str f x
noncomputable def identity (X : TopCat.{0}) : @ContinuousMap X.carrier X.carrier X.str X.str :=
  @ContinuousMap.id X.carrier X.str
noncomputable def compose (X Y Z : TopCat.{0})
  (g : @ContinuousMap Y.carrier Z.carrier Y.str Z.str)
  (f : @ContinuousMap X.carrier Y.carrier X.str Y.str) :
  @ContinuousMap X.carrier Z.carrier X.str Z.str :=
  @ContinuousMap.comp X.carrier Y.carrier Z.carrier X.str Y.str Z.str g f
structure Diagram : Type 1 where
  source : TopCat.{0}
  target : TopCat.{0}
  arrow : @ContinuousMap source.carrier target.carrier source.str target.str
noncomputable def diagram (source target : TopCat.{0})
  (arrow : @ContinuousMap source.carrier target.carrier source.str target.str) : Diagram :=
  @Diagram.mk source target arrow
noncomputable def identityDiagram (X : TopCat.{0}) : Diagram := diagram X X (@identity X)
def identityStatement : Prop := ∀ (X : TopCat.{0}) (x : X.carrier), @value X X (@identity X) x=x
def composeStatement : Prop := ∀ (X Y Z : TopCat.{0})
  (f : @ContinuousMap X.carrier Y.carrier X.str Y.str)
  (g : @ContinuousMap Y.carrier Z.carrier Y.str Z.str) (x : X.carrier),
  @value X Z (@compose X Y Z g f) x = @value Y Z g (@value X Y f x)
def leftIdentityStatement : Prop := ∀ (X Y : TopCat.{0})
  (f : @ContinuousMap X.carrier Y.carrier X.str Y.str), @compose X Y Y (@identity Y) f=f
def diagramStatement : Prop := ∀ (X : TopCat.{0}), let D : Diagram := identityDiagram X;
  @Diagram.source D = X ∧ @Diagram.target D = X
def arrowStatement : Prop := ∀ (D : Diagram),
  @Exists (@ContinuousMap D.source.carrier D.target.carrier D.source.str D.target.str)
    (fun f => f = @Diagram.arrow D)
end SpaceOracle
same_target cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75 SpaceOracle.Diagram
same_target cleanType_TopologicalSpace_d66be29262ccb5d89e3b SpaceOracle.spaceType
same_target cleanType_Point_9d395db6c3916b4d8815 SpaceOracle.pointType
same_target cleanType_ContinuousMap_1146b39bc8bc0eb23b61 SpaceOracle.mapType
same_target cleanNotation_topological_space_f914ed39b3c4b34a458d SpaceOracle.bundle
same_target cleanNotation_space_topology_b2730f9844c3dbcbb1b2 SpaceOracle.topology
same_target cleanNotation_underlying_continuous_map_46ba25e3bbb7fb81de27 SpaceOracle.underlying
same_target cleanNotation_continuous_value_e0e5252f52b24d976ca2 SpaceOracle.value
same_target cleanNotation_identity_continuous_map_315ac9c43278079f1ecf SpaceOracle.identity
same_target cleanNotation_compose_continuous_maps_5b97f65ef52a877965dc SpaceOracle.compose
same_target cleanConstructor_topological_diagram_3fd3e4e646daf54240f0 SpaceOracle.diagram
same_target cleanDefine_identity_diagram_d9f548f51d6a44697707 SpaceOracle.identityDiagram
same_target cleanType_Zero_43e3aaa4ea3cc1535513 SpaceOracle.levelZero
same_target cleanType_One_84f2c011d1cfaa45ee03 SpaceOracle.levelOne
same_target cleanType_Two_3be28f8951d97abf6ed8 SpaceOracle.levelTwo
same_target cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.mk SpaceOracle.Diagram.mk
same_target cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.source SpaceOracle.Diagram.source
same_target cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.target SpaceOracle.Diagram.target
same_target cleanStructure_TopologicalDiagram_5f4137d1fa5370857d75.arrow SpaceOracle.Diagram.arrow
same_target CleanStatements.continuous_identity_fixes_each_point SpaceOracle.identityStatement
same_target CleanStatements.continuous_composition_acts_pointwise SpaceOracle.composeStatement
same_target CleanStatements.identity_on_the_target_preserves_a_continuous_map SpaceOracle.leftIdentityStatement
same_target CleanStatements.identity_diagram_has_its_declared_spaces SpaceOracle.diagramStatement
same_target CleanStatements.diagram_supplies_its_continuous_map SpaceOracle.arrowStatement

namespace SpaceProofs
theorem continuous_identity_fixes_each_point : CleanStatements.continuous_identity_fixes_each_point := by
  intro X x
  rfl
theorem continuous_composition_acts_pointwise : CleanStatements.continuous_composition_acts_pointwise := by
  intro X Y Z f g x
  rfl
theorem identity_on_the_target_preserves_a_continuous_map : CleanStatements.identity_on_the_target_preserves_a_continuous_map := by
  intro X Y f
  exact ContinuousMap.id_comp f
theorem identity_diagram_has_its_declared_spaces : CleanStatements.identity_diagram_has_its_declared_spaces := by
  intro X
  exact ⟨rfl,rfl⟩
theorem diagram_supplies_its_continuous_map : CleanStatements.diagram_supplies_its_continuous_map := by
  intro D
  exact ⟨D.arrow,rfl⟩
end SpaceProofs

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
