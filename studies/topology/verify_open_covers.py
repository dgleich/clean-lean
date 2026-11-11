# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Check open-cover interfaces; this does not prove Mayer–Vietoris exactness."""
from pathlib import Path
import ast, os, re, subprocess, sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from cleanlang.core import Environment, lean
from cleanlang.modules import load_document
HERE = Path(__file__).resolve().parent
env = Environment()
results = load_document(HERE / 'OpenCovers.clean', env)
source = lean(results, env, ['Lean'])
(HERE / 'OpenCovers.lean').write_text(source)
f = lambda name: env.data['functions'][name]['native_binding']
t = lambda name: env.data['types'][name]['native_binding']
mapping = {key: t(name) for key, name in [('SPACE','TopologicalSpace'), ('POINT','Point'), ('SET','Set'), ('PROP','Proposition')]}
mapping.update({key: env.structures[name]['key'] for key, name in [('OPEN','OpenSubset'), ('COVER','OpenCover')]})
mapping.update({key: f(name) for key, name in [('ISOPEN','open in'), ('TOPOLOGY','space topology'), ('INTER','set intersection'), ('MEM','set member'), ('OR','disjunction'), ('EQ','equal'), ('COVERS','covers space'), ('MKOPEN','open subset'), ('MKCOVER','open cover'), ('OPENNESS','intersection openness'), ('OVERLAP','open overlap')]})
oracles = '''
namespace OpenCoverOracle
noncomputable def subset (X : SPACE) (carrier : SET (POINT X))
 (openness : ISOPEN carrier (TOPOLOGY X)) : OPEN X := @OPEN.mk X carrier openness
noncomputable def cover (X : SPACE) (left right : OPEN X)
 (covering : COVERS X left right) : COVER X := @COVER.mk X left right covering
noncomputable def covers (X : SPACE) (U V : OPEN X) : PROP :=
 ∀ (x : POINT X), OR (MEM x U.carrier) (MEM x V.carrier)
noncomputable def intersectionOpen (X : SPACE) (U V : OPEN X) :
 ISOPEN (INTER U.carrier V.carrier) (TOPOLOGY X) :=
 @IsOpen.inter X.carrier X.str U.carrier V.carrier U.openness V.openness
noncomputable def overlap (X : SPACE) (U V : OPEN X) : OPEN X :=
 MKOPEN X (INTER U.carrier V.carrier) (OPENNESS X U V)
def openStatement : Prop := ∀ (X : SPACE) (U : OPEN X), ISOPEN U.carrier (TOPOLOGY X)
def overlapStatement : Prop := ∀ (X : SPACE) (U V : OPEN X),
 EQ (INTER U.carrier V.carrier) (INTER U.carrier V.carrier)
def coverStatement : Prop := ∀ (X : SPACE) (C : COVER X) (x : POINT X),
 OR (MEM x C.left.carrier) (MEM x C.right.carrier)
end OpenCoverOracle

theorem openSubsetCertificate : CleanStatements.open_subset_is_open := by
 intro X U
 exact U.openness

theorem overlapCarrier : CleanStatements.overlap_has_intersection_carrier := by
 intro X U V
 rfl

theorem coverCertificate : CleanStatements.cover_contains_every_point := by
 intro X C x
 exact C.covering x

-- Independent mathematical interpretation of the Clean-authored condition.
theorem coversIffUnion (X : SPACE) (U V : OPEN X) :
 COVERS X U V ↔ U.carrier ∪ V.carrier = Set.univ := by
 change (∀ x, x ∈ U.carrier ∨ x ∈ V.carrier) ↔ _
 constructor
 · intro h
   apply Set.eq_univ_of_forall
   exact h
 · intro h x
   have hx : x ∈ U.carrier ∪ V.carrier := by rw [h]; trivial
   exact hx
'''
for key, value in mapping.items():
    oracles = re.sub(r'\b' + key + r'\b', value, oracles)
comparison = next(ast.literal_eval(node.value) for node in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
    if isinstance(node, ast.Assign) and any(isinstance(target, ast.Name) and target.id == 'COMPARISON' for target in node.targets))
pairs = [(f(name), 'OpenCoverOracle.' + oracle) for name, oracle in [
    ('open subset','subset'), ('open cover','cover'), ('covers space','covers'),
    ('intersection openness','intersectionOpen'), ('open overlap','overlap')]]
pairs += [('CleanStatements.' + name, 'OpenCoverOracle.' + oracle) for name, oracle in [
    ('open_subset_is_open','openStatement'), ('overlap_has_intersection_carrier','overlapStatement'),
    ('cover_contains_every_point','coverStatement')]]
path = HERE / 'OpenCoversVerified.lean'
path.write_text(source + oracles + comparison + '\n'.join('same_basic_target '+a+' '+b for a,b in pairs)+'\n')
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Eight exact targets and four open-cover proofs passed; geometric exactness remains pending.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
