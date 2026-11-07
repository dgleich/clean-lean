import Lean
import Mathlib.Data.Real.Basic
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse

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
noncomputable def cleanType_Scalar_26f57455726c067fc151  : Type :=
  Real

noncomputable def cleanType_Proposition_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable def cleanNotation_scalar_addition_29a21dac530425fdc4d4  (x : Real) (y : Real) : Real :=
  x+y

noncomputable def cleanNotation_scalar_product_384e96fe470620f72f6f  (x : Real) (y : Real) : Real :=
  x*y

noncomputable def cleanNotation_scalar_equality_3f1c601070baec9dbb6f  (x : Real) (y : Real) : Prop :=
  x=y

noncomputable def cleanDefine_authored_sum_0a7ab8cae8b762917a56  (x : Real) (y : Real) : Real :=
  (cleanNotation_scalar_addition_29a21dac530425fdc4d4 (x) (y))

noncomputable def expected_add (x y : Real) : Real := x+y
noncomputable def expected_mul (x y : Real) : Real := x*y
noncomputable def expected_eq (x y : Real) : Prop := x=y
same_basic_target cleanNotation_scalar_addition_29a21dac530425fdc4d4 expected_add
same_basic_target cleanNotation_scalar_product_384e96fe470620f72f6f expected_mul
same_basic_target cleanNotation_scalar_equality_3f1c601070baec9dbb6f expected_eq
noncomputable def expected_authored_sum (x y : Real) : Real := cleanNotation_scalar_addition_29a21dac530425fdc4d4 x y
same_basic_target cleanDefine_authored_sum_0a7ab8cae8b762917a56 expected_authored_sum
def actual_expression (x y : Real) : Prop := (cleanNotation_scalar_equality_3f1c601070baec9dbb6f ((cleanNotation_scalar_addition_29a21dac530425fdc4d4 (x) (y))) ((cleanNotation_scalar_addition_29a21dac530425fdc4d4 (y) (x))))
def expected_expression (x y : Real) : Prop := cleanNotation_scalar_equality_3f1c601070baec9dbb6f (cleanNotation_scalar_addition_29a21dac530425fdc4d4 x y) (cleanNotation_scalar_addition_29a21dac530425fdc4d4 y x)
same_basic_target actual_expression expected_expression
noncomputable def actual_nested (x y : Real) : Real := (cleanNotation_scalar_product_384e96fe470620f72f6f (x) ((cleanNotation_scalar_addition_29a21dac530425fdc4d4 (y) (x))))
noncomputable def expected_nested (x y : Real) : Real := cleanNotation_scalar_product_384e96fe470620f72f6f x (cleanNotation_scalar_addition_29a21dac530425fdc4d4 y x)
same_basic_target actual_nested expected_nested
theorem commutative_example (x y : Real) : actual_expression x y := by
 unfold actual_expression cleanNotation_scalar_equality_3f1c601070baec9dbb6f cleanNotation_scalar_addition_29a21dac530425fdc4d4
 exact add_comm x y
noncomputable def cleanType_Natural_ed60542607241095b2d0  : Type :=
  Nat

noncomputable def cleanType_Grid_bb6a853e5012113f80d0 (m : Nat) (n : Nat) : Type :=
  Matrix (Fin m) (Fin n) Real

noncomputable def cleanType_Column_1f07c16bc0c00c3bb932 (n : Nat) : Type :=
  Fin n → Real

noncomputable def cleanNotation_grid_product_cc3a8a150e155954a3da {m : Nat} {n : Nat} {p : Nat} (A : Matrix (Fin m) (Fin n) Real) (B : Matrix (Fin n) (Fin p) Real) : Matrix (Fin m) (Fin p) Real :=
  A*B

noncomputable def cleanNotation_grid_application_b68b94e24608c2fdbd5c {m : Nat} {n : Nat} (A : Matrix (Fin m) (Fin n) Real) (x : Fin n → Real) : Fin m → Real :=
  Matrix.mulVec A x

noncomputable def cleanNotation_scale_grid_bb440830a1dbec7bc019 {m : Nat} {n : Nat} (s : Real) (A : Matrix (Fin m) (Fin n) Real) : Matrix (Fin m) (Fin n) Real :=
  s • A

noncomputable def cleanNotation_scale_column_e6e6a9a4416b1ed761f0 {n : Nat} (s : Real) (x : Fin n → Real) : Fin n → Real :=
  s • x

noncomputable def cleanNotation_column_equality_e5508af380dcb765d06d {n : Nat} (x : Fin n → Real) (y : Fin n → Real) : Prop :=
  x=y

noncomputable def expected_grid_product {m n p : Nat} (A : Matrix (Fin m) (Fin n) Real) (B : Matrix (Fin n) (Fin p) Real) := A*B
noncomputable def expected_grid_application {m n : Nat} (A : Matrix (Fin m) (Fin n) Real) (x : Fin n → Real) := Matrix.mulVec A x
noncomputable def expected_scale_grid {m n : Nat} (s : Real) (A : Matrix (Fin m) (Fin n) Real) := s • A
noncomputable def expected_scale_column {n : Nat} (s : Real) (x : Fin n → Real) := s • x
noncomputable def expected_column_equality {n : Nat} (x y : Fin n → Real) : Prop := x=y
same_basic_target cleanNotation_grid_product_cc3a8a150e155954a3da expected_grid_product
same_basic_target cleanNotation_grid_application_b68b94e24608c2fdbd5c expected_grid_application
same_basic_target cleanNotation_scale_grid_bb440830a1dbec7bc019 expected_scale_grid
same_basic_target cleanNotation_scale_column_e6e6a9a4416b1ed761f0 expected_scale_column
same_basic_target cleanNotation_column_equality_e5508af380dcb765d06d expected_column_equality
noncomputable def actual_linear_0 (m n p : Nat) (A : Matrix (Fin m) (Fin n) Real) (B : Matrix (Fin n) (Fin p) Real) (y : Fin n → Real) (s : Real) : Matrix (Fin m) (Fin p) Real := (@cleanNotation_grid_product_cc3a8a150e155954a3da (m) (n) (p) (A) (B))
noncomputable def expected_linear_0 (m n p : Nat) (A : Matrix (Fin m) (Fin n) Real) (B : Matrix (Fin n) (Fin p) Real) (y : Fin n → Real) (s : Real) : Matrix (Fin m) (Fin p) Real := @cleanNotation_grid_product_cc3a8a150e155954a3da m n p A B
same_basic_target actual_linear_0 expected_linear_0
noncomputable def actual_linear_1 (m n p : Nat) (A : Matrix (Fin m) (Fin n) Real) (B : Matrix (Fin n) (Fin p) Real) (y : Fin n → Real) (s : Real) : Fin m → Real := (@cleanNotation_grid_application_b68b94e24608c2fdbd5c (m) (n) (A) (y))
noncomputable def expected_linear_1 (m n p : Nat) (A : Matrix (Fin m) (Fin n) Real) (B : Matrix (Fin n) (Fin p) Real) (y : Fin n → Real) (s : Real) : Fin m → Real := @cleanNotation_grid_application_b68b94e24608c2fdbd5c m n A y
same_basic_target actual_linear_1 expected_linear_1
noncomputable def actual_linear_2 (m n p : Nat) (A : Matrix (Fin m) (Fin n) Real) (B : Matrix (Fin n) (Fin p) Real) (y : Fin n → Real) (s : Real) : Matrix (Fin m) (Fin n) Real := (@cleanNotation_scale_grid_bb440830a1dbec7bc019 (m) (n) (s) (A))
noncomputable def expected_linear_2 (m n p : Nat) (A : Matrix (Fin m) (Fin n) Real) (B : Matrix (Fin n) (Fin p) Real) (y : Fin n → Real) (s : Real) : Matrix (Fin m) (Fin n) Real := @cleanNotation_scale_grid_bb440830a1dbec7bc019 m n s A
same_basic_target actual_linear_2 expected_linear_2
noncomputable def actual_linear_3 (m n p : Nat) (A : Matrix (Fin m) (Fin n) Real) (B : Matrix (Fin n) (Fin p) Real) (y : Fin n → Real) (s : Real) : Fin n → Real := (@cleanNotation_scale_column_e6e6a9a4416b1ed761f0 (n) (s) (y))
noncomputable def expected_linear_3 (m n p : Nat) (A : Matrix (Fin m) (Fin n) Real) (B : Matrix (Fin n) (Fin p) Real) (y : Fin n → Real) (s : Real) : Fin n → Real := @cleanNotation_scale_column_e6e6a9a4416b1ed761f0 n s y
same_basic_target actual_linear_3 expected_linear_3
namespace CleanStatements

/--
source: mathlib
reference: Matrix.mulVec_mulVec
relationship: adapted
-/
def grid_product_application : Prop :=
  ∀ (m n p : Nat),
  ∀ (A : Matrix (Fin m) (Fin n) Real),
  ∀ (B : Matrix (Fin n) (Fin p) Real),
  ∀ (x : Fin p → Real),
  (@cleanNotation_column_equality_e5508af380dcb765d06d (m) ((@cleanNotation_grid_application_b68b94e24608c2fdbd5c (m) (p) ((@cleanNotation_grid_product_cc3a8a150e155954a3da (m) (n) (p) (A) (B))) (x))) ((@cleanNotation_grid_application_b68b94e24608c2fdbd5c (m) (n) (A) ((@cleanNotation_grid_application_b68b94e24608c2fdbd5c (n) (p) (B) (x))))))

end CleanStatements

def expected_grid_law : Prop := ∀ (m n p : Nat) (A : Matrix (Fin m) (Fin n) Real)
 (B : Matrix (Fin n) (Fin p) Real) (x : Fin p → Real),
 @cleanNotation_column_equality_e5508af380dcb765d06d m (@cleanNotation_grid_application_b68b94e24608c2fdbd5c m p (@cleanNotation_grid_product_cc3a8a150e155954a3da m n p A B) x) (@cleanNotation_grid_application_b68b94e24608c2fdbd5c m n A (@cleanNotation_grid_application_b68b94e24608c2fdbd5c n p B x))
same_basic_target CleanStatements.grid_product_application expected_grid_law
theorem grid_law_proof : CleanStatements.grid_product_application := by
 intro m n p A B x
 change (A * B).mulVec x = A.mulVec (B.mulVec x)
 exact (Matrix.mulVec_mulVec x A B).symm

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
