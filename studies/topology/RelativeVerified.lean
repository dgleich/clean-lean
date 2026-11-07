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


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/-!
```latex
Relative chains are defined as the cokernel of the singular-chain map induced
by the inclusion of the relative subset into the ambient subset.
Relative homology is the homology of this complex in the selected degree.
These constructions do not yet supply the relative maps, connecting morphisms,
excision, or the well-group theorem.
```
-/

/--
source: topology
reference: CategoryTheory.Limits.cokernel.condition
relationship: adapted
-/
def chain_cokernel_kills_its_defining_map : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (C D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)),
  ∀ (f : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)),
  ((@cleanNotation_compose_chain_maps_7c3b42656ba4e987ff45 (K) (field) (C) (D) ((@cleanNotation_chain_cokernel_4dbbbbfef07a623c6749 (K) (field) (C) (D) (f))) ((@cleanNotation_chain_cokernel_projection_0fc4366fc1387c70adfa (K) (field) (C) (D) (f))) (f)) = (@cleanNotation_zero_chain_map_aedd3eb32a6dc949f8cd (K) (field) (C) ((@cleanNotation_chain_cokernel_4dbbbbfef07a623c6749 (K) (field) (C) (D) (f)))))

/--
source: topology
reference: AlgebraicTopology.singularHomologyFunctor
relationship: direct
-/
def singular_chain_homology_agrees : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)),
  ∀ (X : TopCat.{0}),
  ((@cleanNotation_chain_homology_08373901ee9ce5bedd90 (K) (field) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) (X))) ((@cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b.«degree» (K) (field) (H)))) = (@cleanNotation_homology_module_637b1330364c9c74b547 (K) (field) (H) (X)))

/--
source: topology
reference: relative singular chain definition
relationship: original
-/
def relative_chains_are_the_inclusion_cokernel : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)),
  ∀ (X : TopCat.{0}),
  ∀ (Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)),
  ((@cleanDefine_relative_chains_4678c66539e1e43260fb (K) (field) (H) (X) (Q)) = (@cleanNotation_chain_cokernel_4dbbbbfef07a623c6749 (K) (field) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) (Q))))))) ((@cleanNotation_singular_chains_5896876ad7f8802529c6 (K) (field) (H) ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) (Q))))))) ((@cleanDefine_pair_chain_inclusion_e21b8d5fe8d5aa16e6d3 (K) (field) (H) (X) (Q)))))

/--
source: topology
reference: relative singular homology definition
relationship: original
-/
def relative_homology_uses_the_selected_degree : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b (K) (field)),
  ∀ (X : TopCat.{0}),
  ∀ (Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)),
  ((@cleanDefine_relative_homology_4cec0e496ce985bfa88a (K) (field) (H) (X) (Q)) = (@cleanNotation_chain_homology_08373901ee9ce5bedd90 (K) (field) ((@cleanDefine_relative_chains_4678c66539e1e43260fb (K) (field) (H) (X) (Q))) ((@cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b.«degree» (K) (field) (H)))))

end CleanStatements

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `RelativeOracle.Complex then return `cleanType_ModuleChainComplex_b70ee3e20da4c1ab8305
  if n == `RelativeOracle.Map then return `cleanType_ChainMap_c3041b721346072705c8
  if n == `RelativeOracle.cokernel then return `cleanNotation_chain_cokernel_4dbbbbfef07a623c6749
  if n == `RelativeOracle.projection then return `cleanNotation_chain_cokernel_projection_0fc4366fc1387c70adfa
  if n == `RelativeOracle.compose then return `cleanNotation_compose_chain_maps_7c3b42656ba4e987ff45
  if n == `RelativeOracle.zeroMap then return `cleanNotation_zero_chain_map_aedd3eb32a6dc949f8cd
  if n == `RelativeOracle.homology then return `cleanNotation_chain_homology_08373901ee9ce5bedd90
  if n == `RelativeOracle.singular then return `cleanNotation_singular_chains_5896876ad7f8802529c6
  if n == `RelativeOracle.induced then return `cleanNotation_induced_chain_map_94f837d94faca5d01c50
  if n == `RelativeOracle.inclusion then return `cleanDefine_pair_chain_inclusion_e21b8d5fe8d5aa16e6d3
  if n == `RelativeOracle.relativeChains then return `cleanDefine_relative_chains_4678c66539e1e43260fb
  if n == `RelativeOracle.relativeHomology then return `cleanDefine_relative_homology_4cec0e496ce985bfa88a
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

namespace RelativeOracle
noncomputable def Complex (K : Type) (field : Field K) : Type 1 :=
  letI : Field K := field
  ChainComplex (ModuleCat.{0} K) ℕ
noncomputable def Map (K : Type) (field : Field K)
  (C D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) : Type :=
  letI : Field K := field
  @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D
noncomputable def cokernel {K : Type} (field : Field K) (C D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ))
  (f : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)) : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ) :=
  letI : Field K := field
  CategoryTheory.Limits.cokernel f
noncomputable def projection {K : Type} (field : Field K) (C D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ))
  (f : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance D (@cokernel K field C D f)) :=
  letI : Field K := field
  CategoryTheory.Limits.cokernel.π f
noncomputable def compose {K : Type} (field : Field K) (C D E : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ))
  (g : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance D E)) (f : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C E) :=
  letI : Field K := field
  CategoryTheory.CategoryStruct.comp f g
noncomputable def zeroMap {K : Type} (field : Field K) (C D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D) :=
  letI : Field K := field
  0
noncomputable def homology {K : Type} (field : Field K) (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (n : ℕ) : (@ModuleCat.{0,0} K field.toRing) :=
  letI : Field K := field
  (HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) n).obj C
noncomputable def singular {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b K field) (X : TopCat.{0}) : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ) :=
  letI : Field K := field
  ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{0} K)).obj H.coefficients).obj X
noncomputable def induced {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b K field) (X Y : TopCat.{0})
  (f : @ContinuousMap X.carrier Y.carrier X.str Y.str) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance (@singular K field H X) (@singular K field H Y)) :=
  letI : Field K := field
  ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{0} K)).obj H.coefficients).map (TopCat.ofHom f)
noncomputable def inclusion {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b K field) (X : TopCat.{0})
  (Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X) : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance (@singular K field H (@cleanNotation_subspace_4d29dc4d5e65a0cd314c X Q.relative)) (@singular K field H (@cleanNotation_subspace_4d29dc4d5e65a0cd314c X Q.ambient))) :=
  @induced K field H (@cleanNotation_subspace_4d29dc4d5e65a0cd314c X Q.relative) (@cleanNotation_subspace_4d29dc4d5e65a0cd314c X Q.ambient)
    (@cleanNotation_subspace_inclusion_ec403bdf245f64be6ba9 X Q.relative Q.ambient Q.nesting)
noncomputable def relativeChains {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b K field) (X : TopCat.{0})
  (Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X) : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ) :=
  @cokernel K field (@singular K field H (@cleanNotation_subspace_4d29dc4d5e65a0cd314c X Q.relative))
    (@singular K field H (@cleanNotation_subspace_4d29dc4d5e65a0cd314c X Q.ambient)) (@inclusion K field H X Q)
noncomputable def relativeHomology {K : Type} (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b K field) (X : TopCat.{0})
  (Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X) : (@ModuleCat.{0,0} K field.toRing) := @homology K field (@relativeChains K field H X Q) H.degree

def quotientStatement : Prop := ∀ (K : Type) (field : Field K) (C D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) (f : (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)),
  @compose K field C D (@cokernel K field C D f) (@projection K field C D f) f =
    @zeroMap K field C (@cokernel K field C D f)
def agreementStatement : Prop := ∀ (K : Type) (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b K field) (X : TopCat.{0}),
  @homology K field (@singular K field H X) H.degree = @cleanNotation_homology_module_637b1330364c9c74b547 K field H X
def relativeChainStatement : Prop := ∀ (K : Type) (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b K field) (X : TopCat.{0}) (Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X),
  @relativeChains K field H X Q = @cokernel K field (@singular K field H (@cleanNotation_subspace_4d29dc4d5e65a0cd314c X Q.relative))
    (@singular K field H (@cleanNotation_subspace_4d29dc4d5e65a0cd314c X Q.ambient)) (@inclusion K field H X Q)
def relativeHomologyStatement : Prop := ∀ (K : Type) (field : Field K) (H : cleanStructure_HomologyTheory_1b7d0a2aa40eb3e6062b K field) (X : TopCat.{0}) (Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X),
  @relativeHomology K field H X Q = @homology K field (@relativeChains K field H X Q) H.degree
end RelativeOracle
same_target cleanType_ModuleChainComplex_b70ee3e20da4c1ab8305 RelativeOracle.Complex
same_target cleanType_ChainMap_c3041b721346072705c8 RelativeOracle.Map
same_target cleanNotation_chain_cokernel_4dbbbbfef07a623c6749 RelativeOracle.cokernel
same_target cleanNotation_chain_cokernel_projection_0fc4366fc1387c70adfa RelativeOracle.projection
same_target cleanNotation_compose_chain_maps_7c3b42656ba4e987ff45 RelativeOracle.compose
same_target cleanNotation_zero_chain_map_aedd3eb32a6dc949f8cd RelativeOracle.zeroMap
same_target cleanNotation_chain_homology_08373901ee9ce5bedd90 RelativeOracle.homology
same_target cleanNotation_singular_chains_5896876ad7f8802529c6 RelativeOracle.singular
same_target cleanNotation_induced_chain_map_94f837d94faca5d01c50 RelativeOracle.induced
same_target cleanDefine_pair_chain_inclusion_e21b8d5fe8d5aa16e6d3 RelativeOracle.inclusion
same_target cleanDefine_relative_chains_4678c66539e1e43260fb RelativeOracle.relativeChains
same_target cleanDefine_relative_homology_4cec0e496ce985bfa88a RelativeOracle.relativeHomology
same_target CleanStatements.chain_cokernel_kills_its_defining_map RelativeOracle.quotientStatement
same_target CleanStatements.singular_chain_homology_agrees RelativeOracle.agreementStatement
same_target CleanStatements.relative_chains_are_the_inclusion_cokernel RelativeOracle.relativeChainStatement
same_target CleanStatements.relative_homology_uses_the_selected_degree RelativeOracle.relativeHomologyStatement

namespace RelativeProofs
theorem chain_cokernel_kills_its_defining_map : CleanStatements.chain_cokernel_kills_its_defining_map := by
  intro K field C D f
  letI : Field K := field
  exact CategoryTheory.Limits.cokernel.condition f
theorem singular_chain_homology_agrees : CleanStatements.singular_chain_homology_agrees := by
  intro K field H X
  rfl
theorem relative_chains_are_the_inclusion_cokernel : CleanStatements.relative_chains_are_the_inclusion_cokernel := by
  intro K field H X Q
  rfl
theorem relative_homology_uses_the_selected_degree : CleanStatements.relative_homology_uses_the_selected_degree := by
  intro K field H X Q
  rfl
end RelativeProofs

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
