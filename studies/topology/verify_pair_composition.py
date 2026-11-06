# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Check immediate-function indices and authored pair composition."""
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
env=Environment();results=load_document(here/'PairComposition.clean',env)
source=lean(results,env,['Lean'])
(here/'PairComposition.lean').write_text(source)
(here/'PairComposition.tex').write_text(latex(results,env))
function=lambda n:env.data['functions'][n]['lean'].split()[0]
mapping={}
for oracle,name in [('congruence','equality congruence'),('reflexivity','equality reflexivity'),
 ('subsetRefl','subset reflexivity'),('subsetTrans','subset transitivity'),('replaceTarget','replace subset target'),
 ('ambientEq','pair ambient equality'),('relativeEq','pair relative equality'),
 ('identity','identity pair inclusion'),('compose','compose pair inclusions')]:
    mapping['PairCompositionOracle.'+oracle]=function(name)
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
namespace PairCompositionOracle
noncomputable def congruence {X Y : Type} (f : X → Y) (x y : X) (h : x=y) : f x=f y := congrArg f h
noncomputable def reflexivity {X : Type} (x : X) : x=x := Eq.refl x
noncomputable def subsetRefl {X : Type} (S : Set X) : S ⊆ S := Set.Subset.refl S
noncomputable def subsetTrans {X : Type} (S T U : Set X) (h : S ⊆ T) (k : T ⊆ U) : S ⊆ U := Set.Subset.trans h k
noncomputable def replaceTarget {X : Type} (S T U : Set X) (h : S ⊆ T) (e : T=U) : S ⊆ U :=
  @Eq.rec (Set X) T (fun V _ => S ⊆ V) h U e
noncomputable def ambientEq (X : TopCat.{0}) (P Q : PAIR X) (h : P=Q) : P.ambient=Q.ambient :=
  @congruence (PAIR X) (Set X.carrier) (fun T : PAIR X => T.ambient) P Q h
noncomputable def relativeEq (X : TopCat.{0}) (P Q : PAIR X) (h : P=Q) : P.relative=Q.relative :=
  @congruence (PAIR X) (Set X.carrier) (fun T : PAIR X => T.relative) P Q h
noncomputable def identity (X : TopCat.{0}) (P : PAIR X) : INCLUSION X :=
  @PAIRINCLUSION X P P (@subsetRefl X.carrier P.ambient) (@subsetRefl X.carrier P.relative)
noncomputable def compose (X : TopCat.{0}) (Q R : INCLUSION X) (middle : Q.target=R.source) : INCLUSION X :=
  @PAIRINCLUSION X Q.source R.target
    (@subsetTrans X.carrier Q.source.ambient R.source.ambient R.target.ambient
      (@replaceTarget X.carrier Q.source.ambient Q.target.ambient R.source.ambient Q.ambient
        (@ambientEq X Q.target R.source middle)) R.ambient)
    (@subsetTrans X.carrier Q.source.relative R.source.relative R.target.relative
      (@replaceTarget X.carrier Q.source.relative Q.target.relative R.source.relative Q.relative
        (@relativeEq X Q.target R.source middle)) R.relative)
def identityEndpoints : Prop := ∀ (X : TopCat.{0}) (P : PAIR X), P=P ∧ P=P
def compositionEndpoints : Prop := ∀ (X : TopCat.{0}) (Q R : INCLUSION X), Q.target=R.source →
  Q.source=Q.source ∧ R.target=R.target
def sourceIdentity : Prop := ∀ (X : TopCat.{0}) (Q : INCLUSION X),
  @compose X (@identity X Q.source) Q (@reflexivity (PAIR X) Q.source) = Q
def targetIdentity : Prop := ∀ (X : TopCat.{0}) (Q : INCLUSION X),
  @compose X Q (@identity X Q.target) (@reflexivity (PAIR X) Q.target) = Q
def associativity : Prop := ∀ (X : TopCat.{0}) (Q R S : INCLUSION X)
  (first : Q.target=R.source) (second : R.target=S.source),
  @compose X (@compose X Q R first) S second = @compose X Q (@compose X R S second) first
def continuousIdentity : Prop := ∀ (X : TopCat.{0}) (P : PAIR X),
  @AMBIENT X (@identity X P) = @CONTID (@SUBSPACE X P.ambient) ∧
  @RELATIVE X (@identity X P) = @CONTID (@SUBSPACE X P.relative)
end PairCompositionOracle
'''
substitutions={'PAIR':env.structures['TopologicalPair']['key'],'INCLUSION':env.structures['PairInclusion']['key']}
for placeholder,name in [('PAIRINCLUSION','pair inclusion'),('AMBIENT','ambient continuous map'),
 ('RELATIVE','relative continuous map'),('CONTID','identity continuous map'),('SUBSPACE','subspace')]:
    substitutions[placeholder]=function(name)
for key in sorted(substitutions,key=len,reverse=True):expected=expected.replace(key,substitutions[key])
checks=[f'same_target {target} {oracle}' for oracle,target in mapping.items()]
for name,oracle in [('identity_pair_endpoints','identityEndpoints'),('composed_pair_endpoints','compositionEndpoints'),
 ('pair_source_identity','sourceIdentity'),('pair_target_identity','targetIdentity'),
 ('pair_composition_associativity','associativity'),('identity_pair_continuous_maps','continuousIdentity')]:
    checks.append(f'same_target CleanStatements.{name} PairCompositionOracle.{oracle}')
proofs=r'''
namespace PairCompositionProofs
theorem identity_pair_endpoints : CleanStatements.identity_pair_endpoints := by
  intro X P
  exact ⟨rfl,rfl⟩
theorem composed_pair_endpoints : CleanStatements.composed_pair_endpoints := by
  intro X Q R middle
  exact ⟨rfl,rfl⟩
theorem pair_source_identity : CleanStatements.pair_source_identity := by
  intro X Q
  rfl
theorem pair_target_identity : CleanStatements.pair_target_identity := by
  intro X Q
  rfl
theorem pair_composition_associativity : CleanStatements.pair_composition_associativity := by
  intro X Q R S first second
  rfl
theorem identity_pair_continuous_maps : CleanStatements.identity_pair_continuous_maps := by
  intro X P
  constructor <;> ext x <;> rfl
end PairCompositionProofs
'''
path=here/'PairCompositionVerified.lean'
path.write_text(source+comparison+expected+'\n'.join(checks)+'\n'+proofs)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print(f'{len(checks)} canonical pair-composition targets and six proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
