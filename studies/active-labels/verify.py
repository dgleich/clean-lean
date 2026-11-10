# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Canonical targets and arithmetic construction of the active-label equivalence."""
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
snapshot_only=sys.argv[1:]==['--from-generated']
if sys.argv[1:] and not snapshot_only:raise SystemExit('Usage: verify.py [--from-generated]')
if snapshot_only:
    s=(HERE/'Generated.lean').read_text()
else:
    e=Environment();results=load_document(HERE/'Statements.clean',e)
    s=lean(results,e,['Lean']);(HERE/'Generated.lean').write_text(s)
    (HERE/'Statements.tex').write_text(latex(results,e))
def emitted_key(name,structure=False):
    prefix='structure (cleanStructure_' if structure else r'noncomputable def (clean(?:Notation|Define|Constructor)_'
    matches=re.findall(prefix+re.escape(name.replace(' ','_'))+r'_[0-9a-f]+)\b',s)
    if len(matches)!=1:raise ValueError('Expected exactly one generated binding for '+name)
    return matches[0]
f=emitted_key
keys={k:f(v) for k,v in [('VALUE','element value'),('MEMBER','element membership'),('ELEMENT','element from membership'),('OLD','original active labels'),('NEW','restricted active labels'),('SUR','surviving interval labels'),('AT','interval labels at'),('RESTRICT','restricted interval labels'),('SUBPATH','subpath vertex'),('FORWARD','restrict active label'),('BACKWARD','restore active label'),('EQUIV','equivalence'),('LABEL_EQUIV','active label equivalence'),('EVAL','equivalence forward')]}
keys.update({k:f(v) for k,v in [('GFORWARD','restrict element'),('GBACKWARD','restore element'),('GEQUIV','subtype restriction equivalence')]})
keys.update(LABELS=emitted_key('IntervalLabels',True),SUPPORT=emitted_key('SubtypeRestrictionSupport',True))
# Raw native arithmetic foundation retained for verify_arithmetic.py only.
# Canonical target expectations below come from the independent wrapper templates.
ARITHMETIC_EXPECTED=r'''
namespace ActiveOracle
noncomputable def value {A : Type} (S : Set A) (x : {a : A // a ∈ S}) : A := x.val
noncomputable def member {A : Type} (S : Set A) (x : {a : A // a ∈ S}) : VALUE S x ∈ S := x.property
noncomputable def element {A : Type} (S : Set A) (x : A) (h : x ∈ S) : {a : A // a ∈ S} := Subtype.mk x h
noncomputable def old (I : Type) (n a m : ℕ) (h : a+m ≤ n) (L : LABELS I n) (v : Fin (m+1)) : Set I :=
 AT I n L (SUBPATH n a m h v)
noncomputable def new (I : Type) (n a m : ℕ) (L : LABELS I n) (v : Fin (m+1)) : Set {i : I // i ∈ SUR I n a m L} :=
 AT {i : I // i ∈ SUR I n a m L} m (RESTRICT I n a m L) v
noncomputable def supportConstructor {A : Type} {S T : Set A} {U : Set {i : A // i ∈ S}}
 (survives : ∀ x : {i : A // i ∈ T}, VALUE T x ∈ S)
 (active : ∀ x : {i : A // i ∈ T}, ELEMENT S (VALUE T x) (survives x) ∈ U)
 (original : ∀ y : {j : {i : A // i ∈ S} // j ∈ U}, VALUE S (VALUE U y) ∈ T) : SUPPORT A S T U :=
 ⟨survives,active,original⟩
noncomputable def genericForward (A : Type) (S T : Set A) (U : Set {i : A // i ∈ S})
 (support : SUPPORT A S T U) (x : {i : A // i ∈ T}) : {j : {i : A // i ∈ S} // j ∈ U} :=
 ELEMENT U (ELEMENT S (VALUE T x) (support.survives x)) (support.active x)
noncomputable def genericBackward (A : Type) (S T : Set A) (U : Set {i : A // i ∈ S})
 (support : SUPPORT A S T U) (y : {j : {i : A // i ∈ S} // j ∈ U}) : {i : A // i ∈ T} :=
 ELEMENT T (VALUE S (VALUE U y)) (support.original y)
noncomputable def genericEquivalence (A : Type) (S T : Set A) (U : Set {i : A // i ∈ S})
 (support : SUPPORT A S T U)
 (left : ∀ x : {i : A // i ∈ T}, GBACKWARD A S T U support (GFORWARD A S T U support x) = x)
 (right : ∀ y : {j : {i : A // i ∈ S} // j ∈ U}, GFORWARD A S T U support (GBACKWARD A S T U support y) = y) :
 {i : A // i ∈ T} ≃ {j : {i : A // i ∈ S} // j ∈ U} :=
 EQUIV {i : A // i ∈ T} {j : {i : A // i ∈ S} // j ∈ U}
   (fun x => GFORWARD A S T U support x) (fun y => GBACKWARD A S T U support y) left right
noncomputable def forward (I : Type) (n a m : ℕ) (h : a+m ≤ n) (L : LABELS I n) (v : Fin (m+1))
 (support : SUPPORT I n a m h L v) (x : {i : I // i ∈ OLD I n a m h L v}) :
 {j : {i : I // i ∈ SUR I n a m L} // j ∈ NEW I n a m L v} :=
 GFORWARD I (SUR I n a m L) (OLD I n a m h L v) (NEW I n a m L v) support x
noncomputable def backward (I : Type) (n a m : ℕ) (h : a+m ≤ n) (L : LABELS I n) (v : Fin (m+1))
 (support : SUPPORT I n a m h L v) (y : {j : {i : I // i ∈ SUR I n a m L} // j ∈ NEW I n a m L v}) :
 {i : I // i ∈ OLD I n a m h L v} :=
 GBACKWARD I (SUR I n a m L) (OLD I n a m h L v) (NEW I n a m L v) support y
noncomputable def equivalence (I : Type) (n a m : ℕ) (h : a+m ≤ n) (L : LABELS I n) (v : Fin (m+1))
 (support : SUPPORT I n a m h L v)
 (left : ∀ x : {i : I // i ∈ OLD I n a m h L v}, BACKWARD I n a m h L v support (FORWARD I n a m h L v support x) = x)
 (right : ∀ y : {j : {i : I // i ∈ SUR I n a m L} // j ∈ NEW I n a m L v}, FORWARD I n a m h L v support (BACKWARD I n a m h L v support y) = y) :
 {i : I // i ∈ OLD I n a m h L v} ≃ {j : {i : I // i ∈ SUR I n a m L} // j ∈ NEW I n a m L v} :=
 GEQUIV I (SUR I n a m L) (OLD I n a m h L v) (NEW I n a m L v) support left right

def leftStatement : Prop := ∀ (I : Type) (n a m : ℕ) (h : a+m ≤ n) (L : LABELS I n) (v : Fin (m+1))
 (support : SUPPORT I n a m h L v) (x : {i : I // i ∈ OLD I n a m h L v}),
 BACKWARD I n a m h L v support (FORWARD I n a m h L v support x) = x
def rightStatement : Prop := ∀ (I : Type) (n a m : ℕ) (h : a+m ≤ n) (L : LABELS I n) (v : Fin (m+1))
 (support : SUPPORT I n a m h L v) (y : {j : {i : I // i ∈ SUR I n a m L} // j ∈ NEW I n a m L v}),
 FORWARD I n a m h L v support (BACKWARD I n a m h L v support y) = y
def existsStatement : Prop := ∀ (I : Type) (n a m : ℕ) (h : a+m ≤ n) (L : LABELS I n) (v : Fin (m+1)),
 ∃ e : {i : I // i ∈ OLD I n a m h L v} ≃ {j : {i : I // i ∈ SUR I n a m L} // j ∈ NEW I n a m L v},
 ∀ x : {i : I // i ∈ OLD I n a m h L v},
 VALUE (SUR I n a m L) (VALUE (NEW I n a m L v) (EVAL e x)) = VALUE (OLD I n a m h L v) x
end ActiveOracle
'''
def emitted_type(name, prefix='cleanType_'):
    matches=set(re.findall(r'\b'+prefix+re.escape(name)+r'_[0-9a-f]+\b',s))
    if len(matches)!=1:raise ValueError('Expected exactly one binding for '+name)
    return next(iter(matches))
keys.update({k:emitted_type(n) for k,n in [('TYPE','Type'),('NAT','Natural'),
    ('VERTEX','Vertex'),('SET','Set'),('EL','Element'),('EQUIVALENCE','Equivalence')]})
keys.update({k:f(n) for k,n in [('MEM','set member'),('EQ','equal'),
    ('LE','natural at most'),('ADD','natural sum')]})
keys['NUM']=emitted_type('Natural','cleanNumeral_')
expected=(HERE/'GenericOracle.lean.in').read_text()+(HERE/'ActiveOracle.lean.in').read_text()
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(n),v) for n,v in [('element value','value'),('element membership','member'),('element from membership','element'),('original active labels','old'),('restricted active labels','new'),('restrict active label','forward'),('restore active label','backward'),('active label equivalence','equivalence'),('restrict element','genericForward'),('restore element','genericBackward'),('subtype restriction equivalence','genericEquivalence')]]
pairs += [('CleanStatements.'+n,v) for n,v in [('restoring_a_restricted_label','leftStatement'),('restricting_a_restored_label','rightStatement'),('active_labels_correspond','existsStatement')]]
generic={'value','member','element','genericForward','genericBackward','genericEquivalence'}
checks='\n'.join('same_basic_target '+a+(' GenericOracle.' if b in generic else ' ActiveOracle.')+b for a,b in pairs)+'\n'
ctor_check=r'''
run_cmd do
 let env ← Lean.getEnv
 let some a := env.find? `SUPPORT.mk | throwError "Missing support constructor"
 let some b := env.find? `GenericOracle.supportConstructor | throwError "Missing expected constructor"
 unless a.levelParams == b.levelParams && Lean.Expr.equal (canonical a.type) (canonical b.type) do
   throwError "Support constructor type differs"
'''
proofs=r'''
theorem restore_checked : CleanStatements.restoring_a_restricted_label := by
 intro I n a m h L v support x
 apply Subtype.ext
 rfl

theorem restrict_checked : CleanStatements.restricting_a_restored_label := by
 intro I n a m h L v support y
 apply Subtype.ext
 apply Subtype.ext
 rfl

theorem active_labels_checked : CleanStatements.active_labels_correspond := by
 intro I n a m h L v
 obtain ⟨support⟩ := support_exists I n a m h L v
 refine ⟨LABEL_EQUIV I n a m h L v support
   (fun x => restore_checked I n a m h L v support x)
   (fun y => restrict_checked I n a m h L v support y), ?_⟩
 intro x
 rfl
'''
proofs=(HERE/'ArithmeticSupport.lean.in').read_text()+proofs
unfold=[f(n) for n in ['original active labels','restricted active labels','surviving interval labels','interval labels at','set of','restricted interval labels','interval labels','clipped vertex','natural minimum','bounded vertex','vertex number','subpath vertex','offset vertex','widen vertex','transport vertex','selected value','element value','element from membership']]
unfold += [f(n) for n in ['set member','conjunction','natural sum','natural difference','natural at most','vertex at most']]
unfold += [keys['NUM']]
proofs=proofs.replace('UNFOLD',', '.join(unfold+['Set.mem_setOf_eq','Fin.le_iff_val_le_val']))
extra=expected+comparison+checks+ctor_check+proofs
extra=extra.replace('SUPPORT I n a m h L v','SUPPORT I (SUR I n a m L) (OLD I n a m h L v) (NEW I n a m L v)').replace('SUPPORT.mk I n a m h L v','SUPPORT.mk I (SUR I n a m L) (OLD I n a m h L v) (NEW I n a m L v)')
for key,value in keys.items():extra=re.sub(r'\b'+key+r'\b',value,extra)
p=HERE/'Verified.lean';p.write_text(s+extra)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Fifteen exact active-label checks and four proofs passed'+
      (' for the existing Generated.lean snapshot; current Clean source was not retranslated' if snapshot_only else ''))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
