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
import Mathlib.LinearAlgebra.Span.Basic
import Mathlib.Algebra.Category.ModuleCat.Basic
import Mathlib.AlgebraicTopology.SingularHomology.Basic
import Mathlib.Algebra.Category.ModuleCat.Abelian
import Mathlib.Algebra.Category.ModuleCat.Colimits

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

structure cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b («K» : Type) («field» : Field «K») : Type 1 where
  «coefficients» : (@ModuleCat.{0,0} «K» «field».toRing)
  «degree» : ℕ

noncomputable def cleanConstructor_homology_theory_129259f7d0cacb19c802 («K» : Type) («field» : Field «K») («coefficients» : (@ModuleCat.{0,0} «K» «field».toRing)) («degree» : ℕ) : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b («K») («field») :=
  @cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b.mk «K» «field» «coefficients» «degree»

noncomputable def cleanNotation_homology_module_637b1330364c9c74b547 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) : (@ModuleCat.{0,0} K field.toRing) :=
  (letI : Field K := field; ((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).obj X)

noncomputable def cleanNotation_homology_linear_map_0ae4bf1851a01e2f8191 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Y : TopCat.{0}) (g : (@ContinuousMap X.carrier Y.carrier X.str Y.str)) : (@ModuleCat.Hom K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (X)) (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (Y))) :=
  (letI : Field K := field; ((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).map (TopCat.ofHom g))

noncomputable def cleanDefine_induced_homology_value_6fc3a0538148f753cdd6 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Y : TopCat.{0}) (g : (@ContinuousMap X.carrier Y.carrier X.str Y.str)) (x : (@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (X)))) : (@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (Y))) :=
  (@cleanNotation_module_map_value_f0835c4f7a36db98a213 (K) (field) ((@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (X))) ((@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (Y))) ((@cleanNotation_homology_linear_map_0ae4bf1851a01e2f8191 (K) (field) (H) (X) (Y) (g))) (x))

noncomputable def cleanDefine_induced_homology_map_40473061c52055c41391 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Y : TopCat.{0}) (g : (@ContinuousMap X.carrier Y.carrier X.str Y.str)) : ((@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (X)))) → ((@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (Y)))) :=
  (fun (clean_bound_0 : (@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (X)))) => (@cleanDefine_induced_homology_value_6fc3a0538148f753cdd6 (K) (field) (H) (X) (Y) (g) (clean_bound_0)))

noncomputable def cleanDefine_homology_image_80867dd2d2b603b209e7 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Y : TopCat.{0}) (g : (@ContinuousMap X.carrier Y.carrier X.str Y.str)) : (@Submodule K (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (Y)).carrier field.toSemiring (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (Y)).isAddCommGroup.toAddCommMonoid (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (Y)).isModule) :=
  (@cleanNotation_module_map_range_3ddb83929271b74045bc (K) (field) ((@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (X))) ((@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (Y))) ((@cleanNotation_homology_linear_map_0ae4bf1851a01e2f8191 (K) (field) (H) (X) (Y) (g))))

structure cleanStructure_ClassInSpace_81686981eac997d7df62 («K» : Type) («field» : Field «K») («H» : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b («K») («field»)) : Type 1 where
  «space» : TopCat.{0}
  «element» : (@ModuleCat.carrier «K» «field».toRing (@cleanNotation_homology_module_637b1330364c9c74b547 («K») («field») («H») («space»)))

noncomputable def cleanConstructor_class_in_space_660a74fa9b1c0e66aa40 («K» : Type) («field» : Field «K») («H» : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b («K») («field»)) («space» : TopCat.{0}) («element» : (@ModuleCat.carrier «K» «field».toRing (@cleanNotation_homology_module_637b1330364c9c74b547 («K») («field») («H») («space»)))) : cleanStructure_ClassInSpace_81686981eac997d7df62 («K») («field») («H») :=
  @cleanStructure_ClassInSpace_81686981eac997d7df62.mk «K» «field» «H» «space» «element»


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: mathlib
reference: CategoryTheory.Functor.map_id
relationship: adapted
-/
def homology_identity_fixes_classes : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)),
  ∀ (X : TopCat.{0}),
  ∀ (x : (@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (X)))),
  ((@cleanDefine_induced_homology_value_6fc3a0538148f753cdd6 (K) (field) (H) (X) (X) ((@cleanNotation_identity_continuous_map_315ac9c43278079f1ecf (X))) (x)) = x)

/--
source: mathlib
reference: CategoryTheory.Functor.map_comp
relationship: adapted
-/
def homology_respects_composition : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)),
  ∀ (X Y Z : TopCat.{0}),
  ∀ (f : (@ContinuousMap X.carrier Y.carrier X.str Y.str)),
  ∀ (g : (@ContinuousMap Y.carrier Z.carrier Y.str Z.str)),
  ∀ (x : (@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (X)))),
  ((@cleanDefine_induced_homology_value_6fc3a0538148f753cdd6 (K) (field) (H) (X) (Z) ((@cleanNotation_compose_continuous_maps_5b97f65ef52a877965dc (X) (Y) (Z) (g) (f))) (x)) = (@cleanDefine_induced_homology_value_6fc3a0538148f753cdd6 (K) (field) (H) (Y) (Z) (g) ((@cleanDefine_induced_homology_value_6fc3a0538148f753cdd6 (K) (field) (H) (X) (Y) (f) (x)))))

/--
source: topology
reference: induced homology map definition
relationship: original
-/
def induced_function_acts_on_classes : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)),
  ∀ (X Y : TopCat.{0}),
  ∀ (f : (@ContinuousMap X.carrier Y.carrier X.str Y.str)),
  ∀ (x : (@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (X)))),
  let h : ((@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (X)))) → ((@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (Y)))) := (@cleanDefine_induced_homology_map_40473061c52055c41391 (K) (field) (H) (X) (Y) (f));
  ((h x) = (@cleanDefine_induced_homology_value_6fc3a0538148f753cdd6 (K) (field) (H) (X) (Y) (f) (x)))

/--
source: mathlib
reference: LinearMap.mem_range
relationship: adapted
-/
def homology_image_membership : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)),
  ∀ (X Y : TopCat.{0}),
  ∀ (f : (@ContinuousMap X.carrier Y.carrier X.str Y.str)),
  ∀ (x : (@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (Y)))),
  let h : ((@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (X)))) → ((@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (Y)))) := (@cleanDefine_induced_homology_map_40473061c52055c41391 (K) (field) (H) (X) (Y) (f));
  let U : (@Submodule K (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (Y)).carrier field.toSemiring (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (Y)).isAddCommGroup.toAddCommMonoid (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (Y)).isModule) := (@cleanDefine_homology_image_80867dd2d2b603b209e7 (K) (field) (H) (X) (Y) (f));
  ((@cleanDefine_belongs_to_module_subspace_678dcb75741602fad2b5 (K) (field) ((@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (Y))) (x) (U)) ↔ (@Exists ((@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (X)))) (fun (clean_bound_0 : (@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (X)))) => ((h clean_bound_0) = x))))

/--
source: topology
reference: computed dependent record field
relationship: original
-/
def bundled_class_has_its_declared_space : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)),
  ∀ (P : cleanStructure_ClassInSpace_81686981eac997d7df62 (K) (field) (H)),
  (@Exists ((@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) ((@cleanStructure_ClassInSpace_81686981eac997d7df62.«space» (K) (field) (H) (P)))))) (fun (clean_bound_0 : (@ModuleCat.carrier K field.toRing (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) ((@cleanStructure_ClassInSpace_81686981eac997d7df62.«space» (K) (field) (H) (P)))))) => (clean_bound_0 = (@cleanStructure_ClassInSpace_81686981eac997d7df62.«element» (K) (field) (H) (P)))))

end CleanStatements

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
