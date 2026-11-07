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
import Mathlib.Topology.Path

/-!
Basic topology with explicit carrier types and topologies.
   Mathematical preimages, images, composition, and continuity are authored here.
   This first module is restricted to carrier types in Lean Type 0.
-/

/-!
Evidence is an ordinary transparent alias. A parenthesized condition used
   as a type denotes proofs of that condition. This module supplies no proofs.
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

noncomputable abbrev cleanType_Element_4fb2f1b669ed36f80886 (X : Type) (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) : Type :=
  {x : X // x ∈ S}

noncomputable abbrev cleanType_Path_2e5bf3c806cfad5a1ae9 (X : Type) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) (y : X) : Type :=
  @Path X t x y

noncomputable def cleanNotation_underlying_point_5fc735e8b58c86463a25 {X : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (x : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (X) (S))) : X :=
  x.val

noncomputable def cleanNotation_constant_path_e6a080b4f4baea9e3c6a {X : Type} (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (x)) :=
  @Path.refl X t x

noncomputable def cleanNotation_reverse_path_bccacbe82db41fbe7c6d {X : Type} (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) (y : X) (p : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (y))) : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (y) (x)) :=
  @Path.symm X t x y p

noncomputable def cleanNotation_join_paths_413579dc3782617ff91d {X : Type} (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) (y : X) (z : X) (p : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (y))) (q : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (y) (z))) : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (z)) :=
  @Path.trans X t x y z p q

noncomputable def cleanDefine_reverse_twice_19c7d7336839bf577a5b {X : Type} (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) (y : X) (p : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (y))) : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (y)) :=
  (@_root_.cleanNotation_reverse_path_bccacbe82db41fbe7c6d (X) (t) (y) (x) ((@_root_.cleanNotation_reverse_path_bccacbe82db41fbe7c6d (X) (t) (x) (y) (p))))

structure cleanStructure_SubsetInclusion_dee5d235a852d3683ca6 («X» : Type) : Type where
  «source» : (_root_.cleanType_Set_6e300741358eee425e81 («X»))
  «target» : (_root_.cleanType_Set_6e300741358eee425e81 («X»))
  «containment» : ((«source» ⊆ «target»))

noncomputable def cleanConstructor_certified_inclusion_43c70040f5cf64a7c739 («X» : Type) («source» : (_root_.cleanType_Set_6e300741358eee425e81 («X»))) («target» : (_root_.cleanType_Set_6e300741358eee425e81 («X»))) («containment» : ((«source» ⊆ «target»))) : _root_.cleanStructure_SubsetInclusion_dee5d235a852d3683ca6 («X») :=
  @_root_.cleanStructure_SubsetInclusion_dee5d235a852d3683ca6.mk «X» «source» «target» «containment»

noncomputable def cleanNotation_subset_inclusion_map_55ca143b65caa5614928  (X : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (T : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (h : ((S ⊆ T))) : ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (X) (S))) → ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (X) (T))) :=
  Set.inclusion h

noncomputable def cleanDefine_certified_inclusion_map_8e0bdaf9d5f81a8da5ad  (X : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (Q : _root_.cleanStructure_SubsetInclusion_dee5d235a852d3683ca6 (X)) : ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (X) ((@_root_.cleanStructure_SubsetInclusion_dee5d235a852d3683ca6.«source» (X) (Q))))) → ((_root_.cleanType_Element_4fb2f1b669ed36f80886 (X) ((@_root_.cleanStructure_SubsetInclusion_dee5d235a852d3683ca6.«target» (X) (Q))))) :=
  (@_root_.cleanNotation_subset_inclusion_map_55ca143b65caa5614928 (X) ((@_root_.cleanStructure_SubsetInclusion_dee5d235a852d3683ca6.«source» (X) (Q))) ((@_root_.cleanStructure_SubsetInclusion_dee5d235a852d3683ca6.«target» (X) (Q))) ((@_root_.cleanStructure_SubsetInclusion_dee5d235a852d3683ca6.«containment» (X) (Q))))

noncomputable def cleanDefine_subset_certificate_e8cfe77b05f324f28162 {X : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (T : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (h : ((S ⊆ T))) : _root_.cleanStructure_SubsetInclusion_dee5d235a852d3683ca6 (X) :=
  (@_root_.cleanConstructor_certified_inclusion_43c70040f5cf64a7c739 (X) (S) (T) (h))

structure cleanStructure_TopologicalPair_f701031cf43f9f923573 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type where
  «ambient» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))
  «relative» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))
  «nesting» : ((«relative» ⊆ «ambient»))

noncomputable def cleanConstructor_topological_pair_4885b9c6167c75e582cb («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («ambient» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))) («relative» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))) («nesting» : ((«relative» ⊆ «ambient»))) : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 («X») :=
  @_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.mk «X» «ambient» «relative» «nesting»

structure cleanStructure_PairInclusion_2a6b123d94386bb22b2b («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type where
  «source» : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 («X»)
  «target» : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 («X»)
  «ambient» : (((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» («X») («source»)) ⊆ (@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» («X») («target»))))
  «relative» : (((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» («X») («source»)) ⊆ (@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» («X») («target»))))

noncomputable def cleanConstructor_pair_inclusion_d00d3a03332707a42c44 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («source» : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 («X»)) («target» : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 («X»)) («ambient» : (((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» («X») («source»)) ⊆ (@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» («X») («target»))))) («relative» : (((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» («X») («source»)) ⊆ (@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» («X») («target»))))) : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b («X») :=
  @_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.mk «X» «source» «target» «ambient» «relative»

noncomputable def cleanDefine_ambient_inclusion_5524c228887f4e0551ae  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)) : _root_.cleanStructure_SubsetInclusion_dee5d235a852d3683ca6 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) :=
  (@_root_.cleanDefine_subset_certificate_e8cfe77b05f324f28162 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«ambient» (X) (Q))))

noncomputable def cleanDefine_relative_inclusion_42e1f0d0c6d343689238  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)) : _root_.cleanStructure_SubsetInclusion_dee5d235a852d3683ca6 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) :=
  (@_root_.cleanDefine_subset_certificate_e8cfe77b05f324f28162 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«relative» (X) (Q))))

noncomputable def cleanNotation_subspace_c5a9f0dd775aa465e7fc  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (S : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))) : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b) :=
  (letI : TopologicalSpace X.carrier := X.str; TopCat.of S)

noncomputable def cleanNotation_subspace_inclusion_0024be0a72eb4292b055  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (S : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))) (T : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))) (h : ((S ⊆ T))) : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) (S))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) (T)))) :=
  (letI : TopologicalSpace X.carrier := X.str; ContinuousMap.inclusion h)

noncomputable def cleanDefine_ambient_continuous_map_9e18751f172667d7bde2  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)) : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)))))))) :=
  (@_root_.cleanNotation_subspace_inclusion_0024be0a72eb4292b055 (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«ambient» (X) (Q))))

noncomputable def cleanDefine_relative_continuous_map_3c81881ebcda9c1a81bc  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)) : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)))))))) :=
  (@_root_.cleanNotation_subspace_inclusion_0024be0a72eb4292b055 (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«relative» (X) (Q))))

noncomputable def cleanDefine_ambient_composite_08f3c93e58fe21bfaf93  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)) : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)))))))) :=
  (@_root_.cleanNotation_compose_continuous_maps_f3da5f5645c1a654d6b9 ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))) ((@_root_.cleanDefine_ambient_continuous_map_9e18751f172667d7bde2 (X) (Q))) ((@_root_.cleanNotation_subspace_inclusion_0024be0a72eb4292b055 (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«nesting» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))

noncomputable def cleanDefine_relative_composite_93e163bb814449733361  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)) : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)))))))) :=
  (@_root_.cleanNotation_compose_continuous_maps_f3da5f5645c1a654d6b9 ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))) ((@_root_.cleanNotation_subspace_inclusion_0024be0a72eb4292b055 (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«nesting» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))) ((@_root_.cleanDefine_relative_continuous_map_3c81881ebcda9c1a81bc (X) (Q))))

noncomputable def cleanNotation_equality_congruence_3e3f32efa32223213c0e {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) (y : X) (h : ((x = y))) : (((f x) = (f y))) :=
  congrArg f h

noncomputable def cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db {X : Type} (x : X) : ((x = x)) :=
  Eq.refl x

noncomputable def cleanNotation_subset_reflexivity_1568c5a94ff73fdf7628 {X : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) : ((S ⊆ S)) :=
  Set.Subset.refl S

noncomputable def cleanNotation_subset_transitivity_78b5104bebe704cfbd35 {X : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (T : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (U : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (h : ((S ⊆ T))) (k : ((T ⊆ U))) : ((S ⊆ U)) :=
  Set.Subset.trans h k

noncomputable def cleanNotation_replace_subset_target_5c4b0ef7e2b533db2bc1 {X : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (T : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (U : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (h : ((S ⊆ T))) (e : ((T = U))) : ((S ⊆ U)) :=
  @Eq.rec (Set X) T (fun V _ => S ⊆ V) h U e

noncomputable def cleanDefine_pair_ambient_equality_95151602164c8990ac0f  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (P : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) (Q : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) (h : ((P = Q))) : (((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) (P)) = (@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) (Q)))) :=
  (@_root_.cleanNotation_equality_congruence_3e3f32efa32223213c0e (_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) ((_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))) ((fun (clean_bound_0 : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) => (@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) (clean_bound_0)))) (P) (Q) (h))

noncomputable def cleanDefine_pair_relative_equality_88f8a842c2633c83eb92  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (P : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) (Q : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) (h : ((P = Q))) : (((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) (P)) = (@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) (Q)))) :=
  (@_root_.cleanNotation_equality_congruence_3e3f32efa32223213c0e (_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) ((_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))))) ((fun (clean_bound_0 : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) => (@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) (clean_bound_0)))) (P) (Q) (h))

noncomputable def cleanDefine_identity_pair_inclusion_d40752a532778f87478b  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (P : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X) :=
  (@_root_.cleanConstructor_pair_inclusion_d00d3a03332707a42c44 (X) (P) (P) ((@_root_.cleanNotation_subset_reflexivity_1568c5a94ff73fdf7628 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) (P))))) ((@_root_.cleanNotation_subset_reflexivity_1568c5a94ff73fdf7628 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) (P))))))

noncomputable def cleanDefine_compose_pair_inclusions_c4d803d6c358f3e572ee  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)) (R : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)) (middle : (((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)) = (@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (R))))) : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X) :=
  (@_root_.cleanConstructor_pair_inclusion_d00d3a03332707a42c44 (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (R))) ((@_root_.cleanNotation_subset_transitivity_78b5104bebe704cfbd35 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (R))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (R))))) ((@_root_.cleanNotation_replace_subset_target_5c4b0ef7e2b533db2bc1 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (R))))) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«ambient» (X) (Q))) ((@_root_.cleanDefine_pair_ambient_equality_95151602164c8990ac0f (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (R))) (middle))))) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«ambient» (X) (R))))) ((@_root_.cleanNotation_subset_transitivity_78b5104bebe704cfbd35 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (R))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (R))))) ((@_root_.cleanNotation_replace_subset_target_5c4b0ef7e2b533db2bc1 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (R))))) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«relative» (X) (Q))) ((@_root_.cleanDefine_pair_relative_equality_88f8a842c2633c83eb92 (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (R))) (middle))))) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«relative» (X) (R))))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: topology
reference: identity inclusion of pairs
relationship: original
-/
def identity_pair_endpoints : Prop :=
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (P : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)),
  ((P = P) ∧ (P = P))

/--
source: topology
reference: composition of inclusions of pairs
relationship: original
-/
def composed_pair_endpoints : Prop :=
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (Q R : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)),
  ∀ («middle» : ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)) = (@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (R)))),
  (((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q)) = (@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))) ∧ ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (R)) = (@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (R))))

/--
source: topology
reference: source identity law for inclusions
relationship: original
-/
def pair_source_identity : Prop :=
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)),
  ((@_root_.cleanDefine_compose_pair_inclusions_c4d803d6c358f3e572ee (X) ((@_root_.cleanDefine_identity_pair_inclusion_d40752a532778f87478b (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) (Q) ((@_root_.cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q)))))) = Q)

/--
source: topology
reference: target identity law for inclusions
relationship: original
-/
def pair_target_identity : Prop :=
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)),
  ((@_root_.cleanDefine_compose_pair_inclusions_c4d803d6c358f3e572ee (X) (Q) ((@_root_.cleanDefine_identity_pair_inclusion_d40752a532778f87478b (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)))))) = Q)

/--
source: topology
reference: associativity of inclusions
relationship: original
-/
def pair_composition_associativity : Prop :=
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (Q R S : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)),
  ∀ («first» : ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)) = (@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (R)))),
  ∀ («second» : ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (R)) = (@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (S)))),
  ((@_root_.cleanDefine_compose_pair_inclusions_c4d803d6c358f3e572ee (X) ((@_root_.cleanDefine_compose_pair_inclusions_c4d803d6c358f3e572ee (X) (Q) (R) («first»))) (S) («second»)) = (@_root_.cleanDefine_compose_pair_inclusions_c4d803d6c358f3e572ee (X) (Q) ((@_root_.cleanDefine_compose_pair_inclusions_c4d803d6c358f3e572ee (X) (R) (S) («second»))) («first»)))

/--
source: topology
reference: underlying maps of identity inclusions
relationship: original
-/
def identity_pair_continuous_maps : Prop :=
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (P : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)),
  (((@_root_.cleanDefine_ambient_continuous_map_9e18751f172667d7bde2 (X) ((@_root_.cleanDefine_identity_pair_inclusion_d40752a532778f87478b (X) (P)))) = (@_root_.cleanNotation_identity_continuous_map_3328841a46298311ee43 ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) (P))))))) ∧ ((@_root_.cleanDefine_relative_continuous_map_3c81881ebcda9c1a81bc (X) ((@_root_.cleanDefine_identity_pair_inclusion_d40752a532778f87478b (X) (P)))) = (@_root_.cleanNotation_identity_continuous_map_3328841a46298311ee43 ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) (P))))))))

end CleanStatements

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `PairCompositionOracle.setType then return `cleanType_Set_6e300741358eee425e81
  if n == `PairCompositionOracle.spaceType then return `cleanType_TopologicalSpace_d66be29262ccb5d89e3b
  if n == `PairCompositionOracle.pointType then return `cleanType_Point_f8a65e23875fb9a2c125
  if n == `PairCompositionOracle.congruence then return `cleanNotation_equality_congruence_3e3f32efa32223213c0e
  if n == `PairCompositionOracle.reflexivity then return `cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db
  if n == `PairCompositionOracle.subsetRefl then return `cleanNotation_subset_reflexivity_1568c5a94ff73fdf7628
  if n == `PairCompositionOracle.subsetTrans then return `cleanNotation_subset_transitivity_78b5104bebe704cfbd35
  if n == `PairCompositionOracle.replaceTarget then return `cleanNotation_replace_subset_target_5c4b0ef7e2b533db2bc1
  if n == `PairCompositionOracle.ambientEq then return `cleanDefine_pair_ambient_equality_95151602164c8990ac0f
  if n == `PairCompositionOracle.relativeEq then return `cleanDefine_pair_relative_equality_88f8a842c2633c83eb92
  if n == `PairCompositionOracle.identity then return `cleanDefine_identity_pair_inclusion_d40752a532778f87478b
  if n == `PairCompositionOracle.compose then return `cleanDefine_compose_pair_inclusions_c4d803d6c358f3e572ee
  if n == `PairCompositionOracle.sourceIdentity._proof_1 then return `CleanStatements.pair_source_identity._proof_1
  if n == `PairCompositionOracle.targetIdentity._proof_1 then return `CleanStatements.pair_target_identity._proof_1
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
  | .thmInfo x,.thmInfo y =>
    unless Expr.equal (canonical x.value) (canonical y.value) do
      throwError "Canonical proof projection differs"
  | .ctorInfo x,.ctorInfo y =>
    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&
        canonicalName x.induct == canonicalName y.induct do
      throwError "Constructor shape differs"
  | .inductInfo x,.inductInfo y =>
    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&
        x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do
      throwError "Structure shape differs"
  | _,_ => throwError "Unexpected declaration kinds"

namespace PairCompositionOracle
noncomputable abbrev setType (X : Type) : Type := Set X
noncomputable abbrev spaceType : Type 1 := TopCat.{0}
noncomputable abbrev pointType (X : spaceType) : Type := TopCat.carrier X
noncomputable def congruence {X Y : Type} (f : X → Y) (x y : X) (h : x=y) : f x=f y := congrArg f h
noncomputable def reflexivity {X : Type} (x : X) : x=x := Eq.refl x
noncomputable def subsetRefl {X : Type} (S : setType X) : S ⊆ S := Set.Subset.refl S
noncomputable def subsetTrans {X : Type} (S T U : setType X) (h : S ⊆ T) (k : T ⊆ U) : S ⊆ U := Set.Subset.trans h k
noncomputable def replaceTarget {X : Type} (S T U : setType X) (h : S ⊆ T) (e : T=U) : S ⊆ U :=
  @Eq.rec (Set X) T (fun V _ => S ⊆ V) h U e
noncomputable def ambientEq (X : spaceType) (P Q : cleanStructure_TopologicalPair_f701031cf43f9f923573 X) (h : P=Q) : P.ambient=Q.ambient :=
  @congruence (cleanStructure_TopologicalPair_f701031cf43f9f923573 X) (setType (pointType X)) (fun T : cleanStructure_TopologicalPair_f701031cf43f9f923573 X => T.ambient) P Q h
noncomputable def relativeEq (X : spaceType) (P Q : cleanStructure_TopologicalPair_f701031cf43f9f923573 X) (h : P=Q) : P.relative=Q.relative :=
  @congruence (cleanStructure_TopologicalPair_f701031cf43f9f923573 X) (setType (pointType X)) (fun T : cleanStructure_TopologicalPair_f701031cf43f9f923573 X => T.relative) P Q h
noncomputable def identity (X : spaceType) (P : cleanStructure_TopologicalPair_f701031cf43f9f923573 X) : cleanStructure_PairInclusion_2a6b123d94386bb22b2b X :=
  @cleanConstructor_pair_inclusion_d00d3a03332707a42c44 X P P (@subsetRefl (pointType X) P.ambient) (@subsetRefl (pointType X) P.relative)
noncomputable def compose (X : spaceType) (Q R : cleanStructure_PairInclusion_2a6b123d94386bb22b2b X) (middle : Q.target=R.source) : cleanStructure_PairInclusion_2a6b123d94386bb22b2b X :=
  @cleanConstructor_pair_inclusion_d00d3a03332707a42c44 X Q.source R.target
    (@subsetTrans (pointType X) Q.source.ambient R.source.ambient R.target.ambient
      (@replaceTarget (pointType X) Q.source.ambient Q.target.ambient R.source.ambient Q.ambient
        (@ambientEq X Q.target R.source middle)) R.ambient)
    (@subsetTrans (pointType X) Q.source.relative R.source.relative R.target.relative
      (@replaceTarget (pointType X) Q.source.relative Q.target.relative R.source.relative Q.relative
        (@relativeEq X Q.target R.source middle)) R.relative)
def identityEndpoints : Prop := ∀ (X : spaceType) (P : cleanStructure_TopologicalPair_f701031cf43f9f923573 X), P=P ∧ P=P
def compositionEndpoints : Prop := ∀ (X : spaceType) (Q R : cleanStructure_PairInclusion_2a6b123d94386bb22b2b X), Q.target=R.source →
  Q.source=Q.source ∧ R.target=R.target
def sourceIdentity : Prop := ∀ (X : spaceType) (Q : cleanStructure_PairInclusion_2a6b123d94386bb22b2b X),
  @compose X (@identity X Q.source) Q (@reflexivity (cleanStructure_TopologicalPair_f701031cf43f9f923573 X) Q.source) = Q
def targetIdentity : Prop := ∀ (X : spaceType) (Q : cleanStructure_PairInclusion_2a6b123d94386bb22b2b X),
  @compose X Q (@identity X Q.target) (@reflexivity (cleanStructure_TopologicalPair_f701031cf43f9f923573 X) Q.target) = Q
def associativity : Prop := ∀ (X : spaceType) (Q R S : cleanStructure_PairInclusion_2a6b123d94386bb22b2b X)
  (first : Q.target=R.source) (second : R.target=S.source),
  @compose X (@compose X Q R first) S second = @compose X Q (@compose X R S second) first
def continuousIdentity : Prop := ∀ (X : spaceType) (P : cleanStructure_TopologicalPair_f701031cf43f9f923573 X),
  @cleanDefine_ambient_continuous_map_9e18751f172667d7bde2 X (@identity X P) = @cleanNotation_identity_continuous_map_3328841a46298311ee43 (@cleanNotation_subspace_c5a9f0dd775aa465e7fc X P.ambient) ∧
  @cleanDefine_relative_continuous_map_3c81881ebcda9c1a81bc X (@identity X P) = @cleanNotation_identity_continuous_map_3328841a46298311ee43 (@cleanNotation_subspace_c5a9f0dd775aa465e7fc X P.relative)
end PairCompositionOracle
same_target cleanType_Set_6e300741358eee425e81 PairCompositionOracle.setType
same_target cleanType_TopologicalSpace_d66be29262ccb5d89e3b PairCompositionOracle.spaceType
same_target cleanType_Point_f8a65e23875fb9a2c125 PairCompositionOracle.pointType
same_target cleanNotation_equality_congruence_3e3f32efa32223213c0e PairCompositionOracle.congruence
same_target cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db PairCompositionOracle.reflexivity
same_target cleanNotation_subset_reflexivity_1568c5a94ff73fdf7628 PairCompositionOracle.subsetRefl
same_target cleanNotation_subset_transitivity_78b5104bebe704cfbd35 PairCompositionOracle.subsetTrans
same_target cleanNotation_replace_subset_target_5c4b0ef7e2b533db2bc1 PairCompositionOracle.replaceTarget
same_target cleanDefine_pair_ambient_equality_95151602164c8990ac0f PairCompositionOracle.ambientEq
same_target cleanDefine_pair_relative_equality_88f8a842c2633c83eb92 PairCompositionOracle.relativeEq
same_target cleanDefine_identity_pair_inclusion_d40752a532778f87478b PairCompositionOracle.identity
same_target cleanDefine_compose_pair_inclusions_c4d803d6c358f3e572ee PairCompositionOracle.compose
same_target CleanStatements.pair_source_identity._proof_1 PairCompositionOracle.sourceIdentity._proof_1
same_target CleanStatements.pair_target_identity._proof_1 PairCompositionOracle.targetIdentity._proof_1
same_target CleanStatements.identity_pair_endpoints PairCompositionOracle.identityEndpoints
same_target CleanStatements.composed_pair_endpoints PairCompositionOracle.compositionEndpoints
same_target CleanStatements.pair_source_identity PairCompositionOracle.sourceIdentity
same_target CleanStatements.pair_target_identity PairCompositionOracle.targetIdentity
same_target CleanStatements.pair_composition_associativity PairCompositionOracle.associativity
same_target CleanStatements.identity_pair_continuous_maps PairCompositionOracle.continuousIdentity

namespace PairCompositionProofs
theorem identity_pair_endpoints : CleanStatements.identity_pair_endpoints := by
  intro X P
  exact ⟨rfl,rfl⟩
theorem composed_pair_endpoints : CleanStatements.composed_pair_endpoints := by
  intro X Q R middle
  exact ⟨rfl,rfl⟩
theorem pair_source_identity : CleanStatements.pair_source_identity := by
  intro X Q
  rfl
theorem pair_target_identity : CleanStatements.pair_target_identity := by
  intro X Q
  rfl
theorem pair_composition_associativity : CleanStatements.pair_composition_associativity := by
  intro X Q R S first second
  rfl
theorem identity_pair_continuous_maps : CleanStatements.identity_pair_continuous_maps := by
  intro X P
  constructor <;> ext x <;> rfl
end PairCompositionProofs

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
