# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Independent native targets for module-declared Natural prefix dimensions."""
from pathlib import Path
from dataclasses import replace
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Expr,Expressions,Type,lean
from cleanlang.modules import load_module,notation
from cleanlang.indices import substitute_index
from cleanlang.retained_codec import dumps,loads

env=Environment();load_module(ROOT/'library/linear_algebra.clean',env)
notation('Notation truncated opposite(x: Natural): Natural:',
 ['Means: 0 - x','Prefix: -','Render latex: -{x}'],env)
scope={n:Expr(n,n,env.type('Natural'),tree=['Local',n]) for n in ['n','k']}
t=lambda name:env.data['types'][name]['native_binding']
fn=env.data['functions']['truncated opposite']['native_binding']
vector=env.type('Vector((-n),Real)',scope)
saved=replace(loads(dumps(vector.args[0])),resolved=None)
changed=substitute_index(saved,{'n':Expressions(env,scope).parse('k')},env,scope)
substituted=Type('Vector',(changed,env.type('Real')))
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(x,ast.Name) and x.id=='COMPARISON' for x in n.targets))
checks=[f'''
noncomputable def expectedPrefix (x : {t('Natural')}) : {t('Natural')} := 0 - x
same_basic_target {fn} expectedPrefix
theorem prefixIsZero (n : {t('Natural')}) : {fn} n = 0 := by simp [{fn}]
''']
for label,name,typ in [('Direct','n',vector),('Substituted','k',substituted)]:
 actual=env.render_type(typ,'lean')
 expected=f"{t('Vector')} ({fn} {name}) {t('Real')}"
 checks.append(f'''
noncomputable def actual{label} ({name} : {t('Natural')}) (x : {actual}) : {actual} := x
noncomputable def expected{label} ({name} : {t('Natural')}) (x : {expected}) : {expected} := x
same_basic_target actual{label} expected{label}
theorem identity{label} ({name} : {t('Natural')}) (x : {expected}) : actual{label} {name} x = x := by rfl
''')
path=ROOT/'generated/DimensionPrefixes.lean'
path.write_text(lean([],env,['Lean'])+comparison+'\n'.join(checks))
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Three exact prefix-dimension targets and three supporting proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
