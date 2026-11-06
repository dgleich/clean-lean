# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
e=Environment();rs=load_document(here/'ProofFamilies.clean',e)
source=lean(rs,e,['Lean']);(here/'ProofFamilies.lean').write_text(source);(here/'ProofFamilies.tex').write_text(latex(rs,e))
f=lambda n:e.data['functions'][n]['lean'].split()[0]
mapping={'ProofFamilyOracle.finite':f('finite reflexivity'),
 'ProofFamilyOracle.proofIdentity':f('proof identity'),
 'ProofFamilyOracle.modules':f('module reflexivity'),
 'ProofFamilyOracle.proofToNatural':f('proof to natural'),
 'ProofFamilyOracle.moduleIdentity':f('module identity family')}
expected=r"""
namespace ProofFamilyOracle
noncomputable def finite (n : ℕ) : (v : Fin n) → v = v :=
  fun v : Fin n => @REFLEXIVITY (Fin n) v
noncomputable def proofIdentity (n : ℕ) : (n = n) → (n = n) :=
  fun h : n = n => h
noncomputable def modules (K : Type) (field : Field K) :
  (M : @ModuleCat.{0,0} K field.toRing) → (x : @ModuleCat.carrier K field.toRing M) → x = x :=
  fun M : @ModuleCat.{0,0} K field.toRing =>
    fun x : @ModuleCat.carrier K field.toRing M => @REFLEXIVITY (@ModuleCat.carrier K field.toRing M) x
noncomputable def proofToNatural (n : ℕ) : (n = n) → ℕ := fun _ : n = n => n
noncomputable def moduleIdentity (K : Type) (field : Field K) :
  (@ModuleCat.{0,0} K field.toRing) → (@ModuleCat.{0,0} K field.toRing) :=
  fun M : @ModuleCat.{0,0} K field.toRing => M
def application : Prop := ∀ (n : ℕ),
  let f : (v : Fin n) → v = v := @finite n
  ∀ (v : Fin n), let h : v = v := f v; v = v
def empty : Prop := ∀ (f : (v : Fin 0) → v = v) (v : Fin 0),
  let h : v = v := f v; v = v
def singleton : Prop := ∀ (f : (v : Fin 1) → v = v) (v : Fin 1),
  let h : v = v := f v; v = v
def proofApplication : Prop := ∀ (n : ℕ) (same : n = n),
  let f : (n = n) → (n = n) := @proofIdentity n
  let h : n = n := f same
  n = n
def moduleApplication : Prop := ∀ (K : Type) (field : Field K)
  (M : @ModuleCat.{0,0} K field.toRing) (x : @ModuleCat.carrier K field.toRing M),
  let f : (N : @ModuleCat.{0,0} K field.toRing) → (y : @ModuleCat.carrier K field.toRing N) → y = y := @modules K field
  let g : (y : @ModuleCat.carrier K field.toRing M) → y = y := f M
  let h : x = x := g x
  x = x
end ProofFamilyOracle
""".replace('REFLEXIVITY',f('equality reflexivity'))
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
checks=[f'same_target {actual} {oracle}' for oracle,actual in mapping.items()]
checks += ['same_target CleanStatements.'+a+' ProofFamilyOracle.'+b for a,b in [
 ('finite_family_application','application'),('empty_family','empty'),
 ('singleton_family','singleton'),('proof_domain_application','proofApplication'),
 ('module_family_application','moduleApplication')]]
sorts=r"""
elab "declaration_sort " n:ident k:num : command => do
  let env ← getEnv
  let some info := env.find? n.getId | throwError "Missing declaration"
  liftTermElabM do
    let s ← Lean.Meta.whnf (← Lean.Meta.inferType info.type)
    unless s == Expr.sort (Lean.Level.ofNat k.getNat) do
      throwError "Incorrect sort of declaration type: {s}"
"""
sorts+='\n'.join('declaration_sort '+f(name)+' '+str(level) for name,level in [
 ('finite reflexivity',0),('proof identity',0),('module reflexivity',0),
 ('proof to natural',1),('module identity family',2)])
proof=r"""
namespace ProofFamilyChecks
 theorem application : CleanStatements.finite_family_application := by
  intro n f v h
  exact h
 theorem empty : CleanStatements.empty_family := by
  intro f v h
  exact h
 theorem singleton : CleanStatements.singleton_family := by
  intro f v h
  exact h
 theorem proof_application : CleanStatements.proof_domain_application := by
  intro n same f h
  exact h
 theorem module_application : CleanStatements.module_family_application := by
  intro K field M x f g h
  exact h
end ProofFamilyChecks
"""
p=here/'ProofFamiliesVerified.lean';p.write_text(source+expected+comparison+'\n'.join(checks)+sorts+proof)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Ten exact proof-family targets, five sort checks and five proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
