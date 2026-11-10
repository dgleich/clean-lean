# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
import ast,os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'tests')]
from test_projection_dependencies import SOURCE
from cleanlang.core import Environment,Expr,Expressions,lean
from cleanlang.modules import load_module
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
with tempfile.TemporaryDirectory() as d:
 path=Path(d)/'Records.clean';path.write_text('Import "'+str(ROOT/'library/logic/proof_equality.clean')+'"\n'+SOURCE)
 e=Environment();load_module(path,e)
 c,t,i=[e.structures[name]['key'] for name in ['Choice','Tower','Indexed']]
 nat=e.data['types']['Natural']['native_binding']
 eq=e.data['functions']['equal']['native_binding'];same=e.data['functions']['same evidence']['native_binding']
 s={n:Expr(n,n,e.type(typ),tree=['Local',n]) for n,typ in [('c','Choice'),('t','Tower'),('i','Indexed')]}
 checks=[]
 expected_types=[f'{nat}',f'{c}.carrier c',f'@{same} (@{eq} ({t}.carrier t) ({t}.object t) ({t}.object t)) ({t}.selected t) ({t}.selected t)',f'@{eq} {nat} ({i}.mark i ({i}.point i)) ({i}.mark i ({i}.point i))']
 for number,(source,parameter,structure,field,expected_type) in enumerate(zip(['c.count','c.value','t.witness','i.law'],['c','c','t','i'],[c,c,t,i],['count','value','witness','law'],expected_types)):
  value=Expressions(e,s).parse(source)
  checks.append(f'noncomputable def actual{number} ({parameter} : {structure}) : {e.render_type(value.type,"lean",s)} := {value.lean}')
  checks.append(f'noncomputable def expected{number} ({parameter} : {structure}) : {expected_type} := @{structure}.{field} {parameter}')
  checks.append(f'same_basic_target actual{number} expected{number}')
 checks += [f'theorem countAgreement (c : {c}) : actual0 c = {c}.count c := by rfl',f'theorem valueAgreement (c : {c}) : actual1 c = {c}.value c := by rfl']
 native=Path(d)/'Checks.lean';native.write_text(lean([],e,['Lean'])+comparison+'\n'.join(checks)+'\n')
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(native)],cwd=ROOT,check=True)
print('Four canonical projection targets and two agreement proofs passed.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
