# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Native complete-call targets for automatic experimental scoped consumers."""
from pathlib import Path
import ast,os,subprocess,sys
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path[:0]=[str(ROOT),str(HERE)]
from cleanlang.core import Environment,Expr,lean
from cleanlang.modules import load_module,notation
from cleanlang.syntax import parse,expression_tree
from clean_rows import Builder

env=Environment();load_module(ROOT/'library/linear_algebra.clean',env)
scope={n:Expr(n,n,env.type('Natural'),tree=['Local',n]) for n in ('n','m')}
t=lambda name:env.data['types'][name]['native_binding']
f=lambda name:env.data['functions'][name]['native_binding']
num=lambda name:env.data['types'][name]['numerals']['native_binding']
zr=f'{num("Real")} (nat_lit 0)';zc=f'{num("Complex")} (nat_lit 0)';one=f'{num("Natural")} (nat_lit 1)'
zv=f('complex vector zero')
cases=[
 ('consume family','f: Function(k: Natural,Vector(k,Complex)),x: Real','Real','x',
  'consume family(function (k: Natural,0),0)',f'(fun (k : {t("Natural")}) => {zv} k) ({zr})'),
 ('apply complex','f: Function(Complex,Complex),x: Complex','Complex','f x',
  'apply complex(function (z: Complex,0),0)',f'(fun (z : {t("Complex")}) => {zc}) ({zc})'),
 ('consume shifted','f: Function(k: Natural,Vector((k+1),Complex)),x: Real','Real','x',
  'consume shifted(function (k: Natural,0),0)',f'(fun (k : {t("Natural")}) => {zv} ({f("natural sum")} k ({one}))) ({zr})'),
 ('sized','n: Natural,f: Function(Real,Vector(n,Complex))','Real','0',
  'sized(n,function (z: Real,0))',f'n (fun (z : {t("Real")}) => {zv} n)'),
 ('mixed','n: Natural,m: Natural,f: Function(Real,Real),a: Vector(n,Complex),b: Vector(m,Complex)','Real','f 0',
  'mixed(n,m,function (z: Real,0),0,0)',f'n m (fun (z : {t("Real")}) => {zr}) ({zv} n) ({zv} m)'),
 ('two','f: Function(Real,Real),g: Function(Real,Complex)','Real','f 0',
  'two(function (a: Real,0),function (b: Real,0))',f'(fun (a : {t("Real")}) => {zr}) (fun (b : {t("Real")}) => {zc})'),
 ('typed','T: Type,f: Function(T,T),x: T','T','f x',
  'typed(type(Real),function (z: Real,0),0)',f'{t("Real")} (fun (z : {t("Real")}) => {zr}) ({zr})'),
 ('accept','p: Proposition,x: Real','Real','x',
  'accept(for every (z: Real,z = 0),0)',f'(∀ (z : {t("Real")}), @{f("equal")} {t("Real")} z ({zr})) ({zr})'),
]
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(x,ast.Name) and x.id=='COMPARISON' for x in n.targets))
checks=[]
for i,(name,parameters,result,meaning,source,expected) in enumerate(cases):
 notation(f'Notation {name}({parameters}): {result}:',['Means: '+meaning,'Render latex: consumer'],env)
 value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')),use_default=False)
 result='Real' if result=='T' else result
 checks.append(f'''
noncomputable def actualScopedCall{i} (n m : {t('Natural')}) : {t(result)} := {value.lean}
noncomputable def expectedScopedCall{i} (n m : {t('Natural')}) : {t(result)} := {f(name)} {expected}
same_basic_target actualScopedCall{i} expectedScopedCall{i}
theorem scopedCallMeaning{i} (n m : {t('Natural')}) : actualScopedCall{i} n m = 0 := by
  simp [actualScopedCall{i}, {f(name)}, {num(result)}]
''')
path=HERE/'ScopedCallTargets.lean';path.write_text(lean([],env,['Lean'])+comparison+'\n'.join(checks))
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Eight automatic scoped-call targets and eight interpretation proofs passed; implicit/contextually unresolved consumers and production integration remain pending.')

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
