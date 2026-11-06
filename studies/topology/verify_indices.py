# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Generate and check independent named-index target oracles and genuine proofs."""
from pathlib import Path
import os, subprocess, sys
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment, lean, latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
env=Environment();rs=load_document(here/'ValueIndices.clean',env)
source=lean(rs,env,['Lean'])
(here/'ValueIndices.lean').write_text(source)
(here/'ValueIndices.tex').write_text(latex(rs,env))
pre=env.definitions['inverse image']['key']
comparison=r'''
open Lean Elab Command
private def canonical : Expr → Expr
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj n i (canonical b)
  | e => e
elab "same_target " a:ident b:ident : command => do
  let env ← getEnv
  let some (.defnInfo x) := env.find? a.getId | throwError "Missing actual target"
  let some (.defnInfo y) := env.find? b.getId | throwError "Missing expected target"
  unless x.levelParams == y.levelParams &&
      Expr.equal (canonical x.type) (canonical y.type) &&
      Expr.equal (canonical x.value) (canonical y.value) do
    throwError "Canonical type or value differs"
'''
expected=f"""
namespace ValueIndexOracles

def subsetElement : Prop :=
  ∀ (X : Type) (S : Set X) (x : {{x : X // x ∈ S}}), x=x

def pathReflexivity : Prop :=
  ∀ (X : Type) (t : TopologicalSpace X) (x y : X) (p : @Path X t x y), p=p

def constantPath : Prop :=
  ∀ (X : Type) (t : TopologicalSpace X),
    ∀ (x : X), @Exists (@Path X t x x) (fun p => p=p)

def namedSubset : Prop :=
  ∀ (X Y : Type) (f : X → Y) (S : Set Y),
    let T : Set X := {pre} f S
    ∀ (x : {{x : X // x ∈ T}}), x=x

end ValueIndexOracles
same_target CleanStatements.subset_element_reflexivity ValueIndexOracles.subsetElement
same_target CleanStatements.path_reflexivity ValueIndexOracles.pathReflexivity
same_target CleanStatements.constant_path_exists ValueIndexOracles.constantPath
same_target CleanStatements.named_subset_expression ValueIndexOracles.namedSubset

namespace ValueIndexProofs

theorem subset_element_reflexivity : CleanStatements.subset_element_reflexivity := by
  intro X S x
  rfl

theorem path_reflexivity : CleanStatements.path_reflexivity := by
  intro X t x y p
  rfl

theorem constant_path_exists : CleanStatements.constant_path_exists := by
  intro X t x
  exact ⟨@Path.refl X t x, rfl⟩

theorem named_subset_expression : CleanStatements.named_subset_expression := by
  intro X Y f S
  dsimp
  intro x
  rfl

end ValueIndexProofs
"""
path=here/'ValueIndicesVerified.lean';path.write_text(source+comparison+expected)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Four canonical indexed-type statement targets and four proofs passed.')

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
