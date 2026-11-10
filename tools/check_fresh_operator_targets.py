# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Independent native targets for fresh operator evidence types."""
from pathlib import Path
import ast,os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Expr,lean
from cleanlang.modules import load_module,notation
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
e=Environment();load_module(ROOT/'library/logic/proof_equality.clean',e)
notation('Notation retain(x):',['Let A: Type','Let x: A','Returns: A','Means: x','Render latex: {x}'],e)
f=lambda n:e.data['functions'][n]['lean'].split()[0]
eq,neg,disj,keep=map(f,['equal','negation','disjunction','retain'])
scope={'A':Expr('A','A',e.type('Type'),tree=['Local','A'])}
scope['x']=Expr('x','x',e.type('A',scope),tree=['Local','x'])
left=f'@{eq} A (@{keep} A x) x'
right=f'@{eq} A x (@{keep} A (@{keep} A x))'
cases=[('retain(x) = x',left),('not (retain(x) = x)',f'{neg} ({left})'),
 ('not (retain(x) = x) or x = retain(retain(x))',f'{disj} ({neg} ({left})) ({right})')]
body=[]
for i,(source,expected) in enumerate(cases):
 typ=e.type('('+source+')',scope);actual=e.render_type(typ,'lean',scope)
 body += [f'noncomputable def actual{i} (A : Type) (x : A) (h : {actual}) : {actual} := h',
 f'noncomputable def expected{i} (A : Type) (x : A) (h : {expected}) : {expected} := h',
 f'same_basic_target actual{i} expected{i}']
with tempfile.TemporaryDirectory() as directory:
 path=Path(directory)/'Targets.lean';path.write_text(lean([],e,['Lean'])+comparison+'\n'.join(body)+'\n')
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Three independent operator evidence targets passed.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
