# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Apply the isolated operator patch and check syntax, dispatch and native targets."""
from pathlib import Path
import ast,os,shutil,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
if len(sys.argv)==1:
    with tempfile.TemporaryDirectory(prefix='clean-operators-') as td:
        dest=Path(td)
        for name in subprocess.check_output(['git','ls-files','-z'],cwd=ROOT,text=True).split('\0'):
            if name and (ROOT/name).is_file():
                out=dest/name;out.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(ROOT/name,out)
        (dest/'.lake').symlink_to(ROOT/'.lake',target_is_directory=True)
        subprocess.run(['git','apply',str(HERE/'prototype.patch')],cwd=dest,check=True)
        for args in [[],['--check']]:
            subprocess.run([sys.executable,str(dest/'tools/generate_parser.py'),*args],cwd=dest,check=True)
        subprocess.run([sys.executable,str(Path(__file__).resolve()),str(dest)],cwd=dest,check=True)
    raise SystemExit(0)
COMPILER=Path(sys.argv[1]);sys.path.insert(0,str(COMPILER))
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module,notation
from cleanlang.syntax import parse,expression_tree
from unittest.mock import patch
source=(HERE/'Operators.clean.proposed').read_text()
def load(text):
    with tempfile.TemporaryDirectory() as td:
        p=Path(td)/'Operators.clean';p.write_text(text);env=Environment();load_module(p,env)
    return env

def local(env,typ='Scalar'):
    return {n:Expr(n,n,env.type(typ),tree=['Local',n]) for n in ['x','y','z']}

def reject(env,text,fragment,scope=None):
    try:Expressions(env,scope or local(env)).parse(text)
    except CleanError as e:
        assert fragment in str(e),(fragment,str(e));return str(e)
    raise AssertionError('Expected rejection: '+text)

env=load(source);scope=local(env)
expected=['Operator','=', ['Operator','+',['Local','x'],['Local','y']],
          ['Operator','+',['Local','y'],['Local','x']]]
assert expression_tree(parse('x+y = y+x','expression'))==expected
actual=Expressions(env,scope).parse('x+y = y+x');assert actual.tree==expected
nested=Expressions(env,scope).parse('x*(y+x)')
assert r'\left(' in nested.tex and r'\right)' in nested.tex
assert nested.tree==['Operator','*',['Local','x'],['Operator','+',['Local','y'],['Local','x']]]
# A type named Matrix with no dimensions must not trigger the old matrix branch.
renamed=load(source.replace('Scalar','Matrix'))
assert Expressions(renamed,local(renamed,'Matrix')).parse('x*(y+x)').lean==nested.lean
missing=load(source.replace('  Infix: +\n',''))
reject(missing,'x+y','No declared meaning')
reject(env,'x+1','numeral interpretation')
ambiguous=load(source+'''\nNotation another sum(x: Scalar,y: Scalar): Scalar:
  Infix: +
  Means: x+y
  Render latex: {x}+{y}
''')
first=reject(ambiguous,'x+y','Ambiguous operator')
ambiguous.operator_overloads['+'].reverse()
assert reject(ambiguous,'x+y','Ambiguous operator')==first
prior=dict(env.data['functions'])
try:notation('Notation wrong(x):',['Let x: Scalar','Returns: Scalar','Infix: +','Means: x','Render latex: {x}'],env)
except CleanError as e:assert 'two explicit operands' in str(e)
else:raise AssertionError('Invalid arity accepted')
assert env.data['functions']==prior
other=load(source+'\nType Other():\n  Means: Nat\n  Render latex: N\n')
scope2=local(other);scope2['y']=Expr('y','y',other.type('Other'),tree=['Local','y'])
reject(other,'x+y','No declared meaning',scope2)
# An interrupted candidate cannot be discarded in favor of a successful one.
notation('Notation generic equality(x,y):',[
 'Let T: Type','Let x,y: T','Returns: Proposition','Infix: =','Means: x=y','Render latex: {x}={y}'],env)
with patch.object(env,'require_type_argument',side_effect=TimeoutError('incomplete candidate')):
    try:Expressions(env,scope).parse('x=y')
    except TimeoutError:pass
    else:raise AssertionError('An unfinished candidate was ignored')
# Restore the single-meaning environment for native fixtures.
env=load(source);f=lambda n:env.data['functions'][n]['lean'].split()[0]
add,mul,eq=(f(n) for n in ['scalar addition','scalar product','scalar equality'])
parsed=ast.parse((ROOT/'tools/check_basic_targets.py').read_text())
comparison=next(ast.literal_eval(n.value) for n in parsed.body if isinstance(n,ast.Assign)
                and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
native='import Lean\nimport Mathlib.Data.Real.Basic\n'+comparison+'\n'.join(env.notation_definitions.values())
native+='''
noncomputable def expected_add (x y : Real) : Real := x+y
noncomputable def expected_mul (x y : Real) : Real := x*y
noncomputable def expected_eq (x y : Real) : Prop := x=y
'''
for name,expected_name in [(add,'expected_add'),(mul,'expected_mul'),(eq,'expected_eq')]:
    native+=f'same_basic_target {name} {expected_name}\n'
native+=f'def actual_expression (x y : Real) : Prop := {actual.lean}\n'
native+=f'def expected_expression (x y : Real) : Prop := {eq} ({add} x y) ({add} y x)\n'
native+='same_basic_target actual_expression expected_expression\n'
native+=f'noncomputable def actual_nested (x y : Real) : Real := {nested.lean}\n'
native+=f'noncomputable def expected_nested (x y : Real) : Real := {mul} x ({add} y x)\n'
native+='same_basic_target actual_nested expected_nested\n'
native+=f'theorem commutative_example (x y : Real) : actual_expression x y := by\n unfold actual_expression {eq} {add}\n exact add_comm x y\n'
p=COMPILER/'OperatorAcceptance.lean';p.write_text(native)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=COMPILER,check=True)
print('Operator prototype: syntax/dispatch checks, five exact targets and one proof passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
