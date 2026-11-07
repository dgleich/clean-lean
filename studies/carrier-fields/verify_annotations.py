# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Retain checked type annotations and rebind their free local references."""
from pathlib import Path
import sys,ast,subprocess,os,shutil,tempfile,json,copy
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from tools.study_checkout import create_study_checkout
if len(sys.argv)==1:
 with tempfile.TemporaryDirectory(prefix='clean-bound-calls-') as td:
  dest=Path(td)
  create_study_checkout(dest, ROOT)
  for patch in ['prototype.patch','bound-calls.patch','proof-bindings.patch','annotations.patch']:
   subprocess.run(['git','apply',str(HERE/patch)],cwd=dest,check=True)
  for args in [[],['--check']]:subprocess.run([sys.executable,str(dest/'tools/generate_parser.py'),*args],cwd=dest,check=True)
  subprocess.run([sys.executable,str(Path(__file__).resolve()),str(dest)],cwd=dest,check=True)
  subprocess.run([sys.executable,str(HERE/'check_capture.py'),str(dest)],cwd=dest,check=True)
  subprocess.run([sys.executable,str(HERE/'verify_proof_bindings.py'),str(dest)],cwd=dest,check=True)
  subprocess.run([sys.executable,str(HERE/'verify_prototype.py'),str(dest)],cwd=dest,check=True)
  extra_env=os.environ.copy();extra_env['PYTHONPATH']=str(dest/'tests')
  subprocess.run([sys.executable,'-m','unittest','test_quantified_beta','test_quantifiers','test_proof_families','test_evidence','test_comparison_token_cache','test_bound_name_cache','-v'],cwd=dest,env=extra_env,check=True)
 raise SystemExit(0)
COMPILER=Path(sys.argv[1]).resolve();sys.path.insert(0,str(COMPILER))
from cleanlang.core import Environment,Expr,Expressions,CleanError,lean
from cleanlang.modules import load_document
from cleanlang.indices import index_value,substitute_index
from cleanlang.proof_types import substitute_proof
from cleanlang.dependent_functions import index_tree
from cleanlang.annotations import Annotation
from cleanlang.conversion import index_comparison
r=ROOT;e=Environment();results=load_document(r/'studies/carrier-fields/AnnotatedTypes.clean.proposed',e)
assert len(results)==1
s={}
for n,t in [('n','Natural'),('m','Natural')]:s[n]=Expr(n,n,e.type(t,s),tree=['Local',n])
v=index_value(Expressions(e,s).parse('marker(type(Vector((count(n)),Real)))'),e,s)
q=e.type('(for every (v: Vector((count(n)),Real), for every (p: (v=v), p=p)))',s).args[0]
authored=index_value(Expressions(e,s).parse('mark vector(n)'),e,s)
s['count']=Expr('count','count',e.type('Function(Natural,Natural)'),tree=['Local','count'])
v2=substitute_index(v,{'n':s['m']},e,s)
q2=substitute_proof(q,{'n':s['m']},e,s)
authored2=substitute_index(authored,{'n':s['m']},e,s)
assert authored2==v2
assert isinstance(index_tree(v2)[2][0][1],Annotation)
annotation=index_tree(v2)[2][0][1]
assert annotation.names=={'m'}
assert 'ModuleCall' in annotation.typ.args[0].syntax
assert isinstance(index_tree(q2)[2],Annotation)
assert isinstance(index_tree(q2)[3][2],Annotation)
assert len(index_tree(q2)[3][2].names)==1
assert copy.deepcopy(v2)==v2
assert isinstance(index_tree(copy.deepcopy(v2))[2][0][1],Annotation)
assert substitute_index(v2,{},e,s)==v2
assert substitute_proof(q2,{},e,s)==q2
# Equal display spelling must not erase different resolved local/module meanings.
other=Annotation(str(annotation),e.type(str(annotation),s),annotation.names)
assert annotation!=other
try:annotation.typ=e.type('Real')
except AttributeError:pass
else:raise AssertionError('Semantic annotation mutated')
s['bad']=Expr('bad','bad',e.type('(for every (v: Vector((count(n)),Real), for every (p: (v=v), p=p)))',s),tree=['Local','bad'])
try:Expressions(e,s).parse('keep law(n,bad)')
except CleanError as error:assert 'Dependent index mismatch' in str(error),str(error)
else:raise AssertionError('Local callable captured a stored binder domain')
old=e.data['functions']['count']['lean'];e.data['functions']['count']['lean']='changed_target'
try:Expressions(e,s).elaborate(index_tree(v2))
except CleanError as error:assert str(error)=='Changed bound module callable: count',str(error)
else:raise AssertionError('Changed nested callable accepted')
e.data['functions']['count']['lean']=old
f=lambda name:e.data['functions'][name]['lean'].split()[0]
comparison=next(ast.literal_eval(n.value) for n in ast.parse((r/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
native=lean(results,e,['Lean'])+comparison+f'''
noncomputable def actual_marker (m : ℕ) (count : ℕ → ℕ) : ℕ := {v2.lean}
noncomputable def expected_marker (m : ℕ) (count : ℕ → ℕ) : ℕ := @{f('marker')} (Fin ({f('count')} m) → ℝ)
same_basic_target actual_marker expected_marker
noncomputable def actual_authored (m : ℕ) (count : ℕ → ℕ) : ℕ := {authored2.lean}
noncomputable def expected_authored (m : ℕ) (count : ℕ → ℕ) : ℕ := @{f('mark vector')} m
same_basic_target actual_authored expected_authored
noncomputable def actual_normal (m : ℕ) (count : ℕ → ℕ) : ℕ := {authored2.comparison_key()}
noncomputable def expected_normal (m : ℕ) (count : ℕ → ℕ) : ℕ := @{f('marker')} (Fin ({f('count')} m) → ℝ)
same_basic_target actual_normal expected_normal
 def actual_nested (m : ℕ) (count : ℕ → ℕ) : Prop := {q2.lean}
 def expected_nested (m : ℕ) (count : ℕ → ℕ) : Prop := ∀ (v : Fin ({f('count')} m) → ℝ), ∀ (p : v=v), p=p
 same_basic_target actual_nested expected_nested
 def expected_statement : Prop := ∀ (n : ℕ) (h : ∀ (v : Fin ({f('count')} n) → ℝ), ∀ (p : v=v), p=p) (count : ℕ → ℕ), @{f('keep law')} n h = h
 same_basic_target CleanStatements.quantified_annotation_retained expected_statement
 theorem marker_checked (m : ℕ) (count : ℕ → ℕ) : actual_marker m count = 0 := rfl
 theorem nested_checked (m : ℕ) (count : ℕ → ℕ) : actual_nested m count := by intro v p; rfl
 theorem statement_checked : CleanStatements.quantified_annotation_retained := by intro n h count; rfl
'''
p=COMPILER/'AnnotatedTypesVerified.lean';p.write_text(native)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=p.parent,check=True)
print('Five exact annotation targets and three proofs passed, including nested dependent binders')
(HERE/'AnnotatedTypesVerified.lean').write_text(native)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
