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
import Mathlib.Algebra.Category.ModuleCat.Basic

/-!
Basic topology with explicit carrier types and topologies.
   Mathematical preimages, images, composition, and continuity are authored here.
   This first module is restricted to carrier types in Lean Type 0.
-/

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

noncomputable def cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

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

noncomputable def cleanType_FieldStructure_473fae039b953a4e35cf (K : Type) : Type :=
  Field K

noncomputable def cleanType_AdditiveGroup_666602168ae423a21d05 (V : Type) : Type :=
  AddCommGroup V

noncomputable def cleanType_ModuleStructure_820ec14dd63d4f0c4588 (K : Type) (f : Field K) (V : Type) (a : AddCommGroup V) : Type :=
  @Module K V f.toSemiring a.toAddCommMonoid

structure cleanStructure_LinearSpace_5642406e6e2374eb8d06 («K» : Type) («f» : Field «K») («V» : Type) : Type where
  «addition» : AddCommGroup «V»
  «action» : @Module «K» «V» «f».toSemiring «addition».toAddCommMonoid

noncomputable def cleanConstructor_linear_space_b20108f764cf57d518bf («K» : Type) («f» : Field «K») («V» : Type) («addition» : AddCommGroup «V») («action» : @Module «K» «V» «f».toSemiring «addition».toAddCommMonoid) : cleanStructure_LinearSpace_5642406e6e2374eb8d06 («K») («f») («V») :=
  @cleanStructure_LinearSpace_5642406e6e2374eb8d06.mk «K» «f» «V» «addition» «action»

noncomputable def cleanType_Subspace_8486bbfd1e163b11a16f (K : Type) (f : Field K) (V : Type) (L : cleanStructure_LinearSpace_5642406e6e2374eb8d06 (K) (f) (V)) : Type :=
  @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action

noncomputable def cleanNotation_subspace_carrier_f070e04df90854f81887 {K : Type} {V : Type} (f : Field K) (L : cleanStructure_LinearSpace_5642406e6e2374eb8d06 (K) (f) (V)) (U : @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) : Set (V) :=
  @SetLike.coe (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) V (@Submodule.setLike K V f.toSemiring L.addition.toAddCommMonoid L.action) U

noncomputable def cleanDefine_belongs_to_subspace_ec8790b9b2bf97dae6d9 {K : Type} {V : Type} (f : Field K) (L : cleanStructure_LinearSpace_5642406e6e2374eb8d06 (K) (f) (V)) (x : V) (U : @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) : Prop :=
  (x ∈ (@cleanNotation_subspace_carrier_f070e04df90854f81887 (K) (V) (f) (L) (U)))

noncomputable def cleanDefine_subspace_included_in_d5798f9beb1245834242 {K : Type} {V : Type} (f : Field K) (L : cleanStructure_LinearSpace_5642406e6e2374eb8d06 (K) (f) (V)) (U : @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) (W : @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) : Prop :=
  (∀ (clean_bound_0 : V), ((@cleanDefine_belongs_to_subspace_ec8790b9b2bf97dae6d9 (K) (V) (f) (L) (clean_bound_0) (U)) → (@cleanDefine_belongs_to_subspace_ec8790b9b2bf97dae6d9 (K) (V) (f) (L) (clean_bound_0) (W))))

noncomputable def cleanNotation_subspace_infimum_5fa957304ce3d9bcc086 {K : Type} {V : Type} (f : Field K) (L : cleanStructure_LinearSpace_5642406e6e2374eb8d06 (K) (f) (V)) (spaces : Set (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action)) : @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action :=
  @sInf (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) (@Submodule.instInfSet K V f.toSemiring L.addition.toAddCommMonoid L.action) spaces

noncomputable def cleanDefine_intersection_of_subspaces_639a4229345a029542f3 {K : Type} {V : Type} {I : Type} (f : Field K) (L : cleanStructure_LinearSpace_5642406e6e2374eb8d06 (K) (f) (V)) (A : Set (I)) (spaces : (I) → (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action)) : @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action :=
  (@cleanNotation_subspace_infimum_5fa957304ce3d9bcc086 (K) (V) (f) (L) ((cleanNotation_set_of_25534029a1fdae044ce8 ((fun (clean_bound_0 : @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) => (@Exists (I) (fun (clean_bound_1 : I) => ((clean_bound_1 ∈ A) ∧ (clean_bound_0 = (spaces clean_bound_1))))))))))

noncomputable def cleanType_CoefficientModule_51152214c957ecc84ea1 (K : Type) (field : Field K) : Type 1 :=
  (@ModuleCat.{0,0} K field.toRing)

noncomputable def cleanType_ModuleElement_b836832e231addafdcde (K : Type) (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) : Type :=
  (@ModuleCat.carrier K field.toRing M)

noncomputable def cleanNotation_coefficient_module_1a0755937bb2a62d769c  (K : Type) (field : Field K) (V : Type) (L : cleanStructure_LinearSpace_5642406e6e2374eb8d06 (K) (field) (V)) : (@ModuleCat.{0,0} K field.toRing) :=
  @ModuleCat.of K field.toRing V L.addition L.action

noncomputable def cleanType_ModuleMap_5397c112671d325e4f70 (K : Type) (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) (N : (@ModuleCat.{0,0} K field.toRing)) : Type :=
  (@ModuleCat.Hom K field.toRing M N)

noncomputable def cleanType_ModuleSubspace_1d5cec6119106efdc1bf (K : Type) (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) : Type :=
  (@Submodule K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule)

noncomputable def cleanNotation_module_map_value_f0835c4f7a36db98a213 {K : Type} (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) (N : (@ModuleCat.{0,0} K field.toRing)) (f : (@ModuleCat.Hom K field.toRing M N)) (x : (@ModuleCat.carrier K field.toRing M)) : (@ModuleCat.carrier K field.toRing N) :=
  (@ModuleCat.Hom.hom K field.toRing M N f) x

noncomputable def cleanNotation_module_map_range_3ddb83929271b74045bc {K : Type} (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) (N : (@ModuleCat.{0,0} K field.toRing)) (f : (@ModuleCat.Hom K field.toRing M N)) : (@Submodule K N.carrier field.toSemiring N.isAddCommGroup.toAddCommMonoid N.isModule) :=
  LinearMap.range (@ModuleCat.Hom.hom K field.toRing M N f)

noncomputable def cleanNotation_module_subspace_carrier_dfe8594175e35b27e6cd {K : Type} (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) (U : (@Submodule K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule)) : Set ((@ModuleCat.carrier K field.toRing M)) :=
  U.carrier

noncomputable def cleanDefine_belongs_to_module_subspace_678dcb75741602fad2b5 {K : Type} (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) (x : (@ModuleCat.carrier K field.toRing M)) (U : (@Submodule K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule)) : Prop :=
  (x ∈ (@cleanNotation_module_subspace_carrier_dfe8594175e35b27e6cd (K) (field) (M) (U)))

structure cleanStructure_GradedModule_db830affbb1da28ca3aa («K» : Type) («field» : Field «K») : Type 1 where
  «component» : (ℕ) → ((@ModuleCat.{0,0} «K» «field».toRing))

noncomputable def cleanConstructor_graded_module_50ded2c434f81d68c40c («K» : Type) («field» : Field «K») («component» : (ℕ) → ((@ModuleCat.{0,0} «K» «field».toRing))) : cleanStructure_GradedModule_db830affbb1da28ca3aa («K») («field») :=
  @cleanStructure_GradedModule_db830affbb1da28ca3aa.mk «K» «field» «component»

noncomputable def cleanDefine_component_module_16aff9d37d3cf0c1675c {K : Type} (field : Field K) (M : cleanStructure_GradedModule_db830affbb1da28ca3aa (K) (field)) (p : ℕ) : (@ModuleCat.{0,0} K field.toRing) :=
  ((@cleanStructure_GradedModule_db830affbb1da28ca3aa.«component» (K) (field) (M)) p)

structure cleanStructure_GradedMap_7d0b6981486ea03cb162 («K» : Type) («field» : Field «K») («M» : cleanStructure_GradedModule_db830affbb1da28ca3aa («K») («field»)) («N» : cleanStructure_GradedModule_db830affbb1da28ca3aa («K») («field»)) : Type where
  «component» : (clean_pi_bound_0 : ℕ) → ((@ModuleCat.Hom «K» «field».toRing ((@cleanStructure_GradedModule_db830affbb1da28ca3aa.«component» («K») («field») («M»)) clean_pi_bound_0) ((@cleanStructure_GradedModule_db830affbb1da28ca3aa.«component» («K») («field») («N»)) clean_pi_bound_0)))

noncomputable def cleanConstructor_graded_map_515c03a014bbe0523c07 («K» : Type) («field» : Field «K») («M» : cleanStructure_GradedModule_db830affbb1da28ca3aa («K») («field»)) («N» : cleanStructure_GradedModule_db830affbb1da28ca3aa («K») («field»)) («component» : (clean_pi_bound_0 : ℕ) → ((@ModuleCat.Hom «K» «field».toRing ((@cleanStructure_GradedModule_db830affbb1da28ca3aa.«component» («K») («field») («M»)) clean_pi_bound_0) ((@cleanStructure_GradedModule_db830affbb1da28ca3aa.«component» («K») («field») («N»)) clean_pi_bound_0)))) : cleanStructure_GradedMap_7d0b6981486ea03cb162 («K») («field») («M») («N») :=
  @cleanStructure_GradedMap_7d0b6981486ea03cb162.mk «K» «field» «M» «N» «component»

noncomputable def cleanNotation_module_identity_584a18e3c6f6747bc76f {K : Type} (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) : (@ModuleCat.Hom K field.toRing M M) :=
  @CategoryTheory.CategoryStruct.id (@ModuleCat.{0,0} K field.toRing) (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct M

noncomputable def cleanNotation_module_composition_115d9963c374fb45e52e {K : Type} (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) (N : (@ModuleCat.{0,0} K field.toRing)) (P : (@ModuleCat.{0,0} K field.toRing)) (f : (@ModuleCat.Hom K field.toRing M N)) (g : (@ModuleCat.Hom K field.toRing N P)) : (@ModuleCat.Hom K field.toRing M P) :=
  @CategoryTheory.CategoryStruct.comp (@ModuleCat.{0,0} K field.toRing) (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct M N P f g

noncomputable def cleanDefine_graded_identity_c616d4bdb0b54c49a1e2 {K : Type} (field : Field K) (M : cleanStructure_GradedModule_db830affbb1da28ca3aa (K) (field)) : cleanStructure_GradedMap_7d0b6981486ea03cb162 (K) (field) (M) (M) :=
  (@cleanConstructor_graded_map_515c03a014bbe0523c07 (K) (field) (M) (M) ((fun (clean_bound_0 : ℕ) => (@cleanNotation_module_identity_584a18e3c6f6747bc76f (K) (field) (((@cleanStructure_GradedModule_db830affbb1da28ca3aa.«component» (K) (field) (M)) clean_bound_0))))))

noncomputable def cleanDefine_graded_composition_6e387c2cd5de8784f643 {K : Type} (field : Field K) (M : cleanStructure_GradedModule_db830affbb1da28ca3aa (K) (field)) (N : cleanStructure_GradedModule_db830affbb1da28ca3aa (K) (field)) (P : cleanStructure_GradedModule_db830affbb1da28ca3aa (K) (field)) (f : cleanStructure_GradedMap_7d0b6981486ea03cb162 (K) (field) (M) (N)) (g : cleanStructure_GradedMap_7d0b6981486ea03cb162 (K) (field) (N) (P)) : cleanStructure_GradedMap_7d0b6981486ea03cb162 (K) (field) (M) (P) :=
  (@cleanConstructor_graded_map_515c03a014bbe0523c07 (K) (field) (M) (P) ((fun (clean_bound_0 : ℕ) => (@cleanNotation_module_composition_115d9963c374fb45e52e (K) (field) (((@cleanStructure_GradedModule_db830affbb1da28ca3aa.«component» (K) (field) (M)) clean_bound_0)) (((@cleanStructure_GradedModule_db830affbb1da28ca3aa.«component» (K) (field) (N)) clean_bound_0)) (((@cleanStructure_GradedModule_db830affbb1da28ca3aa.«component» (K) (field) (P)) clean_bound_0)) (((@cleanStructure_GradedMap_7d0b6981486ea03cb162.«component» (K) (field) (M) (N) (f)) clean_bound_0)) (((@cleanStructure_GradedMap_7d0b6981486ea03cb162.«component» (K) (field) (N) (P) (g)) clean_bound_0))))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: topology
reference: graded map left identity
relationship: original
-/
def graded_left_identity : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (M N : cleanStructure_GradedModule_db830affbb1da28ca3aa (K) (field)),
  ∀ (f : cleanStructure_GradedMap_7d0b6981486ea03cb162 (K) (field) (M) (N)),
  ((@cleanDefine_graded_composition_6e387c2cd5de8784f643 (K) (field) (M) (M) (N) ((@cleanDefine_graded_identity_c616d4bdb0b54c49a1e2 (K) (field) (M))) (f)) = f)

/--
source: topology
reference: graded map right identity
relationship: original
-/
def graded_right_identity : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (M N : cleanStructure_GradedModule_db830affbb1da28ca3aa (K) (field)),
  ∀ (f : cleanStructure_GradedMap_7d0b6981486ea03cb162 (K) (field) (M) (N)),
  ((@cleanDefine_graded_composition_6e387c2cd5de8784f643 (K) (field) (M) (N) (N) (f) ((@cleanDefine_graded_identity_c616d4bdb0b54c49a1e2 (K) (field) (N)))) = f)

/--
source: topology
reference: graded map associativity
relationship: original
-/
def graded_associativity : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (M N P Q : cleanStructure_GradedModule_db830affbb1da28ca3aa (K) (field)),
  ∀ (f : cleanStructure_GradedMap_7d0b6981486ea03cb162 (K) (field) (M) (N)),
  ∀ (g : cleanStructure_GradedMap_7d0b6981486ea03cb162 (K) (field) (N) (P)),
  ∀ (h : cleanStructure_GradedMap_7d0b6981486ea03cb162 (K) (field) (P) (Q)),
  ((@cleanDefine_graded_composition_6e387c2cd5de8784f643 (K) (field) (M) (P) (Q) ((@cleanDefine_graded_composition_6e387c2cd5de8784f643 (K) (field) (M) (N) (P) (f) (g))) (h)) = (@cleanDefine_graded_composition_6e387c2cd5de8784f643 (K) (field) (M) (N) (Q) (f) ((@cleanDefine_graded_composition_6e387c2cd5de8784f643 (K) (field) (N) (P) (Q) (g) (h)))))

end CleanStatements

namespace MapOracle
structure GradedMap (K : Type) (field : Field K) (M N : cleanStructure_GradedModule_db830affbb1da28ca3aa K field) : Type where
  component : (p : ℕ) → @ModuleCat.Hom K field.toRing (M.component p) (N.component p)
noncomputable def gradedMap (K : Type) (field : Field K) (M N : cleanStructure_GradedModule_db830affbb1da28ca3aa K field)
  (component : (p : ℕ) → @ModuleCat.Hom K field.toRing (M.component p) (N.component p)) :
  GradedMap K field M N := @GradedMap.mk K field M N component
noncomputable def moduleIdentity {K : Type} (field : Field K) (M : @ModuleCat.{0,0} K field.toRing) :
  @ModuleCat.Hom K field.toRing M M :=
  @CategoryTheory.CategoryStruct.id (@ModuleCat.{0,0} K field.toRing)
    (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct M
noncomputable def moduleCompose {K : Type} (field : Field K) (M N P : @ModuleCat.{0,0} K field.toRing)
  (f : @ModuleCat.Hom K field.toRing M N) (g : @ModuleCat.Hom K field.toRing N P) :
  @ModuleCat.Hom K field.toRing M P :=
  @CategoryTheory.CategoryStruct.comp (@ModuleCat.{0,0} K field.toRing)
    (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct M N P f g
noncomputable def identity {K : Type} (field : Field K) (M : cleanStructure_GradedModule_db830affbb1da28ca3aa K field) : GradedMap K field M M :=
  @gradedMap K field M M (fun p : ℕ => @moduleIdentity K field (M.component p))
noncomputable def compose {K : Type} (field : Field K) (M N P : cleanStructure_GradedModule_db830affbb1da28ca3aa K field)
  (f : GradedMap K field M N) (g : GradedMap K field N P) : GradedMap K field M P :=
  @gradedMap K field M P (fun p : ℕ => @moduleCompose K field
    (M.component p) (N.component p) (P.component p) (f.component p) (g.component p))
def leftIdentity : Prop := ∀ (K : Type) (field : Field K) (M N : cleanStructure_GradedModule_db830affbb1da28ca3aa K field)
  (f : GradedMap K field M N), @compose K field M M N (@identity K field M) f = f
def rightIdentity : Prop := ∀ (K : Type) (field : Field K) (M N : cleanStructure_GradedModule_db830affbb1da28ca3aa K field)
  (f : GradedMap K field M N), @compose K field M N N f (@identity K field N) = f
def associativity : Prop := ∀ (K : Type) (field : Field K) (M N P Q : cleanStructure_GradedModule_db830affbb1da28ca3aa K field)
  (f : GradedMap K field M N) (g : GradedMap K field N P) (h : GradedMap K field P Q),
  @compose K field M P Q (@compose K field M N P f g) h =
    @compose K field M N Q f (@compose K field N P Q g h)
end MapOracle

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `MapOracle.GradedMap then return `cleanStructure_GradedMap_7d0b6981486ea03cb162
  if n == `MapOracle.gradedMap then return `cleanConstructor_graded_map_515c03a014bbe0523c07
  if n == `MapOracle.identity then return `cleanDefine_graded_identity_c616d4bdb0b54c49a1e2
  if n == `MapOracle.compose then return `cleanDefine_graded_composition_6e387c2cd5de8784f643
  if n == `MapOracle.moduleIdentity then return `cleanNotation_module_identity_584a18e3c6f6747bc76f
  if n == `MapOracle.moduleCompose then return `cleanNotation_module_composition_115d9963c374fb45e52e
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
    unless Expr.equal (canonical x.value) (canonical y.value) do throwError "Canonical body differs"
  | .ctorInfo x,.ctorInfo y =>
    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&
      canonicalName x.induct == canonicalName y.induct do throwError "Constructor differs"
  | .inductInfo x,.inductInfo y =>
    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&
      x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do throwError "Record differs"
  | _,_ => throwError "Unexpected declaration kinds"
same_target cleanStructure_GradedMap_7d0b6981486ea03cb162 MapOracle.GradedMap
same_target cleanConstructor_graded_map_515c03a014bbe0523c07 MapOracle.gradedMap
same_target cleanDefine_graded_identity_c616d4bdb0b54c49a1e2 MapOracle.identity
same_target cleanDefine_graded_composition_6e387c2cd5de8784f643 MapOracle.compose
same_target cleanNotation_module_identity_584a18e3c6f6747bc76f MapOracle.moduleIdentity
same_target cleanNotation_module_composition_115d9963c374fb45e52e MapOracle.moduleCompose
same_target cleanStructure_GradedMap_7d0b6981486ea03cb162.mk MapOracle.GradedMap.mk
same_target cleanStructure_GradedMap_7d0b6981486ea03cb162.component MapOracle.GradedMap.component
same_target CleanStatements.graded_left_identity MapOracle.leftIdentity
same_target CleanStatements.graded_right_identity MapOracle.rightIdentity
same_target CleanStatements.graded_associativity MapOracle.associativity
namespace MapProofs
private theorem map_ext {K : Type} {field : Field K} {M N : cleanStructure_GradedModule_db830affbb1da28ca3aa K field}
  (f g : cleanStructure_GradedMap_7d0b6981486ea03cb162 K field M N) (h : f.component = g.component) : f = g := by
  cases f; cases g; cases h; rfl
 theorem left_identity : CleanStatements.graded_left_identity := by
  intro K field M N f
  apply map_ext
  funext p
  exact @CategoryTheory.Category.id_comp (@ModuleCat.{0,0} K field.toRing)
      (@ModuleCat.moduleCategory.{0,0} K field.toRing) (M.component p) (N.component p) (f.component p)
 theorem right_identity : CleanStatements.graded_right_identity := by
  intro K field M N f
  apply map_ext
  funext p
  exact @CategoryTheory.Category.comp_id (@ModuleCat.{0,0} K field.toRing)
      (@ModuleCat.moduleCategory.{0,0} K field.toRing) (M.component p) (N.component p) (f.component p)
 theorem associativity : CleanStatements.graded_associativity := by
  intro K field M N P Q f g h
  apply map_ext
  funext p
  exact @CategoryTheory.Category.assoc (@ModuleCat.{0,0} K field.toRing)
    (@ModuleCat.moduleCategory.{0,0} K field.toRing) (M.component p) (N.component p)
    (P.component p) (Q.component p) (f.component p) (g.component p) (h.component p)
end MapProofs

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
