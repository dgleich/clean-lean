# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Assemble level-pair certification and inverse ordinary-homology maps."""
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'LevelHomologyComparison.clean',env)
source=lean(results,env,['Lean']);(HERE/'LevelHomologyComparison.lean').write_text(source)
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
mapping={k:t(n) for k,n in [('TYPE','Type'),('FIELD','FieldStructure'),('SPACE','TopologicalSpace'),('CMAP','ContinuousRealMap'),('REAL','Real'),('MOD','CoefficientModule'),('MMAP','ModuleMap'),('PROP','Proposition')]}
mapping.update({k:env.structures[n]['key'] for k,n in [('THEORY','HomologyTheory'),('DATA','SpacePairData')]})
mapping.update({k:f(n) for k,n in [('INVERSE','inverse module maps'),('COMP','module composition'),('ID','module identity'),('EQ','equal'),('AND','conjunction'),('NESTED','nested pair'),('CERTIFY','certify pair data'),('REL','relative homology'),('ORD','homology module'),('SUB','subspace'),('BACK','ordinary to relative homology'),('FWD','relative to ordinary homology'),('CHAINS','singular chains'),('INC','pair chain inclusion'),('RED','vanishing quotient reduction'),('PI','chain cokernel projection'),('EXP','expanded pair'),('PERT','perturbed pair'),('SHIFT','shifted pair'),('LEVEL','level problem')]})
existence='''∃ (nesting : NESTED X s), ∃ (alpha : MMAP K field (REL field H X (CERTIFY X s nesting)) (ORD field H (SUB X s.ambient))),
 INVERSE field (REL field H X (CERTIFY X s nesting)) (ORD field H (SUB X s.ambient)) alpha (BACK field H X (CERTIFY X s nesting))'''
oracles='''
namespace LevelHomologyOracle
noncomputable def inverse {K : Type} (field : FIELD K) (M N : MOD K field) (f : MMAP K field M N) (g : MMAP K field N M) : PROP :=
 AND (EQ (COMP field M N M f g) (ID field M)) (EQ (COMP field N M N g f) (ID field N))
'''
for name,params,body in [('expanded','(f : CMAP X) (a r : REAL)','EXP (LEVEL X f a) r'),('perturbed','(f g : CMAP X) (a : REAL)','PERT (LEVEL X f a) g'),('shifted','(f : CMAP X) (a t : REAL)','SHIFT (LEVEL X f a) t')]:
 oracles+=f'''def {name} : Prop := ∀ (K : TYPE) (field : FIELD K) (H : THEORY K field) (X : SPACE) {params},
 let s : DATA X := {body}
 {existence}
'''
oracles+='''
end LevelHomologyOracle
open CategoryTheory CategoryTheory.Limits

theorem singularChainsEmpty (K : Type) [Field K] (R : ModuleCat.{0} K)
 (X : TopCat.{0}) [IsEmpty X] :
 IsZero (((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{0} K)).obj R).obj X) := by
 have hz : IsZero (∐ fun _ : X => R) := by
  apply (IsZero.iff_id_eq_zero _).2
  apply Sigma.hom_ext
  intro x
  exact isEmptyElim x
 have ha : IsZero (ChainComplex.alternatingConst.obj (∐ fun _ : X => R)) := by
  apply (IsZero.iff_id_eq_zero _).2
  apply HomologicalComplex.hom_ext
  intro n
  exact hz.eq_of_src _ _
 exact ha.of_iso (AlgebraicTopology.singularChainComplexFunctorIsoOfTotallyDisconnectedSpace (ModuleCat.{0} K) R X)

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
'''
oracles+='''
theorem assembledEmptyPair (K : TYPE) (field : FIELD K) (H : THEORY K field)
 (X : SPACE) (s : DATA X) (empty : IsEmpty (SUB X s.relative)) :
'''+existence+''' := by
 letI : Field K := field
 have nesting : NESTED X s := by
  intro x hx
  exact (empty.false ⟨x,hx⟩).elim
 let Q := CERTIFY X s nesting
 let C := CHAINS field H (SUB X s.relative)
 let D := CHAINS field H (SUB X s.ambient)
 let i : C ⟶ D := INC field H X Q
 letI : IsEmpty (SUB X s.relative) := empty
 have hz : IsZero C := singularChainsEmpty K H.coefficients (SUB X s.relative)
 have h : i = 0 := hz.eq_of_src _ _
 refine ⟨nesting, FWD field H X Q h, ?_⟩
 constructor
 · let HF := HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) H.degree
   change (HF.map (RED field C D i h) ≫ 𝟙 (HF.obj D)) ≫ (𝟙 (HF.obj D) ≫ HF.map (PI field C D i)) = 𝟙 (HF.obj (cokernel i))
   simp only [Category.comp_id, Category.id_comp]
   rw [← HF.map_comp, ← HF.map_id]
   exact congrArg HF.map (reductionProjection C D i h)
 · let HF := HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) H.degree
   change (𝟙 (HF.obj D) ≫ HF.map (PI field C D i)) ≫ (HF.map (RED field C D i h) ≫ 𝟙 (HF.obj D)) = 𝟙 (HF.obj D)
   simp only [Category.comp_id, Category.id_comp]
   rw [← HF.map_comp, ← HF.map_id]
   exact congrArg HF.map (projectionReduction C D i h)

theorem expandedLevelComparison : CleanStatements.expanded_level_pair_admits_ordinary_comparison := by
 intro K field H X f a r
 apply assembledEmptyPair
 refine ⟨?_⟩
 intro x
 have hx := x.property
 change ((false = true ∧ a-r ≤ f x.val) ∧ f x.val ≤ a+r) ∨ ((false = true ∧ a-r ≤ f x.val) ∧ f x.val ≤ a+r) at hx
 simp at hx

theorem perturbedLevelComparison : CleanStatements.perturbed_level_pair_admits_ordinary_comparison := by
 intro K field H X f g a
 apply assembledEmptyPair
 refine ⟨?_⟩
 intro x
 have hx := x.property
 change (false = true ∧ g x.val = a) ∨ (false = true ∧ g x.val = a) at hx
 simp at hx

theorem shiftedLevelComparison : CleanStatements.shifted_level_pair_admits_ordinary_comparison := by
 intro K field H X f a t
 apply assembledEmptyPair
 refine ⟨?_⟩
 intro x
 have hx := x.property
 change (false = true ∧ f x.val = a+t) ∨ (false = true ∧ f x.val = a+t) at hx
 simp at hx
'''
for key,value in mapping.items():oracles=re.sub(r'\b'+key+r'\b',value,oracles)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f('inverse module maps'),'LevelHomologyOracle.inverse')]
pairs += [('CleanStatements.'+n,'LevelHomologyOracle.'+o) for n,o in [('expanded_level_pair_admits_ordinary_comparison','expanded'),('perturbed_level_pair_admits_ordinary_comparison','perturbed'),('shifted_level_pair_admits_ordinary_comparison','shifted')]]
path=HERE/'LevelHomologyComparisonVerified.lean';path.write_text(source+oracles+comparison+'\n'.join('same_basic_target '+a+' '+b for a,b in pairs)+'\n')
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Four exact targets and three level applications (plus four generic helper proofs) passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
