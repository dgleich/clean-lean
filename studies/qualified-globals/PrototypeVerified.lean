import Lean
import Mathlib.Data.Real.Basic

noncomputable abbrev cleanType_Type_c1fed1af64ab6f12e0ed  : Type 1 :=
  Type

noncomputable abbrev cleanType_Scalar_26f57455726c067fc151  : Type :=
  Real

noncomputable abbrev cleanType_Natural_ed60542607241095b2d0  : Type :=
  Nat

noncomputable abbrev cleanType_Vector_05659923fab260da9b0c (n : Nat) (T : Type) : Type :=
  Fin n → T

noncomputable abbrev cleanType_Function_c7021aafda499fb8cdb1 (T : Type) (U : Type) : Type :=
  (T) → (U)

noncomputable def cleanDefine_identity_d3c711f54a1b96c03825  (x : (_root_.cleanType_Scalar_26f57455726c067fc151)) : (_root_.cleanType_Scalar_26f57455726c067fc151) :=
  x

noncomputable def cleanNotation_square_5b28651c9960df914260  (x : (_root_.cleanType_Scalar_26f57455726c067fc151)) : (_root_.cleanType_Scalar_26f57455726c067fc151) :=
  x*x

noncomputable def cleanDefine_vector_identity_7f6d6e51a2cebbc954e9  (n : (_root_.cleanType_Natural_ed60542607241095b2d0)) (v : (_root_.cleanType_Vector_05659923fab260da9b0c (n) ((_root_.cleanType_Scalar_26f57455726c067fc151)))) : (_root_.cleanType_Vector_05659923fab260da9b0c (n) ((_root_.cleanType_Scalar_26f57455726c067fc151))) :=
  v

structure cleanStructure_Box_a69e0a7b39dc53d0cc1f  : Type where
  «value» : (_root_.cleanType_Scalar_26f57455726c067fc151)

noncomputable def cleanConstructor_box_e96d933134e974211e5d («value» : (_root_.cleanType_Scalar_26f57455726c067fc151)) : _root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f :=
  @_root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f.mk «value»

structure cleanStructure_VectorBundle_311e9e4473083cd11317  : Type where
  «size» : (_root_.cleanType_Natural_ed60542607241095b2d0)
  «value» : (_root_.cleanType_Vector_05659923fab260da9b0c («size») ((_root_.cleanType_Scalar_26f57455726c067fc151)))

noncomputable def cleanConstructor_vector_bundle_659be6147aab96ce8096 («size» : (_root_.cleanType_Natural_ed60542607241095b2d0)) («value» : (_root_.cleanType_Vector_05659923fab260da9b0c («size») ((_root_.cleanType_Scalar_26f57455726c067fc151)))) : _root_.cleanStructure_VectorBundle_311e9e4473083cd11317 :=
  @_root_.cleanStructure_VectorBundle_311e9e4473083cd11317.mk «size» «value»

noncomputable def cleanDefine_ignore_shadow_1f408ae73ae0973f8c9a  (cleanDefine_identity_d3c711f54a1b96c03825 : ((_root_.cleanType_Scalar_26f57455726c067fc151)) → ((_root_.cleanType_Scalar_26f57455726c067fc151))) (x : (_root_.cleanType_Scalar_26f57455726c067fc151)) : (_root_.cleanType_Scalar_26f57455726c067fc151) :=
  (_root_.cleanDefine_identity_d3c711f54a1b96c03825 (x))



-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: local
reference: authored callable collision
relationship: original
-/
def authored_callable_retains_identity : Prop :=
  ∀ (cleanDefine_identity_d3c711f54a1b96c03825 : ((_root_.cleanType_Scalar_26f57455726c067fc151)) → ((_root_.cleanType_Scalar_26f57455726c067fc151))),
  ∀ (x : (_root_.cleanType_Scalar_26f57455726c067fc151)),
  ((_root_.cleanDefine_identity_d3c711f54a1b96c03825 (x)) = x)

/--
source: local
reference: notation collision
relationship: original
-/
def native_callable_retains_identity : Prop :=
  ∀ (cleanNotation_square_5b28651c9960df914260 : ((_root_.cleanType_Scalar_26f57455726c067fc151)) → ((_root_.cleanType_Scalar_26f57455726c067fc151))),
  ∀ (x : (_root_.cleanType_Scalar_26f57455726c067fc151)),
  ((_root_.cleanNotation_square_5b28651c9960df914260 (x)) = (x * x))

/--
source: local
reference: dependent callable collision
relationship: original
-/
def dependent_callable_retains_identity : Prop :=
  ∀ (cleanDefine_vector_identity_7f6d6e51a2cebbc954e9 : (clean_pi_bound_0 : (_root_.cleanType_Natural_ed60542607241095b2d0)) → (((_root_.cleanType_Vector_05659923fab260da9b0c (clean_pi_bound_0) ((_root_.cleanType_Scalar_26f57455726c067fc151)))) → ((_root_.cleanType_Vector_05659923fab260da9b0c (clean_pi_bound_0) ((_root_.cleanType_Scalar_26f57455726c067fc151)))))),
  ∀ (n : (_root_.cleanType_Natural_ed60542607241095b2d0)),
  ∀ (v : (_root_.cleanType_Vector_05659923fab260da9b0c (n) ((_root_.cleanType_Scalar_26f57455726c067fc151)))),
  ((@_root_.cleanDefine_vector_identity_7f6d6e51a2cebbc954e9 (n) (v)) = v)

/--
source: local
reference: record type collision
relationship: original
-/
def record_type_retains_identity : Prop :=
  ∀ (cleanStructure_Box_a69e0a7b39dc53d0cc1f : (_root_.cleanType_Type_c1fed1af64ab6f12e0ed)),
  ∀ (b : _root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f),
  (b = b)

end CleanStatements

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

-- Independently authored declaration bodies under an explicit name mapping.
def expected_identity (x : _root_.cleanType_Scalar_26f57455726c067fc151) : _root_.cleanType_Scalar_26f57455726c067fc151 := x
same_basic_target cleanDefine_identity_d3c711f54a1b96c03825 expected_identity
def expected_square (x : _root_.cleanType_Scalar_26f57455726c067fc151) : _root_.cleanType_Scalar_26f57455726c067fc151 := x*x
same_basic_target cleanNotation_square_5b28651c9960df914260 expected_square
def expected_vector (n : _root_.cleanType_Natural_ed60542607241095b2d0) (v : _root_.cleanType_Vector_05659923fab260da9b0c n _root_.cleanType_Scalar_26f57455726c067fc151) : _root_.cleanType_Vector_05659923fab260da9b0c n _root_.cleanType_Scalar_26f57455726c067fc151 := v
same_basic_target cleanDefine_vector_identity_7f6d6e51a2cebbc954e9 expected_vector
def expected_box (value : _root_.cleanType_Scalar_26f57455726c067fc151) : _root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f := @_root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f.mk value
same_basic_target cleanConstructor_box_e96d933134e974211e5d expected_box
noncomputable def expected_ignored (shadow : _root_.cleanType_Scalar_26f57455726c067fc151 → _root_.cleanType_Scalar_26f57455726c067fc151) (x : _root_.cleanType_Scalar_26f57455726c067fc151) : _root_.cleanType_Scalar_26f57455726c067fc151 := _root_.cleanDefine_identity_d3c711f54a1b96c03825 x
same_basic_target cleanDefine_ignore_shadow_1f408ae73ae0973f8c9a expected_ignored

def expected_authored_statement : Prop := ∀ (shadow : _root_.cleanType_Scalar_26f57455726c067fc151 → _root_.cleanType_Scalar_26f57455726c067fc151) (x : _root_.cleanType_Scalar_26f57455726c067fc151), _root_.cleanDefine_identity_d3c711f54a1b96c03825 x = x
same_basic_target CleanStatements.authored_callable_retains_identity expected_authored_statement
def expected_native_statement : Prop := ∀ (shadow : _root_.cleanType_Scalar_26f57455726c067fc151 → _root_.cleanType_Scalar_26f57455726c067fc151) (x : _root_.cleanType_Scalar_26f57455726c067fc151), _root_.cleanNotation_square_5b28651c9960df914260 x = x*x
same_basic_target CleanStatements.native_callable_retains_identity expected_native_statement
def expected_dependent_statement : Prop := ∀ (shadow : (k : _root_.cleanType_Natural_ed60542607241095b2d0) → (_root_.cleanType_Vector_05659923fab260da9b0c k _root_.cleanType_Scalar_26f57455726c067fc151) → (_root_.cleanType_Vector_05659923fab260da9b0c k _root_.cleanType_Scalar_26f57455726c067fc151))
    (n : _root_.cleanType_Natural_ed60542607241095b2d0) (v : _root_.cleanType_Vector_05659923fab260da9b0c n _root_.cleanType_Scalar_26f57455726c067fc151), @_root_.cleanDefine_vector_identity_7f6d6e51a2cebbc954e9 n v = v
same_basic_target CleanStatements.dependent_callable_retains_identity expected_dependent_statement
def expected_record_statement : Prop := ∀ (shadow : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) (b : _root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f), b=b
same_basic_target CleanStatements.record_type_retains_identity expected_record_statement

noncomputable def actual_constructor (cleanConstructor_box_e96d933134e974211e5d : _root_.cleanType_Scalar_26f57455726c067fc151 → _root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f) (x : _root_.cleanType_Scalar_26f57455726c067fc151) : _root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f := (@_root_.cleanConstructor_box_e96d933134e974211e5d (x))
noncomputable def expected_constructor (shadow : _root_.cleanType_Scalar_26f57455726c067fc151 → _root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f) (x : _root_.cleanType_Scalar_26f57455726c067fc151) : _root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f := @_root_.cleanConstructor_box_e96d933134e974211e5d x
same_basic_target actual_constructor expected_constructor
def actual_projection (b : _root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f) (cleanStructure_Box_a69e0a7b39dc53d0cc1f : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) : _root_.cleanType_Scalar_26f57455726c067fc151 := (@_root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f.«value» (b))
def expected_projection (b : _root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f) (shadow : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) : _root_.cleanType_Scalar_26f57455726c067fc151 := @_root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f.value b
same_basic_target actual_projection expected_projection
def actual_dependent_projection (b : _root_.cleanStructure_VectorBundle_311e9e4473083cd11317) (cleanStructure_VectorBundle_311e9e4473083cd11317 : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) : (_root_.cleanType_Vector_05659923fab260da9b0c ((@_root_.cleanStructure_VectorBundle_311e9e4473083cd11317.«size» (b))) ((_root_.cleanType_Scalar_26f57455726c067fc151))) := (@_root_.cleanStructure_VectorBundle_311e9e4473083cd11317.«value» (b))
def expected_dependent_projection (b : _root_.cleanStructure_VectorBundle_311e9e4473083cd11317) (shadow : _root_.cleanType_Type_c1fed1af64ab6f12e0ed) :
    _root_.cleanType_Vector_05659923fab260da9b0c (@_root_.cleanStructure_VectorBundle_311e9e4473083cd11317.size b) _root_.cleanType_Scalar_26f57455726c067fc151 := @_root_.cleanStructure_VectorBundle_311e9e4473083cd11317.value b
same_basic_target actual_dependent_projection expected_dependent_projection

theorem authored_checked : CleanStatements.authored_callable_retains_identity := by intro shadow x; rfl
theorem native_checked : CleanStatements.native_callable_retains_identity := by intro shadow x; rfl
theorem dependent_checked : CleanStatements.dependent_callable_retains_identity := by intro shadow n v; rfl
theorem record_checked : CleanStatements.record_type_retains_identity := by intro shadow b; rfl
theorem constructor_checked (shadow : _root_.cleanType_Scalar_26f57455726c067fc151 → _root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f) (x : _root_.cleanType_Scalar_26f57455726c067fc151) :
    actual_constructor shadow x = @_root_.cleanStructure_Box_a69e0a7b39dc53d0cc1f.mk x := rfl
theorem declaration_body_checked (shadow : _root_.cleanType_Scalar_26f57455726c067fc151 → _root_.cleanType_Scalar_26f57455726c067fc151) (x : _root_.cleanType_Scalar_26f57455726c067fc151) :
    _root_.cleanDefine_ignore_shadow_1f408ae73ae0973f8c9a shadow x = x := rfl

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
