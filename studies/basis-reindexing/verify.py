# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Independent canonical targets for explicit equivalences and basis reindexing."""
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
e=Environment();results=load_document(HERE/'Statements.clean',e)
f=lambda n:e.data['functions'][n]['lean'].split()[0]
s=lean(results,e,['Lean']);(HERE/'Generated.lean').write_text(s)
(HERE/'Statements.tex').write_text(latex(results,e))
keys={n:f(v) for n,v in [('MAKE','equivalence'),('FORWARD','equivalence forward'),('BACKWARD','equivalence backward'),('IDENTITY','identity equivalence'),('REFL','equality reflexivity'),('REINDEX','reindex module basis'),('VECTOR','module basis vector')]}
expected=r'''
namespace ReindexOracle
noncomputable def equivalenceType (A B : Type) : Type := A ≃ B
noncomputable def make (A B : Type) (f : A → B) (g : B → A)
 (left : ∀ x : A, g (f x) = x) (right : ∀ y : B, f (g y) = y) : A ≃ B :=
 Equiv.mk f g left right
noncomputable def forward {A B : Type} (e : A ≃ B) (x : A) : B := e x
noncomputable def backward {A B : Type} (e : A ≃ B) (y : B) : A := e.symm y
noncomputable def identity (A : Type) : A ≃ A :=
 MAKE A A (fun x => x) (fun y => y) (fun x => REFL x) (fun y => REFL y)
noncomputable def reindex {K I J : Type} (field : Field K)
 (M : @ModuleCat.{0,0} K field.toRing)
 (b : @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule)
 (e : I ≃ J) : @Module.Basis J K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule :=
 letI : Field K := field
 b.reindex e

def vectorStatement : Prop := ∀ (K I J : Type) (field : Field K)
 (M : @ModuleCat.{0,0} K field.toRing)
 (b : @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule)
 (e : I ≃ J) (j : J), VECTOR field M (REINDEX field M b e) j = VECTOR field M b (BACKWARD e j)
def leftStatement : Prop := ∀ (A B : Type) (e : A ≃ B) (x : A), BACKWARD e (FORWARD e x) = x
def rightStatement : Prop := ∀ (A B : Type) (e : A ≃ B) (y : B), FORWARD e (BACKWARD e y) = y
def identityStatement : Prop := ∀ (A : Type) (x : A), FORWARD (IDENTITY A) x = x
end ReindexOracle
'''
for key,value in keys.items():expected=re.sub(r'\b'+key+r'\b',value,expected)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(re.search(r'noncomputable def (cleanType_Equivalence_[0-9a-f]+)',s)[1],'equivalenceType')]
pairs += [(f(n),v) for n,v in [('equivalence','make'),('equivalence forward','forward'),('equivalence backward','backward'),('identity equivalence','identity'),('reindex module basis','reindex')]]
pairs += [('CleanStatements.'+n,v) for n,v in [('reindexed_basis_vector','vectorStatement'),('equivalence_backward_forward','leftStatement'),('equivalence_forward_backward','rightStatement'),('identity_equivalence_fixes_points','identityStatement')]]
s+=expected+comparison+'\n'.join('same_basic_target '+a+' ReindexOracle.'+b for a,b in pairs)+'\n'
s+='''
theorem reindexed_vector_checked : CleanStatements.reindexed_basis_vector := by
 intro K I J field M b e j
 letI : Field K := field
 exact b.reindex_apply e j

theorem equivalence_left_checked : CleanStatements.equivalence_backward_forward := by
 intro A B e x
 exact e.symm_apply_apply x

theorem equivalence_right_checked : CleanStatements.equivalence_forward_backward := by
 intro A B e y
 exact e.apply_symm_apply y

theorem identity_checked : CleanStatements.identity_equivalence_fixes_points := by
 intro A x
 rfl
'''
p=HERE/'Verified.lean';p.write_text(s)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Ten exact reindexing targets and four proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
