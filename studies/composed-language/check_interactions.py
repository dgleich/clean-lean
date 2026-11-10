# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Independent targets spanning retained literals, blocks and dependent records."""
from pathlib import Path
import ast,os,subprocess,tempfile,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
import cleanlang
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
ROOT=Path(cleanlang.__file__).resolve().parents[1]
env=Environment();results=load_document(ROOT/'studies/composed-language/Interactions.clean',env)
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
record=env.structures['SizedVector']['key']
expected=f'''
def expectedVectorAssumption : Prop := ∀ (n : {t('Natural')}) (v : {t('Vector')} n {t('Complex')}),
 {f('equal')} v ({f('vector zero')} n) → {f('equal')} v ({f('vector zero')} n)
def expectedRecordAssumption : Prop := ∀ (V : {record}),
 {f('equal')} (@{record}.vector V) ({f('vector zero')} (@{record}.size V)) →
 {f('equal')} (@{record}.vector V) ({f('vector zero')} (@{record}.size V))
theorem vectorAssumptionChecked : CleanStatements.explicit_vector_zero_assumption := by
 intro n v h
 exact h
theorem recordAssumptionChecked : CleanStatements.inherited_zero_assumption := by
 intro V h
 exact h
'''
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
checks='\nsame_basic_target CleanStatements.explicit_vector_zero_assumption expectedVectorAssumption\nsame_basic_target CleanStatements.inherited_zero_assumption expectedRecordAssumption\n'
with tempfile.TemporaryDirectory(prefix='clean-composed-interactions-') as directory:
 p=Path(directory)/'Interactions.lean';p.write_text(lean(results,env,['Lean'])+expected+comparison+checks)
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Two exact cross-feature statement targets and two proofs passed.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
