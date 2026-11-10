# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'CarrierExample.clean',env)
source=lean(results,env,['Lean'])
keys={name:env.data['functions'][name]['native_binding'] for name in ('retain','retain twice','equal large')}
space=env.data['types']['TopologicalSpace']['native_binding']
expected='''
namespace CarrierOracle
abbrev classifier : Type 2 := Type 1
noncomputable def retain {A : Type 1} (x : A) : A := x
noncomputable def twice {A : Type 1} (x : A) : A := RETAIN (RETAIN x)
noncomputable def equalLarge {A : Type 1} (x y : A) : Prop := x = y
noncomputable def statement : Prop := ∀ (X : SPACE), EQUAL (TWICE X) X
end CarrierOracle
'''
for old,new in [('RETAIN',keys['retain']),('TWICE',keys['retain twice']),('EQUAL',keys['equal large']),('SPACE',space)]:expected=expected.replace(old,new)
# The condition's return type is the declared Proposition wrapper, as in Clean.
prop=env.data['types']['Proposition']['native_binding']
expected=expected.replace('(x y : A) : Prop', '(x y : A) : '+prop)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(env.data['types']['LargeTypes']['native_binding'],'classifier'),(keys['retain'],'retain'),(keys['retain twice'],'twice'),(keys['equal large'],'equalLarge'),('CleanStatements.retain_topology_object','statement')]
source+=expected+comparison+'\n'.join('same_basic_target '+a+' CarrierOracle.'+b for a,b in pairs)+'\n'
source+='theorem retain_topology_object_proved : CleanStatements.retain_topology_object := by\n  intro X\n  rfl\n'
source+='\n-- generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md\n'
p=HERE/'CarrierTargets.lean';p.write_text(source)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Five exact carrier targets and the topology-object identity proof passed.')
