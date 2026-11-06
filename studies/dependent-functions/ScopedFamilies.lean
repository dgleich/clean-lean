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
import Mathlib.Topology.Path
import Mathlib.Algebra.Homology.HomologicalComplexAbelian
import Mathlib.Algebra.Homology.ShortComplex.HomologicalComplex

/-!
Basic topology with explicit carrier types and topologies.
   Mathematical preimages, images, composition, and continuity are authored here.
   This first module is restricted to carrier types in Lean Type 0.
-/

/-!
Evidence is an ordinary transparent alias. A parenthesized condition used
   as a type denotes proofs of that condition. This module supplies no proofs.
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

noncomputable def cleanType_Element_f6cf8dd1e8f2bae54be4 (X : Type) (S : Set (X)) : Type :=
  {x : X // x ∈ S}

noncomputable def cleanType_Path_3fdd593c9b34e872c4b4 (X : Type) (t : TopologicalSpace X) (x : X) (y : X) : Type :=
  @Path X t x y

noncomputable def cleanNotation_underlying_point_158884de113671a93ba6 {X : Type} (S : Set (X)) (x : {x : X // x ∈ S}) : X :=
  x.val

noncomputable def cleanNotation_constant_path_79f5a6b7ce858e190d0b {X : Type} (t : TopologicalSpace X) (x : X) : @Path X t x x :=
  @Path.refl X t x

noncomputable def cleanNotation_reverse_path_43d430a43539939bcf2c {X : Type} (t : TopologicalSpace X) (x : X) (y : X) (p : @Path X t x y) : @Path X t y x :=
  @Path.symm X t x y p

noncomputable def cleanNotation_join_paths_32898d58a46eb9c632f2 {X : Type} (t : TopologicalSpace X) (x : X) (y : X) (z : X) (p : @Path X t x y) (q : @Path X t y z) : @Path X t x z :=
  @Path.trans X t x y z p q

noncomputable def cleanDefine_reverse_twice_70df96ff552a5e9ef886 {X : Type} (t : TopologicalSpace X) (x : X) (y : X) (p : @Path X t x y) : @Path X t x y :=
  (@cleanNotation_reverse_path_43d430a43539939bcf2c (X) (t) (y) (x) ((@cleanNotation_reverse_path_43d430a43539939bcf2c (X) (t) (x) (y) (p))))

structure cleanStructure_SubsetInclusion_7fc22cecd40f767463de («X» : Type) : Type where
  «source» : Set («X»)
  «target» : Set («X»)
  «containment» : ((«source» ⊆ «target»))

noncomputable def cleanConstructor_certified_inclusion_634925e44d761d47bf70 («X» : Type) («source» : Set («X»)) («target» : Set («X»)) («containment» : ((«source» ⊆ «target»))) : cleanStructure_SubsetInclusion_7fc22cecd40f767463de («X») :=
  @cleanStructure_SubsetInclusion_7fc22cecd40f767463de.mk «X» «source» «target» «containment»

noncomputable def cleanNotation_subset_inclusion_map_12092cff24227ab14783  (X : Type) (S : Set (X)) (T : Set (X)) (h : ((S ⊆ T))) : ({x : X // x ∈ S}) → ({x : X // x ∈ T}) :=
  Set.inclusion h

noncomputable def cleanDefine_certified_inclusion_map_b978ebcdd082c055c359  (X : Type) (Q : cleanStructure_SubsetInclusion_7fc22cecd40f767463de (X)) : ({x : X // x ∈ (@cleanStructure_SubsetInclusion_7fc22cecd40f767463de.«source» (X) (Q))}) → ({x : X // x ∈ (@cleanStructure_SubsetInclusion_7fc22cecd40f767463de.«target» (X) (Q))}) :=
  (@cleanNotation_subset_inclusion_map_12092cff24227ab14783 (X) ((@cleanStructure_SubsetInclusion_7fc22cecd40f767463de.«source» (X) (Q))) ((@cleanStructure_SubsetInclusion_7fc22cecd40f767463de.«target» (X) (Q))) ((@cleanStructure_SubsetInclusion_7fc22cecd40f767463de.«containment» (X) (Q))))

noncomputable def cleanDefine_subset_certificate_bc4e70535370b0bef261 {X : Type} (S : Set (X)) (T : Set (X)) (h : ((S ⊆ T))) : cleanStructure_SubsetInclusion_7fc22cecd40f767463de (X) :=
  (@cleanConstructor_certified_inclusion_634925e44d761d47bf70 (X) (S) (T) (h))

structure cleanStructure_TopologicalPair_23a951172729bcd7e2a9 («X» : TopCat.{0}) : Type where
  «ambient» : Set ((TopCat.carrier «X»))
  «relative» : Set ((TopCat.carrier «X»))
  «nesting» : ((«relative» ⊆ «ambient»))

noncomputable def cleanConstructor_topological_pair_d2eb62bc922cb0af9e3c («X» : TopCat.{0}) («ambient» : Set ((TopCat.carrier «X»))) («relative» : Set ((TopCat.carrier «X»))) («nesting» : ((«relative» ⊆ «ambient»))) : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 («X») :=
  @cleanStructure_TopologicalPair_23a951172729bcd7e2a9.mk «X» «ambient» «relative» «nesting»

structure cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 («X» : TopCat.{0}) : Type where
  «source» : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 («X»)
  «target» : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 («X»)
  «ambient» : (((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» («X») («source»)) ⊆ (@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» («X») («target»))))
  «relative» : (((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» («X») («source»)) ⊆ (@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» («X») («target»))))

noncomputable def cleanConstructor_pair_inclusion_4f04d1794c02e12be8a7 («X» : TopCat.{0}) («source» : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 («X»)) («target» : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 («X»)) («ambient» : (((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» («X») («source»)) ⊆ (@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» («X») («target»))))) («relative» : (((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» («X») («source»)) ⊆ (@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» («X») («target»))))) : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 («X») :=
  @cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.mk «X» «source» «target» «ambient» «relative»

noncomputable def cleanDefine_ambient_inclusion_032b049cd73918a6b653  (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) : cleanStructure_SubsetInclusion_7fc22cecd40f767463de ((TopCat.carrier X)) :=
  (@cleanDefine_subset_certificate_bc4e70535370b0bef261 ((TopCat.carrier X)) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«ambient» (X) (Q))))

noncomputable def cleanDefine_relative_inclusion_28b943741c4dc665fd30  (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) : cleanStructure_SubsetInclusion_7fc22cecd40f767463de ((TopCat.carrier X)) :=
  (@cleanDefine_subset_certificate_bc4e70535370b0bef261 ((TopCat.carrier X)) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«relative» (X) (Q))))

noncomputable def cleanNotation_subspace_4d29dc4d5e65a0cd314c  (X : TopCat.{0}) (S : Set ((TopCat.carrier X))) : TopCat.{0} :=
  (letI : TopologicalSpace X.carrier := X.str; TopCat.of S)

noncomputable def cleanNotation_subspace_inclusion_ec403bdf245f64be6ba9  (X : TopCat.{0}) (S : Set ((TopCat.carrier X))) (T : Set ((TopCat.carrier X))) (h : ((S ⊆ T))) : (@ContinuousMap (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) (S)).carrier (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) (T)).carrier (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) (S)).str (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) (T)).str) :=
  (letI : TopologicalSpace X.carrier := X.str; ContinuousMap.inclusion h)

noncomputable def cleanDefine_ambient_continuous_map_8847accc2cf96844c6cb  (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) : (@ContinuousMap (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q)))))).carrier (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)))))).carrier (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q)))))).str (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)))))).str) :=
  (@cleanNotation_subspace_inclusion_ec403bdf245f64be6ba9 (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«ambient» (X) (Q))))

noncomputable def cleanDefine_relative_continuous_map_9ee2cb50fac73bd8824e  (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) : (@ContinuousMap (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q)))))).carrier (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)))))).carrier (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q)))))).str (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)))))).str) :=
  (@cleanNotation_subspace_inclusion_ec403bdf245f64be6ba9 (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«relative» (X) (Q))))

noncomputable def cleanDefine_ambient_composite_563210341a2f39435865  (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) : (@ContinuousMap (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q)))))).carrier (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)))))).carrier (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q)))))).str (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)))))).str) :=
  (@cleanNotation_compose_continuous_maps_5b97f65ef52a877965dc ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))) ((@cleanDefine_ambient_continuous_map_8847accc2cf96844c6cb (X) (Q))) ((@cleanNotation_subspace_inclusion_ec403bdf245f64be6ba9 (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«nesting» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))

noncomputable def cleanDefine_relative_composite_65d097960ba7f9f6872c  (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) : (@ContinuousMap (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q)))))).carrier (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)))))).carrier (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q)))))).str (@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)))))).str) :=
  (@cleanNotation_compose_continuous_maps_5b97f65ef52a877965dc ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))) ((@cleanNotation_subspace_inclusion_ec403bdf245f64be6ba9 (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«nesting» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))) ((@cleanDefine_relative_continuous_map_9ee2cb50fac73bd8824e (X) (Q))))

noncomputable def cleanType_ModuleChainComplex_b70ee3e20da4c1ab8305 (K : Type) (field : Field K) : Type 1 :=
  (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)

noncomputable def cleanType_ChainMap_c3041b721346072705c8 (K : Type) (field : Field K) (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) : Type :=
  (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)

noncomputable def cleanNotation_chain_cokernel_4dbbbbfef07a623c6749 {K : Type} (field : Field K) (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (f : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)) : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ) :=
  (letI : Field K := field; CategoryTheory.Limits.cokernel f)

noncomputable def cleanNotation_chain_cokernel_projection_0fc4366fc1387c70adfa {K : Type} (field : Field K) (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (f : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance D (@cleanNotation_chain_cokernel_4dbbbbfef07a623c6749 (K) (field) (C) (D) (f))) :=
  (letI : Field K := field; CategoryTheory.Limits.cokernel.π f)

noncomputable def cleanNotation_compose_chain_maps_7c3b42656ba4e987ff45 {K : Type} (field : Field K) (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (E : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (g : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance D E)) (f : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C E) :=
  (letI : Field K := field; CategoryTheory.CategoryStruct.comp f g)

noncomputable def cleanNotation_zero_chain_map_aedd3eb32a6dc949f8cd {K : Type} (field : Field K) (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D) :=
  (letI : Field K := field; 0)

noncomputable def cleanNotation_chain_homology_08373901ee9ce5bedd90 {K : Type} (field : Field K) (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (n : ℕ) : (@ModuleCat.{0,0} K field.toRing) :=
  (letI : Field K := field; (HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) n).obj C)

noncomputable def cleanNotation_induced_chain_homology_map_62c79a897825782bdcd3 {K : Type} (field : Field K) (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (f : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)) (n : ℕ) : (@ModuleCat.Hom K field.toRing (@cleanNotation_chain_homology_08373901ee9ce5bedd90 (K) (field) (C) (n)) (@cleanNotation_chain_homology_08373901ee9ce5bedd90 (K) (field) (D) (n))) :=
  (letI : Field K := field; (HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) n).map f)

noncomputable def cleanNotation_singular_chains_5896876ad7f8802529c6 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ) :=
  (letI : Field K := field; ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{0} K)).obj H.coefficients).obj X)

noncomputable def cleanNotation_induced_chain_map_94f837d94faca5d01c50 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Y : TopCat.{0}) (f : (@ContinuousMap X.carrier Y.carrier X.str Y.str)) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance (@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) (X)) (@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) (Y))) :=
  (letI : Field K := field; ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{0} K)).obj H.coefficients).map (TopCat.ofHom f))

noncomputable def cleanDefine_pair_chain_inclusion_e21b8d5fe8d5aa16e6d3 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance (@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) (Q)))))) (@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) (Q))))))) :=
  (@cleanNotation_induced_chain_map_94f837d94faca5d01c50 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) (Q))))) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) (Q))))) ((@cleanNotation_subspace_inclusion_ec403bdf245f64be6ba9 (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) (Q))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) (Q))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«nesting» (X) (Q))))))

noncomputable def cleanDefine_relative_chains_4678c66539e1e43260fb {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ) :=
  (@cleanNotation_chain_cokernel_4dbbbbfef07a623c6749 (K) (field) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) (Q))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) (Q))))))) ((@cleanDefine_pair_chain_inclusion_e21b8d5fe8d5aa16e6d3 (K) (field) (H) (X) (Q))))

noncomputable def cleanDefine_relative_homology_4cec0e496ce985bfa88a {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) : (@ModuleCat.{0,0} K field.toRing) :=
  (@cleanNotation_chain_homology_08373901ee9ce5bedd90 (K) (field) ((@cleanDefine_relative_chains_4678c66539e1e43260fb (K) (field) (H) (X) (Q))) ((@cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b.«degree» (K) (field) (H))))

structure cleanStructure_ChainSquare_53c761a7ae734942d8e5 («K» : Type) («field» : Field «K») («C» : (letI : Field «K» := «field»; ChainComplex (ModuleCat.{0} «K») ℕ)) («D» : (letI : Field «K» := «field»; ChainComplex (ModuleCat.{0} «K») ℕ)) («E» : (letI : Field «K» := «field»; ChainComplex (ModuleCat.{0} «K») ℕ)) («F» : (letI : Field «K» := «field»; ChainComplex (ModuleCat.{0} «K») ℕ)) : Type where
  «source» : (letI : Field «K» := «field»; @Quiver.Hom (ChainComplex (ModuleCat.{0} «K») ℕ) inferInstance «C» «D»)
  «target» : (letI : Field «K» := «field»; @Quiver.Hom (ChainComplex (ModuleCat.{0} «K») ℕ) inferInstance «E» «F»)
  «left» : (letI : Field «K» := «field»; @Quiver.Hom (ChainComplex (ModuleCat.{0} «K») ℕ) inferInstance «C» «E»)
  «right» : (letI : Field «K» := «field»; @Quiver.Hom (ChainComplex (ModuleCat.{0} «K») ℕ) inferInstance «D» «F»)
  «commutes» : (((@cleanNotation_compose_chain_maps_7c3b42656ba4e987ff45 («K») («field») («C») («D») («F») («right») («source»)) = (@cleanNotation_compose_chain_maps_7c3b42656ba4e987ff45 («K») («field») («C») («E») («F») («target») («left»))))

noncomputable def cleanConstructor_chain_square_fc89f7855cc3636ecd54 («K» : Type) («field» : Field «K») («C» : (letI : Field «K» := «field»; ChainComplex (ModuleCat.{0} «K») ℕ)) («D» : (letI : Field «K» := «field»; ChainComplex (ModuleCat.{0} «K») ℕ)) («E» : (letI : Field «K» := «field»; ChainComplex (ModuleCat.{0} «K») ℕ)) («F» : (letI : Field «K» := «field»; ChainComplex (ModuleCat.{0} «K») ℕ)) («source» : (letI : Field «K» := «field»; @Quiver.Hom (ChainComplex (ModuleCat.{0} «K») ℕ) inferInstance «C» «D»)) («target» : (letI : Field «K» := «field»; @Quiver.Hom (ChainComplex (ModuleCat.{0} «K») ℕ) inferInstance «E» «F»)) («left» : (letI : Field «K» := «field»; @Quiver.Hom (ChainComplex (ModuleCat.{0} «K») ℕ) inferInstance «C» «E»)) («right» : (letI : Field «K» := «field»; @Quiver.Hom (ChainComplex (ModuleCat.{0} «K») ℕ) inferInstance «D» «F»)) («commutes» : (((@cleanNotation_compose_chain_maps_7c3b42656ba4e987ff45 («K») («field») («C») («D») («F») («right») («source»)) = (@cleanNotation_compose_chain_maps_7c3b42656ba4e987ff45 («K») («field») («C») («E») («F») («target») («left»))))) : cleanStructure_ChainSquare_53c761a7ae734942d8e5 («K») («field») («C») («D») («E») («F») :=
  @cleanStructure_ChainSquare_53c761a7ae734942d8e5.mk «K» «field» «C» «D» «E» «F» «source» «target» «left» «right» «commutes»

noncomputable def cleanNotation_chain_cokernel_map_8758969d90d7c63ff714 {K : Type} (field : Field K) (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (E : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (F : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (f : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)) (g : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance E F)) (p : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C E)) (q : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance D F)) (h : (((@cleanNotation_compose_chain_maps_7c3b42656ba4e987ff45 (K) (field) (C) (D) (F) (q) (f)) = (@cleanNotation_compose_chain_maps_7c3b42656ba4e987ff45 (K) (field) (C) (E) (F) (g) (p))))) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance (@cleanNotation_chain_cokernel_4dbbbbfef07a623c6749 (K) (field) (C) (D) (f)) (@cleanNotation_chain_cokernel_4dbbbbfef07a623c6749 (K) (field) (E) (F) (g))) :=
  (letI : Field K := field; CategoryTheory.Limits.cokernel.map f g p q h)

noncomputable def cleanDefine_square_quotient_map_c90e823c9602c328729c {K : Type} (field : Field K) (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (E : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (F : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (S : cleanStructure_ChainSquare_53c761a7ae734942d8e5 (K) (field) (C) (D) (E) (F)) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance (@cleanNotation_chain_cokernel_4dbbbbfef07a623c6749 (K) (field) (C) (D) ((@cleanStructure_ChainSquare_53c761a7ae734942d8e5.«source» (K) (field) (C) (D) (E) (F) (S)))) (@cleanNotation_chain_cokernel_4dbbbbfef07a623c6749 (K) (field) (E) (F) ((@cleanStructure_ChainSquare_53c761a7ae734942d8e5.«target» (K) (field) (C) (D) (E) (F) (S))))) :=
  (@cleanNotation_chain_cokernel_map_8758969d90d7c63ff714 (K) (field) (C) (D) (E) (F) ((@cleanStructure_ChainSquare_53c761a7ae734942d8e5.«source» (K) (field) (C) (D) (E) (F) (S))) ((@cleanStructure_ChainSquare_53c761a7ae734942d8e5.«target» (K) (field) (C) (D) (E) (F) (S))) ((@cleanStructure_ChainSquare_53c761a7ae734942d8e5.«left» (K) (field) (C) (D) (E) (F) (S))) ((@cleanStructure_ChainSquare_53c761a7ae734942d8e5.«right» (K) (field) (C) (D) (E) (F) (S))) ((@cleanStructure_ChainSquare_53c761a7ae734942d8e5.«commutes» (K) (field) (C) (D) (E) (F) (S))))

noncomputable def cleanDefine_square_homology_map_69905bc5717b990977f9 {K : Type} (field : Field K) (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (E : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (F : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (S : cleanStructure_ChainSquare_53c761a7ae734942d8e5 (K) (field) (C) (D) (E) (F)) (n : ℕ) : (@ModuleCat.Hom K field.toRing (@cleanNotation_chain_homology_08373901ee9ce5bedd90 (K) (field) ((@cleanNotation_chain_cokernel_4dbbbbfef07a623c6749 (K) (field) (C) (D) ((@cleanStructure_ChainSquare_53c761a7ae734942d8e5.«source» (K) (field) (C) (D) (E) (F) (S))))) (n)) (@cleanNotation_chain_homology_08373901ee9ce5bedd90 (K) (field) ((@cleanNotation_chain_cokernel_4dbbbbfef07a623c6749 (K) (field) (E) (F) ((@cleanStructure_ChainSquare_53c761a7ae734942d8e5.«target» (K) (field) (C) (D) (E) (F) (S))))) (n))) :=
  (@cleanNotation_induced_chain_homology_map_62c79a897825782bdcd3 (K) (field) ((@cleanNotation_chain_cokernel_4dbbbbfef07a623c6749 (K) (field) (C) (D) ((@cleanStructure_ChainSquare_53c761a7ae734942d8e5.«source» (K) (field) (C) (D) (E) (F) (S))))) ((@cleanNotation_chain_cokernel_4dbbbbfef07a623c6749 (K) (field) (E) (F) ((@cleanStructure_ChainSquare_53c761a7ae734942d8e5.«target» (K) (field) (C) (D) (E) (F) (S))))) ((@cleanDefine_square_quotient_map_c90e823c9602c328729c (K) (field) (C) (D) (E) (F) (S))) (n))

noncomputable def cleanDefine_ambient_chain_map_e3fe61c1871b353b0930 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance (@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q)))))))) (@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) :=
  (@cleanNotation_induced_chain_map_94f837d94faca5d01c50 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))) ((@cleanDefine_ambient_continuous_map_8847accc2cf96844c6cb (X) (Q))))

noncomputable def cleanDefine_relative_subset_chain_map_e28b1c3df003a5e04cf4 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance (@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q)))))))) (@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) :=
  (@cleanNotation_induced_chain_map_94f837d94faca5d01c50 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))) ((@cleanDefine_relative_continuous_map_9ee2cb50fac73bd8824e (X) (Q))))

noncomputable def cleanDefine_square_represents_pair_inclusion_9016c4254462c71b7583 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) (S : cleanStructure_ChainSquare_53c761a7ae734942d8e5 (K) (field) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)))))))))) : Prop :=
  (((((@cleanStructure_ChainSquare_53c761a7ae734942d8e5.«source» (K) (field) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) (S)) = (@cleanDefine_pair_chain_inclusion_e21b8d5fe8d5aa16e6d3 (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ∧ ((@cleanStructure_ChainSquare_53c761a7ae734942d8e5.«target» (K) (field) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) (S)) = (@cleanDefine_pair_chain_inclusion_e21b8d5fe8d5aa16e6d3 (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)))))) ∧ ((@cleanStructure_ChainSquare_53c761a7ae734942d8e5.«left» (K) (field) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) (S)) = (@cleanDefine_relative_subset_chain_map_e28b1c3df003a5e04cf4 (K) (field) (H) (X) (Q)))) ∧ ((@cleanStructure_ChainSquare_53c761a7ae734942d8e5.«right» (K) (field) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) (S)) = (@cleanDefine_ambient_chain_map_e3fe61c1871b353b0930 (K) (field) (H) (X) (Q))))

noncomputable def cleanDefine_relative_chain_projection_0e7efef1eb6d7a6a0856 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance (@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) (Q)))))) (@cleanDefine_relative_chains_4678c66539e1e43260fb (K) (field) (H) (X) (Q))) :=
  (@cleanNotation_chain_cokernel_projection_0fc4366fc1387c70adfa (K) (field) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) (Q))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) (Q))))))) ((@cleanDefine_pair_chain_inclusion_e21b8d5fe8d5aa16e6d3 (K) (field) (H) (X) (Q))))

noncomputable def cleanDefine_pair_chain_commutes_1d0e90cb924255a39f03 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) : Prop :=
  ((@cleanNotation_compose_chain_maps_7c3b42656ba4e987ff45 (K) (field) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) ((@cleanDefine_ambient_chain_map_e3fe61c1871b353b0930 (K) (field) (H) (X) (Q))) ((@cleanDefine_pair_chain_inclusion_e21b8d5fe8d5aa16e6d3 (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q)))))) = (@cleanNotation_compose_chain_maps_7c3b42656ba4e987ff45 (K) (field) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) ((@cleanDefine_pair_chain_inclusion_e21b8d5fe8d5aa16e6d3 (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) ((@cleanDefine_relative_subset_chain_map_e28b1c3df003a5e04cf4 (K) (field) (H) (X) (Q)))))

noncomputable def cleanDefine_relative_chain_map_0f478e82a211b5328539 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) (h : ((@cleanDefine_pair_chain_commutes_1d0e90cb924255a39f03 (K) (field) (H) (X) (Q)))) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance (@cleanDefine_relative_chains_4678c66539e1e43260fb (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q)))) (@cleanDefine_relative_chains_4678c66539e1e43260fb (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) :=
  (@cleanNotation_chain_cokernel_map_8758969d90d7c63ff714 (K) (field) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))))))) ((@cleanDefine_pair_chain_inclusion_e21b8d5fe8d5aa16e6d3 (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ((@cleanDefine_pair_chain_inclusion_e21b8d5fe8d5aa16e6d3 (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) ((@cleanDefine_relative_subset_chain_map_e28b1c3df003a5e04cf4 (K) (field) (H) (X) (Q))) ((@cleanDefine_ambient_chain_map_e3fe61c1871b353b0930 (K) (field) (H) (X) (Q))) (h))

noncomputable def cleanDefine_relative_homology_map_42fade1c132888074790 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) (h : ((@cleanDefine_pair_chain_commutes_1d0e90cb924255a39f03 (K) (field) (H) (X) (Q)))) : (@ModuleCat.Hom K field.toRing (@cleanDefine_relative_homology_4cec0e496ce985bfa88a (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q)))) (@cleanDefine_relative_homology_4cec0e496ce985bfa88a (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) :=
  (@cleanNotation_induced_chain_homology_map_62c79a897825782bdcd3 (K) (field) ((@cleanDefine_relative_chains_4678c66539e1e43260fb (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ((@cleanDefine_relative_chains_4678c66539e1e43260fb (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) ((@cleanDefine_relative_chain_map_0f478e82a211b5328539 (K) (field) (H) (X) (Q) (h))) ((@cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b.«degree» (K) (field) (H))))

noncomputable def cleanDefine_relative_homology_image_47cb815d3925fd050595 {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) (h : ((@cleanDefine_pair_chain_commutes_1d0e90cb924255a39f03 (K) (field) (H) (X) (Q)))) : (@Submodule K (@cleanDefine_relative_homology_4cec0e496ce985bfa88a (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)))).carrier field.toSemiring (@cleanDefine_relative_homology_4cec0e496ce985bfa88a (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)))).isAddCommGroup.toAddCommMonoid (@cleanDefine_relative_homology_4cec0e496ce985bfa88a (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)))).isModule) :=
  (@cleanNotation_module_map_range_3ddb83929271b74045bc (K) (field) ((@cleanDefine_relative_homology_4cec0e496ce985bfa88a (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ((@cleanDefine_relative_homology_4cec0e496ce985bfa88a (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) ((@cleanDefine_relative_homology_map_42fade1c132888074790 (K) (field) (H) (X) (Q) (h))))

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

noncomputable def cleanNotation_identity_chain_map_64380a5161a688db35af {K : Type} (field : Field K) (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C C) :=
  (letI : Field K := field; CategoryTheory.CategoryStruct.id C)

noncomputable def cleanDefine_graded_chain_homology_efdd726d39e978291242  (K : Type) (field : Field K) (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) : cleanStructure_GradedModule_db830affbb1da28ca3aa (K) (field) :=
  (@cleanConstructor_graded_module_50ded2c434f81d68c40c (K) (field) ((fun (clean_bound_0 : ℕ) => (@cleanNotation_chain_homology_08373901ee9ce5bedd90 (K) (field) (C) (clean_bound_0)))))

noncomputable def cleanDefine_graded_chain_homology_map_a9643f6e7031a77aae5f  (K : Type) (field : Field K) (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (f : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)) : cleanStructure_GradedMap_7d0b6981486ea03cb162 (K) (field) ((@cleanDefine_graded_chain_homology_efdd726d39e978291242 (K) (field) (C))) ((@cleanDefine_graded_chain_homology_efdd726d39e978291242 (K) (field) (D))) :=
  (@cleanConstructor_graded_map_515c03a014bbe0523c07 (K) (field) ((@cleanDefine_graded_chain_homology_efdd726d39e978291242 (K) (field) (C))) ((@cleanDefine_graded_chain_homology_efdd726d39e978291242 (K) (field) (D))) ((fun (clean_bound_0 : ℕ) => (@cleanNotation_induced_chain_homology_map_62c79a897825782bdcd3 (K) (field) (C) (D) (f) (clean_bound_0)))))

noncomputable def cleanDefine_graded_relative_homology_6935b88aa4ea7867a873  (K : Type) (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (P : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) : cleanStructure_GradedModule_db830affbb1da28ca3aa (K) (field) :=
  (@cleanDefine_graded_chain_homology_efdd726d39e978291242 (K) (field) ((@cleanDefine_relative_chains_4678c66539e1e43260fb (K) (field) (H) (X) (P))))

noncomputable def cleanDefine_graded_relative_homology_map_f43b4c2a202c65249abc  (K : Type) (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)) (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) (h : ((@cleanDefine_pair_chain_commutes_1d0e90cb924255a39f03 (K) (field) (H) (X) (Q)))) : cleanStructure_GradedMap_7d0b6981486ea03cb162 (K) (field) ((@cleanDefine_graded_relative_homology_6935b88aa4ea7867a873 (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ((@cleanDefine_graded_relative_homology_6935b88aa4ea7867a873 (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) :=
  (@cleanDefine_graded_chain_homology_map_a9643f6e7031a77aae5f (K) (field) ((@cleanDefine_relative_chains_4678c66539e1e43260fb (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ((@cleanDefine_relative_chains_4678c66539e1e43260fb (K) (field) (H) (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) ((@cleanDefine_relative_chain_map_0f478e82a211b5328539 (K) (field) (H) (X) (Q) (h))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: topology
reference: graded map right identity across local scopes
relationship: original
-/
def saved_graded_map : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)),
  let M : cleanStructure_GradedModule_db830affbb1da28ca3aa (K) (field) := (@cleanDefine_graded_chain_homology_efdd726d39e978291242 (K) (field) (C));
  ∀ (f : cleanStructure_GradedMap_7d0b6981486ea03cb162 (K) (field) (M) (M)),
  ∀ (clean_bound_0 clean_comparison_identity_0 : ℕ),
  let N : cleanStructure_GradedModule_db830affbb1da28ca3aa (K) (field) := (@cleanDefine_graded_chain_homology_efdd726d39e978291242 (K) (field) (C));
  let g : cleanStructure_GradedMap_7d0b6981486ea03cb162 (K) (field) (N) (N) := (@cleanDefine_graded_composition_6e387c2cd5de8784f643 (K) (field) (N) (N) (N) (f) ((@cleanDefine_graded_identity_c616d4bdb0b54c49a1e2 (K) (field) (N))));
  (g = f)

/--
source: topology
reference: relative graded map right identity across local scopes
relationship: original
-/
def saved_relative_graded_map : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)),
  ∀ (X : TopCat.{0}),
  ∀ (P : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)),
  let M : cleanStructure_GradedModule_db830affbb1da28ca3aa (K) (field) := (@cleanDefine_graded_relative_homology_6935b88aa4ea7867a873 (K) (field) (H) (X) (P));
  ∀ (f : cleanStructure_GradedMap_7d0b6981486ea03cb162 (K) (field) (M) (M)),
  ∀ (clean_bound_0 clean_pi_bound_0 clean_comparison_identity_0 : ℕ),
  let N : cleanStructure_GradedModule_db830affbb1da28ca3aa (K) (field) := (@cleanDefine_graded_relative_homology_6935b88aa4ea7867a873 (K) (field) (H) (X) (P));
  let g : cleanStructure_GradedMap_7d0b6981486ea03cb162 (K) (field) (N) (N) := (@cleanDefine_graded_composition_6e387c2cd5de8784f643 (K) (field) (N) (N) (N) (f) ((@cleanDefine_graded_identity_c616d4bdb0b54c49a1e2 (K) (field) (N))));
  (g = f)

end CleanStatements

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
