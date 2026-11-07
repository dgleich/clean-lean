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

noncomputable def cleanNotation_equality_congruence_3e3f32efa32223213c0e {X : Type} {Y : Type} (f : (X) → (Y)) (x : X) (y : X) (h : ((x = y))) : (((f x) = (f y))) :=
  congrArg f h

noncomputable def cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db {X : Type} (x : X) : ((x = x)) :=
  Eq.refl x

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

noncomputable def cleanDefine_finite_reflexivity_7070c639d64b69f253c3  (n : ℕ) : (clean_pi_bound_0 : Fin n) → (((clean_pi_bound_0 = clean_pi_bound_0))) :=
  (fun (clean_bound_0 : Fin n) => (@cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (Fin n) (clean_bound_0)))

noncomputable def cleanDefine_proof_identity_3f5d45d627fa3553bea6  (n : ℕ) : (((n = n))) → (((n = n))) :=
  (fun (clean_bound_0 : ((n = n))) => clean_bound_0)

noncomputable def cleanDefine_module_reflexivity_ad7761a92b59c86d181d  (K : Type) (field : Field K) : (clean_pi_bound_1 : (@ModuleCat.{0,0} K field.toRing)) → ((clean_pi_bound_2 : (@ModuleCat.carrier K field.toRing clean_pi_bound_1)) → (((clean_pi_bound_2 = clean_pi_bound_2)))) :=
  (fun (clean_bound_0 : (@ModuleCat.{0,0} K field.toRing)) => (fun (clean_bound_1 : (@ModuleCat.carrier K field.toRing clean_bound_0)) => (@cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db ((@ModuleCat.carrier K field.toRing clean_bound_0)) (clean_bound_1))))

noncomputable def cleanDefine_proof_to_natural_86f43c226508d4d6bb96  (n : ℕ) : (((n = n))) → (ℕ) :=
  (fun (clean_bound_0 : ((n = n))) => n)

noncomputable def cleanDefine_module_identity_family_62515deacbf568671e07  (K : Type) (field : Field K) : ((@ModuleCat.{0,0} K field.toRing)) → ((@ModuleCat.{0,0} K field.toRing)) :=
  (fun (clean_bound_0 : (@ModuleCat.{0,0} K field.toRing)) => clean_bound_0)


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: topology
reference: dependent proof family application
relationship: original
-/
def finite_family_application : Prop :=
  ∀ (n : ℕ),
  let f : (clean_pi_bound_3 : Fin n) → (((clean_pi_bound_3 = clean_pi_bound_3))) := (@cleanDefine_finite_reflexivity_7070c639d64b69f253c3 (n));
  ∀ (v : Fin n),
  let h : ((v = v)) := (f v);
  (v = v)

/--
source: topology
reference: proof family over Fin zero
relationship: original
-/
def empty_family : Prop :=
  ∀ (f : (clean_pi_bound_3 : Fin 0) → (((clean_pi_bound_3 = clean_pi_bound_3)))),
  ∀ (v : Fin 0),
  let h : ((v = v)) := (f v);
  (v = v)

/--
source: topology
reference: proof family over Fin one
relationship: original
-/
def singleton_family : Prop :=
  ∀ (f : (clean_pi_bound_3 : Fin 1) → (((clean_pi_bound_3 = clean_pi_bound_3)))),
  ∀ (v : Fin 1),
  let h : ((v = v)) := (f v);
  (v = v)

/--
source: topology
reference: explicit proof-domain function
relationship: original
-/
def proof_domain_application : Prop :=
  ∀ (n : ℕ),
  ∀ («same» : (n = n)),
  let f : (((n = n))) → (((n = n))) := (@cleanDefine_proof_identity_3f5d45d627fa3553bea6 (n));
  let h : ((n = n)) := (f «same»);
  (n = n)

/--
source: topology
reference: higher-universe proof family application
relationship: original
-/
def module_family_application : Prop :=
  ∀ (K : Type),
  ∀ (field : Field K),
  ∀ (M : (@ModuleCat.{0,0} K field.toRing)),
  ∀ (x : (@ModuleCat.carrier K field.toRing M)),
  let f : (clean_pi_bound_3 : (@ModuleCat.{0,0} K field.toRing)) → ((clean_pi_bound_4 : (@ModuleCat.carrier K field.toRing clean_pi_bound_3)) → (((clean_pi_bound_4 = clean_pi_bound_4)))) := (@cleanDefine_module_reflexivity_ad7761a92b59c86d181d (K) (field));
  let g : (clean_pi_bound_5 : (@ModuleCat.carrier K field.toRing M)) → (((clean_pi_bound_5 = clean_pi_bound_5))) := (f M);
  let h : ((x = x)) := (g x);
  (x = x)

end CleanStatements

namespace ProofFamilyOracle
noncomputable def finite (n : ℕ) : (v : Fin n) → v = v :=
  fun v : Fin n => @cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (Fin n) v
noncomputable def proofIdentity (n : ℕ) : (n = n) → (n = n) :=
  fun h : n = n => h
noncomputable def modules (K : Type) (field : Field K) :
  (M : @ModuleCat.{0,0} K field.toRing) → (x : @ModuleCat.carrier K field.toRing M) → x = x :=
  fun M : @ModuleCat.{0,0} K field.toRing =>
    fun x : @ModuleCat.carrier K field.toRing M => @cleanNotation_equality_reflexivity_72bfc1f43c6e40a818db (@ModuleCat.carrier K field.toRing M) x
noncomputable def proofToNatural (n : ℕ) : (n = n) → ℕ := fun _ : n = n => n
noncomputable def moduleIdentity (K : Type) (field : Field K) :
  (@ModuleCat.{0,0} K field.toRing) → (@ModuleCat.{0,0} K field.toRing) :=
  fun M : @ModuleCat.{0,0} K field.toRing => M
def application : Prop := ∀ (n : ℕ),
  let f : (v : Fin n) → v = v := @finite n
  ∀ (v : Fin n), let h : v = v := f v; v = v
def empty : Prop := ∀ (f : (v : Fin 0) → v = v) (v : Fin 0),
  let h : v = v := f v; v = v
def singleton : Prop := ∀ (f : (v : Fin 1) → v = v) (v : Fin 1),
  let h : v = v := f v; v = v
def proofApplication : Prop := ∀ (n : ℕ) (same : n = n),
  let f : (n = n) → (n = n) := @proofIdentity n
  let h : n = n := f same
  n = n
def moduleApplication : Prop := ∀ (K : Type) (field : Field K)
  (M : @ModuleCat.{0,0} K field.toRing) (x : @ModuleCat.carrier K field.toRing M),
  let f : (N : @ModuleCat.{0,0} K field.toRing) → (y : @ModuleCat.carrier K field.toRing N) → y = y := @modules K field
  let g : (y : @ModuleCat.carrier K field.toRing M) → y = y := f M
  let h : x = x := g x
  x = x
end ProofFamilyOracle

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `ProofFamilyOracle.finite then return `cleanDefine_finite_reflexivity_7070c639d64b69f253c3
  if n == `ProofFamilyOracle.proofIdentity then return `cleanDefine_proof_identity_3f5d45d627fa3553bea6
  if n == `ProofFamilyOracle.modules then return `cleanDefine_module_reflexivity_ad7761a92b59c86d181d
  if n == `ProofFamilyOracle.proofToNatural then return `cleanDefine_proof_to_natural_86f43c226508d4d6bb96
  if n == `ProofFamilyOracle.moduleIdentity then return `cleanDefine_module_identity_family_62515deacbf568671e07
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
  | .ctorInfo x,.ctorInfo y =>
    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&
      canonicalName x.induct == canonicalName y.induct do throwError "Constructor differs"
  | .inductInfo x,.inductInfo y =>
    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&
      x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do throwError "Record differs"
  | _,_ => throwError "Unexpected declaration kinds"
same_target cleanDefine_finite_reflexivity_7070c639d64b69f253c3 ProofFamilyOracle.finite
same_target cleanDefine_proof_identity_3f5d45d627fa3553bea6 ProofFamilyOracle.proofIdentity
same_target cleanDefine_module_reflexivity_ad7761a92b59c86d181d ProofFamilyOracle.modules
same_target cleanDefine_proof_to_natural_86f43c226508d4d6bb96 ProofFamilyOracle.proofToNatural
same_target cleanDefine_module_identity_family_62515deacbf568671e07 ProofFamilyOracle.moduleIdentity
same_target CleanStatements.finite_family_application ProofFamilyOracle.application
same_target CleanStatements.empty_family ProofFamilyOracle.empty
same_target CleanStatements.singleton_family ProofFamilyOracle.singleton
same_target CleanStatements.proof_domain_application ProofFamilyOracle.proofApplication
same_target CleanStatements.module_family_application ProofFamilyOracle.moduleApplication
elab "declaration_sort " n:ident k:num : command => do
  let env ← getEnv
  let some info := env.find? n.getId | throwError "Missing declaration"
  liftTermElabM do
    let s ← Lean.Meta.whnf (← Lean.Meta.inferType info.type)
    unless s == Expr.sort (Lean.Level.ofNat k.getNat) do
      throwError "Incorrect sort of declaration type: {s}"
declaration_sort cleanDefine_finite_reflexivity_7070c639d64b69f253c3 0
declaration_sort cleanDefine_proof_identity_3f5d45d627fa3553bea6 0
declaration_sort cleanDefine_module_reflexivity_ad7761a92b59c86d181d 0
declaration_sort cleanDefine_proof_to_natural_86f43c226508d4d6bb96 1
declaration_sort cleanDefine_module_identity_family_62515deacbf568671e07 2
namespace ProofFamilyChecks
 theorem application : CleanStatements.finite_family_application := by
  intro n f v h
  exact h
 theorem empty : CleanStatements.empty_family := by
  intro f v h
  exact h
 theorem singleton : CleanStatements.singleton_family := by
  intro f v h
  exact h
 theorem proof_application : CleanStatements.proof_domain_application := by
  intro n same f h
  exact h
 theorem module_application : CleanStatements.module_family_application := by
  intro K field M x f g h
  exact h
end ProofFamilyChecks

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
