# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Preserve resolved callable heads in saved proof conditions, including quantifiers."""
from pathlib import Path
import sys,ast,subprocess,os,shutil,tempfile,json
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
if len(sys.argv)==1:
 with tempfile.TemporaryDirectory(prefix='clean-bound-calls-') as td:
  dest=Path(td)
  for name in subprocess.check_output(['git','ls-files','-z'],cwd=ROOT,text=True).split('\0'):
   if name and (ROOT/name).is_file():
    out=dest/name;out.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(ROOT/name,out)
  (dest/'.lake').symlink_to(ROOT/'.lake',target_is_directory=True)
  for patch in ['prototype.patch','bound-calls.patch','proof-bindings.patch']:
   subprocess.run(['git','apply',str(HERE/patch)],cwd=dest,check=True)
  for args in [[],['--check']]:subprocess.run([sys.executable,str(dest/'tools/generate_parser.py'),*args],cwd=dest,check=True)
  subprocess.run([sys.executable,str(Path(__file__).resolve()),str(dest)],cwd=dest,check=True)
  subprocess.run([sys.executable,str(HERE/'check_capture.py'),str(dest)],cwd=dest,check=True)
  subprocess.run([sys.executable,str(HERE/'verify_prototype.py'),str(dest)],cwd=dest,check=True)
  extra_env=os.environ.copy();extra_env['PYTHONPATH']=str(dest/'tests')
  subprocess.run([sys.executable,'-m','unittest','test_quantified_beta','test_quantifiers','test_proof_families','test_evidence','-v'],cwd=dest,env=extra_env,check=True)
 raise SystemExit(0)
COMPILER=Path(sys.argv[1]).resolve();sys.path.insert(0,str(COMPILER))
from cleanlang.core import Environment,Expr,Expressions,CleanError,lean
from cleanlang.modules import load_module,notation,load_document
from cleanlang.proof_types import substitute_proof
from cleanlang.syntax import parse,expression_tree
r=ROOT;e=Environment();results=load_document(r/'studies/carrier-fields/ProofBindings.clean.proposed',e)
assert len(results)==4
s={}
def local(n,t):s[n]=Expr(n,n,e.type(t,s),tree=['Local',n])
local('x','Real');local('q','(for every (z: Real, c(z)))')
local('c','Function(Real,Proposition)');local('h','(c(x))');local('k','(x=x)')
local('bad','(for every (z: Real, c(z)))')
def reject(source):
 try:Expressions(e,s).parse(source)
 except CleanError as error:assert 'Dependent index mismatch:' in str(error),str(error)
 else:raise AssertionError('Captured proof accepted: '+source)
reject('retain proof(x,h)');reject('retain universal(bad)');reject('specialize(bad,x)')
values=[Expressions(e,s).parse(source) for source in ['retain proof(x,k)','retain local(c,x,h)','retain universal(q)','specialize(q,x)']]
module=e.data['functions']['c']['lean']
index=e.data['functions']['retain proof']['dependent_signature']['parameters'][1][1].args[0]
assert json.loads(index.syntax)==['ModuleCall','c',[['Local','x']],module]
quantified=e.data['functions']['retain universal']['dependent_signature']['parameters'][0][1].args[0]
assert json.loads(quantified.syntax)==['Forall','z','Real',['ModuleCall','c',[['Local','z']],module]]
assert expression_tree(parse('for every (z: Real, c(z))','expression'))==['Forall','z','Real',['Call','c',[['Local','z']]]]
# Quantifier-bound functions are local, even inside saved proof conditions.
function_condition=e.type('(for every (f: Function(Real,Proposition), f(x) → f(x)))',s).args[0]
assert json.loads(function_condition.syntax)==['Forall','f','Function(Real,Proposition)',['Operator','→',['Apply',['Local','f'],[['Local','x']]],['Apply',['Local','f'],[['Local','x']]]]]
# Repeated proof substitution preserves the module head under caller shadowing.
changed=substitute_proof(index,{'x':s['x']},e,s)
assert json.loads(changed.syntax)[0]=='ModuleCall'
assert substitute_proof(changed,{},e,s)==changed
original=e.data['functions']['c']['lean'];e.data['functions']['c']['lean']='changed_target'
try:substitute_proof(index,{'x':s['x']},e,s)
except CleanError as error:assert str(error)=='Changed bound module callable: c',str(error)
else:raise AssertionError('Changed proof callable accepted')
e.data['functions']['c']['lean']=original
comparison=next(ast.literal_eval(n.value) for n in ast.parse((r/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
f=lambda name:e.data['functions'][name]['lean'].split()[0]
native=lean(results,e,['Lean'])+comparison+f'''
def actual_module (x : ℝ) (c : ℝ → Prop) (k : x=x) := {values[0].lean}
def expected_module (x : ℝ) (c : ℝ → Prop) (k : x=x) := @{f('retain proof')} x k
same_basic_target actual_module expected_module
def actual_local (x : ℝ) (c : ℝ → Prop) (h : c x) := {values[1].lean}
def expected_local (x : ℝ) (c : ℝ → Prop) (h : c x) := @{f('retain local')} c x h
same_basic_target actual_local expected_local
def actual_universal (c : ℝ → Prop) (q : ∀ z : ℝ, {f('c')} z) := {values[2].lean}
def expected_universal (c : ℝ → Prop) (q : ∀ z : ℝ, {f('c')} z) := @{f('retain universal')} q
same_basic_target actual_universal expected_universal
def actual_specialize (x : ℝ) (c : ℝ → Prop) (q : ∀ z : ℝ, {f('c')} z) := {values[3].lean}
def expected_specialize (x : ℝ) (c : ℝ → Prop) (q : ∀ z : ℝ, {f('c')} z) := @{f('specialize')} q x
same_basic_target actual_specialize expected_specialize

theorem module_checked (x : ℝ) (c : ℝ → Prop) (k : x=x) : actual_module x c k = k := rfl
theorem local_checked (x : ℝ) (c : ℝ → Prop) (h : c x) : actual_local x c h = h := rfl
theorem universal_checked (c : ℝ → Prop) (q : ∀ z : ℝ, {f('c')} z) : actual_universal c q = q := rfl
theorem specialize_checked (x : ℝ) (c : ℝ → Prop) (q : ∀ z : ℝ, {f('c')} z) : actual_specialize x c q = q x := rfl
'''
native+=f'''
 def expected_statement_module : Prop := ∀ (x : ℝ) (k : x=x) (c : ℝ → Prop), @{f('retain proof')} x k = k
 def expected_statement_local : Prop := ∀ (x : ℝ) (c : ℝ → Prop) (h : c x), @{f('retain local')} c x h = h
 def expected_statement_universal : Prop := ∀ (q : ∀ z : ℝ, {f('c')} z) (c : ℝ → Prop), @{f('retain universal')} q = q
 def expected_statement_specialize : Prop := ∀ (x : ℝ) (q : ∀ z : ℝ, {f('c')} z) (c : ℝ → Prop), @{f('specialize')} q x = q x
 same_basic_target CleanStatements.module_proof_retained expected_statement_module
 same_basic_target CleanStatements.local_proof_retained expected_statement_local
 same_basic_target CleanStatements.universal_proof_retained expected_statement_universal
 same_basic_target CleanStatements.universal_proof_specialized expected_statement_specialize
 theorem statement_module_checked : CleanStatements.module_proof_retained := by intro x k c; rfl
 theorem statement_local_checked : CleanStatements.local_proof_retained := by intro x c h; rfl
 theorem statement_universal_checked : CleanStatements.universal_proof_retained := by intro q c; rfl
 theorem statement_specialize_checked : CleanStatements.universal_proof_specialized := by intro x q c; rfl
'''
p=COMPILER/'ProofBindingsVerified.lean';p.write_text(native)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=p.parent,check=True)
print('Eight exact proof-binding targets and eight proofs passed; wrong local conditions rejected')
(HERE/'ProofBindingsVerified.lean').write_text(native)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
