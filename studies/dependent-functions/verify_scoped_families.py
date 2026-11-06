# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
e=Environment();rs=load_document(here/'ScopedFamilies.clean',e)
source=lean(rs,e,['Lean']);(here/'ScopedFamilies.lean').write_text(source);(here/'ScopedFamilies.tex').write_text(latex(rs,e))
f=lambda n:e.data['functions'][n]['lean'].split()[0]
mapping={}
substitutions={name:e.structures[source]['key'] for name,source in
 [('GRADED','GradedModule'),('MAP','GradedMap'),('THEORY','HomologyTheory'),('PAIR','TopologicalPair')]}
substitutions.update({name:f(source) for name,source in
 [('CHAIN','graded chain homology'),('RELATIVE','graded relative homology'),
  ('COMPOSE','graded composition'),('IDENTITY','graded identity')]})
def fill(s):
    import re
    return re.sub(r'\b('+'|'.join(substitutions)+r')\b',lambda m:substitutions[m[0]],s)
expected=fill(r"""
namespace ScopedFamilyOracle
def chainStatement : Prop := ∀ (K : Type) (field : Field K)
 (C : (letI : Field K := field; ChainComplex (ModuleCat.{0} K) ℕ)),
 let M : GRADED K field := @CHAIN K field C
 ∀ (f : MAP K field M M) (clean_bound_0 clean_comparison_identity_0 : ℕ),
 let N : GRADED K field := @CHAIN K field C
 let g : MAP K field N N := @COMPOSE K field N N N f (@IDENTITY K field N)
 g = f
def relativeStatement : Prop := ∀ (K : Type) (field : Field K) (H : THEORY K field)
 (X : TopCat.{0}) (P : PAIR X),
 let M : GRADED K field := @RELATIVE K field H X P
 ∀ (f : MAP K field M M) (clean_bound_0 clean_pi_bound_0 clean_comparison_identity_0 : ℕ),
 let N : GRADED K field := @RELATIVE K field H X P
 let g : MAP K field N N := @COMPOSE K field N N N f (@IDENTITY K field N)
 g = f
end ScopedFamilyOracle
""")
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
    unless Expr.equal (canonical x.value) (canonical y.value) do throwError "Canonical body differs"
  | .ctorInfo x,.ctorInfo y =>
    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&
      canonicalName x.induct == canonicalName y.induct do throwError "Constructor differs"
  | .inductInfo x,.inductInfo y =>
    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&
      x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do throwError "Record differs"
  | _,_ => throwError "Unexpected declaration kinds"
'''
checks=[
 'same_target CleanStatements.saved_graded_map ScopedFamilyOracle.chainStatement',
 'same_target CleanStatements.saved_relative_graded_map ScopedFamilyOracle.relativeStatement']
proof=fill(r"""
set_option maxHeartbeats 1000000
namespace ScopedFamilyProofs
private theorem rightIdentity {K : Type} (field : Field K) (M : GRADED K field)
 (f : MAP K field M M) : @COMPOSE K field M M M f (@IDENTITY K field M) = f := by
 cases f
 rfl
 theorem chain : CleanStatements.saved_graded_map := by
 intro K field C
 dsimp only
 intro f unused unused'
 exact rightIdentity field _ f
 theorem relative : CleanStatements.saved_relative_graded_map := by
 intro K field H X P
 dsimp only
 intro f unused unused' unused''
 exact rightIdentity field _ f
end ScopedFamilyProofs
""")
p=here/'ScopedFamiliesVerified.lean';p.write_text(source+expected+comparison+'\n'.join(checks)+proof)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Two exact saved-family targets and two proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
