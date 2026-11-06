# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Check authored endpoint choices, interlevel pairs and their inclusions."""
from pathlib import Path
import os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
env=Environment();results=load_document(here/'Interlevel.clean',env)
source=lean(results,env,['Lean','Mathlib.Tactic.Linarith'])
(here/'Interlevel.lean').write_text(lean(results,env,[]))
(here/'Interlevel.tex').write_text(latex(results,env))
function=lambda n:env.data['functions'][n]['lean'].split()[0]
typekey=lambda n:next(k for k in env.notation_definitions if k.startswith('cleanType_'+n+'_'))
mapping={}
for oracle,actual in [('Ends','Endpoints'),('Selection','EndpointSelection'),('Problem','InterlevelProblem'),('Pair','SpacePairData')]:
    mapping['InterlevelOracle.'+oracle]=env.structures[actual]['key']
for oracle,actual in [('boolType','Boolean'),('realMapType','ContinuousRealMap')]:
    mapping['InterlevelOracle.'+oracle]=typekey(actual)
for oracle,actual in [('yes','true value'),('no','false value'),('ends','endpoints'),('shift','shifted endpoints'),
 ('selection','endpoint selection'),('neither','no endpoints'),('lowerOnly','lower endpoint'),
 ('upperOnly','upper endpoint'),('both','both endpoints'),('setOf','set of'),('preimage','inverse image'),
 ('underlying','underlying real map'),('closed','closed interval'),('selected','selected endpoints'),
 ('expanded','expanded interval'),('boundary','expanded endpoints'),('problem','interlevel problem'),
 ('pair','space pair data'),('nested','nested pair'),('expandedPair','expanded pair'),
 ('shiftedPair','shifted pair'),('included','pair included in'),('evaluate','evaluate map'),
 ('value','real map value'),('bounded','bounded perturbation'),('perturbed','perturbed pair'),('certify','certify pair data'),('represents','has pair data')]:mapping['InterlevelOracle.'+oracle]=function(actual)
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
namespace InterlevelOracle
noncomputable def boolType : Type := Bool
noncomputable def yes : Bool := true
noncomputable def no : Bool := false
structure Ends : Type where
  lower : ℝ
  upper : ℝ
noncomputable def ends (lower upper : ℝ) : Ends := @Ends.mk lower upper
noncomputable def shift (I : Ends) (s : ℝ) : Ends := @ends (I.lower+s) (I.upper+s)
structure Selection : Type where
  lower : Bool
  upper : Bool
noncomputable def selection (lower upper : Bool) : Selection := @Selection.mk lower upper
noncomputable def neither : Selection := @selection no no
noncomputable def lowerOnly : Selection := @selection yes no
noncomputable def upperOnly : Selection := @selection no yes
noncomputable def both : Selection := @selection yes yes
noncomputable def setOf {X : Type} (condition : X → Prop) : Set X := _root_.setOf condition
noncomputable def preimage {X Y : Type} (f : X → Y) (S : Set Y) : Set X := setOf (fun x : X => f x ∈ S)
noncomputable def realMapType (X : TopCat.{0}) : Type :=
  @ContinuousMap X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace
noncomputable def underlying (X : TopCat.{0})
  (f : @ContinuousMap X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace) : X.carrier → ℝ :=
  @ContinuousMap.toFun X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace f
noncomputable def closed (I : Ends) : Set ℝ := setOf (fun x : ℝ => I.lower ≤ x ∧ x ≤ I.upper)
noncomputable def selected (I : Ends) (E : Selection) : Set ℝ :=
  setOf (fun x : ℝ => (E.lower=yes ∧ x=I.lower) ∨ (E.upper=yes ∧ x=I.upper))
noncomputable def expanded (I : Ends) (r : ℝ) : Set ℝ := setOf (fun x : ℝ => I.lower-r ≤ x ∧ x ≤ I.upper+r)
noncomputable def boundary (I : Ends) (E : Selection) (r : ℝ) : Set ℝ :=
  setOf (fun x : ℝ => ((E.lower=yes ∧ I.lower-r ≤ x) ∧ x ≤ I.lower+r) ∨
                     ((E.upper=yes ∧ I.upper-r ≤ x) ∧ x ≤ I.upper+r))
structure Problem : Type 1 where
  space : TopCat.{0}
  map : @ContinuousMap space.carrier ℝ space.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace
  interval : Ends
  selection : Selection
noncomputable def problem (space : TopCat.{0})
  (map : @ContinuousMap space.carrier ℝ space.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace)
  (interval : Ends) (selection : Selection) : Problem := @Problem.mk space map interval selection
structure Pair (X : TopCat.{0}) : Type where
  ambient : Set X.carrier
  relative : Set X.carrier
noncomputable def pair (X : TopCat.{0}) (ambient relative : Set X.carrier) : Pair X := @Pair.mk X ambient relative
noncomputable def nested (X : TopCat.{0}) (Q : Pair X) : Prop := Q.relative ⊆ Q.ambient
noncomputable def expandedPair (P : Problem) (r : ℝ) : Pair P.space :=
  @pair P.space (preimage (@underlying P.space P.map) (expanded P.interval r))
               (preimage (@underlying P.space P.map) (boundary P.interval P.selection r))
noncomputable def shiftedPair (P : Problem) (t : ℝ) : Pair P.space :=
  @pair P.space (preimage (@underlying P.space P.map) (closed (shift P.interval t)))
               (preimage (@underlying P.space P.map) (selected (shift P.interval t) P.selection))
noncomputable def included (X : TopCat.{0}) (Q R : Pair X) : Prop :=
  Q.ambient ⊆ R.ambient ∧ Q.relative ⊆ R.relative

noncomputable def evaluate {X Y : Type} (f : X → Y) (x : X) : Y := f x
noncomputable def value (X : TopCat.{0})
  (f : @ContinuousMap X.carrier ℝ X.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace) (x : X.carrier) : ℝ :=
  evaluate (@underlying X f) x
noncomputable def bounded (P : Problem)
  (h : @ContinuousMap P.space.carrier ℝ P.space.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace) (r : ℝ) : Prop :=
  ∀ x : P.space.carrier, -r ≤ @value P.space h x - @value P.space P.map x ∧
    @value P.space h x - @value P.space P.map x ≤ r
noncomputable def perturbed (P : Problem)
  (h : @ContinuousMap P.space.carrier ℝ P.space.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace) : Pair P.space :=
  @pair P.space (preimage (@underlying P.space h) (closed P.interval))
               (preimage (@underlying P.space h) (selected P.interval P.selection))

def choicesStatement : Prop := ∀ E : Selection, ((E=neither ∨ E=lowerOnly) ∨ E=upperOnly) ∨ E=both
def endpointsStatement : Prop := ∀ (I : Ends) (E : Selection), I.lower ≤ I.upper → selected I E ⊆ closed I
def expandedStatement : Prop := ∀ (P : Problem) (r : ℝ), P.interval.lower ≤ P.interval.upper → r ≥ 0 →
  @nested P.space (@expandedPair P r)
def shiftedStatement : Prop := ∀ (P : Problem) (t : ℝ), P.interval.lower ≤ P.interval.upper →
  @nested P.space (@shiftedPair P t)
def inclusionStatement : Prop := ∀ (P : Problem) (r t : ℝ), r ≥ 0 → (-r ≤ t ∧ t ≤ r) →
  @included P.space (@shiftedPair P t) (@expandedPair P r)
def perturbedStatement : Prop := ∀ (P : Problem)
  (h : @ContinuousMap P.space.carrier ℝ P.space.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace),
  P.interval.lower ≤ P.interval.upper → @nested P.space (@perturbed P h)
def boundedStatement : Prop := ∀ (P : Problem)
  (h : @ContinuousMap P.space.carrier ℝ P.space.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace) (r : ℝ),
  r ≥ 0 → @bounded P h r → @included P.space (@perturbed P h) (@expandedPair P r)
noncomputable def certify (X : TopCat.{0}) (Q : Pair X) (h : Q.relative ⊆ Q.ambient) : CERTPAIR X :=
  @CERTCONSTRUCTOR X Q.ambient Q.relative h
noncomputable def represents (X : TopCat.{0}) (Q : CERTPAIR X) (S : Pair X) : Prop :=
  Q.ambient=S.ambient ∧ Q.relative=S.relative
def certifiedExpandedStatement : Prop := ∀ (P : Problem) (r : ℝ),
  P.interval.lower ≤ P.interval.upper → r ≥ 0 →
  let T : Pair P.space := @expandedPair P r;
  ∃ Q : CERTPAIR P.space, @represents P.space Q T
def certifiedShiftStatement : Prop := ∀ (P : Problem) (r t : ℝ),
  P.interval.lower ≤ P.interval.upper → r ≥ 0 → (-r ≤ t ∧ t ≤ r) →
  let S : Pair P.space := @shiftedPair P t;
  let T : Pair P.space := @expandedPair P r;
  ∃ Q : CERTINCLUSION P.space,
    @represents P.space Q.source S ∧ @represents P.space Q.target T
def certifiedPerturbationStatement : Prop := ∀ (P : Problem)
  (h : @ContinuousMap P.space.carrier ℝ P.space.str Real.pseudoMetricSpace.toUniformSpace.toTopologicalSpace) (r : ℝ),
  P.interval.lower ≤ P.interval.upper → r ≥ 0 → @bounded P h r →
  let S : Pair P.space := @perturbed P h;
  let T : Pair P.space := @expandedPair P r;
  ∃ Q : CERTINCLUSION P.space,
    @represents P.space Q.source S ∧ @represents P.space Q.target T

end InterlevelOracle
'''
expected=expected.replace('CERTPAIR',env.structures['TopologicalPair']['key']).replace('CERTINCLUSION',env.structures['PairInclusion']['key']).replace('CERTCONSTRUCTOR',function('topological pair'))
checks=[f'same_target {target} {oracle}' for oracle,target in mapping.items()]
for name,fields in [('Ends',['mk','lower','upper']),('Selection',['mk','lower','upper']),
                    ('Problem',['mk','space','map','interval','selection']),('Pair',['mk','ambient','relative'])]:
    checks += [f'same_target {mapping["InterlevelOracle."+name]}.{field} InterlevelOracle.{name}.{field}' for field in fields]
checks += [f'same_target CleanStatements.{name} InterlevelOracle.{oracle}' for name,oracle in [
 ('endpoint_choices_are_exhaustive','choicesStatement'),('selected_endpoints_lie_in_the_interval','endpointsStatement'),
 ('expanded_pair_is_nested','expandedStatement'),('shifted_pair_is_nested','shiftedStatement'),
 ('shifted_pair_lies_in_expanded_pair','inclusionStatement'),
 ('perturbed_pair_is_nested','perturbedStatement'),('bounded_perturbation_lies_in_expanded_pair','boundedStatement'),
 ('expanded_pair_has_a_certificate','certifiedExpandedStatement'),
 ('bounded_shift_has_a_certified_inclusion','certifiedShiftStatement'),
 ('bounded_perturbation_has_a_certified_inclusion','certifiedPerturbationStatement')]]
proofs=r'''
namespace InterlevelProofs
theorem endpoint_choices_are_exhaustive : CleanStatements.endpoint_choices_are_exhaustive := by
  intro E
  rcases E with ⟨l,u⟩
  cases l <;> cases u <;>
    first | exact Or.inl (Or.inl (Or.inl rfl)) | exact Or.inl (Or.inl (Or.inr rfl)) |
            exact Or.inl (Or.inr rfl) | exact Or.inr rfl

theorem selected_endpoints_lie_in_the_interval : CleanStatements.selected_endpoints_lie_in_the_interval := by
  intro I E h x hx
  change (E.lower=true ∧ x=I.lower) ∨ (E.upper=true ∧ x=I.upper) at hx
  change I.lower ≤ x ∧ x ≤ I.upper
  rcases hx with ⟨_,rfl⟩ | ⟨_,rfl⟩
  · exact ⟨le_refl _,h⟩
  · exact ⟨h,le_refl _⟩

theorem expanded_pair_is_nested : CleanStatements.expanded_pair_is_nested := by
  intro P r ho _hr x hx
  change ((P.selection.lower=true ∧ P.interval.lower-r ≤ P.map x) ∧ P.map x ≤ P.interval.lower+r) ∨
    ((P.selection.upper=true ∧ P.interval.upper-r ≤ P.map x) ∧ P.map x ≤ P.interval.upper+r) at hx
  change P.interval.lower-r ≤ P.map x ∧ P.map x ≤ P.interval.upper+r
  rcases hx with ⟨⟨_,hl⟩,hu⟩ | ⟨⟨_,hl⟩,hu⟩
  · exact ⟨hl, by linarith⟩
  · exact ⟨by linarith, hu⟩

theorem shifted_pair_is_nested : CleanStatements.shifted_pair_is_nested := by
  intro P t ho x hx
  change (P.selection.lower=true ∧ P.map x=P.interval.lower+t) ∨
    (P.selection.upper=true ∧ P.map x=P.interval.upper+t) at hx
  change P.interval.lower+t ≤ P.map x ∧ P.map x ≤ P.interval.upper+t
  rcases hx with ⟨_,he⟩ | ⟨_,he⟩
  · constructor <;> linarith
  · constructor <;> linarith

theorem shifted_pair_lies_in_expanded_pair : CleanStatements.shifted_pair_lies_in_expanded_pair := by
  intro P r t _hr ht
  constructor
  · intro x hx
    change P.interval.lower+t ≤ P.map x ∧ P.map x ≤ P.interval.upper+t at hx
    change P.interval.lower-r ≤ P.map x ∧ P.map x ≤ P.interval.upper+r
    constructor <;> linarith [hx.1,hx.2,ht.1,ht.2]
  · intro x hx
    change (P.selection.lower=true ∧ P.map x=P.interval.lower+t) ∨
      (P.selection.upper=true ∧ P.map x=P.interval.upper+t) at hx
    change ((P.selection.lower=true ∧ P.interval.lower-r ≤ P.map x) ∧ P.map x ≤ P.interval.lower+r) ∨
      ((P.selection.upper=true ∧ P.interval.upper-r ≤ P.map x) ∧ P.map x ≤ P.interval.upper+r)
    rcases hx with ⟨he,hx⟩ | ⟨he,hx⟩
    · left
      exact ⟨⟨he,by linarith [ht.1]⟩,by linarith [ht.2]⟩
    · right
      exact ⟨⟨he,by linarith [ht.1]⟩,by linarith [ht.2]⟩
theorem perturbed_pair_is_nested : CleanStatements.perturbed_pair_is_nested := by
  intro P h ho x hx
  change (P.selection.lower=true ∧ h x=P.interval.lower) ∨
    (P.selection.upper=true ∧ h x=P.interval.upper) at hx
  change P.interval.lower ≤ h x ∧ h x ≤ P.interval.upper
  rcases hx with ⟨_,he⟩ | ⟨_,he⟩
  · constructor <;> linarith
  · constructor <;> linarith

theorem bounded_perturbation_lies_in_expanded_pair : CleanStatements.bounded_perturbation_lies_in_expanded_pair := by
  intro P h r _hr hb
  change ∀ x : P.space.carrier, -r ≤ h x-P.map x ∧ h x-P.map x ≤ r at hb
  constructor
  · intro x hx
    change P.interval.lower ≤ h x ∧ h x ≤ P.interval.upper at hx
    change P.interval.lower-r ≤ P.map x ∧ P.map x ≤ P.interval.upper+r
    constructor <;> linarith [(hb x).1,(hb x).2,hx.1,hx.2]
  · intro x hx
    change (P.selection.lower=true ∧ h x=P.interval.lower) ∨
      (P.selection.upper=true ∧ h x=P.interval.upper) at hx
    change ((P.selection.lower=true ∧ P.interval.lower-r ≤ P.map x) ∧ P.map x ≤ P.interval.lower+r) ∨
      ((P.selection.upper=true ∧ P.interval.upper-r ≤ P.map x) ∧ P.map x ≤ P.interval.upper+r)
    rcases hx with ⟨he,hx⟩ | ⟨he,hx⟩
    · left
      exact ⟨⟨he,by linarith [(hb x).1,(hb x).2]⟩,by linarith [(hb x).1,(hb x).2]⟩
    · right
      exact ⟨⟨he,by linarith [(hb x).1,(hb x).2]⟩,by linarith [(hb x).1,(hb x).2]⟩
theorem expanded_pair_has_a_certificate : CleanStatements.expanded_pair_has_a_certificate := by
  intro P r ho hr
  let T := EXPANDED P r
  refine ⟨⟨T.ambient,T.relative,?_⟩,rfl,rfl⟩
  exact expanded_pair_is_nested P r ho hr

theorem bounded_shift_has_a_certified_inclusion : CleanStatements.bounded_shift_has_a_certified_inclusion := by
  intro P r t ho hr ht
  let S := SHIFTED P t
  let T := EXPANDED P r
  have hs := shifted_pair_is_nested P t ho
  have ht' := expanded_pair_is_nested P r ho hr
  have hi := shifted_pair_lies_in_expanded_pair P r t hr ht
  refine ⟨⟨⟨S.ambient,S.relative,hs⟩,⟨T.ambient,T.relative,ht'⟩,hi.1,hi.2⟩,?_⟩
  exact ⟨⟨rfl,rfl⟩,⟨rfl,rfl⟩⟩

theorem bounded_perturbation_has_a_certified_inclusion : CleanStatements.bounded_perturbation_has_a_certified_inclusion := by
  intro P h r ho hr hb
  let S := PERTURBED P h
  let T := EXPANDED P r
  have hs := perturbed_pair_is_nested P h ho
  have ht := expanded_pair_is_nested P r ho hr
  have hi := bounded_perturbation_lies_in_expanded_pair P h r hr hb
  refine ⟨⟨⟨S.ambient,S.relative,hs⟩,⟨T.ambient,T.relative,ht⟩,hi.1,hi.2⟩,?_⟩
  exact ⟨⟨rfl,rfl⟩,⟨rfl,rfl⟩⟩

end InterlevelProofs
'''
proofs=proofs.replace('EXPANDED',function('expanded pair')).replace('SHIFTED',function('shifted pair')).replace('PERTURBED',function('perturbed pair'))
path=here/'InterlevelVerified.lean';path.write_text(source+comparison+expected+'\n'.join(checks)+'\n'+proofs)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print(f'{len(checks)} canonical interlevel targets and ten proofs passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
