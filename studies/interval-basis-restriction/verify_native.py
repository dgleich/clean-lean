# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Native counterpart; full Clean statement translation is a separate pending check."""
from pathlib import Path
import hashlib,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import normalize_layout
from cleanlang.syntax import document
document(normalize_layout((HERE/'Statements.clean').read_text()))
print('Clean statement syntax passed; binding/type/target checks remain pending',flush=True)
source=ROOT/'studies/active-labels/Arithmetic.lean'
s=source.read_text()
def key(pattern):
    matches=re.findall(pattern,s)
    if len(matches)!=1:raise ValueError('Expected one generated foundation binding: '+pattern)
    return matches[0]
keys={
 'LABELS':key(r'structure (cleanStructure_IntervalLabels_[0-9a-f]+)'),
 'SUR':key(r'noncomputable def (cleanDefine_surviving_interval_labels_[0-9a-f]+)'),
 'VALUE':key(r'noncomputable def (cleanNotation_element_value_[0-9a-f]+)'),
 'EVAL':key(r'noncomputable def (cleanNotation_equivalence_forward_[0-9a-f]+)')}
extra=r'''
namespace RestrictedBasis

-- The original basis is indexed by labels active at the embedded vertex.
-- Its vectors are the given interval vectors at those underlying labels.
theorem exists_basis_at_restricted_vertex
    {K : Type} [Field K] (M : ModuleCat K)
    (I : Type) (n a m : ℕ) (bound : a+m ≤ n)
    (L : LABELS I n) (v : Fin (m+1))
    (b : Module.Basis {i : I // i ∈ Arithmetic.old I n a m bound L v} K M)
    (vectors : I → M)
    (realizes : ∀ x : {i : I // i ∈ Arithmetic.old I n a m bound L v}, b x = vectors x.val) :
    ∃ c : Module.Basis
      {j : {i : I // i ∈ SUR I n a m L} // j ∈ Arithmetic.new I n a m L v} K M,
      ∀ y, c y = vectors y.val.val := by
  obtain ⟨e, preserves⟩ := Arithmetic.active_labels_exist I n a m bound L v
  refine ⟨b.reindex e, ?_⟩
  intro y
  have label_eq := preserves (e.symm y)
  simp only [VALUE, EVAL, Equiv.apply_symm_apply] at label_eq
  calc
    (b.reindex e) y = b (e.symm y) := b.reindex_apply e y
    _ = vectors (e.symm y).val := realizes (e.symm y)
    _ = vectors y.val.val := congrArg vectors label_eq.symm

end RestrictedBasis
'''
for name,value in keys.items():extra=re.sub(r'\b'+name+r'\b',value,extra)
p=HERE/'Native.lean'
p.write_text('-- Native arithmetic input SHA256: '+hashlib.sha256(source.read_bytes()).hexdigest()+'\n'+s+extra)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Native restricted-vertex basis existence and vector formula passed; Clean target comparison remains pending')

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
