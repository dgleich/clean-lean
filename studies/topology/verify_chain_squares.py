# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Canonical chain-square targets and actual quotient/naturality proofs."""
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
env=Environment();results=load_document(here/'ChainSquares.clean',env)
source=lean(results,env,['Lean'])
(here/'ChainSquares.lean').write_text(source)
(here/'ChainSquares.tex').write_text(latex(results,env))
function=lambda n:env.data['functions'][n]['native_binding']
record=env.structures['ChainSquare']['key']
mapping={'SquareOracle.Square':record}
for oracle,name in [('square','chain square'),('cokernelMap','chain cokernel map'),
 ('quotient','square quotient map'),('homologyMap','induced chain homology map'),('squareHomologyMap','square homology map'),('ambient','ambient chain map'),('relative','relative subset chain map'),
 ('represents','square represents pair inclusion')]:mapping['SquareOracle.'+oracle]=function(name)
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
namespace SquareOracle
structure Square (K : Type) (field : FIELDTYPE K) (C D E F : COMPLEX) where
  source : MAP(C,D)
  target : MAP(E,F)
  left : MAP(C,E)
  right : MAP(D,F)
  commutes : @COMPOSE K field C D F right source = @COMPOSE K field C E F target left
noncomputable def square (K : Type) (field : FIELDTYPE K) (C D E F : COMPLEX)
  (f : MAP(C,D)) (g : MAP(E,F)) (p : MAP(C,E)) (q : MAP(D,F))
  (h : @COMPOSE K field C D F q f = @COMPOSE K field C E F g p) : Square K field C D E F :=
  @Square.mk K field C D E F f g p q h
noncomputable def cokernelMap {K : Type} (field : FIELDTYPE K) (C D E F : COMPLEX)
  (f : MAP(C,D)) (g : MAP(E,F)) (p : MAP(C,E)) (q : MAP(D,F))
  (h : @COMPOSE K field C D F q f = @COMPOSE K field C E F g p) :
  MAP((@COKERNEL K field C D f),(@COKERNEL K field E F g)) :=
  letI : Field K := field
  CategoryTheory.Limits.cokernel.map f g p q h
noncomputable def quotient {K : Type} (field : FIELDTYPE K) (C D E F : COMPLEX)
  (S : Square K field C D E F) : MAP((@COKERNEL K field C D S.source),(@COKERNEL K field E F S.target)) :=
  @cokernelMap K field C D E F S.source S.target S.left S.right S.commutes
noncomputable def homologyMap {K : Type} (field : FIELDTYPE K) (C D : COMPLEX) (f : MAP(C,D)) (n : NATURALTYPE) :
  MODULEMAPTYPE K field (@HOMOLOGY K field C n) (@HOMOLOGY K field D n) :=
  letI : Field K := field
  (HomologicalComplex.homologyFunctor (ModuleCat.{0} K) (ComplexShape.down ℕ) n).map f
noncomputable def squareHomologyMap {K : Type} (field : FIELDTYPE K) (C D E F : COMPLEX)
  (S : Square K field C D E F) (n : NATURALTYPE) :
  MODULEMAPTYPE K field (@HOMOLOGY K field (@COKERNEL K field C D S.source) n)
    (@HOMOLOGY K field (@COKERNEL K field E F S.target) n) :=
  @homologyMap K field (@COKERNEL K field C D S.source) (@COKERNEL K field E F S.target)
    (@quotient K field C D E F S) n
noncomputable def ambient {K : Type} (field : FIELDTYPE K) (H : THEORY K field) (X : SPACETYPE)
  (Q : PAIRINCLUSION X) : MAP(B,D) :=
  @INDUCED K field H (@SUBSPACE X Q.source.ambient) (@SUBSPACE X Q.target.ambient) (@AMBIENTCONT X Q)
noncomputable def relative {K : Type} (field : FIELDTYPE K) (H : THEORY K field) (X : SPACETYPE)
  (Q : PAIRINCLUSION X) : MAP(A,C) :=
  @INDUCED K field H (@SUBSPACE X Q.source.relative) (@SUBSPACE X Q.target.relative) (@RELATIVECONT X Q)
noncomputable def represents {K : Type} (field : FIELDTYPE K) (H : THEORY K field) (X : SPACETYPE)
  (Q : PAIRINCLUSION X) (S : Square K field A B C D) : CONDITIONTYPE :=
  ((S.source = @PAIRMAP K field H X Q.source ∧ S.target = @PAIRMAP K field H X Q.target) ∧
    S.left = @relative K field H X Q) ∧ S.right = @ambient K field H X Q

def quotientStatement : Prop := ∀ (K : CARRIERTYPE) (field : FIELDTYPE K) (C D E F : COMPLEX)
  (S : Square K field C D E F),
  @COMPOSE K field D (@COKERNEL K field C D S.source) (@COKERNEL K field E F S.target)
    (@quotient K field C D E F S) (@PROJECTION K field C D S.source) =
  @COMPOSE K field D F (@COKERNEL K field E F S.target) (@PROJECTION K field E F S.target) S.right
def pairStatement : Prop := ∀ (K : CARRIERTYPE) (field : FIELDTYPE K) (H : THEORY K field) (X : SPACETYPE)
  (Q : PAIRINCLUSION X), ∃ S : Square K field A B C D, @represents K field H X Q S
end SquareOracle
'''
# Substitute the four independently specified corners only in the pair-specific declarations.
parts=expected.split('noncomputable def ambient',1)
pairpart=parts[1]
# Limit substitution to pair-specific stretches, leaving the generic quotient statement unchanged.
import re
corners={n:f'(@SINGULAR K field H (@SUBSPACE X Q.{pair}.{subset}))'
         for n,pair,subset in [('A','source','relative'),('B','source','ambient'),
                              ('C','target','relative'),('D','target','ambient')]}
start,end=pairpart.split('def quotientStatement',1)
generic,final=end.split('def pairStatement',1)
expand=lambda s:re.sub(r'\b[A-D]\b',lambda m:corners[m[0]],s)
expected=parts[0]+'noncomputable def ambient'+expand(start)+'def quotientStatement'+generic+'def pairStatement'+expand(final)
while 'MAP(' in expected:
    start=expected.index('MAP(');i=start+4;depth=0;split=None
    while True:
        ch=expected[i]
        if ch=='(':depth+=1
        elif ch==')':
            if depth==0:break
            depth-=1
        elif ch==',' and depth==0:split=i
        i+=1
    a,b=expected[start+4:split],expected[split+1:i]
    expected=expected[:start]+f'(CHAINMAPTYPE K field {a} {b})'+expected[i+1:]
expected=expected.replace('COMPLEX','(CHAINTYPE K field)')
substitutions={'THEORY':env.structures['HomologyTheory']['key'],'PAIRINCLUSION':env.structures['PairInclusion']['key']}
for placeholder,name in [('HOMOLOGY','chain homology'),('COMPOSE','compose chain maps'),('COKERNEL','chain cokernel'),
 ('PROJECTION','chain cokernel projection'),('INDUCED','induced chain map'),('SUBSPACE','subspace'),
 ('AMBIENTCONT','ambient continuous map'),('RELATIVECONT','relative continuous map'),
 ('PAIRMAP','pair chain inclusion'),('SINGULAR','singular chains')]:substitutions[placeholder]=function(name)
for placeholder,name in [('FIELDTYPE','FieldStructure'),('SPACETYPE','TopologicalSpace'),
 ('NATURALTYPE','Natural'),('CARRIERTYPE','Type'),('MODULEMAPTYPE','ModuleMap'),
 ('CONDITIONTYPE','Proposition'),('CHAINMAPTYPE','ChainMap'),('CHAINTYPE','ModuleChainComplex')]:
    substitutions[placeholder]='_root_.'+env.data['types'][name]['native_binding']
for placeholder in sorted(substitutions,key=len,reverse=True):expected=expected.replace(placeholder,substitutions[placeholder])
checks=[f'same_target {target} {oracle}' for oracle,target in mapping.items()]
checks += [f'same_target {record}.{name} SquareOracle.Square.{name}' for name in ['mk','source','target','left','right','commutes']]
checks += ['same_target CleanStatements.quotient_square_commutes SquareOracle.quotientStatement',
           'same_target CleanStatements.pair_inclusion_induces_a_chain_square SquareOracle.pairStatement']
proofs=r'''
namespace SquareProofs
theorem quotient_square_commutes : CleanStatements.quotient_square_commutes := by
  intro K field C D E F S
  letI : Field K := field
  exact CategoryTheory.Limits.cokernel.π_desc _ _ _
theorem pair_inclusion_induces_a_chain_square : CleanStatements.pair_inclusion_induces_a_chain_square := by
  intro K field H X Q
  letI : Field K := field
  refine ⟨⟨@PAIRMAP K field H X Q.source, @PAIRMAP K field H X Q.target,
    @RELATIVE K field H X Q, @AMBIENT K field H X Q, ?_⟩, ?_⟩
  · simp only [COMPOSE, PAIRMAP, INDUCED, AMBIENT, RELATIVE]
    rw [← CategoryTheory.Functor.map_comp, ← CategoryTheory.Functor.map_comp]
    rfl
  · exact ⟨⟨⟨rfl,rfl⟩,rfl⟩,rfl⟩
end SquareProofs
'''
for placeholder,target in {**substitutions,'RELATIVE':function('relative subset chain map'),'AMBIENT':function('ambient chain map')}.items():
    proofs=proofs.replace(placeholder,target)
path=here/'ChainSquaresVerified.lean';path.write_text(source+comparison+expected+'\n'.join(checks)+'\n'+proofs)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print(f'{len(checks)} canonical chain-square targets and two proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
