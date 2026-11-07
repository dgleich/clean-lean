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
noncomputable def cleanType_Function_8573b0da6c8c62c25d21 (A : Type) (B : Type) : Type :=
  (A) → (B)

noncomputable def cleanNotation_natural_equality_e814707e5958f10c3f51  (x : Nat) (y : Nat) : Prop :=
  x=y

noncomputable def cleanNotation_retain_with_law_2e7ea68c44942dbe9392 {T : Type} (n : Nat) (f : (Nat) → (Nat)) (h : (clean_pi_bound_0 : Nat) → (((cleanNotation_natural_equality_e814707e5958f10c3f51 ((f clean_pi_bound_0)) (n))))) (z : T) : T :=
  z

noncomputable def cleanNotation_apply_reflexive_family_b0a48f9adb3b8e7f3fdd  (h : (clean_pi_bound_1 : Nat) → (((cleanNotation_natural_equality_e814707e5958f10c3f51 (clean_pi_bound_1) (clean_pi_bound_1))))) (n : Nat) : ((cleanNotation_natural_equality_e814707e5958f10c3f51 (n) (n))) :=
  h n


noncomputable def expected_natural_equality (x y : Nat) : Prop := x=y
noncomputable def expected_retain {T : Type} (n : Nat) (f : Nat → Nat)
 (h : (x : Nat) → cleanNotation_natural_equality_e814707e5958f10c3f51 (f x) n) (z : T) : T := z
noncomputable def expected_family_apply (h : (x : Nat) → cleanNotation_natural_equality_e814707e5958f10c3f51 x x) (n : Nat) : cleanNotation_natural_equality_e814707e5958f10c3f51 n n := h n
same_basic_target cleanNotation_natural_equality_e814707e5958f10c3f51 expected_natural_equality
same_basic_target cleanNotation_retain_with_law_2e7ea68c44942dbe9392 expected_retain
same_basic_target cleanNotation_apply_reflexive_family_b0a48f9adb3b8e7f3fdd expected_family_apply
noncomputable def actual_retained (n m : Nat) (z : Real) (h : ∀ x : Nat, cleanNotation_natural_equality_e814707e5958f10c3f51 n m) : Real := (@cleanNotation_retain_with_law_2e7ea68c44942dbe9392 (Real) (m) ((fun (clean_bound_0 : Nat) => n)) ((fun (clean_bound_1 : Nat) => (h clean_bound_1))) (z))
noncomputable def expected_retained (n m : Nat) (z : Real) (h : ∀ x : Nat, cleanNotation_natural_equality_e814707e5958f10c3f51 n m) : Real :=
 @cleanNotation_retain_with_law_2e7ea68c44942dbe9392 Real m (fun x : Nat => n) (fun x : Nat => h x) z
same_basic_target actual_retained expected_retained
noncomputable def actual_family_application (refl : ∀ x : Nat, cleanNotation_natural_equality_e814707e5958f10c3f51 x x) (n : Nat) : cleanNotation_natural_equality_e814707e5958f10c3f51 n n := (@cleanNotation_apply_reflexive_family_b0a48f9adb3b8e7f3fdd (refl) (n))
noncomputable def expected_family_application (refl : ∀ x : Nat, cleanNotation_natural_equality_e814707e5958f10c3f51 x x) (n : Nat) : cleanNotation_natural_equality_e814707e5958f10c3f51 n n := cleanNotation_apply_reflexive_family_b0a48f9adb3b8e7f3fdd refl n
same_basic_target actual_family_application expected_family_application
noncomputable def cleanNotation_scalar_opposite_3bc08c1aca276578cf96  (x : Real) : Real :=
  -x

noncomputable def cleanNotation_condition_negation_e13248ce4dea13616d10  (p : Prop) : Prop :=
  ¬p

noncomputable def cleanNotation_scalar_difference_1069573284f1ba4f0971  (x : Real) (y : Real) : Real :=
  x-y

noncomputable def cleanType_Row_a61e1adde933155df482 (n : Nat) : Type :=
  Fin n → Real

noncomputable def cleanNotation_row_opposite_c72a43200363c5798dbc {n : Nat} (x : Fin n → Real) : Fin n → Real :=
  -x

noncomputable def cleanDefine_authored_opposite_93bb3d112909e8552eb9  (x : Real) : Real :=
  (cleanNotation_scalar_opposite_3bc08c1aca276578cf96 (x))


noncomputable def expected_prefix_neg (x : Real) : Real := -x
noncomputable def expected_prefix_not (p : Prop) : Prop := ¬p
noncomputable def expected_prefix_sub (x y : Real) : Real := x-y
noncomputable def expected_prefix_row {n : Nat} (x : Fin n → Real) : Fin n → Real := -x
noncomputable def expected_authored_opposite (x : Real) : Real := cleanNotation_scalar_opposite_3bc08c1aca276578cf96 x
same_basic_target cleanNotation_scalar_opposite_3bc08c1aca276578cf96 expected_prefix_neg
same_basic_target cleanNotation_condition_negation_e13248ce4dea13616d10 expected_prefix_not
same_basic_target cleanNotation_scalar_difference_1069573284f1ba4f0971 expected_prefix_sub
same_basic_target cleanNotation_row_opposite_c72a43200363c5798dbc expected_prefix_row
same_basic_target cleanDefine_authored_opposite_93bb3d112909e8552eb9 expected_authored_opposite
noncomputable def actual_prefix_0 (n : Nat) (x y : Real) (v : Fin n → Real) : Real := (cleanNotation_scalar_opposite_3bc08c1aca276578cf96 (x))
noncomputable def expected_prefix_0 (n : Nat) (x y : Real) (v : Fin n → Real) : Real := cleanNotation_scalar_opposite_3bc08c1aca276578cf96 x
same_basic_target actual_prefix_0 expected_prefix_0
noncomputable def actual_prefix_1 (n : Nat) (x y : Real) (v : Fin n → Real) : Real := (cleanNotation_scalar_opposite_3bc08c1aca276578cf96 ((cleanNotation_scalar_addition_29a21dac530425fdc4d4 (x) (y))))
noncomputable def expected_prefix_1 (n : Nat) (x y : Real) (v : Fin n → Real) : Real := cleanNotation_scalar_opposite_3bc08c1aca276578cf96 (cleanNotation_scalar_addition_29a21dac530425fdc4d4 x y)
same_basic_target actual_prefix_1 expected_prefix_1
noncomputable def actual_prefix_2 (n : Nat) (x y : Real) (v : Fin n → Real) : Prop := (cleanNotation_condition_negation_e13248ce4dea13616d10 ((cleanNotation_scalar_equality_3f1c601070baec9dbb6f (x) (y))))
noncomputable def expected_prefix_2 (n : Nat) (x y : Real) (v : Fin n → Real) : Prop := cleanNotation_condition_negation_e13248ce4dea13616d10 (cleanNotation_scalar_equality_3f1c601070baec9dbb6f x y)
same_basic_target actual_prefix_2 expected_prefix_2
noncomputable def actual_prefix_3 (n : Nat) (x y : Real) (v : Fin n → Real) : Fin n → Real := (@cleanNotation_row_opposite_c72a43200363c5798dbc (n) (v))
noncomputable def expected_prefix_3 (n : Nat) (x y : Real) (v : Fin n → Real) : Fin n → Real := @cleanNotation_row_opposite_c72a43200363c5798dbc n v
same_basic_target actual_prefix_3 expected_prefix_3
noncomputable def actual_prefix_4 (n : Nat) (x y : Real) (v : Fin n → Real) : Real := (cleanNotation_scalar_opposite_3bc08c1aca276578cf96 ((cleanNotation_scalar_opposite_3bc08c1aca276578cf96 (x))))
noncomputable def expected_prefix_4 (n : Nat) (x y : Real) (v : Fin n → Real) : Real := cleanNotation_scalar_opposite_3bc08c1aca276578cf96 (cleanNotation_scalar_opposite_3bc08c1aca276578cf96 x)
same_basic_target actual_prefix_4 expected_prefix_4
noncomputable def actual_prefix_5 (n : Nat) (x y : Real) (v : Fin n → Real) : Real := (cleanNotation_scalar_difference_1069573284f1ba4f0971 (x) ((cleanNotation_scalar_opposite_3bc08c1aca276578cf96 (y))))
noncomputable def expected_prefix_5 (n : Nat) (x y : Real) (v : Fin n → Real) : Real := cleanNotation_scalar_difference_1069573284f1ba4f0971 x (cleanNotation_scalar_opposite_3bc08c1aca276578cf96 y)
same_basic_target actual_prefix_5 expected_prefix_5
theorem prefix_double_opposite (x : Real) : cleanNotation_scalar_opposite_3bc08c1aca276578cf96 (cleanNotation_scalar_opposite_3bc08c1aca276578cf96 x) = x := by
 change -(-x) = x
 exact neg_neg x

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
