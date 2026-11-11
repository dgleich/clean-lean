# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Independent closed-universe nominal targets through the joint completion API."""
from pathlib import Path
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Expr,lean
from cleanlang.modules import load_module,type_declaration
from cleanlang.syntax import parse,expression_tree
from cleanlang.joint_inference import complete

env=Environment();load_module(ROOT/'library/operators.clean',env)
t=lambda name:env.data['types'][name]['native_binding']
f=lambda name:env.data['functions'][name]['native_binding']
numeral=env.data['types']['Natural']['numerals']['native_binding']
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(x,ast.Name) and x.id=='COMPARISON' for x in n.targets))
checks=[]
for level in (1,2):
 name='High'+str(level)
 type_declaration('Type '+name+'():',['Universe: '+str(level),'Means: ULift.{'+str(level)+',0} Nat','Render latex: H'],env)
 typ=env.type(name)
 scope={'n':Expr('n','n',env.type('Natural'),tree=['Local','n']),
        'object':Expr('object','object',env.function_type(env.type('Natural'),typ),tree=['Local','object'])}
 value=complete(expression_tree(parse('object(n+1)','expression')),env,scope,use_default=False)
 checks.append(f'''
noncomputable def actualHigher{level} (object : {t('Natural')} → {t(name)}) (n : {t('Natural')}) : {t(name)} := {value.lean}
noncomputable def expectedHigher{level} (object : {t('Natural')} → {t(name)}) (n : {t('Natural')}) : {t(name)} := object ({f('natural sum')} n ({numeral} (nat_lit 1)))
same_basic_target actualHigher{level} expectedHigher{level}
theorem higherMeaning{level} (object : {t('Natural')} → {t(name)}) (n : {t('Natural')}) : actualHigher{level} object n = object (n+1) := by rfl
''')
path=ROOT/'studies/parameterized-literals/HigherTargets.lean'
path.write_text(lean([],env,['Lean'])+comparison+'\n'.join(checks))
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Two higher-universe nominal targets and two interpretation proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
