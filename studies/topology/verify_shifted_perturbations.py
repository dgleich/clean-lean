# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Check shifted maps, their interlevel pairs and certificate-backed images."""
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
env=Environment()
support=load_document(here/'Interlevel.clean',env)+load_document(here/'RelativeMaps.clean',env)+load_document(here/'WellGroups.clean',env)
results=load_document(here/'ShiftedPerturbations.clean',env)
source=lean(support+results,env,['Lean','Mathlib.Tactic.Linarith'])
(here/'ShiftedPerturbations.lean').write_text(lean(results,env,[]))
(here/'ShiftedPerturbations.tex').write_text(latex(results,env))
function=lambda n:env.data['functions'][n]['lean'].split()[0]
mapping={}
for oracle,name in [('constant','constant real map'),('add','add real maps'),('translate','translate real map'),
 ('shift','shifted perturbation'),('image','shifted pair image')]:
    mapping['ShiftOracle.'+oracle]=function(name)
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
namespace ShiftOracle
noncomputable def constant (X : TopCat.{0}) (c : ℝ) : REALMAP_X :=
  @ContinuousMap.const X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace c
noncomputable def add (X : TopCat.{0}) (f g : REALMAP_X) : REALMAP_X :=
  letI : TopologicalSpace X.carrier := X.str
  f+g
noncomputable def translate (X : TopCat.{0}) (f : REALMAP_X) (t : ℝ) : REALMAP_X :=
  @add X f (@constant X t)
noncomputable def shift (P : PROBLEM) (t : ℝ) : REALMAP_P := @translate P.space P.map (-t)
noncomputable def image {K : Type} (field : Field K) (H : THEORY K field) (P : PROBLEM) (r : ℝ)
  (nesting : NESTING) (t : ℝ) (C : CERTIFIED K field H P r nesting)
  (represents : C.data.map = @shift P t) : SUB_TARGET := @IMAGE K field H P r nesting C

def valueStatement : Prop := ∀ (P : PROBLEM) (t : ℝ) (x : P.space.carrier),
  @VALUE P.space (@shift P t) x = @VALUE P.space P.map x - t
def boundStatement : Prop := ∀ (P : PROBLEM) (t r : ℝ), -r ≤ t → t ≤ r → @BOUNDED P (@shift P t) r
def pairStatement : Prop := ∀ (P : PROBLEM) (t : ℝ), @PERTURBED P (@shift P t) = @SHIFTED P t
def certificatesStatement : Prop := ∀ (K : Type) (field : Field K) (H : THEORY K field) (P : PROBLEM) (t r : ℝ),
  P.interval.lower ≤ P.interval.upper → r ≥ 0 → -r ≤ t → t ≤ r → ∀ (nesting : NESTING),
  ∃ C : CERTIFIED K field H P r nesting, C.data.map = @shift P t
def independenceStatement : Prop := ∀ (K : Type) (field : Field K) (H : THEORY K field) (P : PROBLEM) (t r : ℝ)
  (nesting : NESTING) (C D : CERTIFIED K field H P r nesting)
  (first : C.data.map = @shift P t) (second : D.data.map = @shift P t),
  @image K field H P r nesting t C first = @image K field H P r nesting t D second
def inclusionStatement : Prop := ∀ (K : Type) (field : Field K) (H : THEORY K field) (P : PROBLEM) (t r : ℝ)
  (nesting : NESTING) (C : CERTIFIED K field H P r nesting)
  (represents : C.data.map = @shift P t) (x : @ModuleCat.carrier K field.toRing TARGET_MODULE),
  @BELONGS K field TARGET_MODULE x (@WELL K field H P r nesting) →
    @BELONGS K field TARGET_MODULE x (@image K field H P r nesting t C represents)
end ShiftOracle
'''
expected=expected.replace('REALMAP_X','(@ContinuousMap X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)')
expected=expected.replace('REALMAP_P','(@ContinuousMap P.space.carrier ℝ P.space.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)')
expected=expected.replace('NESTING','(@NESTED P.space (@EXPANDED P r))')
target='(@RELHOMOLOGY K field H P.space (@TARGET P r nesting))'
expected=expected.replace('TARGET_MODULE',target)
expected=expected.replace('SUB_TARGET',f'(@Submodule K {target}.carrier field.toSemiring {target}.isAddCommGroup.toAddCommMonoid {target}.isModule)')
substitutions={'PROBLEM':env.structures['InterlevelProblem']['key'],'THEORY':env.structures['HomologyTheory']['key'],
 'CERTIFIED':env.structures['CertifiedPerturbation']['key']}
for placeholder,name in [('IMAGE','perturbation homology image'),('VALUE','real map value'),('BOUNDED','bounded perturbation'),
 ('PERTURBED','perturbed pair'),('SHIFTED','shifted pair'),('NESTED','nested pair'),('EXPANDED','expanded pair'),
 ('RELHOMOLOGY','relative homology'),('TARGET','perturbation target'),('WELL','relative well group'),('BELONGS','belongs to module subspace')]:substitutions[placeholder]=function(name)
for key in sorted(substitutions,key=len,reverse=True):expected=expected.replace(key,substitutions[key])
checks=[f'same_target {target} {oracle}' for oracle,target in mapping.items()]
for name,oracle in [('shifted_perturbation_value','valueStatement'),('shifted_perturbation_bound','boundStatement'),
 ('shifted_perturbation_pair','pairStatement'),('shifted_perturbations_have_certificates','certificatesStatement'),
 ('shifted_image_certificate_independence','independenceStatement'),('well_group_lies_in_every_shifted_image','inclusionStatement')]:
    checks.append(f'same_target CleanStatements.{name} ShiftOracle.{oracle}')
supportproofs=''
content=(here/'WellGroupsVerified.lean').read_text()
for namespace in ['InterlevelProofs','RelativeMapProofs','WellProofs']:
    supportproofs+='namespace '+namespace+content.split('namespace '+namespace,1)[1].split('end '+namespace,1)[0]+'end '+namespace+'\n'
proofs=r'''
namespace ShiftProofs
theorem shifted_perturbation_value : CleanStatements.shifted_perturbation_value := by
  intro P t x
  rfl
theorem shifted_perturbation_bound : CleanStatements.shifted_perturbation_bound := by
  intro P t r lower upper x
  change -r ≤ (P.map x + -t) - P.map x ∧ (P.map x + -t) - P.map x ≤ r
  constructor <;> linarith
theorem shifted_perturbation_pair : CleanStatements.shifted_perturbation_pair := by
  intro P t
  apply congrArg₂ (fun A B : Set P.space.carrier => @DATA.mk P.space A B)
  · apply Set.ext
    intro x
    change (P.interval.lower ≤ P.map x + -t ∧ P.map x + -t ≤ P.interval.upper) ↔
      (P.interval.lower+t ≤ P.map x ∧ P.map x ≤ P.interval.upper+t)
    constructor <;> rintro ⟨h1,h2⟩ <;> constructor <;> linarith
  · apply Set.ext
    intro x
    change ((P.selection.lower=true ∧ P.map x + -t=P.interval.lower) ∨
      (P.selection.upper=true ∧ P.map x + -t=P.interval.upper)) ↔
      ((P.selection.lower=true ∧ P.map x=P.interval.lower+t) ∨
      (P.selection.upper=true ∧ P.map x=P.interval.upper+t))
    constructor <;> rintro (⟨e,h⟩ | ⟨e,h⟩)
    · exact Or.inl ⟨e,by linarith⟩
    · exact Or.inr ⟨e,by linarith⟩
    · exact Or.inl ⟨e,by linarith⟩
    · exact Or.inr ⟨e,by linarith⟩
theorem shifted_perturbations_have_certificates : CleanStatements.shifted_perturbations_have_certificates := by
  intro K field H P t r order radius lower upper nesting
  exact WellProofs.bounded_perturbations_have_certificates K field H P r order radius nesting
    (@SHIFT P t) (shifted_perturbation_bound P t r lower upper)
theorem shifted_image_certificate_independence : CleanStatements.shifted_image_certificate_independence := by
  intro K field H P t r nesting C D first second
  exact WellProofs.perturbation_image_ignores_certificate_choice K field H P r nesting C D (first.trans second.symm)
theorem well_group_lies_in_every_shifted_image : CleanStatements.well_group_lies_in_every_shifted_image := by
  intro K field H P t r nesting C represents x member
  exact (WellProofs.relative_well_group_membership K field H P r nesting x).mp member C
end ShiftProofs
'''
proofs=proofs.replace('DATA',env.structures['SpacePairData']['key']).replace('SHIFT',function('shifted perturbation'))
path=here/'ShiftedPerturbationsVerified.lean'
path.write_text(source+comparison+expected+'\n'.join(checks)+'\n'+supportproofs+proofs)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print(f'{len(checks)} canonical shifted-perturbation targets, six new proofs, and twenty supporting proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
