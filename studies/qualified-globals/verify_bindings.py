# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Check global qualification against deliberate local name collisions.

Run on the preceding native-type compiler to expose the callable/type capture
failures, or on the qualified-global prototype to check the repaired targets.
"""
from pathlib import Path
import ast
import os
import subprocess
import sys
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
COMPILER = Path(sys.argv[1]).resolve()
sys.path.insert(0, str(COMPILER))
from cleanlang.core import Environment, Expr, Type, Expressions, lean
from cleanlang.modules import load_module, load_document
from cleanlang.syntax import parse, expression_tree

assert expression_tree(parse('vector identity(n,v)', 'expression')) == [
    'Call', 'vector identity', [['Local', 'n'], ['Local', 'v']]]
assert expression_tree(parse('b.value', 'expression')) == ['Projection', ['Local', 'b'], 'value']

env = Environment()
load_module(HERE / 'Definitions.clean.proposed', env)

def callable_key(name):
    spec = env.data['functions'][name]
    # The fallback only lets this regression driver exercise the older compiler.
    return spec.get('native_binding') or spec['lean'].split()[0].removeprefix('_root_.')

identity = callable_key('identity')
square = callable_key('square')
vector = callable_key('vector identity')
box = callable_key('box')
box_type = env.structures['Box']['key']
bundle_type = env.structures['VectorBundle']['key']
K = lambda name: '_root_.' + env.data['types'][name]['native_binding']
scalar = K('Scalar')
nat = K('Natural')
types = K('Type')
vectors = K('Vector')

# These are authored Clean statements, including the deliberately colliding names.
source = f'''Define ignore shadow({identity}: Function(Scalar,Scalar),x: Scalar): Scalar:
  Equals: identity(x)

Result authored callable retains identity:
  Attribution: local; authored callable collision; original
  Let {identity}: Function(Scalar,Scalar)
  Let x: Scalar
  Conclude: identity(x) = x

Result native callable retains identity:
  Attribution: local; notation collision; original
  Let {square}: Function(Scalar,Scalar)
  Let x: Scalar
  Conclude: square(x) = x*x

Result dependent callable retains identity:
  Attribution: local; dependent callable collision; original
  Let {vector}: Function(k: Natural,Function(Vector(k,Scalar),Vector(k,Scalar)))
  Let n: Natural
  Let v: Vector(n,Scalar)
  Conclude: vector identity(n,v) = v

Result record type retains identity:
  Attribution: local; record type collision; original
  Let {box_type}: Type
  Let b: Box
  Conclude: b = b
'''
with tempfile.TemporaryDirectory(prefix='clean-qualified-source-') as td:
    path = Path(td) / 'Statements.clean'
    path.write_text('Import "' + str(HERE / 'Definitions.clean.proposed') + '"\n' + source)
    env = Environment()
    results = load_document(path, env)
assert len(results) == 4
ignored = callable_key('ignore shadow')

scope = {box: Expr(box, box, env.type('Function(Scalar,Box)'), tree=['Local', box])}
scope['x'] = Expr('x', 'x', env.type('Scalar'), tree=['Local', 'x'])
constructed = Expressions(env, scope).parse('box(x)')
projection_scope = {'b': Expr('b', 'b', env.type('Box'), tree=['Local', 'b']),
                    box_type: Expr(box_type, box_type, Type('Type'), tree=['Local', box_type])}
projected = Expressions(env, projection_scope).parse('b.value')
bundle_scope = {'b': Expr('b', 'b', env.type('VectorBundle'), tree=['Local', 'b']),
                bundle_type: Expr(bundle_type, bundle_type, Type('Type'), tree=['Local', bundle_type])}
dependent = Expressions(env, bundle_scope).parse('b.value')

comparison = next(ast.literal_eval(n.value)
    for n in ast.parse((ROOT / 'tools/check_basic_targets.py').read_text()).body
    if isinstance(n, ast.Assign) and any(isinstance(t, ast.Name) and t.id == 'COMPARISON' for t in n.targets))
native = lean(results, env, ['Lean']) + comparison + f'''
-- Independently authored declaration bodies under an explicit name mapping.
def expected_identity (x : {scalar}) : {scalar} := x
same_basic_target {identity} expected_identity
def expected_square (x : {scalar}) : {scalar} := x*x
same_basic_target {square} expected_square
def expected_vector (n : {nat}) (v : {vectors} n {scalar}) : {vectors} n {scalar} := v
same_basic_target {vector} expected_vector
def expected_box (value : {scalar}) : _root_.{box_type} := @_root_.{box_type}.mk value
same_basic_target {box} expected_box
noncomputable def expected_ignored (shadow : {scalar} → {scalar}) (x : {scalar}) : {scalar} := _root_.{identity} x
same_basic_target {ignored} expected_ignored

def expected_authored_statement : Prop := ∀ (shadow : {scalar} → {scalar}) (x : {scalar}), _root_.{identity} x = x
same_basic_target CleanStatements.authored_callable_retains_identity expected_authored_statement
def expected_native_statement : Prop := ∀ (shadow : {scalar} → {scalar}) (x : {scalar}), _root_.{square} x = x*x
same_basic_target CleanStatements.native_callable_retains_identity expected_native_statement
def expected_dependent_statement : Prop := ∀ (shadow : (k : {nat}) → ({vectors} k {scalar}) → ({vectors} k {scalar}))
    (n : {nat}) (v : {vectors} n {scalar}), @_root_.{vector} n v = v
same_basic_target CleanStatements.dependent_callable_retains_identity expected_dependent_statement
def expected_record_statement : Prop := ∀ (shadow : {types}) (b : _root_.{box_type}), b=b
same_basic_target CleanStatements.record_type_retains_identity expected_record_statement

noncomputable def actual_constructor ({box} : {scalar} → _root_.{box_type}) (x : {scalar}) : _root_.{box_type} := {constructed.lean}
noncomputable def expected_constructor (shadow : {scalar} → _root_.{box_type}) (x : {scalar}) : _root_.{box_type} := @_root_.{box} x
same_basic_target actual_constructor expected_constructor
def actual_projection (b : _root_.{box_type}) ({box_type} : {types}) : {scalar} := {projected.lean}
def expected_projection (b : _root_.{box_type}) (shadow : {types}) : {scalar} := @_root_.{box_type}.value b
same_basic_target actual_projection expected_projection
def actual_dependent_projection (b : _root_.{bundle_type}) ({bundle_type} : {types}) : {env.render_type(dependent.type, 'lean')} := {dependent.lean}
def expected_dependent_projection (b : _root_.{bundle_type}) (shadow : {types}) :
    {vectors} (@_root_.{bundle_type}.size b) {scalar} := @_root_.{bundle_type}.value b
same_basic_target actual_dependent_projection expected_dependent_projection

theorem authored_checked : CleanStatements.authored_callable_retains_identity := by intro shadow x; rfl
theorem native_checked : CleanStatements.native_callable_retains_identity := by intro shadow x; rfl
theorem dependent_checked : CleanStatements.dependent_callable_retains_identity := by intro shadow n v; rfl
theorem record_checked : CleanStatements.record_type_retains_identity := by intro shadow b; rfl
theorem constructor_checked (shadow : {scalar} → _root_.{box_type}) (x : {scalar}) :
    actual_constructor shadow x = @_root_.{box_type}.mk x := rfl
theorem declaration_body_checked (shadow : {scalar} → {scalar}) (x : {scalar}) :
    _root_.{ignored} shadow x = x := rfl
'''
output = COMPILER / 'QualifiedGlobalsVerified.lean'
output.write_text(native)
subprocess.run([os.environ.get('LAKE', '/home/claude/.elan/bin/lake'), 'env', 'lean', str(output)],
               cwd=ROOT, check=True)
(HERE / 'Statements.clean.proposed').write_text('-- generated: gpt-6 2026-11-07 role=assisted; generated collision fixture\n'
    'Import "Definitions.clean.proposed"\n\n' + source)
(HERE / 'PrototypeVerified.lean').write_text(native)
print('Twelve exact global-binding targets and six proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
