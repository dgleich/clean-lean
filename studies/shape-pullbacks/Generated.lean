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

noncomputable def cleanNotation_equality_congruence_3e3f32efa32223213c0e {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) (y : X) (h : ((x = y))) : (((f x) = (f y))) :=
  congrArg f h

noncomputable def cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db {X : Type} (x : X) : ((x = x)) :=
  Eq.refl x

noncomputable def cleanNotation_equality_symmetry_9c171431d92e37157b4c {T : Type} (x : T) (y : T) (h : ((x = y))) : ((y = x)) :=
  Eq.symm h

noncomputable def cleanNotation_equality_transitivity_6a3ecc1273cd16127fa3 {T : Type} (x : T) (y : T) (z : T) (h : ((x = y))) (k : ((y = z))) : ((x = z)) :=
  Eq.trans h k

structure cleanStructure_DiagramShapeMap_226c818652aee71d710f («V» : Type) («E» : Type) («W» : Type) («F» : Type) («Q» : cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V») («E»)) («R» : cleanStructure_DiagramShape_02ab4e571d9987d4a63c («W») («F»)) : Type where
  «vertices» : («V») → («W»)
  «edges» : («E») → («F»)
  «sources» : (clean_pi_bound_2 : «E») → ((((«vertices» ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («V») («E») («Q»)) clean_pi_bound_2)) = ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («W») («F») («R»)) («edges» clean_pi_bound_2)))))
  «targets» : (clean_pi_bound_3 : «E») → ((((«vertices» ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («V») («E») («Q»)) clean_pi_bound_3)) = ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («W») («F») («R»)) («edges» clean_pi_bound_3)))))

noncomputable def cleanConstructor_shape_map_c0afd85485a15384aa81 («V» : Type) («E» : Type) («W» : Type) («F» : Type) («Q» : cleanStructure_DiagramShape_02ab4e571d9987d4a63c («V») («E»)) («R» : cleanStructure_DiagramShape_02ab4e571d9987d4a63c («W») («F»)) («vertices» : («V») → («W»)) («edges» : («E») → («F»)) («sources» : (clean_pi_bound_2 : «E») → ((((«vertices» ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («V») («E») («Q»)) clean_pi_bound_2)) = ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» («W») («F») («R»)) («edges» clean_pi_bound_2)))))) («targets» : (clean_pi_bound_3 : «E») → ((((«vertices» ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («V») («E») («Q»)) clean_pi_bound_3)) = ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» («W») («F») («R»)) («edges» clean_pi_bound_3)))))) : cleanStructure_DiagramShapeMap_226c818652aee71d710f («V») («E») («W») («F») («Q») («R») :=
  @cleanStructure_DiagramShapeMap_226c818652aee71d710f.mk «V» «E» «W» «F» «Q» «R» «vertices» «edges» «sources» «targets»

noncomputable def cleanDefine_identity_shape_map_579d101c3f56b37cff06  (V : Type) (E : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) : cleanStructure_DiagramShapeMap_226c818652aee71d710f (V) (E) (V) (E) (Q) (Q) :=
  (@cleanConstructor_shape_map_c0afd85485a15384aa81 (V) (E) (V) (E) (Q) (Q) ((fun (clean_bound_0 : V) => clean_bound_0)) ((fun (clean_bound_1 : E) => clean_bound_1)) ((fun (clean_bound_2 : E) => (@cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (V) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_2))))) ((fun (clean_bound_3 : E) => (@cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (V) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_3))))))

noncomputable def cleanDefine_composite_shape_map_18c19026cee62e20dbac  (V : Type) (E : Type) (W : Type) (F : Type) (U : Type) (J : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (R : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)) (S : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (U) (J)) (f : cleanStructure_DiagramShapeMap_226c818652aee71d710f (V) (E) (W) (F) (Q) (R)) (g : cleanStructure_DiagramShapeMap_226c818652aee71d710f (W) (F) (U) (J) (R) (S)) : cleanStructure_DiagramShapeMap_226c818652aee71d710f (V) (E) (U) (J) (Q) (S) :=
  (@cleanConstructor_shape_map_c0afd85485a15384aa81 (V) (E) (U) (J) (Q) (S) ((fun (clean_bound_0 : V) => ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_0)))) ((fun (clean_bound_1 : E) => ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1)))) ((fun (clean_bound_2 : E) => (@cleanNotation_equality_transitivity_6a3ecc1273cd16127fa3 (U) (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_2)))) (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_2)))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (U) (J) (S)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_2)))) ((@cleanNotation_equality_congruence_3e3f32efa32223213c0e (W) (U) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (W) (F) (U) (J) (R) (S) (g))) (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_2))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_2))) (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«sources» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_2)))) (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«sources» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_2)))))) ((fun (clean_bound_3 : E) => (@cleanNotation_equality_transitivity_6a3ecc1273cd16127fa3 (U) (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_3)))) (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_3)))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (U) (J) (S)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_3)))) ((@cleanNotation_equality_congruence_3e3f32efa32223213c0e (W) (U) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (W) (F) (U) (J) (R) (S) (g))) (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_3))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_3))) (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«targets» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_3)))) (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«targets» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_3)))))))

noncomputable def cleanDefine_shape_identity_bc05e2fda3553da1c168 {V : Type} {E : Type} (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) : cleanStructure_DiagramShapeMap_226c818652aee71d710f (V) (E) (V) (E) (Q) (Q) :=
  (@cleanDefine_identity_shape_map_579d101c3f56b37cff06 (V) (E) (Q))

noncomputable def cleanDefine_compose_shapes_a95a4ea8e6676884745a {V : Type} {E : Type} {W : Type} {F : Type} {U : Type} {J : Type} (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (R : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)) (S : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (U) (J)) (f : cleanStructure_DiagramShapeMap_226c818652aee71d710f (V) (E) (W) (F) (Q) (R)) (g : cleanStructure_DiagramShapeMap_226c818652aee71d710f (W) (F) (U) (J) (R) (S)) : cleanStructure_DiagramShapeMap_226c818652aee71d710f (V) (E) (U) (J) (Q) (S) :=
  (@cleanDefine_composite_shape_map_18c19026cee62e20dbac (V) (E) (W) (F) (U) (J) (Q) (R) (S) (f) (g))

noncomputable def cleanNotation_module_family_transport_d6b9d443d0d35715792a {K : Type} {T : Type} (field : Field K) (M : (T) → ((@ModuleCat.{0,0} K field.toRing))) (x : T) (y : T) (h : ((x = y))) : (@ModuleCat.Hom K field.toRing (M x) (M y)) :=
  @CategoryTheory.eqToHom (@ModuleCat.{0,0} K field.toRing) (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct (M x) (M y) (congrArg M h)

noncomputable def cleanDefine_diagram_pullback_1d312eae3edad3487f4a  (K : Type) (field : Field K) (V : Type) (E : Type) (W : Type) (F : Type) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (R : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)) (f : cleanStructure_DiagramShapeMap_226c818652aee71d710f (V) (E) (W) (F) (Q) (R)) (M : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (W) (F) (R)) : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q) :=
  (@cleanConstructor_module_diagram_d34ad79f6914baaf649a (K) (field) (V) (E) (Q) ((fun (clean_bound_0 : V) => ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_0)))) ((fun (clean_bound_1 : E) => (@cleanNotation_module_composition_115d9963c374fb45e52e (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_1)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_1)))) ((@cleanNotation_module_composition_115d9963c374fb45e52e (K) (field) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_1)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1)))) ((@cleanNotation_module_family_transport_d6b9d443d0d35715792a (K) (W) (field) ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M))) (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (V) (E) (Q)) clean_bound_1))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«source» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1))) (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«sources» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1)))) (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«arrow» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1))))) ((@cleanNotation_module_family_transport_d6b9d443d0d35715792a (K) (W) (field) ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1))) (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_1))) ((@cleanNotation_equality_symmetry_9c171431d92e37157b4c (W) (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (W) (F) (Q) (R) (f)) ((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (V) (E) (Q)) clean_bound_1))) (((@cleanStructure_DiagramShape_02ab4e571d9987d4a63c.«target» (W) (F) (R)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1))) (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«targets» (V) (E) (W) (F) (Q) (R) (f)) clean_bound_1))))))))))

noncomputable def cleanDefine_pull_back_diagram_9fb46e4c113301c0a120 {K : Type} {V : Type} {E : Type} {W : Type} {F : Type} (field : Field K) (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)) (R : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)) (f : cleanStructure_DiagramShapeMap_226c818652aee71d710f (V) (E) (W) (F) (Q) (R)) (M : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (W) (F) (R)) : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q) :=
  (@cleanDefine_diagram_pullback_1d312eae3edad3487f4a (K) (field) (V) (E) (W) (F) (Q) (R) (f) (M))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: topology
reference: shape maps and diagram pullbacks
relationship: original
-/
def identity_shape_vertex : Prop :=
  ∀ (V E : Type),
  ∀ (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)),
  ∀ (v : V),
  (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (V) (E) (Q) (Q) ((@cleanDefine_shape_identity_bc05e2fda3553da1c168 (V) (E) (Q)))) v) = v)

/--
source: topology
reference: shape maps and diagram pullbacks
relationship: original
-/
def composite_shape_vertex : Prop :=
  ∀ (V E W F : Type),
  ∀ (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)),
  ∀ (R : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)),
  ∀ (f : cleanStructure_DiagramShapeMap_226c818652aee71d710f (V) (E) (W) (F) (Q) (R)),
  ∀ (U J : Type),
  ∀ (S : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (U) (J)),
  ∀ (g : cleanStructure_DiagramShapeMap_226c818652aee71d710f (W) (F) (U) (J) (R) (S)),
  ∀ (v : V),
  (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (U) (J) (Q) (S) ((@cleanDefine_compose_shapes_a95a4ea8e6676884745a (V) (E) (W) (F) (U) (J) (Q) (R) (S) (f) (g)))) v) = ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (W) (F) (Q) (R) (f)) v)))

/--
source: topology
reference: shape maps and diagram pullbacks
relationship: original
-/
def composite_shape_edge : Prop :=
  ∀ (V E W F : Type),
  ∀ (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)),
  ∀ (R : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)),
  ∀ (f : cleanStructure_DiagramShapeMap_226c818652aee71d710f (V) (E) (W) (F) (Q) (R)),
  ∀ (U J : Type),
  ∀ (S : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (U) (J)),
  ∀ (g : cleanStructure_DiagramShapeMap_226c818652aee71d710f (W) (F) (U) (J) (R) (S)),
  ∀ (e : E),
  (((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (U) (J) (Q) (S) ((@cleanDefine_compose_shapes_a95a4ea8e6676884745a (V) (E) (W) (F) (U) (J) (Q) (R) (S) (f) (g)))) e) = ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (W) (F) (U) (J) (R) (S) (g)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«edges» (V) (E) (W) (F) (Q) (R) (f)) e)))

/--
source: topology
reference: shape maps and diagram pullbacks
relationship: original
-/
def shape_left_identity : Prop :=
  ∀ (V E W F : Type),
  ∀ (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)),
  ∀ (R : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)),
  ∀ (f : cleanStructure_DiagramShapeMap_226c818652aee71d710f (V) (E) (W) (F) (Q) (R)),
  ((@cleanDefine_compose_shapes_a95a4ea8e6676884745a (V) (E) (V) (E) (W) (F) (Q) (Q) (R) ((@cleanDefine_shape_identity_bc05e2fda3553da1c168 (V) (E) (Q))) (f)) = f)

/--
source: topology
reference: shape maps and diagram pullbacks
relationship: original
-/
def shape_right_identity : Prop :=
  ∀ (V E W F : Type),
  ∀ (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)),
  ∀ (R : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)),
  ∀ (f : cleanStructure_DiagramShapeMap_226c818652aee71d710f (V) (E) (W) (F) (Q) (R)),
  ((@cleanDefine_compose_shapes_a95a4ea8e6676884745a (V) (E) (W) (F) (W) (F) (Q) (R) (R) (f) ((@cleanDefine_shape_identity_bc05e2fda3553da1c168 (W) (F) (R)))) = f)

/--
source: topology
reference: shape maps and diagram pullbacks
relationship: original
-/
def module_transport_reflexivity : Prop :=
  ∀ (K T : Type),
  ∀ (field : Field K),
  ∀ (M : (T) → ((@ModuleCat.{0,0} K field.toRing))),
  ∀ (x : T),
  ((@cleanNotation_module_family_transport_d6b9d443d0d35715792a (K) (T) (field) (M) (x) (x) ((@cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (T) (x)))) = (@cleanNotation_module_identity_584a18e3c6f6747bc76f (K) (field) ((M x))))

/--
source: topology
reference: shape maps and diagram pullbacks
relationship: original
-/
def pullback_vertex_module : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (V E W F : Type),
  ∀ (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)),
  ∀ (R : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)),
  ∀ (f : cleanStructure_DiagramShapeMap_226c818652aee71d710f (V) (E) (W) (F) (Q) (R)),
  ∀ (M : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (W) (F) (R)),
  ∀ (v : V),
  (((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (V) (E) (Q) ((@cleanDefine_pull_back_diagram_9fb46e4c113301c0a120 (K) (V) (E) (W) (F) (field) (Q) (R) (f) (M)))) v) = ((@cleanStructure_ModuleDiagram_dce40a415c66aa5652c4.«object» (K) (field) (W) (F) (R) (M)) ((@cleanStructure_DiagramShapeMap_226c818652aee71d710f.«vertices» (V) (E) (W) (F) (Q) (R) (f)) v)))

/--
source: topology
reference: shape maps and diagram pullbacks
relationship: original
-/
def identity_pullback : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (V E : Type),
  ∀ (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)),
  ∀ (M : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (V) (E) (Q)),
  ((@cleanDefine_pull_back_diagram_9fb46e4c113301c0a120 (K) (V) (E) (V) (E) (field) (Q) (Q) ((@cleanDefine_shape_identity_bc05e2fda3553da1c168 (V) (E) (Q))) (M)) = M)

/--
source: topology
reference: composition of diagram pullbacks
relationship: original
-/
def composite_pullback : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (V E W F U J : Type),
  ∀ (Q : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (V) (E)),
  ∀ (R : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (W) (F)),
  ∀ (S : cleanStructure_DiagramShape_02ab4e571d9987d4a63c (U) (J)),
  ∀ (f : cleanStructure_DiagramShapeMap_226c818652aee71d710f (V) (E) (W) (F) (Q) (R)),
  ∀ (g : cleanStructure_DiagramShapeMap_226c818652aee71d710f (W) (F) (U) (J) (R) (S)),
  ∀ (M : cleanStructure_ModuleDiagram_dce40a415c66aa5652c4 (K) (field) (U) (J) (S)),
  ((@cleanDefine_pull_back_diagram_9fb46e4c113301c0a120 (K) (V) (E) (U) (J) (field) (Q) (S) ((@cleanDefine_compose_shapes_a95a4ea8e6676884745a (V) (E) (W) (F) (U) (J) (Q) (R) (S) (f) (g))) (M)) = (@cleanDefine_pull_back_diagram_9fb46e4c113301c0a120 (K) (V) (E) (W) (F) (field) (Q) (R) (f) ((@cleanDefine_pull_back_diagram_9fb46e4c113301c0a120 (K) (W) (F) (U) (J) (field) (R) (S) (g) (M)))))

end CleanStatements

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
