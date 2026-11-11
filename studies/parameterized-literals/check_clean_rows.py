# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Native checks of selected experimental rows, not production joint inference."""
from pathlib import Path
import ast,os,subprocess,sys
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
sys.path[:0]=[str(ROOT),str(HERE)]
from cleanlang.core import Environment,Expr,lean
from cleanlang.modules import load_module
from cleanlang.syntax import parse,expression_tree
from clean_rows import Builder

env=Environment();load_module(ROOT/'library/linear_algebra.clean',env)
scope={n:Expr(n,n,env.type('Natural'),tree=['Local',n]) for n in ('m','n')}
for name,source in [('x','Vector(n,Complex)'),('A','Matrix(m,n,Real)'),('r','Real')]:
 scope[name]=Expr(name,name,env.type(source,scope),tree=['Local',name])
t=lambda name:env.data['types'][name]['native_binding']
f=lambda name:env.data['functions'][name]['native_binding']
vec=f"{t('Vector')} n {t('Complex')}";mat=f"{t('Matrix')} m n {t('Real')}"
binders=f"(m n : {t('Natural')}) (x : {vec}) (A : {mat}) (r : {t('Real')})"
zv=f"{f('complex vector zero')} n";zm=f"{f('real matrix zero')} m n"
nr=env.data['types']['Real']['numerals']['native_binding']
cases=[
 ('x != 0',t('Proposition'),f"@{f('unequal')} ({vec}) x ({zv})",'x ≠ (fun _ => (0 : Complex))'),
 ('0 != x',t('Proposition'),f"@{f('unequal')} ({vec}) ({zv}) x",'(fun _ => (0 : Complex)) ≠ x'),
 ('A = 0',t('Proposition'),f"@{f('equal')} ({mat}) A ({zm})",'A = (fun _ _ => (0 : Real))'),
 ('0 = A',t('Proposition'),f"@{f('equal')} ({mat}) ({zm}) A",'(fun _ _ => (0 : Real)) = A'),
 ('r + 0',t('Real'),f"{f('real sum')} r ({nr} (nat_lit 0))",None),
]
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(x,ast.Name) and x.id=='COMPARISON' for x in n.targets))
checks=[]
for i,(source,result,expected,meaning) in enumerate(cases):
 value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')))
 checks.append(f'''
noncomputable def actualJoint{i} {binders} : {result} := {value.lean}
noncomputable def expectedJoint{i} {binders} : {result} := {expected}
same_basic_target actualJoint{i} expectedJoint{i}
''')
 if meaning is not None:
  checks.append(f'theorem meaningJoint{i} {binders} : actualJoint{i} m n x A r ↔ ({meaning}) := by rfl\n')
 else:
  checks.append(f'''theorem meaningJoint{i} {binders} : actualJoint{i} m n x A r = r := by
  simp [actualJoint{i}, {f('real sum')}, {nr}]
''')
nn=env.data['types']['Natural']['numerals']['native_binding']
nzero=f"{nn} (nat_lit 0)"
for i,(source,typ,expected) in enumerate([
 ('0',t('Natural'),nzero),
 ('0 = 0',t('Proposition'),f"@{f('equal')} {t('Natural')} ({nzero}) ({nzero})")]):
 value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')))
 checks.append(f'''
noncomputable def actualDefault{i} : {typ} := {value.lean}
noncomputable def expectedDefault{i} : {typ} := {expected}
same_basic_target actualDefault{i} expectedDefault{i}
''')
checks.append('theorem meaningDefault0 : actualDefault0 = (0 : Nat) := by rfl\n')
checks.append('theorem meaningDefault1 : actualDefault1 := by rfl\n')
from cleanlang.structures import declare
declare('Structure ScalarCell():',['Let entry: Real','Constructor: scalar cell'],env)
declare('Structure VectorCell(n: Natural):',
 ['Let entry: Vector(n,Complex)','Constructor: vector cell'],env)
for i,(source,result,expected,meaning) in enumerate([
 ('scalar cell(0)',env.structures['ScalarCell']['key'],
  f"@{f('scalar cell')} ({nr} (nat_lit 0))",'(0 : Real)'),
 ('vector cell(n,0)',env.structures['VectorCell']['key']+' n',
  f"@{f('vector cell')} n ({zv})",'(fun _ => (0 : Complex))')]):
 value=Builder(env,scope).materialize(expression_tree(parse(source,'expression')))
 proof=f"by simp [actualConstructor{i}, {f('scalar cell')}, {nr}]" if i==0 else 'by rfl'
 checks.append(f"""
noncomputable def actualConstructor{i} {binders} : {result} := {value.lean}
noncomputable def expectedConstructor{i} {binders} : {result} := {expected}
same_basic_target actualConstructor{i} expectedConstructor{i}
theorem meaningConstructor{i} {binders} :
  (actualConstructor{i} m n x A r).entry = {meaning} := {proof}
""")
path=HERE/'JointTargets.lean';path.write_text(lean([],env,['Lean'])+comparison+'\n'.join(checks))
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Nine experimental joint-row targets and nine meaning proofs passed; production joint inference remains unimplemented.')

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
