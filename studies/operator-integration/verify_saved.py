# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Compose declared operators with carrier, callable-binding and annotation fixes."""
from pathlib import Path
import sys,ast,subprocess,os,shutil,tempfile,json,copy
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
COMPILER=Path(sys.argv[1]).resolve();sys.path.insert(0,str(COMPILER))
from cleanlang.core import Environment,Expr,Expressions,CleanError,lean,latex
from cleanlang.modules import load_document,load_module,notation,condition_declaration
from cleanlang.dependent_functions import index_tree
from cleanlang.proof_types import substitute_proof,callable_view
from cleanlang.syntax import condition_spelling,header,parse,expression_tree
from cleanlang.annotations import Annotation
r=ROOT;e=Environment();results=load_document(HERE/'Saved.clean.proposed',e)
assert len(results)==3
assert header('Condition implication(p: Proposition,q: Proposition):')==('condition','implication',[('p','Proposition'),('q','Proposition')],None)
assert expression_tree(parse('P → Q','expression'))==['Operator','→',['Local','P'],['Local','Q']]

scope={}
def local(n,t):scope[n]=Expr(n,n,e.type(t,scope),tree=['Local',n])
local('n','Natural');local('h','(equal(n,n))');local('P','Proposition');local('Q','Proposition')
result=Expressions(e,scope).parse('retain equation(n,h)')
for spelling in ['n=n','n+n']:
 try:Expressions(e,scope).parse(spelling)
 except CleanError as error:assert 'Ambiguous operator' in str(error),str(error)
 else:raise AssertionError('Fresh source was not ambiguous')
saved=e.data['functions']['retain equation']['dependent_signature']['parameters'][1][1].args[0]
assert index_tree(saved)[0:2]==['ModuleCall','equal']
assert index_tree(saved)[4]==['infix','=']
assert condition_spelling(index_tree(saved))=='(x = x)'
qtype=e.type('(not (P → Q))',scope)
neg=substitute_proof(qtype.args[0],{},e,scope)
assert '\\left(' in neg.tex and '\\right)' in neg.tex,neg.tex
assert index_tree(neg)[4]==['prefix','not']
assert index_tree(neg)[2][0][4]==['infix','→']
named=Expressions(e,scope).parse('negation(implication(P,Q))')
assert (named.lean,named.tex)==(neg.lean,neg.tex)
assert named.tex.count('\\left(')==1
right=Expressions(e,scope).parse('sum(n,sum(n,n))')
left=Expressions(e,scope).parse('sum(sum(n,n),n)')
assert '\\left(' in right.tex and '\\left(' not in left.tex

assert e.is_function_type(e.type('(P → Q)',scope))
quantified=e.data['functions']['keep quantified']['dependent_signature']['parameters'][1][1].args[0]
domain=index_tree(quantified)[2]
assert isinstance(domain,Annotation)
assert index_tree(domain.typ.args[0])[4]==['infix','+']
# Condition metadata uses the same arity validation and publishes nothing on failure.
before_functions=dict(e.data['functions'])
try:condition_declaration('Condition invalid prefix(p: Proposition,q: Proposition):',['Prefix: not','From Lean: p ∧ q','Render latex: {p},{q}'],e)
except CleanError as error:assert 'one explicit operand' in str(error),str(error)
else:raise AssertionError('Invalid Condition prefix arity accepted')
assert e.data['functions']==before_functions
# Candidate order is irrelevant to stored expressions as well as fresh ambiguity.
before=result.lean
e.operator_overloads['='].reverse();e.operator_overloads['+'].reverse()
assert Expressions(e,scope).parse('retain equation(n,h)').lean==before
# The arrow's callable meaning comes from its authored Forall, not its token.
other=Environment()
source=(HERE/'Saved.clean.proposed').read_text().split('Result saved equality:')[0]
source=source.replace('Holds when: for every (h: (p), q)','From Lean: p ∧ q')
p=COMPILER/'NonCallableArrow.clean';p.write_text(source)
load_module(p,other)
other_scope={n:Expr(n,n,other.type('Proposition'),tree=['Local',n]) for n in ['P','Q']}
assert not other.is_function_type(other.type('(P → Q)',other_scope))
# Saved prefix meaning and grouping survive a later competing prefix declaration.
condition_declaration('Condition another negation(p: Proposition):',['Prefix: not','From Lean: ¬p','Render latex: NOT({p})'],e)
try:Expressions(e,scope).parse('not P')
except CleanError as error:assert 'Ambiguous operator' in str(error),str(error)
else:raise AssertionError('Fresh prefix was not ambiguous')
for order in [False,True]:
 if order:e.prefix_overloads['¬'].reverse()
 again=substitute_proof(neg,{},e,scope)
 assert (again.lean,again.tex)==(neg.lean,neg.tex)
from cleanlang.conditions import source_expression
assert source_expression(index_tree(neg))=='(not (P → Q))'
# Changed selected templates remain errors even if candidate lists look unchanged.
old=e.data['functions']['negation']['lean'];e.data['functions']['negation']['lean']='changed_target'
try:substitute_proof(neg,{},e,scope)
except CleanError as error:assert str(error)=='Changed bound module callable: negation',str(error)
else:raise AssertionError('Changed prefix binding accepted')
e.data['functions']['negation']['lean']=old
f=lambda n:e.data['functions'][n]['native_binding']
k=lambda n:e.data['types'][n]['native_binding']
N,P,R=(f'_root_.{k(n)}' for n in ['Natural','Proposition','Real'])
V=f'_root_.{k("Vector")}'
comparison=next(ast.literal_eval(n.value) for n in ast.parse((r/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
native=lean(results,e,['Lean'])+comparison+f'''
def expected_type : Type 1 := Type
same_basic_target {k('Type')} expected_type
def expected_prop : Sort 1 := Prop
same_basic_target {k('Proposition')} expected_prop
def expected_nat : Type := Nat
same_basic_target {k('Natural')} expected_nat
def expected_real : Type := Real
same_basic_target {k('Real')} expected_real
def expected_function (T U : Type) : Type := T → U
same_basic_target {k('Function')} expected_function
def expected_vector (n : Nat) (T : Type) : Type := Fin n → T
same_basic_target {k('Vector')} expected_vector
def expected_equal {{T : Type}} (x y : T) : {P} := x=y
same_basic_target {f('equal')} expected_equal
def expected_negation_body (p : {P}) : {P} := ¬p
same_basic_target {f('negation')} expected_negation_body
noncomputable def expected_sum (x y : {N}) : {N} := x+y
same_basic_target {f('sum')} expected_sum
def expected_natural_equality (x y : {N}) : {P} := x=y
same_basic_target {f('natural equality')} expected_natural_equality

def actual_retained (n : {N}) (h : @{f('equal')} {N} n n) := {result.lean}
def expected_retained (n : {N}) (h : @{f('equal')} {N} n n) := @{f('retain equation')} {N} n h
same_basic_target actual_retained expected_retained
def actual_negation (P Q : {P}) : Prop := {neg.lean}
def expected_negation (P Q : {P}) : Prop := @{f('negation')} (@{f('implication')} P Q)
same_basic_target actual_negation expected_negation
def expected_implication (p q : {P}) : {P} := ∀ (_ : p), q
same_basic_target {f('implication')} expected_implication
noncomputable def expected_another_sum (x y : {N}) : {N} := @{f('sum')} x y
same_basic_target {f('another sum')} expected_another_sum

def expected_saved : Prop := ∀ (n : {N}) (h : @{f('equal')} {N} n n), let q : @{f('equal')} {N} n n := @{f('retain equation')} {N} n h; @{f('equal')} {N} n n
same_basic_target CleanStatements.saved_equality expected_saved
def expected_application : Prop := ∀ (P Q : {P}) (h : @{f('implication')} P Q) (p : P), let q : Q := h p; Q
same_basic_target CleanStatements.implication_application expected_application
def expected_quantified : Prop := ∀ (n : {N}) (h : ∀ v : {V} ({f('sum')} n n) {R}, @{f('equal')} ({V} ({f('sum')} n n) {R}) v v), let q := @{f('keep quantified')} n h; ∀ v : {V} ({f('sum')} n n) {R}, @{f('equal')} ({V} ({f('sum')} n n) {R}) v v
same_basic_target CleanStatements.saved_quantified_annotation expected_quantified

theorem saved_checked : CleanStatements.saved_equality := by intro n h; exact h
theorem application_checked : CleanStatements.implication_application := by intro P Q h p; exact h p
theorem quantified_checked : CleanStatements.saved_quantified_annotation := by intro n h; exact h
'''
p=COMPILER/'SavedVerified.lean';p.write_text(native)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=p.parent,check=True)
print('Seventeen exact composed targets and three proofs passed; frozen overloads, annotations, prefix rendering and authored implication checked')
(HERE/'SavedVerified.lean').write_text(native)
(HERE/'Saved.tex').write_text(latex(results,e)+r'''
\paragraph{Grouping checks.}
The operator and named negation forms have the same rendering:
\['''+named.tex+r'''.\]
A right-nested named sum preserves its parentheses:
\['''+right.tex+r'''.\]
''')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
