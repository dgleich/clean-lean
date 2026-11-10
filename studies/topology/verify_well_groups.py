# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Check a fixed-target perturbation intersection and certificate completeness."""
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
env=Environment()
support=load_document(here/'Interlevel.clean',env)+load_document(here/'RelativeMaps.clean',env)
results=load_document(here/'WellGroups.clean',env)
source=lean(support+results,env,['Lean','Mathlib.Tactic.Linarith'])
(here/'WellGroups.lean').write_text(lean(results,env,[]))
(here/'WellGroups.tex').write_text(latex(results,env))
function=lambda n:env.data['functions'][n]['native_binding']
mapping={'WellOracle.Data':env.structures['PerturbationCertificate']['key'],
         'WellOracle.Certified':env.structures['CertifiedPerturbation']['key']}
for oracle,name in [('infimum','module subspace infimum'),('intersection','intersection of module family'),
 ('data','perturbation certificate'),('certified','certified perturbation'),('target','perturbation target'),
 ('inclusion','perturbation pair inclusion'),('image','perturbation homology image'),('well','relative well group')]:
    mapping['WellOracle.'+oracle]=function(name)
for oracle,name in [('equal','equal'),('subset','set subset'),('equivalent','logical equivalence'),('atMost','real at most'),('atLeast','real at least')]:
    mapping['WellOracle.'+oracle]=function(name)
mapping['WellOracle.numeral']=env.data['types']['Real']['numerals']['native_binding']
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
namespace WellOracle
noncomputable def equal {T : Type} (x y : T) : CONDITIONTYPE := x=y
noncomputable def subset {T : Type} (A B : SETTYPE T) : CONDITIONTYPE := A ⊆ B
noncomputable def equivalent (x y : CONDITIONTYPE) : CONDITIONTYPE := x ↔ y
noncomputable def atMost (x y : REALTYPE) : CONDITIONTYPE := x ≤ y
noncomputable def atLeast (x y : REALTYPE) : CONDITIONTYPE := x ≥ y
noncomputable def numeral (digits : Nat) : REALTYPE := (fun n : Nat => (n : Real)) digits
local infix:50 " =ᵥ " => equal
local infix:50 " ⊆ᵥ " => subset
local infix:20 " ↔ᵥ " => equivalent
local infix:50 " ≤ᵥ " => atMost
local infix:50 " ≥ᵥ " => atLeast
noncomputable def infimum {K : Type} (field : FIELDTYPE K) (M : MODULE) (spaces : SETTYPE SUB_M) : SUB_M :=
  letI : Field K := field
  sInf spaces
noncomputable def intersection {K I : Type} (field : FIELDTYPE K) (M : MODULE) (spaces : I → SUB_M) : SUB_M :=
  @infimum K field M (@SETOF SUB_M (fun U => @Exists I (fun i => U=ᵥspaces i)))
structure Data (P : PROBLEM) (r : REALTYPE) where
  map : REALMAP
  bounded : @BOUNDED P map r
  nesting : @NESTED P.space (@PERTURBED P map)
  ambient : CANDIDATE_AMBIENT ⊆ᵥ EXPANDED_AMBIENT
  relative : CANDIDATE_RELATIVE ⊆ᵥ EXPANDED_RELATIVE
noncomputable def data (P : PROBLEM) (r : REALTYPE) (map : REALMAP)
  (bounded : @BOUNDED P map r) (nesting : @NESTED P.space (@PERTURBED P map))
  (ambient : CANDIDATE_AMBIENT ⊆ᵥ EXPANDED_AMBIENT)
  (relative : CANDIDATE_RELATIVE ⊆ᵥ EXPANDED_RELATIVE) : Data P r :=
  @Data.mk P r map bounded nesting ambient relative
noncomputable def target (P : PROBLEM) (r : REALTYPE) (nesting : NESTING) : PAIR P.space :=
  @CERTIFY P.space (@EXPANDED P r) nesting
noncomputable def inclusion (P : PROBLEM) (r : REALTYPE) (nesting : NESTING) (D : Data P r) : INCLUSION P.space :=
  @CERTIFYINCLUSION P.space (@PERTURBED P D.map) (@EXPANDED P r) D.nesting nesting D.ambient D.relative
structure Certified (K : Type) (field : FIELDTYPE K) (H : THEORY K field) (P : PROBLEM) (r : REALTYPE)
  (nesting : NESTING) where
  data : Data P r
  commutes : @COMMUTES K field H P.space (@inclusion P r nesting data)
noncomputable def certified (K : Type) (field : FIELDTYPE K) (H : THEORY K field) (P : PROBLEM) (r : REALTYPE)
  (nesting : NESTING) (data : Data P r)
  (commutes : @COMMUTES K field H P.space (@inclusion P r nesting data)) : Certified K field H P r nesting :=
  @Certified.mk K field H P r nesting data commutes
noncomputable def image {K : Type} (field : FIELDTYPE K) (H : THEORY K field) (P : PROBLEM) (r : REALTYPE)
  (nesting : NESTING) (C : Certified K field H P r nesting) : SUB_TARGET :=
  @IMAGE K field H P.space (@inclusion P r nesting C.data) C.commutes
noncomputable def well {K : Type} (field : FIELDTYPE K) (H : THEORY K field) (P : PROBLEM) (r : REALTYPE)
  (nesting : NESTING) : SUB_TARGET :=
  @intersection K (Certified K field H P r nesting) field TARGET
    (fun C : Certified K field H P r nesting => @image K field H P r nesting C)

def intersectionStatement : Prop := ∀ (K I : CARRIERTYPE) (field : FIELDTYPE K) (M : MODULE) (spaces : I → SUB_M)
  (x : ELEMENTTYPE K field M),
  @BELONGS K field M x (@intersection K I field M spaces) ↔ᵥ ∀ i : I, @BELONGS K field M x (spaces i)
def coverageStatement : Prop := ∀ (K : CARRIERTYPE) (field : FIELDTYPE K) (H : THEORY K field) (P : PROBLEM) (r : REALTYPE),
  P.interval.lower ≤ᵥ P.interval.upper → r ≥ᵥ numeral (nat_lit 0) → ∀ (nesting : NESTING) (h : REALMAP),
  @BOUNDED P h r → ∃ C : Certified K field H P r nesting, C.data.map=ᵥh
def boundedStatement : Prop := ∀ (K : CARRIERTYPE) (field : FIELDTYPE K) (H : THEORY K field) (P : PROBLEM) (r : REALTYPE)
  (nesting : NESTING) (C : Certified K field H P r nesting), @BOUNDED P C.data.map r
def independenceStatement : Prop := ∀ (K : CARRIERTYPE) (field : FIELDTYPE K) (H : THEORY K field) (P : PROBLEM) (r : REALTYPE)
  (nesting : NESTING) (C D : Certified K field H P r nesting), C.data.map=ᵥD.data.map →
  @image K field H P r nesting C =ᵥ @image K field H P r nesting D
def membershipStatement : Prop := ∀ (K : CARRIERTYPE) (field : FIELDTYPE K) (H : THEORY K field) (P : PROBLEM) (r : REALTYPE)
  (nesting : NESTING) (x : ELEMENTTYPE K field TARGET),
  @BELONGS K field TARGET x (@well K field H P r nesting) ↔ᵥ
    ∀ C : Certified K field H P r nesting, @BELONGS K field TARGET x (@image K field H P r nesting C)
end WellOracle
'''
# Independently specified native expressions; no generated bodies are used as oracles.
submodule=lambda m:f'(SUBSPACETYPE K field {m})'
expected=expected.replace('SUB_TARGET',submodule('TARGET')).replace('SUB_M',submodule('M'))
expected=expected.replace('TARGET','(@RELHOMOLOGY K field H P.space (@target P r nesting))')
expected=expected.replace('MODULE','(MODULETYPE K field)')
expected=expected.replace('REALMAP','(REALMAPTYPE P.space)')
expected=expected.replace('NESTING','(@NESTED P.space (@EXPANDED P r))')
expected=expected.replace('CANDIDATE_AMBIENT','(@PREIMAGE (POINTTYPE P.space) REALTYPE (@UNDERLYING P.space map) (@CLOSED P.interval))')
expected=expected.replace('CANDIDATE_RELATIVE','(@PREIMAGE (POINTTYPE P.space) REALTYPE (@UNDERLYING P.space map) (@SELECTED P.interval P.selection))')
expected=expected.replace('EXPANDED_AMBIENT','(@PREIMAGE (POINTTYPE P.space) REALTYPE (@UNDERLYING P.space P.map) (@EXPANDINTERVAL P.interval r))')
expected=expected.replace('EXPANDED_RELATIVE','(@PREIMAGE (POINTTYPE P.space) REALTYPE (@UNDERLYING P.space P.map) (@EXPANDENDPOINTS P.interval P.selection r))')
substitutions={'PROBLEM':env.structures['InterlevelProblem']['key'],'PAIR':env.structures['TopologicalPair']['key'],
               'INCLUSION':env.structures['PairInclusion']['key'],'THEORY':env.structures['HomologyTheory']['key']}
for placeholder,name in [('SETOF','set of'),('BOUNDED','bounded perturbation'),('NESTED','nested pair'),
 ('PERTURBED','perturbed pair'),('EXPANDED','expanded pair'),('CERTIFY','certify pair data'),
 ('CERTIFYINCLUSION','certify pair inclusion'),('COMMUTES','pair chain commutes'),('IMAGE','relative homology image'),
 ('RELHOMOLOGY','relative homology'),('BELONGS','belongs to module subspace'),('PREIMAGE','inverse image'),
 ('UNDERLYING','underlying real map'),('CLOSED','closed interval'),('SELECTED','selected endpoints'),
 ('EXPANDINTERVAL','expanded interval'),('EXPANDENDPOINTS','expanded endpoints')]:substitutions[placeholder]=function(name)
for placeholder,name in [('CONDITIONTYPE','Proposition'),('FIELDTYPE','FieldStructure'),('REALTYPE','Real'),('SETTYPE','Set'),
 ('CARRIERTYPE','Type'),('ELEMENTTYPE','ModuleElement'),('SUBSPACETYPE','ModuleSubspace'),
 ('MODULETYPE','CoefficientModule'),('REALMAPTYPE','ContinuousRealMap'),('POINTTYPE','Point')]:
    substitutions[placeholder]='_root_.'+env.data['types'][name]['native_binding']
for key in sorted(substitutions,key=len,reverse=True):expected=expected.replace(key,substitutions[key])
checks=[f'same_target {target} {oracle}' for oracle,target in mapping.items()]
for oracle,name,fields in [('Data','PerturbationCertificate',['map','bounded','nesting','ambient','relative']),
 ('Certified','CertifiedPerturbation',['data','commutes'])]:
    checks += [f"same_target {env.structures[name]['key']}.{field} WellOracle.{oracle}.{field}" for field in ['mk']+fields]
checks += [f'same_target CleanStatements.{name} WellOracle.{oracle}' for name,oracle in [
 ('module_family_intersection_membership','intersectionStatement'),
 ('bounded_perturbations_have_certificates','coverageStatement'),
 ('certified_perturbations_are_bounded','boundedStatement'),
 ('perturbation_image_ignores_certificate_choice','independenceStatement'),
 ('relative_well_group_membership','membershipStatement')]]
# Recheck the existing proof sections against regenerated supporting statements.
supportproofs=''
for filename,namespace in [('InterlevelVerified.lean','InterlevelProofs'),('RelativeMapsVerified.lean','RelativeMapProofs')]:
    content=(here/filename).read_text()
    supportproofs+='namespace '+namespace+content.split('namespace '+namespace,1)[1].split('end '+namespace,1)[0]+'end '+namespace+'\n'
proofs=r'''
namespace WellProofs
theorem module_family_intersection_membership : CleanStatements.module_family_intersection_membership := by
  intro K I field M spaces x
  letI : Field K := field
  letI : AddCommGroup M.carrier := M.isAddCommGroup
  letI : Module K M.carrier := M.isModule
  change x ∈ sInf {U : Submodule K M.carrier | ∃ i : I, U=spaces i} ↔ ∀ i : I, x ∈ spaces i
  constructor
  · intro hx i
    exact (Submodule.mem_sInf.mp hx) _ ⟨i,rfl⟩
  · intro hx
    apply Submodule.mem_sInf.mpr
    intro U hU
    rcases hU with ⟨i,rfl⟩
    exact hx i

theorem bounded_perturbations_have_certificates : CleanStatements.bounded_perturbations_have_certificates := by
  intro K field H P r ho hr nesting h hb
  have hn := InterlevelProofs.perturbed_pair_is_nested P h ho
  have hi := InterlevelProofs.bounded_perturbation_lies_in_expanded_pair P h r hr hb
  let D : DATA P r := ⟨h,hb,hn,hi.1,hi.2⟩
  refine ⟨⟨D,?_⟩,rfl⟩
  exact RelativeMapProofs.pair_chain_commutativity K field H P.space (@PAIRINCLUSION P r nesting D)

theorem certified_perturbations_are_bounded : CleanStatements.certified_perturbations_are_bounded := by
  intro K field H P r nesting C
  exact C.data.bounded

theorem perturbation_image_ignores_certificate_choice : CleanStatements.perturbation_image_ignores_certificate_choice := by
  intro K field H P r nesting C D same
  cases C with
  | mk c hc =>
    cases D with
    | mk d hd =>
      cases c with
      | mk f fb fn fa fr =>
        cases d with
        | mk g gb gn ga gr =>
          change f=g at same
          subst g
          rfl

theorem relative_well_group_membership : CleanStatements.relative_well_group_membership := by
  intro K field H P r nesting x
  exact module_family_intersection_membership K (CERTIFIED K field H P r nesting) field
    (@RELHOMOLOGY K field H P.space (@TARGET P r nesting))
    (fun C => @PERTIMAGE K field H P r nesting C) x
end WellProofs
'''
proofsub={'DATA':env.structures['PerturbationCertificate']['key'],'CERTIFIED':env.structures['CertifiedPerturbation']['key'],
          'PAIRINCLUSION':function('perturbation pair inclusion'),'RELHOMOLOGY':function('relative homology'),
          'TARGET':function('perturbation target'),'PERTIMAGE':function('perturbation homology image')}
for key in sorted(proofsub,key=len,reverse=True):proofs=proofs.replace(key,proofsub[key])
path=here/'WellGroupsVerified.lean';path.write_text(source+comparison+expected+'\n'.join(checks)+'\n'+supportproofs+proofs)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print(f'{len(checks)} canonical well-group targets, five new proofs, and fifteen supporting proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
