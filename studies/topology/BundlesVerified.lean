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

noncomputable abbrev cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable abbrev cleanType_Natural_469c53b6dafb7a218246  : Type :=
  ℕ

noncomputable abbrev cleanType_Real_107b6641a486642ad8e1  : Type :=
  ℝ

noncomputable abbrev cleanType_Complex_2d7f06a08f8ab1e3f46d  : Type :=
  ℂ

noncomputable abbrev cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable abbrev cleanType_Matrix_61d617e3f5143c327dd3 (p0 : Nat) (p1 : Nat) (p2 : Type) : Type :=
  Matrix (Fin p0) (Fin p1) p2

noncomputable abbrev cleanType_Vector_b5a130b68abf7f0646e8 (p0 : Nat) (p1 : Type) : Type :=
  Fin p0 → p1

noncomputable abbrev cleanType_Vertex_460956e39f5b9ffca091 (p0 : Nat) : Type :=
  Fin p0

noncomputable abbrev cleanType_Graph_7bde0ce024ce143f369b (p0 : Nat) : Type :=
  SimpleGraph (Fin p0)

noncomputable abbrev cleanType_List_530f2b2df99696550311 (p0 : Type) : Type :=
  List (p0)

noncomputable abbrev cleanType_Set_6e300741358eee425e81 (p0 : Type) : Type :=
  Set (p0)

noncomputable abbrev cleanType_Function_9d746dbeb0e035328deb (p0 : Type) (p1 : Type) : Type :=
  (p0) → (p1)

noncomputable abbrev cleanType_Topology_2eca621ea710e87cf174 (X : Type) : Type :=
  TopologicalSpace X

noncomputable def cleanNotation_set_of_2c71fd475f49a65bd03e {X : Type} (condition : (X) → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) : (_root_.cleanType_Set_6e300741358eee425e81 (X)) :=
  setOf condition

noncomputable def cleanDefine_open_in_2f000176928f8b3f5fc4 {X : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  @IsOpen X t S

noncomputable def cleanDefine_inverse_image_eb657a3c1d0219ea719b {X : Type} {Y : Type} (f : (X) → (Y)) (S : (_root_.cleanType_Set_6e300741358eee425e81 (Y))) : (_root_.cleanType_Set_6e300741358eee425e81 (X)) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : X) => ((f clean_bound_0) ∈ S))))

noncomputable def cleanDefine_image_869a575587985294ee29 {X : Type} {Y : Type} (f : (X) → (Y)) (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) : (_root_.cleanType_Set_6e300741358eee425e81 (Y)) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : Y) => (@Exists (X) (fun (clean_bound_1 : X) => ((clean_bound_1 ∈ S) ∧ ((f clean_bound_1) = clean_bound_0)))))))

noncomputable def cleanDefine_compose_maps_b7e7219a131a4bb5245c {X : Type} {Y : Type} {Z : Type} (g : (Y) → (Z)) (f : (X) → (Y)) : (X) → (Z) :=
  (fun (clean_bound_0 : X) => (g (f clean_bound_0)))

noncomputable def cleanDefine_continuous_between_3b927933ead621e0bfe9 {X : Type} {Y : Type} (f : (X) → (Y)) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (u : (_root_.cleanType_Topology_2eca621ea710e87cf174 (Y))) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  (∀ (clean_bound_0 : (_root_.cleanType_Set_6e300741358eee425e81 (Y))), ((_root_.cleanDefine_open_in_2f000176928f8b3f5fc4 (clean_bound_0) (u)) → (_root_.cleanDefine_open_in_2f000176928f8b3f5fc4 ((_root_.cleanDefine_inverse_image_eb657a3c1d0219ea719b (f) (clean_bound_0))) (t))))

noncomputable def cleanDefine_selected_elements_b4d39602cd1cf697afb5 {X : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (condition : (X) → ((_root_.cleanType_Proposition_ae4a13d2f060407bce35))) : (_root_.cleanType_Set_6e300741358eee425e81 (X)) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : X) => ((clean_bound_0 ∈ S) ∧ (condition clean_bound_0)))))

noncomputable def cleanDefine_intersection_family_7482d46b5fb61bd1ecae {I : Type} {X : Type} (sets : (I) → ((_root_.cleanType_Set_6e300741358eee425e81 (X)))) : (_root_.cleanType_Set_6e300741358eee425e81 (X)) :=
  (_root_.cleanNotation_set_of_2c71fd475f49a65bd03e ((fun (clean_bound_0 : X) => (∀ (clean_bound_1 : I), (clean_bound_0 ∈ (sets clean_bound_1))))))

noncomputable abbrev cleanType_Element_4fb2f1b669ed36f80886 (X : Type) (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) : Type :=
  {x : X // x ∈ S}

noncomputable abbrev cleanType_Path_2e5bf3c806cfad5a1ae9 (X : Type) (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) (y : X) : Type :=
  @Path X t x y

noncomputable def cleanNotation_underlying_point_5fc735e8b58c86463a25 {X : Type} (S : (_root_.cleanType_Set_6e300741358eee425e81 (X))) (x : (_root_.cleanType_Element_4fb2f1b669ed36f80886 (X) (S))) : X :=
  x.val

noncomputable def cleanNotation_constant_path_e6a080b4f4baea9e3c6a {X : Type} (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (x)) :=
  @Path.refl X t x

noncomputable def cleanNotation_reverse_path_bccacbe82db41fbe7c6d {X : Type} (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) (y : X) (p : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (y))) : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (y) (x)) :=
  @Path.symm X t x y p

noncomputable def cleanNotation_join_paths_413579dc3782617ff91d {X : Type} (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) (y : X) (z : X) (p : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (y))) (q : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (y) (z))) : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (z)) :=
  @Path.trans X t x y z p q

noncomputable def cleanDefine_reverse_twice_19c7d7336839bf577a5b {X : Type} (t : (_root_.cleanType_Topology_2eca621ea710e87cf174 (X))) (x : X) (y : X) (p : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (y))) : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) (t) (x) (y)) :=
  (@_root_.cleanNotation_reverse_path_bccacbe82db41fbe7c6d (X) (t) (y) (x) ((@_root_.cleanNotation_reverse_path_bccacbe82db41fbe7c6d (X) (t) (x) (y) (p))))

/--
A topology, two points, and a path between them, on a fixed carrier.
-/
structure cleanStructure_BasedPath_70f574d7589934963ee1 («X» : Type) : Type where
  «topology» : (_root_.cleanType_Topology_2eca621ea710e87cf174 («X»))
  «start» : «X»
  «finish» : «X»
  «path» : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 («X») («topology») («start») («finish»))

noncomputable def cleanConstructor_based_path_2b5edffd368145e026ec («X» : Type) («topology» : (_root_.cleanType_Topology_2eca621ea710e87cf174 («X»))) («start» : «X») («finish» : «X») («path» : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 («X») («topology») («start») («finish»))) : _root_.cleanStructure_BasedPath_70f574d7589934963ee1 («X») :=
  @_root_.cleanStructure_BasedPath_70f574d7589934963ee1.mk «X» «topology» «start» «finish» «path»

noncomputable def cleanDefine_reversed_bundle_89d7b5d246c5c673d41c  (X : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)) (P : _root_.cleanStructure_BasedPath_70f574d7589934963ee1 (X)) : _root_.cleanStructure_BasedPath_70f574d7589934963ee1 (X) :=
  (@_root_.cleanConstructor_based_path_2b5edffd368145e026ec (X) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«topology» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«finish» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«start» (X) (P))) ((@_root_.cleanNotation_reverse_path_bccacbe82db41fbe7c6d (X) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«topology» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«start» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«finish» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«path» (X) (P))))))

structure cleanStructure_Endpoints_7a6ba0b879274641120c  : Type where
  «lower» : (_root_.cleanType_Real_107b6641a486642ad8e1)
  «upper» : (_root_.cleanType_Real_107b6641a486642ad8e1)

noncomputable def cleanConstructor_endpoints_3622a2317e61075ae5a0 («lower» : (_root_.cleanType_Real_107b6641a486642ad8e1)) («upper» : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c :=
  @_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.mk «lower» «upper»

noncomputable def cleanDefine_ordered_endpoints_e18d07991fd919237102  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) : (_root_.cleanType_Proposition_ae4a13d2f060407bce35) :=
  ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I)) < (@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I)))

noncomputable def cleanDefine_shifted_endpoints_ea3398852390cb480b6d  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) (s : (_root_.cleanType_Real_107b6641a486642ad8e1)) : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c :=
  (@_root_.cleanConstructor_endpoints_3622a2317e61075ae5a0 (((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I)) + s)) (((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I)) + s)))

structure cleanStructure_ScalarMap_54cbe725f12fda5c0d93  : Type where
  «map» : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))

noncomputable def cleanConstructor_scalar_map_33b9c976a3a5618354af («map» : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))) : _root_.cleanStructure_ScalarMap_54cbe725f12fda5c0d93 :=
  @_root_.cleanStructure_ScalarMap_54cbe725f12fda5c0d93.mk «map»

structure cleanStructure_SizedVector_5330c22ed683e2bafdc3  : Type where
  «size» : (_root_.cleanType_Natural_469c53b6dafb7a218246)
  «vector» : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 («size») ((_root_.cleanType_Real_107b6641a486642ad8e1)))

noncomputable def cleanConstructor_sized_vector_bfaf63c6661b235d273b («size» : (_root_.cleanType_Natural_469c53b6dafb7a218246)) («vector» : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 («size») ((_root_.cleanType_Real_107b6641a486642ad8e1)))) : _root_.cleanStructure_SizedVector_5330c22ed683e2bafdc3 :=
  @_root_.cleanStructure_SizedVector_5330c22ed683e2bafdc3.mk «size» «vector»

noncomputable def cleanNotation_opaque_endpoints_df879bc887dc13a99748  (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c) : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c :=
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
  ∀ (a b : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  let I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c := (@_root_.cleanConstructor_endpoints_3622a2317e61075ae5a0 (a) (b));
  (((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I)) = a) ∧ ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«upper» (I)) = b))

/--
source: topology
reference: translating ordered endpoints
relationship: original
-/
def shifting_endpoints_preserves_order : Prop :=
  ∀ (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c),
  ∀ (s : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  ∀ («ordering_of_I» : (_root_.cleanDefine_ordered_endpoints_e18d07991fd919237102 (I))),
  (_root_.cleanDefine_ordered_endpoints_e18d07991fd919237102 ((_root_.cleanDefine_shifted_endpoints_ea3398852390cb480b6d (I) (s))))

/--
source: topology
reference: dependent path projection
relationship: original
-/
def bundled_path_has_its_declared_endpoints : Prop :=
  ∀ (X : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (P : _root_.cleanStructure_BasedPath_70f574d7589934963ee1 (X)),
  (@Exists ((_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«topology» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«start» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«finish» (X) (P))))) (fun (clean_bound_0 : (_root_.cleanType_Path_2e5bf3c806cfad5a1ae9 (X) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«topology» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«start» (X) (P))) ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«finish» (X) (P))))) => (clean_bound_0 = (@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«path» (X) (P)))))

/--
source: topology
reference: bundled path involution
relationship: original
-/
def reversing_a_bundled_path_twice : Prop :=
  ∀ (X : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (P : _root_.cleanStructure_BasedPath_70f574d7589934963ee1 (X)),
  ((@_root_.cleanDefine_reversed_bundle_89d7b5d246c5c673d41c (X) ((@_root_.cleanDefine_reversed_bundle_89d7b5d246c5c673d41c (X) (P)))) = P)

/--
source: topology
reference: function field application
relationship: original
-/
def function_field_application : Prop :=
  ∀ (f : ((_root_.cleanType_Real_107b6641a486642ad8e1)) → ((_root_.cleanType_Real_107b6641a486642ad8e1))),
  ∀ (x : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  let P : _root_.cleanStructure_ScalarMap_54cbe725f12fda5c0d93 := (@_root_.cleanConstructor_scalar_map_33b9c976a3a5618354af (f));
  (((@_root_.cleanStructure_ScalarMap_54cbe725f12fda5c0d93.«map» (P)) x) = (f x))

/--
source: topology
reference: natural field dependency
relationship: original
-/
def vector_field_dimensions : Prop :=
  ∀ (V : _root_.cleanStructure_SizedVector_5330c22ed683e2bafdc3),
  (@Exists ((_root_.cleanType_Vector_b5a130b68abf7f0646e8 ((@_root_.cleanStructure_SizedVector_5330c22ed683e2bafdc3.«size» (V))) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) (fun (clean_bound_0 : (_root_.cleanType_Vector_b5a130b68abf7f0646e8 ((@_root_.cleanStructure_SizedVector_5330c22ed683e2bafdc3.«size» (V))) ((_root_.cleanType_Real_107b6641a486642ad8e1)))) => (clean_bound_0 = (@_root_.cleanStructure_SizedVector_5330c22ed683e2bafdc3.«vector» (V)))))

/--
source: topology
reference: constructor field computation
relationship: original
-/
def computed_constructor_projection : Prop :=
  ∀ (a b : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (a = a)

/--
source: topology
reference: translated endpoints
relationship: original
-/
def authored_record_projection : Prop :=
  ∀ (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c),
  ∀ (s : (_root_.cleanType_Real_107b6641a486642ad8e1)),
  (((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I)) + s) = ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I)) + s))

/--
source: topology
reference: native identity adapter
relationship: original
-/
def opaque_record_projection : Prop :=
  ∀ (I : _root_.cleanStructure_Endpoints_7a6ba0b879274641120c),
  ((@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» ((_root_.cleanNotation_opaque_endpoints_df879bc887dc13a99748 (I)))) = (@_root_.cleanStructure_Endpoints_7a6ba0b879274641120c.«lower» (I)))

/--
source: topology
reference: dependent constructor projection
relationship: original
-/
def computed_dependent_field : Prop :=
  ∀ (X : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (P : _root_.cleanStructure_BasedPath_70f574d7589934963ee1 (X)),
  ((@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«path» (X) (P)) = (@_root_.cleanStructure_BasedPath_70f574d7589934963ee1.«path» (X) (P)))

end CleanStatements

open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
  if n == `BundleOracle.BasedPath then return `cleanStructure_BasedPath_70f574d7589934963ee1
  if n == `BundleOracle.Endpoints then return `cleanStructure_Endpoints_7a6ba0b879274641120c
  if n == `BundleOracle.makePath then return `cleanConstructor_based_path_2b5edffd368145e026ec
  if n == `BundleOracle.endpoints then return `cleanConstructor_endpoints_3622a2317e61075ae5a0
  if n == `BundleOracle.reverse then return `cleanDefine_reversed_bundle_89d7b5d246c5c673d41c
  if n == `BundleOracle.shift then return `cleanDefine_shifted_endpoints_ea3398852390cb480b6d
  if n == `BundleOracle.ordered then return `cleanDefine_ordered_endpoints_e18d07991fd919237102
  if n == `BundleOracle.reversePath then return `cleanNotation_reverse_path_bccacbe82db41fbe7c6d
  if n == `BundleOracle.ScalarMap then return `cleanStructure_ScalarMap_54cbe725f12fda5c0d93
  if n == `BundleOracle.SizedVector then return `cleanStructure_SizedVector_5330c22ed683e2bafdc3
  if n == `BundleOracle.scalarMap then return `cleanConstructor_scalar_map_33b9c976a3a5618354af
  if n == `BundleOracle.sizedVector then return `cleanConstructor_sized_vector_bfaf63c6661b235d273b
  if n == `BundleOracle.nativeIdentity then return `cleanNotation_opaque_endpoints_df879bc887dc13a99748
  if n == `BundleOracle.carrierType then return `cleanType_Type_c1fed1af64ab6f12e0ed
  if n == `BundleOracle.realType then return `cleanType_Real_107b6641a486642ad8e1
  if n == `BundleOracle.naturalType then return `cleanType_Natural_469c53b6dafb7a218246
  if n == `BundleOracle.conditionType then return `cleanType_Proposition_ae4a13d2f060407bce35
  if n == `BundleOracle.topologyType then return `cleanType_Topology_2eca621ea710e87cf174
  if n == `BundleOracle.pathType then return `cleanType_Path_2e5bf3c806cfad5a1ae9
  if n == `BundleOracle.vectorType then return `cleanType_Vector_b5a130b68abf7f0646e8
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
noncomputable abbrev carrierType : Type 1 := Type
noncomputable abbrev realType : Type := ℝ
noncomputable abbrev naturalType : Type := ℕ
noncomputable abbrev conditionType : Sort 1 := Prop
noncomputable abbrev topologyType (X : Type) : Type := TopologicalSpace X
noncomputable abbrev pathType (X : Type) (t : topologyType X) (x y : X) : Type := @Path X t x y
noncomputable abbrev vectorType (n : Nat) (T : Type) : Type := Fin n → T
structure BasedPath (X : Type) : Type where
  topology : topologyType X
  start : X
  finish : X
  path : pathType X topology start finish
structure Endpoints : Type where
  lower : realType
  upper : realType
structure ScalarMap : Type where
  map : realType → realType
structure SizedVector : Type where
  size : naturalType
  vector : vectorType size realType
noncomputable def scalarMap (f : realType → realType) : ScalarMap := @ScalarMap.mk f
noncomputable def sizedVector (n : naturalType) (v : vectorType n realType) : SizedVector := @SizedVector.mk n v
noncomputable def makePath (X : Type) (t : topologyType X) (x y : X)
    (p : pathType X t x y) : BasedPath X := @BasedPath.mk X t x y p
noncomputable def endpoints (a b : realType) : Endpoints := @Endpoints.mk a b
noncomputable def reversePath {X : Type} (t : topologyType X) (x y : X)
    (p : pathType X t x y) : pathType X t y x := @Path.symm X t x y p
noncomputable def reverse (X : carrierType) (P : BasedPath X) : BasedPath X :=
  @makePath X P.topology P.finish P.start
    (@reversePath X P.topology P.start P.finish P.path)
noncomputable def ordered (I : Endpoints) : conditionType := I.lower < I.upper
noncomputable def shift (I : Endpoints) (s : realType) : Endpoints :=
  @endpoints (I.lower+s) (I.upper+s)
def constructorStatement : Prop := ∀ (a b : realType),
  let I : Endpoints := @endpoints a b
  I.lower=a ∧ I.upper=b
def shiftStatement : Prop := ∀ (I : Endpoints) (s : realType), ordered I → ordered (shift I s)
def pathStatement : Prop := ∀ (X : carrierType) (P : BasedPath X),
  @Exists (pathType X P.topology P.start P.finish) (fun p => p=P.path)
def reverseStatement : Prop := ∀ (X : carrierType) (P : BasedPath X), reverse X (reverse X P) = P
def functionStatement : Prop := ∀ (f : realType → realType) (x : realType),
  let P : ScalarMap := scalarMap f
  P.map x = f x
def dimensionStatement : Prop := ∀ (V : SizedVector),
  @Exists (vectorType V.size realType) (fun v => v=V.vector)
noncomputable def nativeIdentity (I : Endpoints) : Endpoints := I
def computedStatement : Prop := ∀ (a b : realType), a=a
def authoredProjectionStatement : Prop := ∀ (I : Endpoints) (s : realType), I.lower+s=I.lower+s
def opaqueStatement : Prop := ∀ (I : Endpoints), (@nativeIdentity I).lower=I.lower
def computedDependentStatement : Prop := ∀ (X : carrierType) (P : BasedPath X), P.path=P.path
end BundleOracle
same_target cleanStructure_BasedPath_70f574d7589934963ee1 BundleOracle.BasedPath
same_target cleanStructure_Endpoints_7a6ba0b879274641120c BundleOracle.Endpoints
same_target cleanConstructor_based_path_2b5edffd368145e026ec BundleOracle.makePath
same_target cleanConstructor_endpoints_3622a2317e61075ae5a0 BundleOracle.endpoints
same_target cleanDefine_reversed_bundle_89d7b5d246c5c673d41c BundleOracle.reverse
same_target cleanDefine_shifted_endpoints_ea3398852390cb480b6d BundleOracle.shift
same_target cleanDefine_ordered_endpoints_e18d07991fd919237102 BundleOracle.ordered
same_target cleanNotation_reverse_path_bccacbe82db41fbe7c6d BundleOracle.reversePath
same_target cleanStructure_ScalarMap_54cbe725f12fda5c0d93 BundleOracle.ScalarMap
same_target cleanStructure_SizedVector_5330c22ed683e2bafdc3 BundleOracle.SizedVector
same_target cleanConstructor_scalar_map_33b9c976a3a5618354af BundleOracle.scalarMap
same_target cleanConstructor_sized_vector_bfaf63c6661b235d273b BundleOracle.sizedVector
same_target cleanNotation_opaque_endpoints_df879bc887dc13a99748 BundleOracle.nativeIdentity
same_target cleanType_Type_c1fed1af64ab6f12e0ed BundleOracle.carrierType
same_target cleanType_Real_107b6641a486642ad8e1 BundleOracle.realType
same_target cleanType_Natural_469c53b6dafb7a218246 BundleOracle.naturalType
same_target cleanType_Proposition_ae4a13d2f060407bce35 BundleOracle.conditionType
same_target cleanType_Topology_2eca621ea710e87cf174 BundleOracle.topologyType
same_target cleanType_Path_2e5bf3c806cfad5a1ae9 BundleOracle.pathType
same_target cleanType_Vector_b5a130b68abf7f0646e8 BundleOracle.vectorType
same_target cleanStructure_BasedPath_70f574d7589934963ee1.mk BundleOracle.BasedPath.mk
same_target cleanStructure_BasedPath_70f574d7589934963ee1.topology BundleOracle.BasedPath.topology
same_target cleanStructure_BasedPath_70f574d7589934963ee1.start BundleOracle.BasedPath.start
same_target cleanStructure_BasedPath_70f574d7589934963ee1.finish BundleOracle.BasedPath.finish
same_target cleanStructure_BasedPath_70f574d7589934963ee1.path BundleOracle.BasedPath.path
same_target cleanStructure_Endpoints_7a6ba0b879274641120c.mk BundleOracle.Endpoints.mk
same_target cleanStructure_Endpoints_7a6ba0b879274641120c.lower BundleOracle.Endpoints.lower
same_target cleanStructure_Endpoints_7a6ba0b879274641120c.upper BundleOracle.Endpoints.upper
same_target cleanStructure_ScalarMap_54cbe725f12fda5c0d93.mk BundleOracle.ScalarMap.mk
same_target cleanStructure_ScalarMap_54cbe725f12fda5c0d93.map BundleOracle.ScalarMap.map
same_target cleanStructure_SizedVector_5330c22ed683e2bafdc3.mk BundleOracle.SizedVector.mk
same_target cleanStructure_SizedVector_5330c22ed683e2bafdc3.size BundleOracle.SizedVector.size
same_target cleanStructure_SizedVector_5330c22ed683e2bafdc3.vector BundleOracle.SizedVector.vector
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
  simp [cleanDefine_reversed_bundle_89d7b5d246c5c673d41c, cleanConstructor_based_path_2b5edffd368145e026ec, cleanNotation_reverse_path_bccacbe82db41fbe7c6d, Path.symm_symm]
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
