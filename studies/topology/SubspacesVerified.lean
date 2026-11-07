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
import Mathlib.LinearAlgebra.Span.Basic

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

noncomputable abbrev cleanType_FieldStructure_473fae039b953a4e35cf (K : Type) : Type :=
  Field K

noncomputable abbrev cleanType_AdditiveGroup_666602168ae423a21d05 (V : Type) : Type :=
  AddCommGroup V

noncomputable abbrev cleanType_ModuleStructure_0b8e617c710f84874c5e (K : Type) (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (V : Type) (a : (_root_.cleanType_AdditiveGroup_666602168ae423a21d05 (V))) : Type :=
  @Module K V f.toSemiring a.toAddCommMonoid

structure cleanStructure_LinearSpace_f45f02f1386f986b860e («K» : Type) («f» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («V» : Type) : Type where
  «addition» : (_root_.cleanType_AdditiveGroup_666602168ae423a21d05 («V»))
  «action» : (_root_.cleanType_ModuleStructure_0b8e617c710f84874c5e («K») («f») («V») («addition»))

noncomputable def cleanConstructor_linear_space_c6906729504c965f4274 («K» : Type) («f» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («V» : Type) («addition» : (_root_.cleanType_AdditiveGroup_666602168ae423a21d05 («V»))) («action» : (_root_.cleanType_ModuleStructure_0b8e617c710f84874c5e («K») («f») («V») («addition»))) : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e («K») («f») («V») :=
  @_root_.cleanStructure_LinearSpace_f45f02f1386f986b860e.mk «K» «f» «V» «addition» «action»

noncomputable abbrev cleanType_Subspace_dc5ab31620781ca45e7b (K : Type) (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (V : Type) (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)) : Type :=
  @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action

noncomputable def cleanNotation_subspace_carrier_a36fe035268c9f2bf46c {K : Type} {V : Type} (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)) (U : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L))) : (_root_.cleanType_Set_6e300741358eee425e81 (V)) :=
  @SetLike.coe (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) V (@Submodule.setLike K V f.toSemiring L.addition.toAddCommMonoid L.action) U

noncomputable def cleanDefine_belongs_to_subspace_cac970f86f8d567f0d73 {K : Type} {V : Type} (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)) (x : V) (U : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (x ∈ (@_root_.cleanNotation_subspace_carrier_a36fe035268c9f2bf46c (K) (V) (f) (L) (U)))

noncomputable def cleanDefine_subspace_included_in_9d54abefbe28ea507ec5 {K : Type} {V : Type} (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)) (U : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L))) (W : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : V), ((@_root_.cleanDefine_belongs_to_subspace_cac970f86f8d567f0d73 (K) (V) (f) (L) (clean_bound_0) (U)) → (@_root_.cleanDefine_belongs_to_subspace_cac970f86f8d567f0d73 (K) (V) (f) (L) (clean_bound_0) (W))))

noncomputable def cleanNotation_subspace_infimum_9664207c517e43bafadf {K : Type} {V : Type} (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)) (spaces : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L))))) : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L)) :=
  @sInf (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) (@Submodule.instInfSet K V f.toSemiring L.addition.toAddCommMonoid L.action) spaces

noncomputable def cleanDefine_intersection_of_subspaces_69f80863cdfaf06239cf {K : Type} {V : Type} {I : Type} (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)) (A : (_root_.cleanType_Set_6e300741358eee425e81 (I))) (spaces : (I) → ((_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L)))) : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L)) :=
  (@_root_.cleanNotation_subspace_infimum_9664207c517e43bafadf (K) (V) (f) (L) ((_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L))) => (@Exists (I) (fun (clean_bound_1 : I) => ((clean_bound_1 ∈ A) ∧ (clean_bound_0 = (spaces clean_bound_1))))))))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/-!
These are algebraic ingredients for perturbation-indexed well groups.
The ambient space and scalar structure are fixed explicitly.
This file does not assert the two-extreme-perturbation characterization.
-/

/--
source: mathlib
reference: Submodule.mem_sInf
relationship: adapted
-/
def indexed_intersection_membership : Prop :=
  ∀ (K V I : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)),
  ∀ (A : (_root_.cleanType_Set_6e300741358eee425e81 (I))),
  ∀ (S : (I) → ((_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L)))),
  ∀ (x : V),
  ((@_root_.cleanDefine_belongs_to_subspace_cac970f86f8d567f0d73 (K) (V) (f) (L) (x) ((@_root_.cleanDefine_intersection_of_subspaces_69f80863cdfaf06239cf (K) (V) (I) (f) (L) (A) (S)))) ↔ (∀ (clean_bound_0 : I), ((clean_bound_0 ∈ A) → (@_root_.cleanDefine_belongs_to_subspace_cac970f86f8d567f0d73 (K) (V) (f) (L) (x) ((S clean_bound_0))))))

/--
source: mathlib
reference: Submodule.mem_sInf
relationship: adapted
-/
def intersection_is_included_in_each_member : Prop :=
  ∀ (K V I : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)),
  ∀ (A : (_root_.cleanType_Set_6e300741358eee425e81 (I))),
  ∀ (S : (I) → ((_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L)))),
  ∀ (i : I),
  ∀ («admissible_index» : (i ∈ A)),
  (@_root_.cleanDefine_subspace_included_in_9d54abefbe28ea507ec5 (K) (V) (f) (L) ((@_root_.cleanDefine_intersection_of_subspaces_69f80863cdfaf06239cf (K) (V) (I) (f) (L) (A) (S))) ((S i)))

/--
source: mathlib
reference: Submodule.mem_sInf
relationship: adapted
-/
def more_indices_give_a_smaller_intersection : Prop :=
  ∀ (K V I : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)),
  ∀ (A : (_root_.cleanType_Set_6e300741358eee425e81 (I))),
  ∀ (S : (I) → ((_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L)))),
  ∀ (B : (_root_.cleanType_Set_6e300741358eee425e81 (I))),
  ∀ («more_indices» : (A ⊆ B)),
  (@_root_.cleanDefine_subspace_included_in_9d54abefbe28ea507ec5 (K) (V) (f) (L) ((@_root_.cleanDefine_intersection_of_subspaces_69f80863cdfaf06239cf (K) (V) (I) (f) (L) (B) (S))) ((@_root_.cleanDefine_intersection_of_subspaces_69f80863cdfaf06239cf (K) (V) (I) (f) (L) (A) (S))))

/--
source: mathlib
reference: Submodule.mem_sInf
relationship: adapted
-/
def empty_family_contains_every_vector : Prop :=
  ∀ (K V I : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (f : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (f) (V)),
  ∀ (A : (_root_.cleanType_Set_6e300741358eee425e81 (I))),
  ∀ (S : (I) → ((_root_.cleanType_Subspace_dc5ab31620781ca45e7b (K) (f) (V) (L)))),
  ∀ (x : V),
  ∀ («no_admissible_indices» : (∀ (clean_bound_0 : I), (¬(clean_bound_0 ∈ A)))),
  (@_root_.cleanDefine_belongs_to_subspace_cac970f86f8d567f0d73 (K) (V) (f) (L) (x) ((@_root_.cleanDefine_intersection_of_subspaces_69f80863cdfaf06239cf (K) (V) (I) (f) (L) (A) (S))))

end CleanStatements

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `SubspaceOracle.LinearSpace then return `cleanStructure_LinearSpace_f45f02f1386f986b860e
  if n == `SubspaceOracle.carrierType then return `cleanType_Type_c1fed1af64ab6f12e0ed
  if n == `SubspaceOracle.conditionType then return `cleanType_Proposition_ae4a13d2f060407bce35
  if n == `SubspaceOracle.setType then return `cleanType_Set_6e300741358eee425e81
  if n == `SubspaceOracle.fieldType then return `cleanType_FieldStructure_473fae039b953a4e35cf
  if n == `SubspaceOracle.additiveType then return `cleanType_AdditiveGroup_666602168ae423a21d05
  if n == `SubspaceOracle.moduleType then return `cleanType_ModuleStructure_0b8e617c710f84874c5e
  if n == `SubspaceOracle.subspaceType then return `cleanType_Subspace_dc5ab31620781ca45e7b
  if n == `SubspaceOracle.makeSpace then return `cleanConstructor_linear_space_c6906729504c965f4274
  if n == `SubspaceOracle.carrier then return `cleanNotation_subspace_carrier_a36fe035268c9f2bf46c
  if n == `SubspaceOracle.belongs then return `cleanDefine_belongs_to_subspace_cac970f86f8d567f0d73
  if n == `SubspaceOracle.included then return `cleanDefine_subspace_included_in_9d54abefbe28ea507ec5
  if n == `SubspaceOracle.infimum then return `cleanNotation_subspace_infimum_9664207c517e43bafadf
  if n == `SubspaceOracle.intersection then return `cleanDefine_intersection_of_subspaces_69f80863cdfaf06239cf
  if n == `SubspaceOracle.setOf then return `cleanNotation_set_of_2c71fd475f49a65bd03e
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

namespace SubspaceOracle
noncomputable abbrev carrierType : Type 1 := Type
noncomputable abbrev conditionType : Sort 1 := Prop
noncomputable abbrev setType (X : Type) : Type := Set X
noncomputable abbrev fieldType (K : Type) : Type := Field K
noncomputable abbrev additiveType (V : Type) : Type := AddCommGroup V
noncomputable abbrev moduleType (K : Type) (f : fieldType K) (V : Type) (a : additiveType V) : Type :=
  @Module K V f.toSemiring a.toAddCommMonoid
structure LinearSpace (K : Type) (f : fieldType K) (V : Type) : Type where
  addition : additiveType V
  action : moduleType K f V addition
noncomputable def makeSpace (K : Type) (f : fieldType K) (V : Type) (a : additiveType V)
    (m : moduleType K f V a) : LinearSpace K f V :=
  @LinearSpace.mk K f V a m
noncomputable abbrev subspaceType (K : Type) (f : fieldType K) (V : Type) (L : LinearSpace K f V) : Type :=
  @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action
noncomputable def carrier {K V : Type} (f : fieldType K) (L : LinearSpace K f V)
    (U : subspaceType K f V L) : setType V :=
  @SetLike.coe (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) V
    (@Submodule.setLike K V f.toSemiring L.addition.toAddCommMonoid L.action) U
noncomputable def belongs {K V : Type} (f : fieldType K) (L : LinearSpace K f V) (x : V)
    (U : subspaceType K f V L) : conditionType :=
  x ∈ @carrier K V f L U
noncomputable def included {K V : Type} (f : fieldType K) (L : LinearSpace K f V)
    (U W : subspaceType K f V L) : conditionType :=
  ∀ x : V, @belongs K V f L x U → @belongs K V f L x W
noncomputable def infimum {K V : Type} (f : fieldType K) (L : LinearSpace K f V)
    (S : setType (subspaceType K f V L)) :
    subspaceType K f V L :=
  @sInf (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action)
    (@Submodule.instInfSet K V f.toSemiring L.addition.toAddCommMonoid L.action) S
noncomputable def setOf {X : Type} (condition : X → conditionType) : setType X := _root_.setOf condition
noncomputable def intersection {K V I : Type} (f : fieldType K) (L : LinearSpace K f V)
    (A : setType I) (spaces : I → subspaceType K f V L) :
    subspaceType K f V L :=
  @infimum K V f L (@setOf (subspaceType K f V L)
    (fun U => @Exists I (fun i => i ∈ A ∧ U=spaces i)))

def membershipStatement : Prop := ∀ (K V I : carrierType) (f : fieldType K) (L : LinearSpace K f V)
  (A : setType I) (spaces : I → subspaceType K f V L) (x : V),
  @belongs K V f L x (@intersection K V I f L A spaces) ↔
    ∀ i : I, i ∈ A → @belongs K V f L x (spaces i)
def includedStatement : Prop := ∀ (K V I : carrierType) (f : fieldType K) (L : LinearSpace K f V)
  (A : setType I) (spaces : I → subspaceType K f V L) (i : I),
  i ∈ A → @included K V f L (@intersection K V I f L A spaces) (spaces i)
def antitoneStatement : Prop := ∀ (K V I : carrierType) (f : fieldType K) (L : LinearSpace K f V)
  (A : setType I) (spaces : I → subspaceType K f V L) (B : setType I),
  A ⊆ B → @included K V f L (@intersection K V I f L B spaces) (@intersection K V I f L A spaces)
def emptyStatement : Prop := ∀ (K V I : carrierType) (f : fieldType K) (L : LinearSpace K f V)
  (A : setType I) (spaces : I → subspaceType K f V L) (x : V),
  (∀ i : I, ¬ i ∈ A) → @belongs K V f L x (@intersection K V I f L A spaces)
end SubspaceOracle
same_target cleanStructure_LinearSpace_f45f02f1386f986b860e SubspaceOracle.LinearSpace
same_target cleanType_Type_c1fed1af64ab6f12e0ed SubspaceOracle.carrierType
same_target cleanType_Proposition_ae4a13d2f060407bce35 SubspaceOracle.conditionType
same_target cleanType_Set_6e300741358eee425e81 SubspaceOracle.setType
same_target cleanType_FieldStructure_473fae039b953a4e35cf SubspaceOracle.fieldType
same_target cleanType_AdditiveGroup_666602168ae423a21d05 SubspaceOracle.additiveType
same_target cleanType_ModuleStructure_0b8e617c710f84874c5e SubspaceOracle.moduleType
same_target cleanType_Subspace_dc5ab31620781ca45e7b SubspaceOracle.subspaceType
same_target cleanConstructor_linear_space_c6906729504c965f4274 SubspaceOracle.makeSpace
same_target cleanNotation_subspace_carrier_a36fe035268c9f2bf46c SubspaceOracle.carrier
same_target cleanDefine_belongs_to_subspace_cac970f86f8d567f0d73 SubspaceOracle.belongs
same_target cleanDefine_subspace_included_in_9d54abefbe28ea507ec5 SubspaceOracle.included
same_target cleanNotation_subspace_infimum_9664207c517e43bafadf SubspaceOracle.infimum
same_target cleanDefine_intersection_of_subspaces_69f80863cdfaf06239cf SubspaceOracle.intersection
same_target cleanNotation_set_of_2c71fd475f49a65bd03e SubspaceOracle.setOf
same_target cleanStructure_LinearSpace_f45f02f1386f986b860e.mk SubspaceOracle.LinearSpace.mk
same_target cleanStructure_LinearSpace_f45f02f1386f986b860e.addition SubspaceOracle.LinearSpace.addition
same_target cleanStructure_LinearSpace_f45f02f1386f986b860e.action SubspaceOracle.LinearSpace.action
same_target CleanStatements.indexed_intersection_membership SubspaceOracle.membershipStatement
same_target CleanStatements.intersection_is_included_in_each_member SubspaceOracle.includedStatement
same_target CleanStatements.more_indices_give_a_smaller_intersection SubspaceOracle.antitoneStatement
same_target CleanStatements.empty_family_contains_every_vector SubspaceOracle.emptyStatement

namespace SubspaceProofs
theorem indexed_intersection_membership : CleanStatements.indexed_intersection_membership := by
  intro K V I f L A spaces x
  letI : Field K := f
  letI : AddCommGroup V := L.addition
  letI : Module K V := L.action
  change x ∈ sInf {U : Submodule K V | ∃ i : I, i ∈ A ∧ U = spaces i} ↔
    ∀ i : I, i ∈ A → x ∈ spaces i
  constructor
  · intro hx i hi
    exact (Submodule.mem_sInf.mp hx) (spaces i) ⟨i,hi,rfl⟩
  · intro hx
    apply Submodule.mem_sInf.mpr
    intro U hU
    obtain ⟨i,hi,rfl⟩ := hU
    exact hx i hi

theorem intersection_is_included_in_each_member : CleanStatements.intersection_is_included_in_each_member := by
  intro K V I f L A spaces i hi x hx
  exact (indexed_intersection_membership K V I f L A spaces x).mp hx i hi

theorem more_indices_give_a_smaller_intersection : CleanStatements.more_indices_give_a_smaller_intersection := by
  intro K V I f L A spaces B hAB x hx
  apply (indexed_intersection_membership K V I f L A spaces x).mpr
  intro i hi
  exact (indexed_intersection_membership K V I f L B spaces x).mp hx i (hAB hi)

theorem empty_family_contains_every_vector : CleanStatements.empty_family_contains_every_vector := by
  intro K V I f L A spaces x hnone
  apply (indexed_intersection_membership K V I f L A spaces x).mpr
  intro i hi
  exact False.elim (hnone i hi)
end SubspaceProofs

-- generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
