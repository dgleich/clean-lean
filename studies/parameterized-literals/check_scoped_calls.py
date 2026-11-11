# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Native complete-call targets for automatic experimental scoped consumers."""
from pathlib import Path
import ast,os,subprocess,sys
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path[:0]=[str(ROOT),str(HERE)]
from cleanlang.core import Environment,Expr,lean
from cleanlang.modules import load_module,notation
from cleanlang.syntax import parse,expression_tree
from cleanlang.joint_inference import complete

env=Environment();load_module(ROOT/'library/linear_algebra.clean',env)
scope={n:Expr(n,n,env.type('Natural'),tree=['Local',n]) for n in ('n','m')}
t=lambda name:env.data['types'][name]['native_binding']
f=lambda name:env.data['functions'][name]['native_binding']
num=lambda name:env.data['types'][name]['numerals']['native_binding']
zr=f'{num("Real")} (nat_lit 0)';zc=f'{num("Complex")} (nat_lit 0)';one=f'{num("Natural")} (nat_lit 1)'
zv=f('complex vector zero')
notation('Notation inner(f: Function(Real,Real),x: Real): Real:',
 ['Means: x','Render latex: inner'],env)
cases=[
 ('nested','f: Function(Real,Function(Real,Real)),x: Real','Real','x',
  'nested(function (a: Real,function (b: Real,0)),0)',f'(fun (a : {t("Real")}) => fun (b : {t("Real")}) => {zr}) ({zr})'),
 ('wrapped','x: Real','Real','x',
  'wrapped(inner(function (a: Real,0),0))',f'({f("inner")} (fun (a : {t("Real")}) => {zr}) ({zr}))'),
 ('body','f: Function(Real,Real),x: Real','Real','x',
  'body(function (a: Real,inner(function (b: Real,0),0)),0)',f'(fun (a : {t("Real")}) => {f("inner")} (fun (b : {t("Real")}) => {zr}) ({zr})) ({zr})'),
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
 value=complete(expression_tree(parse(source,'expression')),env,scope,use_default=False)
 result='Real' if result=='T' else result
 checks.append(f'''
noncomputable def actualScopedCall{i} (n m : {t('Natural')}) : {t(result)} := {value.lean}
noncomputable def expectedScopedCall{i} (n m : {t('Natural')}) : {t(result)} := {f(name)} {expected}
same_basic_target actualScopedCall{i} expectedScopedCall{i}
theorem scopedCallMeaning{i} (n m : {t('Natural')}) : actualScopedCall{i} n m = 0 := by
  simp [actualScopedCall{i}, {f(name)}, {f('inner')}, {num(result)}]
''')
local_cases=[
 ('Function(Function(Real,Real),Function(Complex,Real))',
  f'({t("Real")} → {t("Real")}) → {t("Complex")} → {t("Real")}',
  'h(function (a: Real,0))(0)',f'h (fun (a : {t("Real")}) => {zr}) ({zc})'),
 ('Function(Complex,Function(Function(Real,Real),Real))',
  f'{t("Complex")} → ({t("Real")} → {t("Real")}) → {t("Real")}',
  'h(0)(function (a: Real,0))',f'h ({zc}) (fun (a : {t("Real")}) => {zr})'),
 ('Function(Function(Real,Real),Real)',f'({t("Real")} → {t("Real")}) → {t("Real")}',
  'h(function (a: Real,0))',f'h (fun (a : {t("Real")}) => {zr})'),
 ('Function(k: Natural,Function(Function(Real,Vector(k,Complex)),Real))',
  f'(k : {t("Natural")}) → ({t("Real")} → {t("Vector")} k {t("Complex")}) → {t("Real")}',
  'h(n)(function (a: Real,0))',f'h n (fun (a : {t("Real")}) => {zv} n)'),
 ('Function(Proposition,Real)',f'Prop → {t("Real")}',
  'h(for every (a: Real,a = 0))',f'h (∀ (a : {t("Real")}), @{f("equal")} {t("Real")} a ({zr}))'),
]
for i,(typ,native,source,expected) in enumerate(local_cases):
 local_scope={**scope,'h':Expr('h','h',env.type(typ,scope),tree=['Local','h'])}
 value=complete(expression_tree(parse(source,'expression')),env,local_scope,use_default=False)
 checks.append(f"""
noncomputable def actualLocalScoped{i} (n : {t('Natural')}) (h : {native}) : {t('Real')} := {value.lean}
noncomputable def expectedLocalScoped{i} (n : {t('Natural')}) (h : {native}) : {t('Real')} := {expected}
same_basic_target actualLocalScoped{i} expectedLocalScoped{i}
theorem localScopedMeaning{i} (n : {t('Natural')}) (h : {native}) : actualLocalScoped{i} n h = {expected} := by rfl
""")
notation('Notation factory(f: Function(Real,Real)): Function(Complex,Real):',
 ['Means: fun _ => f 0','Render latex: factory({f})'],env)
factory=complete(expression_tree(parse('factory(function (a: Real,0))(0)','expression')),env,scope,use_default=False)
checks.append(f"""
noncomputable def actualFactory : {t('Real')} := {factory.lean}
noncomputable def expectedFactory : {t('Real')} := {f('factory')} (fun (a : {t('Real')}) => {zr}) ({zc})
same_basic_target actualFactory expectedFactory
theorem factoryMeaning : actualFactory = 0 := by simp [actualFactory, {f('factory')}, {num('Real')}]
""")
direct=complete(expression_tree(parse('(function(x: Natural,x+1))(2)','expression')),env,scope,use_default=False)
checks.append(f"""
noncomputable def actualDirectLambda : {t('Natural')} := {direct.lean}
noncomputable def expectedDirectLambda : {t('Natural')} := (fun (x : {t('Natural')}) => {f('natural sum')} x ({one})) ({num('Natural')} (nat_lit 2))
same_basic_target actualDirectLambda expectedDirectLambda
theorem directLambdaMeaning : actualDirectLambda = 3 := by rfl
""")
for label,typ,result,zero in [
 ('Real',env.type('Real'),t('Real'),zr),
 ('Complex',env.type('Complex'),t('Complex'),zc)]:
 contextual=complete(expression_tree(parse('(function(x: Natural,0))(2)','expression')),env,scope,typ,use_default=False)
 checks.append(f"""
noncomputable def actualExpected{label} (n : {t('Natural')}) : {result} := {contextual.lean}
noncomputable def expectedExpected{label} (n : {t('Natural')}) : {result} := (fun (x : {t('Natural')}) => {zero}) ({num('Natural')} (nat_lit 2))
same_basic_target actualExpected{label} expectedExpected{label}
theorem expectedMeaning{label} (n : {t('Natural')}) : actualExpected{label} n = {zero} := by rfl
""")
for label,dimension,native_dimension in [
 ('Direct','k','n'),
 ('Shifted','(k+1)',f'{f("natural sum")} n ({one})')]:
 name='indexed zero '+label.lower()
 notation(f'Notation {name}(k: Natural,z: Real): Vector({dimension},Complex):',
  ['Means: fun _ => 0','Render latex: zero({k},{z})'],env)
 source=f'(function(k: Natural,{name}(k,0)))(n)'
 value=complete(expression_tree(parse(source,'expression')),env,scope,use_default=False)
 checks.append(f"""
noncomputable def actualDependent{label} (n : {t('Natural')}) : {t('Vector')} ({native_dimension}) {t('Complex')} := {value.lean}
noncomputable def expectedDependent{label} (n : {t('Natural')}) : {t('Vector')} ({native_dimension}) {t('Complex')} := (fun (k : {t('Natural')}) => {f(name)} k ({zr})) n
same_basic_target actualDependent{label} expectedDependent{label}
theorem dependentMeaning{label} (n : {t('Natural')}) : actualDependent{label} n = (fun _ => 0) := by rfl
""")
path=HERE/'ScopedCallTargets.lean';path.write_text(lean([],env,['Lean'])+comparison+'\n'.join(checks))
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Twenty-two automatic scoped-call targets and twenty-two interpretation proofs passed; implicit/contextually unresolved consumers and production integration remain pending.')

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
