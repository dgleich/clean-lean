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

noncomputable abbrev cleanType_CoefficientModule_79514ce65e42b4219878 (K : Type) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) : Type 1 :=
  (@ModuleCat.{0,0} K field.toRing)

noncomputable abbrev cleanType_ModuleElement_0c3dbc92ed35f00927af (K : Type) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : Type :=
  (@ModuleCat.carrier K field.toRing M)

noncomputable def cleanNotation_coefficient_module_573cf10e404b9587b3bb  (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (V : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (L : _root_.cleanStructure_LinearSpace_f45f02f1386f986b860e (K) (field) (V)) : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field)) :=
  @ModuleCat.of K field.toRing V L.addition L.action

noncomputable abbrev cleanType_ModuleMap_9bf239ee5af2145b9b57 (K : Type) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : Type :=
  (@ModuleCat.Hom K field.toRing M N)

noncomputable abbrev cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K : Type) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) : Type :=
  (@Submodule K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule)

noncomputable def cleanNotation_module_map_value_d59145d0b679c3ce3011 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (f : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (N))) (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (M))) : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (N)) :=
  (@ModuleCat.Hom.hom K field.toRing M N f) x

noncomputable def cleanNotation_module_map_range_7b55a8a231e2462f9d90 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (N : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (f : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) (M) (N))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (N)) :=
  LinearMap.range (@ModuleCat.Hom.hom K field.toRing M N f)

noncomputable def cleanNotation_module_subspace_carrier_0c98b2b061cbada2721f {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (U : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M))) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (M)))) :=
  U.carrier

noncomputable def cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (M))) (U : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (x ∈ (@_root_.cleanNotation_module_subspace_carrier_0c98b2b061cbada2721f (K) (field) (M) (U)))

structure cleanStructure_HomologyTheory_f4058490561c3b80c6d9 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) : Type 1 where
  «coefficients» : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 («K») («field»))
  «degree» : (_root_.cleanType_Natural_469c53b6dafb7a218246)

noncomputable def cleanConstructor_homology_theory_1d5d27e4480944537ec9 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («coefficients» : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 («K») («field»))) («degree» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 («K») («field») :=
  @_root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9.mk «K» «field» «coefficients» «degree»

noncomputable def cleanNotation_homology_module_0623b9da21d8ff427c7d {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field)) :=
  (letI : Field K := field; ((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).obj X)

noncomputable def cleanNotation_homology_linear_map_870f7f10a6e47fa2be41 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (g : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y)))) :=
  (letI : Field K := field; ((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).map (TopCat.ofHom g))

noncomputable def cleanDefine_induced_homology_value_7aaece293e09f77385ba {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (g : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))))) : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y)))) :=
  (@_root_.cleanNotation_module_map_value_d59145d0b679c3ce3011 (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y))) ((@_root_.cleanNotation_homology_linear_map_870f7f10a6e47fa2be41 (K) (field) (H) (X) (Y) (g))) (x))

noncomputable def cleanDefine_induced_homology_map_6a00940d673663e6165b {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (g : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) : ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))))) → ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y))))) :=
  (fun (clean_bound_0 : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))))) => (@_root_.cleanDefine_induced_homology_value_7aaece293e09f77385ba (K) (field) (H) (X) (Y) (g) (clean_bound_0)))

noncomputable def cleanDefine_homology_image_e6a3638ecb5732b0e74f {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (g : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y)))) :=
  (@_root_.cleanNotation_module_map_range_7b55a8a231e2462f9d90 (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y))) ((@_root_.cleanNotation_homology_linear_map_870f7f10a6e47fa2be41 (K) (field) (H) (X) (Y) (g))))

structure cleanStructure_ClassInSpace_61dc4f62a877eee5d096 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («H» : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 («K») («field»)) : Type 1 where
  «space» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)
  «element» : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af («K») («field») ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d («K») («field») («H») («space»))))

noncomputable def cleanConstructor_class_in_space_cbaf989b8bf9f18ad65f («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («H» : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 («K») («field»)) («space» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («element» : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af («K») («field») ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d («K») («field») («H») («space»))))) : _root_.cleanStructure_ClassInSpace_61dc4f62a877eee5d096 («K») («field») («H») :=
  @_root_.cleanStructure_ClassInSpace_61dc4f62a877eee5d096.mk «K» «field» «H» «space» «element»


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
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))))),
  ((@_root_.cleanDefine_induced_homology_value_7aaece293e09f77385ba (K) (field) (H) (X) (X) ((@_root_.cleanNotation_identity_continuous_map_3328841a46298311ee43 (X))) (x)) = x)

/--
source: mathlib
reference: CategoryTheory.Functor.map_comp
relationship: adapted
-/
def homology_respects_composition : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (X Y Z : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (f : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))),
  ∀ (g : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (Y) (Z))),
  ∀ (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))))),
  ((@_root_.cleanDefine_induced_homology_value_7aaece293e09f77385ba (K) (field) (H) (X) (Z) ((@_root_.cleanNotation_compose_continuous_maps_f3da5f5645c1a654d6b9 (X) (Y) (Z) (g) (f))) (x)) = (@_root_.cleanDefine_induced_homology_value_7aaece293e09f77385ba (K) (field) (H) (Y) (Z) (g) ((@_root_.cleanDefine_induced_homology_value_7aaece293e09f77385ba (K) (field) (H) (X) (Y) (f) (x)))))

/--
source: topology
reference: induced homology map definition
relationship: original
-/
def induced_function_acts_on_classes : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (X Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (f : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))),
  ∀ (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))))),
  let h : ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))))) → ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y))))) := (@_root_.cleanDefine_induced_homology_map_6a00940d673663e6165b (K) (field) (H) (X) (Y) (f));
  ((h x) = (@_root_.cleanDefine_induced_homology_value_7aaece293e09f77385ba (K) (field) (H) (X) (Y) (f) (x)))

/--
source: mathlib
reference: LinearMap.mem_range
relationship: adapted
-/
def homology_image_membership : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (X Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (f : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))),
  ∀ (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y))))),
  let h : ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))))) → ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y))))) := (@_root_.cleanDefine_induced_homology_map_6a00940d673663e6165b (K) (field) (H) (X) (Y) (f));
  let U : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y)))) := (@_root_.cleanDefine_homology_image_e6a3638ecb5732b0e74f (K) (field) (H) (X) (Y) (f));
  ((@_root_.cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (Y))) (x) (U)) ↔ (@Exists ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))))) (fun (clean_bound_0 : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) (X))))) => ((h clean_bound_0) = x))))

/--
source: topology
reference: computed dependent record field
relationship: original
-/
def bundled_class_has_its_declared_space : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (P : _root_.cleanStructure_ClassInSpace_61dc4f62a877eee5d096 (K) (field) (H)),
  (@Exists ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) ((@_root_.cleanStructure_ClassInSpace_61dc4f62a877eee5d096.«space» (K) (field) (H) (P))))))) (fun (clean_bound_0 : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanNotation_homology_module_0623b9da21d8ff427c7d (K) (field) (H) ((@_root_.cleanStructure_ClassInSpace_61dc4f62a877eee5d096.«space» (K) (field) (H) (P))))))) => (clean_bound_0 = (@_root_.cleanStructure_ClassInSpace_61dc4f62a877eee5d096.«element» (K) (field) (H) (P)))))

end CleanStatements

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `HomologyOracle.Theory then return `cleanStructure_HomologyTheory_f4058490561c3b80c6d9
  if n == `HomologyOracle.ClassInSpace then return `cleanStructure_ClassInSpace_61dc4f62a877eee5d096
  if n == `HomologyOracle.carrierType then return `cleanType_Type_c1fed1af64ab6f12e0ed
  if n == `HomologyOracle.fieldType then return `cleanType_FieldStructure_473fae039b953a4e35cf
  if n == `HomologyOracle.naturalType then return `cleanType_Natural_469c53b6dafb7a218246
  if n == `HomologyOracle.spaceType then return `cleanType_TopologicalSpace_d66be29262ccb5d89e3b
  if n == `HomologyOracle.continuousType then return `cleanType_ContinuousMap_05cf8501fbb474169b7a
  if n == `HomologyOracle.conditionType then return `cleanType_Proposition_ae4a13d2f060407bce35
  if n == `HomologyOracle.setType then return `cleanType_Set_6e300741358eee425e81
  if n == `HomologyOracle.coefficientType then return `cleanType_CoefficientModule_79514ce65e42b4219878
  if n == `HomologyOracle.elementType then return `cleanType_ModuleElement_0c3dbc92ed35f00927af
  if n == `HomologyOracle.mapType then return `cleanType_ModuleMap_9bf239ee5af2145b9b57
  if n == `HomologyOracle.subspaceType then return `cleanType_ModuleSubspace_3c17b4583cdbf46f50ae
  if n == `HomologyOracle.bundle then return `cleanNotation_coefficient_module_573cf10e404b9587b3bb
  if n == `HomologyOracle.theory then return `cleanConstructor_homology_theory_1d5d27e4480944537ec9
  if n == `HomologyOracle.homology then return `cleanNotation_homology_module_0623b9da21d8ff427c7d
  if n == `HomologyOracle.value then return `cleanDefine_induced_homology_value_7aaece293e09f77385ba
  if n == `HomologyOracle.induced then return `cleanDefine_induced_homology_map_6a00940d673663e6165b
  if n == `HomologyOracle.classInSpace then return `cleanConstructor_class_in_space_cbaf989b8bf9f18ad65f
  if n == `HomologyOracle.mapValue then return `cleanNotation_module_map_value_d59145d0b679c3ce3011
  if n == `HomologyOracle.mapRange then return `cleanNotation_module_map_range_7b55a8a231e2462f9d90
  if n == `HomologyOracle.carrier then return `cleanNotation_module_subspace_carrier_0c98b2b061cbada2721f
  if n == `HomologyOracle.belongs then return `cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad
  if n == `HomologyOracle.linear then return `cleanNotation_homology_linear_map_870f7f10a6e47fa2be41
  if n == `HomologyOracle.image then return `cleanDefine_homology_image_e6a3638ecb5732b0e74f
  if n == `HomologyOracle.identity then return `cleanNotation_identity_continuous_map_3328841a46298311ee43
  if n == `HomologyOracle.compose then return `cleanNotation_compose_continuous_maps_f3da5f5645c1a654d6b9
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

namespace HomologyOracle
noncomputable abbrev carrierType : Type 1 := Type
noncomputable abbrev fieldType (K : Type) : Type := Field K
noncomputable abbrev naturalType : Type := ℕ
noncomputable abbrev spaceType : Type 1 := TopCat.{0}
noncomputable abbrev continuousType (X Y : spaceType) : Type :=
  @ContinuousMap X.carrier Y.carrier X.str Y.str
noncomputable abbrev conditionType : Sort 1 := Prop
noncomputable abbrev setType (X : Type) : Type := Set X
noncomputable def coefficientType (K : Type) (field : fieldType K) : Type 1 := @ModuleCat.{0,0} K field.toRing
noncomputable def elementType (K : Type) (field : fieldType K) (M : coefficientType K field) : Type :=
  @ModuleCat.carrier K field.toRing M
noncomputable def bundle (K : carrierType) (field : fieldType K) (V : carrierType) (L : cleanStructure_LinearSpace_f45f02f1386f986b860e K field V) :
  coefficientType K field := @ModuleCat.of K field.toRing V L.addition L.action
structure Theory (K : Type) (field : fieldType K) : Type 1 where
  coefficients : coefficientType K field
  degree : naturalType
noncomputable def theory (K : Type) (field : fieldType K) (R : coefficientType K field) (n : naturalType) : Theory K field :=
  @Theory.mk K field R n
noncomputable def homology {K : Type} (field : fieldType K) (H : Theory K field) (X : spaceType) :
  coefficientType K field :=
  letI : Field K := field
  ((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).obj X
noncomputable def mapType (K : Type) (field : fieldType K)
  (M N : coefficientType K field) : Type := @ModuleCat.Hom K field.toRing M N
noncomputable def subspaceType (K : Type) (field : fieldType K) (M : coefficientType K field) : Type :=
  @Submodule K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule
noncomputable def mapValue {K : Type} (field : fieldType K) (M N : coefficientType K field)
  (f : mapType K field M N) (x : elementType K field M) :
  elementType K field N := (@ModuleCat.Hom.hom K field.toRing M N f) x
noncomputable def mapRange {K : Type} (field : fieldType K) (M N : coefficientType K field)
  (f : mapType K field M N) :
  subspaceType K field N :=
  LinearMap.range (@ModuleCat.Hom.hom K field.toRing M N f)
noncomputable def carrier {K : Type} (field : fieldType K) (M : coefficientType K field)
  (U : subspaceType K field M) :
  setType (elementType K field M) := U.carrier
noncomputable def belongs {K : Type} (field : fieldType K) (M : coefficientType K field)
  (x : elementType K field M)
  (U : subspaceType K field M) : conditionType :=
  x ∈ @carrier K field M U
noncomputable def linear {K : Type} (field : fieldType K) (H : Theory K field) (X Y : spaceType)
  (g : continuousType X Y) : mapType K field (@homology K field H X) (@homology K field H Y) :=
  letI : Field K := field
  ((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).map (TopCat.ofHom g)
noncomputable def value {K : Type} (field : fieldType K) (H : Theory K field) (X Y : spaceType)
  (g : continuousType X Y) (x : (elementType K field (@homology K field H X))) : (elementType K field (@homology K field H Y)) :=
  @mapValue K field (@homology K field H X) (@homology K field H Y) (@linear K field H X Y g) x
noncomputable def image {K : Type} (field : fieldType K) (H : Theory K field) (X Y : spaceType)
  (g : continuousType X Y) :
  subspaceType K field (@homology K field H Y) :=
  @mapRange K field (@homology K field H X) (@homology K field H Y) (@linear K field H X Y g)
noncomputable def induced {K : Type} (field : fieldType K) (H : Theory K field) (X Y : spaceType)
  (g : continuousType X Y) : (elementType K field (@homology K field H X)) → (elementType K field (@homology K field H Y)) :=
  fun (x : (elementType K field (@homology K field H X))) => @value K field H X Y g x
noncomputable def identity (X : spaceType) : continuousType X X :=
  @ContinuousMap.id X.carrier X.str
noncomputable def compose (X Y Z : spaceType)
  (g : continuousType Y Z)
  (f : continuousType X Y) :
  continuousType X Z :=
  @ContinuousMap.comp X.carrier Y.carrier Z.carrier X.str Y.str Z.str g f

structure ClassInSpace (K : Type) (field : fieldType K) (H : Theory K field) : Type 1 where
  space : spaceType
  element : elementType K field (@homology K field H space)
noncomputable def classInSpace (K : Type) (field : fieldType K) (H : Theory K field)
  (space : spaceType) (element : elementType K field (@homology K field H space)) :
  ClassInSpace K field H := @ClassInSpace.mk K field H space element

def identityStatement : Prop := ∀ (K : carrierType) (field : fieldType K) (H : Theory K field)
  (X : spaceType) (x : (elementType K field (@homology K field H X))), @value K field H X X (@identity X) x=x
def compositionStatement : Prop := ∀ (K : carrierType) (field : fieldType K) (H : Theory K field)
  (X Y Z : spaceType) (f : continuousType X Y)
  (g : continuousType Y Z) (x : (elementType K field (@homology K field H X))),
  @value K field H X Z (@compose X Y Z g f) x = @value K field H Y Z g (@value K field H X Y f x)
def applicationStatement : Prop := ∀ (K : carrierType) (field : fieldType K) (H : Theory K field)
  (X Y : spaceType) (f : continuousType X Y) (x : (elementType K field (@homology K field H X))),
  let h : (elementType K field (@homology K field H X)) → (elementType K field (@homology K field H Y)) := @induced K field H X Y f;
  h x = @value K field H X Y f x
def rangeStatement : Prop := ∀ (K : carrierType) (field : fieldType K) (H : Theory K field)
  (X Y : spaceType) (f : continuousType X Y) (x : (elementType K field (@homology K field H Y))),
  let h : (elementType K field (@homology K field H X)) → (elementType K field (@homology K field H Y)) := @induced K field H X Y f;
  let U : subspaceType K field (@homology K field H Y) := @image K field H X Y f;
  @belongs K field (@homology K field H Y) x U ↔ @Exists (elementType K field (@homology K field H X)) (fun y => h y = x)
def fieldStatement : Prop := ∀ (K : carrierType) (field : fieldType K) (H : Theory K field)
  (P : ClassInSpace K field H),
  @Exists (elementType K field (@homology K field H (@ClassInSpace.space K field H P)))
    (fun x => x = @ClassInSpace.element K field H P)
end HomologyOracle
same_target cleanStructure_HomologyTheory_f4058490561c3b80c6d9 HomologyOracle.Theory
same_target cleanStructure_ClassInSpace_61dc4f62a877eee5d096 HomologyOracle.ClassInSpace
same_target cleanType_Type_c1fed1af64ab6f12e0ed HomologyOracle.carrierType
same_target cleanType_FieldStructure_473fae039b953a4e35cf HomologyOracle.fieldType
same_target cleanType_Natural_469c53b6dafb7a218246 HomologyOracle.naturalType
same_target cleanType_TopologicalSpace_d66be29262ccb5d89e3b HomologyOracle.spaceType
same_target cleanType_ContinuousMap_05cf8501fbb474169b7a HomologyOracle.continuousType
same_target cleanType_Proposition_ae4a13d2f060407bce35 HomologyOracle.conditionType
same_target cleanType_Set_6e300741358eee425e81 HomologyOracle.setType
same_target cleanType_CoefficientModule_79514ce65e42b4219878 HomologyOracle.coefficientType
same_target cleanType_ModuleElement_0c3dbc92ed35f00927af HomologyOracle.elementType
same_target cleanType_ModuleMap_9bf239ee5af2145b9b57 HomologyOracle.mapType
same_target cleanType_ModuleSubspace_3c17b4583cdbf46f50ae HomologyOracle.subspaceType
same_target cleanNotation_coefficient_module_573cf10e404b9587b3bb HomologyOracle.bundle
same_target cleanConstructor_homology_theory_1d5d27e4480944537ec9 HomologyOracle.theory
same_target cleanNotation_homology_module_0623b9da21d8ff427c7d HomologyOracle.homology
same_target cleanDefine_induced_homology_value_7aaece293e09f77385ba HomologyOracle.value
same_target cleanDefine_induced_homology_map_6a00940d673663e6165b HomologyOracle.induced
same_target cleanConstructor_class_in_space_cbaf989b8bf9f18ad65f HomologyOracle.classInSpace
same_target cleanNotation_module_map_value_d59145d0b679c3ce3011 HomologyOracle.mapValue
same_target cleanNotation_module_map_range_7b55a8a231e2462f9d90 HomologyOracle.mapRange
same_target cleanNotation_module_subspace_carrier_0c98b2b061cbada2721f HomologyOracle.carrier
same_target cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad HomologyOracle.belongs
same_target cleanNotation_homology_linear_map_870f7f10a6e47fa2be41 HomologyOracle.linear
same_target cleanDefine_homology_image_e6a3638ecb5732b0e74f HomologyOracle.image
same_target cleanNotation_identity_continuous_map_3328841a46298311ee43 HomologyOracle.identity
same_target cleanNotation_compose_continuous_maps_f3da5f5645c1a654d6b9 HomologyOracle.compose
same_target cleanStructure_HomologyTheory_f4058490561c3b80c6d9.mk HomologyOracle.Theory.mk
same_target cleanStructure_HomologyTheory_f4058490561c3b80c6d9.coefficients HomologyOracle.Theory.coefficients
same_target cleanStructure_HomologyTheory_f4058490561c3b80c6d9.degree HomologyOracle.Theory.degree
same_target cleanStructure_ClassInSpace_61dc4f62a877eee5d096.mk HomologyOracle.ClassInSpace.mk
same_target cleanStructure_ClassInSpace_61dc4f62a877eee5d096.space HomologyOracle.ClassInSpace.space
same_target cleanStructure_ClassInSpace_61dc4f62a877eee5d096.element HomologyOracle.ClassInSpace.element
same_target CleanStatements.homology_identity_fixes_classes HomologyOracle.identityStatement
same_target CleanStatements.homology_respects_composition HomologyOracle.compositionStatement
same_target CleanStatements.induced_function_acts_on_classes HomologyOracle.applicationStatement
same_target CleanStatements.homology_image_membership HomologyOracle.rangeStatement
same_target CleanStatements.bundled_class_has_its_declared_space HomologyOracle.fieldStatement

open CategoryTheory
namespace HomologyProofs
theorem homology_identity_fixes_classes : CleanStatements.homology_identity_fixes_classes := by
  intro K field H X x
  letI : Field K := field
  change (((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).map (𝟙 X)).hom x = x
  rw [CategoryTheory.Functor.map_id]
  rfl

theorem homology_respects_composition : CleanStatements.homology_respects_composition := by
  intro K field H X Y Z f g x
  letI : Field K := field
  change (((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).map
    (TopCat.ofHom f ≫ TopCat.ofHom g)).hom x = _
  rw [CategoryTheory.Functor.map_comp]
  rfl

theorem induced_function_acts_on_classes : CleanStatements.induced_function_acts_on_classes := by
  intro K field H X Y f x
  rfl
theorem homology_image_membership : CleanStatements.homology_image_membership := by
  intro K field H X Y f x
  rfl
theorem bundled_class_has_its_declared_space : CleanStatements.bundled_class_has_its_declared_space := by
  intro K field H P
  exact ⟨P.element,rfl⟩
end HomologyProofs

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
