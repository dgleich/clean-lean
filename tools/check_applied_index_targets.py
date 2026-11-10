# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Independent canonical oracles for binder applications in dependent indices."""
from pathlib import Path
import ast,os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Expr,Expressions,lean
from cleanlang.modules import load_module
from cleanlang.indices import index_value
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
e=Environment();load_module(ROOT/'library/topology/pair_composition.clean',e)
scope={}
for name,typ in [('a','Real'),('b','Real'),('hab','Evidence((a=b))')]:
 scope[name]=Expr(name,name,e.type(typ,scope),tree=['Local',name])
key=lambda name:e.data['functions'][name]['native_binding']
real=e.data['types']['Real']['native_binding'];prop=e.data['types']['Proposition']['native_binding']
eq,add,congr=map(key,['equal','real sum','equality congruence'])
checks=[]
for label,body,codomain,expected_function in [
 ('Quantified','for every (u: Real,t=u)',prop,f'(fun (t : {real}) => ∀ u : {real}, {eq} t u)'),
 ('Nested','function(u: Real,t+u)',f'({real} → {real})',f'(fun (t : {real}) => fun (u : {real}) => {add} t u)')]:
 value=Expressions(e,scope).parse('equality congruence(function(t: Real,'+body+'),a,b,hab)')
 actual_type=e.render_type(value.type,'lean',scope)
 expected_type=f'{eq} ({expected_function} a) ({expected_function} b)'
 checks.append(f'''
noncomputable def actual{label}Type (a b : {real}) : Prop := {actual_type}
noncomputable def expected{label}Type (a b : {real}) : Prop := {expected_type}
same_basic_target actual{label}Type expected{label}Type
noncomputable def actual{label}Proof (a b : {real}) (hab : {eq} a b) : {actual_type} := {value.lean}
noncomputable def expected{label}Proof (a b : {real}) (hab : {eq} a b) : {expected_type} :=
 @{congr} {real} {codomain} {expected_function} a b hab
same_basic_target actual{label}Proof expected{label}Proof
''')
expression=Expressions(e,scope).elaborate(['Apply',['Lambda','t','Real',['Local','t']],[['Decimal','1']]])
value=index_value(expression,e,scope)
num=e.data['types']['Real']['numerals']['native_binding']
checks.append(f'''
noncomputable def actualNumeral : {real} := {value.lean}
noncomputable def expectedNumeral : {real} := {num} (nat_lit 1)
same_basic_target actualNumeral expectedNumeral
theorem contractedNumeralValue : actualNumeral = (1 : Real) := by
 simp [actualNumeral, {num}]
''')
with tempfile.TemporaryDirectory(prefix='clean-applied-index-') as directory:
 path=Path(directory)/'Checks.lean';path.write_text(lean([],e,['Lean'])+comparison+''.join(checks))
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Five canonical applied-index targets and numeral value proof passed.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
