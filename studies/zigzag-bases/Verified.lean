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
import Mathlib.LinearAlgebra.Basis.Basic
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

noncomputable def cleanType_Boolean_b98a4c98fcdb0f46359e  : Type :=
  Bool

noncomputable def cleanNotation_true_value_2fd5fc223c8905693b89   : Bool :=
  true

noncomputable def cleanNotation_false_value_d4e3155033dd79d1d53f   : Bool :=
  false

noncomputable def cleanNotation_select_value_c11801da606ce7eb1515 {T : Type} (b : Bool) (x : T) (y : T) : T :=
  if b then x else y

noncomputable def cleanNotation_left_vertex_11cc62d804acf6603303  (n : ℕ) (e : Fin n) : Fin (n + 1) :=
  e.castSucc

noncomputable def cleanNotation_right_vertex_5c0c0fa990cf02dd2676  (n : ℕ) (e : Fin n) : Fin (n + 1) :=
  e.succ

noncomputable def cleanNotation_vertex_number_64138f6f46dd27172356  (n : ℕ) (v : Fin n) : ℕ :=
  v.val

noncomputable def cleanDefine_zigzag_shape_aabf9ce777651ce61e96  (n : ℕ) (d : (Fin n) → (Bool)) : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (Fin (n + 1)) (Fin n) :=
  (cleanDefine_shape_ab2900d9a72e571d2eb8 ((fun (clean_bound_0 : Fin n) => (cleanNotation_select_value_c11801da606ce7eb1515 ((d clean_bound_0)) ((@cleanNotation_left_vertex_11cc62d804acf6603303 (n) (clean_bound_0))) ((@cleanNotation_right_vertex_5c0c0fa990cf02dd2676 (n) (clean_bound_0)))))) ((fun (clean_bound_1 : Fin n) => (cleanNotation_select_value_c11801da606ce7eb1515 ((d clean_bound_1)) ((@cleanNotation_right_vertex_5c0c0fa990cf02dd2676 (n) (clean_bound_1))) ((@cleanNotation_left_vertex_11cc62d804acf6603303 (n) (clean_bound_1)))))))

noncomputable def cleanDefine_constant_zigzag_f3f91c9bf3b9b0272da1  (K : Type) (field : Field K) (n : ℕ) (d : (Fin n) → (Bool)) (M : (@ModuleCat.{0,0} K field.toRing)) : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) :=
  (@cleanDefine_constant_diagram_e9c37c47e521ce184399 (K) (Fin (n + 1)) (Fin n) (field) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (M))

noncomputable def cleanType_ModuleBasis_296e16eac63a71b96e36 (K : Type) (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) (I : Type) : Type :=
  @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule

noncomputable def cleanNotation_module_basis_vector_b6882a4cd225e847e1a4 {K : Type} {I : Type} (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) (b : @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule) (i : I) : (@ModuleCat.carrier K field.toRing M) :=
  (letI : Field K := field; b i)

noncomputable def cleanNotation_module_zero_28d8dceda339c15e0abe {K : Type} (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) : (@ModuleCat.carrier K field.toRing M) :=
  @Zero.zero M.carrier M.isAddCommGroup.toZero

noncomputable def cleanType_Element_f6cf8dd1e8f2bae54be4 (X : Type) (S : Set (X)) : Type :=
  {x : X // x ∈ S}

noncomputable def cleanType_Path_3fdd593c9b34e872c4b4 (X : Type) (t : TopologicalSpace X) (x : X) (y : X) : Type :=
  @Path X t x y

noncomputable def cleanNotation_evaluate_map_fc8e4f20170606ffe807 {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) : Y :=
  f x

noncomputable def cleanNotation_selected_value_df54a12138d36423a390 {I : Type} (S : Set (I)) (x : {x : I // x ∈ S}) : I :=
  x.val

noncomputable def cleanDefine_ordered_interval_endpoints_b96fc005e5e3165ce77d  (I : Type) (n : ℕ) (lower : (I) → (Fin (n + 1))) (upper : (I) → (Fin (n + 1))) : Prop :=
  (∀ (clean_bound_0 : I), ((lower clean_bound_0) ≤ (upper clean_bound_0)))

structure cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe («I» : Type) («n» : ℕ) : Type where
  «lower» : («I») → (Fin («n» + 1))
  «upper» : («I») → (Fin («n» + 1))
  «ordered» : ((@cleanDefine_ordered_interval_endpoints_b96fc005e5e3165ce77d («I») («n») («lower») («upper»)))

noncomputable def cleanConstructor_interval_labels_c716f00fe8e77d75edb2 («I» : Type) («n» : ℕ) («lower» : («I») → (Fin («n» + 1))) («upper» : («I») → (Fin («n» + 1))) («ordered» : ((@cleanDefine_ordered_interval_endpoints_b96fc005e5e3165ce77d («I») («n») («lower») («upper»)))) : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe («I») («n») :=
  @cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe.mk «I» «n» «lower» «upper» «ordered»

noncomputable def cleanDefine_interval_labels_at_1f63148e436b0a274491  (I : Type) (n : ℕ) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe (I) (n)) (v : Fin (n + 1)) : Set (I) :=
  (cleanNotation_set_of_25534029a1fdae044ce8 ((fun (clean_bound_0 : I) => ((((@cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe.«lower» (I) (n) (L)) clean_bound_0) ≤ v) ∧ (v ≤ ((@cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe.«upper» (I) (n) (L)) clean_bound_0))))))

noncomputable def cleanDefine_zigzag_source_dc6df9137c1a7c80c3de  (n : ℕ) (d : (Fin n) → (Bool)) (e : Fin n) : Fin (n + 1) :=
  ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d)))) e)

noncomputable def cleanDefine_zigzag_target_ac4c1cb2e01fce9aaa56  (n : ℕ) (d : (Fin n) → (Bool)) (e : Fin n) : Fin (n + 1) :=
  ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d)))) e)

noncomputable def cleanDefine_interval_vectors_realize_bases_25b21b45a650c29569d7  (K : Type) (field : Field K) (n : ℕ) (d : (Fin n) → (Bool)) (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d)))) (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe (I) (n)) (vectors : (clean_pi_bound_2 : Fin (n + 1)) → ((I) → ((@ModuleCat.carrier K field.toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) clean_pi_bound_2))))) (basis : (clean_pi_bound_3 : Fin (n + 1)) → (@Module.Basis {x : I // x ∈ (@cleanDefine_interval_labels_at_1f63148e436b0a274491 (I) (n) (L) (clean_pi_bound_3))} K ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) clean_pi_bound_3).carrier field.toSemiring ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) clean_pi_bound_3).isAddCommGroup.toAddCommMonoid ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) clean_pi_bound_3).isModule)) : Prop :=
  (∀ (clean_bound_0 : Fin (n + 1)), (∀ (clean_bound_1 : {x : I // x ∈ (@cleanDefine_interval_labels_at_1f63148e436b0a274491 (I) (n) (L) (clean_bound_0))}), ((@cleanNotation_module_basis_vector_b6882a4cd225e847e1a4 (K) ({x : I // x ∈ (@cleanDefine_interval_labels_at_1f63148e436b0a274491 (I) (n) (L) (clean_bound_0))}) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) clean_bound_0)) ((basis clean_bound_0)) (clean_bound_1)) = (cleanNotation_evaluate_map_fc8e4f20170606ffe807 ((vectors clean_bound_0)) ((@cleanNotation_selected_value_df54a12138d36423a390 (I) ((@cleanDefine_interval_labels_at_1f63148e436b0a274491 (I) (n) (L) (clean_bound_0))) (clean_bound_1)))))))

noncomputable def cleanDefine_interval_vectors_vanish_76b24f11b6da51eab033  (K : Type) (field : Field K) (n : ℕ) (d : (Fin n) → (Bool)) (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d)))) (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe (I) (n)) (vectors : (clean_pi_bound_4 : Fin (n + 1)) → ((I) → ((@ModuleCat.carrier K field.toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) clean_pi_bound_4))))) : Prop :=
  (∀ (clean_bound_0 : Fin (n + 1)), (∀ (clean_bound_1 : I), ((¬(clean_bound_1 ∈ (@cleanDefine_interval_labels_at_1f63148e436b0a274491 (I) (n) (L) (clean_bound_0)))) → ((cleanNotation_evaluate_map_fc8e4f20170606ffe807 ((vectors clean_bound_0)) (clean_bound_1)) = (@cleanNotation_module_zero_28d8dceda339c15e0abe (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) clean_bound_0)))))))

noncomputable def cleanDefine_interval_vectors_compatible_9ad73449cd688c6c847b  (K : Type) (field : Field K) (n : ℕ) (d : (Fin n) → (Bool)) (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d)))) (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe (I) (n)) (vectors : (clean_pi_bound_5 : Fin (n + 1)) → ((I) → ((@ModuleCat.carrier K field.toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) clean_pi_bound_5))))) : Prop :=
  (∀ (clean_bound_0 : Fin n), (∀ (clean_bound_1 : I), ((clean_bound_1 ∈ (@cleanDefine_interval_labels_at_1f63148e436b0a274491 (I) (n) (L) ((@cleanDefine_zigzag_source_dc6df9137c1a7c80c3de (n) (d) (clean_bound_0))))) → ((@cleanNotation_module_map_value_f0835c4f7a36db98a213 (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) (@cleanDefine_zigzag_source_dc6df9137c1a7c80c3de (n) (d) (clean_bound_0)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) (@cleanDefine_zigzag_target_ac4c1cb2e01fce9aaa56 (n) (d) (clean_bound_0)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«arrow» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) clean_bound_0)) ((cleanNotation_evaluate_map_fc8e4f20170606ffe807 ((vectors (@cleanDefine_zigzag_source_dc6df9137c1a7c80c3de (n) (d) (clean_bound_0)))) (clean_bound_1)))) = (cleanNotation_evaluate_map_fc8e4f20170606ffe807 ((vectors (@cleanDefine_zigzag_target_ac4c1cb2e01fce9aaa56 (n) (d) (clean_bound_0)))) (clean_bound_1))))))

structure cleanStructure_IntervalBasis_d65eb8127efa954ca5fb («K» : Type) («field» : Field «K») («n» : ℕ) («d» : (Fin «n») → (Bool)) («Z» : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 («K») («field») (Fin («n» + 1)) (Fin «n») ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 («n») («d»)))) («I» : Type) («L» : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe («I») («n»)) : Type where
  «vectors» : (clean_pi_bound_6 : Fin («n» + 1)) → ((«I») → ((@ModuleCat.carrier «K» «field».toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» («K») («field») (Fin («n» + 1)) (Fin «n») ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 («n») («d»))) («Z»)) clean_pi_bound_6))))
  «basis» : (clean_pi_bound_7 : Fin («n» + 1)) → (@Module.Basis {x : «I» // x ∈ (@cleanDefine_interval_labels_at_1f63148e436b0a274491 («I») («n») («L») (clean_pi_bound_7))} «K» ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» («K») («field») (Fin («n» + 1)) (Fin «n») ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 («n») («d»))) («Z»)) clean_pi_bound_7).carrier «field».toSemiring ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» («K») («field») (Fin («n» + 1)) (Fin «n») ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 («n») («d»))) («Z»)) clean_pi_bound_7).isAddCommGroup.toAddCommMonoid ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» («K») («field») (Fin («n» + 1)) (Fin «n») ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 («n») («d»))) («Z»)) clean_pi_bound_7).isModule)
  «realizes» : ((@cleanDefine_interval_vectors_realize_bases_25b21b45a650c29569d7 («K») («field») («n») («d») («Z») («I») («L») («vectors») («basis»)))
  «vanishes» : ((@cleanDefine_interval_vectors_vanish_76b24f11b6da51eab033 («K») («field») («n») («d») («Z») («I») («L») («vectors»)))
  «compatible» : ((@cleanDefine_interval_vectors_compatible_9ad73449cd688c6c847b («K») («field») («n») («d») («Z») («I») («L») («vectors»)))

noncomputable def cleanConstructor_interval_basis_e74c048feef25f457251 («K» : Type) («field» : Field «K») («n» : ℕ) («d» : (Fin «n») → (Bool)) («Z» : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 («K») («field») (Fin («n» + 1)) (Fin «n») ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 («n») («d»)))) («I» : Type) («L» : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe («I») («n»)) («vectors» : (clean_pi_bound_6 : Fin («n» + 1)) → ((«I») → ((@ModuleCat.carrier «K» «field».toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» («K») («field») (Fin («n» + 1)) (Fin «n») ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 («n») («d»))) («Z»)) clean_pi_bound_6))))) («basis» : (clean_pi_bound_7 : Fin («n» + 1)) → (@Module.Basis {x : «I» // x ∈ (@cleanDefine_interval_labels_at_1f63148e436b0a274491 («I») («n») («L») (clean_pi_bound_7))} «K» ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» («K») («field») (Fin («n» + 1)) (Fin «n») ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 («n») («d»))) («Z»)) clean_pi_bound_7).carrier «field».toSemiring ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» («K») («field») (Fin («n» + 1)) (Fin «n») ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 («n») («d»))) («Z»)) clean_pi_bound_7).isAddCommGroup.toAddCommMonoid ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» («K») («field») (Fin («n» + 1)) (Fin «n») ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 («n») («d»))) («Z»)) clean_pi_bound_7).isModule)) («realizes» : ((@cleanDefine_interval_vectors_realize_bases_25b21b45a650c29569d7 («K») («field») («n») («d») («Z») («I») («L») («vectors») («basis»)))) («vanishes» : ((@cleanDefine_interval_vectors_vanish_76b24f11b6da51eab033 («K») («field») («n») («d») («Z») («I») («L») («vectors»)))) («compatible» : ((@cleanDefine_interval_vectors_compatible_9ad73449cd688c6c847b («K») («field») («n») («d») («Z») («I») («L») («vectors»)))) : cleanStructure_IntervalBasis_d65eb8127efa954ca5fb («K») («field») («n») («d») («Z») («I») («L») :=
  @cleanStructure_IntervalBasis_d65eb8127efa954ca5fb.mk «K» «field» «n» «d» «Z» «I» «L» «vectors» «basis» «realizes» «vanishes» «compatible»

noncomputable def cleanDefine_interval_basis_vector_d15e7f14dbe5e9177d01 {K : Type} (field : Field K) (n : ℕ) (d : (Fin n) → (Bool)) (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d)))) (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe (I) (n)) (B : cleanStructure_IntervalBasis_d65eb8127efa954ca5fb (K) (field) (n) (d) (Z) (I) (L)) (v : Fin (n + 1)) (i : I) : (@ModuleCat.carrier K field.toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) v)) :=
  (cleanNotation_evaluate_map_fc8e4f20170606ffe807 (((@cleanStructure_IntervalBasis_d65eb8127efa954ca5fb.«vectors» (K) (field) (n) (d) (Z) (I) (L) (B)) v)) (i))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: topology
reference: forward orientation convention
relationship: original
-/
def forward_edge : Prop :=
  ∀ (n : ℕ),
  ∀ (d : (Fin n) → (Bool)),
  ∀ (e : Fin n),
  ∀ («forward» : ((d e) = (cleanNotation_true_value_2fd5fc223c8905693b89))),
  (((@cleanDefine_zigzag_source_dc6df9137c1a7c80c3de (n) (d) (e)) = (@cleanNotation_left_vertex_11cc62d804acf6603303 (n) (e))) ∧ ((@cleanDefine_zigzag_target_ac4c1cb2e01fce9aaa56 (n) (d) (e)) = (@cleanNotation_right_vertex_5c0c0fa990cf02dd2676 (n) (e))))

/--
source: topology
reference: backward orientation convention
relationship: original
-/
def backward_edge : Prop :=
  ∀ (n : ℕ),
  ∀ (d : (Fin n) → (Bool)),
  ∀ (e : Fin n),
  ∀ («backward» : ((d e) = (cleanNotation_false_value_d4e3155033dd79d1d53f))),
  (((@cleanDefine_zigzag_source_dc6df9137c1a7c80c3de (n) (d) (e)) = (@cleanNotation_right_vertex_5c0c0fa990cf02dd2676 (n) (e))) ∧ ((@cleanDefine_zigzag_target_ac4c1cb2e01fce9aaa56 (n) (d) (e)) = (@cleanNotation_left_vertex_11cc62d804acf6603303 (n) (e))))

/--
source: topology
reference: constant diagram component
relationship: original
-/
def constant_diagram_arrow : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (V E : Type),
  ∀ (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)),
  ∀ (M : (@ModuleCat.{0,0} K field.toRing)),
  ∀ (e : E),
  (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«arrow» (K) (field) (V) (E) (Q) ((@cleanDefine_constant_module_diagram_97d37ecd434f2512260b (K) (field) (V) (E) (Q) (M)))) e) = (@cleanNotation_module_identity_584a18e3c6f6747bc76f (K) (field) (M)))

/--
source: interlevel
reference: section 2.2, labelled interval basis
relationship: adapted
-/
def interval_vector_support : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (n : ℕ),
  ∀ (d : (Fin n) → (Bool)),
  ∀ (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d)))),
  ∀ (I : Type),
  ∀ (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe (I) (n)),
  ∀ (B : cleanStructure_IntervalBasis_d65eb8127efa954ca5fb (K) (field) (n) (d) (Z) (I) (L)),
  ∀ (v : Fin (n + 1)),
  ∀ (i : I),
  (((@cleanDefine_interval_basis_vector_d15e7f14dbe5e9177d01 (K) (field) (n) (d) (Z) (I) (L) (B) (v) (i)) ≠ (@cleanNotation_module_zero_28d8dceda339c15e0abe (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) v)))) ↔ (i ∈ (@cleanDefine_interval_labels_at_1f63148e436b0a274491 (I) (n) (L) (v))))

/--
source: interlevel
reference: section 2.2, maps on labelled intervals
relationship: adapted
-/
def interval_edge_action : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (n : ℕ),
  ∀ (d : (Fin n) → (Bool)),
  ∀ (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d)))),
  ∀ (I : Type),
  ∀ (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe (I) (n)),
  ∀ (B : cleanStructure_IntervalBasis_d65eb8127efa954ca5fb (K) (field) (n) (d) (Z) (I) (L)),
  ∀ (e : Fin n),
  ∀ (i : I),
  ∀ («active» : (i ∈ (@cleanDefine_interval_labels_at_1f63148e436b0a274491 (I) (n) (L) ((@cleanDefine_zigzag_source_dc6df9137c1a7c80c3de (n) (d) (e)))))),
  ((@cleanNotation_module_map_value_f0835c4f7a36db98a213 (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) (@cleanDefine_zigzag_source_dc6df9137c1a7c80c3de (n) (d) (e)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) (@cleanDefine_zigzag_target_ac4c1cb2e01fce9aaa56 (n) (d) (e)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«arrow» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) e)) ((@cleanDefine_interval_basis_vector_d15e7f14dbe5e9177d01 (K) (field) (n) (d) (Z) (I) (L) (B) ((@cleanDefine_zigzag_source_dc6df9137c1a7c80c3de (n) (d) (e))) (i)))) = (@cleanDefine_interval_basis_vector_d15e7f14dbe5e9177d01 (K) (field) (n) (d) (Z) (I) (L) (B) ((@cleanDefine_zigzag_target_ac4c1cb2e01fce9aaa56 (n) (d) (e))) (i)))

/--
source: topology
reference: constant zigzag construction
relationship: original
-/
def constant_zigzag_has_interval_basis : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (n : ℕ),
  ∀ (d : (Fin n) → (Bool)),
  ∀ (M : (@ModuleCat.{0,0} K field.toRing)),
  ∀ (I : Type),
  ∀ (b : @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule),
  (@Exists (cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe (I) (n)) (fun (clean_bound_0 : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe (I) (n)) => (@Exists (cleanStructure_IntervalBasis_d65eb8127efa954ca5fb (K) (field) (n) (d) ((@cleanDefine_constant_zigzag_f3f91c9bf3b9b0272da1 (K) (field) (n) (d) (M))) (I) (clean_bound_0)) (fun (clean_bound_1 : cleanStructure_IntervalBasis_d65eb8127efa954ca5fb (K) (field) (n) (d) ((@cleanDefine_constant_zigzag_f3f91c9bf3b9b0272da1 (K) (field) (n) (d) (M))) (I) (clean_bound_0)) => (∀ (clean_bound_2 : Fin (n + 1)), (∀ (clean_bound_3 : I), (clean_bound_3 ∈ (@cleanDefine_interval_labels_at_1f63148e436b0a274491 (I) (n) (clean_bound_0) (clean_bound_2)))))))))

end CleanStatements

namespace ZigzagOracle
structure Shape (V E : Type) where
 source : E → V
 target : E → V
structure Diagram (K : Type) (field : Field K) (V E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E) : Type 1 where
 object : V → (@ModuleCat.{0,0} K field.toRing)
 arrow : (a : E) → @ModuleCat.Hom K field.toRing (object (Q.source a)) (object (Q.target a))
structure Labels (I : Type) (n : ℕ) where
 lower : I → Fin (n+1)
 upper : I → Fin (n+1)
 ordered : @cleanDefine_ordered_interval_endpoints_b96fc005e5e3165ce77d I n lower upper
structure Basis (K : Type) (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field (Fin (n+1)) (Fin n) (@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d)) (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe I n) where
 vectors : (v : Fin (n+1)) → I → (Z.object v).carrier
 basis : (v : Fin (n+1)) → @Module.Basis {i : I // i ∈ @cleanDefine_interval_labels_at_1f63148e436b0a274491 I n L v} K (Z.object v).carrier field.toSemiring (Z.object v).isAddCommGroup.toAddCommMonoid (Z.object v).isModule
 realizes : @cleanDefine_interval_vectors_realize_bases_25b21b45a650c29569d7 K field n d Z I L vectors basis
 vanishes : @cleanDefine_interval_vectors_vanish_76b24f11b6da51eab033 K field n d Z I L vectors
 compatible : @cleanDefine_interval_vectors_compatible_9ad73449cd688c6c847b K field n d Z I L vectors
noncomputable def shape {V E : Type} (source target : E → V) : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E :=
 @cleanConstructor_diagram_shape_b5c9edb90b3d54e4cc06 V E source target
noncomputable def constant (K : Type) (field : Field K) (V E : Type)
 (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E) (M : (@ModuleCat.{0,0} K field.toRing)) : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field V E Q :=
 @cleanConstructor_module_diagram_d34ad79f6914baaf649a K field V E Q (fun _ : V => M) (fun _ : E => @cleanNotation_module_identity_584a18e3c6f6747bc76f K field M)
noncomputable def constantShort {K V E : Type} (field : Field K)
 (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E) (M : (@ModuleCat.{0,0} K field.toRing)) : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field V E Q := @cleanDefine_constant_module_diagram_97d37ecd434f2512260b K field V E Q M
noncomputable def select {T : Type} (b : Bool) (x y : T) : T := if b then x else y
noncomputable def left (n : ℕ) (a : Fin n) : Fin (n+1) := a.castSucc
noncomputable def right (n : ℕ) (a : Fin n) : Fin (n+1) := a.succ
noncomputable def shapeZ (n : ℕ) (d : Fin n → Bool) : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (Fin (n+1)) (Fin n) :=
 @cleanDefine_shape_ab2900d9a72e571d2eb8 (Fin (n+1)) (Fin n)
  (fun a : Fin n => @cleanNotation_select_value_c11801da606ce7eb1515 (Fin (n+1)) (d a) (@cleanNotation_left_vertex_11cc62d804acf6603303 n a) (@cleanNotation_right_vertex_5c0c0fa990cf02dd2676 n a))
  (fun a : Fin n => @cleanNotation_select_value_c11801da606ce7eb1515 (Fin (n+1)) (d a) (@cleanNotation_right_vertex_5c0c0fa990cf02dd2676 n a) (@cleanNotation_left_vertex_11cc62d804acf6603303 n a))
noncomputable def constantZ (K : Type) (field : Field K) (n : ℕ)
 (d : Fin n → Bool) (M : (@ModuleCat.{0,0} K field.toRing)) : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field (Fin (n+1)) (Fin n) (@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d) :=
 @cleanDefine_constant_diagram_e9c37c47e521ce184399 K (Fin (n+1)) (Fin n) field (@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d) M
noncomputable def ordered (I : Type) (n : ℕ) (lower upper : I → Fin (n+1)) : Prop :=
 ∀ i : I, lower i ≤ upper i
noncomputable def activeLabels (I : Type) (n : ℕ) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe I n) (v : Fin (n+1)) : Set I :=
 @cleanNotation_set_of_25534029a1fdae044ce8 I (fun i : I => L.lower i ≤ v ∧ v ≤ L.upper i)
noncomputable def source (n : ℕ) (d : Fin n → Bool) (a : Fin n) : Fin (n+1) :=
 (@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d).source a
noncomputable def target (n : ℕ) (d : Fin n → Bool) (a : Fin n) : Fin (n+1) :=
 (@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d).target a
noncomputable def basisVector {K I : Type} (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing))
 (b : @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule)
 (i : I) : M.carrier := (letI : Field K := field; b i)
noncomputable def zero {K : Type} (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) : M.carrier :=
 @Zero.zero M.carrier M.isAddCommGroup.toZero
noncomputable def realizes (K : Type) (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field (Fin (n+1)) (Fin n) (@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d)) (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe I n) (vectors : (v : Fin (n+1)) → I → (Z.object v).carrier) (basis : (v : Fin (n+1)) → @Module.Basis {i : I // i ∈ @cleanDefine_interval_labels_at_1f63148e436b0a274491 I n L v} K (Z.object v).carrier field.toSemiring (Z.object v).isAddCommGroup.toAddCommMonoid (Z.object v).isModule) : Prop :=
 ∀ (v : Fin (n+1)) (j : {i : I // i ∈ @cleanDefine_interval_labels_at_1f63148e436b0a274491 I n L v}),
 @cleanNotation_module_basis_vector_b6882a4cd225e847e1a4 K {i : I // i ∈ @cleanDefine_interval_labels_at_1f63148e436b0a274491 I n L v} field (Z.object v) (basis v) j =
 @cleanNotation_evaluate_map_fc8e4f20170606ffe807 I (Z.object v).carrier (vectors v) (@cleanNotation_selected_value_df54a12138d36423a390 I (@cleanDefine_interval_labels_at_1f63148e436b0a274491 I n L v) j)
noncomputable def vanishes (K : Type) (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field (Fin (n+1)) (Fin n) (@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d)) (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe I n) (vectors : (v : Fin (n+1)) → I → (Z.object v).carrier) : Prop :=
 ∀ (v : Fin (n+1)) (i : I), ¬ i ∈ @cleanDefine_interval_labels_at_1f63148e436b0a274491 I n L v →
 @cleanNotation_evaluate_map_fc8e4f20170606ffe807 I (Z.object v).carrier (vectors v) i = @cleanNotation_module_zero_28d8dceda339c15e0abe K field (Z.object v)
noncomputable def compatible (K : Type) (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field (Fin (n+1)) (Fin n) (@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d)) (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe I n) (vectors : (v : Fin (n+1)) → I → (Z.object v).carrier) : Prop :=
 ∀ (a : Fin n) (i : I), i ∈ @cleanDefine_interval_labels_at_1f63148e436b0a274491 I n L (@cleanDefine_zigzag_source_dc6df9137c1a7c80c3de n d a) →
 @cleanNotation_module_map_value_f0835c4f7a36db98a213 K field (Z.object (@cleanDefine_zigzag_source_dc6df9137c1a7c80c3de n d a)) (Z.object (@cleanDefine_zigzag_target_ac4c1cb2e01fce9aaa56 n d a)) (Z.arrow a)
  (@cleanNotation_evaluate_map_fc8e4f20170606ffe807 I (Z.object (@cleanDefine_zigzag_source_dc6df9137c1a7c80c3de n d a)).carrier (vectors (@cleanDefine_zigzag_source_dc6df9137c1a7c80c3de n d a)) i) =
 @cleanNotation_evaluate_map_fc8e4f20170606ffe807 I (Z.object (@cleanDefine_zigzag_target_ac4c1cb2e01fce9aaa56 n d a)).carrier (vectors (@cleanDefine_zigzag_target_ac4c1cb2e01fce9aaa56 n d a)) i
noncomputable def vector {K : Type} (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field (Fin (n+1)) (Fin n) (@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d)) (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe I n) (B : cleanStructure_IntervalBasis_d65eb8127efa954ca5fb K field n d Z I L)
 (v : Fin (n+1)) (i : I) : (Z.object v).carrier :=
 @cleanNotation_evaluate_map_fc8e4f20170606ffe807 I (Z.object v).carrier (B.vectors v) i

def forwardStatement : Prop := ∀ (n : ℕ) (d : Fin n → Bool) (a : Fin n), d a = @cleanNotation_true_value_2fd5fc223c8905693b89 →
 @cleanDefine_zigzag_source_dc6df9137c1a7c80c3de n d a = @cleanNotation_left_vertex_11cc62d804acf6603303 n a ∧ @cleanDefine_zigzag_target_ac4c1cb2e01fce9aaa56 n d a = @cleanNotation_right_vertex_5c0c0fa990cf02dd2676 n a
def backwardStatement : Prop := ∀ (n : ℕ) (d : Fin n → Bool) (a : Fin n), d a = @cleanNotation_false_value_d4e3155033dd79d1d53f →
 @cleanDefine_zigzag_source_dc6df9137c1a7c80c3de n d a = @cleanNotation_right_vertex_5c0c0fa990cf02dd2676 n a ∧ @cleanDefine_zigzag_target_ac4c1cb2e01fce9aaa56 n d a = @cleanNotation_left_vertex_11cc62d804acf6603303 n a
def constantStatement : Prop := ∀ (K : Type) (field : Field K) (V E : Type)
 (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c V E) (M : (@ModuleCat.{0,0} K field.toRing)) (a : E),
 (@cleanDefine_constant_module_diagram_97d37ecd434f2512260b K field V E Q M).arrow a = @cleanNotation_module_identity_584a18e3c6f6747bc76f K field M
def supportStatement : Prop := ∀ (K : Type) (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field (Fin (n+1)) (Fin n) (@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d)) (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe I n) (B : cleanStructure_IntervalBasis_d65eb8127efa954ca5fb K field n d Z I L)
 (v : Fin (n+1)) (i : I),
 @cleanDefine_interval_basis_vector_d15e7f14dbe5e9177d01 K field n d Z I L B v i ≠ @cleanNotation_module_zero_28d8dceda339c15e0abe K field (Z.object v) ↔ i ∈ @cleanDefine_interval_labels_at_1f63148e436b0a274491 I n L v
def edgeStatement : Prop := ∀ (K : Type) (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field (Fin (n+1)) (Fin n) (@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d)) (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe I n) (B : cleanStructure_IntervalBasis_d65eb8127efa954ca5fb K field n d Z I L)
 (a : Fin n) (i : I), i ∈ @cleanDefine_interval_labels_at_1f63148e436b0a274491 I n L (@cleanDefine_zigzag_source_dc6df9137c1a7c80c3de n d a) →
 @cleanNotation_module_map_value_f0835c4f7a36db98a213 K field (Z.object (@cleanDefine_zigzag_source_dc6df9137c1a7c80c3de n d a)) (Z.object (@cleanDefine_zigzag_target_ac4c1cb2e01fce9aaa56 n d a)) (Z.arrow a)
  (@cleanDefine_interval_basis_vector_d15e7f14dbe5e9177d01 K field n d Z I L B (@cleanDefine_zigzag_source_dc6df9137c1a7c80c3de n d a) i) =
 @cleanDefine_interval_basis_vector_d15e7f14dbe5e9177d01 K field n d Z I L B (@cleanDefine_zigzag_target_ac4c1cb2e01fce9aaa56 n d a) i
def existsStatement : Prop := ∀ (K : Type) (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (M : (@ModuleCat.{0,0} K field.toRing)) (I : Type)
 (b : @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule),
 ∃ L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe I n, ∃ B : cleanStructure_IntervalBasis_d65eb8127efa954ca5fb K field n d (@cleanDefine_constant_zigzag_f3f91c9bf3b9b0272da1 K field n d M) I L,
 ∀ (v : Fin (n+1)) (i : I), i ∈ @cleanDefine_interval_labels_at_1f63148e436b0a274491 I n L v
end ZigzagOracle

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `ZigzagOracle.Shape then return `cleanStructure_DiagramShape_02ab4e571d9987d4a63c
  if n == `ZigzagOracle.Diagram then return `cleanStructure_ModuleDiagram_dce40a415c66aa5652c4
  if n == `ZigzagOracle.Labels then return `cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe
  if n == `ZigzagOracle.Basis then return `cleanStructure_IntervalBasis_d65eb8127efa954ca5fb
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
same_target cleanStructure_DiagramShape_02ab4e571d9987d4a63c ZigzagOracle.Shape
same_target cleanStructure_DiagramShape_02ab4e571d9987d4a63c.mk ZigzagOracle.Shape.mk
same_target cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 ZigzagOracle.Diagram
same_target cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.mk ZigzagOracle.Diagram.mk
same_target cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe ZigzagOracle.Labels
same_target cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe.mk ZigzagOracle.Labels.mk
same_target cleanStructure_IntervalBasis_d65eb8127efa954ca5fb ZigzagOracle.Basis
same_target cleanStructure_IntervalBasis_d65eb8127efa954ca5fb.mk ZigzagOracle.Basis.mk
same_target cleanStructure_DiagramShape_02ab4e571d9987d4a63c.source ZigzagOracle.Shape.source
same_target cleanStructure_DiagramShape_02ab4e571d9987d4a63c.target ZigzagOracle.Shape.target
same_target cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.object ZigzagOracle.Diagram.object
same_target cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.arrow ZigzagOracle.Diagram.arrow
same_target cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe.lower ZigzagOracle.Labels.lower
same_target cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe.upper ZigzagOracle.Labels.upper
same_target cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe.ordered ZigzagOracle.Labels.ordered
same_target cleanStructure_IntervalBasis_d65eb8127efa954ca5fb.vectors ZigzagOracle.Basis.vectors
same_target cleanStructure_IntervalBasis_d65eb8127efa954ca5fb.basis ZigzagOracle.Basis.basis
same_target cleanStructure_IntervalBasis_d65eb8127efa954ca5fb.realizes ZigzagOracle.Basis.realizes
same_target cleanStructure_IntervalBasis_d65eb8127efa954ca5fb.vanishes ZigzagOracle.Basis.vanishes
same_target cleanStructure_IntervalBasis_d65eb8127efa954ca5fb.compatible ZigzagOracle.Basis.compatible
same_target cleanDefine_shape_ab2900d9a72e571d2eb8 ZigzagOracle.shape
same_target cleanDefine_constant_module_diagram_97d37ecd434f2512260b ZigzagOracle.constant
same_target cleanDefine_constant_diagram_e9c37c47e521ce184399 ZigzagOracle.constantShort
same_target cleanNotation_select_value_c11801da606ce7eb1515 ZigzagOracle.select
same_target cleanNotation_left_vertex_11cc62d804acf6603303 ZigzagOracle.left
same_target cleanNotation_right_vertex_5c0c0fa990cf02dd2676 ZigzagOracle.right
same_target cleanDefine_zigzag_shape_aabf9ce777651ce61e96 ZigzagOracle.shapeZ
same_target cleanDefine_constant_zigzag_f3f91c9bf3b9b0272da1 ZigzagOracle.constantZ
same_target cleanDefine_ordered_interval_endpoints_b96fc005e5e3165ce77d ZigzagOracle.ordered
same_target cleanDefine_interval_labels_at_1f63148e436b0a274491 ZigzagOracle.activeLabels
same_target cleanDefine_zigzag_source_dc6df9137c1a7c80c3de ZigzagOracle.source
same_target cleanDefine_zigzag_target_ac4c1cb2e01fce9aaa56 ZigzagOracle.target
same_target cleanNotation_module_basis_vector_b6882a4cd225e847e1a4 ZigzagOracle.basisVector
same_target cleanNotation_module_zero_28d8dceda339c15e0abe ZigzagOracle.zero
same_target cleanDefine_interval_vectors_realize_bases_25b21b45a650c29569d7 ZigzagOracle.realizes
same_target cleanDefine_interval_vectors_vanish_76b24f11b6da51eab033 ZigzagOracle.vanishes
same_target cleanDefine_interval_vectors_compatible_9ad73449cd688c6c847b ZigzagOracle.compatible
same_target cleanDefine_interval_basis_vector_d15e7f14dbe5e9177d01 ZigzagOracle.vector
same_target CleanStatements.forward_edge ZigzagOracle.forwardStatement
same_target CleanStatements.backward_edge ZigzagOracle.backwardStatement
same_target CleanStatements.constant_diagram_arrow ZigzagOracle.constantStatement
same_target CleanStatements.interval_vector_support ZigzagOracle.supportStatement
same_target CleanStatements.interval_edge_action ZigzagOracle.edgeStatement
same_target CleanStatements.constant_zigzag_has_interval_basis ZigzagOracle.existsStatement
set_option maxHeartbeats 2000000
namespace ZigzagProofs
 theorem forward : CleanStatements.forward_edge := by
  intro n d a h
  change d a = true at h
  change (if d a then a.castSucc else a.succ) = a.castSucc ∧
    (if d a then a.succ else a.castSucc) = a.succ
  simp [h]
 theorem backward : CleanStatements.backward_edge := by
  intro n d a h
  change d a = false at h
  change (if d a then a.castSucc else a.succ) = a.succ ∧
    (if d a then a.succ else a.castSucc) = a.castSucc
  simp [h]
 theorem constantArrow : CleanStatements.constant_diagram_arrow := by
  intro K field V E Q M a
  rfl
 theorem support : CleanStatements.interval_vector_support := by
  intro K field n d Z I L B v i
  letI : Field K := field
  change B.vectors v i ≠ 0 ↔ i ∈ @cleanDefine_interval_labels_at_1f63148e436b0a274491 I n L v
  constructor
  · intro nonzero
    by_contra absent
    exact nonzero (B.vanishes v i absent)
  · intro active zero
    have h := B.realizes v ⟨i,active⟩
    change (B.basis v) ⟨i,active⟩ = B.vectors v i at h
    exact (B.basis v).ne_zero ⟨i,active⟩ (h.trans zero)
 theorem edge : CleanStatements.interval_edge_action := by
  intro K field n d Z I L B a i active
  exact B.compatible a i active
 theorem constantBasis : CleanStatements.constant_zigzag_has_interval_basis := by
  intro K field n d M I b
  letI : Field K := field
  let Z := @cleanDefine_constant_zigzag_f3f91c9bf3b9b0272da1 K field n d M
  let L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe I n := {
    lower := fun _ => 0
    upper := fun _ => Fin.last n
    ordered := by intro i; exact Fin.zero_le _ }
  have allActive (v : Fin (n+1)) (i : I) : i ∈ @cleanDefine_interval_labels_at_1f63148e436b0a274491 I n L v := by
    change (0 : Fin (n+1)) ≤ v ∧ v ≤ Fin.last n
    exact ⟨Fin.zero_le v, Fin.le_last v⟩
  let equiv (v : Fin (n+1)) : I ≃ {i : I // i ∈ @cleanDefine_interval_labels_at_1f63148e436b0a274491 I n L v} := {
    toFun := fun i => ⟨i,allActive v i⟩
    invFun := Subtype.val
    left_inv := fun _ => rfl
    right_inv := by intro i; cases i; rfl }
  let B : cleanStructure_IntervalBasis_d65eb8127efa954ca5fb K field n d Z I L := {
    vectors := fun _ i => b i
    basis := fun v => b.reindex (equiv v)
    realizes := by
      intro v j
      change (b.reindex (equiv v)) j = b j.val
      exact b.reindex_apply (equiv v) j
    vanishes := by
      intro v i absent
      exact False.elim (absent (allActive v i))
    compatible := by
      intro a i active
      rfl }
  exact ⟨L,B,allActive⟩
end ZigzagProofs

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
