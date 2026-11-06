# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Independent canonical targets for explicit proof arguments and pair inclusions."""
from pathlib import Path
import os, subprocess, sys
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
env=Environment();results=load_document(here/'Evidence.clean',env)
source=lean(results,env,['Lean'])
(here/'Evidence.lean').write_text(source)
(here/'Evidence.tex').write_text(latex(results,env))
function=lambda n:env.data['functions'][n]['lean'].split()[0]
mapping={}
records={'Subset':'SubsetInclusion','Pair':'TopologicalPair','Inclusion':'PairInclusion'}
for oracle,name in records.items():mapping['EvidenceOracle.'+oracle]=env.structures[name]['key']
for oracle,name in [('certify','certified inclusion'),('pair','topological pair'),('inclusion','pair inclusion'),
 ('subsetMap','subset inclusion map'),('certifiedMap','certified inclusion map'),('certificate','subset certificate'),
 ('ambient','ambient inclusion'),('relative','relative inclusion'),('subspace','subspace'),
 ('subspaceMap','subspace inclusion'),('ambientMap','ambient continuous map'),('relativeMap','relative continuous map'),
 ('ambientComposite','ambient composite'),('relativeComposite','relative composite'),
 ('compose','compose continuous maps'),('point','underlying point')]:
    mapping['EvidenceOracle.'+oracle]=function(name)
rename='\n'.join(f'  if n == `{a} then return `{b}' for a,b in mapping.items())
comparison='''
open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
'''+rename+'''
  match n with
  | .str p s => return .str (canonicalName p) s
  | .num p i => return .num (canonicalName p) i
  | .anonymous => return .anonymous
private def canonical : Expr → Expr
  | .const n u => .const (canonicalName n) u
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj (canonicalName n) i (canonical b)
  | e => e
elab "same_target " a:ident b:ident : command => do
  let env ← getEnv
  let some x := env.find? a.getId | throwError "Missing actual target"
  let some y := env.find? b.getId | throwError "Missing expected target"
  unless x.levelParams == y.levelParams && Expr.equal (canonical x.type) (canonical y.type) do
    throwError "Canonical type differs: {a} vs {b}"
  match x,y with
  | .defnInfo x,.defnInfo y =>
    unless Expr.equal (canonical x.value) (canonical y.value) do
      throwError "Canonical body differs: {a} vs {b}"
  | .thmInfo x,.thmInfo y =>
    unless Expr.equal (canonical x.value) (canonical y.value) do
      throwError "Canonical proof projection differs"
  | .ctorInfo x,.ctorInfo y =>
    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&
        canonicalName x.induct == canonicalName y.induct do
      throwError "Constructor shape differs"
  | .inductInfo x,.inductInfo y =>
    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&
        x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do
      throwError "Structure shape differs"
  | _,_ => throwError "Unexpected declaration kinds"
'''
expected=r'''
namespace EvidenceOracle
structure Subset (X : Type) where
  source : Set X
  target : Set X
  containment : source ⊆ target
noncomputable def certify (X : Type) (S T : Set X) (h : S ⊆ T) : Subset X := @Subset.mk X S T h
noncomputable def subsetMap (X : Type) (S T : Set X) (h : S ⊆ T) : {x : X // x ∈ S} → {x : X // x ∈ T} := Set.inclusion h
noncomputable def certifiedMap (X : Type) (Q : Subset X) : {x : X // x ∈ Q.source} → {x : X // x ∈ Q.target} :=
  @subsetMap X Q.source Q.target Q.containment
noncomputable def certificate {X : Type} (S T : Set X) (h : S ⊆ T) : Subset X := @certify X S T h
noncomputable def point {X : Type} (S : Set X) (x : {x : X // x ∈ S}) : X := x.val
structure Pair (X : TopCat.{0}) where
  ambient : Set X.carrier
  relative : Set X.carrier
  nesting : relative ⊆ ambient
structure Inclusion (X : TopCat.{0}) where
  source : Pair X
  target : Pair X
  ambient : source.ambient ⊆ target.ambient
  relative : source.relative ⊆ target.relative
noncomputable def pair (X : TopCat.{0}) (S T : Set X.carrier) (h : T ⊆ S) : Pair X := @Pair.mk X S T h
noncomputable def inclusion (X : TopCat.{0}) (S T : Pair X)
  (h : S.ambient ⊆ T.ambient) (k : S.relative ⊆ T.relative) : Inclusion X := @Inclusion.mk X S T h k
noncomputable def ambient (X : TopCat.{0}) (Q : Inclusion X) : Subset X.carrier :=
  @certificate X.carrier Q.source.ambient Q.target.ambient Q.ambient
noncomputable def relative (X : TopCat.{0}) (Q : Inclusion X) : Subset X.carrier :=
  @certificate X.carrier Q.source.relative Q.target.relative Q.relative
noncomputable def subspace (X : TopCat.{0}) (S : Set X.carrier) : TopCat.{0} :=
  letI : TopologicalSpace X.carrier := X.str
  TopCat.of S
noncomputable def subspaceMap (X : TopCat.{0}) (S T : Set X.carrier) (h : S ⊆ T) :
  @ContinuousMap (subspace X S).carrier (subspace X T).carrier (subspace X S).str (subspace X T).str :=
  letI : TopologicalSpace X.carrier := X.str
  ContinuousMap.inclusion h
noncomputable def ambientMap (X : TopCat.{0}) (Q : Inclusion X) :
  @ContinuousMap (subspace X Q.source.ambient).carrier (subspace X Q.target.ambient).carrier
    (subspace X Q.source.ambient).str (subspace X Q.target.ambient).str :=
  @subspaceMap X Q.source.ambient Q.target.ambient Q.ambient
noncomputable def relativeMap (X : TopCat.{0}) (Q : Inclusion X) :
  @ContinuousMap (subspace X Q.source.relative).carrier (subspace X Q.target.relative).carrier
    (subspace X Q.source.relative).str (subspace X Q.target.relative).str :=
  @subspaceMap X Q.source.relative Q.target.relative Q.relative
noncomputable def compose (X Y Z : TopCat.{0})
  (g : @ContinuousMap Y.carrier Z.carrier Y.str Z.str)
  (f : @ContinuousMap X.carrier Y.carrier X.str Y.str) :
  @ContinuousMap X.carrier Z.carrier X.str Z.str :=
  @ContinuousMap.comp X.carrier Y.carrier Z.carrier X.str Y.str Z.str g f
noncomputable def ambientComposite (X : TopCat.{0}) (Q : Inclusion X) :
  @ContinuousMap (subspace X Q.source.relative).carrier (subspace X Q.target.ambient).carrier
    (subspace X Q.source.relative).str (subspace X Q.target.ambient).str :=
  @compose (subspace X Q.source.relative) (subspace X Q.source.ambient) (subspace X Q.target.ambient)
    (@ambientMap X Q) (@subspaceMap X Q.source.relative Q.source.ambient Q.source.nesting)
noncomputable def relativeComposite (X : TopCat.{0}) (Q : Inclusion X) :
  @ContinuousMap (subspace X Q.source.relative).carrier (subspace X Q.target.ambient).carrier
    (subspace X Q.source.relative).str (subspace X Q.target.ambient).str :=
  @compose (subspace X Q.source.relative) (subspace X Q.target.relative) (subspace X Q.target.ambient)
    (@subspaceMap X Q.target.relative Q.target.ambient Q.target.nesting) (@relativeMap X Q)
def constructorStatement : Prop := ∀ (X : Type) (S T : Set X) (h : S ⊆ T),
  let Q : Subset X := @certify X S T h;
  Q.source = S ∧ Q.target = T
def inclusionStatement : Prop := ∀ (X : Type) (S T : Set X) (h : S ⊆ T) (x : {x : X // x ∈ S}),
  let f : {x : X // x ∈ S} → {x : X // x ∈ T} := @subsetMap X S T h;
  @point X T (f x) = @point X S x
def certifiedStatement : Prop := ∀ (X : Type) (Q : Subset X) (x : {x : X // x ∈ Q.source}),
  let f : {x : X // x ∈ Q.source} → {x : X // x ∈ Q.target} := @certifiedMap X Q;
  @point X Q.target (f x) = @point X Q.source x
def squareStatement : Prop := ∀ (X : TopCat.{0}) (Q : Inclusion X),
  @ambientComposite X Q = @relativeComposite X Q
end EvidenceOracle
'''
checks=[f'same_target {target} {oracle}' for oracle,target in mapping.items()]
for oracle,name,fields in [('Subset','SubsetInclusion',['source','target','containment']),
 ('Pair','TopologicalPair',['ambient','relative','nesting']),
 ('Inclusion','PairInclusion',['source','target','ambient','relative'])]:
    checks += [f"same_target {env.structures[name]['key']}.{field} EvidenceOracle.{oracle}.{field}"
               for field in ['mk']+fields]
checks += [f'same_target CleanStatements.{name} EvidenceOracle.{oracle}' for name,oracle in [
 ('assumed_inclusion_constructs_certified_data','constructorStatement'),
 ('inclusion_preserves_the_underlying_element','inclusionStatement'),
 ('certified_map_preserves_the_underlying_element','certifiedStatement'),
 ('pair_inclusion_square_commutes','squareStatement')]]
proofs=r'''
namespace EvidenceProofs
theorem assumed_inclusion_constructs_certified_data : CleanStatements.assumed_inclusion_constructs_certified_data := by
  intro X S T h
  exact ⟨rfl,rfl⟩
theorem inclusion_preserves_the_underlying_element : CleanStatements.inclusion_preserves_the_underlying_element := by
  intro X S T h x
  rfl
theorem certified_map_preserves_the_underlying_element : CleanStatements.certified_map_preserves_the_underlying_element := by
  intro X Q x
  rfl
theorem pair_inclusion_square_commutes : CleanStatements.pair_inclusion_square_commutes := by
  intro X Q
  rfl
end EvidenceProofs
'''
path=here/'EvidenceVerified.lean';path.write_text(source+comparison+expected+'\n'.join(checks)+'\n'+proofs)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print(f'{len(checks)} canonical evidence targets and four proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
