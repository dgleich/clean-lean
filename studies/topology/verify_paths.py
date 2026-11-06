# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Independent dependent-wrapper/statement targets, plus actual path proofs."""
from pathlib import Path
import os
import subprocess
import sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from cleanlang.core import Environment, lean, latex
from cleanlang.modules import load_document
here = Path(__file__).resolve().parent
env = Environment()
results = load_document(here / 'Paths.clean', env)
source = lean(results, env, ['Lean'])
(here / 'Paths.lean').write_text(source)
(here / 'Paths.tex').write_text(latex(results, env))
keys = {name: spec['dependent_signature']['key'] for name, spec in env.data['functions'].items()
        if 'dependent_signature' in spec}
comparison = r'''
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
    throwError "Canonical type or value differs: {a} vs {b}"
'''
expected = f'''
namespace PathOracles
noncomputable def underlying {{X : Type}} (S : Set X) (x : {{x : X // x ∈ S}}) : X := x.val
noncomputable def constant {{X : Type}} (t : TopologicalSpace X) (x : X) : @Path X t x x :=
  @Path.refl X t x
noncomputable def reverse {{X : Type}} (t : TopologicalSpace X) (x y : X)
    (p : @Path X t x y) : @Path X t y x := @Path.symm X t x y p
noncomputable def join {{X : Type}} (t : TopologicalSpace X) (x y z : X)
    (p : @Path X t x y) (q : @Path X t y z) : @Path X t x z :=
  @Path.trans X t x y z p q
noncomputable def twice {{X : Type}} (t : TopologicalSpace X) (x y : X)
    (p : @Path X t x y) : @Path X t x y :=
  @{keys['reverse path']} X t y x (@{keys['reverse path']} X t x y p)

def member : Prop := ∀ (X : Type) (S : Set X) (x : {{x : X // x ∈ S}}),
  @{keys['underlying point']} X S x ∈ S
def reversing : Prop := ∀ (X : Type) (t : TopologicalSpace X) (x y : X) (p : @Path X t x y),
  @{keys['reverse twice']} X t x y p = p
def constants : Prop := ∀ (X : Type) (t : TopologicalSpace X),
  ∀ (x : X), @Exists (@Path X t x x) (fun p => p = @{keys['constant path']} X t x)
def joined : Prop := ∀ (X : Type) (t : TopologicalSpace X) (x y z : X)
  (p : @Path X t x y) (q : @Path X t y z),
  @Exists (@Path X t x z) (fun r => r = @{keys['join paths']} X t x y z p q)
end PathOracles
same_target {keys['underlying point']} PathOracles.underlying
same_target {keys['constant path']} PathOracles.constant
same_target {keys['reverse path']} PathOracles.reverse
same_target {keys['join paths']} PathOracles.join
same_target {keys['reverse twice']} PathOracles.twice
same_target CleanStatements.underlying_point_belongs PathOracles.member
same_target CleanStatements.reversing_a_path_twice PathOracles.reversing
same_target CleanStatements.constant_paths_exist PathOracles.constants
same_target CleanStatements.paths_can_be_joined PathOracles.joined

namespace PathProofs
theorem underlying_point_belongs : CleanStatements.underlying_point_belongs := by
  intro X S x
  exact x.property
theorem reversing_a_path_twice : CleanStatements.reversing_a_path_twice := by
  intro X t x y p
  exact @Path.symm_symm X t x y p
theorem constant_paths_exist : CleanStatements.constant_paths_exist := by
  intro X t x
  exact ⟨@Path.refl X t x, rfl⟩
theorem paths_can_be_joined : CleanStatements.paths_can_be_joined := by
  intro X t x y z p q
  exact ⟨@Path.trans X t x y z p q, rfl⟩
end PathProofs
'''
path = here / 'PathsVerified.lean'
path.write_text(source + comparison + expected)
subprocess.run([os.environ.get('LAKE', 'lake'), 'env', 'lean', str(path)], cwd=ROOT, check=True)
print('Five canonical wrapper targets, four statement targets, and four proofs passed.')

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
