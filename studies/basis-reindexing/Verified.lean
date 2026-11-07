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
import Mathlib.Logic.Equiv.Defs

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

noncomputable def cleanType_ModuleBasis_296e16eac63a71b96e36 (K : Type) (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) (I : Type) : Type :=
  @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule

noncomputable def cleanNotation_module_basis_vector_b6882a4cd225e847e1a4 {K : Type} {I : Type} (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) (b : @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule) (i : I) : (@ModuleCat.carrier K field.toRing M) :=
  (letI : Field K := field; b i)

noncomputable def cleanNotation_module_zero_28d8dceda339c15e0abe {K : Type} (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) : (@ModuleCat.carrier K field.toRing M) :=
  @Zero.zero M.carrier M.isAddCommGroup.toZero

noncomputable def cleanNotation_equality_congruence_3e3f32efa32223213c0e {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) (y : X) (h : ((x = y))) : (((f x) = (f y))) :=
  congrArg f h

noncomputable def cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db {X : Type} (x : X) : ((x = x)) :=
  Eq.refl x

noncomputable def cleanNotation_evaluate_map_fc8e4f20170606ffe807 {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) : Y :=
  f x

noncomputable def cleanType_Equivalence_58fcab11d3757c8990fc (A : Type) (B : Type) : Type :=
  A ≃ B

noncomputable def cleanNotation_equivalence_9dc94fc17e20833d2fb8  (A : Type) (B : Type) (f : (A) → (B)) (g : (B) → (A)) (left : (clean_pi_bound_0 : A) → ((((g (f clean_pi_bound_0)) = clean_pi_bound_0)))) (right : (clean_pi_bound_1 : B) → ((((f (g clean_pi_bound_1)) = clean_pi_bound_1)))) : A ≃ B :=
  Equiv.mk f g left right

noncomputable def cleanNotation_equivalence_forward_ebd1d090984645228598 {A : Type} {B : Type} (e : A ≃ B) (x : A) : B :=
  e x

noncomputable def cleanNotation_equivalence_backward_e72e31c61ebe95923018 {A : Type} {B : Type} (e : A ≃ B) (y : B) : A :=
  e.symm y

noncomputable def cleanDefine_identity_equivalence_65a44dab62957ae3bb79  (A : Type) : A ≃ A :=
  (@cleanNotation_equivalence_9dc94fc17e20833d2fb8 (A) (A) ((fun (clean_bound_0 : A) => clean_bound_0)) ((fun (clean_bound_1 : A) => clean_bound_1)) ((fun (clean_bound_2 : A) => (@cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (A) (clean_bound_2)))) ((fun (clean_bound_3 : A) => (@cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (A) (clean_bound_3)))))

noncomputable def cleanNotation_reindex_module_basis_e4df7b3cfceb986c07ac {K : Type} {I : Type} {J : Type} (field : Field K) (M : (@ModuleCat.{0,0} K field.toRing)) (b : @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule) (e : I ≃ J) : @Module.Basis J K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule :=
  (letI : Field K := field; b.reindex e)


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: mathlib
reference: Module.Basis.reindex_apply
relationship: adapted
-/
def reindexed_basis_vector : Prop :=
  ∀ (K I J : Type),
  ∀ (field : Field K),
  ∀ (M : (@ModuleCat.{0,0} K field.toRing)),
  ∀ (b : @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule),
  ∀ (e : I ≃ J),
  ∀ (j : J),
  ((@cleanNotation_module_basis_vector_b6882a4cd225e847e1a4 (K) (J) (field) (M) ((@cleanNotation_reindex_module_basis_e4df7b3cfceb986c07ac (K) (I) (J) (field) (M) (b) (e))) (j)) = (@cleanNotation_module_basis_vector_b6882a4cd225e847e1a4 (K) (I) (field) (M) (b) ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (e) (j)))))

/--
source: mathlib
reference: Equiv.symm_apply_apply
relationship: adapted
-/
def equivalence_backward_forward : Prop :=
  ∀ (A B : Type),
  ∀ (e : A ≃ B),
  ∀ (x : A),
  ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (e) ((cleanNotation_equivalence_forward_ebd1d090984645228598 (e) (x)))) = x)

/--
source: mathlib
reference: Equiv.apply_symm_apply
relationship: adapted
-/
def equivalence_forward_backward : Prop :=
  ∀ (A B : Type),
  ∀ (e : A ≃ B),
  ∀ (y : B),
  ((cleanNotation_equivalence_forward_ebd1d090984645228598 (e) ((cleanNotation_equivalence_backward_e72e31c61ebe95923018 (e) (y)))) = y)

/--
source: mathlib
reference: Equiv.refl_apply
relationship: adapted
-/
def identity_equivalence_fixes_points : Prop :=
  ∀ (A : Type),
  ∀ (x : A),
  ((cleanNotation_equivalence_forward_ebd1d090984645228598 ((@cleanDefine_identity_equivalence_65a44dab62957ae3bb79 (A))) (x)) = x)

end CleanStatements

namespace ReindexOracle
noncomputable def equivalenceType (A B : Type) : Type := A ≃ B
noncomputable def make (A B : Type) (f : A → B) (g : B → A)
 (left : ∀ x : A, g (f x) = x) (right : ∀ y : B, f (g y) = y) : A ≃ B :=
 Equiv.mk f g left right
noncomputable def forward {A B : Type} (e : A ≃ B) (x : A) : B := e x
noncomputable def backward {A B : Type} (e : A ≃ B) (y : B) : A := e.symm y
noncomputable def identity (A : Type) : A ≃ A :=
 cleanNotation_equivalence_9dc94fc17e20833d2fb8 A A (fun x => x) (fun y => y) (fun x => cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db x) (fun y => cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db y)
noncomputable def reindex {K I J : Type} (field : Field K)
 (M : @ModuleCat.{0,0} K field.toRing)
 (b : @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule)
 (e : I ≃ J) : @Module.Basis J K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule :=
 letI : Field K := field
 b.reindex e

def vectorStatement : Prop := ∀ (K I J : Type) (field : Field K)
 (M : @ModuleCat.{0,0} K field.toRing)
 (b : @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule)
 (e : I ≃ J) (j : J), cleanNotation_module_basis_vector_b6882a4cd225e847e1a4 field M (cleanNotation_reindex_module_basis_e4df7b3cfceb986c07ac field M b e) j = cleanNotation_module_basis_vector_b6882a4cd225e847e1a4 field M b (cleanNotation_equivalence_backward_e72e31c61ebe95923018 e j)
def leftStatement : Prop := ∀ (A B : Type) (e : A ≃ B) (x : A), cleanNotation_equivalence_backward_e72e31c61ebe95923018 e (cleanNotation_equivalence_forward_ebd1d090984645228598 e x) = x
def rightStatement : Prop := ∀ (A B : Type) (e : A ≃ B) (y : B), cleanNotation_equivalence_forward_ebd1d090984645228598 e (cleanNotation_equivalence_backward_e72e31c61ebe95923018 e y) = y
def identityStatement : Prop := ∀ (A : Type) (x : A), cleanNotation_equivalence_forward_ebd1d090984645228598 (cleanDefine_identity_equivalence_65a44dab62957ae3bb79 A) x = x
end ReindexOracle

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
same_basic_target cleanType_Equivalence_58fcab11d3757c8990fc ReindexOracle.equivalenceType
same_basic_target cleanNotation_equivalence_9dc94fc17e20833d2fb8 ReindexOracle.make
same_basic_target cleanNotation_equivalence_forward_ebd1d090984645228598 ReindexOracle.forward
same_basic_target cleanNotation_equivalence_backward_e72e31c61ebe95923018 ReindexOracle.backward
same_basic_target cleanDefine_identity_equivalence_65a44dab62957ae3bb79 ReindexOracle.identity
same_basic_target cleanNotation_reindex_module_basis_e4df7b3cfceb986c07ac ReindexOracle.reindex
same_basic_target CleanStatements.reindexed_basis_vector ReindexOracle.vectorStatement
same_basic_target CleanStatements.equivalence_backward_forward ReindexOracle.leftStatement
same_basic_target CleanStatements.equivalence_forward_backward ReindexOracle.rightStatement
same_basic_target CleanStatements.identity_equivalence_fixes_points ReindexOracle.identityStatement

theorem reindexed_vector_checked : CleanStatements.reindexed_basis_vector := by
 intro K I J field M b e j
 letI : Field K := field
 exact b.reindex_apply e j

theorem equivalence_left_checked : CleanStatements.equivalence_backward_forward := by
 intro A B e x
 exact e.symm_apply_apply x

theorem equivalence_right_checked : CleanStatements.equivalence_forward_backward := by
 intro A B e y
 exact e.apply_symm_apply y

theorem identity_checked : CleanStatements.identity_equivalence_fixes_points := by
 intro A x
 rfl

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
