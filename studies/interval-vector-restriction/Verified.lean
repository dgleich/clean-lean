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
import Mathlib.CategoryTheory.EqToHom

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

noncomputable def cleanNotation_equality_congruence_3e3f32efa32223213c0e {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) (y : X) (h : ((x = y))) : (((f x) = (f y))) :=
  congrArg f h

noncomputable def cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db {X : Type} (x : X) : ((x = x)) :=
  Eq.refl x

noncomputable def cleanNotation_equality_symmetry_9c171431d92e37157b4c {T : Type} (x : T) (y : T) (h : ((x = y))) : ((y = x)) :=
  Eq.symm h

noncomputable def cleanNotation_equality_transitivity_6a3ecc1273cd16127fa3 {T : Type} (x : T) (y : T) (z : T) (h : ((x = y))) (k : ((y = z))) : ((x = z)) :=
  Eq.trans h k

structure cleanStructure_DiagramShapeMap_24e73609b1402cf1af68 («V» : Type) («E» : Type) («W» : Type) («F» : Type) («Q» : cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V») («E»)) («R» : cleanStructure_DiagramShape_02ab4e571d9987d4a63c («W») («F»)) : Type where
  «vertices» : («V») → («W»)
  «edges» : («E») → («F»)
  «sources» : (clean_pi_bound_8 : «E») → ((((«vertices» ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («V») («E») («Q»)) clean_pi_bound_8)) = ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («W») («F») («R»)) («edges» clean_pi_bound_8)))))
  «targets» : (clean_pi_bound_9 : «E») → ((((«vertices» ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («V») («E») («Q»)) clean_pi_bound_9)) = ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («W») («F») («R»)) («edges» clean_pi_bound_9)))))

noncomputable def cleanConstructor_shape_map_b8af62a3da251f8c8e84 («V» : Type) («E» : Type) («W» : Type) («F» : Type) («Q» : cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V») («E»)) («R» : cleanStructure_DiagramShape_02ab4e571d9987d4a63c («W») («F»)) («vertices» : («V») → («W»)) («edges» : («E») → («F»)) («sources» : (clean_pi_bound_8 : «E») → ((((«vertices» ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («V») («E») («Q»)) clean_pi_bound_8)) = ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («W») («F») («R»)) («edges» clean_pi_bound_8)))))) («targets» : (clean_pi_bound_9 : «E») → ((((«vertices» ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («V») («E») («Q»)) clean_pi_bound_9)) = ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («W») («F») («R»)) («edges» clean_pi_bound_9)))))) : cleanStructure_DiagramShapeMap_24e73609b1402cf1af68 («V») («E») («W») («F») («Q») («R») :=
  @cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.mk «V» «E» «W» «F» «Q» «R» «vertices» «edges» «sources» «targets»

noncomputable def cleanDefine_identity_shape_map_bbf15faeb2237c4f0dc0  (V : Type) (E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) : cleanStructure_DiagramShapeMap_24e73609b1402cf1af68 (V) (E) (V) (E) (Q) (Q) :=
  (@cleanConstructor_shape_map_b8af62a3da251f8c8e84 (V) (E) (V) (E) (Q) (Q) ((fun (clean_bound_0 : V) => clean_bound_0)) ((fun (clean_bound_1 : E) => clean_bound_1)) ((fun (clean_bound_2 : E) => (@cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (V) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_2))))) ((fun (clean_bound_3 : E) => (@cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (V) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_3))))))

noncomputable def cleanDefine_composite_shape_map_c470364e392935589840  (V : Type) (E : Type) (W : Type) (F : Type) (U : Type) (J : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (R : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)) (S : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (U) (J)) (f : cleanStructure_DiagramShapeMap_24e73609b1402cf1af68 (V) (E) (W) (F) (Q) (R)) (g : cleanStructure_DiagramShapeMap_24e73609b1402cf1af68 (W) (F) (U) (J) (R) (S)) : cleanStructure_DiagramShapeMap_24e73609b1402cf1af68 (V) (E) (U) (J) (Q) (S) :=
  (@cleanConstructor_shape_map_b8af62a3da251f8c8e84 (V) (E) (U) (J) (Q) (S) ((fun (clean_bound_0 : V) => ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_0)))) ((fun (clean_bound_1 : E) => ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1)))) ((fun (clean_bound_2 : E) => (@cleanNotation_equality_transitivity_6a3ecc1273cd16127fa3 (U) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_2)))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_2)))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (U) (J) (S)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_2)))) ((@cleanNotation_equality_congruence_3e3f32efa32223213c0e (W) (U) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (W) (F) (U) (J) (R) (S) (g))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_2))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_2))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«sources» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_2)))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«sources» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_2)))))) ((fun (clean_bound_3 : E) => (@cleanNotation_equality_transitivity_6a3ecc1273cd16127fa3 (U) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_3)))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_3)))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (U) (J) (S)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_3)))) ((@cleanNotation_equality_congruence_3e3f32efa32223213c0e (W) (U) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (W) (F) (U) (J) (R) (S) (g))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_3))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_3))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«targets» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_3)))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«targets» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_3)))))))

noncomputable def cleanDefine_shape_identity_7110b104701aa6aca83b {V : Type} {E : Type} (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) : cleanStructure_DiagramShapeMap_24e73609b1402cf1af68 (V) (E) (V) (E) (Q) (Q) :=
  (@cleanDefine_identity_shape_map_bbf15faeb2237c4f0dc0 (V) (E) (Q))

noncomputable def cleanDefine_compose_shapes_f0c00a973fb091c80e6f {V : Type} {E : Type} {W : Type} {F : Type} {U : Type} {J : Type} (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (R : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)) (S : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (U) (J)) (f : cleanStructure_DiagramShapeMap_24e73609b1402cf1af68 (V) (E) (W) (F) (Q) (R)) (g : cleanStructure_DiagramShapeMap_24e73609b1402cf1af68 (W) (F) (U) (J) (R) (S)) : cleanStructure_DiagramShapeMap_24e73609b1402cf1af68 (V) (E) (U) (J) (Q) (S) :=
  (@cleanDefine_composite_shape_map_c470364e392935589840 (V) (E) (W) (F) (U) (J) (Q) (R) (S) (f) (g))

noncomputable def cleanNotation_module_family_transport_d6b9d443d0d35715792a {K : Type} {T : Type} (field : Field K) (M : (T) → ((@ModuleCat.{0,0} K field.toRing))) (x : T) (y : T) (h : ((x = y))) : (@ModuleCat.Hom K field.toRing (M x) (M y)) :=
  @CategoryTheory.eqToHom (@ModuleCat.{0,0} K field.toRing) (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct (M x) (M y) (congrArg M h)

noncomputable def cleanDefine_diagram_pullback_f41fee258061f1774ce1  (K : Type) (field : Field K) (V : Type) (E : Type) (W : Type) (F : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (R : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)) (f : cleanStructure_DiagramShapeMap_24e73609b1402cf1af68 (V) (E) (W) (F) (Q) (R)) (M : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (W) (F) (R)) : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q) :=
  (@cleanConstructor_module_diagram_d34ad79f6914baaf649a (K) (field) (V) (E) (Q) ((fun (clean_bound_0 : V) => ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_0)))) ((fun (clean_bound_1 : E) => (@cleanNotation_module_composition_115d9963c374fb45e52e (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_1)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_1)))) ((@cleanNotation_module_composition_115d9963c374fb45e52e (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_1)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1)))) ((@cleanNotation_module_family_transport_d6b9d443d0d35715792a (K) (W) (field) ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_1))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«sources» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«arrow» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1))))) ((@cleanNotation_module_family_transport_d6b9d443d0d35715792a (K) (W) (field) ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_1))) ((@cleanNotation_equality_symmetry_9c171431d92e37157b4c (W) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_1))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«targets» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1))))))))))

noncomputable def cleanDefine_pull_back_diagram_ce8d888364cd467ea2b6 {K : Type} {V : Type} {E : Type} {W : Type} {F : Type} (field : Field K) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (R : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)) (f : cleanStructure_DiagramShapeMap_24e73609b1402cf1af68 (V) (E) (W) (F) (Q) (R)) (M : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (W) (F) (R)) : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q) :=
  (@cleanDefine_diagram_pullback_f41fee258061f1774ce1 (K) (field) (V) (E) (W) (F) (Q) (R) (f) (M))

noncomputable def cleanDefine_pull_back_arrow_1ccc831e5dbaeee39231 {K : Type} {V : Type} {E : Type} {W : Type} {F : Type} (field : Field K) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (R : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)) (f : cleanStructure_DiagramShapeMap_24e73609b1402cf1af68 (V) (E) (W) (F) (Q) (R)) (M : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (W) (F) (R)) (e : E) : (@ModuleCat.Hom K field.toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) e))) ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) e)))) :=
  (@cleanNotation_module_composition_115d9963c374fb45e52e (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) e)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) e)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) e)))) ((@cleanNotation_module_composition_115d9963c374fb45e52e (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) e)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) e)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) e)))) ((@cleanNotation_module_family_transport_d6b9d443d0d35715792a (K) (W) (field) ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) e))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) e))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«sources» (V) (E) (W) (F) (Q) (R) (f)) e)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«arrow» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) e))))) ((@cleanNotation_module_family_transport_d6b9d443d0d35715792a (K) (W) (field) ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) e))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) e))) ((@cleanNotation_equality_symmetry_9c171431d92e37157b4c (W) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) e))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«edges» (V) (E) (W) (F) (Q) (R) (f)) e))) (((@cleanStructure_DiagramShapeMap_24e73609b1402cf1af68.«targets» (V) (E) (W) (F) (Q) (R) (f)) e)))))))

noncomputable def cleanNotation_offset_vertex_8893e544ed839c8e4060  (a : ℕ) (m : ℕ) (v : Fin m) : Fin (a + m) :=
  Fin.natAdd a v

noncomputable def cleanNotation_widen_vertex_69bf9fc558a039a86f3c  (n : ℕ) (m : ℕ) (h : ((m ≤ n))) (v : Fin m) : Fin n :=
  Fin.castLE h v

noncomputable def cleanNotation_transport_vertex_ae30515c2c6ff2e395df  (n : ℕ) (m : ℕ) (h : ((n = m))) (v : Fin n) : Fin m :=
  Fin.cast h v

noncomputable def cleanNotation_natural_sum_association_ca0c9d3847291ec5e4ab  (a : ℕ) (b : ℕ) (c : ℕ) : ((((a + b) + c) = (a + (b + c)))) :=
  Nat.add_assoc a b c

noncomputable def cleanNotation_advance_bound_e7bb421f6f0d9f619543  (a : ℕ) (b : ℕ) (c : ℕ) (h : ((a ≤ b))) : (((a + c) ≤ (b + c))) :=
  Nat.add_le_add_right h c

noncomputable def cleanDefine_subpath_edge_c6bc2388be5e8cd17cf2  (n : ℕ) (a : ℕ) (m : ℕ) (h : (((a + m) ≤ n))) (e : Fin m) : Fin n :=
  (@cleanNotation_widen_vertex_69bf9fc558a039a86f3c (n) ((a + m)) (h) ((@cleanNotation_offset_vertex_8893e544ed839c8e4060 (a) (m) (e))))

noncomputable def cleanDefine_subpath_vertex_ed24b88b5532567c119f  (n : ℕ) (a : ℕ) (m : ℕ) (h : (((a + m) ≤ n))) (v : Fin (m + 1)) : Fin (n + 1) :=
  (@cleanNotation_widen_vertex_69bf9fc558a039a86f3c ((n + 1)) (((a + m) + 1)) ((@cleanNotation_advance_bound_e7bb421f6f0d9f619543 ((a + m)) (n) (1) (h))) ((@cleanNotation_transport_vertex_ae30515c2c6ff2e395df ((a + (m + 1))) (((a + m) + 1)) ((@cleanNotation_equality_symmetry_9c171431d92e37157b4c (ℕ) (((a + m) + 1)) ((a + (m + 1))) ((@cleanNotation_natural_sum_association_ca0c9d3847291ec5e4ab (a) (m) (1))))) ((@cleanNotation_offset_vertex_8893e544ed839c8e4060 (a) ((m + 1)) (v))))))

noncomputable def cleanDefine_subpath_directions_d5b179a212a0b19f9880  (n : ℕ) (a : ℕ) (m : ℕ) (h : (((a + m) ≤ n))) (d : (Fin n) → (Bool)) : (Fin m) → (Bool) :=
  (fun (clean_bound_0 : Fin m) => (d (@cleanDefine_subpath_edge_c6bc2388be5e8cd17cf2 (n) (a) (m) (h) (clean_bound_0))))

noncomputable def cleanDefine_subpath_sources_preserved_46191249bc7c5cd92929  (n : ℕ) (a : ℕ) (m : ℕ) (h : (((a + m) ≤ n))) (d : (Fin n) → (Bool)) : Prop :=
  (∀ (clean_bound_0 : Fin m), ((@cleanDefine_subpath_vertex_ed24b88b5532567c119f (n) (a) (m) (h) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (Fin (m + 1)) (Fin m) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (m) ((@cleanDefine_subpath_directions_d5b179a212a0b19f9880 (n) (a) (m) (h) (d)))))) clean_bound_0))) = ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d)))) (@cleanDefine_subpath_edge_c6bc2388be5e8cd17cf2 (n) (a) (m) (h) (clean_bound_0)))))

noncomputable def cleanDefine_subpath_targets_preserved_21dad01a350642fb797c  (n : ℕ) (a : ℕ) (m : ℕ) (h : (((a + m) ≤ n))) (d : (Fin n) → (Bool)) : Prop :=
  (∀ (clean_bound_0 : Fin m), ((@cleanDefine_subpath_vertex_ed24b88b5532567c119f (n) (a) (m) (h) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (Fin (m + 1)) (Fin m) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (m) ((@cleanDefine_subpath_directions_d5b179a212a0b19f9880 (n) (a) (m) (h) (d)))))) clean_bound_0))) = ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d)))) (@cleanDefine_subpath_edge_c6bc2388be5e8cd17cf2 (n) (a) (m) (h) (clean_bound_0)))))

noncomputable def cleanDefine_subpath_shape_map_0e3cb29f5cd1d71b2b0a  (n : ℕ) (a : ℕ) (m : ℕ) (h : (((a + m) ≤ n))) (d : (Fin n) → (Bool)) (hs : ((@cleanDefine_subpath_sources_preserved_46191249bc7c5cd92929 (n) (a) (m) (h) (d)))) (ht : ((@cleanDefine_subpath_targets_preserved_21dad01a350642fb797c (n) (a) (m) (h) (d)))) : cleanStructure_DiagramShapeMap_24e73609b1402cf1af68 (Fin (m + 1)) (Fin m) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (m) ((@cleanDefine_subpath_directions_d5b179a212a0b19f9880 (n) (a) (m) (h) (d))))) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) :=
  (@cleanConstructor_shape_map_b8af62a3da251f8c8e84 (Fin (m + 1)) (Fin m) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (m) ((@cleanDefine_subpath_directions_d5b179a212a0b19f9880 (n) (a) (m) (h) (d))))) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) ((fun (clean_bound_0 : Fin (m + 1)) => (@cleanDefine_subpath_vertex_ed24b88b5532567c119f (n) (a) (m) (h) (clean_bound_0)))) ((fun (clean_bound_1 : Fin m) => (@cleanDefine_subpath_edge_c6bc2388be5e8cd17cf2 (n) (a) (m) (h) (clean_bound_1)))) (hs) (ht))

noncomputable def cleanDefine_restricted_zigzag_60d15adfd9b03073eff1 {K : Type} (field : Field K) (n : ℕ) (a : ℕ) (m : ℕ) (h : (((a + m) ≤ n))) (d : (Fin n) → (Bool)) (hs : ((@cleanDefine_subpath_sources_preserved_46191249bc7c5cd92929 (n) (a) (m) (h) (d)))) (ht : ((@cleanDefine_subpath_targets_preserved_21dad01a350642fb797c (n) (a) (m) (h) (d)))) (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d)))) : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (Fin (m + 1)) (Fin m) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (m) ((@cleanDefine_subpath_directions_d5b179a212a0b19f9880 (n) (a) (m) (h) (d))))) :=
  (@cleanDefine_pull_back_diagram_ce8d888364cd467ea2b6 (K) (Fin (m + 1)) (Fin m) (Fin (n + 1)) (Fin n) (field) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (m) ((@cleanDefine_subpath_directions_d5b179a212a0b19f9880 (n) (a) (m) (h) (d))))) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) ((@cleanDefine_subpath_shape_map_0e3cb29f5cd1d71b2b0a (n) (a) (m) (h) (d) (hs) (ht))) (Z))

noncomputable def cleanNotation_natural_minimum_a98622f728b78fbd6d0f  (a : ℕ) (b : ℕ) : ℕ :=
  min a b

noncomputable def cleanNotation_minimum_left_bound_18eddb4005f545937da0  (a : ℕ) (b : ℕ) : (((cleanNotation_natural_minimum_a98622f728b78fbd6d0f (a) (b)) ≤ a)) :=
  Nat.min_le_left a b

noncomputable def cleanNotation_bounded_vertex_5747514b48fa95eb06be  (n : ℕ) (k : ℕ) (h : ((k ≤ n))) : Fin (n + 1) :=
  Fin.mk k (Nat.lt_succ_of_le h)

noncomputable def cleanDefine_clipped_vertex_2105907b2c6d43692206  (n : ℕ) (a : ℕ) (m : ℕ) (v : Fin (n + 1)) : Fin (m + 1) :=
  (@cleanNotation_bounded_vertex_5747514b48fa95eb06be (m) ((cleanNotation_natural_minimum_a98622f728b78fbd6d0f (m) (((@cleanNotation_vertex_number_64138f6f46dd27172356 ((n + 1)) (v)) - a)))) ((@cleanNotation_minimum_left_bound_18eddb4005f545937da0 (m) (((@cleanNotation_vertex_number_64138f6f46dd27172356 ((n + 1)) (v)) - a)))))

noncomputable def cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651  (I : Type) (n : ℕ) (a : ℕ) (m : ℕ) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe (I) (n)) : Set (I) :=
  (cleanNotation_set_of_25534029a1fdae044ce8 ((fun (clean_bound_0 : I) => (((@cleanNotation_vertex_number_64138f6f46dd27172356 ((n + 1)) (((@cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe.«lower» (I) (n) (L)) clean_bound_0))) ≤ (a + m)) ∧ (a ≤ (@cleanNotation_vertex_number_64138f6f46dd27172356 ((n + 1)) (((@cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe.«upper» (I) (n) (L)) clean_bound_0))))))))

noncomputable def cleanNotation_vertex_order_numbers_d0bb5e78e6107e76915f  (n : ℕ) (u : Fin n) (v : Fin n) (h : ((u ≤ v))) : (((@cleanNotation_vertex_number_64138f6f46dd27172356 (n) (u)) ≤ (@cleanNotation_vertex_number_64138f6f46dd27172356 (n) (v)))) :=
  h

noncomputable def cleanNotation_subtraction_preserves_order_545889f2dbbe43ac08cd  (a : ℕ) (u : ℕ) (v : ℕ) (h : ((u ≤ v))) : (((u - a) ≤ (v - a))) :=
  Nat.sub_le_sub_right h a

noncomputable def cleanNotation_minimum_preserves_order_366e442832d54d11c011  (m : ℕ) (u : ℕ) (v : ℕ) (h : ((u ≤ v))) : (((cleanNotation_natural_minimum_a98622f728b78fbd6d0f (m) (u)) ≤ (cleanNotation_natural_minimum_a98622f728b78fbd6d0f (m) (v)))) :=
  min_le_min_left m h

noncomputable def cleanNotation_bounded_vertices_ordered_618d6a051cf02953cafd  (n : ℕ) (k : ℕ) (l : ℕ) (hk : ((k ≤ n))) (hl : ((l ≤ n))) (h : ((k ≤ l))) : (((@cleanNotation_bounded_vertex_5747514b48fa95eb06be (n) (k) (hk)) ≤ (@cleanNotation_bounded_vertex_5747514b48fa95eb06be (n) (l) (hl)))) :=
  h

noncomputable def cleanDefine_clipped_vertices_ordered_18639ea00d989c74f29e  (n : ℕ) (a : ℕ) (m : ℕ) (u : Fin (n + 1)) (v : Fin (n + 1)) (h : ((u ≤ v))) : (((@cleanDefine_clipped_vertex_2105907b2c6d43692206 (n) (a) (m) (u)) ≤ (@cleanDefine_clipped_vertex_2105907b2c6d43692206 (n) (a) (m) (v)))) :=
  (@cleanNotation_bounded_vertices_ordered_618d6a051cf02953cafd (m) ((cleanNotation_natural_minimum_a98622f728b78fbd6d0f (m) (((@cleanNotation_vertex_number_64138f6f46dd27172356 ((n + 1)) (u)) - a)))) ((cleanNotation_natural_minimum_a98622f728b78fbd6d0f (m) (((@cleanNotation_vertex_number_64138f6f46dd27172356 ((n + 1)) (v)) - a)))) ((@cleanNotation_minimum_left_bound_18eddb4005f545937da0 (m) (((@cleanNotation_vertex_number_64138f6f46dd27172356 ((n + 1)) (u)) - a)))) ((@cleanNotation_minimum_left_bound_18eddb4005f545937da0 (m) (((@cleanNotation_vertex_number_64138f6f46dd27172356 ((n + 1)) (v)) - a)))) ((@cleanNotation_minimum_preserves_order_366e442832d54d11c011 (m) (((@cleanNotation_vertex_number_64138f6f46dd27172356 ((n + 1)) (u)) - a)) (((@cleanNotation_vertex_number_64138f6f46dd27172356 ((n + 1)) (v)) - a)) ((@cleanNotation_subtraction_preserves_order_545889f2dbbe43ac08cd (a) ((@cleanNotation_vertex_number_64138f6f46dd27172356 ((n + 1)) (u))) ((@cleanNotation_vertex_number_64138f6f46dd27172356 ((n + 1)) (v))) ((@cleanNotation_vertex_order_numbers_d0bb5e78e6107e76915f ((n + 1)) (u) (v) (h))))))))

noncomputable def cleanDefine_restricted_interval_labels_4699560db33250f6be06  (I : Type) (n : ℕ) (a : ℕ) (m : ℕ) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe (I) (n)) : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe ({x : I // x ∈ (@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))}) (m) :=
  (@cleanConstructor_interval_labels_c716f00fe8e77d75edb2 ({x : I // x ∈ (@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))}) (m) ((fun (clean_bound_0 : {x : I // x ∈ (@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))}) => (@cleanDefine_clipped_vertex_2105907b2c6d43692206 (n) (a) (m) (((@cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe.«lower» (I) (n) (L)) (@cleanNotation_selected_value_df54a12138d36423a390 (I) ((@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))) (clean_bound_0))))))) ((fun (clean_bound_1 : {x : I // x ∈ (@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))}) => (@cleanDefine_clipped_vertex_2105907b2c6d43692206 (n) (a) (m) (((@cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe.«upper» (I) (n) (L)) (@cleanNotation_selected_value_df54a12138d36423a390 (I) ((@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))) (clean_bound_1))))))) ((fun (clean_bound_2 : {x : I // x ∈ (@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))}) => (@cleanDefine_clipped_vertices_ordered_18639ea00d989c74f29e (n) (a) (m) (((@cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe.«lower» (I) (n) (L)) (@cleanNotation_selected_value_df54a12138d36423a390 (I) ((@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))) (clean_bound_2)))) (((@cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe.«upper» (I) (n) (L)) (@cleanNotation_selected_value_df54a12138d36423a390 (I) ((@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))) (clean_bound_2)))) (((@cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe.«ordered» (I) (n) (L)) (@cleanNotation_selected_value_df54a12138d36423a390 (I) ((@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))) (clean_bound_2))))))))

noncomputable def cleanNotation_element_value_44c9341f476da5cce234 {A : Type} (S : Set (A)) (x : {x : A // x ∈ S}) : A :=
  x.val

noncomputable def cleanNotation_element_membership_e14f01f6635e1d17b47e {A : Type} (S : Set (A)) (x : {x : A // x ∈ S}) : (((@cleanNotation_element_value_44c9341f476da5cce234 (A) (S) (x)) ∈ S)) :=
  x.property

noncomputable def cleanNotation_element_from_membership_9c436f2be1ab5193d023 {A : Type} (S : Set (A)) (x : A) (h : ((x ∈ S))) : {x : A // x ∈ S} :=
  Subtype.mk x h

noncomputable def cleanDefine_restricted_interval_vectors_17c9803c94f731a4263e {K : Type} (field : Field K) (n : ℕ) (a : ℕ) (m : ℕ) (h : (((a + m) ≤ n))) (d : (Fin n) → (Bool)) (hs : ((@cleanDefine_subpath_sources_preserved_46191249bc7c5cd92929 (n) (a) (m) (h) (d)))) (ht : ((@cleanDefine_subpath_targets_preserved_21dad01a350642fb797c (n) (a) (m) (h) (d)))) (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d)))) (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe (I) (n)) (vectors : (clean_pi_bound_10 : Fin (n + 1)) → ((I) → ((@ModuleCat.carrier K field.toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) clean_pi_bound_10))))) : (clean_pi_bound_11 : Fin (m + 1)) → (({x : I // x ∈ (@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))}) → ((@ModuleCat.carrier K field.toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (m + 1)) (Fin m) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (m) ((@cleanDefine_subpath_directions_d5b179a212a0b19f9880 (n) (a) (m) (h) (d))))) ((@cleanDefine_restricted_zigzag_60d15adfd9b03073eff1 (K) (field) (n) (a) (m) (h) (d) (hs) (ht) (Z)))) clean_pi_bound_11)))) :=
  (fun (clean_bound_0 : Fin (m + 1)) => (fun (clean_bound_1 : {x : I // x ∈ (@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))}) => (cleanNotation_evaluate_map_fc8e4f20170606ffe807 ((vectors (@cleanDefine_subpath_vertex_ed24b88b5532567c119f (n) (a) (m) (h) (clean_bound_0)))) ((@cleanNotation_element_value_44c9341f476da5cce234 (I) ((@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))) (clean_bound_1))))))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: clean
reference: restricted vector value
relationship: original
-/
def restricted_vector_value : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (n a m : ℕ),
  ∀ («bound» : ((a + m) ≤ n)),
  ∀ (d : (Fin n) → (Bool)),
  ∀ («sources» : (@cleanDefine_subpath_sources_preserved_46191249bc7c5cd92929 (n) (a) (m) («bound») (d))),
  ∀ («targets» : (@cleanDefine_subpath_targets_preserved_21dad01a350642fb797c (n) (a) (m) («bound») (d))),
  ∀ (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d)))),
  ∀ (I : Type),
  ∀ (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe (I) (n)),
  ∀ (vectors : (clean_pi_bound_12 : Fin (n + 1)) → ((I) → ((@ModuleCat.carrier K field.toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) clean_pi_bound_12))))),
  ∀ (v : Fin (m + 1)),
  ∀ (j : {x : I // x ∈ (@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))}),
  ((((@cleanDefine_restricted_interval_vectors_17c9803c94f731a4263e (K) (field) (n) (a) (m) («bound») (d) («sources») («targets») (Z) (I) (L) (vectors)) v) j) = (cleanNotation_evaluate_map_fc8e4f20170606ffe807 ((vectors (@cleanDefine_subpath_vertex_ed24b88b5532567c119f (n) (a) (m) («bound») (v)))) ((@cleanNotation_element_value_44c9341f476da5cce234 (I) ((@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))) (j)))))

/--
source: clean
reference: restricted vectors vanish
relationship: original
-/
def restricted_vectors_vanish : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (n a m : ℕ),
  ∀ («bound» : ((a + m) ≤ n)),
  ∀ (d : (Fin n) → (Bool)),
  ∀ («sources» : (@cleanDefine_subpath_sources_preserved_46191249bc7c5cd92929 (n) (a) (m) («bound») (d))),
  ∀ («targets» : (@cleanDefine_subpath_targets_preserved_21dad01a350642fb797c (n) (a) (m) («bound») (d))),
  ∀ (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d)))),
  ∀ (I : Type),
  ∀ (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe (I) (n)),
  ∀ (vectors : (clean_pi_bound_12 : Fin (n + 1)) → ((I) → ((@ModuleCat.carrier K field.toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) clean_pi_bound_12))))),
  ∀ («vanishes» : (@cleanDefine_interval_vectors_vanish_76b24f11b6da51eab033 (K) (field) (n) (d) (Z) (I) (L) (vectors))),
  (@cleanDefine_interval_vectors_vanish_76b24f11b6da51eab033 (K) (field) (m) ((@cleanDefine_subpath_directions_d5b179a212a0b19f9880 (n) (a) (m) («bound») (d))) ((@cleanDefine_restricted_zigzag_60d15adfd9b03073eff1 (K) (field) (n) (a) (m) («bound») (d) («sources») («targets») (Z))) ({x : I // x ∈ (@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))}) ((@cleanDefine_restricted_interval_labels_4699560db33250f6be06 (I) (n) (a) (m) (L))) ((@cleanDefine_restricted_interval_vectors_17c9803c94f731a4263e (K) (field) (n) (a) (m) («bound») (d) («sources») («targets») (Z) (I) (L) (vectors))))

/--
source: clean
reference: restricted vectors compatible
relationship: original
-/
def restricted_vectors_compatible : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (n a m : ℕ),
  ∀ («bound» : ((a + m) ≤ n)),
  ∀ (d : (Fin n) → (Bool)),
  ∀ («sources» : (@cleanDefine_subpath_sources_preserved_46191249bc7c5cd92929 (n) (a) (m) («bound») (d))),
  ∀ («targets» : (@cleanDefine_subpath_targets_preserved_21dad01a350642fb797c (n) (a) (m) («bound») (d))),
  ∀ (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d)))),
  ∀ (I : Type),
  ∀ (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe (I) (n)),
  ∀ (vectors : (clean_pi_bound_12 : Fin (n + 1)) → ((I) → ((@ModuleCat.carrier K field.toRing ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (Fin (n + 1)) (Fin n) ((@cleanDefine_zigzag_shape_aabf9ce777651ce61e96 (n) (d))) (Z)) clean_pi_bound_12))))),
  ∀ («compatible» : (@cleanDefine_interval_vectors_compatible_9ad73449cd688c6c847b (K) (field) (n) (d) (Z) (I) (L) (vectors))),
  (@cleanDefine_interval_vectors_compatible_9ad73449cd688c6c847b (K) (field) (m) ((@cleanDefine_subpath_directions_d5b179a212a0b19f9880 (n) (a) (m) («bound») (d))) ((@cleanDefine_restricted_zigzag_60d15adfd9b03073eff1 (K) (field) (n) (a) (m) («bound») (d) («sources») («targets») (Z))) ({x : I // x ∈ (@cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 (I) (n) (a) (m) (L))}) ((@cleanDefine_restricted_interval_labels_4699560db33250f6be06 (I) (n) (a) (m) (L))) ((@cleanDefine_restricted_interval_vectors_17c9803c94f731a4263e (K) (field) (n) (a) (m) («bound») (d) («sources») («targets») (Z) (I) (L) (vectors))))

end CleanStatements

namespace RestrictedVectorsOracle
noncomputable def vectors {K : Type} (field : Field K)
 (n a m : ℕ) (h : a+m ≤ n) (d : Fin n → Bool)
 (hs : cleanDefine_subpath_sources_preserved_46191249bc7c5cd92929 n a m h d) (ht : cleanDefine_subpath_targets_preserved_21dad01a350642fb797c n a m h d)
 (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field (Fin (n+1)) (Fin n) (cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d))
 (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe I n)
 (vectors : (u : Fin (n+1)) → I → @ModuleCat.carrier K field.toRing (Z.object u)) :
 (v : Fin (m+1)) → {j : I // j ∈ cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 I n a m L} →
   @ModuleCat.carrier K field.toRing ((cleanDefine_restricted_zigzag_60d15adfd9b03073eff1 field n a m h d hs ht Z).object v) :=
 fun v j => cleanNotation_evaluate_map_fc8e4f20170606ffe807 (vectors (cleanDefine_subpath_vertex_ed24b88b5532567c119f n a m h v)) (cleanNotation_element_value_44c9341f476da5cce234 (cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 I n a m L) j)

def valueStatement : Prop := ∀ (K : Type) (field : Field K)
 (n a m : ℕ) (bound : a+m ≤ n) (d : Fin n → Bool)
 (sources : cleanDefine_subpath_sources_preserved_46191249bc7c5cd92929 n a m bound d) (targets : cleanDefine_subpath_targets_preserved_21dad01a350642fb797c n a m bound d)
 (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field (Fin (n+1)) (Fin n) (cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d))
 (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe I n)
 (vectors : (u : Fin (n+1)) → I → @ModuleCat.carrier K field.toRing (Z.object u))
 (v : Fin (m+1)) (j : {j : I // j ∈ cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 I n a m L}),
 cleanDefine_restricted_interval_vectors_17c9803c94f731a4263e field n a m bound d sources targets Z I L vectors v j =
   cleanNotation_evaluate_map_fc8e4f20170606ffe807 (vectors (cleanDefine_subpath_vertex_ed24b88b5532567c119f n a m bound v)) (cleanNotation_element_value_44c9341f476da5cce234 (cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 I n a m L) j)
def vanishingStatement : Prop := ∀ (K : Type) (field : Field K)
 (n a m : ℕ) (bound : a+m ≤ n) (d : Fin n → Bool)
 (sources : cleanDefine_subpath_sources_preserved_46191249bc7c5cd92929 n a m bound d) (targets : cleanDefine_subpath_targets_preserved_21dad01a350642fb797c n a m bound d)
 (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field (Fin (n+1)) (Fin n) (cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d))
 (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe I n)
 (vectors : (u : Fin (n+1)) → I → @ModuleCat.carrier K field.toRing (Z.object u))
 (vanishes : cleanDefine_interval_vectors_vanish_76b24f11b6da51eab033 K field n d Z I L vectors),
 cleanDefine_interval_vectors_vanish_76b24f11b6da51eab033 K field m (cleanDefine_subpath_directions_d5b179a212a0b19f9880 n a m bound d)
   (cleanDefine_restricted_zigzag_60d15adfd9b03073eff1 field n a m bound d sources targets Z)
   {j : I // j ∈ cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 I n a m L} (cleanDefine_restricted_interval_labels_4699560db33250f6be06 I n a m L)
   (cleanDefine_restricted_interval_vectors_17c9803c94f731a4263e field n a m bound d sources targets Z I L vectors)
def compatibleStatement : Prop := ∀ (K : Type) (field : Field K)
 (n a m : ℕ) (bound : a+m ≤ n) (d : Fin n → Bool)
 (sources : cleanDefine_subpath_sources_preserved_46191249bc7c5cd92929 n a m bound d) (targets : cleanDefine_subpath_targets_preserved_21dad01a350642fb797c n a m bound d)
 (Z : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 K field (Fin (n+1)) (Fin n) (cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d))
 (I : Type) (L : cleanStructure_IntervalLabels_4e73cb2f4ca40b36affe I n)
 (vectors : (u : Fin (n+1)) → I → @ModuleCat.carrier K field.toRing (Z.object u))
 (compatible : cleanDefine_interval_vectors_compatible_9ad73449cd688c6c847b K field n d Z I L vectors),
 cleanDefine_interval_vectors_compatible_9ad73449cd688c6c847b K field m (cleanDefine_subpath_directions_d5b179a212a0b19f9880 n a m bound d)
   (cleanDefine_restricted_zigzag_60d15adfd9b03073eff1 field n a m bound d sources targets Z)
   {j : I // j ∈ cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651 I n a m L} (cleanDefine_restricted_interval_labels_4699560db33250f6be06 I n a m L)
   (cleanDefine_restricted_interval_vectors_17c9803c94f731a4263e field n a m bound d sources targets Z I L vectors)
end RestrictedVectorsOracle

open Lean Elab Command
private def canonical : Expr → Expr
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj n i (canonical b)
  | e => e
elab "same_basic_target " a:ident b:ident : command => do
  let env ← getEnv
  let some (.defnInfo x) := env.find? a.getId | throwError "Missing actual target"
  let some (.defnInfo y) := env.find? b.getId | throwError "Missing expected target"
  unless x.levelParams == y.levelParams &&
      Expr.equal (canonical x.type) (canonical y.type) &&
      Expr.equal (canonical x.value) (canonical y.value) do
    throwError "Canonical type or value differs"

same_basic_target cleanDefine_restricted_interval_vectors_17c9803c94f731a4263e RestrictedVectorsOracle.vectors
same_basic_target CleanStatements.restricted_vector_value RestrictedVectorsOracle.valueStatement
same_basic_target CleanStatements.restricted_vectors_vanish RestrictedVectorsOracle.vanishingStatement
same_basic_target CleanStatements.restricted_vectors_compatible RestrictedVectorsOracle.compatibleStatement

theorem restricted_vector_value_checked : CleanStatements.restricted_vector_value := by
 intro K field n a m bound d sources targets Z I L vectors v j
 rfl

theorem restricted_vectors_vanish_checked : CleanStatements.restricted_vectors_vanish := by
 intro K field n a m bound d sources targets Z I L vectors vanishes
 intro v j inactive
 apply vanishes (cleanDefine_subpath_vertex_ed24b88b5532567c119f n a m bound v) j.val
 intro active
 apply inactive
 simp only [cleanDefine_interval_labels_at_1f63148e436b0a274491, cleanNotation_set_of_25534029a1fdae044ce8, cleanDefine_restricted_interval_labels_4699560db33250f6be06, cleanConstructor_interval_labels_c716f00fe8e77d75edb2, cleanDefine_clipped_vertex_2105907b2c6d43692206, cleanNotation_natural_minimum_a98622f728b78fbd6d0f, cleanNotation_bounded_vertex_5747514b48fa95eb06be, cleanNotation_vertex_number_64138f6f46dd27172356, cleanDefine_subpath_vertex_ed24b88b5532567c119f, cleanNotation_offset_vertex_8893e544ed839c8e4060, cleanNotation_widen_vertex_69bf9fc558a039a86f3c, cleanNotation_transport_vertex_ae30515c2c6ff2e395df, cleanNotation_selected_value_df54a12138d36423a390, Set.mem_setOf_eq, Fin.le_iff_val_le_val] at active ⊢
 simp only [Fin.val_mk, Fin.coe_natAdd, Fin.coe_castLE, Fin.coe_cast] at *
 omega


private theorem transport_edge_value {K W : Type} (field : Field K)
 (M : W → @ModuleCat.{0,0} K field.toRing) (fs s t ft : W)
 (hs : fs = s) (ht : ft = t) (g : @ModuleCat.Hom K field.toRing (M s) (M t))
 (vectors : (w : W) → @ModuleCat.carrier K field.toRing (M w))
 (law : cleanNotation_module_map_value_f0835c4f7a36db98a213 field (M s) (M t) g (vectors s) = vectors t) :
 cleanNotation_module_map_value_f0835c4f7a36db98a213 field (M fs) (M ft)
   (cleanNotation_module_composition_115d9963c374fb45e52e field (M fs) (M t) (M ft)
     (cleanNotation_module_composition_115d9963c374fb45e52e field (M fs) (M s) (M t) (cleanNotation_module_family_transport_d6b9d443d0d35715792a field M fs s hs) g)
     (cleanNotation_module_family_transport_d6b9d443d0d35715792a field M t ft ht.symm)) (vectors fs) = vectors ft := by
 cases hs
 cases ht
 simpa [cleanNotation_module_map_value_f0835c4f7a36db98a213, cleanNotation_module_composition_115d9963c374fb45e52e, cleanNotation_module_family_transport_d6b9d443d0d35715792a] using law

theorem restricted_vectors_compatible_checked : CleanStatements.restricted_vectors_compatible := by
 intro K field n a m bound d sources targets Z I L vectors compatible
 intro edge j active
 have old_active : j.val ∈ cleanDefine_interval_labels_at_1f63148e436b0a274491 I n L
     (cleanDefine_subpath_vertex_ed24b88b5532567c119f n a m bound ((cleanDefine_zigzag_shape_aabf9ce777651ce61e96 m (cleanDefine_subpath_directions_d5b179a212a0b19f9880 n a m bound d)).source edge)) := by
   have survives := j.property
   simp only [cleanDefine_interval_labels_at_1f63148e436b0a274491, cleanNotation_set_of_25534029a1fdae044ce8, cleanDefine_restricted_interval_labels_4699560db33250f6be06, cleanConstructor_interval_labels_c716f00fe8e77d75edb2, cleanDefine_clipped_vertex_2105907b2c6d43692206, cleanNotation_natural_minimum_a98622f728b78fbd6d0f, cleanNotation_bounded_vertex_5747514b48fa95eb06be, cleanNotation_vertex_number_64138f6f46dd27172356, cleanDefine_subpath_vertex_ed24b88b5532567c119f, cleanNotation_offset_vertex_8893e544ed839c8e4060, cleanNotation_widen_vertex_69bf9fc558a039a86f3c, cleanNotation_transport_vertex_ae30515c2c6ff2e395df, cleanNotation_selected_value_df54a12138d36423a390, Set.mem_setOf_eq, Fin.le_iff_val_le_val, cleanDefine_zigzag_source_dc6df9137c1a7c80c3de, cleanDefine_surviving_interval_labels_c95e4788f0cd06a17651] at active survives ⊢
   simp only [Fin.val_mk, Fin.coe_natAdd, Fin.coe_castLE, Fin.coe_cast] at *
   omega
 have original_active : j.val ∈ cleanDefine_interval_labels_at_1f63148e436b0a274491 I n L ((cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d).source (cleanDefine_subpath_edge_c6bc2388be5e8cd17cf2 n a m bound edge)) := by
   rw [← sources edge]
   exact old_active
 exact transport_edge_value field Z.object
   (cleanDefine_subpath_vertex_ed24b88b5532567c119f n a m bound ((cleanDefine_zigzag_shape_aabf9ce777651ce61e96 m (cleanDefine_subpath_directions_d5b179a212a0b19f9880 n a m bound d)).source edge))
   ((cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d).source (cleanDefine_subpath_edge_c6bc2388be5e8cd17cf2 n a m bound edge))
   ((cleanDefine_zigzag_shape_aabf9ce777651ce61e96 n d).target (cleanDefine_subpath_edge_c6bc2388be5e8cd17cf2 n a m bound edge))
   (cleanDefine_subpath_vertex_ed24b88b5532567c119f n a m bound ((cleanDefine_zigzag_shape_aabf9ce777651ce61e96 m (cleanDefine_subpath_directions_d5b179a212a0b19f9880 n a m bound d)).target edge))
   (sources edge) (targets edge) (Z.arrow (cleanDefine_subpath_edge_c6bc2388be5e8cd17cf2 n a m bound edge))
   (fun u => vectors u j.val) (compatible (cleanDefine_subpath_edge_c6bc2388be5e8cd17cf2 n a m bound edge) j.val original_active)

-- generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
