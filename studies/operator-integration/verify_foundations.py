# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Check explicit foundation modules, their targets, and six mathematical laws."""
from pathlib import Path
import ast,sys,os,subprocess,copy,tempfile
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
COMPILER=Path(sys.argv[1]).resolve();sys.path.insert(0,str(COMPILER))
from cleanlang.core import Environment,Expr,Expressions,CleanError,lean,latex
from cleanlang.modules import load_document,load_module
from cleanlang.syntax import parse,expression_tree

e=Environment();results=load_document(HERE/'foundations/Statements.clean.proposed',e)
assert len(results)==6
f=lambda name:e.data['functions'][name]['native_binding']
k=lambda name:e.data['types'][name]['native_binding']
ref=lambda name:'_root_.'+f(name)
K,P,S,R,N,M,V=('_root_.'+k(name) for name in ['Type','Proposition','Set','Real','Natural','Matrix','Vector'])
eq,add,neg,diff,inter,member,subset,common,prod,app,sm,sv=(ref(name) for name in ['equal','real addition','real negative','real difference','intersection','member','subset','common part','matrix product','matrix application','scale matrix','scale vector'])
assert expression_tree(parse('x ∈ A ∩ B','expression'))==['Operator','∈',['Local','x'],['Operator','∩',['Local','A'],['Local','B']]]
assert expression_tree(parse('(A*B)*x = A*(B*x)','expression'))==['Operator','=', ['Operator','*',['Operator','*',['Local','A'],['Local','B']],['Local','x']], ['Operator','*',['Local','A'],['Operator','*',['Local','B'],['Local','x']]]]

scope={}
for name,typ in [('m','Natural'),('n','Natural'),('p','Natural'),('q','Natural'),('A','Matrix(m,n)'),('B','Matrix(n,p)'),('x','Vector(n)'),('wrong','Vector(q)'),('s','Real')]:
    scope[name]=Expr(name,name,e.type(typ,scope),tree=['Local',name])
forms=[('A*B','matrix product','Matrix(m,p)'),('A*x','matrix application','Vector(m)'),('s*A','scale matrix','Matrix(m,n)'),('s*x','scale vector','Vector(n)')]
terms=[]
for source,selected,typ in forms:
    value=Expressions(e,scope).parse(source);assert value.operator_binding[0]==selected
    assert value.type==e.type(typ,scope);terms.append(value)
e.operator_overloads['*'].reverse()
for (source,_,_),value in zip(forms,terms):assert Expressions(e,scope).parse(source).lean==value.lean

def rejects(env,source,local,fragment):
    try:Expressions(env,local).parse(source)
    except CleanError as error:assert fragment in str(error),str(error)
    else:raise AssertionError('Expected rejection: '+source)
rejects(e,'A*wrong',scope,'No declared meaning')
rejects(e,'s+1',scope,'numeral interpretation')
# Imports supply the vocabulary; no missing operator can use a built-in fallback.
missing=copy.deepcopy(e);missing.operator_overloads['*'].remove('matrix application')
rejects(missing,'A*x',scope,'No declared meaning')
# A shared explicit import is deduplicated; reversing independent imports does
# not change the selected declarations or generated statement bodies.
source=(HERE/'foundations/Statements.clean.proposed').read_text()
a='Import "Sets.clean.proposed"';b='Import "LinearAlgebra.clean.proposed"'
with tempfile.TemporaryDirectory() as td:
    import shutil
    for path in (HERE/'foundations').glob('*.clean.proposed'):shutil.copy2(path,Path(td)/path.name)
    path=Path(td)/'Statements.clean.proposed';path.write_text(source.replace(a+'\n'+b,b+'\n'+a))
    other=Environment();again=load_document(path,other)
    # Named Condition calls retain automatic labels, including comma lists.
    path.write_text(source.replace('  Assume in A: x ∈ A\n  Assume in B: x ∈ B',
                                   '  Assume member(x,A), member(x,B)'))
    named_env=Environment();named_results=load_document(path,named_env)
    path.write_text(source.replace('  Assume in A: x ∈ A\n  Assume in B: x ∈ B',
                                   '  Assume x ∈ A, x ∈ B'))
    try:load_document(path,Environment())
    except CleanError as error:assert 'Automatic assumption naming requires a declared Condition call' in str(error)
    else:raise AssertionError('Undeclared automatic infix naming policy accepted')
assert e.notation_definitions==other.notation_definitions
for first,second in zip(results,again):assert first.conclusion.lean==second.conclusion.lean
assert len(e.data['functions'])==19 and len(e.data['types'])==8

comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
native=lean(results,e,['Lean'])+comparison
count=0

def target(actual,binders,typ,body):
    global native,count
    label='expected_foundation_'+str(count);count+=1
    native+=f'\nnoncomputable def {label} {binders} : {typ} := {body}\nsame_basic_target {actual} {label}\n'

# Adapter bodies are independent expected terms, not regenerated translator output.
for name,binders,typ,body in [
 ('Type','','Type 1','Type'),('Proposition','','Sort 1','Prop'),
 ('Set','(T : Type)','Type','Set T'),('Real','','Type','Real'),
 ('Natural','','Type','Nat'),('Matrix','(m n : Nat)','Type','Matrix (Fin m) (Fin n) Real'),
 ('Vector','(n : Nat)','Type','Fin n → Real'),
 ('Function','(X Y : Type)','Type','X → Y')]:target(k(name),binders,typ,body)
for name,binders,typ,body in [
 ('equal','{T : Type} (x y : T)',P,'x=y'),
 ('conjunction',f'(p q : {P})',P,'p ∧ q'),
 ('implication',f'(p q : {P})',P,'∀ (_ : p), q'),
 ('negation',f'(p : {P})',P,'¬p'),
 ('equivalent',f'(p q : {P})',P,'p ↔ q'),
 ('union',f'{{T : Type}} (A B : {S} T)',f'{S} T','A ∪ B'),
 ('intersection',f'{{T : Type}} (A B : {S} T)',f'{S} T','A ∩ B'),
 ('subset',f'{{T : Type}} (A B : {S} T)',P,'A ⊆ B'),
 ('member',f'{{T : Type}} (x : T) (A : {S} T)',P,'x ∈ A'),
 ('common part',f'{{T : Type}} (A B : {S} T)',f'{S} T',f'@{inter} T A B'),
 ('real addition',f'(x y : {R})',R,'x+y'),
 ('real multiplication',f'(x y : {R})',R,'x*y'),
 ('real negative',f'(x : {R})',R,'-x'),
 ('real at most',f'(x y : {R})',P,'x ≤ y'),
 ('real difference',f'(x y : {R})',R,f'{add} x ({neg} y)'),
 ('matrix product',f'{{m n p : {N}}} (A : {M} m n) (B : {M} n p)',f'{M} m p','A*B'),
 ('matrix application',f'{{m n : {N}}} (A : {M} m n) (x : {V} n)',f'{V} m','Matrix.mulVec A x'),
 ('scale matrix',f'{{m n : {N}}} (s : {R}) (A : {M} m n)',f'{M} m n','s • A'),
 ('scale vector',f'{{n : {N}}} (s : {R}) (x : {V} n)',f'{V} n','s • x')]:target(f(name),binders,typ,body)

expected_statements=[
 f'∀ (x y : {R}), @{eq} {R} ({add} x y) ({add} y x)',
 f'∀ (x y : {R}), @{eq} {R} ({diff} x y) ({add} x ({neg} y))',
 f'∀ (T : {K}) (A B : {S} T), @{eq} ({S} T) (@{inter} T A B) (@{inter} T B A)',
 f'∀ (T : {K}) (A B : {S} T), @{subset} T (@{common} T A B) A',
 f'∀ (T : {K}) (x : T) (A B : {S} T) (_ : @{member} T x A) (_ : @{member} T x B), @{member} T x (@{inter} T A B)',
 f'∀ (m n p : {N}) (A : {M} m n) (B : {M} n p) (x : {V} p), @{eq} ({V} m) (@{app} m p (@{prod} m n p A B) x) (@{app} m n A (@{app} n p B x))']
for result,expected in zip(results,expected_statements):target('CleanStatements.'+result.name,'','Prop',expected)
for i,(value,expected,typ) in enumerate(zip(terms,[f'@{prod} m n p A B',f'@{app} m n A x',f'@{sm} m n s A',f'@{sv} n s x'],[f'{M} m p',f'{V} m',f'{M} m n',f'{V} n'])):
    binders=f'(m n p : {N}) (A : {M} m n) (B : {M} n p) (x : {V} n) (s : {R})'
    native+=f'\nnoncomputable def actual_application_{i} {binders} : {typ} := {value.lean}\n'
    target('actual_application_'+str(i),binders,typ,expected)

native+='''
theorem addition_checked : CleanStatements.addition_commutes := by
  intro x y
  change x+y=y+x
  exact add_comm x y

theorem difference_checked : CleanStatements.subtraction_means_addition_of_the_negative := by
  intro x y
  rfl

theorem intersection_checked : CleanStatements.intersection_commutes := by
  intro T A B
  change A ∩ B = B ∩ A
  exact Set.inter_comm A B

theorem common_checked : CleanStatements.common_part_is_contained := by
  intro T A B
  change A ∩ B ⊆ A
  exact Set.inter_subset_left

theorem membership_checked : CleanStatements.intersection_membership := by
  intro T x A B hA hB
  exact ⟨hA,hB⟩

theorem matrix_checked : CleanStatements.matrix_product_application := by
  intro m n p A B x
  change (A*B).mulVec x = A.mulVec (B.mulVec x)
  exact (Matrix.mulVec_mulVec x A B).symm
'''
named_native=lean([named_results[4]],named_env,[])
named_native=named_native[named_native.index('namespace CleanStatements'):]
native+=named_native.replace('CleanStatements','NamedAssumptions')
target('NamedAssumptions.intersection_membership','','Prop',expected_statements[4])
assert count==38
p=COMPILER/'FoundationsVerified.lean';p.write_text(native)
subprocess.run([os.environ.get('LAKE','/home/claude/.elan/bin/lake'),'env','lean',str(p)],cwd=COMPILER,check=True)
(HERE/'FoundationsVerified.lean').write_text(native)
(HERE/'Foundations.tex').write_text(latex(results,e))
print('Explicit foundations: 38 exact targets, six proofs; import order, dependent dimensions and missing-operator rejection passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
