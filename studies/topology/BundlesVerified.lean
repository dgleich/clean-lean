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
import Mathlib.Topology.Path

/-!
Basic topology with explicit carrier types and topologies.
   Mathematical preimages, images, composition, and continuity are authored here.
   This first module is restricted to carrier types in Lean Type 0.
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

structure cleanStructure_ScalarMap_b571a474391ee4a1048f  : Type where
  «map» : (ℝ) → (ℝ)

noncomputable def cleanConstructor_scalar_map_f78247db9d7c5f5369a0 («map» : (ℝ) → (ℝ)) : cleanStructure_ScalarMap_b571a474391ee4a1048f :=
  @cleanStructure_ScalarMap_b571a474391ee4a1048f.mk «map»

structure cleanStructure_SizedVector_e3bb6d8f3a27db756907  : Type where
  «size» : ℕ
  «vector» : Fin «size» → ℝ

noncomputable def cleanConstructor_sized_vector_236d49ac38f05d98affb («size» : ℕ) («vector» : Fin «size» → ℝ) : cleanStructure_SizedVector_e3bb6d8f3a27db756907 :=
  @cleanStructure_SizedVector_e3bb6d8f3a27db756907.mk «size» «vector»

noncomputable def cleanNotation_opaque_endpoints_d1fd4290aaef6a02d3f2  (I : cleanStructure_Endpoints_2512a023e0474ce195ac) : cleanStructure_Endpoints_2512a023e0474ce195ac :=
  I


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: topology
reference: endpoint constructor
relationship: original
-/
def endpoint_constructor : Prop :=
  ∀ (a b : ℝ),
  let I : cleanStructure_Endpoints_2512a023e0474ce195ac := (@cleanConstructor_endpoints_ae57156441e5057814f6 (a) (b));
  (((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» (I)) = a) ∧ ((@cleanStructure_Endpoints_2512a023e0474ce195ac.«upper» (I)) = b))

/--
source: topology
reference: translating ordered endpoints
relationship: original
-/
def shifting_endpoints_preserves_order : Prop :=
  ∀ (I : cleanStructure_Endpoints_2512a023e0474ce195ac),
  ∀ (s : ℝ),
  ∀ («ordering_of_I» : (cleanDefine_ordered_endpoints_867d201d7c772f8385d6 (I))),
  (cleanDefine_ordered_endpoints_867d201d7c772f8385d6 ((cleanDefine_shifted_endpoints_0341e7d28e14c6ec5711 (I) (s))))

/--
source: topology
reference: dependent path projection
relationship: original
-/
def bundled_path_has_its_declared_endpoints : Prop :=
  ∀ (X : Type),
  ∀ (P : cleanStructure_BasedPath_af4022cf2eeed1e2d1ab (X)),
  (@Exists (@Path X (@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«topology» (X) (P)) (@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«start» (X) (P)) (@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«finish» (X) (P))) (fun (clean_bound_0 : @Path X (@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«topology» (X) (P)) (@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«start» (X) (P)) (@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«finish» (X) (P))) => (clean_bound_0 = (@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«path» (X) (P)))))

/--
source: topology
reference: bundled path involution
relationship: original
-/
def reversing_a_bundled_path_twice : Prop :=
  ∀ (X : Type),
  ∀ (P : cleanStructure_BasedPath_af4022cf2eeed1e2d1ab (X)),
  ((@cleanDefine_reversed_bundle_9779f436492a7430ddec (X) ((@cleanDefine_reversed_bundle_9779f436492a7430ddec (X) (P)))) = P)

/--
source: topology
reference: function field application
relationship: original
-/
def function_field_application : Prop :=
  ∀ (f : (ℝ) → (ℝ)),
  ∀ (x : ℝ),
  let P : cleanStructure_ScalarMap_b571a474391ee4a1048f := (@cleanConstructor_scalar_map_f78247db9d7c5f5369a0 (f));
  (((@cleanStructure_ScalarMap_b571a474391ee4a1048f.«map» (P)) x) = (f x))

/--
source: topology
reference: natural field dependency
relationship: original
-/
def vector_field_dimensions : Prop :=
  ∀ (V : cleanStructure_SizedVector_e3bb6d8f3a27db756907),
  (@Exists (Fin (@cleanStructure_SizedVector_e3bb6d8f3a27db756907.«size» (V)) → ℝ) (fun (clean_bound_0 : Fin (@cleanStructure_SizedVector_e3bb6d8f3a27db756907.«size» (V)) → ℝ) => (clean_bound_0 = (@cleanStructure_SizedVector_e3bb6d8f3a27db756907.«vector» (V)))))

/--
source: topology
reference: constructor field computation
relationship: original
-/
def computed_constructor_projection : Prop :=
  ∀ (a b : ℝ),
  (a = a)

/--
source: topology
reference: translated endpoints
relationship: original
-/
def authored_record_projection : Prop :=
  ∀ (I : cleanStructure_Endpoints_2512a023e0474ce195ac),
  ∀ (s : ℝ),
  (((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» (I)) + s) = ((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» (I)) + s))

/--
source: topology
reference: native identity adapter
relationship: original
-/
def opaque_record_projection : Prop :=
  ∀ (I : cleanStructure_Endpoints_2512a023e0474ce195ac),
  ((@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» ((cleanNotation_opaque_endpoints_d1fd4290aaef6a02d3f2 (I)))) = (@cleanStructure_Endpoints_2512a023e0474ce195ac.«lower» (I)))

/--
source: topology
reference: dependent constructor projection
relationship: original
-/
def computed_dependent_field : Prop :=
  ∀ (X : Type),
  ∀ (P : cleanStructure_BasedPath_af4022cf2eeed1e2d1ab (X)),
  ((@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«path» (X) (P)) = (@cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.«path» (X) (P)))

end CleanStatements

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `BundleOracle.BasedPath then return `cleanStructure_BasedPath_af4022cf2eeed1e2d1ab
  if n == `BundleOracle.Endpoints then return `cleanStructure_Endpoints_2512a023e0474ce195ac
  if n == `BundleOracle.makePath then return `cleanConstructor_based_path_68c2fc8490e4ebc630bb
  if n == `BundleOracle.endpoints then return `cleanConstructor_endpoints_ae57156441e5057814f6
  if n == `BundleOracle.reverse then return `cleanDefine_reversed_bundle_9779f436492a7430ddec
  if n == `BundleOracle.shift then return `cleanDefine_shifted_endpoints_0341e7d28e14c6ec5711
  if n == `BundleOracle.ordered then return `cleanDefine_ordered_endpoints_867d201d7c772f8385d6
  if n == `BundleOracle.reversePath then return `cleanNotation_reverse_path_43d430a43539939bcf2c
  if n == `BundleOracle.ScalarMap then return `cleanStructure_ScalarMap_b571a474391ee4a1048f
  if n == `BundleOracle.SizedVector then return `cleanStructure_SizedVector_e3bb6d8f3a27db756907
  if n == `BundleOracle.scalarMap then return `cleanConstructor_scalar_map_f78247db9d7c5f5369a0
  if n == `BundleOracle.sizedVector then return `cleanConstructor_sized_vector_236d49ac38f05d98affb
  if n == `BundleOracle.nativeIdentity then return `cleanNotation_opaque_endpoints_d1fd4290aaef6a02d3f2
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

namespace BundleOracle
structure BasedPath (X : Type) : Type where
  topology : TopologicalSpace X
  start : X
  finish : X
  path : @Path X topology start finish
structure Endpoints : Type where
  lower : ℝ
  upper : ℝ
structure ScalarMap : Type where
  map : ℝ → ℝ
structure SizedVector : Type where
  size : ℕ
  vector : Fin size → ℝ
noncomputable def scalarMap (f : ℝ → ℝ) : ScalarMap := @ScalarMap.mk f
noncomputable def sizedVector (n : ℕ) (v : Fin n → ℝ) : SizedVector := @SizedVector.mk n v
noncomputable def makePath (X : Type) (t : TopologicalSpace X) (x y : X)
    (p : @Path X t x y) : BasedPath X := @BasedPath.mk X t x y p
noncomputable def endpoints (a b : ℝ) : Endpoints := @Endpoints.mk a b
noncomputable def reversePath {X : Type} (t : TopologicalSpace X) (x y : X)
    (p : @Path X t x y) : @Path X t y x := @Path.symm X t x y p
noncomputable def reverse (X : Type) (P : BasedPath X) : BasedPath X :=
  @makePath X P.topology P.finish P.start
    (@reversePath X P.topology P.start P.finish P.path)
noncomputable def ordered (I : Endpoints) : Prop := I.lower < I.upper
noncomputable def shift (I : Endpoints) (s : ℝ) : Endpoints :=
  @endpoints (I.lower+s) (I.upper+s)
def constructorStatement : Prop := ∀ (a b : ℝ),
  let I : Endpoints := @endpoints a b
  I.lower=a ∧ I.upper=b
def shiftStatement : Prop := ∀ (I : Endpoints) (s : ℝ), ordered I → ordered (shift I s)
def pathStatement : Prop := ∀ (X : Type) (P : BasedPath X),
  @Exists (@Path X P.topology P.start P.finish) (fun p => p=P.path)
def reverseStatement : Prop := ∀ (X : Type) (P : BasedPath X), reverse X (reverse X P) = P
def functionStatement : Prop := ∀ (f : ℝ → ℝ) (x : ℝ),
  let P : ScalarMap := scalarMap f
  P.map x = f x
def dimensionStatement : Prop := ∀ (V : SizedVector),
  @Exists (Fin V.size → ℝ) (fun v => v=V.vector)
noncomputable def nativeIdentity (I : Endpoints) : Endpoints := I
def computedStatement : Prop := ∀ (a b : ℝ), a=a
def authoredProjectionStatement : Prop := ∀ (I : Endpoints) (s : ℝ), I.lower+s=I.lower+s
def opaqueStatement : Prop := ∀ (I : Endpoints), (@nativeIdentity I).lower=I.lower
def computedDependentStatement : Prop := ∀ (X : Type) (P : BasedPath X), P.path=P.path
end BundleOracle
same_target cleanStructure_BasedPath_af4022cf2eeed1e2d1ab BundleOracle.BasedPath
same_target cleanStructure_Endpoints_2512a023e0474ce195ac BundleOracle.Endpoints
same_target cleanConstructor_based_path_68c2fc8490e4ebc630bb BundleOracle.makePath
same_target cleanConstructor_endpoints_ae57156441e5057814f6 BundleOracle.endpoints
same_target cleanDefine_reversed_bundle_9779f436492a7430ddec BundleOracle.reverse
same_target cleanDefine_shifted_endpoints_0341e7d28e14c6ec5711 BundleOracle.shift
same_target cleanDefine_ordered_endpoints_867d201d7c772f8385d6 BundleOracle.ordered
same_target cleanNotation_reverse_path_43d430a43539939bcf2c BundleOracle.reversePath
same_target cleanStructure_ScalarMap_b571a474391ee4a1048f BundleOracle.ScalarMap
same_target cleanStructure_SizedVector_e3bb6d8f3a27db756907 BundleOracle.SizedVector
same_target cleanConstructor_scalar_map_f78247db9d7c5f5369a0 BundleOracle.scalarMap
same_target cleanConstructor_sized_vector_236d49ac38f05d98affb BundleOracle.sizedVector
same_target cleanNotation_opaque_endpoints_d1fd4290aaef6a02d3f2 BundleOracle.nativeIdentity
same_target cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.mk BundleOracle.BasedPath.mk
same_target cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.topology BundleOracle.BasedPath.topology
same_target cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.start BundleOracle.BasedPath.start
same_target cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.finish BundleOracle.BasedPath.finish
same_target cleanStructure_BasedPath_af4022cf2eeed1e2d1ab.path BundleOracle.BasedPath.path
same_target cleanStructure_Endpoints_2512a023e0474ce195ac.mk BundleOracle.Endpoints.mk
same_target cleanStructure_Endpoints_2512a023e0474ce195ac.lower BundleOracle.Endpoints.lower
same_target cleanStructure_Endpoints_2512a023e0474ce195ac.upper BundleOracle.Endpoints.upper
same_target cleanStructure_ScalarMap_b571a474391ee4a1048f.mk BundleOracle.ScalarMap.mk
same_target cleanStructure_ScalarMap_b571a474391ee4a1048f.map BundleOracle.ScalarMap.map
same_target cleanStructure_SizedVector_e3bb6d8f3a27db756907.mk BundleOracle.SizedVector.mk
same_target cleanStructure_SizedVector_e3bb6d8f3a27db756907.size BundleOracle.SizedVector.size
same_target cleanStructure_SizedVector_e3bb6d8f3a27db756907.vector BundleOracle.SizedVector.vector
same_target CleanStatements.endpoint_constructor BundleOracle.constructorStatement
same_target CleanStatements.shifting_endpoints_preserves_order BundleOracle.shiftStatement
same_target CleanStatements.bundled_path_has_its_declared_endpoints BundleOracle.pathStatement
same_target CleanStatements.reversing_a_bundled_path_twice BundleOracle.reverseStatement
same_target CleanStatements.function_field_application BundleOracle.functionStatement
same_target CleanStatements.vector_field_dimensions BundleOracle.dimensionStatement
same_target CleanStatements.computed_constructor_projection BundleOracle.computedStatement
same_target CleanStatements.authored_record_projection BundleOracle.authoredProjectionStatement
same_target CleanStatements.opaque_record_projection BundleOracle.opaqueStatement
same_target CleanStatements.computed_dependent_field BundleOracle.computedDependentStatement

namespace BundleProofs
theorem endpoint_constructor : CleanStatements.endpoint_constructor := by
  intro a b
  exact ⟨rfl,rfl⟩
theorem shifting_endpoints_preserves_order : CleanStatements.shifting_endpoints_preserves_order := by
  intro I s h
  change I.lower+s < I.upper+s
  exact add_lt_add_right h s
theorem bundled_path_has_its_declared_endpoints : CleanStatements.bundled_path_has_its_declared_endpoints := by
  intro X P
  exact ⟨P.path,rfl⟩
theorem reversing_a_bundled_path_twice : CleanStatements.reversing_a_bundled_path_twice := by
  intro X P
  cases P
  simp [cleanDefine_reversed_bundle_9779f436492a7430ddec, cleanConstructor_based_path_68c2fc8490e4ebc630bb, cleanNotation_reverse_path_43d430a43539939bcf2c, Path.symm_symm]
theorem function_field_application : CleanStatements.function_field_application := by
  intro f x
  rfl
theorem vector_field_dimensions : CleanStatements.vector_field_dimensions := by
  intro V
  exact ⟨V.vector,rfl⟩
theorem computed_constructor_projection : CleanStatements.computed_constructor_projection := by
  intro a b
  rfl
theorem authored_record_projection : CleanStatements.authored_record_projection := by
  intro I s
  rfl
theorem opaque_record_projection : CleanStatements.opaque_record_projection := by
  intro I
  rfl
theorem computed_dependent_field : CleanStatements.computed_dependent_field := by
  intro X P
  rfl
end BundleProofs

-- generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
