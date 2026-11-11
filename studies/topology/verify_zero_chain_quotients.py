# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Zero cokernel comparison: exact targets and inverse chain/homology maps."""
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'ZeroChainQuotients.clean',env)
source=lean(results,env,['Lean']);(HERE/'ZeroChainQuotients.lean').write_text(source)
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
mapping={k:t(n) for k,n in [('TYPE','Type'),('FIELD','FieldStructure'),('CHAIN','ModuleChainComplex'),('MAP','ChainMap'),('MOD','CoefficientModule'),('MMAP','ModuleMap'),('NAT','Natural')]}
mapping.update({k:f(n) for k,n in [('Q','zero chain quotient'),('PI','zero quotient projection'),('RHO','zero quotient reduction'),('FORWARD','zero quotient homology forward'),('BACKWARD','zero quotient homology backward'),('COK','chain cokernel'),('COKPI','chain cokernel projection'),('ZERO','zero chain map'),('H','chain homology'),('HMAP','induced chain homology map'),('CCOMP','compose chain maps'),('CID','identity chain map'),('MCOMP','module composition'),('MID','module identity'),('EQ','equal')]})
oracles='''
namespace ZeroQuotientOracle
noncomputable def quotient {K : Type} (field : FIELD K) (C D : CHAIN K field) : CHAIN K field := COK field C D (ZERO field C D)
noncomputable def projection {K : Type} (field : FIELD K) (C D : CHAIN K field) : MAP K field D (Q field C D) := COKPI field C D (ZERO field C D)
noncomputable def reduction {K : Type} (field : FIELD K) (C D : CHAIN K field) : MAP K field (Q field C D) D :=
 letI : Field K := field
 (CategoryTheory.Limits.cokernelZeroIsoTarget (X := C) (Y := D)).hom
noncomputable def forward {K : Type} (field : FIELD K) (C D : CHAIN K field) (p : NAT) : MMAP K field (H field (Q field C D) p) (H field D p) := HMAP field (Q field C D) D (RHO field C D) p
noncomputable def backward {K : Type} (field : FIELD K) (C D : CHAIN K field) (p : NAT) : MMAP K field (H field D p) (H field (Q field C D) p) := HMAP field D (Q field C D) (PI field C D) p

def chainLeft : Prop := ∀ (K : TYPE) (field : FIELD K) (C D : CHAIN K field),
 let q : CHAIN K field := Q field C D
 EQ (CCOMP field D q D (RHO field C D) (PI field C D)) (CID field D)
def chainRight : Prop := ∀ (K : TYPE) (field : FIELD K) (C D : CHAIN K field),
 let q : CHAIN K field := Q field C D
 EQ (CCOMP field q D q (PI field C D) (RHO field C D)) (CID field q)
def homologyLeft : Prop := ∀ (K : TYPE) (field : FIELD K) (C D : CHAIN K field) (p : NAT),
 let m : MOD K field := H field D p
 let n : MOD K field := H field (Q field C D) p
 EQ (MCOMP field m n m (BACKWARD field C D p) (FORWARD field C D p)) (MID field m)
def homologyRight : Prop := ∀ (K : TYPE) (field : FIELD K) (C D : CHAIN K field) (p : NAT),
 let m : MOD K field := H field D p
 let n : MOD K field := H field (Q field C D) p
 EQ (MCOMP field n m n (FORWARD field C D p) (BACKWARD field C D p)) (MID field n)
end ZeroQuotientOracle

open CategoryTheory CategoryTheory.Limits

theorem chainLeftInverse : CleanStatements.zero_quotient_reduction_after_projection := by
 intro K field C D
 letI : Field K := field
 exact (cokernelZeroIsoTarget (X := C) (Y := D)).inv_hom_id

theorem chainRightInverse : CleanStatements.zero_quotient_projection_after_reduction := by
 intro K field C D
 letI : Field K := field
 exact (cokernelZeroIsoTarget (X := C) (Y := D)).hom_inv_id

theorem homologyLeftInverse : CleanStatements.zero_quotient_homology_forward_after_backward := by
 intro K field C D p
 letI : Field K := field
 exact ((HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) p).mapIso (cokernelZeroIsoTarget (X := C) (Y := D))).inv_hom_id

theorem homologyRightInverse : CleanStatements.zero_quotient_homology_backward_after_forward := by
 intro K field C D p
 letI : Field K := field
 exact ((HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) p).mapIso (cokernelZeroIsoTarget (X := C) (Y := D))).hom_inv_id
'''
for key,value in mapping.items():oracles=re.sub(r'\b'+key+r'\b',value,oracles)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(n),'ZeroQuotientOracle.'+o) for n,o in [('zero chain quotient','quotient'),('zero quotient projection','projection'),('zero quotient reduction','reduction'),('zero quotient homology forward','forward'),('zero quotient homology backward','backward')]]
pairs += [('CleanStatements.'+n,'ZeroQuotientOracle.'+o) for n,o in [('zero_quotient_reduction_after_projection','chainLeft'),('zero_quotient_projection_after_reduction','chainRight'),('zero_quotient_homology_forward_after_backward','homologyLeft'),('zero_quotient_homology_backward_after_forward','homologyRight')]]
path=HERE/'ZeroChainQuotientsVerified.lean';path.write_text(source+oracles+comparison+'\n'.join('same_basic_target '+a+' '+b for a,b in pairs)+'\n')
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Nine exact targets and four inverse-map proofs passed; empty-subspace chain identification remains pending.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
