# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Independent targets for Clean-authored restricted interval vectors."""
from pathlib import Path
import ast,os,re,runpy,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
e=Environment();results=load_document(HERE/'Statements.clean',e)
f=lambda n:e.data['functions'][n]['lean'].split()[0]
s=lean(results,e,['Lean']);(HERE/'Generated.lean').write_text(s);(HERE/'Statements.tex').write_text(latex(results,e))
keys={k:f(v) for k,v in [('SOURCES','subpath sources preserved'),('TARGETS','subpath targets preserved'),('ZIG','zigzag shape'),('VERTEX','subpath vertex'),('RESTRICT','restricted zigzag'),('SUR','surviving interval labels'),('VALUE','element value'),('MAP','evaluate map'),('VECTORS','restricted interval vectors'),('VANISHES','interval vectors vanish'),('DIRECTIONS','subpath directions'),('LABELRESTRICT','restricted interval labels'),('COMPAT','interval vectors compatible'),('EDGE','subpath edge'),('MAPVALUE','module map value'),('COMPOSE','module composition'),('TRANSPORT','module family transport'),('SOURCE','zigzag source'),('AT','interval labels at')]}
keys.update(DIAGRAM=e.structures['ModuleDiagram']['key'],LABELS=e.structures['IntervalLabels']['key'])
expected=r'''
namespace RestrictedVectorsOracle
noncomputable def vectors {K : Type} (field : Field K)
 (n a m : ℕ) (h : a+m ≤ n) (d : Fin n → Bool)
 (hs : SOURCES n a m h d) (ht : TARGETS n a m h d)
 (Z : DIAGRAM K field (Fin (n+1)) (Fin n) (ZIG n d))
 (I : Type) (L : LABELS I n)
 (vectors : (u : Fin (n+1)) → I → @ModuleCat.carrier K field.toRing (Z.object u)) :
 (v : Fin (m+1)) → {j : I // j ∈ SUR I n a m L} →
   @ModuleCat.carrier K field.toRing ((RESTRICT field n a m h d hs ht Z).object v) :=
 fun v j => MAP (vectors (VERTEX n a m h v)) (VALUE (SUR I n a m L) j)

def valueStatement : Prop := ∀ (K : Type) (field : Field K)
 (n a m : ℕ) (bound : a+m ≤ n) (d : Fin n → Bool)
 (sources : SOURCES n a m bound d) (targets : TARGETS n a m bound d)
 (Z : DIAGRAM K field (Fin (n+1)) (Fin n) (ZIG n d))
 (I : Type) (L : LABELS I n)
 (vectors : (u : Fin (n+1)) → I → @ModuleCat.carrier K field.toRing (Z.object u))
 (v : Fin (m+1)) (j : {j : I // j ∈ SUR I n a m L}),
 VECTORS field n a m bound d sources targets Z I L vectors v j =
   MAP (vectors (VERTEX n a m bound v)) (VALUE (SUR I n a m L) j)
def vanishingStatement : Prop := ∀ (K : Type) (field : Field K)
 (n a m : ℕ) (bound : a+m ≤ n) (d : Fin n → Bool)
 (sources : SOURCES n a m bound d) (targets : TARGETS n a m bound d)
 (Z : DIAGRAM K field (Fin (n+1)) (Fin n) (ZIG n d))
 (I : Type) (L : LABELS I n)
 (vectors : (u : Fin (n+1)) → I → @ModuleCat.carrier K field.toRing (Z.object u))
 (vanishes : VANISHES K field n d Z I L vectors),
 VANISHES K field m (DIRECTIONS n a m bound d)
   (RESTRICT field n a m bound d sources targets Z)
   {j : I // j ∈ SUR I n a m L} (LABELRESTRICT I n a m L)
   (VECTORS field n a m bound d sources targets Z I L vectors)
def compatibleStatement : Prop := ∀ (K : Type) (field : Field K)
 (n a m : ℕ) (bound : a+m ≤ n) (d : Fin n → Bool)
 (sources : SOURCES n a m bound d) (targets : TARGETS n a m bound d)
 (Z : DIAGRAM K field (Fin (n+1)) (Fin n) (ZIG n d))
 (I : Type) (L : LABELS I n)
 (vectors : (u : Fin (n+1)) → I → @ModuleCat.carrier K field.toRing (Z.object u))
 (compatible : COMPAT K field n d Z I L vectors),
 COMPAT K field m (DIRECTIONS n a m bound d)
   (RESTRICT field n a m bound d sources targets Z)
   {j : I // j ∈ SUR I n a m L} (LABELRESTRICT I n a m L)
   (VECTORS field n a m bound d sources targets Z I L vectors)
end RestrictedVectorsOracle
'''
for k,v in keys.items():expected=re.sub(r'\b'+k+r'\b',v,expected)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
s+=expected+comparison+'\nsame_basic_target '+keys['VECTORS']+' RestrictedVectorsOracle.vectors\n'
s+='same_basic_target CleanStatements.restricted_vector_value RestrictedVectorsOracle.valueStatement\n'
s+='same_basic_target CleanStatements.restricted_vectors_vanish RestrictedVectorsOracle.vanishingStatement\n'
s+='same_basic_target CleanStatements.restricted_vectors_compatible RestrictedVectorsOracle.compatibleStatement\n'
s+='''
theorem restricted_vector_value_checked : CleanStatements.restricted_vector_value := by
 intro K field n a m bound d sources targets Z I L vectors v j
 rfl
'''
s+=runpy.run_path(str(HERE/'proof_templates.py'))['render_proofs'](e)
p=HERE/'Verified.lean';p.write_text(s)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Four exact restricted-vector targets; value, vanishing, and compatibility theorems proved')

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
