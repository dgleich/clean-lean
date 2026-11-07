import Lean
import Mathlib.Tactic.Linarith
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


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: topology
reference: two Boolean endpoint flags
relationship: original
-/
def endpoint_choices_are_exhaustive : Prop :=
  ∀ (E : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182),
  ((((E = (_root_.cleanDefine_no_endpoints_3aad239e18f86ce44c68)) ∨ (E = (_root_.cleanDefine_lower_endpoint_c404a3843e685ffaf059))) ∨ (E = (_root_.cleanDefine_upper_endpoint_06a0ff0e6593640bb148))) ∨ (E = (_root_.cleanDefine_both_endpoints_5b72385d3bc820377d4f)))

/--
source: interlevel
reference: setup for Theorem 4
relationship: adapted
scope: endpoint inclusion
-/
def selected_endpoints_lie_in_the_interval : Prop :=
  ∀ (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c),
  ∀ (E : _root_.cleanStructure_EndpointSelection_417d89980a2c354c2182),
  ∀ («order» : ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I)) ≤ (@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I)))),
  ((_root_.cleanDefine_selected_endpoints_bcf18dafd1a2219f7cb4 (I) (E)) ⊆ (_root_.cleanDefine_closed_interval_3ef09f064d8b2f7a4e2e (I)))

/--
source: interlevel
reference: setup for Theorem 4
relationship: adapted
scope: pair inclusion
-/
def expanded_pair_is_nested : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («order» : ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))) ≤ (@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))))),
  ∀ («radius» : (r ≥ 0)),
  (@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r))))

/--
source: interlevel
reference: setup for Theorem 4
relationship: adapted
scope: pair inclusion
-/
def shifted_pair_is_nested : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (t : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («order» : ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))) ≤ (@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))))),
  (@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_shifted_pair_50c0b1d200edca0505cb (P) (t))))

/--
source: interlevel
reference: setup for Theorem 4
relationship: adapted
scope: all bounded shifts
-/
def shifted_pair_lies_in_expanded_pair : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r t : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («radius» : (r ≥ 0)),
  ∀ («shift» : (((-r) ≤ t) ∧ (t ≤ r))),
  (@_root_.cleanDefine_pair_included_in_4a73f638127387b9d365 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_shifted_pair_50c0b1d200edca0505cb (P) (t))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r))))

/--
source: interlevel
reference: definition of perturbation pairs
relationship: adapted
scope: pair inclusion
-/
def perturbed_pair_is_nested : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (h : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))),
  ∀ («order» : ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))) ≤ (@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))))),
  (@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbed_pair_8cc4c2f45ef4c0e4a653 (P) (h))))

/--
source: interlevel
reference: definition of relative well groups
relationship: adapted
scope: pair inclusion
-/
def bounded_perturbation_lies_in_expanded_pair : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (h : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («radius» : (r ≥ 0)),
  ∀ («bounded_perturbation_u28_P_u2c__h_u2c__r_u29_» : (@_root_.cleanDefine_bounded_perturbation_cc3ccaca9b62051112ab (P) (h) (r))),
  (@_root_.cleanDefine_pair_included_in_4a73f638127387b9d365 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbed_pair_8cc4c2f45ef4c0e4a653 (P) (h))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r))))

/--
source: topology
reference: certified expanded pair
relationship: original
-/
def expanded_pair_has_a_certificate : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («order» : ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))) ≤ (@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))))),
  ∀ («radius» : (r ≥ 0)),
  let T : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) := (@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r));
  (@Exists (_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P)))) (fun (clean_bound_0 : _root_.cleanStructure_TopologicalPair_f701031cf43f9f923573 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P)))) => (@_root_.cleanDefine_has_pair_data_6f33fdbc4ebfe2f6829b ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (clean_bound_0) (T))))

/--
source: interlevel
reference: setup for Theorem 4
relationship: adapted
scope: certified inclusion
-/
def bounded_shift_has_a_certified_inclusion : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r t : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («order» : ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))) ≤ (@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))))),
  ∀ («radius» : (r ≥ 0)),
  ∀ («shift» : (((-r) ≤ t) ∧ (t ≤ r))),
  let S : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) := (@_root_.cleanDefine_shifted_pair_50c0b1d200edca0505cb (P) (t));
  let T : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) := (@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r));
  (@Exists (_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P)))) (fun (clean_bound_0 : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P)))) => ((@_root_.cleanDefine_has_pair_data_6f33fdbc4ebfe2f6829b ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (clean_bound_0))) (S)) ∧ (@_root_.cleanDefine_has_pair_data_6f33fdbc4ebfe2f6829b ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (clean_bound_0))) (T)))))

/--
source: interlevel
reference: definition of relative well groups
relationship: adapted
scope: certified inclusion
-/
def bounded_perturbation_has_a_certified_inclusion : Prop :=
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (h : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («order» : ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))) ≤ (@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))))),
  ∀ («radius» : (r ≥ 0)),
  ∀ («bounded_perturbation_u28_P_u2c__h_u2c__r_u29_» : (@_root_.cleanDefine_bounded_perturbation_cc3ccaca9b62051112ab (P) (h) (r))),
  let S : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) := (@_root_.cleanDefine_perturbed_pair_8cc4c2f45ef4c0e4a653 (P) (h));
  let T : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) := (@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r));
  (@Exists (_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P)))) (fun (clean_bound_0 : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P)))) => ((@_root_.cleanDefine_has_pair_data_6f33fdbc4ebfe2f6829b ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (clean_bound_0))) (S)) ∧ (@_root_.cleanDefine_has_pair_data_6f33fdbc4ebfe2f6829b ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) (clean_bound_0))) (T)))))

/--
source: topology
reference: certified pair constructor
relationship: original
-/
def certification_preserves_pair_data : Prop :=
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (S : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)),
  ∀ («nesting» : ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (S)) ⊆ (@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (S)))),
  (@_root_.cleanDefine_has_pair_data_6f33fdbc4ebfe2f6829b (X) ((@_root_.cleanDefine_certify_pair_data_cdf76f9608063262c4c7 (X) (S) («nesting»))) (S))

/--
source: topology
reference: certified inclusion constructor
relationship: original
-/
def certification_preserves_inclusion_data : Prop :=
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (S T : _root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7 (X)),
  ∀ («source» : ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (S)) ⊆ (@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (S)))),
  ∀ («target» : ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (T)) ⊆ (@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (T)))),
  ∀ («ambient» : ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (S)) ⊆ (@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«ambient» (X) (T)))),
  ∀ («relative» : ((@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (S)) ⊆ (@_root_.cleanStructure_SpacePairData_8be8da5fc95a34b54ce7.«relative» (X) (T)))),
  let Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X) := (@_root_.cleanDefine_certify_pair_inclusion_681b193e2d00940bf5cb (X) (S) (T) («source») («target») («ambient») («relative»));
  ((@_root_.cleanDefine_has_pair_data_6f33fdbc4ebfe2f6829b (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))) (S)) ∧ (@_root_.cleanDefine_has_pair_data_6f33fdbc4ebfe2f6829b (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))) (T)))

/--
source: topology
reference: singular chain functor on pair inclusions
relationship: original
-/
def pair_chain_commutativity : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)),
  (@_root_.cleanDefine_pair_chain_commutes_929a552ea747790726dd (K) (field) (H) (X) (Q))

/--
source: topology
reference: cokernel projection naturality
relationship: adapted
-/
def relative_quotient_maps_commute : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)),
  ∀ («h» : (@_root_.cleanDefine_pair_chain_commutes_929a552ea747790726dd (K) (field) (H) (X) (Q))),
  ((@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanDefine_relative_chains_d91531b175001e44787e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanDefine_relative_chains_d91531b175001e44787e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanDefine_relative_chain_map_2fe783f5b93f84a5bd07 (K) (field) (H) (X) (Q) («h»))) ((@_root_.cleanDefine_relative_chain_projection_349a164acb3a0d01fa8c (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q)))))) = (@_root_.cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b (K) (field) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))))) ((@_root_.cleanNotation_singular_chains_0ea3a0216812a68de8de (K) (field) (H) ((@_root_.cleanNotation_subspace_c5a9f0dd775aa465e7fc (X) ((@_root_.cleanStructure_TopologicalPair_f701031cf43f9f923573.«ambient» (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))))) ((@_root_.cleanDefine_relative_chains_d91531b175001e44787e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanDefine_relative_chain_projection_349a164acb3a0d01fa8c (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) ((@_root_.cleanDefine_ambient_chain_map_906f67b0b9e6be5a9f07 (K) (field) (H) (X) (Q)))))

/--
source: topology
reference: module map range membership
relationship: adapted
-/
def relative_homology_image_membership : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (X : (_root_.cleanType_TopologicalSpace_d66be29262ccb5d89e3b)),
  ∀ (Q : _root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b (X)),
  ∀ («h» : (@_root_.cleanDefine_pair_chain_commutes_929a552ea747790726dd (K) (field) (H) (X) (Q))),
  ∀ (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))))),
  let f : (_root_.cleanType_ModuleMap_9bf239ee5af2145b9b57 (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)))))) := (@_root_.cleanDefine_relative_homology_map_2115802226e510f63e4c (K) (field) (H) (X) (Q) («h»));
  let U : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q)))))) := (@_root_.cleanDefine_relative_homology_image_3c5af3e571472a8fdd97 (K) (field) (H) (X) (Q) («h»));
  ((@_root_.cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) (x) (U)) ↔ (@Exists ((_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))) (fun (clean_bound_0 : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))))) => ((@_root_.cleanNotation_module_map_value_d59145d0b679c3ce3011 (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«source» (X) (Q))))) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) (X) ((@_root_.cleanStructure_PairInclusion_2a6b123d94386bb22b2b.«target» (X) (Q))))) (f) (clean_bound_0)) = x))))

/--
source: topology
reference: Submodule.mem_sInf
relationship: adapted
-/
def module_family_intersection_membership : Prop :=
  ∀ (K I : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 (K) (field))),
  ∀ (spaces : (I) → ((_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae (K) (field) (M)))),
  ∀ (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) (M))),
  ((@_root_.cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad (K) (field) (M) (x) ((@_root_.cleanDefine_intersection_of_module_family_36e3a337678493ef3f03 (K) (I) (field) (M) (spaces)))) ↔ (∀ (clean_bound_0 : I), (@_root_.cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad (K) (field) (M) (x) ((spaces clean_bound_0)))))

/--
source: interlevel
reference: well-group perturbation family
relationship: adapted
scope: certificate completeness
-/
def bounded_perturbations_have_certificates : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («order» : ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))) ≤ (@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«interval» (P)))))),
  ∀ («radius» : (r ≥ 0)),
  ∀ («nesting» : (@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r))))),
  ∀ (h : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))))),
  ∀ («bounded» : (@_root_.cleanDefine_bounded_perturbation_cc3ccaca9b62051112ab (P) (h) (r))),
  (@Exists (_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 (K) (field) (H) (P) (r) («nesting»)) (fun (clean_bound_0 : _root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 (K) (field) (H) (P) (r) («nesting»)) => ((@_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.«map» (P) (r) ((@_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.«data» (K) (field) (H) (P) (r) («nesting») (clean_bound_0)))) = h)))

/--
source: topology
reference: perturbation certificate evidence
relationship: original
-/
def certified_perturbations_are_bounded : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nesting» : (@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r))))),
  ∀ (C : _root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 (K) (field) (H) (P) (r) («nesting»)),
  (@_root_.cleanDefine_bounded_perturbation_cc3ccaca9b62051112ab (P) ((@_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.«map» (P) (r) ((@_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.«data» (K) (field) (H) (P) (r) («nesting») (C))))) (r))

/--
source: topology
reference: proof irrelevance for inclusion certificates
relationship: original
-/
def perturbation_image_ignores_certificate_choice : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nesting» : (@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r))))),
  ∀ (C D : _root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 (K) (field) (H) (P) (r) («nesting»)),
  ∀ («same» : ((@_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.«map» (P) (r) ((@_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.«data» (K) (field) (H) (P) (r) («nesting») (C)))) = (@_root_.cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.«map» (P) (r) ((@_root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.«data» (K) (field) (H) (P) (r) («nesting») (D)))))),
  ((@_root_.cleanDefine_perturbation_homology_image_40b050c3a995fbc459b2 (K) (field) (H) (P) (r) («nesting») (C)) = (@_root_.cleanDefine_perturbation_homology_image_40b050c3a995fbc459b2 (K) (field) (H) (P) (r) («nesting») (D)))

/--
source: interlevel
reference: definition of relative well group
relationship: adapted
-/
def relative_well_group_membership : Prop :=
  ∀ (K : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (field : (_root_.cleanType_FieldStructure_473fae039b953a4e35cf (K))),
  ∀ (H : _root_.cleanStructure_HomologyTheory_f4058490561c3b80c6d9 (K) (field)),
  ∀ (P : _root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc),
  ∀ (r : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («nesting» : (@_root_.cleanDefine_nested_pair_6ea1594b4c58dd66c0ce ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 (P) (r))))),
  ∀ (x : (_root_.cleanType_ModuleElement_0c3dbc92ed35f00927af (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_c0c72a5419b38df16a82 (P) (r) («nesting»))))))),
  ((@_root_.cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_c0c72a5419b38df16a82 (P) (r) («nesting»))))) (x) ((@_root_.cleanDefine_relative_well_group_7f7f4a4866ee8b0d0748 (K) (field) (H) (P) (r) («nesting»)))) ↔ (∀ (clean_bound_0 : _root_.cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 (K) (field) (H) (P) (r) («nesting»)), (@_root_.cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad (K) (field) ((@_root_.cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e (K) (field) (H) ((@_root_.cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc.«space» (P))) ((@_root_.cleanDefine_perturbation_target_c0c72a5419b38df16a82 (P) (r) («nesting»))))) (x) ((@_root_.cleanDefine_perturbation_homology_image_40b050c3a995fbc459b2 (K) (field) (H) (P) (r) («nesting») (clean_bound_0))))))

end CleanStatements

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `WellOracle.Data then return `cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b
  if n == `WellOracle.Certified then return `cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4
  if n == `WellOracle.infimum then return `cleanNotation_module_subspace_infimum_a6de9d6c071e01b90d47
  if n == `WellOracle.intersection then return `cleanDefine_intersection_of_module_family_36e3a337678493ef3f03
  if n == `WellOracle.data then return `cleanConstructor_perturbation_certificate_5298df8b313b73f394ec
  if n == `WellOracle.certified then return `cleanConstructor_certified_perturbation_e44e7c735dacf8a137ee
  if n == `WellOracle.target then return `cleanDefine_perturbation_target_c0c72a5419b38df16a82
  if n == `WellOracle.inclusion then return `cleanDefine_perturbation_pair_inclusion_6fcc912f597359ec9825
  if n == `WellOracle.image then return `cleanDefine_perturbation_homology_image_40b050c3a995fbc459b2
  if n == `WellOracle.well then return `cleanDefine_relative_well_group_7f7f4a4866ee8b0d0748
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

namespace WellOracle
noncomputable def infimum {K : Type} (field : _root_.cleanType_FieldStructure_473fae039b953a4e35cf K) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 K field)) (spaces : _root_.cleanType_Set_6e300741358eee425e81 (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae K field M)) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae K field M) :=
  letI : Field K := field
  sInf spaces
noncomputable def intersection {K I : Type} (field : _root_.cleanType_FieldStructure_473fae039b953a4e35cf K) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 K field)) (spaces : I → (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae K field M)) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae K field M) :=
  @infimum K field M (@cleanNotation_set_of_2c71fd475f49a65bd03e (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae K field M) (fun U => @Exists I (fun i => U=spaces i)))
structure Data (P : cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : _root_.cleanType_Real_107b6641a486642ad8e1) where
  map : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 P.space)
  bounded : @cleanDefine_bounded_perturbation_cc3ccaca9b62051112ab P map r
  nesting : @cleanDefine_nested_pair_6ea1594b4c58dd66c0ce P.space (@cleanDefine_perturbed_pair_8cc4c2f45ef4c0e4a653 P map)
  ambient : (@cleanDefine_inverse_image_eb657a3c1d0219ea719b (_root_.cleanType_Point_f8a65e23875fb9a2c125 P.space) _root_.cleanType_Real_107b6641a486642ad8e1 (@cleanNotation_underlying_real_map_0b69f7fea7146ae09669 P.space map) (@cleanDefine_closed_interval_3ef09f064d8b2f7a4e2e P.interval)) ⊆ (@cleanDefine_inverse_image_eb657a3c1d0219ea719b (_root_.cleanType_Point_f8a65e23875fb9a2c125 P.space) _root_.cleanType_Real_107b6641a486642ad8e1 (@cleanNotation_underlying_real_map_0b69f7fea7146ae09669 P.space P.map) (@cleanDefine_expanded_interval_750fd6e1dc6c8362900d P.interval r))
  relative : (@cleanDefine_inverse_image_eb657a3c1d0219ea719b (_root_.cleanType_Point_f8a65e23875fb9a2c125 P.space) _root_.cleanType_Real_107b6641a486642ad8e1 (@cleanNotation_underlying_real_map_0b69f7fea7146ae09669 P.space map) (@cleanDefine_selected_endpoints_bcf18dafd1a2219f7cb4 P.interval P.selection)) ⊆ (@cleanDefine_inverse_image_eb657a3c1d0219ea719b (_root_.cleanType_Point_f8a65e23875fb9a2c125 P.space) _root_.cleanType_Real_107b6641a486642ad8e1 (@cleanNotation_underlying_real_map_0b69f7fea7146ae09669 P.space P.map) (@cleanDefine_expanded_endpoints_5a08e40c8090703620e2 P.interval P.selection r))
noncomputable def data (P : cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : _root_.cleanType_Real_107b6641a486642ad8e1) (map : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 P.space))
  (bounded : @cleanDefine_bounded_perturbation_cc3ccaca9b62051112ab P map r) (nesting : @cleanDefine_nested_pair_6ea1594b4c58dd66c0ce P.space (@cleanDefine_perturbed_pair_8cc4c2f45ef4c0e4a653 P map))
  (ambient : (@cleanDefine_inverse_image_eb657a3c1d0219ea719b (_root_.cleanType_Point_f8a65e23875fb9a2c125 P.space) _root_.cleanType_Real_107b6641a486642ad8e1 (@cleanNotation_underlying_real_map_0b69f7fea7146ae09669 P.space map) (@cleanDefine_closed_interval_3ef09f064d8b2f7a4e2e P.interval)) ⊆ (@cleanDefine_inverse_image_eb657a3c1d0219ea719b (_root_.cleanType_Point_f8a65e23875fb9a2c125 P.space) _root_.cleanType_Real_107b6641a486642ad8e1 (@cleanNotation_underlying_real_map_0b69f7fea7146ae09669 P.space P.map) (@cleanDefine_expanded_interval_750fd6e1dc6c8362900d P.interval r)))
  (relative : (@cleanDefine_inverse_image_eb657a3c1d0219ea719b (_root_.cleanType_Point_f8a65e23875fb9a2c125 P.space) _root_.cleanType_Real_107b6641a486642ad8e1 (@cleanNotation_underlying_real_map_0b69f7fea7146ae09669 P.space map) (@cleanDefine_selected_endpoints_bcf18dafd1a2219f7cb4 P.interval P.selection)) ⊆ (@cleanDefine_inverse_image_eb657a3c1d0219ea719b (_root_.cleanType_Point_f8a65e23875fb9a2c125 P.space) _root_.cleanType_Real_107b6641a486642ad8e1 (@cleanNotation_underlying_real_map_0b69f7fea7146ae09669 P.space P.map) (@cleanDefine_expanded_endpoints_5a08e40c8090703620e2 P.interval P.selection r))) : Data P r :=
  @Data.mk P r map bounded nesting ambient relative
noncomputable def target (P : cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : _root_.cleanType_Real_107b6641a486642ad8e1) (nesting : (@cleanDefine_nested_pair_6ea1594b4c58dd66c0ce P.space (@cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 P r))) : cleanStructure_TopologicalPair_f701031cf43f9f923573 P.space :=
  @cleanDefine_certify_pair_data_cdf76f9608063262c4c7 P.space (@cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 P r) nesting
noncomputable def inclusion (P : cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : _root_.cleanType_Real_107b6641a486642ad8e1) (nesting : (@cleanDefine_nested_pair_6ea1594b4c58dd66c0ce P.space (@cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 P r))) (D : Data P r) : cleanStructure_PairInclusion_2a6b123d94386bb22b2b P.space :=
  @cleanDefine_certify_pair_inclusion_681b193e2d00940bf5cb P.space (@cleanDefine_perturbed_pair_8cc4c2f45ef4c0e4a653 P D.map) (@cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 P r) D.nesting nesting D.ambient D.relative
structure Certified (K : Type) (field : _root_.cleanType_FieldStructure_473fae039b953a4e35cf K) (H : cleanStructure_HomologyTheory_f4058490561c3b80c6d9 K field) (P : cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : _root_.cleanType_Real_107b6641a486642ad8e1)
  (nesting : (@cleanDefine_nested_pair_6ea1594b4c58dd66c0ce P.space (@cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 P r))) where
  data : Data P r
  commutes : @cleanDefine_pair_chain_commutes_929a552ea747790726dd K field H P.space (@inclusion P r nesting data)
noncomputable def certified (K : Type) (field : _root_.cleanType_FieldStructure_473fae039b953a4e35cf K) (H : cleanStructure_HomologyTheory_f4058490561c3b80c6d9 K field) (P : cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : _root_.cleanType_Real_107b6641a486642ad8e1)
  (nesting : (@cleanDefine_nested_pair_6ea1594b4c58dd66c0ce P.space (@cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 P r))) (data : Data P r)
  (commutes : @cleanDefine_pair_chain_commutes_929a552ea747790726dd K field H P.space (@inclusion P r nesting data)) : Certified K field H P r nesting :=
  @Certified.mk K field H P r nesting data commutes
noncomputable def image {K : Type} (field : _root_.cleanType_FieldStructure_473fae039b953a4e35cf K) (H : cleanStructure_HomologyTheory_f4058490561c3b80c6d9 K field) (P : cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : _root_.cleanType_Real_107b6641a486642ad8e1)
  (nesting : (@cleanDefine_nested_pair_6ea1594b4c58dd66c0ce P.space (@cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 P r))) (C : Certified K field H P r nesting) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae K field (@cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e K field H P.space (@target P r nesting))) :=
  @cleanDefine_relative_homology_image_3c5af3e571472a8fdd97 K field H P.space (@inclusion P r nesting C.data) C.commutes
noncomputable def well {K : Type} (field : _root_.cleanType_FieldStructure_473fae039b953a4e35cf K) (H : cleanStructure_HomologyTheory_f4058490561c3b80c6d9 K field) (P : cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : _root_.cleanType_Real_107b6641a486642ad8e1)
  (nesting : (@cleanDefine_nested_pair_6ea1594b4c58dd66c0ce P.space (@cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 P r))) : (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae K field (@cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e K field H P.space (@target P r nesting))) :=
  @intersection K (Certified K field H P r nesting) field (@cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e K field H P.space (@target P r nesting))
    (fun C : Certified K field H P r nesting => @image K field H P r nesting C)

def intersectionStatement : Prop := ∀ (K I : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (field : _root_.cleanType_FieldStructure_473fae039b953a4e35cf K) (M : (_root_.cleanType_CoefficientModule_79514ce65e42b4219878 K field)) (spaces : I → (_root_.cleanType_ModuleSubspace_3c17b4583cdbf46f50ae K field M))
  (x : _root_.cleanType_ModuleElement_0c3dbc92ed35f00927af K field M),
  @cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad K field M x (@intersection K I field M spaces) ↔ ∀ i : I, @cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad K field M x (spaces i)
def coverageStatement : Prop := ∀ (K : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (field : _root_.cleanType_FieldStructure_473fae039b953a4e35cf K) (H : cleanStructure_HomologyTheory_f4058490561c3b80c6d9 K field) (P : cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : _root_.cleanType_Real_107b6641a486642ad8e1),
  P.interval.lower ≤ P.interval.upper → r ≥ 0 → ∀ (nesting : (@cleanDefine_nested_pair_6ea1594b4c58dd66c0ce P.space (@cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 P r))) (h : (_root_.cleanType_ContinuousRealMap_c65fa65fdfc171714c32 P.space)),
  @cleanDefine_bounded_perturbation_cc3ccaca9b62051112ab P h r → ∃ C : Certified K field H P r nesting, C.data.map=h
def boundedStatement : Prop := ∀ (K : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (field : _root_.cleanType_FieldStructure_473fae039b953a4e35cf K) (H : cleanStructure_HomologyTheory_f4058490561c3b80c6d9 K field) (P : cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : _root_.cleanType_Real_107b6641a486642ad8e1)
  (nesting : (@cleanDefine_nested_pair_6ea1594b4c58dd66c0ce P.space (@cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 P r))) (C : Certified K field H P r nesting), @cleanDefine_bounded_perturbation_cc3ccaca9b62051112ab P C.data.map r
def independenceStatement : Prop := ∀ (K : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (field : _root_.cleanType_FieldStructure_473fae039b953a4e35cf K) (H : cleanStructure_HomologyTheory_f4058490561c3b80c6d9 K field) (P : cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : _root_.cleanType_Real_107b6641a486642ad8e1)
  (nesting : (@cleanDefine_nested_pair_6ea1594b4c58dd66c0ce P.space (@cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 P r))) (C D : Certified K field H P r nesting), C.data.map=D.data.map →
  @image K field H P r nesting C = @image K field H P r nesting D
def membershipStatement : Prop := ∀ (K : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (field : _root_.cleanType_FieldStructure_473fae039b953a4e35cf K) (H : cleanStructure_HomologyTheory_f4058490561c3b80c6d9 K field) (P : cleanStructure_InterlevelProblem_bd437b0a9a6bb0556cbc) (r : _root_.cleanType_Real_107b6641a486642ad8e1)
  (nesting : (@cleanDefine_nested_pair_6ea1594b4c58dd66c0ce P.space (@cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 P r))) (x : _root_.cleanType_ModuleElement_0c3dbc92ed35f00927af K field (@cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e K field H P.space (@target P r nesting))),
  @cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad K field (@cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e K field H P.space (@target P r nesting)) x (@well K field H P r nesting) ↔
    ∀ C : Certified K field H P r nesting, @cleanDefine_belongs_to_module_subspace_336835fcf8bff9ca8fad K field (@cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e K field H P.space (@target P r nesting)) x (@image K field H P r nesting C)
end WellOracle
same_target cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b WellOracle.Data
same_target cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 WellOracle.Certified
same_target cleanNotation_module_subspace_infimum_a6de9d6c071e01b90d47 WellOracle.infimum
same_target cleanDefine_intersection_of_module_family_36e3a337678493ef3f03 WellOracle.intersection
same_target cleanConstructor_perturbation_certificate_5298df8b313b73f394ec WellOracle.data
same_target cleanConstructor_certified_perturbation_e44e7c735dacf8a137ee WellOracle.certified
same_target cleanDefine_perturbation_target_c0c72a5419b38df16a82 WellOracle.target
same_target cleanDefine_perturbation_pair_inclusion_6fcc912f597359ec9825 WellOracle.inclusion
same_target cleanDefine_perturbation_homology_image_40b050c3a995fbc459b2 WellOracle.image
same_target cleanDefine_relative_well_group_7f7f4a4866ee8b0d0748 WellOracle.well
same_target cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.mk WellOracle.Data.mk
same_target cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.map WellOracle.Data.map
same_target cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.bounded WellOracle.Data.bounded
same_target cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.nesting WellOracle.Data.nesting
same_target cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.ambient WellOracle.Data.ambient
same_target cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b.relative WellOracle.Data.relative
same_target cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.mk WellOracle.Certified.mk
same_target cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.data WellOracle.Certified.data
same_target cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4.commutes WellOracle.Certified.commutes
same_target CleanStatements.module_family_intersection_membership WellOracle.intersectionStatement
same_target CleanStatements.bounded_perturbations_have_certificates WellOracle.coverageStatement
same_target CleanStatements.certified_perturbations_are_bounded WellOracle.boundedStatement
same_target CleanStatements.perturbation_image_ignores_certificate_choice WellOracle.independenceStatement
same_target CleanStatements.relative_well_group_membership WellOracle.membershipStatement
namespace InterlevelProofs
theorem endpoint_choices_are_exhaustive : CleanStatements.endpoint_choices_are_exhaustive := by
  intro E
  rcases E with ⟨l,u⟩
  cases l <;> cases u <;>
    first | exact Or.inl (Or.inl (Or.inl rfl)) | exact Or.inl (Or.inl (Or.inr rfl)) |
            exact Or.inl (Or.inr rfl) | exact Or.inr rfl

theorem selected_endpoints_lie_in_the_interval : CleanStatements.selected_endpoints_lie_in_the_interval := by
  intro I E h x hx
  change (E.lower=true ∧ x=I.lower) ∨ (E.upper=true ∧ x=I.upper) at hx
  change I.lower ≤ x ∧ x ≤ I.upper
  rcases hx with ⟨_,rfl⟩ | ⟨_,rfl⟩
  · exact ⟨le_refl _,h⟩
  · exact ⟨h,le_refl _⟩

theorem expanded_pair_is_nested : CleanStatements.expanded_pair_is_nested := by
  intro P r ho _hr x hx
  change ((P.selection.lower=true ∧ P.interval.lower-r ≤ P.map x) ∧ P.map x ≤ P.interval.lower+r) ∨
    ((P.selection.upper=true ∧ P.interval.upper-r ≤ P.map x) ∧ P.map x ≤ P.interval.upper+r) at hx
  change P.interval.lower-r ≤ P.map x ∧ P.map x ≤ P.interval.upper+r
  rcases hx with ⟨⟨_,hl⟩,hu⟩ | ⟨⟨_,hl⟩,hu⟩
  · exact ⟨hl, by linarith⟩
  · exact ⟨by linarith, hu⟩

theorem shifted_pair_is_nested : CleanStatements.shifted_pair_is_nested := by
  intro P t ho x hx
  change (P.selection.lower=true ∧ P.map x=P.interval.lower+t) ∨
    (P.selection.upper=true ∧ P.map x=P.interval.upper+t) at hx
  change P.interval.lower+t ≤ P.map x ∧ P.map x ≤ P.interval.upper+t
  rcases hx with ⟨_,he⟩ | ⟨_,he⟩
  · constructor <;> linarith
  · constructor <;> linarith

theorem shifted_pair_lies_in_expanded_pair : CleanStatements.shifted_pair_lies_in_expanded_pair := by
  intro P r t _hr ht
  constructor
  · intro x hx
    change P.interval.lower+t ≤ P.map x ∧ P.map x ≤ P.interval.upper+t at hx
    change P.interval.lower-r ≤ P.map x ∧ P.map x ≤ P.interval.upper+r
    constructor <;> linarith [hx.1,hx.2,ht.1,ht.2]
  · intro x hx
    change (P.selection.lower=true ∧ P.map x=P.interval.lower+t) ∨
      (P.selection.upper=true ∧ P.map x=P.interval.upper+t) at hx
    change ((P.selection.lower=true ∧ P.interval.lower-r ≤ P.map x) ∧ P.map x ≤ P.interval.lower+r) ∨
      ((P.selection.upper=true ∧ P.interval.upper-r ≤ P.map x) ∧ P.map x ≤ P.interval.upper+r)
    rcases hx with ⟨he,hx⟩ | ⟨he,hx⟩
    · left
      exact ⟨⟨he,by linarith [ht.1]⟩,by linarith [ht.2]⟩
    · right
      exact ⟨⟨he,by linarith [ht.1]⟩,by linarith [ht.2]⟩
theorem perturbed_pair_is_nested : CleanStatements.perturbed_pair_is_nested := by
  intro P h ho x hx
  change (P.selection.lower=true ∧ h x=P.interval.lower) ∨
    (P.selection.upper=true ∧ h x=P.interval.upper) at hx
  change P.interval.lower ≤ h x ∧ h x ≤ P.interval.upper
  rcases hx with ⟨_,he⟩ | ⟨_,he⟩
  · constructor <;> linarith
  · constructor <;> linarith

theorem bounded_perturbation_lies_in_expanded_pair : CleanStatements.bounded_perturbation_lies_in_expanded_pair := by
  intro P h r _hr hb
  change ∀ x : P.space.carrier, -r ≤ h x-P.map x ∧ h x-P.map x ≤ r at hb
  constructor
  · intro x hx
    change P.interval.lower ≤ h x ∧ h x ≤ P.interval.upper at hx
    change P.interval.lower-r ≤ P.map x ∧ P.map x ≤ P.interval.upper+r
    constructor <;> linarith [(hb x).1,(hb x).2,hx.1,hx.2]
  · intro x hx
    change (P.selection.lower=true ∧ h x=P.interval.lower) ∨
      (P.selection.upper=true ∧ h x=P.interval.upper) at hx
    change ((P.selection.lower=true ∧ P.interval.lower-r ≤ P.map x) ∧ P.map x ≤ P.interval.lower+r) ∨
      ((P.selection.upper=true ∧ P.interval.upper-r ≤ P.map x) ∧ P.map x ≤ P.interval.upper+r)
    rcases hx with ⟨he,hx⟩ | ⟨he,hx⟩
    · left
      exact ⟨⟨he,by linarith [(hb x).1,(hb x).2]⟩,by linarith [(hb x).1,(hb x).2]⟩
    · right
      exact ⟨⟨he,by linarith [(hb x).1,(hb x).2]⟩,by linarith [(hb x).1,(hb x).2]⟩
theorem expanded_pair_has_a_certificate : CleanStatements.expanded_pair_has_a_certificate := by
  intro P r ho hr
  let T := cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 P r
  refine ⟨⟨T.ambient,T.relative,?_⟩,rfl,rfl⟩
  exact expanded_pair_is_nested P r ho hr

theorem bounded_shift_has_a_certified_inclusion : CleanStatements.bounded_shift_has_a_certified_inclusion := by
  intro P r t ho hr ht
  let S := cleanDefine_shifted_pair_50c0b1d200edca0505cb P t
  let T := cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 P r
  have hs := shifted_pair_is_nested P t ho
  have ht' := expanded_pair_is_nested P r ho hr
  have hi := shifted_pair_lies_in_expanded_pair P r t hr ht
  refine ⟨⟨⟨S.ambient,S.relative,hs⟩,⟨T.ambient,T.relative,ht'⟩,hi.1,hi.2⟩,?_⟩
  exact ⟨⟨rfl,rfl⟩,⟨rfl,rfl⟩⟩

theorem bounded_perturbation_has_a_certified_inclusion : CleanStatements.bounded_perturbation_has_a_certified_inclusion := by
  intro P h r ho hr hb
  let S := cleanDefine_perturbed_pair_8cc4c2f45ef4c0e4a653 P h
  let T := cleanDefine_expanded_pair_cb6ac7c55e8055c38f73 P r
  have hs := perturbed_pair_is_nested P h ho
  have ht := expanded_pair_is_nested P r ho hr
  have hi := bounded_perturbation_lies_in_expanded_pair P h r hr hb
  refine ⟨⟨⟨S.ambient,S.relative,hs⟩,⟨T.ambient,T.relative,ht⟩,hi.1,hi.2⟩,?_⟩
  exact ⟨⟨rfl,rfl⟩,⟨rfl,rfl⟩⟩

theorem certification_preserves_pair_data : CleanStatements.certification_preserves_pair_data := by
  intro X S h
  exact ⟨rfl,rfl⟩
theorem certification_preserves_inclusion_data : CleanStatements.certification_preserves_inclusion_data := by
  intro X S T s t a b
  exact ⟨⟨rfl,rfl⟩,⟨rfl,rfl⟩⟩
end InterlevelProofs
namespace RelativeMapProofs
theorem pair_chain_commutativity : CleanStatements.pair_chain_commutativity := by
  intro K field H X Q
  letI : Field K := field
  simp only [cleanDefine_pair_chain_commutes_929a552ea747790726dd, cleanNotation_compose_chain_maps_e997e4aa538eb942fa5b, cleanDefine_pair_chain_inclusion_dc6f397c90efd14c9e16, cleanNotation_induced_chain_map_abc08358a6e20e5bc49c, cleanDefine_ambient_chain_map_906f67b0b9e6be5a9f07, cleanDefine_relative_subset_chain_map_dbf7491c8916090c6816]
  rw [← CategoryTheory.Functor.map_comp, ← CategoryTheory.Functor.map_comp]
  rfl
theorem relative_quotient_maps_commute : CleanStatements.relative_quotient_maps_commute := by
  intro K field H X Q h
  letI : Field K := field
  exact CategoryTheory.Limits.cokernel.π_desc _ _ _
theorem relative_homology_image_membership : CleanStatements.relative_homology_image_membership := by
  intro K field H X Q h x
  rfl
end RelativeMapProofs

namespace WellProofs
theorem module_family_intersection_membership : CleanStatements.module_family_intersection_membership := by
  intro K I field M spaces x
  letI : Field K := field
  letI : AddCommGroup M.carrier := M.isAddCommGroup
  letI : Module K M.carrier := M.isModule
  change x ∈ sInf {U : Submodule K M.carrier | ∃ i : I, U=spaces i} ↔ ∀ i : I, x ∈ spaces i
  constructor
  · intro hx i
    exact (Submodule.mem_sInf.mp hx) _ ⟨i,rfl⟩
  · intro hx
    apply Submodule.mem_sInf.mpr
    intro U hU
    rcases hU with ⟨i,rfl⟩
    exact hx i

theorem bounded_perturbations_have_certificates : CleanStatements.bounded_perturbations_have_certificates := by
  intro K field H P r ho hr nesting h hb
  have hn := InterlevelProofs.perturbed_pair_is_nested P h ho
  have hi := InterlevelProofs.bounded_perturbation_lies_in_expanded_pair P h r hr hb
  let D : cleanStructure_PerturbationCertificate_7702785863d7fbd9e28b P r := ⟨h,hb,hn,hi.1,hi.2⟩
  refine ⟨⟨D,?_⟩,rfl⟩
  exact RelativeMapProofs.pair_chain_commutativity K field H P.space (@cleanDefine_perturbation_pair_inclusion_6fcc912f597359ec9825 P r nesting D)

theorem certified_perturbations_are_bounded : CleanStatements.certified_perturbations_are_bounded := by
  intro K field H P r nesting C
  exact C.data.bounded

theorem perturbation_image_ignores_certificate_choice : CleanStatements.perturbation_image_ignores_certificate_choice := by
  intro K field H P r nesting C D same
  cases C with
  | mk c hc =>
    cases D with
    | mk d hd =>
      cases c with
      | mk f fb fn fa fr =>
        cases d with
        | mk g gb gn ga gr =>
          change f=g at same
          subst g
          rfl

theorem relative_well_group_membership : CleanStatements.relative_well_group_membership := by
  intro K field H P r nesting x
  exact module_family_intersection_membership K (cleanStructure_CertifiedPerturbation_d14a5d70bf3c40f898c4 K field H P r nesting) field
    (@cleanDefine_relative_homology_c2e54d20e9bf5fa54c5e K field H P.space (@cleanDefine_perturbation_target_c0c72a5419b38df16a82 P r nesting))
    (fun C => @cleanDefine_perturbation_homology_image_40b050c3a995fbc459b2 K field H P r nesting C) x
end WellProofs

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
