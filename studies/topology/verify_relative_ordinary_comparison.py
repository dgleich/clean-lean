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
mapping['PAIRINC']=env.structures['PairInclusion']['key']
mapping.update({k:f(n) for k,n in [('SQUARE','pair chain commutes'),('RMAP','relative homology map'),('OMAP','homology linear map'),('AMBIENT','ambient continuous map'),('ACHAIN','ambient chain map'),('RCHAIN','relative subset chain map')]})
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
def natural : Prop := ∀ (K : TYPE) (field : FIELD K) (H : THEORY K field) (X : SPACE) (Q : PAIRINC X)
 (square : SQUARE field H X Q)
 (sourceZero : EQ (INC field H X Q.source) (ZERO field (CHAINS field H (SUB X Q.source.relative)) (CHAINS field H (SUB X Q.source.ambient))))
 (targetZero : EQ (INC field H X Q.target) (ZERO field (CHAINS field H (SUB X Q.target.relative)) (CHAINS field H (SUB X Q.target.ambient)))),
 let m : MOD K field := REL field H X Q.source
 let n : MOD K field := REL field H X Q.target
 let u : MOD K field := ORD field H (SUB X Q.source.ambient)
 let v : MOD K field := ORD field H (SUB X Q.target.ambient)
 EQ (COMP field m n v (RMAP field H X Q square) (FWD field H X Q.target targetZero))
    (COMP field m u v (FWD field H X Q.source sourceZero) (OMAP field H (SUB X Q.source.ambient) (SUB X Q.target.ambient) (AMBIENT X Q)))
def inverseNatural : Prop := ∀ (K : TYPE) (field : FIELD K) (H : THEORY K field) (X : SPACE) (Q : PAIRINC X)
 (square : SQUARE field H X Q),
 let m : MOD K field := REL field H X Q.source
 let n : MOD K field := REL field H X Q.target
 let u : MOD K field := ORD field H (SUB X Q.source.ambient)
 let v : MOD K field := ORD field H (SUB X Q.target.ambient)
 EQ (COMP field u m n (BACK field H X Q.source) (RMAP field H X Q square))
    (COMP field u v n (OMAP field H (SUB X Q.source.ambient) (SUB X Q.target.ambient) (AMBIENT X Q)) (BACK field H X Q.target))
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
oracles += '''
-- The canonical cokernel map commutes with the vanishing-map reductions.
theorem reductionNatural {K : Type} [Field K]
 (C D E F : ChainComplex (ModuleCat.{0} K) ℕ)
 (f : C ⟶ D) (g : E ⟶ F) (u : C ⟶ E) (v : D ⟶ F)
 (square : f ≫ v = u ≫ g) (hf : f = 0) (hg : g = 0) :
 cokernel.map f g u v square ≫ ((cokernelIsoOfEq hg).hom ≫ (cokernelZeroIsoTarget (X := E) (Y := F)).hom) =
 ((cokernelIsoOfEq hf).hom ≫ (cokernelZeroIsoTarget (X := C) (Y := D)).hom) ≫ v := by
 apply (cancel_epi (cokernel.π f)).1
 calc
  _ = (cokernel.π f ≫ cokernel.map f g u v square) ≫ ((cokernelIsoOfEq hg).hom ≫ (cokernelZeroIsoTarget (X := E) (Y := F)).hom) := (Category.assoc _ _ _).symm
  _ = (v ≫ cokernel.π g) ≫ ((cokernelIsoOfEq hg).hom ≫ (cokernelZeroIsoTarget (X := E) (Y := F)).hom) := by rw [cokernel.π_desc]
  _ = v := by rw [Category.assoc, projectionReduction E F g hg, Category.comp_id]
  _ = _ := by rw [← Category.assoc, projectionReduction C D f hf, Category.id_comp]

theorem relativeOrdinaryNatural : CleanStatements.relative_to_ordinary_comparison_commutes := by
 intro K field H X Q square sourceZero targetZero
 letI : Field K := field
 let C := CHAINS field H (SUB X Q.source.relative)
 let D := CHAINS field H (SUB X Q.source.ambient)
 let E := CHAINS field H (SUB X Q.target.relative)
 let F := CHAINS field H (SUB X Q.target.ambient)
 let i : C ⟶ D := INC field H X Q.source
 let j : E ⟶ F := INC field H X Q.target
 let u : C ⟶ E := RCHAIN field H X Q
 let v : D ⟶ F := ACHAIN field H X Q
 let HF := HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) H.degree
 change HF.map (cokernel.map i j u v square) ≫ (HF.map (RED field E F j targetZero) ≫ 𝟙 (HF.obj F)) = (HF.map (RED field C D i sourceZero) ≫ 𝟙 (HF.obj D)) ≫ HF.map v
 simp only [Category.comp_id]
 rw [← HF.map_comp, ← HF.map_comp]
 exact congrArg HF.map (reductionNatural C D E F i j u v square sourceZero targetZero)

theorem ordinaryRelativeNatural : CleanStatements.ordinary_to_relative_comparison_commutes := by
 intro K field H X Q square
 letI : Field K := field
 let C := CHAINS field H (SUB X Q.source.relative)
 let D := CHAINS field H (SUB X Q.source.ambient)
 let E := CHAINS field H (SUB X Q.target.relative)
 let F := CHAINS field H (SUB X Q.target.ambient)
 let i : C ⟶ D := INC field H X Q.source
 let j : E ⟶ F := INC field H X Q.target
 let u : C ⟶ E := RCHAIN field H X Q
 let v : D ⟶ F := ACHAIN field H X Q
 let HF := HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) H.degree
 change (𝟙 (HF.obj D) ≫ HF.map (cokernel.π i)) ≫ HF.map (cokernel.map i j u v square) = HF.map v ≫ (𝟙 (HF.obj F) ≫ HF.map (cokernel.π j))
 simp only [Category.id_comp]
 rw [← HF.map_comp, ← HF.map_comp]
 exact congrArg HF.map (cokernel.π_desc i (v ≫ cokernel.π j) _)
'''
for key,value in mapping.items():oracles=re.sub(r'\b'+key+r'\b',value,oracles)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(n),'RelativeOrdinaryOracle.'+o) for n,o in [('relative to ordinary homology','forward'),('ordinary to relative homology','backward')]]
pairs += [('CleanStatements.'+n,'RelativeOrdinaryOracle.'+o) for n,o in [('ordinary_after_relative_comparison','left'),('relative_after_ordinary_comparison','right'),('relative_to_ordinary_comparison_commutes','natural'),('ordinary_to_relative_comparison_commutes','inverseNatural')]]
path=HERE/'RelativeOrdinaryComparisonVerified.lean';path.write_text(source+oracles+comparison+'\n'.join('same_basic_target '+a+' '+b for a,b in pairs)+'\n')
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Six exact targets and four comparison inverse/naturality proofs (plus three chain helper lemmas) passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
