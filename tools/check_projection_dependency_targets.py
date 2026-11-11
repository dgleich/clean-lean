# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
import ast,os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[1];sys.path[:0]=[str(ROOT),str(ROOT/'tests')]
from test_projection_dependencies import SOURCE
from cleanlang.core import Environment,Expr,Expressions,lean
from cleanlang.modules import load_module
from cleanlang.conversion import comparison_normal_form,index_comparison
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
with tempfile.TemporaryDirectory() as d:
 path=Path(d)/'Records.clean';path.write_text('Import "'+str(ROOT/'library/logic/proof_equality.clean')+'"\n'+SOURCE+'''
Structure ProducerBox():
  Let value: Natural
  Let unused: Function(Natural,Natural)
  Constructor: producer box
Notation producer argument(n: Natural): Natural:
  Means: n
  Render latex: a({n})
Define projection producer(n: Natural): ProducerBox:
  Equals: producer box(n,function(k: Natural,k))
''')
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
  normalized=comparison_normal_form(value,e,s)
  checks.append(f'noncomputable def normalized{number} ({parameter} : {structure}) : {e.render_type(normalized.type,"lean",s)} := {normalized.lean}')
  checks.append(f'same_basic_target normalized{number} expected{number}')
 checks += [f'theorem countAgreement (c : {c}) : actual0 c = {c}.count c := by rfl',f'theorem valueAgreement (c : {c}) : actual1 c = {c}.value c := by rfl']
 # A binder-bearing producer is retained in source emission but its selected
 # field reduces during comparison; the unused lambda is not normalized.
 s['n']=Expr('n','n',e.type('Natural'),tree=['Local','n'])
 term=Expressions(e,s).parse('projection producer(producer argument(producer argument(n))).value')
 reduced=comparison_normal_form(term,e,s)
 box=e.structures['ProducerBox']['key']
 producer=e.data['functions']['projection producer']['native_binding']
 arg=e.data['functions']['producer argument']['native_binding']
 checks += [f'noncomputable def producerSource (n : {nat}) : {nat} := {term.lean}',
            f'noncomputable def producerExpected (n : {nat}) : {nat} := @{box}.value ({producer} ({arg} ({arg} n)))',
            'same_basic_target producerSource producerExpected',
            f'noncomputable def producerNormal (n : {nat}) : {nat} := {reduced.lean}',
            f'noncomputable def producerNormalExpected (n : {nat}) : {nat} := {arg} ({arg} n)',
            'same_basic_target producerNormal producerNormalExpected',
            f'theorem producerAgreement (n : {nat}) : producerSource n = producerNormal n := by rfl']
 s['b']=Expr('b','b',e.type('ProducerBox'),tree=['Local','b'])
 opaque=Expressions(e,s).parse('producer argument(producer argument(b.value))')
 opaque_key=index_comparison(opaque,e,s)
 checks += [f'noncomputable def opaqueProjectionKey (b : {box}) : {nat} := {opaque_key}',
            f'noncomputable def opaqueProjectionExpected (b : {box}) : {nat} := {arg} ({arg} (@{box}.value b))',
            'same_basic_target opaqueProjectionKey opaqueProjectionExpected',
            f'theorem opaqueProjectionAgreement (b : {box}) : opaqueProjectionKey b = @{box}.value b := by rfl']
 # Rebuilt equal values with different physical sharing use the same key.
 from copy import deepcopy
 from cleanlang.binder_keys import Pool
 reuse_scope={'n':s['n']}
 shared=Expressions(e,reuse_scope).parse('producer argument(n)');shared.type=reuse_scope['n'].type
 rebuilt=deepcopy(shared);e._comparison_pool=Pool(e,reuse_scope,shared.tree)
 try:
  shared_key=index_comparison(shared,e,reuse_scope)
  rebuilt_key=index_comparison(rebuilt,e,reuse_scope)
  assert shared_key==rebuilt_key
 finally:del e._comparison_pool
 checks += [f'noncomputable def rebuiltKey (n : {nat}) : {nat} := {rebuilt_key}',
            f'noncomputable def rebuiltExpected (n : {nat}) : {nat} := {arg} n',
            'same_basic_target rebuiltKey rebuiltExpected',
            f'theorem rebuiltAgreement (n : {nat}) : rebuiltKey n = n := by rfl']
 native=Path(d)/'Checks.lean';native.write_text(lean([],e,['Lean'])+comparison+'\n'.join(checks)+'\n')
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(native)],cwd=ROOT,check=True)
print(f'{sum(line.startswith("same_basic_target") for line in checks)} canonical projection/producer/key targets and {sum(line.startswith("theorem ") for line in checks)} agreement proofs passed.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
