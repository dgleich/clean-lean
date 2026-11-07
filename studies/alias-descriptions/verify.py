# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
from pathlib import Path
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
e=Environment();rs=load_document(HERE/'Statements.clean',e)
s=lean(rs,e,['Lean']);(HERE/'Generated.lean').write_text(s)
(HERE/'Statements.tex').write_text(latex(rs,e))
expected='''
namespace AliasOracle
def single : Prop := ∀ (A : Type) (S : Set A) (x : {a : A // a ∈ S}), x = x
def pair : Prop := ∀ (A : Type) (S : Set A) (x y : {a : A // a ∈ S}), x = x ∧ y = y
end AliasOracle
'''
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
s+=expected+comparison+'''
same_basic_target CleanStatements.selected_element_identity AliasOracle.single
same_basic_target CleanStatements.eligible_element_identity AliasOracle.single
same_basic_target CleanStatements.selected_pair_identity AliasOracle.pair

theorem selected_checked : CleanStatements.selected_element_identity := by
 intro A S x
 rfl
theorem eligible_checked : CleanStatements.eligible_element_identity := by
 intro A S x
 rfl
theorem pair_checked : CleanStatements.selected_pair_identity := by
 intro A S x y
 exact ⟨rfl, rfl⟩
'''
(HERE/'Verified.lean').write_text(s)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(HERE/'Verified.lean')],cwd=ROOT,check=True)
print('Three exact alias statement targets and three proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
