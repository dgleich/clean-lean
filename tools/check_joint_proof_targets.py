# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Independent targets for checked evidence in the explicit joint solver."""
from pathlib import Path
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Expr,lean
from cleanlang.modules import load_module,notation
from cleanlang.syntax import parse,expression_tree
from cleanlang.joint_inference import complete
env=Environment();load_module(ROOT/'library/linear_algebra.clean',env);load_module(ROOT/'library/logic/evidence.clean',env)
scope={'n':Expr('n','n',env.type('Natural'),tree=['Local','n'])}
scope['h']=Expr('h','h',env.type('Evidence((n=n))',scope),tree=['Local','h'])
notation('Notation self equality(n: Natural): Evidence((n=n)):', ['Means: rfl','Render latex: e({n})'],env)
notation('Notation keep evidence(n: Natural,h: Evidence((n=n)),z: Real): Natural:', ['Means: n','Render latex: k({n},{h},{z})'],env)
f=lambda name:env.data['functions'][name]['native_binding']
t=lambda name:env.data['types'][name]['native_binding']
num=lambda name:env.data['types'][name]['numerals']['native_binding']
realzero=f'{num("Real")} (nat_lit 0)';natone=f'{num("Natural")} (nat_lit 1)'
shift=f'{f("natural sum")} n ({natone})'
comparison=next(ast.literal_eval(node.value) for node in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(node,ast.Assign) and any(isinstance(x,ast.Name) and x.id=='COMPARISON' for x in node.targets))
checks=[]
value=complete(expression_tree(parse('keep evidence(n,h,0)','expression')),env,scope,use_default=False)
checks.append(f'''
noncomputable def actualEvidence (n : {t('Natural')}) (h : {f('equal')} n n) : {t('Natural')} := {value.lean}
noncomputable def expectedEvidence (n : {t('Natural')}) (h : {f('equal')} n n) : {t('Natural')} := {f('keep evidence')} n h ({realzero})
same_basic_target actualEvidence expectedEvidence
theorem evidenceMeaning (n : {t('Natural')}) (h : {f('equal')} n n) : actualEvidence n h = n := by rfl
''')
value=complete(expression_tree(parse('self equality(n+1)','expression')),env,scope,use_default=False)
checks.append(f'''
noncomputable def actualProof (n : {t('Natural')}) : {f('equal')} ({shift}) ({shift}) := {value.lean}
noncomputable def expectedProof (n : {t('Natural')}) : {f('equal')} ({shift}) ({shift}) := {f('self equality')} ({shift})
same_basic_target actualProof expectedProof
theorem proofMeaning (n : {t('Natural')}) : actualProof n = expectedProof n := by rfl
''')
value=complete(expression_tree(parse('for every(k: Natural,keep evidence(k,self equality(k),0)=k)','expression')),env,scope,use_default=False)
checks.append(f'''
def actualQuantifiedEvidence : Prop := {value.lean}
def expectedQuantifiedEvidence : Prop := ∀ (k : {t('Natural')}), {f('equal')} ({f('keep evidence')} k ({f('self equality')} k) ({realzero})) k
same_basic_target actualQuantifiedEvidence expectedQuantifiedEvidence
theorem quantifiedEvidenceMeaning : actualQuantifiedEvidence := by intro k; rfl
''')
path=ROOT/'studies/parameterized-literals/ProofTargets.lean';path.write_text(lean([],env,['Lean'])+comparison+'\n'.join(checks))
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Three exact evidence targets and three interpretation proofs passed; callable proof discovery and production integration remain pending.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
