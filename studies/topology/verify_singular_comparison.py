# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Exact singular-homology bridge targets and natural inverse maps."""
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'SingularComparison.clean',env)
source=lean(results,env,['Lean']);(HERE/'SingularComparison.lean').write_text(source)
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
mapping={k:t(n) for k,n in [('TYPE','Type'),('FIELD','FieldStructure'),('SPACE','TopologicalSpace'),('CONT','ContinuousMap'),('CHAIN','ModuleChainComplex'),('MOD','CoefficientModule'),('MMAP','ModuleMap')]}
mapping['THEORY']=env.structures['HomologyTheory']['key']
mapping.update({k:f(n) for k,n in [('FORWARD','singular homology comparison'),('BACK','singular homology comparison inverse'),('CHAINS','singular chains'),('CMAP','induced chain map'),('HOMOLOGY','homology module'),('CH','chain homology'),('HM','induced chain homology map'),('MAP','homology linear map'),('COMP','module composition'),('ID','module identity'),('EQ','equal')]})
oracles='''
namespace SingularComparisonOracle
noncomputable def forward {K : Type} (field : FIELD K) (H : THEORY K field) (X : SPACE) : MMAP K field (CH field (CHAINS field H X) H.degree) (HOMOLOGY field H X) :=
 letI : Field K := field
 CategoryTheory.CategoryStruct.id (((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).obj X)
noncomputable def backward {K : Type} (field : FIELD K) (H : THEORY K field) (X : SPACE) : MMAP K field (HOMOLOGY field H X) (CH field (CHAINS field H X) H.degree) :=
 letI : Field K := field
 CategoryTheory.CategoryStruct.id (((AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients).obj X)
'''
for name,conclusion in [('left','EQ (COMP field m n m (FORWARD field H X) (BACK field H X)) (ID field m)'),('right','EQ (COMP field n m n (BACK field H X) (FORWARD field H X)) (ID field n)')]:
 oracles+=f'''\ndef {name} : Prop := ∀ (K : TYPE) (field : FIELD K) (H : THEORY K field) (X : SPACE),
 let m : MOD K field := CH field (CHAINS field H X) H.degree
 let n : MOD K field := HOMOLOGY field H X
 {conclusion}
'''
for name,conclusion in [('natural','EQ (COMP field m n v (HM field c d (CMAP field H X Y g) H.degree) (FORWARD field H Y)) (COMP field m u v (FORWARD field H X) (MAP field H X Y g))'),('inverseNatural','EQ (COMP field u v n (MAP field H X Y g) (BACK field H Y)) (COMP field u m n (BACK field H X) (HM field c d (CMAP field H X Y g) H.degree))')]:
 oracles+=f'''\ndef {name} : Prop := ∀ (K : TYPE) (field : FIELD K) (H : THEORY K field) (X Y : SPACE) (g : CONT X Y),
 let c : CHAIN K field := CHAINS field H X
 let d : CHAIN K field := CHAINS field H Y
 let m : MOD K field := CH field c H.degree
 let n : MOD K field := CH field d H.degree
 let u : MOD K field := HOMOLOGY field H X
 let v : MOD K field := HOMOLOGY field H Y
 {conclusion}
'''
oracles+='''
end SingularComparisonOracle
open CategoryTheory

theorem comparisonLeft : CleanStatements.singular_comparison_inverse_after_forward := by
 intro K field H X
 letI : Field K := field
 exact Category.id_comp _

theorem comparisonRight : CleanStatements.singular_comparison_forward_after_inverse := by
 intro K field H X
 letI : Field K := field
 exact Category.id_comp _

theorem comparisonNatural : CleanStatements.singular_comparison_commutes_with_induced_maps := by
 intro K field H X Y g
 letI : Field K := field
 change MAP field H X Y g ≫ 𝟙 (HOMOLOGY field H Y) = 𝟙 (HOMOLOGY field H X) ≫ MAP field H X Y g
 simp only [Category.comp_id, Category.id_comp]

theorem comparisonInverseNatural : CleanStatements.singular_inverse_comparison_commutes_with_induced_maps := by
 intro K field H X Y g
 letI : Field K := field
 change MAP field H X Y g ≫ 𝟙 (HOMOLOGY field H Y) = 𝟙 (HOMOLOGY field H X) ≫ MAP field H X Y g
 simp only [Category.comp_id, Category.id_comp]
'''
for key,value in mapping.items():oracles=re.sub(r'\b'+key+r'\b',value,oracles)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(n),'SingularComparisonOracle.'+o) for n,o in [('singular homology comparison','forward'),('singular homology comparison inverse','backward')]]
pairs += [('CleanStatements.'+n,'SingularComparisonOracle.'+o) for n,o in [('singular_comparison_inverse_after_forward','left'),('singular_comparison_forward_after_inverse','right'),('singular_comparison_commutes_with_induced_maps','natural'),('singular_inverse_comparison_commutes_with_induced_maps','inverseNatural')]]
path=HERE/'SingularComparisonVerified.lean';path.write_text(source+oracles+comparison+'\n'.join('same_basic_target '+a+' '+b for a,b in pairs)+'\n')
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Six exact targets and four inverse/naturality proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
