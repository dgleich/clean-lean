# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Declaration-only numeral adapters; independent native body/type oracles."""
from pathlib import Path
import ast
import copy
import os
import subprocess
import sys
ROOT=Path(__file__).resolve().parents[2]
COMPILER=Path(sys.argv[1]).resolve()
sys.path.insert(0,str(COMPILER))
from cleanlang.core import Environment,CleanError,Expressions
from cleanlang.modules import type_declaration,notation

def declare(env,name,body='Real',payload='fun n : Nat => (n : Real)',extra=()):
    type_declaration('Type '+name+'():',
        ['Means: '+body,'Render latex: R','Numerals: '+payload,*extra],env)

def rejects(env,action):
    before=copy.deepcopy((env.data,env.notation_definitions))
    try:action()
    except CleanError:pass
    else:raise AssertionError('Expected rejection')
    assert (env.data,env.notation_definitions)==before,'Rejected declaration published state'

e=Environment()
declare(e,'Real')
declare(e,'Counting','Nat','fun n : Nat => n')
declare(e,'Renamed')
assert e.data['types']['Real']['numerals']['native_binding']!=e.data['types']['Renamed']['numerals']['native_binding']
type_declaration('Type Alias():',['Equals: Real'],e)
assert e.type('Alias')==e.type('Real')
assert 'numerals' not in e.data['types']['Alias']
for body in ['Prop','Type']:
    rejects(e,lambda body=body:declare(e,'Rejected',body))
rejects(e,lambda:declare(e,'Rejected',extra=['Universe: 1']))
rejects(e,lambda:declare(e,'Rejected',extra=['NUMERALS: fun n : Nat => n']))
rejects(e,lambda:type_declaration('Type Rejected():',['Equals: Real','Numerals: fun n : Nat => n'],e))
rejects(e,lambda:type_declaration('Type Rejected(T: Type):',
    ['Means: T','Render latex: T','Numerals: fun n : Nat => n'],e))
rejects(e,lambda:notation('Notation rejected(): Real:',
    ['Means: 0','Render latex: 0','Numerals: fun n : Nat => n'],e))
try:Expressions(e,{}).parse('(1: Real)')
except CleanError as error:assert 'not implemented' in str(error)
else:raise AssertionError('Expression binding unexpectedly enabled')

comparison=next(ast.literal_eval(node.value) for node in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
    if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in node.targets))
native='import Mathlib.Data.Real.Basic\nimport Lean\n'+''.join(e.notation_definitions.values())+comparison
# Expected types/bodies are authored independently, using only generated constant
# names from metadata. No output body or expression emission feeds the oracle.
for i,(name,body,payload) in enumerate([
    ('Real','Real','fun n : Nat => (n : Real)'),
    ('Counting','Nat','fun n : Nat => n'),
    ('Renamed','Real','fun n : Nat => (n : Real)')]):
    spec=e.data['types'][name]; carrier=spec['native_binding']; adapter=spec['numerals']['native_binding']
    native+=f'\ndef expected_carrier_{i} : Type := {body}\nsame_basic_target {carrier} expected_carrier_{i}\n'
    native+=f'\nnoncomputable def expected_adapter_{i} (n : Nat) : _root_.{carrier} := ({payload}) n\nsame_basic_target {adapter} expected_adapter_{i}\n'
    native+=f'\ntheorem adapter_zero_{i} : _root_.{adapter} (nat_lit 0) = 0 := by simp [_root_.{adapter}]\n'
path=COMPILER/'NumeralAdaptersVerified.lean';path.write_text(native)
lake=os.environ.get('LAKE','/home/claude/.elan/bin/lake')
subprocess.run([lake,'env','lean',str(path)],cwd=COMPILER,check=True)
# Native payload correctness is a kernel-validation obligation, as for Means.
# A malformed payload must never be counted as validated by the Python phase.
for i,(body,payload) in enumerate([('Real','fun n : Nat => True'),('False','fun n : Nat => n')]):
    bad=Environment();declare(bad,'Bad',body,payload)
    path=COMPILER/f'NumeralAdapterRejected{i}.lean'
    path.write_text('import Mathlib.Data.Real.Basic\n'+''.join(bad.notation_definitions.values()))
    result=subprocess.run([lake,'env','lean',str(path)],cwd=COMPILER,capture_output=True,text=True)
    assert result.returncode!=0 and 'type mismatch' in result.stdout.lower(),result.stdout+result.stderr
(ROOT/'studies/module-numerals/AdaptersVerified.lean').write_text(native)
print('Numeral declarations: six exact native targets, three zero proofs, two kernel rejections; declaration restrictions and alias ownership passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
