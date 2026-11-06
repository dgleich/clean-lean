# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Verify explicit Mathlib algebra interfaces and authored indexed intersections."""
from pathlib import Path
import os, subprocess, sys
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
env=Environment();results=load_document(here/'Subspaces.clean',env)
source=lean(results,env,['Lean'])
(here/'Subspaces.lean').write_text(source)
(here/'Subspaces.tex').write_text(latex(results,env))
record=env.structures['LinearSpace']['key']
function=lambda n:env.data['functions'][n]['lean'].split()[0]
typekey=lambda n:next(k for k in env.notation_definitions if k.startswith('cleanType_'+n+'_'))
mapping={'SubspaceOracle.LinearSpace':record,
 'SubspaceOracle.fieldType':typekey('FieldStructure'),
 'SubspaceOracle.additiveType':typekey('AdditiveGroup'),
 'SubspaceOracle.moduleType':typekey('ModuleStructure'),
 'SubspaceOracle.subspaceType':typekey('Subspace'),
 'SubspaceOracle.makeSpace':function('linear space'),
 'SubspaceOracle.carrier':function('subspace carrier'),
 'SubspaceOracle.belongs':function('belongs to subspace'),
 'SubspaceOracle.included':function('subspace included in'),
 'SubspaceOracle.infimum':function('subspace infimum'),
 'SubspaceOracle.intersection':function('intersection of subspaces'),
 'SubspaceOracle.setOf':function('set of')}
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
namespace SubspaceOracle
noncomputable def fieldType (K : Type) : Type := Field K
noncomputable def additiveType (V : Type) : Type := AddCommGroup V
noncomputable def moduleType (K : Type) (f : Field K) (V : Type) (a : AddCommGroup V) : Type :=
  @Module K V f.toSemiring a.toAddCommMonoid
structure LinearSpace (K : Type) (f : Field K) (V : Type) : Type where
  addition : AddCommGroup V
  action : @Module K V f.toSemiring addition.toAddCommMonoid
noncomputable def makeSpace (K : Type) (f : Field K) (V : Type) (a : AddCommGroup V)
    (m : @Module K V f.toSemiring a.toAddCommMonoid) : LinearSpace K f V :=
  @LinearSpace.mk K f V a m
noncomputable def subspaceType (K : Type) (f : Field K) (V : Type) (L : LinearSpace K f V) : Type :=
  @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action
noncomputable def carrier {K V : Type} (f : Field K) (L : LinearSpace K f V)
    (U : @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) : Set V :=
  @SetLike.coe (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) V
    (@Submodule.setLike K V f.toSemiring L.addition.toAddCommMonoid L.action) U
noncomputable def belongs {K V : Type} (f : Field K) (L : LinearSpace K f V) (x : V)
    (U : @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) : Prop :=
  x ∈ @carrier K V f L U
noncomputable def included {K V : Type} (f : Field K) (L : LinearSpace K f V)
    (U W : @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) : Prop :=
  ∀ x : V, @belongs K V f L x U → @belongs K V f L x W
noncomputable def infimum {K V : Type} (f : Field K) (L : LinearSpace K f V)
    (S : Set (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action)) :
    @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action :=
  @sInf (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action)
    (@Submodule.instInfSet K V f.toSemiring L.addition.toAddCommMonoid L.action) S
noncomputable def setOf {X : Type} (condition : X → Prop) : Set X := _root_.setOf condition
noncomputable def intersection {K V I : Type} (f : Field K) (L : LinearSpace K f V)
    (A : Set I) (spaces : I → @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) :
    @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action :=
  @infimum K V f L (@setOf (@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action)
    (fun U => @Exists I (fun i => i ∈ A ∧ U=spaces i)))

def membershipStatement : Prop := ∀ (K V I : Type) (f : Field K) (L : LinearSpace K f V)
  (A : Set I) (spaces : I → @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) (x : V),
  @belongs K V f L x (@intersection K V I f L A spaces) ↔
    ∀ i : I, i ∈ A → @belongs K V f L x (spaces i)
def includedStatement : Prop := ∀ (K V I : Type) (f : Field K) (L : LinearSpace K f V)
  (A : Set I) (spaces : I → @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) (i : I),
  i ∈ A → @included K V f L (@intersection K V I f L A spaces) (spaces i)
def antitoneStatement : Prop := ∀ (K V I : Type) (f : Field K) (L : LinearSpace K f V)
  (A : Set I) (spaces : I → @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) (B : Set I),
  A ⊆ B → @included K V f L (@intersection K V I f L B spaces) (@intersection K V I f L A spaces)
def emptyStatement : Prop := ∀ (K V I : Type) (f : Field K) (L : LinearSpace K f V)
  (A : Set I) (spaces : I → @Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action) (x : V),
  (∀ i : I, ¬ i ∈ A) → @belongs K V f L x (@intersection K V I f L A spaces)
end SubspaceOracle
'''
checks=[f'same_target {target} {oracle}' for oracle,target in mapping.items()]
checks += [f'same_target {record}.{n} SubspaceOracle.LinearSpace.{n}' for n in ['mk','addition','action']]
checks += [f'same_target CleanStatements.{n} SubspaceOracle.{oracle}' for n,oracle in [
 ('indexed_intersection_membership','membershipStatement'),
 ('intersection_is_included_in_each_member','includedStatement'),
 ('more_indices_give_a_smaller_intersection','antitoneStatement'),
 ('empty_family_contains_every_vector','emptyStatement')]]
proofs=r'''
namespace SubspaceProofs
theorem indexed_intersection_membership : CleanStatements.indexed_intersection_membership := by
  intro K V I f L A spaces x
  letI : Field K := f
  letI : AddCommGroup V := L.addition
  letI : Module K V := L.action
  change x ∈ sInf {U : Submodule K V | ∃ i : I, i ∈ A ∧ U = spaces i} ↔
    ∀ i : I, i ∈ A → x ∈ spaces i
  constructor
  · intro hx i hi
    exact (Submodule.mem_sInf.mp hx) (spaces i) ⟨i,hi,rfl⟩
  · intro hx
    apply Submodule.mem_sInf.mpr
    intro U hU
    obtain ⟨i,hi,rfl⟩ := hU
    exact hx i hi

theorem intersection_is_included_in_each_member : CleanStatements.intersection_is_included_in_each_member := by
  intro K V I f L A spaces i hi x hx
  exact (indexed_intersection_membership K V I f L A spaces x).mp hx i hi

theorem more_indices_give_a_smaller_intersection : CleanStatements.more_indices_give_a_smaller_intersection := by
  intro K V I f L A spaces B hAB x hx
  apply (indexed_intersection_membership K V I f L A spaces x).mpr
  intro i hi
  exact (indexed_intersection_membership K V I f L B spaces x).mp hx i (hAB hi)

theorem empty_family_contains_every_vector : CleanStatements.empty_family_contains_every_vector := by
  intro K V I f L A spaces x hnone
  apply (indexed_intersection_membership K V I f L A spaces x).mpr
  intro i hi
  exact False.elim (hnone i hi)
end SubspaceProofs
'''
path=here/'SubspacesVerified.lean';path.write_text(source+comparison+expected+'\n'.join(checks)+'\n'+proofs)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print(f'{len(checks)} canonical algebra targets and four subspace proofs passed.')

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
