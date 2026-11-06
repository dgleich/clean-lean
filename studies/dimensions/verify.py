# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
e=Environment();rs=load_document(here/'Statements.clean',e)
source=lean(rs,e,['Lean'])
(here/'Statements.lean').write_text(source);(here/'Statements.tex').write_text(latex(rs,e))
f=lambda n:e.data['functions'][n]['lean'].split()[0]
expected=r'''
namespace DimensionOracle
noncomputable def vectorIdentity (n : ℕ) (x : Fin n → ℝ) : Fin n → ℝ := x
def determinantStatement : Prop := ∀ (n : ℕ), let m : ℕ := n;
  ∀ (A : Matrix (Fin n) (Fin n) ℂ) (B : Matrix (Fin m) (Fin m) ℂ),
  @DET m (A * B) = @DET n A * @DET m B
def transposeStatement : Prop := ∀ (n : ℕ), let m : ℕ := n;
  ∀ (A : Matrix (Fin m) (Fin n) ℂ), @TRANSPOSE n m (@TRANSPOSE m n A) = A
def literalStatement : Prop := ∀ (x : Fin 3 → ℝ), @IDENTITY 3 x = x
def fieldStatement : Prop := ∀ (S : SIZED), @IDENTITY S.size S.vector = S.vector
end DimensionOracle
'''.replace('DET',f('det')).replace('TRANSPOSE',f('transpose')).replace('IDENTITY',f('vector identity')).replace('SIZED',e.structures['SizedVector']['key'])
checks=r'''
open Lean Elab Command
private def canonical : Expr → Expr
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj n i (canonical b)
  | e => e
elab "same_target " a:ident b:ident : command => do
  let env ← getEnv
  let some (.defnInfo x) := env.find? a.getId | throwError "Missing actual target"
  let some (.defnInfo y) := env.find? b.getId | throwError "Missing expected target"
  unless x.levelParams == y.levelParams && Expr.equal (canonical x.type) (canonical y.type) &&
    Expr.equal (canonical x.value) (canonical y.value) do
    throwError "Canonical target differs: {a} vs {b}"
same_target IDENTITY DimensionOracle.vectorIdentity
same_target CleanStatements.determinant_with_named_dimension DimensionOracle.determinantStatement
same_target CleanStatements.transpose_with_named_dimension DimensionOracle.transposeStatement
same_target CleanStatements.explicit_dimension_literal DimensionOracle.literalStatement
same_target CleanStatements.dimension_from_record_field DimensionOracle.fieldStatement
namespace DimensionProofs
theorem determinant : CleanStatements.determinant_with_named_dimension := by
  intro n
  dsimp only
  intro A B
  exact Matrix.det_mul A B
theorem transpose : CleanStatements.transpose_with_named_dimension := by
  intro n
  dsimp only
  intro A
  rfl
theorem literal : CleanStatements.explicit_dimension_literal := by
  intro x
  rfl
theorem stored_dimension : CleanStatements.dimension_from_record_field := by
  intro S
  rfl
end DimensionProofs
'''.replace('IDENTITY',f('vector identity'))
p=here/'Verified.lean';p.write_text(source+expected+checks)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Five exact dimension targets and four proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
