# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Check assumption layout against an independent Lean proposition and proof."""
import ast,os,subprocess,sys,tempfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,parse
from cleanlang.modules import load_module
env=Environment();load_module(ROOT/'library/standard.clean',env)
env.sources.declare('local',{'kind':'other','label':'Local','title':'Assumption blocks'},ROOT)
def source(clause):
 return 'Result identity:\n  Attribution: local; identity; original\n  Let x: Real\n'+clause+'\n  Conclude: x = x\n'
forms=['  Assume reflexive: x = x','  Assume reflexive:\n    x = x','  Assume reflexive:\n     x =\n     x']
targets=[lean(parse(source(form),env),env,['Lean']) for form in forms]
assert all(target==targets[0] for target in targets)
real=env.data['types']['Real']['native_binding'];eq=env.data['functions']['equal']['native_binding']
oracle=f'''
def independentAssumptionTarget : Prop := ∀ (x : {real}), {eq} x x → {eq} x x
theorem assumptionBlockChecked : CleanStatements.identity := by
 intro x reflexive
 exact reflexive
'''
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
with tempfile.TemporaryDirectory(prefix='clean-assumption-native-') as directory:
 p=Path(directory)/'Check.lean';p.write_text(targets[0]+oracle+comparison+'\nsame_basic_target CleanStatements.identity independentAssumptionTarget\n')
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Three source layouts share one independently checked exact target; one proof passed.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
