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
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.LinearAlgebra.Span.Basic
import Mathlib.Algebra.Category.ModuleCat.Basic
import Mathlib.AlgebraicTopology.SingularHomology.Basic
import Mathlib.Algebra.Category.ModuleCat.Abelian
import Mathlib.Algebra.Category.ModuleCat.Colimits
import Mathlib.Algebra.Homology.HomologicalComplexAbelian
import Mathlib.Algebra.Homology.ShortComplex.HomologicalComplex
import Mathlib.Topology.ContinuousMap.Algebra
import Mathlib.Topology.Compactness.Compact

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

/--
A topology, two points, and a path between them, on a fixed carrier.
-/
structure cleanStructure_BasedPath_70f574d7589934963ee1 («X» : Type) : Type where
  «topology» : (_root_.cleanType_Topology_2eca621ea710e87cf174 («X»))
  «start» : «X»
  «finish» : «X»
  «path» : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 («X») («topology») («start») («finish»))

noncomputable def cleanConstructor_based_path_2b5edffd368145e026ec («X» : Type) («topology» : (_root_.cleanType_Topology_2eca621ea710e87cf174 («X»))) («start» : «X») («finish» : «X») («path» : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 («X») («topology») («start») («finish»))) : _root_.cleanStructure_BasedPath_70f574d7589934963ee1 («X») :=
  @_root_.cleanStructure_BasedPath_70f574d7589934963ee1.mk «X» «topology» «start» «finish» «path»

noncomputable def cleanDefine_reversed_bundle_89d7b5d246c5c673d41c  (X : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (P : _root_.cleanStructure_BasedPath_70f574d7589934963ee1 (X)) : _root_.cleanStructure_BasedPath_70f574d7589934963ee1 (X) :=
  (@_root_.cleanConstructor_based_path_2b5edffd368145e026ec (X) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«topology» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«finish» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«start» (X) (P))) ((@_root_.cleanNotation_reverse_path_bccacbe82db41fbe7c6d (X) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«topology» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«start» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«finish» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«path» (X) (P))))))

structure cleanStructure_Endpoints_7a6ba0b879274641120c  : Type where
  «lower» : (_root_.cleanType_Real_107b6641a486642ad8e1)
  «upper» : (_root_.cleanType_Real_107b6641a486642ad8e1)

noncomputable def cleanConstructor_endpoints_3622a2317e61075ae5a0 («lower» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («upper» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c :=
  @_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.mk «lower» «upper»

noncomputable def cleanDefine_ordered_endpoints_e18d07991fd919237102  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I)) < (@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I)))

noncomputable def cleanDefine_shifted_endpoints_ea3398852390cb480b6d  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) (s : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c :=
  (@_root_.cleanConstructor_endpoints_3622a2317e61075ae5a0 (((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I)) + s)) (((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I)) + s)))

noncomputable abbrev cleanType_Boolean_b98a4c98fcdb0f46359e  : Type :=
  Bool

noncomputable def cleanNotation_true_value_9ca9e49e1312ca23ac23   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  true

noncomputable def cleanNotation_false_value_30a63b75654d87153a83   : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e) :=
  false

noncomputable def cleanNotation_evaluate_map_fc8e4f20170606ffe807 {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) : Y :=
  f x

noncomputable abbrev cleanType_ContinuousRealMap_c65fa65fdfc171714c32 (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type :=
  (@ContinuousMap X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)

noncomputable def cleanNotation_underlying_real_map_0b69f7fea7146ae09669  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (f : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 (X))) : ((_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) → ((_root_.cleanType_Real_107b6641a486642ad8e1)) :=
  @ContinuousMap.toFun X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace f

structure cleanStructure_EndpointSelection_417d89980a2c354c2182  : Type where
  «lower» : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)
  «upper» : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)

noncomputable def cleanConstructor_endpoint_selection_f2c54850f699491deae8 («lower» : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)) («upper» : (_root_.cleanType_Boolean_b98a4c98fcdb0f46359e)) : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182 :=
  @_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.mk «lower» «upper»

noncomputable def cleanDefine_no_endpoints_3aad239e18f86ce44c68   : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182 :=
  (@_root_.cleanConstructor_endpoint_selection_f2c54850f699491deae8 ((_root_.cleanNotation_false_value_30a63b75654d87153a83)) ((_root_.cleanNotation_false_value_30a63b75654d87153a83)))

noncomputable def cleanDefine_lower_endpoint_c404a3843e685ffaf059   : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182 :=
  (@_root_.cleanConstructor_endpoint_selection_f2c54850f699491deae8 ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)) ((_root_.cleanNotation_false_value_30a63b75654d87153a83)))

noncomputable def cleanDefine_upper_endpoint_06a0ff0e6593640bb148   : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182 :=
  (@_root_.cleanConstructor_endpoint_selection_f2c54850f699491deae8 ((_root_.cleanNotation_false_value_30a63b75654d87153a83)) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))

noncomputable def cleanDefine_both_endpoints_5b72385d3bc820377d4f   : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182 :=
  (@_root_.cleanConstructor_endpoint_selection_f2c54850f699491deae8 ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)) ((_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)))

noncomputable def cleanDefine_closed_interval_3ef09f064d8b2f7a4e2e  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I)) ≤ clean_bound_0) ∧ (clean_bound_0 ≤ (@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I)))))))

noncomputable def cleanDefine_selected_endpoints_bcf18dafd1a2219f7cb4  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) (E : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => ((((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«lower» (E)) = (_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)) ∧ (clean_bound_0 = (@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I)))) ∨ (((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«upper» (E)) = (_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)) ∧ (clean_bound_0 = (@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I))))))))

noncomputable def cleanDefine_expanded_interval_750fd6e1dc6c8362900d  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => ((((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I)) - r) ≤ clean_bound_0) ∧ (clean_bound_0 ≤ ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I)) + r))))))

noncomputable def cleanDefine_expanded_endpoints_5a08e40c8090703620e2  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) (E : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Real_107b6641a486642ad8e1))) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_Real_107b6641a486642ad8e1)) => (((((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«lower» (E)) = (_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)) ∧ (((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I)) - r) ≤ clean_bound_0)) ∧ (clean_bound_0 ≤ ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I)) + r))) ∨ ((((@_root_.cleanStructure_EndpointSelection_417d89980a2c354c2182.«upper» (E)) = (_root_.cleanNotation_true_value_9ca9e49e1312ca23ac23)) ∧ (((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I)) - r) ≤ clean_bound_0)) ∧ (clean_bound_0 ≤ ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I)) + r)))))))

structure cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc  : Type 1 where
  «space» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)
  «map» : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 («space»))
  «interval» : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c
  «selection» : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182

noncomputable def cleanConstructor_interlevel_problem_53885bc5547eca082a8b («space» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («map» : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 («space»))) («interval» : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) («selection» : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182) : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc :=
  @_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.mk «space» «map» «interval» «selection»

structure cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : Type where
  «ambient» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))
  «relative» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))

noncomputable def cleanConstructor_space_pair_data_497bb4c3d9a06e9c8bf4 («X» : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) («ambient» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))) («relative» : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_Point_f8a65e23875fb9a2c125 («X»))))) : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 («X») :=
  @_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.mk «X» «ambient» «relative»

noncomputable def cleanDefine_nested_pair_6ea1594b4c58dd66c0ce  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (Q)) ⊆ (@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (Q)))

noncomputable def cleanDefine_expanded_pair_cb6ac7c55e8055c38f73  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) :=
  (@_root_.cleanConstructor_space_pair_data_497bb4c3d9a06e9c8bf4 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))))) ((_root_.cleanDefine_expanded_interval_750fd6e1dc6c8362900d ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))) (r))))) ((_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))))) ((_root_.cleanDefine_expanded_endpoints_5a08e40c8090703620e2 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» (P))) (r))))))

noncomputable def cleanDefine_shifted_pair_50c0b1d200edca0505cb  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (t : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) :=
  (@_root_.cleanConstructor_space_pair_data_497bb4c3d9a06e9c8bf4 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))))) ((_root_.cleanDefine_closed_interval_3ef09f064d8b2f7a4e2e ((_root_.cleanDefine_shifted_endpoints_ea3398852390cb480b6d ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))) (t))))))) ((_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))))) ((_root_.cleanDefine_selected_endpoints_bcf18dafd1a2219f7cb4 ((_root_.cleanDefine_shifted_endpoints_ea3398852390cb480b6d ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))) (t))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» (P))))))))

noncomputable def cleanDefine_pair_included_in_4a73f638127387b9d365  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) (R : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (Q)) ⊆ (@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (R))) ∧ ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (Q)) ⊆ (@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (R))))

noncomputable def cleanDefine_real_map_value_829bba0c597453819c48  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (f : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 (X))) (x : (_root_.cleanType_Point_f8a65e23875fb9a2c125 (X))) : (_root_.cleanType_Real_107b6641a486642ad8e1) :=
  (_root_.cleanNotation_evaluate_map_fc8e4f20170606ffe807 ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 (X) (f))) (x))

noncomputable def cleanDefine_bounded_perturbation_cc3ccaca9b62051112ab  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (h : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Point_f8a65e23875fb9a2c125 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))), (((-r) ≤ ((@_root_.cleanDefine_real_map_value_829bba0c597453819c48 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (h) (clean_bound_0)) - (@_root_.cleanDefine_real_map_value_829bba0c597453819c48 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))) (clean_bound_0)))) ∧ (((@_root_.cleanDefine_real_map_value_829bba0c597453819c48 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (h) (clean_bound_0)) - (@_root_.cleanDefine_real_map_value_829bba0c597453819c48 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))) (clean_bound_0))) ≤ r)))

noncomputable def cleanDefine_perturbed_pair_8cc4c2f45ef4c0e4a653  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (h : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))) : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) :=
  (@_root_.cleanConstructor_space_pair_data_497bb4c3d9a06e9c8bf4 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (h))) ((_root_.cleanDefine_closed_interval_3ef09f064d8b2f7a4e2e ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))))))) ((_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (h))) ((_root_.cleanDefine_selected_endpoints_bcf18dafd1a2219f7cb4 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» (P))))))))

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

noncomputable def cleanDefine_certify_pair_data_cdf76f9608063262c4c7  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) (h : (((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (Q)) ⊆ (@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (Q))))) : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X) :=
  (@_root_.cleanConstructor_topological_pair_4885b9c6167c75e582cb (X) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (Q))) ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (Q))) (h))

noncomputable def cleanDefine_has_pair_data_6f33fdbc4ebfe2f6829b  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) (S : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) (Q)) = (@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (S))) ∧ ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) (Q)) = (@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (S))))

noncomputable def cleanDefine_certify_pair_inclusion_681b193e2d00940bf5cb  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (S : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) (T : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)) (s : (((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (S)) ⊆ (@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (S))))) (t : (((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (T)) ⊆ (@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (T))))) (a : (((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (S)) ⊆ (@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (T))))) (b : (((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (S)) ⊆ (@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (T))))) : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X) :=
  (@_root_.cleanConstructor_pair_inclusion_d00d3a03332707a42c44 (X) ((@_root_.cleanDefine_certify_pair_data_cdf76f9608063262c4c7 (X) (S) (s))) ((@_root_.cleanDefine_certify_pair_data_cdf76f9608063262c4c7 (X) (T) (t))) (a) (b))

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

noncomputable abbrev cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K : Type) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) : Type 1 :=
  (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)

noncomputable abbrev cleanType_ChainMap_063e7b1ac16f4d93b32c (K : Type) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) : Type :=
  (letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D)

noncomputable def cleanNotation_chain_cokernel_97744b145fecc96e5aa0 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (f : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (D))) : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field)) :=
  (letI : Field K := field; CategoryTheory.Limits.cokernel f)

noncomputable def cleanNotation_chain_cokernel_projection_519249c918f9191af5f7 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (f : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (D))) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (D) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (C) (D) (f)))) :=
  (letI : Field K := field; CategoryTheory.Limits.cokernel.π f)

noncomputable def cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (E : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (g : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (D) (E))) (f : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (D))) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (E)) :=
  (letI : Field K := field; CategoryTheory.CategoryStruct.comp f g)

noncomputable def cleanNotation_zero_chain_map_f93211fe6742dd559667 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (D)) :=
  (letI : Field K := field; 0)

noncomputable def cleanNotation_chain_homology_d4826777f85ddf6093cd {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field)) :=
  (letI : Field K := field; (HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) n).obj C)

noncomputable def cleanNotation_induced_chain_homology_map_eb54927a741aa03132aa {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (f : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (D))) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) ((@_root_.cleanNotation_chain_homology_d4826777f85ddf6093cd (K) (field) (C) (n))) ((@_root_.cleanNotation_chain_homology_d4826777f85ddf6093cd (K) (field) (D) (n)))) :=
  (letI : Field K := field; (HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) n).map f)

noncomputable def cleanNotation_singular_chains_0ea3a0216812a68de8de {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field)) :=
  (letI : Field K := field; ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{0} K)).obj H.coefficients).obj X)

noncomputable def cleanNotation_induced_chain_map_abc08358a6e20e5bc49c {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Y : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (f : (_root_.cleanType_ContinuousMap_05cf8501fbb474169b7a (X) (Y))) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) (X))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) (Y)))) :=
  (letI : Field K := field; ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{0} K)).obj H.coefficients).map (TopCat.ofHom f))

noncomputable def cleanDefine_pair_chain_inclusion_dc6f397c90efd14c9e16 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) (Q))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) (Q)))))))) :=
  (@_root_.cleanNotation_induced_chain_map_abc08358a6e20e5bc49c (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) (Q))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) (Q))))) ((@_root_.cleanNotation_subspace_inclusion_0024be0a72eb4292b055 (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) (Q))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) (Q))) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«nesting» (X) (Q))))))

noncomputable def cleanDefine_relative_chains_d91531b175001e44787e {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field)) :=
  (@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) (Q))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) (Q))))))) ((@_root_.cleanDefine_pair_chain_inclusion_dc6f397c90efd14c9e16 (K) (field) (H) (X) (Q))))

noncomputable def cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field)) :=
  (@_root_.cleanNotation_chain_homology_d4826777f85ddf6093cd (K) (field) ((@_root_.cleanDefine_relative_chains_d91531b175001e44787e (K) (field) (H) (X) (Q))) ((@_root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9.«degree» (K) (field) (H))))

structure cleanStructure_ChainSquare_1c493e26c9ef975e0275 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («C» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) («E» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) («F» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) : Type where
  «source» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («C») («D»))
  «target» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («E») («F»))
  «left» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («C») («E»))
  «right» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («D») («F»))
  «commutes» : (((@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b («K») («field») («C») («D») («F») («right») («source»)) = (@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b («K») («field») («C») («E») («F») («target») («left»))))

noncomputable def cleanConstructor_chain_square_6c1c21212a45a419665f («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («C» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) («D» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) («E» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) («F» : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 («K») («field»))) («source» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («C») («D»))) («target» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («E») («F»))) («left» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («C») («E»))) («right» : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c («K») («field») («D») («F»))) («commutes» : (((@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b («K») («field») («C») («D») («F») («right») («source»)) = (@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b («K») («field») («C») («E») («F») («target») («left»))))) : _root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275 («K») («field») («C») («D») («E») («F») :=
  @_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.mk «K» «field» «C» «D» «E» «F» «source» «target» «left» «right» «commutes»

noncomputable def cleanNotation_chain_cokernel_map_61a006575c33e948f7d7 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (E : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (F : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (f : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (D))) (g : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (E) (F))) (p : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (C) (E))) (q : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) (D) (F))) (h : (((@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b (K) (field) (C) (D) (F) (q) (f)) = (@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b (K) (field) (C) (E) (F) (g) (p))))) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (C) (D) (f))) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (E) (F) (g)))) :=
  (letI : Field K := field; CategoryTheory.Limits.cokernel.map f g p q h)

noncomputable def cleanDefine_square_quotient_map_1aff1a772747625a2e13 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (E : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (F : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (S : _root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275 (K) (field) (C) (D) (E) (F)) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (C) (D) ((@_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.«source» (K) (field) (C) (D) (E) (F) (S))))) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (E) (F) ((@_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.«target» (K) (field) (C) (D) (E) (F) (S)))))) :=
  (@_root_.cleanNotation_chain_cokernel_map_61a006575c33e948f7d7 (K) (field) (C) (D) (E) (F) ((@_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.«source» (K) (field) (C) (D) (E) (F) (S))) ((@_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.«target» (K) (field) (C) (D) (E) (F) (S))) ((@_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.«left» (K) (field) (C) (D) (E) (F) (S))) ((@_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.«right» (K) (field) (C) (D) (E) (F) (S))) ((@_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.«commutes» (K) (field) (C) (D) (E) (F) (S))))

noncomputable def cleanDefine_square_homology_map_97ad3e8e889e402e28f1 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (C : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (D : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (E : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (F : (_root_.cleanType_ModuleChainComplex_b3e8183ddbd16d368ce8 (K) (field))) (S : _root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275 (K) (field) (C) (D) (E) (F)) (n : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) ((@_root_.cleanNotation_chain_homology_d4826777f85ddf6093cd (K) (field) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (C) (D) ((@_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.«source» (K) (field) (C) (D) (E) (F) (S))))) (n))) ((@_root_.cleanNotation_chain_homology_d4826777f85ddf6093cd (K) (field) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (E) (F) ((@_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.«target» (K) (field) (C) (D) (E) (F) (S))))) (n)))) :=
  (@_root_.cleanNotation_induced_chain_homology_map_eb54927a741aa03132aa (K) (field) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (C) (D) ((@_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.«source» (K) (field) (C) (D) (E) (F) (S))))) ((@_root_.cleanNotation_chain_cokernel_97744b145fecc96e5aa0 (K) (field) (E) (F) ((@_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.«target» (K) (field) (C) (D) (E) (F) (S))))) ((@_root_.cleanDefine_square_quotient_map_1aff1a772747625a2e13 (K) (field) (C) (D) (E) (F) (S))) (n))

noncomputable def cleanDefine_ambient_chain_map_906f67b0b9e6be5a9f07 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)))))))))) :=
  (@_root_.cleanNotation_induced_chain_map_abc08358a6e20e5bc49c (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))) ((@_root_.cleanDefine_ambient_continuous_map_9e18751f172667d7bde2 (X) (Q))))

noncomputable def cleanDefine_relative_subset_chain_map_dbf7491c8916090c6816 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)))))))))) :=
  (@_root_.cleanNotation_induced_chain_map_abc08358a6e20e5bc49c (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))) ((@_root_.cleanDefine_relative_continuous_map_3c81881ebcda9c1a81bc (X) (Q))))

noncomputable def cleanDefine_square_represents_pair_inclusion_6ec93b0151afd54d82aa {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)) (S : _root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275 (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)))))))))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (((((@_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.«source» (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))))) (S)) = (@_root_.cleanDefine_pair_chain_inclusion_dc6f397c90efd14c9e16 (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ∧ ((@_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.«target» (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))))) (S)) = (@_root_.cleanDefine_pair_chain_inclusion_dc6f397c90efd14c9e16 (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)))))) ∧ ((@_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.«left» (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))))) (S)) = (@_root_.cleanDefine_relative_subset_chain_map_dbf7491c8916090c6816 (K) (field) (H) (X) (Q)))) ∧ ((@_root_.cleanStructure_ChainSquare_1c493e26c9ef975e0275.«right» (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))))) (S)) = (@_root_.cleanDefine_ambient_chain_map_906f67b0b9e6be5a9f07 (K) (field) (H) (X) (Q))))

noncomputable def cleanDefine_relative_chain_projection_349a164acb3a0d01fa8c {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 (X)) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) (Q))))))) ((@_root_.cleanDefine_relative_chains_d91531b175001e44787e (K) (field) (H) (X) (Q)))) :=
  (@_root_.cleanNotation_chain_cokernel_projection_519249c918f9191af5f7 (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) (Q))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) (Q))))))) ((@_root_.cleanDefine_pair_chain_inclusion_dc6f397c90efd14c9e16 (K) (field) (H) (X) (Q))))

noncomputable def cleanDefine_pair_chain_commutes_929a552ea747790726dd {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  ((@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))))) ((@_root_.cleanDefine_ambient_chain_map_906f67b0b9e6be5a9f07 (K) (field) (H) (X) (Q))) ((@_root_.cleanDefine_pair_chain_inclusion_dc6f397c90efd14c9e16 (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q)))))) = (@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))))) ((@_root_.cleanDefine_pair_chain_inclusion_dc6f397c90efd14c9e16 (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanDefine_relative_subset_chain_map_dbf7491c8916090c6816 (K) (field) (H) (X) (Q)))))

noncomputable def cleanDefine_relative_chain_map_2fe783f5b93f84a5bd07 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)) (h : ((@_root_.cleanDefine_pair_chain_commutes_929a552ea747790726dd (K) (field) (H) (X) (Q)))) : (_root_.cleanType_ChainMap_063e7b1ac16f4d93b32c (K) (field) ((@_root_.cleanDefine_relative_chains_d91531b175001e44787e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanDefine_relative_chains_d91531b175001e44787e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)))))) :=
  (@_root_.cleanNotation_chain_cokernel_map_61a006575c33e948f7d7 (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«relative» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))))) ((@_root_.cleanDefine_pair_chain_inclusion_dc6f397c90efd14c9e16 (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanDefine_pair_chain_inclusion_dc6f397c90efd14c9e16 (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanDefine_relative_subset_chain_map_dbf7491c8916090c6816 (K) (field) (H) (X) (Q))) ((@_root_.cleanDefine_ambient_chain_map_906f67b0b9e6be5a9f07 (K) (field) (H) (X) (Q))) (h))

noncomputable def cleanDefine_relative_homology_map_2115802226e510f63e4c {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)) (h : ((@_root_.cleanDefine_pair_chain_commutes_929a552ea747790726dd (K) (field) (H) (X) (Q)))) : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)))))) :=
  (@_root_.cleanNotation_induced_chain_homology_map_eb54927a741aa03132aa (K) (field) ((@_root_.cleanDefine_relative_chains_d91531b175001e44787e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanDefine_relative_chains_d91531b175001e44787e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanDefine_relative_chain_map_2fe783f5b93f84a5bd07 (K) (field) (H) (X) (Q) (h))) ((@_root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9.«degree» (K) (field) (H))))

noncomputable def cleanDefine_relative_homology_image_3c5af3e571472a8fdd97 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)) (h : ((@_root_.cleanDefine_pair_chain_commutes_929a552ea747790726dd (K) (field) (H) (X) (Q)))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)))))) :=
  (@_root_.cleanNotation_module_map_range_7b55a8a231e2462f9d90 (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanDefine_relative_homology_map_2115802226e510f63e4c (K) (field) (H) (X) (Q) (h))))

noncomputable def cleanNotation_module_subspace_infimum_a6de9d6c071e01b90d47 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (spaces : (_root_.cleanType_Set_6e300741358eee425e81 ((_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M))))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M)) :=
  (letI : Field K := field; sInf spaces)

noncomputable def cleanDefine_intersection_of_module_family_36e3a337678493ef3f03 {K : Type} {I : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (spaces : (I) → ((_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M)))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M)) :=
  (@_root_.cleanNotation_module_subspace_infimum_a6de9d6c071e01b90d47 (K) (field) (M) ((_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M))) => (@Exists (I) (fun (clean_bound_1 : I) => (clean_bound_0 = (spaces clean_bound_1)))))))))

structure cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b («P» : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : Type where
  «map» : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))))
  «bounded» : ((@_root_.cleanDefine_bounded_perturbation_cc3ccaca9b62051112ab («P») («map») («r»)))
  «nesting» : ((@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanDefine_perturbed_pair_8cc4c2f45ef4c0e4a653 («P») («map»)))))
  «ambient» : (((_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) («map»))) ((_root_.cleanDefine_closed_interval_3ef09f064d8b2f7a4e2e ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»)))))) ⊆ (_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» («P»))))) ((_root_.cleanDefine_expanded_interval_750fd6e1dc6c8362900d ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»))) («r»))))))
  «relative» : (((_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) («map»))) ((_root_.cleanDefine_selected_endpoints_bcf18dafd1a2219f7cb4 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» («P»)))))) ⊆ (_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» («P»))))) ((_root_.cleanDefine_expanded_endpoints_5a08e40c8090703620e2 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» («P»))) («r»))))))

noncomputable def cleanConstructor_perturbation_certificate_5298df8b313b73f394ec («P» : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («map» : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))))) («bounded» : ((@_root_.cleanDefine_bounded_perturbation_cc3ccaca9b62051112ab («P») («map») («r»)))) («nesting» : ((@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanDefine_perturbed_pair_8cc4c2f45ef4c0e4a653 («P») («map»)))))) («ambient» : (((_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) («map»))) ((_root_.cleanDefine_closed_interval_3ef09f064d8b2f7a4e2e ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»)))))) ⊆ (_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» («P»))))) ((_root_.cleanDefine_expanded_interval_750fd6e1dc6c8362900d ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»))) («r»))))))) («relative» : (((_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) («map»))) ((_root_.cleanDefine_selected_endpoints_bcf18dafd1a2219f7cb4 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» («P»)))))) ⊆ (_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b ((@_root_.cleanNotation_underlying_real_map_0b69f7fea7146ae09669 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» («P»))))) ((_root_.cleanDefine_expanded_endpoints_5a08e40c8090703620e2 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» («P»))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«selection» («P»))) («r»))))))) : _root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b («P») («r») :=
  @_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.mk «P» «r» «map» «bounded» «nesting» «ambient» «relative»

noncomputable def cleanDefine_perturbation_target_c0c72a5419b38df16a82  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) (nesting : ((@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r)))))) : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) :=
  (@_root_.cleanDefine_certify_pair_data_cdf76f9608063262c4c7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r))) (nesting))

noncomputable def cleanDefine_perturbation_pair_inclusion_6fcc912f597359ec9825  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) (nesting : ((@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r)))))) (D : _root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b (P) (r)) : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) :=
  (@_root_.cleanDefine_certify_pair_inclusion_681b193e2d00940bf5cb ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbed_pair_8cc4c2f45ef4c0e4a653 (P) ((@_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.«map» (P) (r) (D))))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r))) ((@_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.«nesting» (P) (r) (D))) (nesting) ((@_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.«ambient» (P) (r) (D))) ((@_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.«relative» (P) (r) (D))))

structure cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («H» : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 («K») («field»)) («P» : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («nesting» : ((@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 («P») («r»)))))) : Type where
  «data» : _root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b («P») («r»)
  «commutes» : ((@_root_.cleanDefine_pair_chain_commutes_929a552ea747790726dd («K») («field») («H») ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanDefine_perturbation_pair_inclusion_6fcc912f597359ec9825 («P») («r») («nesting») («data»)))))

noncomputable def cleanConstructor_certified_perturbation_e44e7c735dacf8a137ee («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («H» : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 («K») («field»)) («P» : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («nesting» : ((@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 («P») («r»)))))) («data» : _root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b («P») («r»)) («commutes» : ((@_root_.cleanDefine_pair_chain_commutes_929a552ea747790726dd («K») («field») («H») ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanDefine_perturbation_pair_inclusion_6fcc912f597359ec9825 («P») («r») («nesting») («data»)))))) : _root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 («K») («field») («H») («P») («r») («nesting») :=
  @_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.mk «K» «field» «H» «P» «r» «nesting» «data» «commutes»

noncomputable def cleanDefine_perturbation_homology_image_40b050c3a995fbc459b2 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) (nesting : ((@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r)))))) (C : _root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 (K) (field) (H) (P) (r) (nesting)) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_c0c72a5419b38df16a82 (P) (r) (nesting)))))) :=
  (@_root_.cleanDefine_relative_homology_image_3c5af3e571472a8fdd97 (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_pair_inclusion_6fcc912f597359ec9825 (P) (r) (nesting) ((@_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.«data» (K) (field) (H) (P) (r) (nesting) (C))))) ((@_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.«commutes» (K) (field) (H) (P) (r) (nesting) (C))))

noncomputable def cleanDefine_relative_well_group_7f7f4a4866ee8b0d0748 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) (nesting : ((@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r)))))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_c0c72a5419b38df16a82 (P) (r) (nesting)))))) :=
  (@_root_.cleanDefine_intersection_of_module_family_36e3a337678493ef3f03 (K) (_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 (K) (field) (H) (P) (r) (nesting)) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_c0c72a5419b38df16a82 (P) (r) (nesting))))) ((fun (clean_bound_0 : _root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 (K) (field) (H) (P) (r) (nesting)) => (@_root_.cleanDefine_perturbation_homology_image_40b050c3a995fbc459b2 (K) (field) (H) (P) (r) (nesting) (clean_bound_0)))))

noncomputable def cleanNotation_constant_real_map_ccbffe9ae5ddda5d4e8a  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (c : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 (X)) :=
  @ContinuousMap.const X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace c

noncomputable def cleanNotation_add_real_maps_06e737c5d141c3f38607  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (f : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 (X))) (g : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 (X))) : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 (X)) :=
  (letI : TopologicalSpace X.carrier := X.str; f + g)

noncomputable def cleanDefine_translate_real_map_69674c3df57a5a22e31c  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) (f : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 (X))) (t : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 (X)) :=
  (@_root_.cleanNotation_add_real_maps_06e737c5d141c3f38607 (X) (f) ((@_root_.cleanNotation_constant_real_map_ccbffe9ae5ddda5d4e8a (X) (t))))

noncomputable def cleanDefine_shifted_perturbation_c7f54e9f89318270c92c  (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (t : (_root_.cleanType_Real_107b6641a486642ad8e1)) : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P)))) :=
  (@_root_.cleanDefine_translate_real_map_69674c3df57a5a22e31c ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«map» (P))) ((-t)))

noncomputable def cleanDefine_shifted_pair_image_edb9d169b5798b4e3703 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) (nesting : ((@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r)))))) (t : (_root_.cleanType_Real_107b6641a486642ad8e1)) (C : _root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 (K) (field) (H) (P) (r) (nesting)) (represents : (((@_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.«map» (P) (r) ((@_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.«data» (K) (field) (H) (P) (r) (nesting) (C)))) = (@_root_.cleanDefine_shifted_perturbation_c7f54e9f89318270c92c (P) (t))))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_c0c72a5419b38df16a82 (P) (r) (nesting)))))) :=
  (@_root_.cleanDefine_perturbation_homology_image_40b050c3a995fbc459b2 (K) (field) (H) (P) (r) (nesting) (C))

noncomputable def cleanDefine_intersection_of_module_subspaces_4d6fa5908536e05f1637 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (U : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M))) (V : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M)) :=
  (@_root_.cleanNotation_module_subspace_infimum_a6de9d6c071e01b90d47 (K) (field) (M) ((_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M))) => ((clean_bound_0 = U) ∨ (clean_bound_0 = V)))))))

noncomputable def cleanDefine_module_subspace_included_f21bf9e919a147bc7a4e {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))) (U : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M))) (V : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  ((@_root_.cleanNotation_module_subspace_carrier_0c98b2b061cbada2721f (K) (field) (M) (U)) ⊆ (@_root_.cleanNotation_module_subspace_carrier_0c98b2b061cbada2721f (K) (field) (M) (V)))

structure cleanStructure_ExtremePerturbations_e1a9b9e43f9b60aab368 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («H» : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 («K») («field»)) («P» : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («nesting» : ((@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 («P») («r»)))))) : Type where
  «top» : _root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 («K») («field») («H») («P») («r») («nesting»)
  «bottom» : _root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 («K») («field») («H») («P») («r») («nesting»)
  «topShift» : (((@_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.«map» («P») («r») ((@_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.«data» («K») («field») («H») («P») («r») («nesting») («top»)))) = (@_root_.cleanDefine_shifted_perturbation_c7f54e9f89318270c92c («P») («r»))))
  «bottomShift» : (((@_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.«map» («P») («r») ((@_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.«data» («K») («field») («H») («P») («r») («nesting») («bottom»)))) = (@_root_.cleanDefine_shifted_perturbation_c7f54e9f89318270c92c («P») ((-«r»)))))

noncomputable def cleanConstructor_extreme_perturbations_36b5481e3f87e882d439 («K» : Type) («field» : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf («K»))) («H» : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 («K») («field»)) («P» : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) («r» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («nesting» : ((@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» («P»))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 («P») («r»)))))) («top» : _root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 («K») («field») («H») («P») («r») («nesting»)) («bottom» : _root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 («K») («field») («H») («P») («r») («nesting»)) («topShift» : (((@_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.«map» («P») («r») ((@_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.«data» («K») («field») («H») («P») («r») («nesting») («top»)))) = (@_root_.cleanDefine_shifted_perturbation_c7f54e9f89318270c92c («P») («r»))))) («bottomShift» : (((@_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.«map» («P») («r») ((@_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.«data» («K») («field») («H») («P») («r») («nesting») («bottom»)))) = (@_root_.cleanDefine_shifted_perturbation_c7f54e9f89318270c92c («P») ((-«r»)))))) : _root_.cleanStructure_ExtremePerturbations_e1a9b9e43f9b60aab368 («K») («field») («H») («P») («r») («nesting») :=
  @_root_.cleanStructure_ExtremePerturbations_e1a9b9e43f9b60aab368.mk «K» «field» «H» «P» «r» «nesting» «top» «bottom» «topShift» «bottomShift»

noncomputable def cleanDefine_extreme_pair_image_24e87691f0bcd27adb23 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)) (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : (_root_.cleanType_Real_107b6641a486642ad8e1)) (nesting : ((@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r)))))) (E : _root_.cleanStructure_ExtremePerturbations_e1a9b9e43f9b60aab368 (K) (field) (H) (P) (r) (nesting)) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_c0c72a5419b38df16a82 (P) (r) (nesting)))))) :=
  (@_root_.cleanDefine_intersection_of_module_subspaces_4d6fa5908536e05f1637 (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_c0c72a5419b38df16a82 (P) (r) (nesting))))) ((@_root_.cleanDefine_shifted_pair_image_edb9d169b5798b4e3703 (K) (field) (H) (P) (r) (nesting) (r) ((@_root_.cleanStructure_ExtremePerturbations_e1a9b9e43f9b60aab368.«top» (K) (field) (H) (P) (r) (nesting) (E))) ((@_root_.cleanStructure_ExtremePerturbations_e1a9b9e43f9b60aab368.«topShift» (K) (field) (H) (P) (r) (nesting) (E))))) ((@_root_.cleanDefine_shifted_pair_image_edb9d169b5798b4e3703 (K) (field) (H) (P) (r) (nesting) ((-r)) ((@_root_.cleanStructure_ExtremePerturbations_e1a9b9e43f9b60aab368.«bottom» (K) (field) (H) (P) (r) (nesting) (E))) ((@_root_.cleanStructure_ExtremePerturbations_e1a9b9e43f9b60aab368.«bottomShift» (K) (field) (H) (P) (r) (nesting) (E))))))

noncomputable def cleanDefine_compact_space_a6f8ab53eacade777178  (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  @CompactSpace X.carrier X.str

noncomputable def cleanNotation_scalar_coefficient_module_fdfbd65b56f3a9c9e2b7 {K : Type} (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field)) :=
  (letI : Field K := field; ModuleCat.of K K)

noncomputable def cleanDefine_scalar_homology_0040012de8204f40a877  (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))) (p : (_root_.cleanType_Natural_469c53b6dafb7a218246)) : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field) :=
  (@_root_.cleanConstructor_homology_theory_1d5d27e4480944537ec9 (K) (field) ((@_root_.cleanNotation_scalar_coefficient_module_fdfbd65b56f3a9c9e2b7 (K) (field))) (p))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: topology
reference: submodule intersection
relationship: original
-/
def binary_module_intersection_membership : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))),
  ∀ (U V : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M))),
  ∀ (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (M))),
  ((@_root_.cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad (K) (field) (M) (x) ((@_root_.cleanDefine_intersection_of_module_subspaces_4d6fa5908536e05f1637 (K) (field) (M) (U) (V)))) ↔ ((@_root_.cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad (K) (field) (M) (x) (U)) ∧ (@_root_.cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad (K) (field) (M) (x) (V))))

/--
source: interlevel
reference: Theorem 4 extreme perturbations
relationship: adapted
scope: existence of certificates
-/
def extreme_perturbations_have_certificates : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («order» : ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))) ≤ (@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))))),
  ∀ («radius» : (r ≥ 0)),
  ∀ («nesting» : (@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r))))),
  (@Exists (_root_.cleanStructure_ExtremePerturbations_e1a9b9e43f9b60aab368 (K) (field) (H) (P) (r) («nesting»)) (fun (clean_bound_0 : _root_.cleanStructure_ExtremePerturbations_e1a9b9e43f9b60aab368 (K) (field) (H) (P) (r) («nesting»)) => (((@_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.«map» (P) (r) ((@_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.«data» (K) (field) (H) (P) (r) («nesting») ((@_root_.cleanStructure_ExtremePerturbations_e1a9b9e43f9b60aab368.«top» (K) (field) (H) (P) (r) («nesting») (clean_bound_0)))))) = (@_root_.cleanDefine_shifted_perturbation_c7f54e9f89318270c92c (P) (r))) ∧ ((@_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.«map» (P) (r) ((@_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.«data» (K) (field) (H) (P) (r) («nesting») ((@_root_.cleanStructure_ExtremePerturbations_e1a9b9e43f9b60aab368.«bottom» (K) (field) (H) (P) (r) («nesting») (clean_bound_0)))))) = (@_root_.cleanDefine_shifted_perturbation_c7f54e9f89318270c92c (P) ((-r)))))))

/--
source: topology
reference: two-image certificate independence
relationship: original
-/
def extreme_image_certificate_independence : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nesting» : (@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r))))),
  ∀ (E F : _root_.cleanStructure_ExtremePerturbations_e1a9b9e43f9b60aab368 (K) (field) (H) (P) (r) («nesting»)),
  ((@_root_.cleanDefine_extreme_pair_image_24e87691f0bcd27adb23 (K) (field) (H) (P) (r) («nesting») (E)) = (@_root_.cleanDefine_extreme_pair_image_24e87691f0bcd27adb23 (K) (field) (H) (P) (r) («nesting») (F)))

/--
source: interlevel
reference: Theorem 4
relationship: adapted
scope: forward inclusion only
-/
def well_group_lies_in_both_extreme_images : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nesting» : (@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r))))),
  ∀ (E : _root_.cleanStructure_ExtremePerturbations_e1a9b9e43f9b60aab368 (K) (field) (H) (P) (r) («nesting»)),
  (@_root_.cleanDefine_module_subspace_included_f21bf9e919a147bc7a4e (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_c0c72a5419b38df16a82 (P) (r) («nesting»))))) ((@_root_.cleanDefine_relative_well_group_7f7f4a4866ee8b0d0748 (K) (field) (H) (P) (r) («nesting»))) ((@_root_.cleanDefine_extreme_pair_image_24e87691f0bcd27adb23 (K) (field) (H) (P) (r) («nesting») (E))))

end CleanStatements

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
