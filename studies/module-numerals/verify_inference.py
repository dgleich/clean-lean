# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Exhaustive numeral completion with independent targets and failure ownership."""
from pathlib import Path
import ast,copy,os,subprocess,sys
from unittest.mock import patch
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
COMPILER=Path(sys.argv[1]).resolve();sys.path.insert(0,str(COMPILER))
from cleanlang.core import Environment,Expr,Expressions,Type,CleanError,SignatureMismatch,lean,latex
from cleanlang.modules import load_document
from cleanlang.numeral_inference import complete,IncompleteNumeralAnalysis
from cleanlang.syntax import expression_tree,parse
from cleanlang.conversion import index_comparison
from cleanlang.hygiene import substitute

e=Environment();results=load_document(HERE/'Inference.clean.proposed',e)
s={'x':Expr('x','x',Type('Real'),tree=['Local','x']),
   'n':Expr('n','n',Type('Counting'),tree=['Local','n'])}
def expr(source,env=e,locals=s,expected=None):return Expressions(env,locals).parse(source,expected)
def rejects(action,message,kind=CleanError):
    try:action()
    except kind as error:assert message in str(error),str(error)
    else:raise AssertionError('Expected rejection: '+message)

cases=[('x+1','x+(1: Real)'),('1+x','(1: Real)+x'),
       ('(1+2)+x','((1: Real)+(2: Real))+x'),('x+(1+2)','x+((1: Real)+(2: Real))'),
       ('real sum(1,2)','real sum((1: Real),(2: Real))'),
       ('counting sum(1,2)','counting sum((1: Counting),(2: Counting))'),
       ('n+1','n+(1: Counting)'),('-1','-(1: Real)'),
       ('equal(x,1)','equal(x,(1: Real))'),
       ('(function(y: Real,y+1))(2)','(function(y: Real,y+(1: Real)))((2: Real))')]
for source,explicit in cases:
    assert expr(source).lean==expr(explicit).lean,source
    assert ':' not in expr(source).tex,source
    assert index_comparison(expr(source),e,s)==index_comparison(expr(explicit),e,s),source
for source in ['1','1+2','equal(1,2)']:
    rejects(lambda source=source:expr(source),'Ambiguous numeral')
assert expr('1',expected=Type('Real')).lean==expr('(1: Real)').lean
assert expr('1+2',expected=Type('Counting')).lean==expr('(1: Counting)+(2: Counting)').lean
rejects(lambda:expr('1',expected=Type('Function',(Type('Real'),Type('Real')))),'No consistent')
rejects(lambda:expr('missing(1)'),'Unknown function')
rejects(lambda:expr('١'),'ASCII')
# The result cannot depend on declaration or overload enumeration order.
reverse=copy.deepcopy(e);reverse.data['types']=dict(reversed(list(reverse.data['types'].items())))
for names in reverse.operator_overloads.values():names.reverse()
for source,_ in cases:assert expr(source,env=reverse).lean==expr(source).lean
rejects(lambda:expr('1+2',env=reverse),'Ambiguous numeral')
# Preserve a selected numeral across shadowing, substitution and later scope growth.
selected=expr('1',expected=Type('Real'))
local={'Real':Expr('Real','Real',Type('Type'),tree=['Local','Real'])}
assert Expressions(e,local).elaborate(selected.tree).lean==selected.lean
assert substitute(selected.tree,{'Real':local['Real']},e,local)==selected.tree
changed=copy.deepcopy(e);changed.notation_definitions.pop(e.data['types']['Real']['numerals']['native_binding'])
rejects(lambda:Expressions(changed,{}).elaborate(selected.tree),'Changed')
# Exhaustion and foreign failures are not failed candidate signatures.
tree=expression_tree(parse('x+1','expression'))
rejects(lambda:complete(tree,e,s,limit=2),'Incomplete numeral',IncompleteNumeralAnalysis)
assert not hasattr(e,'_numeral_trial_owner')
for error in [TimeoutError('native analysis incomplete'),SignatureMismatch('foreign mismatch',object()),CleanError('internal failure')]:
    with patch.object(e,'call',side_effect=error):
        try:expr('real sum(1,2)')
        except type(error) as actual:assert actual is error
        else:raise AssertionError('Foreign failure swallowed')
    assert not hasattr(e,'_numeral_trial_owner')
# Even a successful earlier assignment cannot hide a later unresolved candidate.
original_call=e.call;observed=[]
def late_failure(name,args,locals=None):
    if args and args[0].type==Type('Twin'):
        assert observed
        raise TimeoutError('late unresolved candidate')
    result=original_call(name,args,locals);observed.append(result);return result
with patch.object(e,'call',side_effect=late_failure):
    rejects(lambda:expr('real sum(1,2)'),'late unresolved',TimeoutError)
assert not hasattr(e,'_numeral_trial_owner')
e._numeral_trial_owner=None
expr('x+1');assert hasattr(e,'_numeral_trial_owner') and e._numeral_trial_owner is None
del e._numeral_trial_owner
# Existing operator ambiguity must never be treated as a numeral mismatch.
ambiguous=copy.deepcopy(e)
ambiguous.data['functions']['another sum']=copy.deepcopy(e.data['functions']['real sum'])
ambiguous.operator_overloads['+'].append('another sum')
rejects(lambda:expr('x+1',env=ambiguous),'Ambiguous operator')
# No legacy name-based NUM acceptance survives at named calls in this stack.
from cleanlang.core import NUM
rejects(lambda:e.call('real sum',[Expr('1','1',NUM),Expr('2','2',NUM)],{}),'Expected')

r=lambda name:e.data['types'][name]['native_binding']
c=lambda name:e.data['types'][name]['numerals']['native_binding']
f=lambda name:e.data['functions'][name]['native_binding']
N=lambda name,value:f'_root_.{c(name)} (nat_lit {value})'
comparison=next(ast.literal_eval(node.value) for node in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
    if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in node.targets))
native=lean(results,e,['Lean'])+comparison
uses=[
 ('x+1',f'(x : _root_.{r("Real")})',r('Real'),f'_root_.{f("real sum")} x ({N("Real",1)})'),
 ('1+x',f'(x : _root_.{r("Real")})',r('Real'),f'_root_.{f("real sum")} ({N("Real",1)}) x'),
 ('(1+2)+x',f'(x : _root_.{r("Real")})',r('Real'),f'_root_.{f("real sum")} (_root_.{f("real sum")} ({N("Real",1)}) ({N("Real",2)})) x'),
 ('x+(1+2)',f'(x : _root_.{r("Real")})',r('Real'),f'_root_.{f("real sum")} x (_root_.{f("real sum")} ({N("Real",1)}) ({N("Real",2)}))'),
 ('real sum(1,2)','',r('Real'),f'_root_.{f("real sum")} ({N("Real",1)}) ({N("Real",2)})'),
 ('counting sum(1,2)','',r('Counting'),f'_root_.{f("counting sum")} ({N("Counting",1)}) ({N("Counting",2)})'),
 ('n+1',f'(n : _root_.{r("Counting")})',r('Counting'),f'_root_.{f("counting sum")} n ({N("Counting",1)})'),
 ('-1','',r('Real'),f'_root_.{f("negative")} ({N("Real",1)})'),
 ('equal(x,1)',f'(x : _root_.{r("Real")})',r('Proposition'),f'@_root_.{f("equal")} _root_.{r("Real")} x ({N("Real",1)})')]
for i,(source,binders,typ,target) in enumerate(uses):
    native+=f'\nnoncomputable def inference_actual_{i} {binders} : _root_.{typ} := {expr(source).lean}\nnoncomputable def inference_expected_{i} {binders} : _root_.{typ} := {target}\nsame_basic_target inference_actual_{i} inference_expected_{i}\n'
for name,carrier in [('inferred one','Real'),('inferred counting one','Counting')]:
    key=f(name)
    native+=f'\nnoncomputable def expected_{key} : _root_.{r(carrier)} := {N(carrier,1)}\nsame_basic_target {key} expected_{key}\n'
# Independent statement targets keep quantifiers, type arguments and assumptions.
for title,carrier,variable,nested in [
    ('inferred_real_addition','Real','x',False),
    ('inferred_nested_addition','Real','x',True),
    ('inferred_counting_addition','Counting','n',False)]:
    add=f('real sum' if carrier=='Real' else 'counting sum')
    value=N(carrier,1)
    if nested:value=f'_root_.{add} ({N(carrier,1)}) ({N(carrier,2)})'
    left,right=(f'_root_.{add} ({value}) {variable}',f'_root_.{add} {variable} ({value})') if nested else (f'_root_.{add} {variable} ({value})',f'_root_.{add} ({value}) {variable}')
    native+=f'\ndef expected_{title} : Prop := ∀ ({variable} : _root_.{r(carrier)}), @_root_.{f("equal")} _root_.{r(carrier)} ({left}) ({right})\nsame_basic_target CleanStatements.{title} expected_{title}\n'
native+=f'\ndef expected_inferred_assumption : Prop := _root_.{f("nonnegative")} ({N("Real",1)}) → _root_.{f("nonnegative")} ({N("Real",1)})\nsame_basic_target CleanStatements.inferred_named_assumption expected_inferred_assumption\n'
native+='''
theorem inferred_real_proof : CleanStatements.inferred_real_addition := by intro x; exact add_comm _ _
theorem inferred_nested_proof : CleanStatements.inferred_nested_addition := by intro x; exact add_comm _ _
theorem inferred_counting_proof : CleanStatements.inferred_counting_addition := by intro n; exact add_comm _ _
theorem inferred_assumption_proof : CleanStatements.inferred_named_assumption := by intro h; exact h
'''
path=COMPILER/'NumeralInferenceVerified.lean';path.write_text(native)
subprocess.run([os.environ.get('LAKE','/home/claude/.elan/bin/lake'),'env','lean',str(path)],cwd=COMPILER,check=True)
(HERE/'InferenceVerified.lean').write_text(native)
(HERE/'Inference.tex').write_text(latex(results,e))
print('Numeral inference: fifteen exact targets, four proofs; order, expected types, consumer, ambiguity and incomplete-analysis checks passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
