# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Independent targets for determined scalar numerals and dimension arguments."""
from pathlib import Path
import ast,os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Expr,Expressions,lean
from cleanlang.modules import load_module,notation
from cleanlang.conversion import comparison_normal_form
e=Environment()
for module in ['linear_algebra.clean','logic/equalities.clean']:load_module(ROOT/'library'/module,e)
f=lambda n:e.data['functions'][n]['native_binding']
t=lambda n:e.data['types'][n]['native_binding']
numeral=lambda n:e.data['types'][n]['numerals']['native_binding']
notation('Define zero real(): Real:',['Equals: 0'],e,authored=True)
zero=comparison_normal_form(Expressions(e,{}).parse('zero real()'),e,{})
dimension=e.type('Vector((1+1),Real)').args[0]
scope={'A':Expr('A','A',e.type('Matrix(2,3,Complex)'),tree=['Local','A'])}
transpose=Expressions(e,scope).parse('transpose(A)')
reflexivity=Expressions(e,{}).parse('equality reflexivity(0)')
n0=f'{numeral("Natural")} (nat_lit 0)';n1=f'{numeral("Natural")} (nat_lit 1)'
n2=f'{numeral("Natural")} (nat_lit 2)';n3=f'{numeral("Natural")} (nat_lit 3)'
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
checks=f'''
noncomputable def actualZero : {t('Real')} := {zero.lean}
noncomputable def expectedZero : {t('Real')} := {numeral('Real')} (nat_lit 0)
same_basic_target actualZero expectedZero
noncomputable def actualDimension : {t('Natural')} := {dimension.lean}
noncomputable def expectedDimension : {t('Natural')} := {f('natural sum')} ({n1}) ({n1})
same_basic_target actualDimension expectedDimension
noncomputable def actualTranspose (A : {t('Matrix')} ({n2}) ({n3}) {t('Complex')}) :
 {e.render_type(transpose.type,'lean')} := {transpose.lean}
noncomputable def expectedTranspose (A : {t('Matrix')} ({n2}) ({n3}) {t('Complex')}) :
 {t('Matrix')} ({n3}) ({n2}) {t('Complex')} := @{f('transpose')} ({n2}) ({n3}) A
same_basic_target actualTranspose expectedTranspose
noncomputable def actualReflexivity : {e.render_type(reflexivity.type,'lean')} := {reflexivity.lean}
noncomputable def expectedReflexivity : {f('equal')} ({n0}) ({n0}) :=
 @{f('equality reflexivity')} {t('Natural')} ({n0})
same_basic_target actualReflexivity expectedReflexivity
theorem dimension_value : actualDimension = 2 := by rfl
'''
with tempfile.TemporaryDirectory(prefix='clean-completed-numerals-') as directory:
 path=Path(directory)/'Checks.lean';path.write_text(lean([],e,['Lean'])+comparison+checks)
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Four canonical completed-numeral targets and dimension value proof passed.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
