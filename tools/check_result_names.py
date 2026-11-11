# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Independent native checks for result identifier quoting, with kernel proofs."""
from pathlib import Path
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(ROOT),str(ROOT/'tests')]
from test_result_names import load,TITLES
from cleanlang.core import lean
env,results=load(TITLES)
real=env.data['types']['Real']['native_binding']
equal=env.data['functions']['equal']['native_binding']
expected=f'\nnoncomputable def ResultNameOracle : Prop := ∀ (x : _root_.{real}), _root_.{equal} x x\n'
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
# Explicit independent names preserve the existing title-normalization contract.
names=['example','theorem','def','namespace','end','match','by','where','if','else','κ','ordinary_result']
checks=''.join(f'''\nsame_basic_target CleanStatements.«{name}» ResultNameOracle
theorem result_name_{i}_proved : CleanStatements.«{name}» := by
  intro x
  rfl
''' for i,name in enumerate(names))
checks+='\n#check CleanStatements.ordinary_result\n'
p=ROOT/'generated/ResultNames.lean';p.write_text(lean(results,env,['Lean'])+expected+comparison+checks)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Twelve exact result-name targets and twelve kernel proofs passed.')

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
