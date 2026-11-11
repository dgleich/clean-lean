# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Canonical relative/ordinary composites and inverse proofs."""
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'RelativeOrdinaryComparison.clean',env)
source=lean(results,env,['Lean']);(HERE/'RelativeOrdinaryComparison.lean').write_text(source)
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
mapping={k:t(n) for k,n in [('TYPE','Type'),('FIELD','FieldStructure'),('SPACE','TopologicalSpace'),('MOD','CoefficientModule'),('MMAP','ModuleMap')]}
mapping.update({k:env.structures[n]['key'] for k,n in [('THEORY','HomologyTheory'),('PAIR','TopologicalPair')]})
mapping.update({k:f(n) for k,n in [('FWD','relative to ordinary homology'),('BACK','ordinary to relative homology'),('REL','relative homology'),('ORD','homology module'),('CH','chain homology'),('CHAINS','singular chains'),('SUB','subspace'),('INC','pair chain inclusion'),('ZERO','zero chain map'),('VF','vanishing quotient homology forward'),('VB','vanishing quotient homology backward'),('SF','singular homology comparison'),('SB','singular homology comparison inverse'),('COMP','module composition'),('ID','module identity'),('EQ','equal'),('RED','vanishing quotient reduction'),('PI','chain cokernel projection')]})
oracles='''
namespace RelativeOrdinaryOracle
noncomputable def forward {K : Type} (field : FIELD K) (H : THEORY K field) (X : SPACE) (Q : PAIR X)
 (h : EQ (INC field H X Q) (ZERO field (CHAINS field H (SUB X Q.relative)) (CHAINS field H (SUB X Q.ambient)))) :
 MMAP K field (REL field H X Q) (ORD field H (SUB X Q.ambient)) :=
 COMP field (REL field H X Q) (CH field (CHAINS field H (SUB X Q.ambient)) H.degree) (ORD field H (SUB X Q.ambient))
 (VF field (CHAINS field H (SUB X Q.relative)) (CHAINS field H (SUB X Q.ambient)) (INC field H X Q) h H.degree)
 (SF field H (SUB X Q.ambient))
noncomputable def backward {K : Type} (field : FIELD K) (H : THEORY K field) (X : SPACE) (Q : PAIR X) :
 MMAP K field (ORD field H (SUB X Q.ambient)) (REL field H X Q) :=
 COMP field (ORD field H (SUB X Q.ambient)) (CH field (CHAINS field H (SUB X Q.ambient)) H.degree) (REL field H X Q)
 (SB field H (SUB X Q.ambient))
 (VB field (CHAINS field H (SUB X Q.relative)) (CHAINS field H (SUB X Q.ambient)) (INC field H X Q) H.degree)
'''
for name,conclusion in [('left','EQ (COMP field m n m (FWD field H X Q h) (BACK field H X Q)) (ID field m)'),('right','EQ (COMP field n m n (BACK field H X Q) (FWD field H X Q h)) (ID field n)')]:
 oracles+=f'''\ndef {name} : Prop := ∀ (K : TYPE) (field : FIELD K) (H : THEORY K field) (X : SPACE) (Q : PAIR X)
 (h : EQ (INC field H X Q) (ZERO field (CHAINS field H (SUB X Q.relative)) (CHAINS field H (SUB X Q.ambient)))),
 let m : MOD K field := REL field H X Q
 let n : MOD K field := ORD field H (SUB X Q.ambient)
 {conclusion}
'''
oracles+='''
end RelativeOrdinaryOracle
open CategoryTheory CategoryTheory.Limits

-- Generic chain-level identities used to verify the actual composites below.
theorem reductionProjection {K : Type} [Field K]
 (C D : ChainComplex (ModuleCat.{0} K) ℕ) (f : C ⟶ D) (h : f = 0) :
 ((cokernelIsoOfEq h).hom ≫ (cokernelZeroIsoTarget (X := C) (Y := D)).hom) ≫ cokernel.π f = 𝟙 (cokernel f) := by
 subst f
 simp only [cokernelIsoOfEq_refl, Iso.refl_hom, Category.id_comp]
 exact (cokernelZeroIsoTarget (X := C) (Y := D)).hom_inv_id

theorem projectionReduction {K : Type} [Field K]
 (C D : ChainComplex (ModuleCat.{0} K) ℕ) (f : C ⟶ D) (h : f = 0) :
 cokernel.π f ≫ ((cokernelIsoOfEq h).hom ≫ (cokernelZeroIsoTarget (X := C) (Y := D)).hom) = 𝟙 D := by
 rw [← Category.assoc, π_comp_cokernelIsoOfEq_hom]
 exact (cokernelZeroIsoTarget (X := C) (Y := D)).inv_hom_id

theorem relativeOrdinaryLeft : CleanStatements.ordinary_after_relative_comparison := by
 intro K field H X Q h
 letI : Field K := field
 let C := CHAINS field H (SUB X Q.relative)
 let D := CHAINS field H (SUB X Q.ambient)
 let i : C ⟶ D := INC field H X Q
 let HF := HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) H.degree
 change (HF.map (RED field C D i h) ≫ 𝟙 (HF.obj D)) ≫ (𝟙 (HF.obj D) ≫ HF.map (PI field C D i)) = 𝟙 (HF.obj (cokernel i))
 simp only [Category.comp_id, Category.id_comp]
 rw [← HF.map_comp, ← HF.map_id]
 exact congrArg HF.map (reductionProjection C D i h)

theorem relativeOrdinaryRight : CleanStatements.relative_after_ordinary_comparison := by
 intro K field H X Q h
 letI : Field K := field
 let C := CHAINS field H (SUB X Q.relative)
 let D := CHAINS field H (SUB X Q.ambient)
 let i : C ⟶ D := INC field H X Q
 let HF := HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) H.degree
 change (𝟙 (HF.obj D) ≫ HF.map (PI field C D i)) ≫ (HF.map (RED field C D i h) ≫ 𝟙 (HF.obj D)) = 𝟙 (HF.obj D)
 simp only [Category.comp_id, Category.id_comp]
 rw [← HF.map_comp, ← HF.map_id]
 exact congrArg HF.map (projectionReduction C D i h)
'''
for key,value in mapping.items():oracles=re.sub(r'\b'+key+r'\b',value,oracles)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(n),'RelativeOrdinaryOracle.'+o) for n,o in [('relative to ordinary homology','forward'),('ordinary to relative homology','backward')]]
pairs += [('CleanStatements.'+n,'RelativeOrdinaryOracle.'+o) for n,o in [('ordinary_after_relative_comparison','left'),('relative_after_ordinary_comparison','right')]]
path=HERE/'RelativeOrdinaryComparisonVerified.lean';path.write_text(source+oracles+comparison+'\n'.join('same_basic_target '+a+' '+b for a,b in pairs)+'\n')
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Four exact targets and two comparison inverse proofs (plus two chain helper lemmas) passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
