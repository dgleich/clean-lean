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

/--
A topology, two points, and a path between them, on a fixed carrier.
-/
structure cleanStructure_BasedPath_af4022cf2eeed1e2d1ab («X» : Type) : Type where
  «topology» : TopologicalSpace «X»
  «start» : «X»
  «finish» : «X»
  «path» : @Path «X» «topology» «start» «finish»

noncomputable def cleanConstructor_based_path_68c2fc8490e4ebc630bb («X» : Type) («topology» : TopologicalSpace «X») («start» : «X») («finish» : «X») («path» : @Path «X» «topology» «start» «finish») : cleanStructure_BasedPath_af4022cf2eeed1e2d1ab («X») :=
  @cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.mk «X» «topology» «start» «finish» «path»

noncomputable def cleanDefine_reversed_bundle_9779f436492a7430ddec  (X : Type) (P : cleanStructure_BasedPath_af4022cf2eeed1e2d1ab (X)) : cleanStructure_BasedPath_af4022cf2eeed1e2d1ab (X) :=
  (@cleanConstructor_based_path_68c2fc8490e4ebc630bb (X) ((@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«topology» (X) (P))) ((@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«finish» (X) (P))) ((@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«start» (X) (P))) ((@cleanNotation_reverse_path_43d430a43539939bcf2c (X) ((@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«topology» (X) (P))) ((@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«start» (X) (P))) ((@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«finish» (X) (P))) ((@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«path» (X) (P))))))

structure cleanStructure_Endpoints_2512a023e0474ce195ac  : Type where
  «lower» : ℝ
  «upper» : ℝ

noncomputable def cleanConstructor_endpoints_ae57156441e5057814f6 («lower» : ℝ) («upper» : ℝ) : cleanStructure_Endpoints_2512a023e0474ce195ac :=
  @cleanStructure_Endpoints_2512a023e0474ce195ac.mk «lower» «upper»

noncomputable def cleanDefine_ordered_endpoints_867d201d7c772f8385d6  (I : cleanStructure_Endpoints_2512a023e0474ce195ac) : Prop :=
  ((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» (I)) < (@cleanStructure_Endpoints_2512a023e0474ce195ac.«upper» (I)))

noncomputable def cleanDefine_shifted_endpoints_0341e7d28e14c6ec5711  (I : cleanStructure_Endpoints_2512a023e0474ce195ac) (s : ℝ) : cleanStructure_Endpoints_2512a023e0474ce195ac :=
  (@cleanConstructor_endpoints_ae57156441e5057814f6 (((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» (I)) + s)) (((@cleanStructure_Endpoints_2512a023e0474ce195ac.«upper» (I)) + s)))

noncomputable def cleanType_Boolean_b98a4c98fcdb0f46359e  : Type :=
  Bool

noncomputable def cleanNotation_true_value_2fd5fc223c8905693b89   : Bool :=
  true

noncomputable def cleanNotation_false_value_d4e3155033dd79d1d53f   : Bool :=
  false

noncomputable def cleanNotation_evaluate_map_fc8e4f20170606ffe807 {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) : Y :=
  f x

noncomputable def cleanType_ContinuousRealMap_61be08a900d37dad3fed (X : TopCat.{0}) : Type :=
  (@ContinuousMap X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)

noncomputable def cleanNotation_underlying_real_map_a2d4907a882247d2b335  (X : TopCat.{0}) (f : (@ContinuousMap X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)) : ((TopCat.carrier X)) → (ℝ) :=
  @ContinuousMap.toFun X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace f

structure cleanStructure_EndpointSelection_b1d52148908811c63f1d  : Type where
  «lower» : Bool
  «upper» : Bool

noncomputable def cleanConstructor_endpoint_selection_e2c76e8a24faf36bd69d («lower» : Bool) («upper» : Bool) : cleanStructure_EndpointSelection_b1d52148908811c63f1d :=
  @cleanStructure_EndpointSelection_b1d52148908811c63f1d.mk «lower» «upper»

noncomputable def cleanDefine_no_endpoints_3d2c151be5ddaaa6461f   : cleanStructure_EndpointSelection_b1d52148908811c63f1d :=
  (@cleanConstructor_endpoint_selection_e2c76e8a24faf36bd69d ((cleanNotation_false_value_d4e3155033dd79d1d53f)) ((cleanNotation_false_value_d4e3155033dd79d1d53f)))

noncomputable def cleanDefine_lower_endpoint_55a3912dc3794b7cc0b5   : cleanStructure_EndpointSelection_b1d52148908811c63f1d :=
  (@cleanConstructor_endpoint_selection_e2c76e8a24faf36bd69d ((cleanNotation_true_value_2fd5fc223c8905693b89)) ((cleanNotation_false_value_d4e3155033dd79d1d53f)))

noncomputable def cleanDefine_upper_endpoint_17aeb6bb1ab98f7ac7e2   : cleanStructure_EndpointSelection_b1d52148908811c63f1d :=
  (@cleanConstructor_endpoint_selection_e2c76e8a24faf36bd69d ((cleanNotation_false_value_d4e3155033dd79d1d53f)) ((cleanNotation_true_value_2fd5fc223c8905693b89)))

noncomputable def cleanDefine_both_endpoints_9ceafa3c3eae62095b71   : cleanStructure_EndpointSelection_b1d52148908811c63f1d :=
  (@cleanConstructor_endpoint_selection_e2c76e8a24faf36bd69d ((cleanNotation_true_value_2fd5fc223c8905693b89)) ((cleanNotation_true_value_2fd5fc223c8905693b89)))

noncomputable def cleanDefine_closed_interval_02a80046a44a2fbda8de  (I : cleanStructure_Endpoints_2512a023e0474ce195ac) : Set (ℝ) :=
  (cleanNotation_set_of_25534029a1fdae044ce8 ((fun (clean_bound_0 : ℝ) => (((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» (I)) ≤ clean_bound_0) ∧ (clean_bound_0 ≤ (@cleanStructure_Endpoints_2512a023e0474ce195ac.«upper» (I)))))))

noncomputable def cleanDefine_selected_endpoints_5b3e2429768ac206a5ae  (I : cleanStructure_Endpoints_2512a023e0474ce195ac) (E : cleanStructure_EndpointSelection_b1d52148908811c63f1d) : Set (ℝ) :=
  (cleanNotation_set_of_25534029a1fdae044ce8 ((fun (clean_bound_0 : ℝ) => ((((@cleanStructure_EndpointSelection_b1d52148908811c63f1d.«lower» (E)) = (cleanNotation_true_value_2fd5fc223c8905693b89)) ∧ (clean_bound_0 = (@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» (I)))) ∨ (((@cleanStructure_EndpointSelection_b1d52148908811c63f1d.«upper» (E)) = (cleanNotation_true_value_2fd5fc223c8905693b89)) ∧ (clean_bound_0 = (@cleanStructure_Endpoints_2512a023e0474ce195ac.«upper» (I))))))))

noncomputable def cleanDefine_expanded_interval_c25cb2a7d138e802a0ed  (I : cleanStructure_Endpoints_2512a023e0474ce195ac) (r : ℝ) : Set (ℝ) :=
  (cleanNotation_set_of_25534029a1fdae044ce8 ((fun (clean_bound_0 : ℝ) => ((((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» (I)) - r) ≤ clean_bound_0) ∧ (clean_bound_0 ≤ ((@cleanStructure_Endpoints_2512a023e0474ce195ac.«upper» (I)) + r))))))

noncomputable def cleanDefine_expanded_endpoints_246c1c1637936ba4cace  (I : cleanStructure_Endpoints_2512a023e0474ce195ac) (E : cleanStructure_EndpointSelection_b1d52148908811c63f1d) (r : ℝ) : Set (ℝ) :=
  (cleanNotation_set_of_25534029a1fdae044ce8 ((fun (clean_bound_0 : ℝ) => (((((@cleanStructure_EndpointSelection_b1d52148908811c63f1d.«lower» (E)) = (cleanNotation_true_value_2fd5fc223c8905693b89)) ∧ (((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» (I)) - r) ≤ clean_bound_0)) ∧ (clean_bound_0 ≤ ((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» (I)) + r))) ∨ ((((@cleanStructure_EndpointSelection_b1d52148908811c63f1d.«upper» (E)) = (cleanNotation_true_value_2fd5fc223c8905693b89)) ∧ (((@cleanStructure_Endpoints_2512a023e0474ce195ac.«upper» (I)) - r) ≤ clean_bound_0)) ∧ (clean_bound_0 ≤ ((@cleanStructure_Endpoints_2512a023e0474ce195ac.«upper» (I)) + r)))))))

structure cleanStructure_InterlevelProblem_006185c6b0da68de0867  : Type 1 where
  «space» : TopCat.{0}
  «map» : (@ContinuousMap «space».carrier ℝ «space».str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)
  «interval» : cleanStructure_Endpoints_2512a023e0474ce195ac
  «selection» : cleanStructure_EndpointSelection_b1d52148908811c63f1d

noncomputable def cleanConstructor_interlevel_problem_42723c03a4cce7c0a1ff («space» : TopCat.{0}) («map» : (@ContinuousMap «space».carrier ℝ «space».str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)) («interval» : cleanStructure_Endpoints_2512a023e0474ce195ac) («selection» : cleanStructure_EndpointSelection_b1d52148908811c63f1d) : cleanStructure_InterlevelProblem_006185c6b0da68de0867 :=
  @cleanStructure_InterlevelProblem_006185c6b0da68de0867.mk «space» «map» «interval» «selection»

structure cleanStructure_SpacePairData_f4912a1b453369bfb75e («X» : TopCat.{0}) : Type where
  «ambient» : Set ((TopCat.carrier «X»))
  «relative» : Set ((TopCat.carrier «X»))

noncomputable def cleanConstructor_space_pair_data_d4663b2e361ad8703041 («X» : TopCat.{0}) («ambient» : Set ((TopCat.carrier «X»))) («relative» : Set ((TopCat.carrier «X»))) : cleanStructure_SpacePairData_f4912a1b453369bfb75e («X») :=
  @cleanStructure_SpacePairData_f4912a1b453369bfb75e.mk «X» «ambient» «relative»

noncomputable def cleanDefine_nested_pair_203f27c03de1e4f128ad  (X : TopCat.{0}) (Q : cleanStructure_SpacePairData_f4912a1b453369bfb75e (X)) : Prop :=
  ((@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«relative» (X) (Q)) ⊆ (@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«ambient» (X) (Q)))

noncomputable def cleanDefine_expanded_pair_66873557049e4375bc60  (P : cleanStructure_InterlevelProblem_006185c6b0da68de0867) (r : ℝ) : cleanStructure_SpacePairData_f4912a1b453369bfb75e ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) :=
  (@cleanConstructor_space_pair_data_d4663b2e361ad8703041 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((cleanDefine_inverse_image_b2385c49c1629ae08495 ((@cleanNotation_underlying_real_map_a2d4907a882247d2b335 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«map» (P))))) ((cleanDefine_expanded_interval_c25cb2a7d138e802a0ed ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P))) (r))))) ((cleanDefine_inverse_image_b2385c49c1629ae08495 ((@cleanNotation_underlying_real_map_a2d4907a882247d2b335 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«map» (P))))) ((cleanDefine_expanded_endpoints_246c1c1637936ba4cace ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P))) ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«selection» (P))) (r))))))

noncomputable def cleanDefine_shifted_pair_acef58e9c1318b5833c8  (P : cleanStructure_InterlevelProblem_006185c6b0da68de0867) (t : ℝ) : cleanStructure_SpacePairData_f4912a1b453369bfb75e ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) :=
  (@cleanConstructor_space_pair_data_d4663b2e361ad8703041 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((cleanDefine_inverse_image_b2385c49c1629ae08495 ((@cleanNotation_underlying_real_map_a2d4907a882247d2b335 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«map» (P))))) ((cleanDefine_closed_interval_02a80046a44a2fbda8de ((cleanDefine_shifted_endpoints_0341e7d28e14c6ec5711 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P))) (t))))))) ((cleanDefine_inverse_image_b2385c49c1629ae08495 ((@cleanNotation_underlying_real_map_a2d4907a882247d2b335 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«map» (P))))) ((cleanDefine_selected_endpoints_5b3e2429768ac206a5ae ((cleanDefine_shifted_endpoints_0341e7d28e14c6ec5711 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P))) (t))) ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«selection» (P))))))))

noncomputable def cleanDefine_pair_included_in_93a3c208a27e390549af  (X : TopCat.{0}) (Q : cleanStructure_SpacePairData_f4912a1b453369bfb75e (X)) (R : cleanStructure_SpacePairData_f4912a1b453369bfb75e (X)) : Prop :=
  (((@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«ambient» (X) (Q)) ⊆ (@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«ambient» (X) (R))) ∧ ((@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«relative» (X) (Q)) ⊆ (@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«relative» (X) (R))))

noncomputable def cleanDefine_real_map_value_1c81a8738f0927d4f859  (X : TopCat.{0}) (f : (@ContinuousMap X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)) (x : (TopCat.carrier X)) : ℝ :=
  (cleanNotation_evaluate_map_fc8e4f20170606ffe807 ((@cleanNotation_underlying_real_map_a2d4907a882247d2b335 (X) (f))) (x))

noncomputable def cleanDefine_bounded_perturbation_f5d5b63290c0e028ea34  (P : cleanStructure_InterlevelProblem_006185c6b0da68de0867) (h : (@ContinuousMap (@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)).carrier ℝ (@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)).str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)) (r : ℝ) : Prop :=
  (∀ (clean_bound_0 : (TopCat.carrier (@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)))), (((-r) ≤ ((@cleanDefine_real_map_value_1c81a8738f0927d4f859 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) (h) (clean_bound_0)) - (@cleanDefine_real_map_value_1c81a8738f0927d4f859 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«map» (P))) (clean_bound_0)))) ∧ (((@cleanDefine_real_map_value_1c81a8738f0927d4f859 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) (h) (clean_bound_0)) - (@cleanDefine_real_map_value_1c81a8738f0927d4f859 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«map» (P))) (clean_bound_0))) ≤ r)))

noncomputable def cleanDefine_perturbed_pair_8a139afee8bcd7a01090  (P : cleanStructure_InterlevelProblem_006185c6b0da68de0867) (h : (@ContinuousMap (@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)).carrier ℝ (@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)).str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)) : cleanStructure_SpacePairData_f4912a1b453369bfb75e ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) :=
  (@cleanConstructor_space_pair_data_d4663b2e361ad8703041 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((cleanDefine_inverse_image_b2385c49c1629ae08495 ((@cleanNotation_underlying_real_map_a2d4907a882247d2b335 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) (h))) ((cleanDefine_closed_interval_02a80046a44a2fbda8de ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P))))))) ((cleanDefine_inverse_image_b2385c49c1629ae08495 ((@cleanNotation_underlying_real_map_a2d4907a882247d2b335 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) (h))) ((cleanDefine_selected_endpoints_5b3e2429768ac206a5ae ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P))) ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«selection» (P))))))))

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

noncomputable def cleanDefine_certify_pair_data_e3b2e2d1ea91345b889b  (X : TopCat.{0}) (Q : cleanStructure_SpacePairData_f4912a1b453369bfb75e (X)) (h : (((@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«relative» (X) (Q)) ⊆ (@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«ambient» (X) (Q))))) : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X) :=
  (@cleanConstructor_topological_pair_d2eb62bc922cb0af9e3c (X) ((@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«ambient» (X) (Q))) ((@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«relative» (X) (Q))) (h))

noncomputable def cleanDefine_has_pair_data_c2317928d500c075653a  (X : TopCat.{0}) (Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) (S : cleanStructure_SpacePairData_f4912a1b453369bfb75e (X)) : Prop :=
  (((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) (Q)) = (@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«ambient» (X) (S))) ∧ ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) (Q)) = (@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«relative» (X) (S))))

noncomputable def cleanDefine_certify_pair_inclusion_48466e95544d6e5f997e  (X : TopCat.{0}) (S : cleanStructure_SpacePairData_f4912a1b453369bfb75e (X)) (T : cleanStructure_SpacePairData_f4912a1b453369bfb75e (X)) (s : (((@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«relative» (X) (S)) ⊆ (@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«ambient» (X) (S))))) (t : (((@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«relative» (X) (T)) ⊆ (@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«ambient» (X) (T))))) (a : (((@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«ambient» (X) (S)) ⊆ (@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«ambient» (X) (T))))) (b : (((@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«relative» (X) (S)) ⊆ (@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«relative» (X) (T))))) : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X) :=
  (@cleanConstructor_pair_inclusion_4f04d1794c02e12be8a7 (X) ((@cleanDefine_certify_pair_data_e3b2e2d1ea91345b889b (X) (S) (s))) ((@cleanDefine_certify_pair_data_e3b2e2d1ea91345b889b (X) (T) (t))) (a) (b))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/-!
```latex
Write $P=(X,f,(a,b),E)$ for the ambient space, continuous map, endpoints,
and endpoint selection. The selection has four values: none, lower, upper, both.
In the following notation, regard $E$ as its selected subset of $\{a,b\}$.
The expanded pair $X_r(P)$ has components $f^{-1}[a-r,b+r]$ and
$f^{-1}(\bigcup_{e\in E}[e-r,e+r])$.
The shifted pair $T_t(P)$ has components $f^{-1}[a+t,b+t]$ and $f^{-1}(E+t)$.
For a perturbation $h$, $A(P,h)$ has components $h^{-1}[a,b]$ and $h^{-1}(E)$.
Pair inclusion means inclusion of both components. These results establish
set inclusions and certified pair inclusions; they do not assert the well-group characterization.
A certified pair $Q$ represents pair data $S$ when their ambient subsets agree
and their relative subsets agree. A certified inclusion stores the nesting
and both component-inclusion proofs.
```
-/

/--
source: topology
reference: two Boolean endpoint flags
relationship: original
-/
def endpoint_choices_are_exhaustive : Prop :=
  ∀ (E : cleanStructure_EndpointSelection_b1d52148908811c63f1d),
  ((((E = (cleanDefine_no_endpoints_3d2c151be5ddaaa6461f)) ∨ (E = (cleanDefine_lower_endpoint_55a3912dc3794b7cc0b5))) ∨ (E = (cleanDefine_upper_endpoint_17aeb6bb1ab98f7ac7e2))) ∨ (E = (cleanDefine_both_endpoints_9ceafa3c3eae62095b71)))

/--
source: interlevel
reference: setup for Theorem 4
relationship: adapted
scope: endpoint inclusion
-/
def selected_endpoints_lie_in_the_interval : Prop :=
  ∀ (I : cleanStructure_Endpoints_2512a023e0474ce195ac),
  ∀ (E : cleanStructure_EndpointSelection_b1d52148908811c63f1d),
  ∀ («order» : ((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» (I)) ≤ (@cleanStructure_Endpoints_2512a023e0474ce195ac.«upper» (I)))),
  ((cleanDefine_selected_endpoints_5b3e2429768ac206a5ae (I) (E)) ⊆ (cleanDefine_closed_interval_02a80046a44a2fbda8de (I)))

/--
source: interlevel
reference: setup for Theorem 4
relationship: adapted
scope: pair inclusion
-/
def expanded_pair_is_nested : Prop :=
  ∀ (P : cleanStructure_InterlevelProblem_006185c6b0da68de0867),
  ∀ (r : ℝ),
  ∀ («order» : ((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P)))) ≤ (@cleanStructure_Endpoints_2512a023e0474ce195ac.«upper» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P)))))),
  ∀ («radius» : (r ≥ 0)),
  (@cleanDefine_nested_pair_203f27c03de1e4f128ad ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((@cleanDefine_expanded_pair_66873557049e4375bc60 (P) (r))))

/--
source: interlevel
reference: setup for Theorem 4
relationship: adapted
scope: pair inclusion
-/
def shifted_pair_is_nested : Prop :=
  ∀ (P : cleanStructure_InterlevelProblem_006185c6b0da68de0867),
  ∀ (t : ℝ),
  ∀ («order» : ((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P)))) ≤ (@cleanStructure_Endpoints_2512a023e0474ce195ac.«upper» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P)))))),
  (@cleanDefine_nested_pair_203f27c03de1e4f128ad ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((@cleanDefine_shifted_pair_acef58e9c1318b5833c8 (P) (t))))

/--
source: interlevel
reference: setup for Theorem 4
relationship: adapted
scope: all bounded shifts
-/
def shifted_pair_lies_in_expanded_pair : Prop :=
  ∀ (P : cleanStructure_InterlevelProblem_006185c6b0da68de0867),
  ∀ (r t : ℝ),
  ∀ («radius» : (r ≥ 0)),
  ∀ («shift» : (((-r) ≤ t) ∧ (t ≤ r))),
  (@cleanDefine_pair_included_in_93a3c208a27e390549af ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((@cleanDefine_shifted_pair_acef58e9c1318b5833c8 (P) (t))) ((@cleanDefine_expanded_pair_66873557049e4375bc60 (P) (r))))

/--
source: interlevel
reference: definition of perturbation pairs
relationship: adapted
scope: pair inclusion
-/
def perturbed_pair_is_nested : Prop :=
  ∀ (P : cleanStructure_InterlevelProblem_006185c6b0da68de0867),
  ∀ (h : (@ContinuousMap (@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)).carrier ℝ (@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)).str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)),
  ∀ («order» : ((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P)))) ≤ (@cleanStructure_Endpoints_2512a023e0474ce195ac.«upper» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P)))))),
  (@cleanDefine_nested_pair_203f27c03de1e4f128ad ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((@cleanDefine_perturbed_pair_8a139afee8bcd7a01090 (P) (h))))

/--
source: interlevel
reference: definition of relative well groups
relationship: adapted
scope: pair inclusion
-/
def bounded_perturbation_lies_in_expanded_pair : Prop :=
  ∀ (P : cleanStructure_InterlevelProblem_006185c6b0da68de0867),
  ∀ (h : (@ContinuousMap (@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)).carrier ℝ (@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)).str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)),
  ∀ (r : ℝ),
  ∀ («radius» : (r ≥ 0)),
  ∀ («bounded_perturbation_u28_P_u2c__h_u2c__r_u29_» : (@cleanDefine_bounded_perturbation_f5d5b63290c0e028ea34 (P) (h) (r))),
  (@cleanDefine_pair_included_in_93a3c208a27e390549af ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((@cleanDefine_perturbed_pair_8a139afee8bcd7a01090 (P) (h))) ((@cleanDefine_expanded_pair_66873557049e4375bc60 (P) (r))))

/--
source: topology
reference: certified expanded pair
relationship: original
-/
def expanded_pair_has_a_certificate : Prop :=
  ∀ (P : cleanStructure_InterlevelProblem_006185c6b0da68de0867),
  ∀ (r : ℝ),
  ∀ («order» : ((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P)))) ≤ (@cleanStructure_Endpoints_2512a023e0474ce195ac.«upper» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P)))))),
  ∀ («radius» : (r ≥ 0)),
  let T : cleanStructure_SpacePairData_f4912a1b453369bfb75e ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) := (@cleanDefine_expanded_pair_66873557049e4375bc60 (P) (r));
  (@Exists (cleanStructure_TopologicalPair_23a951172729bcd7e2a9 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)))) (fun (clean_bound_0 : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)))) => (@cleanDefine_has_pair_data_c2317928d500c075653a ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) (clean_bound_0) (T))))

/--
source: interlevel
reference: setup for Theorem 4
relationship: adapted
scope: certified inclusion
-/
def bounded_shift_has_a_certified_inclusion : Prop :=
  ∀ (P : cleanStructure_InterlevelProblem_006185c6b0da68de0867),
  ∀ (r t : ℝ),
  ∀ («order» : ((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P)))) ≤ (@cleanStructure_Endpoints_2512a023e0474ce195ac.«upper» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P)))))),
  ∀ («radius» : (r ≥ 0)),
  ∀ («shift» : (((-r) ≤ t) ∧ (t ≤ r))),
  let S : cleanStructure_SpacePairData_f4912a1b453369bfb75e ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) := (@cleanDefine_shifted_pair_acef58e9c1318b5833c8 (P) (t));
  let T : cleanStructure_SpacePairData_f4912a1b453369bfb75e ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) := (@cleanDefine_expanded_pair_66873557049e4375bc60 (P) (r));
  (@Exists (cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)))) (fun (clean_bound_0 : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)))) => ((@cleanDefine_has_pair_data_c2317928d500c075653a ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) (clean_bound_0))) (S)) ∧ (@cleanDefine_has_pair_data_c2317928d500c075653a ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) (clean_bound_0))) (T)))))

/--
source: interlevel
reference: definition of relative well groups
relationship: adapted
scope: certified inclusion
-/
def bounded_perturbation_has_a_certified_inclusion : Prop :=
  ∀ (P : cleanStructure_InterlevelProblem_006185c6b0da68de0867),
  ∀ (h : (@ContinuousMap (@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)).carrier ℝ (@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)).str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)),
  ∀ (r : ℝ),
  ∀ («order» : ((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P)))) ≤ (@cleanStructure_Endpoints_2512a023e0474ce195ac.«upper» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«interval» (P)))))),
  ∀ («radius» : (r ≥ 0)),
  ∀ («bounded_perturbation_u28_P_u2c__h_u2c__r_u29_» : (@cleanDefine_bounded_perturbation_f5d5b63290c0e028ea34 (P) (h) (r))),
  let S : cleanStructure_SpacePairData_f4912a1b453369bfb75e ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) := (@cleanDefine_perturbed_pair_8a139afee8bcd7a01090 (P) (h));
  let T : cleanStructure_SpacePairData_f4912a1b453369bfb75e ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) := (@cleanDefine_expanded_pair_66873557049e4375bc60 (P) (r));
  (@Exists (cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)))) (fun (clean_bound_0 : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P)))) => ((@cleanDefine_has_pair_data_c2317928d500c075653a ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) (clean_bound_0))) (S)) ∧ (@cleanDefine_has_pair_data_c2317928d500c075653a ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» ((@cleanStructure_InterlevelProblem_006185c6b0da68de0867.«space» (P))) (clean_bound_0))) (T)))))

/--
source: topology
reference: certified pair constructor
relationship: original
-/
def certification_preserves_pair_data : Prop :=
  ∀ (X : TopCat.{0}),
  ∀ (S : cleanStructure_SpacePairData_f4912a1b453369bfb75e (X)),
  ∀ («nesting» : ((@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«relative» (X) (S)) ⊆ (@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«ambient» (X) (S)))),
  (@cleanDefine_has_pair_data_c2317928d500c075653a (X) ((@cleanDefine_certify_pair_data_e3b2e2d1ea91345b889b (X) (S) («nesting»))) (S))

/--
source: topology
reference: certified inclusion constructor
relationship: original
-/
def certification_preserves_inclusion_data : Prop :=
  ∀ (X : TopCat.{0}),
  ∀ (S T : cleanStructure_SpacePairData_f4912a1b453369bfb75e (X)),
  ∀ («source» : ((@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«relative» (X) (S)) ⊆ (@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«ambient» (X) (S)))),
  ∀ («target» : ((@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«relative» (X) (T)) ⊆ (@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«ambient» (X) (T)))),
  ∀ («ambient» : ((@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«ambient» (X) (S)) ⊆ (@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«ambient» (X) (T)))),
  ∀ («relative» : ((@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«relative» (X) (S)) ⊆ (@cleanStructure_SpacePairData_f4912a1b453369bfb75e.«relative» (X) (T)))),
  let Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X) := (@cleanDefine_certify_pair_inclusion_48466e95544d6e5f997e (X) (S) (T) («source») («target») («ambient») («relative»));
  ((@cleanDefine_has_pair_data_c2317928d500c075653a (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))) (S)) ∧ (@cleanDefine_has_pair_data_c2317928d500c075653a (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))) (T)))

end CleanStatements

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `InterlevelOracle.Ends then return `cleanStructure_Endpoints_2512a023e0474ce195ac
  if n == `InterlevelOracle.Selection then return `cleanStructure_EndpointSelection_b1d52148908811c63f1d
  if n == `InterlevelOracle.Problem then return `cleanStructure_InterlevelProblem_006185c6b0da68de0867
  if n == `InterlevelOracle.Pair then return `cleanStructure_SpacePairData_f4912a1b453369bfb75e
  if n == `InterlevelOracle.boolType then return `cleanType_Boolean_b98a4c98fcdb0f46359e
  if n == `InterlevelOracle.realMapType then return `cleanType_ContinuousRealMap_61be08a900d37dad3fed
  if n == `InterlevelOracle.yes then return `cleanNotation_true_value_2fd5fc223c8905693b89
  if n == `InterlevelOracle.no then return `cleanNotation_false_value_d4e3155033dd79d1d53f
  if n == `InterlevelOracle.ends then return `cleanConstructor_endpoints_ae57156441e5057814f6
  if n == `InterlevelOracle.shift then return `cleanDefine_shifted_endpoints_0341e7d28e14c6ec5711
  if n == `InterlevelOracle.selection then return `cleanConstructor_endpoint_selection_e2c76e8a24faf36bd69d
  if n == `InterlevelOracle.neither then return `cleanDefine_no_endpoints_3d2c151be5ddaaa6461f
  if n == `InterlevelOracle.lowerOnly then return `cleanDefine_lower_endpoint_55a3912dc3794b7cc0b5
  if n == `InterlevelOracle.upperOnly then return `cleanDefine_upper_endpoint_17aeb6bb1ab98f7ac7e2
  if n == `InterlevelOracle.both then return `cleanDefine_both_endpoints_9ceafa3c3eae62095b71
  if n == `InterlevelOracle.setOf then return `cleanNotation_set_of_25534029a1fdae044ce8
  if n == `InterlevelOracle.preimage then return `cleanDefine_inverse_image_b2385c49c1629ae08495
  if n == `InterlevelOracle.underlying then return `cleanNotation_underlying_real_map_a2d4907a882247d2b335
  if n == `InterlevelOracle.closed then return `cleanDefine_closed_interval_02a80046a44a2fbda8de
  if n == `InterlevelOracle.selected then return `cleanDefine_selected_endpoints_5b3e2429768ac206a5ae
  if n == `InterlevelOracle.expanded then return `cleanDefine_expanded_interval_c25cb2a7d138e802a0ed
  if n == `InterlevelOracle.boundary then return `cleanDefine_expanded_endpoints_246c1c1637936ba4cace
  if n == `InterlevelOracle.problem then return `cleanConstructor_interlevel_problem_42723c03a4cce7c0a1ff
  if n == `InterlevelOracle.pair then return `cleanConstructor_space_pair_data_d4663b2e361ad8703041
  if n == `InterlevelOracle.nested then return `cleanDefine_nested_pair_203f27c03de1e4f128ad
  if n == `InterlevelOracle.expandedPair then return `cleanDefine_expanded_pair_66873557049e4375bc60
  if n == `InterlevelOracle.shiftedPair then return `cleanDefine_shifted_pair_acef58e9c1318b5833c8
  if n == `InterlevelOracle.included then return `cleanDefine_pair_included_in_93a3c208a27e390549af
  if n == `InterlevelOracle.evaluate then return `cleanNotation_evaluate_map_fc8e4f20170606ffe807
  if n == `InterlevelOracle.value then return `cleanDefine_real_map_value_1c81a8738f0927d4f859
  if n == `InterlevelOracle.bounded then return `cleanDefine_bounded_perturbation_f5d5b63290c0e028ea34
  if n == `InterlevelOracle.perturbed then return `cleanDefine_perturbed_pair_8a139afee8bcd7a01090
  if n == `InterlevelOracle.certify then return `cleanDefine_certify_pair_data_e3b2e2d1ea91345b889b
  if n == `InterlevelOracle.represents then return `cleanDefine_has_pair_data_c2317928d500c075653a
  if n == `InterlevelOracle.certifyInclusion then return `cleanDefine_certify_pair_inclusion_48466e95544d6e5f997e
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

namespace InterlevelOracle
noncomputable def boolType : Type := Bool
noncomputable def yes : Bool := true
noncomputable def no : Bool := false
structure Ends : Type where
  lower : ℝ
  upper : ℝ
noncomputable def ends (lower upper : ℝ) : Ends := @Ends.mk lower upper
noncomputable def shift (I : Ends) (s : ℝ) : Ends := @ends (I.lower+s) (I.upper+s)
structure Selection : Type where
  lower : Bool
  upper : Bool
noncomputable def selection (lower upper : Bool) : Selection := @Selection.mk lower upper
noncomputable def neither : Selection := @selection no no
noncomputable def lowerOnly : Selection := @selection yes no
noncomputable def upperOnly : Selection := @selection no yes
noncomputable def both : Selection := @selection yes yes
noncomputable def setOf {X : Type} (condition : X → Prop) : Set X := _root_.setOf condition
noncomputable def preimage {X Y : Type} (f : X → Y) (S : Set Y) : Set X := setOf (fun x : X => f x ∈ S)
noncomputable def realMapType (X : TopCat.{0}) : Type :=
  @ContinuousMap X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace
noncomputable def underlying (X : TopCat.{0})
  (f : @ContinuousMap X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace) : X.carrier → ℝ :=
  @ContinuousMap.toFun X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace f
noncomputable def closed (I : Ends) : Set ℝ := setOf (fun x : ℝ => I.lower ≤ x ∧ x ≤ I.upper)
noncomputable def selected (I : Ends) (E : Selection) : Set ℝ :=
  setOf (fun x : ℝ => (E.lower=yes ∧ x=I.lower) ∨ (E.upper=yes ∧ x=I.upper))
noncomputable def expanded (I : Ends) (r : ℝ) : Set ℝ := setOf (fun x : ℝ => I.lower-r ≤ x ∧ x ≤ I.upper+r)
noncomputable def boundary (I : Ends) (E : Selection) (r : ℝ) : Set ℝ :=
  setOf (fun x : ℝ => ((E.lower=yes ∧ I.lower-r ≤ x) ∧ x ≤ I.lower+r) ∨
                     ((E.upper=yes ∧ I.upper-r ≤ x) ∧ x ≤ I.upper+r))
structure Problem : Type 1 where
  space : TopCat.{0}
  map : @ContinuousMap space.carrier ℝ space.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace
  interval : Ends
  selection : Selection
noncomputable def problem (space : TopCat.{0})
  (map : @ContinuousMap space.carrier ℝ space.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)
  (interval : Ends) (selection : Selection) : Problem := @Problem.mk space map interval selection
structure Pair (X : TopCat.{0}) : Type where
  ambient : Set X.carrier
  relative : Set X.carrier
noncomputable def pair (X : TopCat.{0}) (ambient relative : Set X.carrier) : Pair X := @Pair.mk X ambient relative
noncomputable def nested (X : TopCat.{0}) (Q : Pair X) : Prop := Q.relative ⊆ Q.ambient
noncomputable def expandedPair (P : Problem) (r : ℝ) : Pair P.space :=
  @pair P.space (preimage (@underlying P.space P.map) (expanded P.interval r))
               (preimage (@underlying P.space P.map) (boundary P.interval P.selection r))
noncomputable def shiftedPair (P : Problem) (t : ℝ) : Pair P.space :=
  @pair P.space (preimage (@underlying P.space P.map) (closed (shift P.interval t)))
               (preimage (@underlying P.space P.map) (selected (shift P.interval t) P.selection))
noncomputable def included (X : TopCat.{0}) (Q R : Pair X) : Prop :=
  Q.ambient ⊆ R.ambient ∧ Q.relative ⊆ R.relative

noncomputable def evaluate {X Y : Type} (f : X → Y) (x : X) : Y := f x
noncomputable def value (X : TopCat.{0})
  (f : @ContinuousMap X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace) (x : X.carrier) : ℝ :=
  evaluate (@underlying X f) x
noncomputable def bounded (P : Problem)
  (h : @ContinuousMap P.space.carrier ℝ P.space.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace) (r : ℝ) : Prop :=
  ∀ x : P.space.carrier, -r ≤ @value P.space h x - @value P.space P.map x ∧
    @value P.space h x - @value P.space P.map x ≤ r
noncomputable def perturbed (P : Problem)
  (h : @ContinuousMap P.space.carrier ℝ P.space.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace) : Pair P.space :=
  @pair P.space (preimage (@underlying P.space h) (closed P.interval))
               (preimage (@underlying P.space h) (selected P.interval P.selection))

def choicesStatement : Prop := ∀ E : Selection, ((E=neither ∨ E=lowerOnly) ∨ E=upperOnly) ∨ E=both
def endpointsStatement : Prop := ∀ (I : Ends) (E : Selection), I.lower ≤ I.upper → selected I E ⊆ closed I
def expandedStatement : Prop := ∀ (P : Problem) (r : ℝ), P.interval.lower ≤ P.interval.upper → r ≥ 0 →
  @nested P.space (@expandedPair P r)
def shiftedStatement : Prop := ∀ (P : Problem) (t : ℝ), P.interval.lower ≤ P.interval.upper →
  @nested P.space (@shiftedPair P t)
def inclusionStatement : Prop := ∀ (P : Problem) (r t : ℝ), r ≥ 0 → (-r ≤ t ∧ t ≤ r) →
  @included P.space (@shiftedPair P t) (@expandedPair P r)
def perturbedStatement : Prop := ∀ (P : Problem)
  (h : @ContinuousMap P.space.carrier ℝ P.space.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace),
  P.interval.lower ≤ P.interval.upper → @nested P.space (@perturbed P h)
def boundedStatement : Prop := ∀ (P : Problem)
  (h : @ContinuousMap P.space.carrier ℝ P.space.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace) (r : ℝ),
  r ≥ 0 → @bounded P h r → @included P.space (@perturbed P h) (@expandedPair P r)
noncomputable def certify (X : TopCat.{0}) (Q : Pair X) (h : Q.relative ⊆ Q.ambient) : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X :=
  @cleanConstructor_topological_pair_d2eb62bc922cb0af9e3c X Q.ambient Q.relative h
noncomputable def certifyInclusion (X : TopCat.{0}) (S T : Pair X)
  (s : S.relative ⊆ S.ambient) (t : T.relative ⊆ T.ambient)
  (a : S.ambient ⊆ T.ambient) (b : S.relative ⊆ T.relative) : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 X :=
  @cleanConstructor_pair_inclusion_4f04d1794c02e12be8a7 X (@certify X S s) (@certify X T t) a b
noncomputable def represents (X : TopCat.{0}) (Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X) (S : Pair X) : Prop :=
  Q.ambient=S.ambient ∧ Q.relative=S.relative
def certifiedExpandedStatement : Prop := ∀ (P : Problem) (r : ℝ),
  P.interval.lower ≤ P.interval.upper → r ≥ 0 →
  let T : Pair P.space := @expandedPair P r;
  ∃ Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 P.space, @represents P.space Q T
def certifiedShiftStatement : Prop := ∀ (P : Problem) (r t : ℝ),
  P.interval.lower ≤ P.interval.upper → r ≥ 0 → (-r ≤ t ∧ t ≤ r) →
  let S : Pair P.space := @shiftedPair P t;
  let T : Pair P.space := @expandedPair P r;
  ∃ Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 P.space,
    @represents P.space Q.source S ∧ @represents P.space Q.target T
def certifiedPerturbationStatement : Prop := ∀ (P : Problem)
  (h : @ContinuousMap P.space.carrier ℝ P.space.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace) (r : ℝ),
  P.interval.lower ≤ P.interval.upper → r ≥ 0 → @bounded P h r →
  let S : Pair P.space := @perturbed P h;
  let T : Pair P.space := @expandedPair P r;
  ∃ Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 P.space,
    @represents P.space Q.source S ∧ @represents P.space Q.target T

def certifyStatement : Prop := ∀ (X : TopCat.{0}) (S : Pair X) (h : S.relative ⊆ S.ambient),
  @represents X (@certify X S h) S
def certifyInclusionStatement : Prop := ∀ (X : TopCat.{0}) (S T : Pair X)
  (s : S.relative ⊆ S.ambient) (t : T.relative ⊆ T.ambient)
  (a : S.ambient ⊆ T.ambient) (b : S.relative ⊆ T.relative),
  let Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 X := @certifyInclusion X S T s t a b;
  @represents X Q.source S ∧ @represents X Q.target T
end InterlevelOracle
same_target cleanStructure_Endpoints_2512a023e0474ce195ac InterlevelOracle.Ends
same_target cleanStructure_EndpointSelection_b1d52148908811c63f1d InterlevelOracle.Selection
same_target cleanStructure_InterlevelProblem_006185c6b0da68de0867 InterlevelOracle.Problem
same_target cleanStructure_SpacePairData_f4912a1b453369bfb75e InterlevelOracle.Pair
same_target cleanType_Boolean_b98a4c98fcdb0f46359e InterlevelOracle.boolType
same_target cleanType_ContinuousRealMap_61be08a900d37dad3fed InterlevelOracle.realMapType
same_target cleanNotation_true_value_2fd5fc223c8905693b89 InterlevelOracle.yes
same_target cleanNotation_false_value_d4e3155033dd79d1d53f InterlevelOracle.no
same_target cleanConstructor_endpoints_ae57156441e5057814f6 InterlevelOracle.ends
same_target cleanDefine_shifted_endpoints_0341e7d28e14c6ec5711 InterlevelOracle.shift
same_target cleanConstructor_endpoint_selection_e2c76e8a24faf36bd69d InterlevelOracle.selection
same_target cleanDefine_no_endpoints_3d2c151be5ddaaa6461f InterlevelOracle.neither
same_target cleanDefine_lower_endpoint_55a3912dc3794b7cc0b5 InterlevelOracle.lowerOnly
same_target cleanDefine_upper_endpoint_17aeb6bb1ab98f7ac7e2 InterlevelOracle.upperOnly
same_target cleanDefine_both_endpoints_9ceafa3c3eae62095b71 InterlevelOracle.both
same_target cleanNotation_set_of_25534029a1fdae044ce8 InterlevelOracle.setOf
same_target cleanDefine_inverse_image_b2385c49c1629ae08495 InterlevelOracle.preimage
same_target cleanNotation_underlying_real_map_a2d4907a882247d2b335 InterlevelOracle.underlying
same_target cleanDefine_closed_interval_02a80046a44a2fbda8de InterlevelOracle.closed
same_target cleanDefine_selected_endpoints_5b3e2429768ac206a5ae InterlevelOracle.selected
same_target cleanDefine_expanded_interval_c25cb2a7d138e802a0ed InterlevelOracle.expanded
same_target cleanDefine_expanded_endpoints_246c1c1637936ba4cace InterlevelOracle.boundary
same_target cleanConstructor_interlevel_problem_42723c03a4cce7c0a1ff InterlevelOracle.problem
same_target cleanConstructor_space_pair_data_d4663b2e361ad8703041 InterlevelOracle.pair
same_target cleanDefine_nested_pair_203f27c03de1e4f128ad InterlevelOracle.nested
same_target cleanDefine_expanded_pair_66873557049e4375bc60 InterlevelOracle.expandedPair
same_target cleanDefine_shifted_pair_acef58e9c1318b5833c8 InterlevelOracle.shiftedPair
same_target cleanDefine_pair_included_in_93a3c208a27e390549af InterlevelOracle.included
same_target cleanNotation_evaluate_map_fc8e4f20170606ffe807 InterlevelOracle.evaluate
same_target cleanDefine_real_map_value_1c81a8738f0927d4f859 InterlevelOracle.value
same_target cleanDefine_bounded_perturbation_f5d5b63290c0e028ea34 InterlevelOracle.bounded
same_target cleanDefine_perturbed_pair_8a139afee8bcd7a01090 InterlevelOracle.perturbed
same_target cleanDefine_certify_pair_data_e3b2e2d1ea91345b889b InterlevelOracle.certify
same_target cleanDefine_has_pair_data_c2317928d500c075653a InterlevelOracle.represents
same_target cleanDefine_certify_pair_inclusion_48466e95544d6e5f997e InterlevelOracle.certifyInclusion
same_target cleanStructure_Endpoints_2512a023e0474ce195ac.mk InterlevelOracle.Ends.mk
same_target cleanStructure_Endpoints_2512a023e0474ce195ac.lower InterlevelOracle.Ends.lower
same_target cleanStructure_Endpoints_2512a023e0474ce195ac.upper InterlevelOracle.Ends.upper
same_target cleanStructure_EndpointSelection_b1d52148908811c63f1d.mk InterlevelOracle.Selection.mk
same_target cleanStructure_EndpointSelection_b1d52148908811c63f1d.lower InterlevelOracle.Selection.lower
same_target cleanStructure_EndpointSelection_b1d52148908811c63f1d.upper InterlevelOracle.Selection.upper
same_target cleanStructure_InterlevelProblem_006185c6b0da68de0867.mk InterlevelOracle.Problem.mk
same_target cleanStructure_InterlevelProblem_006185c6b0da68de0867.space InterlevelOracle.Problem.space
same_target cleanStructure_InterlevelProblem_006185c6b0da68de0867.map InterlevelOracle.Problem.map
same_target cleanStructure_InterlevelProblem_006185c6b0da68de0867.interval InterlevelOracle.Problem.interval
same_target cleanStructure_InterlevelProblem_006185c6b0da68de0867.selection InterlevelOracle.Problem.selection
same_target cleanStructure_SpacePairData_f4912a1b453369bfb75e.mk InterlevelOracle.Pair.mk
same_target cleanStructure_SpacePairData_f4912a1b453369bfb75e.ambient InterlevelOracle.Pair.ambient
same_target cleanStructure_SpacePairData_f4912a1b453369bfb75e.relative InterlevelOracle.Pair.relative
same_target CleanStatements.endpoint_choices_are_exhaustive InterlevelOracle.choicesStatement
same_target CleanStatements.selected_endpoints_lie_in_the_interval InterlevelOracle.endpointsStatement
same_target CleanStatements.expanded_pair_is_nested InterlevelOracle.expandedStatement
same_target CleanStatements.shifted_pair_is_nested InterlevelOracle.shiftedStatement
same_target CleanStatements.shifted_pair_lies_in_expanded_pair InterlevelOracle.inclusionStatement
same_target CleanStatements.perturbed_pair_is_nested InterlevelOracle.perturbedStatement
same_target CleanStatements.bounded_perturbation_lies_in_expanded_pair InterlevelOracle.boundedStatement
same_target CleanStatements.expanded_pair_has_a_certificate InterlevelOracle.certifiedExpandedStatement
same_target CleanStatements.bounded_shift_has_a_certified_inclusion InterlevelOracle.certifiedShiftStatement
same_target CleanStatements.bounded_perturbation_has_a_certified_inclusion InterlevelOracle.certifiedPerturbationStatement
same_target CleanStatements.certification_preserves_pair_data InterlevelOracle.certifyStatement
same_target CleanStatements.certification_preserves_inclusion_data InterlevelOracle.certifyInclusionStatement

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
  let T := cleanDefine_expanded_pair_66873557049e4375bc60 P r
  refine ⟨⟨T.ambient,T.relative,?_⟩,rfl,rfl⟩
  exact expanded_pair_is_nested P r ho hr

theorem bounded_shift_has_a_certified_inclusion : CleanStatements.bounded_shift_has_a_certified_inclusion := by
  intro P r t ho hr ht
  let S := cleanDefine_shifted_pair_acef58e9c1318b5833c8 P t
  let T := cleanDefine_expanded_pair_66873557049e4375bc60 P r
  have hs := shifted_pair_is_nested P t ho
  have ht' := expanded_pair_is_nested P r ho hr
  have hi := shifted_pair_lies_in_expanded_pair P r t hr ht
  refine ⟨⟨⟨S.ambient,S.relative,hs⟩,⟨T.ambient,T.relative,ht'⟩,hi.1,hi.2⟩,?_⟩
  exact ⟨⟨rfl,rfl⟩,⟨rfl,rfl⟩⟩

theorem bounded_perturbation_has_a_certified_inclusion : CleanStatements.bounded_perturbation_has_a_certified_inclusion := by
  intro P h r ho hr hb
  let S := cleanDefine_perturbed_pair_8a139afee8bcd7a01090 P h
  let T := cleanDefine_expanded_pair_66873557049e4375bc60 P r
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

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
