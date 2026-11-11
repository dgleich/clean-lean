# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Independent canonical targets and proofs for equality-dependent cokernel transport."""
from pathlib import Path
import ast, os, re, subprocess, sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from cleanlang.core import Environment, lean
from cleanlang.modules import load_document
HERE = Path(__file__).resolve().parent
env = Environment()
results = load_document(HERE / 'CokernelTransport.clean', env)
source = lean(results, env, ['Lean'])
(HERE / 'CokernelTransport.lean').write_text(source)
f = lambda n: env.data['functions'][n]['native_binding']
t = lambda n: env.data['types'][n]['native_binding']
mapping = {k:t(n) for k,n in [('TYPE','Type'),('FIELD','FieldStructure'),('CHAIN','ModuleChainComplex'),('MAP','ChainMap'),('MOD','CoefficientModule'),('MMAP','ModuleMap'),('NAT','Natural')]}
mapping.update({k:f(n) for k,n in [('T','chain cokernel transport'),('REV','chain cokernel reverse transport'),('RED','vanishing quotient reduction'),('FWD','vanishing quotient homology forward'),('BACK','vanishing quotient homology backward'),('Q','zero chain quotient'),('RHO','zero quotient reduction'),('COK','chain cokernel'),('PI','chain cokernel projection'),('ZERO','zero chain map'),('H','chain homology'),('HMAP','induced chain homology map'),('COMP','compose chain maps'),('ID','identity chain map'),('MCOMP','module composition'),('MID','module identity'),('EQ','equal'),('SYM','equality symmetry')]})
oracles = '''
namespace TransportOracle
noncomputable def transport {K : Type} (field : FIELD K) (C D : CHAIN K field) (f g : MAP K field C D) (h : EQ f g) : MAP K field (COK field C D f) (COK field C D g) :=
 letI : Field K := field
 (CategoryTheory.Limits.cokernelIsoOfEq h).hom
noncomputable def reverse {K : Type} (field : FIELD K) (C D : CHAIN K field) (f g : MAP K field C D) (h : EQ f g) : MAP K field (COK field C D g) (COK field C D f) := T field C D g f (SYM f g h)
noncomputable def reduction {K : Type} (field : FIELD K) (C D : CHAIN K field) (f : MAP K field C D) (h : EQ f (ZERO field C D)) : MAP K field (COK field C D f) D :=
 COMP field (COK field C D f) (Q field C D) D (RHO field C D) (T field C D f (ZERO field C D) h)
noncomputable def forward {K : Type} (field : FIELD K) (C D : CHAIN K field) (f : MAP K field C D) (h : EQ f (ZERO field C D)) (p : NAT) : MMAP K field (H field (COK field C D f) p) (H field D p) :=
 HMAP field (COK field C D f) D (RED field C D f h) p
noncomputable def backward {K : Type} (field : FIELD K) (C D : CHAIN K field) (f : MAP K field C D) (p : NAT) : MMAP K field (H field D p) (H field (COK field C D f) p) :=
 HMAP field D (COK field C D f) (PI field C D f) p

def left : Prop := ∀ (K : TYPE) (field : FIELD K) (C D : CHAIN K field) (f g : MAP K field C D) (h : EQ f g),
 let q : CHAIN K field := COK field C D f
 let r : CHAIN K field := COK field C D g
 EQ (COMP field q r q (REV field C D f g h) (T field C D f g h)) (ID field q)
def right : Prop := ∀ (K : TYPE) (field : FIELD K) (C D : CHAIN K field) (f g : MAP K field C D) (h : EQ f g),
 let q : CHAIN K field := COK field C D f
 let r : CHAIN K field := COK field C D g
 EQ (COMP field r q r (T field C D f g h) (REV field C D f g h)) (ID field r)
def projection : Prop := ∀ (K : TYPE) (field : FIELD K) (C D : CHAIN K field) (f g : MAP K field C D) (h : EQ f g),
 let q : CHAIN K field := COK field C D f
 let r : CHAIN K field := COK field C D g
 EQ (COMP field D q r (T field C D f g h) (PI field C D f)) (PI field C D g)
def reductionLeft : Prop := ∀ (K : TYPE) (field : FIELD K) (C D : CHAIN K field) (f : MAP K field C D) (h : EQ f (ZERO field C D)),
 let q : CHAIN K field := COK field C D f
 EQ (COMP field D q D (RED field C D f h) (PI field C D f)) (ID field D)
def reductionRight : Prop := ∀ (K : TYPE) (field : FIELD K) (C D : CHAIN K field) (f : MAP K field C D) (h : EQ f (ZERO field C D)),
 let q : CHAIN K field := COK field C D f
 EQ (COMP field q D q (PI field C D f) (RED field C D f h)) (ID field q)
def homologyLeft : Prop := ∀ (K : TYPE) (field : FIELD K) (C D : CHAIN K field) (f : MAP K field C D) (h : EQ f (ZERO field C D)) (p : NAT),
 let m : MOD K field := H field D p
 let n : MOD K field := H field (COK field C D f) p
 EQ (MCOMP field m n m (BACK field C D f p) (FWD field C D f h p)) (MID field m)
def homologyRight : Prop := ∀ (K : TYPE) (field : FIELD K) (C D : CHAIN K field) (f : MAP K field C D) (h : EQ f (ZERO field C D)) (p : NAT),
 let m : MOD K field := H field D p
 let n : MOD K field := H field (COK field C D f) p
 EQ (MCOMP field n m n (FWD field C D f h p) (BACK field C D f p)) (MID field n)
end TransportOracle
open CategoryTheory CategoryTheory.Limits

theorem transportLeft : CleanStatements.cokernel_reverse_after_transport := by
 intro K field C D f g h
 letI : Field K := field
 change (cokernelIsoOfEq h).hom ≫ (cokernelIsoOfEq h.symm).hom = 𝟙 (cokernel f)
 subst g
 simp

theorem transportRight : CleanStatements.cokernel_transport_after_reverse := by
 intro K field C D f g h
 letI : Field K := field
 change (cokernelIsoOfEq h.symm).hom ≫ (cokernelIsoOfEq h).hom = 𝟙 (cokernel g)
 subst g
 simp

theorem transportProjection : CleanStatements.cokernel_transport_preserves_projection := by
 intro K field C D f g h
 letI : Field K := field
 exact π_comp_cokernelIsoOfEq_hom h

theorem reductionLeft : CleanStatements.vanishing_reduction_after_projection := by
 intro K field C D f h
 letI : Field K := field
 change f = (0 : C ⟶ D) at h
 change cokernel.π f ≫ ((cokernelIsoOfEq h).hom ≫ (cokernelZeroIsoTarget (X := C) (Y := D)).hom) = 𝟙 D
 rw [← Category.assoc, π_comp_cokernelIsoOfEq_hom]
 exact (cokernelZeroIsoTarget (X := C) (Y := D)).inv_hom_id

theorem reductionRight : CleanStatements.vanishing_projection_after_reduction := by
 intro K field C D f h
 letI : Field K := field
 change f = (0 : C ⟶ D) at h
 change ((cokernelIsoOfEq h).hom ≫ (cokernelZeroIsoTarget (X := C) (Y := D)).hom) ≫ cokernel.π f = 𝟙 (cokernel f)
 subst f
 simp only [cokernelIsoOfEq_refl, Iso.refl_hom, Category.id_comp]
 exact (cokernelZeroIsoTarget (X := C) (Y := D)).hom_inv_id

theorem homologyLeft : CleanStatements.vanishing_homology_forward_after_backward := by
 intro K field C D f h p
 letI : Field K := field
 let Hf := HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) p
 change Hf.map (PI field C D f) ≫ Hf.map (RED field C D f h) = 𝟙 (Hf.obj D)
 rw [← Hf.map_comp, ← Hf.map_id]
 exact congrArg Hf.map (reductionLeft K field C D f h)

theorem homologyRight : CleanStatements.vanishing_homology_backward_after_forward := by
 intro K field C D f h p
 letI : Field K := field
 let Hf := HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) p
 change Hf.map (RED field C D f h) ≫ Hf.map (PI field C D f) = 𝟙 (Hf.obj (COK field C D f))
 rw [← Hf.map_comp, ← Hf.map_id]
 exact congrArg Hf.map (reductionRight K field C D f h)
'''
for key,value in mapping.items():
 oracles = re.sub(r'\b'+key+r'\b', value, oracles)
comparison = next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs = [(f(n),'TransportOracle.'+o) for n,o in [('chain cokernel transport','transport'),('chain cokernel reverse transport','reverse'),('vanishing quotient reduction','reduction'),('vanishing quotient homology forward','forward'),('vanishing quotient homology backward','backward')]]
pairs += [('CleanStatements.'+n,'TransportOracle.'+o) for n,o in [('cokernel_reverse_after_transport','left'),('cokernel_transport_after_reverse','right'),('cokernel_transport_preserves_projection','projection'),('vanishing_reduction_after_projection','reductionLeft'),('vanishing_projection_after_reduction','reductionRight'),('vanishing_homology_forward_after_backward','homologyLeft'),('vanishing_homology_backward_after_forward','homologyRight')]]
path = HERE/'CokernelTransportVerified.lean'
path.write_text(source+oracles+comparison+'\n'.join('same_basic_target '+a+' '+b for a,b in pairs)+'\n')
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Twelve exact targets and seven transport/inverse proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
