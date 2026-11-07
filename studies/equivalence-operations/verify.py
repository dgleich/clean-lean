# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Check independently authored elaborated targets and prove emitted statements."""
from pathlib import Path
import ast, os, re, subprocess, sys
ROOT=Path(__file__).resolve().parents[2]; HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment, lean, latex
from cleanlang.modules import load_document
e=Environment(); results=load_document(HERE/'Statements.clean',e)
f=lambda name:e.data['functions'][name]['lean'].split()[0]
s=lean(results,e,['Lean'])
(HERE/'Generated.lean').write_text(s)
(HERE/'Statements.tex').write_text(latex(results,e))
keys={key:f(name) for key,name in [
 ('MAKE','equivalence'),('FORWARD','equivalence forward'),('BACKWARD','equivalence backward'),
 ('LEFT','equivalence left inverse'),('RIGHT','equivalence right inverse'),
 ('TRANS','equality transitivity'),('CONGR','equality congruence'),
 ('INVERSE','inverse equivalence'),('COMPOSE','compose equivalences')]}
expected=r'''
namespace EquivalenceOperationsOracle
noncomputable def transitivity {A : Type} (x y z : A)
 (first : x = y) (second : y = z) : x = z := Eq.trans first second
noncomputable def left {A B : Type} (e : A ≃ B) (x : A) : BACKWARD e (FORWARD e x) = x :=
 e.symm_apply_apply x
noncomputable def right {A B : Type} (e : A ≃ B) (y : B) : FORWARD e (BACKWARD e y) = y :=
 e.apply_symm_apply y
noncomputable def inverse {A B : Type} (e : A ≃ B) : B ≃ A :=
 MAKE B A (fun y => BACKWARD e y) (fun x => FORWARD e x)
   (fun y => RIGHT e y) (fun x => LEFT e x)
noncomputable def compose {A B C : Type} (e : A ≃ B) (f : B ≃ C) : A ≃ C :=
 MAKE A C
   (fun x => FORWARD f (FORWARD e x))
   (fun z => BACKWARD e (BACKWARD f z))
   (fun x => TRANS (BACKWARD e (BACKWARD f (FORWARD f (FORWARD e x))))
      (BACKWARD e (FORWARD e x)) x
      (CONGR (fun y => BACKWARD e y) (BACKWARD f (FORWARD f (FORWARD e x)))
        (FORWARD e x) (LEFT f (FORWARD e x))) (LEFT e x))
   (fun z => TRANS (FORWARD f (FORWARD e (BACKWARD e (BACKWARD f z))))
      (FORWARD f (BACKWARD f z)) z
      (CONGR (fun y => FORWARD f y) (FORWARD e (BACKWARD e (BACKWARD f z)))
        (BACKWARD f z) (RIGHT e (BACKWARD f z))) (RIGHT f z))
def inverseStatement : Prop := ∀ (A B : Type) (e : A ≃ B) (y : B),
 FORWARD (INVERSE e) y = BACKWARD e y
def composeStatement : Prop := ∀ (A B C : Type) (e : A ≃ B) (f : B ≃ C) (x : A),
 FORWARD (COMPOSE e f) x = FORWARD f (FORWARD e x)
def roundtripStatement : Prop := ∀ (A B C : Type) (e : A ≃ B) (f : B ≃ C) (x : A),
 BACKWARD (COMPOSE e f) (FORWARD (COMPOSE e f) x) = x
end EquivalenceOperationsOracle
'''
for key,value in keys.items():expected=re.sub(r'\b'+key+r'\b',value,expected)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(name),oracle) for name,oracle in [
 ('equality transitivity','transitivity'),('equivalence left inverse','left'),
 ('equivalence right inverse','right'),('inverse equivalence','inverse'),('compose equivalences','compose')]]
pairs += [('CleanStatements.'+name,oracle) for name,oracle in [
 ('inverse_equivalence_evaluation','inverseStatement'),('composed_equivalence_evaluation','composeStatement'),
 ('composed_equivalence_round_trip','roundtripStatement')]]
s+=expected+comparison+'\n'.join('same_basic_target '+a+' EquivalenceOperationsOracle.'+b for a,b in pairs)+'\n'
s+='''
theorem inverse_evaluation_checked : CleanStatements.inverse_equivalence_evaluation := by
 intro A B e y
 rfl

theorem composition_evaluation_checked : CleanStatements.composed_equivalence_evaluation := by
 intro A B C e f x
 rfl

theorem composition_roundtrip_checked : CleanStatements.composed_equivalence_round_trip := by
 intro A B C e f x
 exact (COMPOSE e f).symm_apply_apply x
'''.replace('COMPOSE',keys['COMPOSE'])
(HERE/'Verified.lean').write_text(s)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(HERE/'Verified.lean')],cwd=ROOT,check=True)
print('Eight exact equivalence-operation targets and three proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
