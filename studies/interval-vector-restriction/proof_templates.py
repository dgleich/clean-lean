# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Independent native vector proofs instantiated in a checked Clean environment."""
import re

def render_proofs(e):
    f=lambda n:e.data['functions'][n]['lean'].split()[0]
    keys={k:f(v) for k,v in [('VERTEX','subpath vertex'),('DIRECTIONS','subpath directions'),('ZIG','zigzag shape'),('SUR','surviving interval labels'),('AT','interval labels at'),('SOURCE','zigzag source'),('EDGE','subpath edge'),('MAPVALUE','module map value'),('COMPOSE','module composition'),('TRANSPORT','module family transport')]}
    proof=r'''
theorem restricted_vectors_vanish_checked : CleanStatements.restricted_vectors_vanish := by
 intro K field n a m bound d sources targets Z I L vectors vanishes
 intro v j inactive
 apply vanishes (VERTEX n a m bound v) j.val
 intro active
 apply inactive
 simp only [UNFOLD] at active ⊢
 simp only [Fin.val_mk, Fin.coe_natAdd, Fin.coe_castLE, Fin.coe_cast] at *
 omega
'''
    proof+=r'''

private theorem transport_edge_value {K W : Type} (field : Field K)
 (M : W → @ModuleCat.{0,0} K field.toRing) (fs s t ft : W)
 (hs : fs = s) (ht : ft = t) (g : @ModuleCat.Hom K field.toRing (M s) (M t))
 (vectors : (w : W) → @ModuleCat.carrier K field.toRing (M w))
 (law : MAPVALUE field (M s) (M t) g (vectors s) = vectors t) :
 MAPVALUE field (M fs) (M ft)
   (COMPOSE field (M fs) (M t) (M ft)
     (COMPOSE field (M fs) (M s) (M t) (TRANSPORT field M fs s hs) g)
     (TRANSPORT field M t ft ht.symm)) (vectors fs) = vectors ft := by
 cases hs
 cases ht
 simpa [MAPVALUE, COMPOSE, TRANSPORT] using law

theorem restricted_vectors_compatible_checked : CleanStatements.restricted_vectors_compatible := by
 intro K field n a m bound d sources targets Z I L vectors compatible
 intro edge j active
 have old_active : j.val ∈ AT I n L
     (VERTEX n a m bound ((ZIG m (DIRECTIONS n a m bound d)).source edge)) := by
   have survives := j.property
   simp only [UNFOLD, SOURCE, SUR] at active survives ⊢
   simp only [Fin.val_mk, Fin.coe_natAdd, Fin.coe_castLE, Fin.coe_cast] at *
   omega
 have original_active : j.val ∈ AT I n L ((ZIG n d).source (EDGE n a m bound edge)) := by
   rw [← sources edge]
   exact old_active
 exact transport_edge_value field Z.object
   (VERTEX n a m bound ((ZIG m (DIRECTIONS n a m bound d)).source edge))
   ((ZIG n d).source (EDGE n a m bound edge))
   ((ZIG n d).target (EDGE n a m bound edge))
   (VERTEX n a m bound ((ZIG m (DIRECTIONS n a m bound d)).target edge))
   (sources edge) (targets edge) (Z.arrow (EDGE n a m bound edge))
   (fun u => vectors u j.val) (compatible (EDGE n a m bound edge) j.val original_active)
'''
    unfold=[f(n) for n in ['interval labels at','set of','restricted interval labels','interval labels','clipped vertex','natural minimum','bounded vertex','vertex number','subpath vertex','offset vertex','widen vertex','transport vertex','selected value']]
    proof=proof.replace('UNFOLD',', '.join(unfold+['Set.mem_setOf_eq','Fin.le_iff_val_le_val']))
    for k,v in keys.items():proof=re.sub(r'\b'+k+r'\b',v,proof)
    return proof

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
