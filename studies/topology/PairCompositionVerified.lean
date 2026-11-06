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

noncomputable def cleanNotation_equality_congruence_3e3f32efa32223213c0e {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) (y : X) (h : ((x = y))) : (((f x) = (f y))) :=
  congrArg f h

noncomputable def cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db {X : Type} (x : X) : ((x = x)) :=
  Eq.refl x

noncomputable def cleanNotation_subset_reflexivity_5ebc9817a9ee3f43d7f0 {X : Type} (S : Set (X)) : ((S ⊆ S)) :=
  Set.Subset.refl S

noncomputable def cleanNotation_subset_transitivity_fa31d5e4c61a19d8595c {X : Type} (S : Set (X)) (T : Set (X)) (U : Set (X)) (h : ((S ⊆ T))) (k : ((T ⊆ U))) : ((S ⊆ U)) :=
  Set.Subset.trans h k

noncomputable def cleanNotation_replace_subset_target_8b4e7788eded91cdaaa5 {X : Type} (S : Set (X)) (T : Set (X)) (U : Set (X)) (h : ((S ⊆ T))) (e : ((T = U))) : ((S ⊆ U)) :=
  @Eq.rec (Set X) T (fun V _ => S ⊆ V) h U e

noncomputable def cleanDefine_pair_ambient_equality_5648e040d11d9fdd25c5  (X : TopCat.{0}) (P : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) (Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) (h : ((P = Q))) : (((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) (P)) = (@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) (Q)))) :=
  (@cleanNotation_equality_congruence_3e3f32efa32223213c0e (cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) (Set ((TopCat.carrier X))) ((fun (clean_bound_0 : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) => (@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) (clean_bound_0)))) (P) (Q) (h))

noncomputable def cleanDefine_pair_relative_equality_ff40802276b5bb327e8b  (X : TopCat.{0}) (P : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) (Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) (h : ((P = Q))) : (((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) (P)) = (@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) (Q)))) :=
  (@cleanNotation_equality_congruence_3e3f32efa32223213c0e (cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) (Set ((TopCat.carrier X))) ((fun (clean_bound_0 : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) => (@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) (clean_bound_0)))) (P) (Q) (h))

noncomputable def cleanDefine_identity_pair_inclusion_73485ba729e3e7c1bcd4  (X : TopCat.{0}) (P : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X) :=
  (@cleanConstructor_pair_inclusion_4f04d1794c02e12be8a7 (X) (P) (P) ((@cleanNotation_subset_reflexivity_5ebc9817a9ee3f43d7f0 ((TopCat.carrier X)) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) (P))))) ((@cleanNotation_subset_reflexivity_5ebc9817a9ee3f43d7f0 ((TopCat.carrier X)) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) (P))))))

noncomputable def cleanDefine_compose_pair_inclusions_71f3b4369fe55ba0cb47  (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) (R : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)) (middle : (((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)) = (@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (R))))) : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X) :=
  (@cleanConstructor_pair_inclusion_4f04d1794c02e12be8a7 (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (R))) ((@cleanNotation_subset_transitivity_fa31d5e4c61a19d8595c ((TopCat.carrier X)) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (R))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (R))))) ((@cleanNotation_replace_subset_target_8b4e7788eded91cdaaa5 ((TopCat.carrier X)) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (R))))) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«ambient» (X) (Q))) ((@cleanDefine_pair_ambient_equality_5648e040d11d9fdd25c5 (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (R))) (middle))))) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«ambient» (X) (R))))) ((@cleanNotation_subset_transitivity_fa31d5e4c61a19d8595c ((TopCat.carrier X)) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (R))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (R))))) ((@cleanNotation_replace_subset_target_8b4e7788eded91cdaaa5 ((TopCat.carrier X)) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (R))))) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«relative» (X) (Q))) ((@cleanDefine_pair_relative_equality_ff40802276b5bb327e8b (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (R))) (middle))))) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«relative» (X) (R))))))


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
  ∀ (X : TopCat.{0}),
  ∀ (P : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)),
  ((P = P) ∧ (P = P))

/--
source: topology
reference: composition of inclusions of pairs
relationship: original
-/
def composed_pair_endpoints : Prop :=
  ∀ (X : TopCat.{0}),
  ∀ (Q R : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)),
  ∀ («middle» : ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)) = (@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (R)))),
  (((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q)) = (@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))) ∧ ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (R)) = (@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (R))))

/--
source: topology
reference: source identity law for inclusions
relationship: original
-/
def pair_source_identity : Prop :=
  ∀ (X : TopCat.{0}),
  ∀ (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)),
  ((@cleanDefine_compose_pair_inclusions_71f3b4369fe55ba0cb47 (X) ((@cleanDefine_identity_pair_inclusion_73485ba729e3e7c1bcd4 (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q))))) (Q) ((@cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (Q)))))) = Q)

/--
source: topology
reference: target identity law for inclusions
relationship: original
-/
def pair_target_identity : Prop :=
  ∀ (X : TopCat.{0}),
  ∀ (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)),
  ((@cleanDefine_compose_pair_inclusions_71f3b4369fe55ba0cb47 (X) (Q) ((@cleanDefine_identity_pair_inclusion_73485ba729e3e7c1bcd4 (X) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q))))) ((@cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)) ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)))))) = Q)

/--
source: topology
reference: associativity of inclusions
relationship: original
-/
def pair_composition_associativity : Prop :=
  ∀ (X : TopCat.{0}),
  ∀ (Q R S : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 (X)),
  ∀ («first» : ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (Q)) = (@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (R)))),
  ∀ («second» : ((@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«target» (X) (R)) = (@cleanStructure_PairInclusion_c88eb06ea5a6180d62a3.«source» (X) (S)))),
  ((@cleanDefine_compose_pair_inclusions_71f3b4369fe55ba0cb47 (X) ((@cleanDefine_compose_pair_inclusions_71f3b4369fe55ba0cb47 (X) (Q) (R) («first»))) (S) («second»)) = (@cleanDefine_compose_pair_inclusions_71f3b4369fe55ba0cb47 (X) (Q) ((@cleanDefine_compose_pair_inclusions_71f3b4369fe55ba0cb47 (X) (R) (S) («second»))) («first»)))

/--
source: topology
reference: underlying maps of identity inclusions
relationship: original
-/
def identity_pair_continuous_maps : Prop :=
  ∀ (X : TopCat.{0}),
  ∀ (P : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 (X)),
  (((@cleanDefine_ambient_continuous_map_8847accc2cf96844c6cb (X) ((@cleanDefine_identity_pair_inclusion_73485ba729e3e7c1bcd4 (X) (P)))) = (@cleanNotation_identity_continuous_map_315ac9c43278079f1ecf ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«ambient» (X) (P))))))) ∧ ((@cleanDefine_relative_continuous_map_9ee2cb50fac73bd8824e (X) ((@cleanDefine_identity_pair_inclusion_73485ba729e3e7c1bcd4 (X) (P)))) = (@cleanNotation_identity_continuous_map_315ac9c43278079f1ecf ((@cleanNotation_subspace_4d29dc4d5e65a0cd314c (X) ((@cleanStructure_TopologicalPair_23a951172729bcd7e2a9.«relative» (X) (P))))))))

end CleanStatements

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `PairCompositionOracle.congruence then return `cleanNotation_equality_congruence_3e3f32efa32223213c0e
  if n == `PairCompositionOracle.reflexivity then return `cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db
  if n == `PairCompositionOracle.subsetRefl then return `cleanNotation_subset_reflexivity_5ebc9817a9ee3f43d7f0
  if n == `PairCompositionOracle.subsetTrans then return `cleanNotation_subset_transitivity_fa31d5e4c61a19d8595c
  if n == `PairCompositionOracle.replaceTarget then return `cleanNotation_replace_subset_target_8b4e7788eded91cdaaa5
  if n == `PairCompositionOracle.ambientEq then return `cleanDefine_pair_ambient_equality_5648e040d11d9fdd25c5
  if n == `PairCompositionOracle.relativeEq then return `cleanDefine_pair_relative_equality_ff40802276b5bb327e8b
  if n == `PairCompositionOracle.identity then return `cleanDefine_identity_pair_inclusion_73485ba729e3e7c1bcd4
  if n == `PairCompositionOracle.compose then return `cleanDefine_compose_pair_inclusions_71f3b4369fe55ba0cb47
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
noncomputable def congruence {X Y : Type} (f : X → Y) (x y : X) (h : x=y) : f x=f y := congrArg f h
noncomputable def reflexivity {X : Type} (x : X) : x=x := Eq.refl x
noncomputable def subsetRefl {X : Type} (S : Set X) : S ⊆ S := Set.Subset.refl S
noncomputable def subsetTrans {X : Type} (S T U : Set X) (h : S ⊆ T) (k : T ⊆ U) : S ⊆ U := Set.Subset.trans h k
noncomputable def replaceTarget {X : Type} (S T U : Set X) (h : S ⊆ T) (e : T=U) : S ⊆ U :=
  @Eq.rec (Set X) T (fun V _ => S ⊆ V) h U e
noncomputable def ambientEq (X : TopCat.{0}) (P Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X) (h : P=Q) : P.ambient=Q.ambient :=
  @congruence (cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X) (Set X.carrier) (fun T : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X => T.ambient) P Q h
noncomputable def relativeEq (X : TopCat.{0}) (P Q : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X) (h : P=Q) : P.relative=Q.relative :=
  @congruence (cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X) (Set X.carrier) (fun T : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X => T.relative) P Q h
noncomputable def identity (X : TopCat.{0}) (P : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X) : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 X :=
  @cleanConstructor_pair_inclusion_4f04d1794c02e12be8a7 X P P (@subsetRefl X.carrier P.ambient) (@subsetRefl X.carrier P.relative)
noncomputable def compose (X : TopCat.{0}) (Q R : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 X) (middle : Q.target=R.source) : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 X :=
  @cleanConstructor_pair_inclusion_4f04d1794c02e12be8a7 X Q.source R.target
    (@subsetTrans X.carrier Q.source.ambient R.source.ambient R.target.ambient
      (@replaceTarget X.carrier Q.source.ambient Q.target.ambient R.source.ambient Q.ambient
        (@ambientEq X Q.target R.source middle)) R.ambient)
    (@subsetTrans X.carrier Q.source.relative R.source.relative R.target.relative
      (@replaceTarget X.carrier Q.source.relative Q.target.relative R.source.relative Q.relative
        (@relativeEq X Q.target R.source middle)) R.relative)
def identityEndpoints : Prop := ∀ (X : TopCat.{0}) (P : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X), P=P ∧ P=P
def compositionEndpoints : Prop := ∀ (X : TopCat.{0}) (Q R : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 X), Q.target=R.source →
  Q.source=Q.source ∧ R.target=R.target
def sourceIdentity : Prop := ∀ (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 X),
  @compose X (@identity X Q.source) Q (@reflexivity (cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X) Q.source) = Q
def targetIdentity : Prop := ∀ (X : TopCat.{0}) (Q : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 X),
  @compose X Q (@identity X Q.target) (@reflexivity (cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X) Q.target) = Q
def associativity : Prop := ∀ (X : TopCat.{0}) (Q R S : cleanStructure_PairInclusion_c88eb06ea5a6180d62a3 X)
  (first : Q.target=R.source) (second : R.target=S.source),
  @compose X (@compose X Q R first) S second = @compose X Q (@compose X R S second) first
def continuousIdentity : Prop := ∀ (X : TopCat.{0}) (P : cleanStructure_TopologicalPair_23a951172729bcd7e2a9 X),
  @cleanDefine_ambient_continuous_map_8847accc2cf96844c6cb X (@identity X P) = @cleanNotation_identity_continuous_map_315ac9c43278079f1ecf (@cleanNotation_subspace_4d29dc4d5e65a0cd314c X P.ambient) ∧
  @cleanDefine_relative_continuous_map_9ee2cb50fac73bd8824e X (@identity X P) = @cleanNotation_identity_continuous_map_315ac9c43278079f1ecf (@cleanNotation_subspace_4d29dc4d5e65a0cd314c X P.relative)
end PairCompositionOracle
same_target cleanNotation_equality_congruence_3e3f32efa32223213c0e PairCompositionOracle.congruence
same_target cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db PairCompositionOracle.reflexivity
same_target cleanNotation_subset_reflexivity_5ebc9817a9ee3f43d7f0 PairCompositionOracle.subsetRefl
same_target cleanNotation_subset_transitivity_fa31d5e4c61a19d8595c PairCompositionOracle.subsetTrans
same_target cleanNotation_replace_subset_target_8b4e7788eded91cdaaa5 PairCompositionOracle.replaceTarget
same_target cleanDefine_pair_ambient_equality_5648e040d11d9fdd25c5 PairCompositionOracle.ambientEq
same_target cleanDefine_pair_relative_equality_ff40802276b5bb327e8b PairCompositionOracle.relativeEq
same_target cleanDefine_identity_pair_inclusion_73485ba729e3e7c1bcd4 PairCompositionOracle.identity
same_target cleanDefine_compose_pair_inclusions_71f3b4369fe55ba0cb47 PairCompositionOracle.compose
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
