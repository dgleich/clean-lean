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

/-!
Basic topology with explicit carrier types and topologies.
   Mathematical preimages, images, composition, and continuity are authored here.
   This first module is restricted to carrier types in Lean Type 0.
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


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/-!
These are algebraic ingredients for perturbation-indexed well groups.
The ambient space and scalar structure are fixed explicitly.
This file does not assert the two-extreme-perturbation characterization.
-/

/--
source: mathlib
reference: Submodule.mem_sInf
relationship: adapted
-/
def indexed_intersection_membership : Prop :=
  ∀ (K V I : Type),
  ∀ (f : Field K),
  ∀ (L : cleanStructure_LinearSpace_5642406e6e2374eb8d06 (K) (f) (V)),
  ∀ (A : Set (I)),
  ∀ (S : (I) → (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action)),
  ∀ (x : V),
  ((@cleanDefine_belongs_to_subspace_ec8790b9b2bf97dae6d9 (K) (V) (f) (L) (x) ((@cleanDefine_intersection_of_subspaces_639a4229345a029542f3 (K) (V) (I) (f) (L) (A) (S)))) ↔ (∀ (clean_bound_0 : I), ((clean_bound_0 ∈ A) → (@cleanDefine_belongs_to_subspace_ec8790b9b2bf97dae6d9 (K) (V) (f) (L) (x) ((S clean_bound_0))))))

/--
source: mathlib
reference: Submodule.mem_sInf
relationship: adapted
-/
def intersection_is_included_in_each_member : Prop :=
  ∀ (K V I : Type),
  ∀ (f : Field K),
  ∀ (L : cleanStructure_LinearSpace_5642406e6e2374eb8d06 (K) (f) (V)),
  ∀ (A : Set (I)),
  ∀ (S : (I) → (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action)),
  ∀ (i : I),
  ∀ («admissible_index» : (i ∈ A)),
  (@cleanDefine_subspace_included_in_d5798f9beb1245834242 (K) (V) (f) (L) ((@cleanDefine_intersection_of_subspaces_639a4229345a029542f3 (K) (V) (I) (f) (L) (A) (S))) ((S i)))

/--
source: mathlib
reference: Submodule.mem_sInf
relationship: adapted
-/
def more_indices_give_a_smaller_intersection : Prop :=
  ∀ (K V I : Type),
  ∀ (f : Field K),
  ∀ (L : cleanStructure_LinearSpace_5642406e6e2374eb8d06 (K) (f) (V)),
  ∀ (A : Set (I)),
  ∀ (S : (I) → (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action)),
  ∀ (B : Set (I)),
  ∀ («more_indices» : (A ⊆ B)),
  (@cleanDefine_subspace_included_in_d5798f9beb1245834242 (K) (V) (f) (L) ((@cleanDefine_intersection_of_subspaces_639a4229345a029542f3 (K) (V) (I) (f) (L) (B) (S))) ((@cleanDefine_intersection_of_subspaces_639a4229345a029542f3 (K) (V) (I) (f) (L) (A) (S))))

/--
source: mathlib
reference: Submodule.mem_sInf
relationship: adapted
-/
def empty_family_contains_every_vector : Prop :=
  ∀ (K V I : Type),
  ∀ (f : Field K),
  ∀ (L : cleanStructure_LinearSpace_5642406e6e2374eb8d06 (K) (f) (V)),
  ∀ (A : Set (I)),
  ∀ (S : (I) → (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action)),
  ∀ (x : V),
  ∀ («no_admissible_indices» : (∀ (clean_bound_0 : I), (¬(clean_bound_0 ∈ A)))),
  (@cleanDefine_belongs_to_subspace_ec8790b9b2bf97dae6d9 (K) (V) (f) (L) (x) ((@cleanDefine_intersection_of_subspaces_639a4229345a029542f3 (K) (V) (I) (f) (L) (A) (S))))

end CleanStatements

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `SubspaceOracle.LinearSpace then return `cleanStructure_LinearSpace_5642406e6e2374eb8d06
  if n == `SubspaceOracle.fieldType then return `cleanType_FieldStructure_473fae039b953a4e35cf
  if n == `SubspaceOracle.additiveType then return `cleanType_AdditiveGroup_666602168ae423a21d05
  if n == `SubspaceOracle.moduleType then return `cleanType_ModuleStructure_820ec14dd63d4f0c4588
  if n == `SubspaceOracle.subspaceType then return `cleanType_Subspace_8486bbfd1e163b11a16f
  if n == `SubspaceOracle.makeSpace then return `cleanConstructor_linear_space_b20108f764cf57d518bf
  if n == `SubspaceOracle.carrier then return `cleanNotation_subspace_carrier_f070e04df90854f81887
  if n == `SubspaceOracle.belongs then return `cleanDefine_belongs_to_subspace_ec8790b9b2bf97dae6d9
  if n == `SubspaceOracle.included then return `cleanDefine_subspace_included_in_d5798f9beb1245834242
  if n == `SubspaceOracle.infimum then return `cleanNotation_subspace_infimum_5fa957304ce3d9bcc086
  if n == `SubspaceOracle.intersection then return `cleanDefine_intersection_of_subspaces_639a4229345a029542f3
  if n == `SubspaceOracle.setOf then return `cleanNotation_set_of_25534029a1fdae044ce8
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

namespace SubspaceOracle
noncomputable def fieldType (K : Type) : Type := Field K
noncomputable def additiveType (V : Type) : Type := AddCommGroup V
noncomputable def moduleType (K : Type) (f : Field K) (V : Type) (a : AddCommGroup V) : Type :=
  @Module K V f.toSemiring a.toAddCommMonoid
structure LinearSpace (K : Type) (f : Field K) (V : Type) : Type where
  addition : AddCommGroup V
  action : @Module K V f.toSemiring addition.toAddCommMonoid
noncomputable def makeSpace (K : Type) (f : Field K) (V : Type) (a : AddCommGroup V)
    (m : @Module K V f.toSemiring a.toAddCommMonoid) : LinearSpace K f V :=
  @LinearSpace.mk K f V a m
noncomputable def subspaceType (K : Type) (f : Field K) (V : Type) (L : LinearSpace K f V) : Type :=
  @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action
noncomputable def carrier {K V : Type} (f : Field K) (L : LinearSpace K f V)
    (U : @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) : Set V :=
  @SetLike.coe (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) V
    (@Submodule.setLike K V f.toSemiring L.addition.toAddCommMonoid L.action) U
noncomputable def belongs {K V : Type} (f : Field K) (L : LinearSpace K f V) (x : V)
    (U : @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) : Prop :=
  x ∈ @carrier K V f L U
noncomputable def included {K V : Type} (f : Field K) (L : LinearSpace K f V)
    (U W : @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) : Prop :=
  ∀ x : V, @belongs K V f L x U → @belongs K V f L x W
noncomputable def infimum {K V : Type} (f : Field K) (L : LinearSpace K f V)
    (S : Set (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action)) :
    @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action :=
  @sInf (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action)
    (@Submodule.instInfSet K V f.toSemiring L.addition.toAddCommMonoid L.action) S
noncomputable def setOf {X : Type} (condition : X → Prop) : Set X := _root_.setOf condition
noncomputable def intersection {K V I : Type} (f : Field K) (L : LinearSpace K f V)
    (A : Set I) (spaces : I → @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) :
    @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action :=
  @infimum K V f L (@setOf (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action)
    (fun U => @Exists I (fun i => i ∈ A ∧ U=spaces i)))

def membershipStatement : Prop := ∀ (K V I : Type) (f : Field K) (L : LinearSpace K f V)
  (A : Set I) (spaces : I → @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) (x : V),
  @belongs K V f L x (@intersection K V I f L A spaces) ↔
    ∀ i : I, i ∈ A → @belongs K V f L x (spaces i)
def includedStatement : Prop := ∀ (K V I : Type) (f : Field K) (L : LinearSpace K f V)
  (A : Set I) (spaces : I → @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) (i : I),
  i ∈ A → @included K V f L (@intersection K V I f L A spaces) (spaces i)
def antitoneStatement : Prop := ∀ (K V I : Type) (f : Field K) (L : LinearSpace K f V)
  (A : Set I) (spaces : I → @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) (B : Set I),
  A ⊆ B → @included K V f L (@intersection K V I f L B spaces) (@intersection K V I f L A spaces)
def emptyStatement : Prop := ∀ (K V I : Type) (f : Field K) (L : LinearSpace K f V)
  (A : Set I) (spaces : I → @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) (x : V),
  (∀ i : I, ¬ i ∈ A) → @belongs K V f L x (@intersection K V I f L A spaces)
end SubspaceOracle
same_target cleanStructure_LinearSpace_5642406e6e2374eb8d06 SubspaceOracle.LinearSpace
same_target cleanType_FieldStructure_473fae039b953a4e35cf SubspaceOracle.fieldType
same_target cleanType_AdditiveGroup_666602168ae423a21d05 SubspaceOracle.additiveType
same_target cleanType_ModuleStructure_820ec14dd63d4f0c4588 SubspaceOracle.moduleType
same_target cleanType_Subspace_8486bbfd1e163b11a16f SubspaceOracle.subspaceType
same_target cleanConstructor_linear_space_b20108f764cf57d518bf SubspaceOracle.makeSpace
same_target cleanNotation_subspace_carrier_f070e04df90854f81887 SubspaceOracle.carrier
same_target cleanDefine_belongs_to_subspace_ec8790b9b2bf97dae6d9 SubspaceOracle.belongs
same_target cleanDefine_subspace_included_in_d5798f9beb1245834242 SubspaceOracle.included
same_target cleanNotation_subspace_infimum_5fa957304ce3d9bcc086 SubspaceOracle.infimum
same_target cleanDefine_intersection_of_subspaces_639a4229345a029542f3 SubspaceOracle.intersection
same_target cleanNotation_set_of_25534029a1fdae044ce8 SubspaceOracle.setOf
same_target cleanStructure_LinearSpace_5642406e6e2374eb8d06.mk SubspaceOracle.LinearSpace.mk
same_target cleanStructure_LinearSpace_5642406e6e2374eb8d06.addition SubspaceOracle.LinearSpace.addition
same_target cleanStructure_LinearSpace_5642406e6e2374eb8d06.action SubspaceOracle.LinearSpace.action
same_target CleanStatements.indexed_intersection_membership SubspaceOracle.membershipStatement
same_target CleanStatements.intersection_is_included_in_each_member SubspaceOracle.includedStatement
same_target CleanStatements.more_indices_give_a_smaller_intersection SubspaceOracle.antitoneStatement
same_target CleanStatements.empty_family_contains_every_vector SubspaceOracle.emptyStatement

namespace SubspaceProofs
theorem indexed_intersection_membership : CleanStatements.indexed_intersection_membership := by
  intro K V I f L A spaces x
  letI : Field K := f
  letI : AddCommGroup V := L.addition
  letI : Module K V := L.action
  change x ∈ sInf {U : Submodule K V | ∃ i : I, i ∈ A ∧ U = spaces i} ↔
    ∀ i : I, i ∈ A → x ∈ spaces i
  constructor
  · intro hx i hi
    exact (Submodule.mem_sInf.mp hx) (spaces i) ⟨i,hi,rfl⟩
  · intro hx
    apply Submodule.mem_sInf.mpr
    intro U hU
    obtain ⟨i,hi,rfl⟩ := hU
    exact hx i hi

theorem intersection_is_included_in_each_member : CleanStatements.intersection_is_included_in_each_member := by
  intro K V I f L A spaces i hi x hx
  exact (indexed_intersection_membership K V I f L A spaces x).mp hx i hi

theorem more_indices_give_a_smaller_intersection : CleanStatements.more_indices_give_a_smaller_intersection := by
  intro K V I f L A spaces B hAB x hx
  apply (indexed_intersection_membership K V I f L A spaces x).mpr
  intro i hi
  exact (indexed_intersection_membership K V I f L B spaces x).mp hx i (hAB hi)

theorem empty_family_contains_every_vector : CleanStatements.empty_family_contains_every_vector := by
  intro K V I f L A spaces x hnone
  apply (indexed_intersection_membership K V I f L A spaces x).mpr
  intro i hi
  exact False.elim (hnone i hi)
end SubspaceProofs

-- generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
