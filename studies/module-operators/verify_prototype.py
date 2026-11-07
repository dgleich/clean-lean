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
missing=load(source.split('\nDefine authored sum',1)[0].replace('  Infix: +\n',''))
reject(missing,'x+y','No declared meaning')
reject(env,'x+1','numeral interpretation')
ambiguous=load(source+'''\nNotation another sum(x: Scalar,y: Scalar): Scalar:
  Infix: +
  Means: x+y
  Render latex: {x}+{y}
''')
from cleanlang.conversion import comparison_normal_form
original=Expressions(env,scope).parse('authored sum(x,y)')
expanded=comparison_normal_form(original,env,scope)
assert 'cleanNotation_scalar_addition_' in expanded.lean
assert 'cleanDefine_authored_sum_' not in expanded.lean
changed=Expressions(ambiguous,local(ambiguous)).parse('authored sum(x,y)')
assert changed.lean==original.lean
preserved=comparison_normal_form(changed,ambiguous,local(ambiguous))
assert preserved.lean==changed.lean
assert preserved.tree==changed.tree
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
native+=f'noncomputable def expected_authored_sum (x y : Real) : Real := {add} x y\n'
native+=f"same_basic_target {f('authored sum')} expected_authored_sum\n"
native+=f'def actual_expression (x y : Real) : Prop := {actual.lean}\n'
native+=f'def expected_expression (x y : Real) : Prop := {eq} ({add} x y) ({add} y x)\n'
native+='same_basic_target actual_expression expected_expression\n'
native+=f'noncomputable def actual_nested (x y : Real) : Real := {nested.lean}\n'
native+=f'noncomputable def expected_nested (x y : Real) : Real := {mul} x ({add} y x)\n'
native+='same_basic_target actual_nested expected_nested\n'
native+=f'theorem commutative_example (x y : Real) : actual_expression x y := by\n unfold actual_expression {eq} {add}\n exact add_comm x y\n'
# Dependent dimensions are matched by the existing callable rule, with
# candidate-local mismatch ownership; unrelated elaboration failures propagate.
from cleanlang.core import SignatureMismatch,lean
from cleanlang.modules import load_document
linear=Environment();results=load_document(HERE/'Statements.clean.proposed',linear)
assert results[0].conclusion.tree==['Operator','=', ['Operator','*',['Operator','*',['Local','A'],['Local','B']],['Local','x']], ['Operator','*',['Local','A'],['Operator','*',['Local','B'],['Local','x']]]]
ls={}
for name,typ in [('m','Natural'),('n','Natural'),('p','Natural'),('q','Natural'),
                 ('A','Grid(m,n)'),('B','Grid(n,p)'),('x','Column(p)'),
                 ('y','Column(n)'),('wrong','Column(q)'),('s','Scalar')]:
    ls[name]=Expr(name,name,linear.type(typ,ls),tree=['Local',name])
forms=[('A*B','Grid(m,p)'),('A*y','Column(m)'),('s*A','Grid(m,n)'),('s*y','Column(n)')]
terms=[]
for expression,typ in forms:
    term=Expressions(linear,ls).parse(expression)
    assert term.type==linear.type(typ,ls)
    terms.append(term)
# Candidate order must not alter a unique selected target or its inferred type.
linear.operator_overloads['*'].reverse()
for (expression,_),original in zip(forms,terms):
    reordered=Expressions(linear,ls).parse(expression)
    assert (reordered.lean,reordered.type,reordered.tree)==(original.lean,original.type,original.tree)
linear.operator_overloads['*'].reverse()
reject(linear,'A*wrong','No declared meaning',ls)
reject(linear,'A*x','No declared meaning',ls)
# Distinguish a nested failure from the mismatch raised by this candidate.
foreign=SignatureMismatch('nested mismatch',object())
with patch.object(linear,'dependent_call',side_effect=foreign):
    try:Expressions(linear,ls).parse('s*s')
    except SignatureMismatch as error:assert error is foreign
    else:raise AssertionError('Nested mismatch was discarded')
with patch.object(linear,'dependent_call',side_effect=TimeoutError('unfinished dependent candidate')):
    try:Expressions(linear,ls).parse('s*s')
    except TimeoutError:pass
    else:raise AssertionError('Unfinished dependent candidate was discarded')
assert set(ls)=={'m','n','p','q','A','B','x','y','wrong','s'}
native=native.replace('import Mathlib.Data.Real.Basic','import Mathlib.Data.Real.Basic\nimport Mathlib.LinearAlgebra.Matrix.NonsingularInverse')
native+='\n'.join(value for key,value in linear.notation_definitions.items() if key not in env.notation_definitions)
f=lambda name:linear.data['functions'][name]['lean'].split()[0]
prod,app,scale,scalev,eqv=(f(n) for n in ['grid product','grid application','scale grid','scale column','column equality'])
native+=f"""
noncomputable def expected_grid_product {{m n p : Nat}} (A : Matrix (Fin m) (Fin n) Real) (B : Matrix (Fin n) (Fin p) Real) := A*B
noncomputable def expected_grid_application {{m n : Nat}} (A : Matrix (Fin m) (Fin n) Real) (x : Fin n → Real) := Matrix.mulVec A x
noncomputable def expected_scale_grid {{m n : Nat}} (s : Real) (A : Matrix (Fin m) (Fin n) Real) := s • A
noncomputable def expected_scale_column {{n : Nat}} (s : Real) (x : Fin n → Real) := s • x
noncomputable def expected_column_equality {{n : Nat}} (x y : Fin n → Real) : Prop := x=y
same_basic_target {prod} expected_grid_product
same_basic_target {app} expected_grid_application
same_basic_target {scale} expected_scale_grid
same_basic_target {scalev} expected_scale_column
same_basic_target {eqv} expected_column_equality
"""
# Independent explicit arguments include every selected dimension.
expected_calls=[f'@{prod} m n p A B',f'@{app} m n A y',f'@{scale} m n s A',f'@{scalev} n s y']
expected_types=['Matrix (Fin m) (Fin p) Real','Fin m → Real','Matrix (Fin m) (Fin n) Real','Fin n → Real']
for i,(term,expected_call,expected_type) in enumerate(zip(terms,expected_calls,expected_types)):
    binders='(m n p : Nat) (A : Matrix (Fin m) (Fin n) Real) (B : Matrix (Fin n) (Fin p) Real) (y : Fin n → Real) (s : Real)'
    native+=f'noncomputable def actual_linear_{i} {binders} : {expected_type} := {term.lean}\n'
    native+=f'noncomputable def expected_linear_{i} {binders} : {expected_type} := {expected_call}\n'
    native+=f'same_basic_target actual_linear_{i} expected_linear_{i}\n'
statements=lean(results,linear,[])
native+=statements[statements.index('namespace CleanStatements'):]
native+=f"""
def expected_grid_law : Prop := ∀ (m n p : Nat) (A : Matrix (Fin m) (Fin n) Real)
 (B : Matrix (Fin n) (Fin p) Real) (x : Fin p → Real),
 @{eqv} m (@{app} m p (@{prod} m n p A B) x) (@{app} m n A (@{app} n p B x))
same_basic_target CleanStatements.grid_product_application expected_grid_law
theorem grid_law_proof : CleanStatements.grid_product_application := by
 intro m n p A B x
 change (A * B).mulVec x = A.mulVec (B.mulVec x)
 exact (Matrix.mulVec_mulVec x A B).symm
"""
# Two dependent meanings are still ambiguity, independent of insertion order.
notation('Notation another grid product(A,B):',[
 'Let m,n,p: Natural','Let A: Grid(m,n)','Let B: Grid(n,p)','Returns: Grid(m,p)',
 'Infix: *','Means: A*B','Render latex: {A}{B}'],linear)
message=reject(linear,'A*B','Ambiguous operator',ls)
linear.operator_overloads['*'].reverse()
assert reject(linear,'A*B','Ambiguous operator',ls)==message

p=COMPILER/'OperatorAcceptance.lean';p.write_text(native)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=COMPILER,check=True)
print('Operator prototype: syntax/dispatch checks, sixteen exact targets and two proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
