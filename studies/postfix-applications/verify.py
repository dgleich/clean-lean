# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Expr,Expressions,lean,latex
from cleanlang.modules import load_document
e=Environment();rs=load_document(HERE/'Statements.clean',e)
s=lean(rs,e,['Lean']);(HERE/'Generated.lean').write_text(s);(HERE/'Statements.tex').write_text(latex(rs,e))
f=lambda n:e.data['functions'][n]['lean'].split()[0]
box=e.structures['FunctionBox']['key'];offset=f('add offset');congr=f('equality congruence');boxed=f('boxed offset')
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
s+=comparison+f'''
def expected_returned : Prop := ∀ (n m : ℕ), ({offset} n) m = n+m
def expected_local : Prop := ∀ (f : ℕ → ℕ → ℕ) (n m : ℕ), (f n) m = (f n) m
def expected_field : Prop := ∀ (p : {box}) (n m : ℕ), (p.action n) m = (p.action n) m
def expected_lambda : Prop := ∀ (n : ℕ), (fun x : ℕ => x) n = n
def expected_interleaved : Prop := ∀ (n m x y : ℕ), (({boxed} n) m).action x y = n+m+x+y
'''
for a,b in [('returned_function_application','returned'),('curried_local_application','local'),('curried_field_application','field'),('applied_identity_function','lambda'),('interleaved_returned_field','interleaved')]:
 s+='same_basic_target CleanStatements.'+a+' expected_'+b+'\n'
# Proof indices containing an applied lambda preserve its uncontracted binder body.
local={}
for n,t in [('a','Real'),('b','Real'),('h','Evidence((a = b))')]:local[n]=Expr(n,n,e.type(t,local),tree=['Local',n])
for label,source,fn,typ in [
 ('quantified','function(t: Real,for every (u: Real,t = u))','fun t : Real => ∀ u : Real, t=u','Prop'),
 ('nested','function(t: Real,function(u: Real,t+u))','fun t : Real => fun u : Real => t+u','Real → Real')]:
 value=Expressions(e,local).parse('equality congruence('+source+',a,b,h)')
 s+=f'noncomputable def actual_{label} (a b : Real) (h : a=b) : '+e.render_type(value.type,'lean',local)+' := '+value.lean+'\n'
 s+=f'noncomputable def expected_{label} (a b : Real) (h : a=b) : ({fn}) a = ({fn}) b := @{congr} Real ({typ}) ({fn}) a b h\n'
 s+=f'same_basic_target actual_{label} expected_{label}\n'
# A dependent second application must select the supplied proof argument verbatim.
local={}
for n,t in [('h','Function(x: Natural,Function(Evidence((x = x)),Evidence((x = x))))'),('n','Natural'),('p','Evidence((n = n))')]:local[n]=Expr(n,n,e.type(t,local),tree=['Local',n])
value=Expressions(e,local).parse('h(n)(p)')
s+='def actual_dependent (h : ∀ x : ℕ, x=x → x=x) (n : ℕ) (p : n=n) : n=n := '+value.lean+'\n'
s+='def expected_dependent (h : ∀ x : ℕ, x=x → x=x) (n : ℕ) (p : n=n) : n=n := (h n) p\nsame_basic_target actual_dependent expected_dependent\n'
for a in ['returned_function_application','curried_local_application','curried_field_application','applied_identity_function','interleaved_returned_field']:
 s+='theorem checked_'+a+' : CleanStatements.'+a+' := by unfold CleanStatements.'+a+'; intros; rfl\n'
p=HERE/'Verified.lean';p.write_text(s)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Eight exact postfix targets and five proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
