import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

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

noncomputable def cleanType_Vertex_460956e39f5b9ffca091 (p0 : Nat) : Type :=
  Fin p0

noncomputable def cleanType_List_530f2b2df99696550311 (p0 : Type) : Type :=
  List (p0)

noncomputable def cleanType_Function_9d746dbeb0e035328deb (p0 : Type) (p1 : Type) : Type :=
  (p0) → (p1)

noncomputable def cleanType_Boolean_b98a4c98fcdb0f46359e  : Type :=
  Bool

noncomputable def cleanNotation_forward_0788bcbcf6947fc792d8   : Bool :=
  true

noncomputable def cleanNotation_backward_71e5eb68c7c3bab34621   : Bool :=
  false

noncomputable def cleanNotation_pair_15b67cb5922a4f50a003 {T : Type} (x : T) (y : T) : List (T) :=
  [x,y]

noncomputable def cleanNotation_repeat_5d2a815b42f0a394de9c {T : Type} (m : ℕ) (x : T) : List (T) :=
  List.replicate m x

noncomputable def cleanNotation_choices_82b7351357b42ac043a7 {T : Type} (xs : List (List (T))) : List (List (T)) :=
  xs.sections

noncomputable def cleanNotation_map_5d12d795d56ba7da86f5 {T : Type} {U : Type} (f : (T) → (U)) (xs : List (T)) : List (U) :=
  xs.map f

noncomputable def cleanNotation_filter_35fa41184b3a88d16472 {T : Type} (p : (T) → (Prop)) (xs : List (T)) : List (T) :=
  by classical exact xs.filter (fun x => decide (p x))

noncomputable def cleanNotation_choose_e2e205d694c074a81133 {T : Type} (b : Bool) (x : T) (y : T) : T :=
  if b then x else y

noncomputable def cleanNotation_count_58b76c666a9f94fdd55a  (b : Bool) (w : List (Bool)) : ℕ :=
  w.count b

noncomputable def cleanNotation_real_index_c182be2e79fff5553306  (k : ℕ) : ℝ :=
  (k : ℝ)

noncomputable def cleanNotation_sum_matrices_63af84fc6c041afce7bc {n : ℕ} (xs : List (Matrix (Fin n) (Fin n) ℝ)) : Matrix (Fin n) (Fin n) ℝ :=
  xs.sum

noncomputable def cleanNotation_ordered_product_850ea9b0a756a4abc0d2 {n : ℕ} (xs : List (Matrix (Fin n) (Fin n) ℝ)) : Matrix (Fin n) (Fin n) ℝ :=
  xs.prod

noncomputable def cleanNotation_sum_before_769a3c05d6498272ed95 {n : ℕ} (m : ℕ) (f : (ℕ) → (Matrix (Fin n) (Fin n) ℂ)) : Matrix (Fin n) (Fin n) ℂ :=
  ∑ k ∈ Finset.range m, f k

noncomputable def cleanNotation_sum_vertices_19d97077445340f1536d {n : ℕ} (f : (Fin n) → (ℝ)) : ℝ :=
  ∑ i, f i

noncomputable def cleanNotation_entry_42bc533c4b61ce6d9dc9 {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (i : Fin n) (j : Fin n) : ℝ :=
  A i j

noncomputable def cleanNotation_diagonal_924e1f360361bb7f3f3d {n : ℕ} (f : (Fin n) → (ℝ)) : Matrix (Fin n) (Fin n) ℝ :=
  Matrix.diagonal f

noncomputable def cleanNotation_pi_3318d6df42e441010576   : ℝ :=
  Real.pi

noncomputable def cleanNotation_imaginary_unit_dd12d90e3449de458b3a   : ℂ :=
  Complex.I

noncomputable def cleanNotation_complex_scalar_6201cf55b76113d50a6e  (x : ℝ) : ℂ :=
  (x : ℂ)

noncomputable def cleanNotation_complex_exponential_88b7620f1ee63bf4a99d  (z : ℂ) : ℂ :=
  Complex.exp z

noncomputable def cleanNotation_complex_matrix_8ce504730fda017d8908 {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  Complex.ofRealHom.mapMatrix A

noncomputable def cleanNotation_real_transpose_110eeb37f2a3ed58943f {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  A.transpose

noncomputable def cleanDefine_Hermitian_1667495db879ea20ebaa {n : ℕ} (M : Matrix (Fin n) (Fin n) ℂ) : Prop :=
  M.IsHermitian

noncomputable def cleanDefine_symmetric_d11eb3f5e742e399d7fb {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) : Prop :=
  (A = (cleanNotation_real_transpose_110eeb37f2a3ed58943f (A)))

noncomputable def cleanDefine_positive_8c3e9169f0fc7959e8fa  (x : ℝ) : Prop :=
  (x > 0)


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: conditionexamples
reference: symmetry restated
relationship: original
-/
def symmetry_restated : Prop :=
  ∀ (n : ℕ),
  ∀ (A B : Matrix (Fin n) (Fin n) ℝ),
  ∀ («symmetry_of_A» : (cleanDefine_symmetric_d11eb3f5e742e399d7fb (A))),
  ∀ («symmetry_of_B» : (cleanDefine_symmetric_d11eb3f5e742e399d7fb (B))),
  ((cleanDefine_symmetric_d11eb3f5e742e399d7fb (A)) ∧ (cleanDefine_symmetric_d11eb3f5e742e399d7fb (B)))

/--
source: conditionexamples
reference: positive values
relationship: original
-/
def positive_values : Prop :=
  ∀ (x y : ℝ),
  ∀ («positivity_of_x» : (cleanDefine_positive_8c3e9169f0fc7959e8fa (x))),
  ∀ («positivity_of_y» : (cleanDefine_positive_8c3e9169f0fc7959e8fa (y))),
  ((x > 0) ∧ (y > 0))

end CleanStatements

-- generated: gpt-6 2026-10-30 role=assisted; LLM-authored portions; see PROVENANCE.md
