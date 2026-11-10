# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Check actual inclusion-induced maps and composition-to-zero, not exactness."""
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'MayerVietorisMaps.clean',env)
source=lean(results,env,['Lean']);(HERE/'MayerVietorisMaps.lean').write_text(source)
(HERE/'MayerVietorisMaps.tex').write_text(latex(results,env))
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
mapping={k:t(n) for k,n in [('TYPE','Type'),('FIELD','FieldStructure'),('MOD','CoefficientModule'),('MAP','ModuleMap'),('SET','Set'),('SPACE','TopologicalSpace'),('POINT','Point')]}
mapping['THEORY']=env.structures['HomologyTheory']['key']
mapping.update({k:f(n) for k,n in [('INTER','set intersection'),('UNION','set union'),('SUBSET','set subset'),('IL','intersection into left'),('IR','intersection into right'),('UL','left into union'),('UR','right into union'),('SUBH','subset homology'),('INCH','inclusion homology'),('ALPHA','intersection homology map'),('BETA','union homology map'),('HMOD','homology module'),('HMAP','homology linear map'),('SUBSPACE','subspace'),('INC','subspace inclusion'),('PRODUCT','module product'),('SIGNED','signed pair'),('MERGE','merge module maps'),('COMP','module composition'),('ZERO','module zero map'),('EQ','equal')]})
oracles='''
namespace MayerVietorisMapOracle
def interLeft {T : Type} (U V : SET T) : (SUBSET (INTER U V) U) := Set.inter_subset_left
def interRight {T : Type} (U V : SET T) : (SUBSET (INTER U V) V) := Set.inter_subset_right
def unionLeft {T : Type} (U V : SET T) : (SUBSET U (UNION U V)) := Set.subset_union_left
def unionRight {T : Type} (U V : SET T) : (SUBSET V (UNION U V)) := Set.subset_union_right
noncomputable def subsetHomology {K : Type} (field : FIELD K) (H : THEORY K field)
 (X : SPACE) (S : SET (POINT X)) : MOD K field := HMOD field H (SUBSPACE X S)
noncomputable def inclusionHomology {K : Type} (field : FIELD K) (H : THEORY K field)
 (X : SPACE) (S T : SET (POINT X)) (h : (SUBSET S T)) :
 MAP K field (SUBH field H X S) (SUBH field H X T) :=
 HMAP field H (SUBSPACE X S) (SUBSPACE X T) (INC X S T h)
noncomputable def alpha {K : Type} (field : FIELD K) (H : THEORY K field)
 (X : SPACE) (U V : SET (POINT X)) :
 MAP K field (SUBH field H X (INTER U V)) (PRODUCT field (SUBH field H X U) (SUBH field H X V)) :=
 SIGNED (INCH field H X (INTER U V) U (IL U V)) (INCH field H X (INTER U V) V (IR U V))
noncomputable def beta {K : Type} (field : FIELD K) (H : THEORY K field)
 (X : SPACE) (U V : SET (POINT X)) :
 MAP K field (PRODUCT field (SUBH field H X U) (SUBH field H X V)) (SUBH field H X (UNION U V)) :=
 MERGE field (SUBH field H X U) (SUBH field H X V) (SUBH field H X (UNION U V))
  (INCH field H X U (UNION U V) (UL U V)) (INCH field H X V (UNION U V) (UR U V))
def vanishes : Prop := ∀ (K : TYPE) (field : FIELD K) (H : THEORY K field)
 (X : SPACE) (U V : SET (POINT X)),
 EQ (COMP field (SUBH field H X (INTER U V)) (PRODUCT field (SUBH field H X U) (SUBH field H X V))
  (SUBH field H X (UNION U V)) (ALPHA field H X U V) (BETA field H X U V))
  (ZERO field (SUBH field H X (INTER U V)) (SUBH field H X (UNION U V)))
end MayerVietorisMapOracle
'''
for k,v in mapping.items():oracles=re.sub(r'\b'+k+r'\b',v,oracles)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(n),'MayerVietorisMapOracle.'+o) for n,o in [('intersection into left','interLeft'),('intersection into right','interRight'),('left into union','unionLeft'),('right into union','unionRight'),('subset homology','subsetHomology'),('inclusion homology','inclusionHomology'),('intersection homology map','alpha'),('union homology map','beta')]]
pairs.append(('CleanStatements.intersection_then_union_vanishes','MayerVietorisMapOracle.vanishes'))
proofs=(HERE/'mayer-vietoris-map-proofs.lean').read_text()
p=HERE/'MayerVietorisMapsVerified.lean';p.write_text(source+oracles+proofs+comparison+'\n'.join('same_basic_target '+a+' '+b for a,b in pairs)+'\n')
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Nine exact native targets and the inclusion-induced composition-to-zero proof passed.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
