# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Exact native targets for selected contextual callable types, not lambda bodies."""
from pathlib import Path
import ast,os,subprocess,sys
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path[:0]=[str(ROOT),str(HERE)]
from cleanlang.core import Environment,Expr,lean
from cleanlang.modules import load_module
from binder_types import CheckedBinderTypes
from constraint_model import Binder,Reference,Variable,Row,open_binder
from contextual_terms import Parameter,Actual,callable_type
from contextual_constraints import Family,Occurrence,Candidate,select_contextual

env=Environment();load_module(ROOT/'library/linear_algebra.clean',env)
scope={'n':Expr('n','n',env.type('Natural'),tree=['Local','n'])}
t=lambda name:env.data['types'][name]['native_binding']
f=lambda name:env.data['functions'][name]['native_binding']
num=env.data['types']['Natural']['numerals']['native_binding']
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(x,ast.Name) and x.id=='COMPARISON' for x in n.targets))
cases=[
 ('Function(k: Natural,Vector(k,Complex))',1,
  f'(k : {t("Natural")}) → {t("Vector")} k {t("Complex")}',
  '(k : ℕ) → Fin k → ℂ'),
 ('Function(j: Natural,Function(k: Natural,Matrix(j,k,Complex)))',2,
  f'(j : {t("Natural")}) → (k : {t("Natural")}) → {t("Matrix")} j k {t("Complex")}',
  '(j k : ℕ) → Matrix (Fin j) (Fin k) ℂ'),
 ('Function(k: Natural,Vector((k+1),Complex))',1,
  f'(k : {t("Natural")}) → {t("Vector")} ({f("natural sum")} k ({num} (nat_lit 1))) {t("Complex")}',
  '(k : ℕ) → Fin (k+1) → ℂ'),
 ('Function(k: Natural,Matrix(k,n,Complex))',1,
  f'(k : {t("Natural")}) → {t("Matrix")} k n {t("Complex")}',
  '(k : ℕ) → Matrix (Fin k) (Fin n) ℂ'),
]
checks=[]
for i,(source,count,expected,meaning) in enumerate(cases):
 codec=CheckedBinderTypes(env,scope);term=codec.encode(env.type(source,scope))
 parameters=[];actuals=[];current=term
 for index in range(count):
  assert isinstance(current,Binder)
  local=('contextual native local',index)
  parameters.append(Parameter(local,current.domain,'index'))
  actuals.append(Actual(Reference(local,'index'),current.domain))
  current=open_binder(current,local,'index')
 family=Family('result',tuple(parameters),'type')
 carrier=codec.encode(env.type('Real'))
 output=Variable('output','type',frozenset(p.name for p in parameters))
 candidate=Candidate(Row(('selected',),(carrier,),(output,)),(family,),
  (Occurrence('known','result',tuple(actuals),current),Occurrence('use','result',tuple(actuals),output)))
 selected=select_contextual((candidate,),default=carrier)
 reconstructed=codec.decode(callable_type(selected.solutions['result'],t('Function')))
 rendered=env.render_type(reconstructed,'lean',scope)
 checks.append(f'''
noncomputable def actualContextual{i} (n : {t('Natural')}) : Type := {rendered}
noncomputable def expectedContextual{i} (n : {t('Natural')}) : Type := {expected}
same_basic_target actualContextual{i} expectedContextual{i}
theorem contextualMeaning{i} (n : {t('Natural')}) : actualContextual{i} n = ({meaning}) := by rfl
''')
path=HERE/'ContextualTargets.lean';path.write_text(lean([],env,['Lean'])+comparison+'\n'.join(checks))
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Four selected contextual callable-type targets and four interpretation proofs passed; source lambda inference remains pending.')

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
