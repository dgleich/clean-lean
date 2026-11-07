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

structure cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V» : Type) («E» : Type) : Type where
  «source» : («E») → («V»)
  «target» : («E») → («V»)

noncomputable def cleanConstructor_diagram_shape_b5c9edb90b3d54e4cc06 («V» : Type) («E» : Type) («source» : («E») → («V»)) («target» : («E») → («V»)) : cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V») («E») :=
  @cleanStructure_DiagramShape_02ab4e571d9987d4a63c.mk «V» «E» «source» «target»

noncomputable def cleanDefine_shape_ab2900d9a72e571d2eb8 {V : Type} {E : Type} (source : (E) → (V)) (target : (E) → (V)) : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E) :=
  (@cleanConstructor_diagram_shape_b5c9edb90b3d54e4cc06 (V) (E) (source) (target))

structure cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 («K» : Type) («field» : Field «K») («V» : Type) («E» : Type) («Q» : cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V») («E»)) : Type 1 where
  «object» : («V») → ((@ModuleCat.{0,0} «K» «field».toRing))
  «arrow» : (clean_pi_bound_1 : «E») → ((@ModuleCat.Hom «K» «field».toRing («object» ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («V») («E») («Q»)) clean_pi_bound_1)) («object» ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («V») («E») («Q»)) clean_pi_bound_1))))

noncomputable def cleanConstructor_module_diagram_d34ad79f6914baaf649a («K» : Type) («field» : Field «K») («V» : Type) («E» : Type) («Q» : cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V») («E»)) («object» : («V») → ((@ModuleCat.{0,0} «K» «field».toRing))) («arrow» : (clean_pi_bound_1 : «E») → ((@ModuleCat.Hom «K» «field».toRing («object» ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («V») («E») («Q»)) clean_pi_bound_1)) («object» ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («V») («E») («Q»)) clean_pi_bound_1))))) : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 («K») («field») («V») («E») («Q») :=
  @cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.mk «K» «field» «V» «E» «Q» «object» «arrow»

noncomputable def cleanDefine_constant_module_diagram_97d37ecd434f2512260b  (K : Type) (field : Field K) (V : Type) (E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (M : (@ModuleCat.{0,0} K field.toRing)) : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q) :=
  (@cleanConstructor_module_diagram_d34ad79f6914baaf649a (K) (field) (V) (E) (Q) ((fun (clean_bound_0 : V) => M)) ((fun (clean_bound_1 : E) => (@cleanNotation_module_identity_584a18e3c6f6747bc76f (K) (field) (M)))))

noncomputable def cleanDefine_constant_diagram_e9c37c47e521ce184399 {K : Type} {V : Type} {E : Type} (field : Field K) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (M : (@ModuleCat.{0,0} K field.toRing)) : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q) :=
  (@cleanDefine_constant_module_diagram_97d37ecd434f2512260b (K) (field) (V) (E) (Q) (M))

noncomputable def cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c  (K : Type) (field : Field K) (V : Type) (E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (X : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)) (Y : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)) (component : (clean_pi_bound_2 : V) → ((@ModuleCat.Hom K field.toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (X)) clean_pi_bound_2) ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (Y)) clean_pi_bound_2)))) : Prop :=
  (∀ (clean_bound_0 : E), ((@cleanNotation_module_composition_115d9963c374fb45e52e (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (X)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_0))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (X)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_0))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (Y)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_0))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«arrow» (K) (field) (V) (E) (Q) (X)) clean_bound_0)) ((component ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_0)))) = (@cleanNotation_module_composition_115d9963c374fb45e52e (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (X)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_0))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (Y)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_0))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (Y)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_0))) ((component ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_0))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«arrow» (K) (field) (V) (E) (Q) (Y)) clean_bound_0)))))

structure cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 («K» : Type) («field» : Field «K») («V» : Type) («E» : Type) («Q» : cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V») («E»)) («X» : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 («K») («field») («V») («E») («Q»)) («Y» : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 («K») («field») («V») («E») («Q»)) : Type where
  «component» : (clean_pi_bound_3 : «V») → ((@ModuleCat.Hom «K» «field».toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» («K») («field») («V») («E») («Q») («X»)) clean_pi_bound_3) ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» («K») («field») («V») («E») («Q») («Y»)) clean_pi_bound_3)))
  «commutes» : ((@cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c («K») («field») («V») («E») («Q») («X») («Y») («component»)))

noncomputable def cleanConstructor_diagram_map_04bad9ca0991c3e1ad6f («K» : Type) («field» : Field «K») («V» : Type) («E» : Type) («Q» : cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V») («E»)) («X» : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 («K») («field») («V») («E») («Q»)) («Y» : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 («K») («field») («V») («E») («Q»)) («component» : (clean_pi_bound_3 : «V») → ((@ModuleCat.Hom «K» «field».toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» («K») («field») («V») («E») («Q») («X»)) clean_pi_bound_3) ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» («K») («field») («V») («E») («Q») («Y»)) clean_pi_bound_3)))) («commutes» : ((@cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c («K») («field») («V») («E») («Q») («X») («Y») («component»)))) : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 («K») («field») («V») («E») («Q») («X») («Y») :=
  @cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5.mk «K» «field» «V» «E» «Q» «X» «Y» «component» «commutes»

noncomputable def cleanDefine_diagram_identity_components_c1d44112796da4f148fb  (K : Type) (field : Field K) (V : Type) (E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (X : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)) : (clean_pi_bound_4 : V) → ((@ModuleCat.Hom K field.toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (X)) clean_pi_bound_4) ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (X)) clean_pi_bound_4))) :=
  (fun (clean_bound_0 : V) => (@cleanNotation_module_identity_584a18e3c6f6747bc76f (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (X)) clean_bound_0))))

noncomputable def cleanDefine_diagram_composite_components_8699bd92b163fc76be4b  (K : Type) (field : Field K) (V : Type) (E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (X : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)) (Y : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)) (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)) (f : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 (K) (field) (V) (E) (Q) (X) (Y)) (g : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 (K) (field) (V) (E) (Q) (Y) (Z)) : (clean_pi_bound_5 : V) → ((@ModuleCat.Hom K field.toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (X)) clean_pi_bound_5) ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (Z)) clean_pi_bound_5))) :=
  (fun (clean_bound_0 : V) => (@cleanNotation_module_composition_115d9963c374fb45e52e (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (X)) clean_bound_0)) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (Y)) clean_bound_0)) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (Z)) clean_bound_0)) (((@cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5.«component» (K) (field) (V) (E) (Q) (X) (Y) (f)) clean_bound_0)) (((@cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5.«component» (K) (field) (V) (E) (Q) (Y) (Z) (g)) clean_bound_0))))

noncomputable def cleanDefine_certified_diagram_identity_fc633eeae555ec28979f  (K : Type) (field : Field K) (V : Type) (E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (X : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)) (h : ((@cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c (K) (field) (V) (E) (Q) (X) (X) ((@cleanDefine_diagram_identity_components_c1d44112796da4f148fb (K) (field) (V) (E) (Q) (X)))))) : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 (K) (field) (V) (E) (Q) (X) (X) :=
  (@cleanConstructor_diagram_map_04bad9ca0991c3e1ad6f (K) (field) (V) (E) (Q) (X) (X) ((@cleanDefine_diagram_identity_components_c1d44112796da4f148fb (K) (field) (V) (E) (Q) (X))) (h))

noncomputable def cleanDefine_certified_diagram_composition_8af62f236170885c8bf7  (K : Type) (field : Field K) (V : Type) (E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (X : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)) (Y : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)) (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)) (f : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 (K) (field) (V) (E) (Q) (X) (Y)) (g : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 (K) (field) (V) (E) (Q) (Y) (Z)) (h : ((@cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c (K) (field) (V) (E) (Q) (X) (Z) ((@cleanDefine_diagram_composite_components_8699bd92b163fc76be4b (K) (field) (V) (E) (Q) (X) (Y) (Z) (f) (g)))))) : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 (K) (field) (V) (E) (Q) (X) (Z) :=
  (@cleanConstructor_diagram_map_04bad9ca0991c3e1ad6f (K) (field) (V) (E) (Q) (X) (Z) ((@cleanDefine_diagram_composite_components_8699bd92b163fc76be4b (K) (field) (V) (E) (Q) (X) (Y) (Z) (f) (g))) (h))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: topology
reference: diagram map laws
relationship: original
-/
def identity_components_commute : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (V E : Type),
  ∀ (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)),
  ∀ (X : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)),
  (@cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c (K) (field) (V) (E) (Q) (X) (X) ((@cleanDefine_diagram_identity_components_c1d44112796da4f148fb (K) (field) (V) (E) (Q) (X))))

/--
source: topology
reference: diagram map laws
relationship: original
-/
def composite_components_commute : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (V E : Type),
  ∀ (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)),
  ∀ (X Y Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)),
  ∀ (f : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 (K) (field) (V) (E) (Q) (X) (Y)),
  ∀ (g : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 (K) (field) (V) (E) (Q) (Y) (Z)),
  (@cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c (K) (field) (V) (E) (Q) (X) (Z) ((@cleanDefine_diagram_composite_components_8699bd92b163fc76be4b (K) (field) (V) (E) (Q) (X) (Y) (Z) (f) (g))))

/--
source: topology
reference: diagram map laws
relationship: original
-/
def identity_diagram_component : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (V E : Type),
  ∀ (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)),
  ∀ (X : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)),
  ∀ (h : ((@cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c (K) (field) (V) (E) (Q) (X) (X) ((@cleanDefine_diagram_identity_components_c1d44112796da4f148fb (K) (field) (V) (E) (Q) (X)))))),
  ∀ (v : V),
  (((@cleanDefine_diagram_identity_components_c1d44112796da4f148fb (K) (field) (V) (E) (Q) (X)) v) = (@cleanNotation_module_identity_584a18e3c6f6747bc76f (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (X)) v))))

/--
source: topology
reference: diagram map laws
relationship: original
-/
def composite_diagram_component : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (V E : Type),
  ∀ (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)),
  ∀ (X Y Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)),
  ∀ (f : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 (K) (field) (V) (E) (Q) (X) (Y)),
  ∀ (g : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 (K) (field) (V) (E) (Q) (Y) (Z)),
  ∀ (h : ((@cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c (K) (field) (V) (E) (Q) (X) (Z) ((@cleanDefine_diagram_composite_components_8699bd92b163fc76be4b (K) (field) (V) (E) (Q) (X) (Y) (Z) (f) (g)))))),
  ∀ (v : V),
  (((@cleanDefine_diagram_composite_components_8699bd92b163fc76be4b (K) (field) (V) (E) (Q) (X) (Y) (Z) (f) (g)) v) = (@cleanNotation_module_composition_115d9963c374fb45e52e (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (X)) v)) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (Y)) v)) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (Z)) v)) (((@cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5.«component» (K) (field) (V) (E) (Q) (X) (Y) (f)) v)) (((@cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5.«component» (K) (field) (V) (E) (Q) (Y) (Z) (g)) v))))

/--
source: topology
reference: diagram map laws
relationship: original
-/
def diagram_map_extensionality : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (V E : Type),
  ∀ (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)),
  ∀ (X Y : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)),
  ∀ (f g : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 (K) (field) (V) (E) (Q) (X) (Y)),
  ∀ («components» : (∀ (clean_bound_0 : V), (((@cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5.«component» (K) (field) (V) (E) (Q) (X) (Y) (f)) clean_bound_0) = ((@cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5.«component» (K) (field) (V) (E) (Q) (X) (Y) (g)) clean_bound_0)))),
  (f = g)

/--
source: topology
reference: diagram map laws
relationship: original
-/
def identity_diagram_exists : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (V E : Type),
  ∀ (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)),
  ∀ (X : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)),
  (@Exists (cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 (K) (field) (V) (E) (Q) (X) (X)) (fun (clean_bound_0 : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 (K) (field) (V) (E) (Q) (X) (X)) => (∀ (clean_bound_1 : V), (((@cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5.«component» (K) (field) (V) (E) (Q) (X) (X) (clean_bound_0)) clean_bound_1) = (@cleanNotation_module_identity_584a18e3c6f6747bc76f (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) (X)) clean_bound_1)))))))

end CleanStatements

namespace DiagramMapOracle
noncomputable def commutes (K : Type) (field : Field K) (V E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E)
 (X Y : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field V E Q)
 (c : (v : V) → @ModuleCat.Hom K field.toRing (X.object v) (Y.object v)) : Prop :=
 ∀ a : E, @cleanNotation_module_composition_115d9963c374fb45e52e K field (X.object (Q.source a)) (X.object (Q.target a)) (Y.object (Q.target a)) (X.arrow a) (c (Q.target a)) =
 @cleanNotation_module_composition_115d9963c374fb45e52e K field (X.object (Q.source a)) (Y.object (Q.source a)) (Y.object (Q.target a)) (c (Q.source a)) (Y.arrow a)
structure Map (K : Type) (field : Field K) (V E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E)
 (X Y : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field V E Q) : Type where
 component : (v : V) → @ModuleCat.Hom K field.toRing (X.object v) (Y.object v)
 commutes : @cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c K field V E Q X Y component
noncomputable def identity (K : Type) (field : Field K) (V E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E)
 (X : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field V E Q) : (v : V) → @ModuleCat.Hom K field.toRing (X.object v) (X.object v) :=
 fun v : V => @cleanNotation_module_identity_584a18e3c6f6747bc76f K field (X.object v)
noncomputable def composite (K : Type) (field : Field K) (V E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E)
 (X Y Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field V E Q) (f : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 K field V E Q X Y) (g : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 K field V E Q Y Z) :
 (v : V) → @ModuleCat.Hom K field.toRing (X.object v) (Z.object v) :=
 fun v : V => @cleanNotation_module_composition_115d9963c374fb45e52e K field (X.object v) (Y.object v) (Z.object v) (f.component v) (g.component v)
noncomputable def certifiedId (K : Type) (field : Field K) (V E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E)
 (X : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field V E Q) (h : @cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c K field V E Q X X (@cleanDefine_diagram_identity_components_c1d44112796da4f148fb K field V E Q X)) : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 K field V E Q X X :=
 @cleanConstructor_diagram_map_04bad9ca0991c3e1ad6f K field V E Q X X (@cleanDefine_diagram_identity_components_c1d44112796da4f148fb K field V E Q X) h
noncomputable def certifiedComp (K : Type) (field : Field K) (V E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E)
 (X Y Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field V E Q) (f : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 K field V E Q X Y) (g : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 K field V E Q Y Z)
 (h : @cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c K field V E Q X Z (@cleanDefine_diagram_composite_components_8699bd92b163fc76be4b K field V E Q X Y Z f g)) : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 K field V E Q X Z :=
 @cleanConstructor_diagram_map_04bad9ca0991c3e1ad6f K field V E Q X Z (@cleanDefine_diagram_composite_components_8699bd92b163fc76be4b K field V E Q X Y Z f g) h

def identityLaw : Prop := ∀ (K : Type) (field : Field K) (V E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E)
 (X : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field V E Q), @cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c K field V E Q X X (@cleanDefine_diagram_identity_components_c1d44112796da4f148fb K field V E Q X)
def compositionLaw : Prop := ∀ (K : Type) (field : Field K) (V E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E)
 (X Y Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field V E Q) (f : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 K field V E Q X Y) (g : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 K field V E Q Y Z),
 @cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c K field V E Q X Z (@cleanDefine_diagram_composite_components_8699bd92b163fc76be4b K field V E Q X Y Z f g)
def identityComponent : Prop := ∀ (K : Type) (field : Field K) (V E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E)
 (X : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field V E Q) (h : @cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c K field V E Q X X (@cleanDefine_diagram_identity_components_c1d44112796da4f148fb K field V E Q X)) (v : V),
 (@cleanDefine_diagram_identity_components_c1d44112796da4f148fb K field V E Q X) v = @cleanNotation_module_identity_584a18e3c6f6747bc76f K field (X.object v)
def compositeComponent : Prop := ∀ (K : Type) (field : Field K) (V E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E)
 (X Y Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field V E Q) (f : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 K field V E Q X Y) (g : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 K field V E Q Y Z)
 (h : @cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c K field V E Q X Z (@cleanDefine_diagram_composite_components_8699bd92b163fc76be4b K field V E Q X Y Z f g)) (v : V),
 (@cleanDefine_diagram_composite_components_8699bd92b163fc76be4b K field V E Q X Y Z f g) v = @cleanNotation_module_composition_115d9963c374fb45e52e K field (X.object v) (Y.object v) (Z.object v) (f.component v) (g.component v)
def extensionality : Prop := ∀ (K : Type) (field : Field K) (V E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E)
 (X Y : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field V E Q) (f g : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 K field V E Q X Y),
 (∀ v : V, f.component v = g.component v) → f = g
def identityExists : Prop := ∀ (K : Type) (field : Field K) (V E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E)
 (X : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field V E Q), ∃ f : cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 K field V E Q X X, ∀ v : V, f.component v = @cleanNotation_module_identity_584a18e3c6f6747bc76f K field (X.object v)
end DiagramMapOracle

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `DiagramMapOracle.Map then return `cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5
  if n == `DiagramMapOracle.Map.mk then return `cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5.mk
  if n == `DiagramMapOracle.Map.component then return `cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5.component
  if n == `DiagramMapOracle.Map.commutes then return `cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5.commutes
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
  | .thmInfo x,.thmInfo y =>
    unless Expr.equal (canonical x.value) (canonical y.value) do throwError "Canonical proof differs"
  | .ctorInfo x,.ctorInfo y =>
    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&
      canonicalName x.induct == canonicalName y.induct do throwError "Constructor differs"
  | .inductInfo x,.inductInfo y =>
    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&
      x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do throwError "Record differs"
  | _,_ => throwError "Unexpected declaration kinds"
same_target cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5 DiagramMapOracle.Map
same_target cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5.mk DiagramMapOracle.Map.mk
same_target cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5.component DiagramMapOracle.Map.component
same_target cleanStructure_ModuleDiagramMap_d6e960f6d23d601afdb5.commutes DiagramMapOracle.Map.commutes
same_target cleanDefine_diagram_maps_commute_a6bbd9d5c0ec695e3d9c DiagramMapOracle.commutes
same_target cleanDefine_diagram_identity_components_c1d44112796da4f148fb DiagramMapOracle.identity
same_target cleanDefine_diagram_composite_components_8699bd92b163fc76be4b DiagramMapOracle.composite
same_target cleanDefine_certified_diagram_identity_fc633eeae555ec28979f DiagramMapOracle.certifiedId
same_target cleanDefine_certified_diagram_composition_8af62f236170885c8bf7 DiagramMapOracle.certifiedComp
same_target CleanStatements.identity_components_commute DiagramMapOracle.identityLaw
same_target CleanStatements.composite_components_commute DiagramMapOracle.compositionLaw
same_target CleanStatements.identity_diagram_component DiagramMapOracle.identityComponent
same_target CleanStatements.composite_diagram_component DiagramMapOracle.compositeComponent
same_target CleanStatements.diagram_map_extensionality DiagramMapOracle.extensionality
same_target CleanStatements.identity_diagram_exists DiagramMapOracle.identityExists
open CategoryTheory
namespace DiagramMapProofs
theorem identityLaw : CleanStatements.identity_components_commute := by
 intro K field V E Q X
 letI : Field K := field
 change ∀ a : E, X.arrow a ≫ 𝟙 (X.object (Q.target a)) = 𝟙 (X.object (Q.source a)) ≫ X.arrow a
 intro a
 simp

theorem compositionLaw : CleanStatements.composite_components_commute := by
 intro K field V E Q X Y Z f g
 letI : Field K := field
 intro a
 apply ModuleCat.hom_ext
 ext x
 have hf := congrArg (fun h => h.hom x) (f.commutes a)
 have hg := congrArg (fun h => h.hom ((f.component (Q.source a)).hom x)) (g.commutes a)
 change (f.component (Q.target a)).hom ((X.arrow a).hom x) = (Y.arrow a).hom ((f.component (Q.source a)).hom x) at hf
 change (g.component (Q.target a)).hom ((Y.arrow a).hom ((f.component (Q.source a)).hom x)) =
  (Z.arrow a).hom ((g.component (Q.source a)).hom ((f.component (Q.source a)).hom x)) at hg
 change (g.component (Q.target a)).hom ((f.component (Q.target a)).hom ((X.arrow a).hom x)) =
  (Z.arrow a).hom ((g.component (Q.source a)).hom ((f.component (Q.source a)).hom x))
 exact (congrArg (fun y => (g.component (Q.target a)).hom y) hf).trans hg

theorem identityComponent : CleanStatements.identity_diagram_component := by
 intro K field V E Q X h v
 rfl

theorem compositeComponent : CleanStatements.composite_diagram_component := by
 intro K field V E Q X Y Z f g h v
 rfl

theorem extensionality : CleanStatements.diagram_map_extensionality := by
 intro K field V E Q X Y f g h
 have hc := funext h
 cases f with
 | mk fc fh =>
  cases g with
  | mk gc gh =>
   change fc = gc at hc
   cases hc
   rfl

theorem identityExists : CleanStatements.identity_diagram_exists := by
 intro K field V E Q X
 refine ⟨@cleanConstructor_diagram_map_04bad9ca0991c3e1ad6f K field V E Q X X (@cleanDefine_diagram_identity_components_c1d44112796da4f148fb K field V E Q X) (identityLaw K field V E Q X), ?_⟩
 intro v
 rfl
end DiagramMapProofs

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
