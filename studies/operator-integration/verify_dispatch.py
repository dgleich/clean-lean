# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Adversarial dispatch checks on the composed isolated compiler."""
from pathlib import Path
import sys, copy, ast, os, subprocess
from unittest.mock import patch
ROOT=Path(__file__).resolve().parents[2]; HERE=Path(__file__).resolve().parent
COMPILER=Path(sys.argv[1]).resolve(); sys.path.insert(0,str(COMPILER))
from cleanlang.core import Environment,Expr,Expressions,CleanError,SignatureMismatch,lean
from cleanlang.modules import load_document
from cleanlang.syntax import parse,expression_tree

e=Environment(); results=load_document(HERE/'Dispatch.clean.proposed',e)
s={}
for name,typ in [('A','Type'),('B','Type'),('n','Natural'),('m','Natural'),
                 ('ha','(equal types(A,A))'),('hn','(equal(n,n))'),('ht','(truth())')]:
    s[name]=Expr(name,name,e.type(typ,s),tree=['Local',name])
assert expression_tree(parse('A^B','expression'))==['Operator','^',['Local','A'],['Local','B']]
queries={'A^B':'choose carrier','A^ha':'carrier witness','n^hn':'generic witness','-ht':'proof marker'}
checked={}
original=dict(s)
for source,name in queries.items():
    value=Expressions(e,s).parse(source)
    assert value.operator_binding[0]==name,(source,value.operator_binding)
    checked[source]=value
assert s==original
for names in e.operator_overloads.values(): names.reverse()
for names in e.prefix_overloads.values(): names.reverse()
for source,name in queries.items():
    assert Expressions(e,s).parse(source).lean==checked[source].lean
assert s==original

def rejects(action, message):
    try: action()
    except CleanError as error: assert message in str(error),str(error)
    else: raise AssertionError('Expected rejection: '+message)

local=dict(s)
for name,typ in [('Real','Type'),('x','Real'),('v','Vector(n,Real)')]:
    local[name]=Expr(name,name,e.type(typ,local),tree=['Local',name])
assert Expressions(e,local).parse('x=x').operator_binding[0]=='equal'
without=copy.deepcopy(e);without.operator_overloads['='].remove('equal')
rejects(lambda:Expressions(without,local).parse('x=x'),'No declared meaning')
rejects(lambda:Expressions(e,local).parse('v+v'),'No declared meaning')
wrong=dict(s);wrong['hn']=Expr('hn','hn',e.type('(equal(n,m))',s),tree=['Local','hn'])
rejects(lambda:Expressions(e,wrong).parse('n^hn'),'No declared meaning')
# Unresolved analysis is never converted to an ineligible candidate.
with patch.object(e,'sort_level',side_effect=TimeoutError('unresolved sort')):
    try:Expressions(e,s).parse('A^B')
    except TimeoutError:pass
    else:raise AssertionError('Incomplete sort analysis accepted')
for error in [TimeoutError('unresolved dependent candidate'),SignatureMismatch('foreign mismatch',object())]:
    with patch.object(e,'dependent_call',side_effect=error):
        try:Expressions(e,s).parse('A^B')
        except type(error) as actual:assert actual is error
        else:raise AssertionError('Incomplete or foreign candidate failure swallowed')
# Even extensionally equal declarations are distinct permitted targets.
ambiguous=copy.deepcopy(e)
ambiguous.data['functions']['another carrier']=copy.deepcopy(e.data['functions']['choose carrier'])
ambiguous.operator_overloads['^'].append('another carrier')
rejects(lambda:Expressions(ambiguous,s).parse('A^B'),'Ambiguous operator')
ambiguous.operator_overloads['^'].reverse()
rejects(lambda:Expressions(ambiguous,s).parse('A^B'),'Ambiguous operator')

f=lambda name:e.data['functions'][name]['native_binding']
k=lambda name:e.data['types'][name]['native_binding']
N='_root_.'+k('Natural'); P='_root_.'+k('Proposition'); K='_root_.'+k('Type')
comparison=next(ast.literal_eval(node.value) for node in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in node.targets))
native=lean(results,e,['Lean'])+comparison
# Independent selected declaration bodies and uses; no expected term is generated
# by the expression translator. Synthetic ^ and - meanings exercise dispatch.
bodies=[
 ('choose carrier',f'(A B : {K})',K,'A'),
 ('carrier witness',f'(A : {K}) (h : @{f("equal types")} A A)',K,'A'),
 ('generic witness',f'{{T : Type}} (x : T) (h : @{f("equal")} T x x)','T','x'),
 ('proof marker',f'(h : {f("truth")})',f'{f("truth")}','h')]
for i,(name,binders,typ,body) in enumerate(bodies):
    native+=f'\nnoncomputable def expected_body_{i} {binders} : {typ} := {body}\nsame_basic_target {f(name)} expected_body_{i}\n'
uses=[
 ('A^B','(A B : Type)','Type',f'@_root_.{f("choose carrier")} A B'),
 ('A^ha',f'(A : Type) (ha : @{f("equal types")} A A)','Type',f'@_root_.{f("carrier witness")} A ha'),
 ('n^hn',f'(n : {N}) (hn : @{f("equal")} {N} n n)',N,f'@_root_.{f("generic witness")} {N} n hn'),
 ('-ht',f'(ht : {f("truth")})',f'{f("truth")}',f'@_root_.{f("proof marker")} ht')]
for i,(source,binders,typ,expected) in enumerate(uses):
    native+=f'\nnoncomputable def actual_use_{i} {binders} : {typ} := {checked[source].lean}\nnoncomputable def expected_use_{i} {binders} : {typ} := {expected}\nsame_basic_target actual_use_{i} expected_use_{i}\n'
# Fresh operator applications must qualify their wrapper/type constants even
# when the caller binds a value with exactly that generated Lean spelling.
for i, (local_name, condition) in enumerate([
        (f('equal'), False), (k('Natural'), False), (f('proof marker'), True)]):
    typ=e.type('(truth())',s) if condition else e.type('Natural')
    local={local_name:Expr(local_name,local_name,typ,tree=['Local',local_name])}
    query='-'+local_name if condition else local_name+'='+local_name
    actual=Expressions(e,local).parse(query)
    if condition:
        domain=result_type='_root_.'+f('truth')
        expected=f'@_root_.{f("proof marker")} {local_name}'
    else:
        domain=N;result_type=P
        expected=f'@_root_.{f("equal")} {N} {local_name} {local_name}'
    native+=f'\nnoncomputable def actual_global_collision_{i} ({local_name} : {domain}) : {result_type} := {actual.lean}\nnoncomputable def expected_global_collision_{i} ({local_name} : {domain}) : {result_type} := {expected}\nsame_basic_target actual_global_collision_{i} expected_global_collision_{i}\n'
native+=f'\ndef expected_local : Prop := ∀ (Real : {K}) (x : Real), @{f("equal")} Real x x\nsame_basic_target CleanStatements.local_carrier_avoids_concrete_overload expected_local\ntheorem local_checked : CleanStatements.local_carrier_avoids_concrete_overload := by intro Real x; rfl\n'
p=COMPILER/'DispatchVerified.lean';p.write_text(native)
subprocess.run([os.environ.get('LAKE','/home/claude/.elan/bin/lake'),'env','lean',str(p)],cwd=COMPILER,check=True)
(HERE/'DispatchVerified.lean').write_text(native)
print('Dispatch: twelve exact targets and one proof; collision, order, ambiguity and incomplete-analysis checks passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
