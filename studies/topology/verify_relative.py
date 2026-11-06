# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Canonical native chain/relative-homology targets and kernel checks."""
from pathlib import Path
import os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document,load_module
here=Path(__file__).resolve().parent
env=Environment();results=load_document(here/'Relative.clean',env)
source=lean(results,env,['Lean'])
(here/'Relative.lean').write_text(source)
(here/'Relative.tex').write_text(latex(results,env))
function=lambda n:env.data['functions'][n]['lean'].split()[0]
typekey=lambda n:next(k for k in env.notation_definitions if k.startswith('cleanType_'+n+'_'))
mapping={}
for oracle,name in [('Complex','ModuleChainComplex'),('Map','ChainMap')]:
    mapping['RelativeOracle.'+oracle]=typekey(name)
for oracle,name in [('cokernel','chain cokernel'),('projection','chain cokernel projection'),
 ('compose','compose chain maps'),('zeroMap','zero chain map'),('homology','chain homology'),
 ('singular','singular chains'),('induced','induced chain map'),('inclusion','pair chain inclusion'),
 ('relativeChains','relative chains'),('relativeHomology','relative homology')]:
    mapping['RelativeOracle.'+oracle]=function(name)
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
namespace RelativeOracle
noncomputable def Complex (K : Type) (field : Field K) : Type 1 :=
  letI : Field K := field
  ChainComplex (ModuleCat.{0} K) ℕ
noncomputable def Map (K : Type) (field : Field K)
  (C D : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)) : Type :=
  letI : Field K := field
  @Quiver.Hom (ChainComplex (ModuleCat.{0} K) ℕ) inferInstance C D
noncomputable def cokernel {K : Type} (field : Field K) (C D : COMPLEX)
  (f : MAP(C,D)) : COMPLEX :=
  letI : Field K := field
  CategoryTheory.Limits.cokernel f
noncomputable def projection {K : Type} (field : Field K) (C D : COMPLEX)
  (f : MAP(C,D)) : MAP(D,(@cokernel K field C D f)) :=
  letI : Field K := field
  CategoryTheory.Limits.cokernel.π f
noncomputable def compose {K : Type} (field : Field K) (C D E : COMPLEX)
  (g : MAP(D,E)) (f : MAP(C,D)) : MAP(C,E) :=
  letI : Field K := field
  CategoryTheory.CategoryStruct.comp f g
noncomputable def zeroMap {K : Type} (field : Field K) (C D : COMPLEX) : MAP(C,D) :=
  letI : Field K := field
  0
noncomputable def homology {K : Type} (field : Field K) (C : COMPLEX) (n : ℕ) : MODULE :=
  letI : Field K := field
  (HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) n).obj C
noncomputable def singular {K : Type} (field : Field K) (H : THEORY K field) (X : TopCat.{0}) : COMPLEX :=
  letI : Field K := field
  ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{0} K)).obj H.coefficients).obj X
noncomputable def induced {K : Type} (field : Field K) (H : THEORY K field) (X Y : TopCat.{0})
  (f : @ContinuousMap X.carrier Y.carrier X.str Y.str) : MAP((@singular K field H X),(@singular K field H Y)) :=
  letI : Field K := field
  ((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{0} K)).obj H.coefficients).map (TopCat.ofHom f)
noncomputable def inclusion {K : Type} (field : Field K) (H : THEORY K field) (X : TopCat.{0})
  (Q : PAIR X) : MAP((@singular K field H (@SUBSPACE X Q.relative)),(@singular K field H (@SUBSPACE X Q.ambient))) :=
  @induced K field H (@SUBSPACE X Q.relative) (@SUBSPACE X Q.ambient)
    (@SUBINCLUSION X Q.relative Q.ambient Q.nesting)
noncomputable def relativeChains {K : Type} (field : Field K) (H : THEORY K field) (X : TopCat.{0})
  (Q : PAIR X) : COMPLEX :=
  @cokernel K field (@singular K field H (@SUBSPACE X Q.relative))
    (@singular K field H (@SUBSPACE X Q.ambient)) (@inclusion K field H X Q)
noncomputable def relativeHomology {K : Type} (field : Field K) (H : THEORY K field) (X : TopCat.{0})
  (Q : PAIR X) : MODULE := @homology K field (@relativeChains K field H X Q) H.degree

def quotientStatement : Prop := ∀ (K : Type) (field : Field K) (C D : COMPLEX) (f : MAP(C,D)),
  @compose K field C D (@cokernel K field C D f) (@projection K field C D f) f =
    @zeroMap K field C (@cokernel K field C D f)
def agreementStatement : Prop := ∀ (K : Type) (field : Field K) (H : THEORY K field) (X : TopCat.{0}),
  @homology K field (@singular K field H X) H.degree = @ABSOLUTE K field H X
def relativeChainStatement : Prop := ∀ (K : Type) (field : Field K) (H : THEORY K field) (X : TopCat.{0}) (Q : PAIR X),
  @relativeChains K field H X Q = @cokernel K field (@singular K field H (@SUBSPACE X Q.relative))
    (@singular K field H (@SUBSPACE X Q.ambient)) (@inclusion K field H X Q)
def relativeHomologyStatement : Prop := ∀ (K : Type) (field : Field K) (H : THEORY K field) (X : TopCat.{0}) (Q : PAIR X),
  @relativeHomology K field H X Q = @homology K field (@relativeChains K field H X Q) H.degree
end RelativeOracle
'''
# Expand only independently specified native abbreviations, never generated bodies.
# MAP's arguments are balanced to preserve compound complex expressions.
while 'MAP(' in expected:
    start=expected.index('MAP(');i=start+4;depth=0;split=None
    while True:
        ch=expected[i]
        if ch=='(' :depth+=1
        elif ch==')':
            if depth==0:break
            depth-=1
        elif ch==',' and depth==0:split=i
        i+=1
    left=expected[start+4:split];right=expected[split+1:i]
    expected=expected[:start]+f'(letI : Field K := field; @Quiver.Hom (ChainComplex (ModuleCat.{{0}} K) ℕ) inferInstance {left} {right})'+expected[i+1:]
expected=expected.replace('COMPLEX','(letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)')
expected=expected.replace('MODULE','(@ModuleCat.{0,0} K field.toRing)')
for placeholder,target in [('THEORY',env.structures['HomologyTheory']['key']),
 ('PAIR',env.structures['TopologicalPair']['key']),('SUBSPACE',function('subspace')),
 ('SUBINCLUSION',function('subspace inclusion')),('ABSOLUTE',function('homology module'))]:
    expected=expected.replace(placeholder,target)
checks=[f'same_target {target} {oracle}' for oracle,target in mapping.items()]
checks += [f'same_target CleanStatements.{name} RelativeOracle.{oracle}' for name,oracle in [
 ('chain_cokernel_kills_its_defining_map','quotientStatement'),
 ('singular_chain_homology_agrees','agreementStatement'),
 ('relative_chains_are_the_inclusion_cokernel','relativeChainStatement'),
 ('relative_homology_uses_the_selected_degree','relativeHomologyStatement')]]
proofs=r'''
namespace RelativeProofs
theorem chain_cokernel_kills_its_defining_map : CleanStatements.chain_cokernel_kills_its_defining_map := by
  intro K field C D f
  letI : Field K := field
  exact CategoryTheory.Limits.cokernel.condition f
theorem singular_chain_homology_agrees : CleanStatements.singular_chain_homology_agrees := by
  intro K field H X
  rfl
theorem relative_chains_are_the_inclusion_cokernel : CleanStatements.relative_chains_are_the_inclusion_cokernel := by
  intro K field H X Q
  rfl
theorem relative_homology_uses_the_selected_degree : CleanStatements.relative_homology_uses_the_selected_degree := by
  intro K field H X Q
  rfl
end RelativeProofs
'''
path=here/'RelativeVerified.lean';path.write_text(source+comparison+expected+'\n'.join(checks)+'\n'+proofs)
# Check the reusable chain module without the topology module's transitive imports.
chain_env=Environment();load_module(ROOT/'library/algebra/chains.clean',chain_env)
with tempfile.TemporaryDirectory(prefix='clean-chain-module-') as temporary:
    standalone=Path(temporary)/'Chains.lean';standalone.write_text(lean([],chain_env,[]))
    subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(standalone)],cwd=ROOT,check=True)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print(f'{len(checks)} canonical relative-chain targets and four proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
