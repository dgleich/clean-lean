# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Check extreme images and the type of an explicitly unproved candidate."""
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
env=Environment()
support=load_document(here/'Interlevel.clean',env)+load_document(here/'RelativeMaps.clean',env)+load_document(here/'WellGroups.clean',env)+load_document(here/'ShiftedPerturbations.clean',env)
results=load_document(here/'ExtremeImages.clean',env)
candidate=load_document(here/'TwoImageCandidate.clean',env)
source=lean(support+results+candidate,env,['Lean','Mathlib.Tactic.Linarith'])
for stem,entries in [('ExtremeImages',results),('TwoImageCandidate',candidate)]:
    (here/(stem+'.lean')).write_text(lean(entries,env,[]))
    (here/(stem+'.tex')).write_text(latex(entries,env))
function=lambda n:env.data['functions'][n]['native_binding']
mapping={'ExtremeOracle.Extreme':env.structures['ExtremePerturbations']['key']}
for oracle,name in [('intersection','intersection of module subspaces'),('included','module subspace included'),
 ('scalars','scalar coefficient module'),('scalarTheory','scalar homology'),('compact','compact space'),('extreme','extreme perturbations'),('image','extreme pair image')]:
    mapping['ExtremeOracle.'+oracle]=function(name)
for oracle,name in [('equal','equal'),('conjoin','conjunction'),('disjoin','disjunction'),('subset','set subset'),('negative','real negative'),('atMost','real at most'),('atLeast','real at least'),('less','real less'),('equivalent','equivalence')]:
    mapping['ExtremeOracle.'+oracle]=function(name)
mapping['ExtremeOracle.numeral']=env.data['types']['Real']['numerals']['native_binding']
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
namespace ExtremeOracle
noncomputable def equal {T : Type} (x y : T) : CONDITIONTYPE := x=y
noncomputable def conjoin (x y : CONDITIONTYPE) : CONDITIONTYPE := x ∧ y
noncomputable def disjoin (x y : CONDITIONTYPE) : CONDITIONTYPE := x ∨ y
noncomputable def subset {T : Type} (A B : SETTYPE T) : CONDITIONTYPE := A ⊆ B
noncomputable def negative (x : REALTYPE) : REALTYPE := -x
noncomputable def atMost (x y : REALTYPE) : CONDITIONTYPE := x ≤ y
noncomputable def atLeast (x y : REALTYPE) : CONDITIONTYPE := x ≥ y
noncomputable def less (x y : REALTYPE) : CONDITIONTYPE := x < y
noncomputable def equivalent (x y : CONDITIONTYPE) : CONDITIONTYPE := x ↔ y
noncomputable def numeral (digits : Nat) : REALTYPE := (fun n : Nat => (n : Real)) digits
local infix:50 " =ₑ " => equal
local infixr:35 " ∧ₑ " => conjoin
local infixr:30 " ∨ₑ " => disjoin
local infix:50 " ⊆ₑ " => subset
local prefix:75 "-ₑ" => negative
local infix:50 " ≤ₑ " => atMost
local infix:50 " ≥ₑ " => atLeast
local infix:50 " <ₑ " => less
local infix:20 " ↔ₑ " => equivalent
noncomputable def intersection {K : Type} (field : FIELDTYPE K) (M : MODULE) (U V : SUB_M) : SUB_M :=
  @INF K field M (@SETOF SUB_M (fun W => W=ₑU ∨ₑ W=ₑV))
noncomputable def included {K : Type} (field : FIELDTYPE K) (M : MODULE) (U V : SUB_M) : CONDITIONTYPE :=
  @CARRIER K field M U ⊆ₑ @CARRIER K field M V
noncomputable def scalars {K : Type} (field : FIELDTYPE K) : MODULE :=
  letI : Field K := field
  ModuleCat.of K K
noncomputable def scalarTheory (K : CARRIERTYPE) (field : FIELDTYPE K) (p : NATURALTYPE) : THEORY K field :=
  @THEORYCTOR K field (@scalars K field) p
noncomputable def compact (X : SPACETYPE) : CONDITIONTYPE := @CompactSpace X.carrier X.str
structure Extreme (K : Type) (field : FIELDTYPE K) (H : THEORY K field) (P : PROBLEM) (r : REALTYPE)
  (nesting : NESTING) where
  top : CERTIFIED K field H P r nesting
  bottom : CERTIFIED K field H P r nesting
  topShift : top.data.map =ₑ @SHIFT P r
  bottomShift : bottom.data.map =ₑ @SHIFT P (-ₑr)
noncomputable def extreme (K : Type) (field : FIELDTYPE K) (H : THEORY K field) (P : PROBLEM) (r : REALTYPE)
  (nesting : NESTING) (top bottom : CERTIFIED K field H P r nesting)
  (topShift : top.data.map =ₑ @SHIFT P r) (bottomShift : bottom.data.map =ₑ @SHIFT P (-ₑr)) : Extreme K field H P r nesting :=
  @Extreme.mk K field H P r nesting top bottom topShift bottomShift
noncomputable def image {K : Type} (field : FIELDTYPE K) (H : THEORY K field) (P : PROBLEM) (r : REALTYPE)
  (nesting : NESTING) (E : Extreme K field H P r nesting) : SUB_TARGET :=
  @intersection K field TARGET_MODULE
    (@SHIFTIMAGE K field H P r nesting r E.top E.topShift)
    (@SHIFTIMAGE K field H P r nesting (-ₑr) E.bottom E.bottomShift)
def membershipStatement : Prop := ∀ (K : CARRIERTYPE) (field : FIELDTYPE K) (M : MODULE) (U V : SUB_M)
  (x : ELEMENTTYPE K field M),
  @BELONGS K field M x (@intersection K field M U V) ↔ₑ
    (@BELONGS K field M x U ∧ₑ @BELONGS K field M x V)
def existenceStatement : Prop := ∀ (K : CARRIERTYPE) (field : FIELDTYPE K) (H : THEORY K field) (P : PROBLEM) (r : REALTYPE),
  P.interval.lower ≤ₑ P.interval.upper → r ≥ₑ numeral (nat_lit 0) → ∀ (nesting : NESTING),
  ∃ E : Extreme K field H P r nesting, E.top.data.map =ₑ @SHIFT P r ∧ₑ E.bottom.data.map =ₑ @SHIFT P (-ₑr)
def independenceStatement : Prop := ∀ (K : CARRIERTYPE) (field : FIELDTYPE K) (H : THEORY K field) (P : PROBLEM) (r : REALTYPE)
  (nesting : NESTING) (E F : Extreme K field H P r nesting),
  @image K field H P r nesting E =ₑ @image K field H P r nesting F
def containmentStatement : Prop := ∀ (K : CARRIERTYPE) (field : FIELDTYPE K) (H : THEORY K field) (P : PROBLEM) (r : REALTYPE)
  (nesting : NESTING) (E : Extreme K field H P r nesting),
  @included K field TARGET_MODULE (@WELL K field H P r nesting) (@image K field H P r nesting E)
-- This is a proposition definition, deliberately not a theorem or axiom.
def candidateStatement : Prop := ∀ (K : CARRIERTYPE) (field : FIELDTYPE K) (p : NATURALTYPE),
  let H : THEORY K field := @scalarTheory K field p
  ∀ (P : PROBLEM) (r : REALTYPE),
  @compact P.space → P.interval.lower <ₑ P.interval.upper → r ≥ₑ numeral (nat_lit 0) → ∀ (nesting : NESTING)
  (E : Extreme K field H P r nesting),
  @WELL K field H P r nesting =ₑ @image K field H P r nesting E
end ExtremeOracle
'''
sub=lambda m:f'(SUBSPACETYPE K field {m})'
expected=expected.replace('SUB_M',sub('M')).replace('SUB_TARGET',sub('TARGET_MODULE'))
target='(@RELHOMOLOGY K field H P.space (@TARGET P r nesting))'
expected=expected.replace('TARGET_MODULE',target).replace('MODULE','(MODULETYPE K field)')
expected=expected.replace('NESTING','(@NESTED P.space (@EXPANDED P r))')
subs={'THEORY':env.structures['HomologyTheory']['key'],'PROBLEM':env.structures['InterlevelProblem']['key'],
      'CERTIFIED':env.structures['CertifiedPerturbation']['key']}
for key,name in [('INF','module subspace infimum'),('SETOF','set of'),('CARRIER','module subspace carrier'),
 ('SHIFT','shifted perturbation'),('SHIFTIMAGE','shifted pair image'),('BELONGS','belongs to module subspace'),
 ('WELL','relative well group'),('RELHOMOLOGY','relative homology'),('TARGET','perturbation target'),
 ('NESTED','nested pair'),('EXPANDED','expanded pair'),('THEORYCTOR','homology theory')]:subs[key]=function(name)
for placeholder,name in [('SETTYPE','Set'),('FIELDTYPE','FieldStructure'),('NATURALTYPE','Natural'),('REALTYPE','Real'),
 ('SPACETYPE','TopologicalSpace'),('CARRIERTYPE','Type'),('ELEMENTTYPE','ModuleElement'),
 ('CONDITIONTYPE','Proposition'),('SUBSPACETYPE','ModuleSubspace'),('MODULETYPE','CoefficientModule')]:
    subs[placeholder]='_root_.'+env.data['types'][name]['native_binding']
for key in sorted(subs,key=len,reverse=True):expected=expected.replace(key,subs[key])
checks=[f'same_target {actual} {oracle}' for oracle,actual in mapping.items()]
checks += [f"same_target {env.structures['ExtremePerturbations']['key']}.{field} ExtremeOracle.Extreme.{field}" for field in ['mk','top','bottom','topShift','bottomShift']]
for name,oracle in [('binary_module_intersection_membership','membershipStatement'),('extreme_perturbations_have_certificates','existenceStatement'),
 ('extreme_image_certificate_independence','independenceStatement'),('well_group_lies_in_both_extreme_images','containmentStatement'),
 ('interlevel_two_image_candidate','candidateStatement')]:checks.append(f'same_target CleanStatements.{name} ExtremeOracle.{oracle}')
supportproofs=''
content=(here/'ShiftedPerturbationsVerified.lean').read_text()
for namespace in ['InterlevelProofs','RelativeMapProofs','WellProofs','ShiftProofs']:
    supportproofs+='namespace '+namespace+content.split('namespace '+namespace,1)[1].split('end '+namespace,1)[0]+'end '+namespace+'\n'
proofs=r'''
namespace ExtremeProofs
theorem binary_module_intersection_membership : CleanStatements.binary_module_intersection_membership := by
  intro K field M U V x
  letI : Field K := field
  letI : AddCommGroup M.carrier := M.isAddCommGroup
  letI : Module K M.carrier := M.isModule
  change x ∈ sInf {W : Submodule K M.carrier | W=U ∨ W=V} ↔ (x ∈ U ∧ x ∈ V)
  constructor
  · intro h
    exact ⟨(Submodule.mem_sInf.mp h) U (Or.inl rfl), (Submodule.mem_sInf.mp h) V (Or.inr rfl)⟩
  · rintro ⟨hU,hV⟩
    apply Submodule.mem_sInf.mpr
    rintro W (rfl | rfl)
    · exact hU
    · exact hV
theorem extreme_perturbations_have_certificates : CleanStatements.extreme_perturbations_have_certificates := by
  intro K field H P r order radius nesting
  have nonnegative : 0 ≤ r := by
    simpa only [ATLEAST, NUMERAL, Nat.cast_zero] using radius
  obtain ⟨top,ht⟩ := ShiftProofs.shifted_perturbations_have_certificates K field H P r r order radius (by change -r ≤ r; linarith) le_rfl nesting
  obtain ⟨bottom,hb⟩ := ShiftProofs.shifted_perturbations_have_certificates K field H P (-r) r order radius le_rfl (by change -r ≤ r; linarith) nesting
  exact ⟨⟨top,bottom,ht,hb⟩,ht,hb⟩
theorem extreme_image_certificate_independence : CleanStatements.extreme_image_certificate_independence := by
  intro K field H P r nesting E F
  apply congrArg₂ (fun U V => @INTERSECT K field TARGET_MODULE U V)
  · exact ShiftProofs.shifted_image_certificate_independence K field H P r r nesting E.top F.top E.topShift F.topShift
  · exact ShiftProofs.shifted_image_certificate_independence K field H P (-r) r nesting E.bottom F.bottom E.bottomShift F.bottomShift
theorem well_group_lies_in_both_extreme_images : CleanStatements.well_group_lies_in_both_extreme_images := by
  intro K field H P r nesting E x member
  apply (binary_module_intersection_membership K field TARGET_MODULE
    (@SHIFTIMAGE K field H P r nesting r E.top E.topShift)
    (@SHIFTIMAGE K field H P r nesting (-r) E.bottom E.bottomShift) x).mpr
  exact ⟨ShiftProofs.well_group_lies_in_every_shifted_image K field H P r r nesting E.top E.topShift x member,
    ShiftProofs.well_group_lies_in_every_shifted_image K field H P (-r) r nesting E.bottom E.bottomShift x member⟩
end ExtremeProofs
'''
proofs=proofs.replace('ATLEAST',function('real at least')).replace('NUMERAL',env.data['types']['Real']['numerals']['native_binding'])
proofs=proofs.replace('INTERSECT',function('intersection of module subspaces')).replace('TARGET_MODULE',target)
for key in sorted(subs,key=len,reverse=True):proofs=proofs.replace(key,subs[key])
path=here/'ExtremeImagesVerified.lean'
path.write_text(source+comparison+expected+'\n'.join(checks)+'\n'+supportproofs+proofs)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print(f'{len(checks)} canonical targets, four new proofs, and twenty-six supporting proofs passed; candidate equality is unproved.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
