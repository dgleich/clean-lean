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

noncomputable abbrev cleanType_TopologicalSpace_d66be29262ccb5d89e3b  : Type 1 :=
  TopCat.{0}

noncomputable abbrev cleanType_Point_f8a65e23875fb9a2c125 (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type :=
  (TopCat.carrier X)

noncomputable abbrev cleanType_ContinuousMap_05cf8501fbb474169b7a (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type :=
  (@ContinuousMap X.carrier Y.carrier X.str Y.str)

noncomputable def cleanNotation_topological_space_dc14231c2f4f1a05c1eb  (X : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b) :=
  @TopCat.of.{0} X t

noncomputable def cleanNotation_space_topology_d65bd6911832f73ca5e3  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_Topology_2eca621ea710e87cf174 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X)))) :=
  TopCat.str X

noncomputable def cleanNotation_underlying_continuous_map_4c98c5280d9a83caf5c3  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (f : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) : ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) → ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (Y))) :=
  @ContinuousMap.toFun X.carrier Y.carrier X.str Y.str f

noncomputable def cleanNotation_continuous_value_e3b2704dc348962834fc  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (f : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) (x : (_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) : (_root_.cleanType_Point_f8a65e23875fb9a2c125 (Y)) :=
  @ContinuousMap.toFun X.carrier Y.carrier X.str Y.str f x

noncomputable def cleanNotation_identity_continuous_map_3328841a46298311ee43  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (X)) :=
  @ContinuousMap.id X.carrier X.str

noncomputable def cleanNotation_compose_continuous_maps_f3da5f5645c1a654d6b9  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Z : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (g : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (Y) (Z))) (f : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Z)) :=
  @ContinuousMap.comp X.carrier Y.carrier Z.carrier X.str Y.str Z.str g f

structure cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1  : Type 1 where
  «source» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)
  «target» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)
  «arrow» : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a («source») («target»))

noncomputable def cleanConstructor_topological_diagram_ccce48ab8336c31ce6a9 («source» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («target» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («arrow» : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a («source») («target»))) : _root_.cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1 :=
  @_root_.cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1.mk «source» «target» «arrow»

noncomputable def cleanDefine_identity_diagram_4eaea8dd61f4669fc3a0  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : _root_.cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1 :=
  (@_root_.cleanConstructor_topological_diagram_ccce48ab8336c31ce6a9 (X) (X) ((@_root_.cleanNotation_identity_continuous_map_3328841a46298311ee43 (X))))


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
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (x : (_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))),
  ((@_root_.cleanNotation_continuous_value_e3b2704dc348962834fc (X) (X) ((@_root_.cleanNotation_identity_continuous_map_3328841a46298311ee43 (X))) (x)) = x)

/--
source: mathlib
reference: ContinuousMap.comp_apply
relationship: adapted
-/
def continuous_composition_acts_pointwise : Prop :=
  ∀ (X Y Z : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (f : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))),
  ∀ (g : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (Y) (Z))),
  ∀ (x : (_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))),
  ((@_root_.cleanNotation_continuous_value_e3b2704dc348962834fc (X) (Z) ((@_root_.cleanNotation_compose_continuous_maps_f3da5f5645c1a654d6b9 (X) (Y) (Z) (g) (f))) (x)) = (@_root_.cleanNotation_continuous_value_e3b2704dc348962834fc (Y) (Z) (g) ((@_root_.cleanNotation_continuous_value_e3b2704dc348962834fc (X) (Y) (f) (x)))))

/--
source: mathlib
reference: ContinuousMap.id_comp
relationship: adapted
-/
def identity_on_the_target_preserves_a_continuous_map : Prop :=
  ∀ (X Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (f : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))),
  ((@_root_.cleanNotation_compose_continuous_maps_f3da5f5645c1a654d6b9 (X) (Y) (Y) ((@_root_.cleanNotation_identity_continuous_map_3328841a46298311ee43 (Y))) (f)) = f)

/--
source: topology
reference: identity diagram projections
relationship: original
-/
def identity_diagram_has_its_declared_spaces : Prop :=
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  let D : _root_.cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1 := (_root_.cleanDefine_identity_diagram_4eaea8dd61f4669fc3a0 (X));
  (((@_root_.cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1.«source» (D)) = X) ∧ ((@_root_.cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1.«target» (D)) = X))

/--
source: topology
reference: dependent diagram field
relationship: original
-/
def diagram_supplies_its_continuous_map : Prop :=
  ∀ (D : _root_.cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1),
  (@Exists ((_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a ((@_root_.cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1.«source» (D))) ((@_root_.cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1.«target» (D))))) (fun (clean_bound_0 : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a ((@_root_.cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1.«source» (D))) ((@_root_.cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1.«target» (D))))) => (clean_bound_0 = (@_root_.cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1.«arrow» (D)))))

end CleanStatements

noncomputable abbrev cleanType_Zero_43e3aaa4ea3cc1535513  : Type :=
  Nat

noncomputable abbrev cleanType_One_84f2c011d1cfaa45ee03  : Type 1 :=
  Type

noncomputable abbrev cleanType_Two_3be28f8951d97abf6ed8  : Type 2 :=
  Type 1

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `SpaceOracle.Diagram then return `cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1
  if n == `SpaceOracle.spaceType then return `cleanType_TopologicalSpace_d66be29262ccb5d89e3b
  if n == `SpaceOracle.pointType then return `cleanType_Point_f8a65e23875fb9a2c125
  if n == `SpaceOracle.mapType then return `cleanType_ContinuousMap_05cf8501fbb474169b7a
  if n == `SpaceOracle.carrierType then return `cleanType_Type_c1fed1af64ab6f12e0ed
  if n == `SpaceOracle.topologyType then return `cleanType_Topology_2eca621ea710e87cf174
  if n == `SpaceOracle.bundle then return `cleanNotation_topological_space_dc14231c2f4f1a05c1eb
  if n == `SpaceOracle.topology then return `cleanNotation_space_topology_d65bd6911832f73ca5e3
  if n == `SpaceOracle.underlying then return `cleanNotation_underlying_continuous_map_4c98c5280d9a83caf5c3
  if n == `SpaceOracle.value then return `cleanNotation_continuous_value_e3b2704dc348962834fc
  if n == `SpaceOracle.identity then return `cleanNotation_identity_continuous_map_3328841a46298311ee43
  if n == `SpaceOracle.compose then return `cleanNotation_compose_continuous_maps_f3da5f5645c1a654d6b9
  if n == `SpaceOracle.diagram then return `cleanConstructor_topological_diagram_ccce48ab8336c31ce6a9
  if n == `SpaceOracle.identityDiagram then return `cleanDefine_identity_diagram_4eaea8dd61f4669fc3a0
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
noncomputable def carrierType : Type 1 := Type
noncomputable def topologyType (X : Type) : Type := TopologicalSpace X
noncomputable def spaceType : Type 1 := TopCat.{0}
noncomputable def pointType (X : spaceType) : Type := TopCat.carrier X
noncomputable def mapType (X Y : spaceType) : Type :=
  @ContinuousMap X.carrier Y.carrier X.str Y.str
noncomputable def bundle (X : carrierType) (t : topologyType X) : spaceType := @TopCat.of.{0} X t
noncomputable def topology (X : spaceType) : topologyType (pointType X) := TopCat.str X
noncomputable def underlying (X Y : spaceType) (f : mapType X Y) :
  pointType X → pointType Y := @ContinuousMap.toFun X.carrier Y.carrier X.str Y.str f
noncomputable def value (X Y : spaceType) (f : mapType X Y)
  (x : pointType X) : pointType Y := @ContinuousMap.toFun X.carrier Y.carrier X.str Y.str f x
noncomputable def identity (X : spaceType) : mapType X X :=
  @ContinuousMap.id X.carrier X.str
noncomputable def compose (X Y Z : spaceType)
  (g : mapType Y Z) (f : mapType X Y) : mapType X Z :=
  @ContinuousMap.comp X.carrier Y.carrier Z.carrier X.str Y.str Z.str g f
structure Diagram : Type 1 where
  source : spaceType
  target : spaceType
  arrow : mapType source target
noncomputable def diagram (source target : spaceType)
  (arrow : mapType source target) : Diagram := @Diagram.mk source target arrow
noncomputable def identityDiagram (X : spaceType) : Diagram := diagram X X (@identity X)
def identityStatement : Prop := ∀ (X : spaceType) (x : pointType X), @value X X (@identity X) x=x
def composeStatement : Prop := ∀ (X Y Z : spaceType)
  (f : mapType X Y) (g : mapType Y Z) (x : pointType X),
  @value X Z (@compose X Y Z g f) x = @value Y Z g (@value X Y f x)
def leftIdentityStatement : Prop := ∀ (X Y : spaceType)
  (f : mapType X Y), @compose X Y Y (@identity Y) f=f
def diagramStatement : Prop := ∀ (X : spaceType), let D : Diagram := identityDiagram X;
  @Diagram.source D = X ∧ @Diagram.target D = X
def arrowStatement : Prop := ∀ (D : Diagram),
  @Exists (mapType D.source D.target) (fun f => f = @Diagram.arrow D)
end SpaceOracle
same_target cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1 SpaceOracle.Diagram
same_target cleanType_TopologicalSpace_d66be29262ccb5d89e3b SpaceOracle.spaceType
same_target cleanType_Point_f8a65e23875fb9a2c125 SpaceOracle.pointType
same_target cleanType_ContinuousMap_05cf8501fbb474169b7a SpaceOracle.mapType
same_target cleanType_Type_c1fed1af64ab6f12e0ed SpaceOracle.carrierType
same_target cleanType_Topology_2eca621ea710e87cf174 SpaceOracle.topologyType
same_target cleanNotation_topological_space_dc14231c2f4f1a05c1eb SpaceOracle.bundle
same_target cleanNotation_space_topology_d65bd6911832f73ca5e3 SpaceOracle.topology
same_target cleanNotation_underlying_continuous_map_4c98c5280d9a83caf5c3 SpaceOracle.underlying
same_target cleanNotation_continuous_value_e3b2704dc348962834fc SpaceOracle.value
same_target cleanNotation_identity_continuous_map_3328841a46298311ee43 SpaceOracle.identity
same_target cleanNotation_compose_continuous_maps_f3da5f5645c1a654d6b9 SpaceOracle.compose
same_target cleanConstructor_topological_diagram_ccce48ab8336c31ce6a9 SpaceOracle.diagram
same_target cleanDefine_identity_diagram_4eaea8dd61f4669fc3a0 SpaceOracle.identityDiagram
same_target cleanType_Zero_43e3aaa4ea3cc1535513 SpaceOracle.levelZero
same_target cleanType_One_84f2c011d1cfaa45ee03 SpaceOracle.levelOne
same_target cleanType_Two_3be28f8951d97abf6ed8 SpaceOracle.levelTwo
same_target cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1.mk SpaceOracle.Diagram.mk
same_target cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1.source SpaceOracle.Diagram.source
same_target cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1.target SpaceOracle.Diagram.target
same_target cleanStructure_TopologicalDiagram_e9430f3a193ee28421c1.arrow SpaceOracle.Diagram.arrow
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
