# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Check cover homology maps into H(X), without asserting exactness."""
from pathlib import Path
import ast, os, re, subprocess, sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'CoverHomology.clean',env)
source=lean(results,env,['Lean']);(HERE/'CoverHomology.lean').write_text(source)
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
mapping={k:t(n) for k,n in [('TYPE','Type'),('FIELD','FieldStructure'),('MOD','CoefficientModule'),('MAP','ModuleMap'),('SET','Set'),('SPACE','TopologicalSpace'),('POINT','Point'),('CONT','ContinuousMap')]}
mapping.update({k:env.structures[n]['key'] for k,n in [('THEORY','HomologyTheory'),('COVER','OpenCover')]})
mapping.update({k:f(n) for k,n in [('INTER','set intersection'),('SUBH','subset homology'),('ALPHA','intersection homology map'),('HMOD','homology module'),('HMAP','homology linear map'),('SUBSPACE','subspace'),('PRODUCT','module product'),('MERGE','merge module maps'),('COMP','module composition'),('ZERO','module zero map'),('EQ','equal'),('AMBIENT','subspace ambient map'),('INCLUSION','ambient homology inclusion'),('CA','cover intersection map'),('CB','cover ambient map')]})
oracles='''
namespace CoverHomologyOracle
noncomputable def ambient (X : SPACE) (S : SET (POINT X)) : CONT (SUBSPACE X S) X :=
 letI : TopologicalSpace X.carrier := X.str
 (⟨Subtype.val, continuous_subtype_val⟩ : ContinuousMap S X.carrier)
noncomputable def inclusion {K : Type} (field : FIELD K) (H : THEORY K field)
 (X : SPACE) (S : SET (POINT X)) : MAP K field (SUBH field H X S) (HMOD field H X) :=
 HMAP field H (SUBSPACE X S) X (AMBIENT X S)
noncomputable def alpha {K : Type} (field : FIELD K) (H : THEORY K field)
 (X : SPACE) (C : COVER X) :
 MAP K field (SUBH field H X (INTER C.left.carrier C.right.carrier))
  (PRODUCT field (SUBH field H X C.left.carrier) (SUBH field H X C.right.carrier)) :=
 ALPHA field H X C.left.carrier C.right.carrier
noncomputable def beta {K : Type} (field : FIELD K) (H : THEORY K field)
 (X : SPACE) (C : COVER X) :
 MAP K field (PRODUCT field (SUBH field H X C.left.carrier) (SUBH field H X C.right.carrier)) (HMOD field H X) :=
 MERGE field (SUBH field H X C.left.carrier) (SUBH field H X C.right.carrier) (HMOD field H X)
  (INCLUSION field H X C.left.carrier) (INCLUSION field H X C.right.carrier)
def vanishes : Prop := ∀ (K : TYPE) (field : FIELD K) (H : THEORY K field)
 (X : SPACE) (C : COVER X),
 let L : MOD K field := SUBH field H X (INTER C.left.carrier C.right.carrier)
 let M : MOD K field := PRODUCT field (SUBH field H X C.left.carrier) (SUBH field H X C.right.carrier)
 let N : MOD K field := HMOD field H X
 EQ (COMP field L M N (CA field H X C) (CB field H X C)) (ZERO field L N)
end CoverHomologyOracle

theorem ambientMapValue (X : SPACE) (S : SET (POINT X)) (x : S) :
 (AMBIENT X S) x = x.val := by rfl

open CategoryTheory

theorem coverMapsComposeToZero : CleanStatements.cover_maps_compose_to_zero := by
 intro K field H X C
 letI : Field K := field
 letI : TopologicalSpace X.carrier := X.str
 let U : Set X.carrier := C.left.carrier
 let V : Set X.carrier := C.right.carrier
 let F := (AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients
 let a : TopCat.of (U ∩ V : Set X.carrier) ⟶ TopCat.of U := TopCat.ofHom (ContinuousMap.inclusion Set.inter_subset_left)
 let b : TopCat.of (U ∩ V : Set X.carrier) ⟶ TopCat.of V := TopCat.ofHom (ContinuousMap.inclusion Set.inter_subset_right)
 let c : TopCat.of U ⟶ X := TopCat.ofHom (⟨Subtype.val, continuous_subtype_val⟩ : ContinuousMap U X.carrier)
 let d : TopCat.of V ⟶ X := TopCat.ofHom (⟨Subtype.val, continuous_subtype_val⟩ : ContinuousMap V X.carrier)
 have square : F.map a ≫ F.map c = F.map b ≫ F.map d := by
  rw [← F.map_comp, ← F.map_comp]
  rfl
 have hc : (F.map c).hom.comp (F.map a).hom = (F.map d).hom.comp (F.map b).hom :=
  congrArg ModuleCat.Hom.hom square
 change ModuleCat.ofHom (((F.map c).hom.coprod (F.map d).hom).comp
   ((F.map a).hom.prod (-(F.map b).hom))) =
  ModuleCat.ofHom (0 : (F.obj (TopCat.of (U ∩ V : Set X.carrier))).carrier →ₗ[K] (F.obj X).carrier)
 congr 1
 ext x
 have hx := congrArg (fun t : (F.obj (TopCat.of (U ∩ V : Set X.carrier))).carrier →ₗ[K] (F.obj X).carrier => t x) hc
 change (F.map c).hom ((F.map a).hom x) + (F.map d).hom (-((F.map b).hom x)) = 0
 change (F.map c).hom ((F.map a).hom x) = (F.map d).hom ((F.map b).hom x) at hx
 simp [hx]
'''
for k,v in mapping.items():oracles=re.sub(r'\b'+k+r'\b',v,oracles)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(n),'CoverHomologyOracle.'+o) for n,o in [('subspace ambient map','ambient'),('ambient homology inclusion','inclusion'),('cover intersection map','alpha'),('cover ambient map','beta')]]
pairs.append(('CleanStatements.cover_maps_compose_to_zero','CoverHomologyOracle.vanishes'))
p=HERE/'CoverHomologyVerified.lean';p.write_text(source+oracles+comparison+'\n'.join('same_basic_target '+a+' '+b for a,b in pairs)+'\n')
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Five exact targets and two cover-homology proofs passed; exactness remains pending.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
