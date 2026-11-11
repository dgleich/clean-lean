# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Check generated definitions and supporting proofs, not the paper's four theorems."""
import os,sys,subprocess,re
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
e=Environment();rs=load_document(HERE/'Paper.clean',e)
source=lean(rs,e,['Lean'])
(HERE/'Generated.lean').write_text(source)
f=lambda n:e.data['functions'][n]['lean'].split()[0]
proofs='''
namespace LAProofChecks
 theorem rounding_zero : CleanStatements.no_accumulated_rounding_at_zero := by
  intro u
  change (1+u)^(0:Nat)-1 = (0:Real)
  simp
 theorem underflow_zero : CleanStatements.no_accumulated_underflow_at_zero := by
  intro u eta m
  change (0:Real)*eta*(1+((1+u)^m-1))=0
  simp
'''
proofs+=f'''
 theorem dot_model (T : Type) (add mul : T → T → T) (z : T) (x y : List T) :
  @{f('dot')} T add mul z x y = List.foldl add z (List.zipWith mul x y) := by rfl
 theorem sum_model (T : Type) (add : T → T → T) (z : T) (x : List T) :
  @{f('vector sum')} T add z x = List.foldr add z x := by rfl
 theorem matrix_model (T : Type) (add mul : T → T → T) (z : T) (A B : List (List T)) :
  @{f('matrix product')} T add mul z A B =
    A.map (fun row => B.transpose.map (fun col => List.foldl add z (List.zipWith mul row col))) := by rfl
 theorem fused_model (T : Type) (fma : T → T → T → T) (z : T) (x y : List T) :
  @{f('fused dot')} T fma z x y =
    List.foldl (fun s step => step s) z (List.zipWith (fun a b s => fma a b s) x y) := by rfl
 theorem equivalence_model (T : Type) (finite : T → Prop) (value : T → Real) (x y : T) :
  @{f('floating equivalence')} T finite value x y ↔
    (finite x ∧ finite y ∧ value x = value y) ∨ (¬ finite x ∧ ¬ finite y) := by rfl
end LAProofChecks
'''
numerals=re.findall(r'^(?:noncomputable )?def (cleanNumeral_\w+)',source,re.M)
common=['equal','accumulated rounding','accumulated underflow','real difference','real sum','real product','real power','real index']
unfold=', '.join([f(n) for n in common]+numerals)
proofs=proofs.replace('  intro u\n  change (1+u)^(0:Nat)-1 = (0:Real)\n  simp','  simp [CleanStatements.no_accumulated_rounding_at_zero, '+unfold+']')
proofs=proofs.replace('  intro u eta m\n  change (0:Real)*eta*(1+((1+u)^m-1))=0\n  simp','  simp [CleanStatements.no_accumulated_underflow_at_zero, '+unfold+']')
proofs=proofs.replace('(finite x ∧ finite y ∧ value x = value y)', '((finite x ∧ finite y) ∧ value x = value y)')
(HERE/'Verified.lean').write_text(source+proofs)
for filename in ['Generated.lean','Verified.lean']:
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(HERE/filename)],cwd=ROOT,check=True)
print('Generated definitions and two supporting statements checked; seven supporting/agreement proofs passed. Paper theorems remain unproved.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
