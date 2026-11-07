# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Check native binding identities and independently stated Lean targets."""
from pathlib import Path
import ast
import copy
import os
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
COMPILER = Path(sys.argv[1]).resolve()
sys.path.insert(0, str(COMPILER))
from cleanlang.core import Environment, Expr, Type, CleanError, lean
from cleanlang.modules import load_document
from cleanlang.syntax import parse, type_tree

assert type_tree(parse('NativeReal', 'type_ref')) == ['Name', 'NativeReal']
assert type_tree(parse('Function((p),(q))', 'type_ref')) == [
    'Apply', 'Function', [['ComputedIndex', ['Local', 'p']], ['ComputedIndex', ['Local', 'q']]]]

env = Environment()
results = load_document(HERE / 'Statements.clean.proposed', env)
assert len(results) == 4
keys = {name: env.data['types'][name]['native_binding'] for name in
        ['Type', 'Proposition', 'Natural', 'NativeReal', 'NativeList', 'Function']}
for name, key in keys.items():
    assert env.notation_definitions[key].startswith('noncomputable abbrev ' + key)

native_type = env.type('NativeReal')
target = env.render_type(native_type, 'lean')
assert target == '(_root_.' + keys['NativeReal'] + ')'
assert env.render_type(env.type('NativeList(NativeReal)'), 'lean') == (
    '(_root_.' + keys['NativeList'] + ' (' + target + '))')

# An opaque native template cannot silently diverge from its selected binding.
for mutation in ['template', 'body', 'missing']:
    altered = copy.deepcopy(env)
    key = keys['NativeReal']
    if mutation == 'template':
        altered.data['types']['NativeReal']['lean'] = 'Nat'
        message = 'Changed bound native type: NativeReal'
    else:
        if mutation == 'missing':
            del altered.notation_definitions[key]
        else:
            altered.notation_definitions[key] = 'noncomputable abbrev ' + key + ' : Type := Nat'
        message = 'Changed or missing bound native type declaration: NativeReal'
    try:
        altered.render_type(native_type, 'lean')
    except CleanError as error:
        assert str(error) == message, str(error)
    else:
        raise AssertionError('Changed native binding accepted: ' + mutation)

comparison = next(ast.literal_eval(node.value)
    for node in ast.parse((ROOT / 'tools/check_basic_targets.py').read_text()).body
    if isinstance(node, ast.Assign)
    and any(isinstance(t, ast.Name) and t.id == 'COMPARISON' for t in node.targets))
K = lambda name: '_root_.' + keys[name]
native = lean(results, env, ['Lean']) + comparison + f'''
-- Independent adapter bodies: the mapping supplies names, never expected bodies.
def expected_type : Type 1 := Type
same_basic_target {keys['Type']} expected_type
def expected_prop : Sort 1 := Prop
same_basic_target {keys['Proposition']} expected_prop
def expected_nat : Type := Nat
same_basic_target {keys['Natural']} expected_nat
def expected_real : Type := Real
same_basic_target {keys['NativeReal']} expected_real
def expected_list (T : Type) : Type := List T
same_basic_target {keys['NativeList']} expected_list
def expected_function (T : Type) (U : Type) : Type := T → U
same_basic_target {keys['Function']} expected_function

def expected_constant : Prop := ∀ (Real : {K('Type')}) (x : {K('NativeReal')}), x = x
same_basic_target CleanStatements.native_constant_retains_scope expected_constant
def expected_constructor : Prop := ∀ (List : {K('Type')}) (x : {K('NativeList')} {K('NativeReal')}), x = x
same_basic_target CleanStatements.native_constructor_retains_scope expected_constructor
def expected_arrow : Prop := ∀ (p q : {K('Proposition')}) (f : p → q), f = f
same_basic_target CleanStatements.proof_arrow_remains_structural expected_arrow
def expected_instances : Prop := ∀ (n : {K('Natural')}), n+n = n+n
same_basic_target CleanStatements.native_instances_remain_available expected_instances

-- Deliberately give a local binder the generated global declaration's name.
def actual_generated_collision : Prop := ∀ ({keys['NativeReal']} : {K('Type')}) (x : {target}), x = x
def expected_generated_collision : Prop := ∀ (shadow : {K('Type')}) (x : {K('NativeReal')}), x = x
same_basic_target actual_generated_collision expected_generated_collision

theorem constant_checked : CleanStatements.native_constant_retains_scope := by intro A x; rfl
theorem constructor_checked : CleanStatements.native_constructor_retains_scope := by intro A x; rfl
theorem arrow_checked : CleanStatements.proof_arrow_remains_structural := by intro p q f; rfl
theorem instances_checked : CleanStatements.native_instances_remain_available := by intro n; rfl
theorem generated_collision_checked : actual_generated_collision := by intro A x; rfl
-- This also compares the wrapper-based statement with its ordinary mathematical reading.
theorem constant_has_original_meaning : CleanStatements.native_constant_retains_scope =
    (∀ (A : Type) (x : Real), x=x) := rfl
'''
path = COMPILER / 'NativeTypesVerified.lean'
path.write_text(native)
subprocess.run([os.environ.get('LAKE', '/home/claude/.elan/bin/lake'), 'env', 'lean', str(path)],
               cwd=ROOT, check=True)
(HERE / 'PrototypeVerified.lean').write_text(native)
print('Eleven exact targets, six proofs and native binding mutation checks passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
