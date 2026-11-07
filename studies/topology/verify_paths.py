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
k = lambda name: env.data['types'][name]['native_binding']
K, S, T, E, P = ('_root_.' + k(name) for name in ['Type', 'Set', 'Topology', 'Element', 'Path'])
type_checks = ''
for i, (name, binders, sort, body) in enumerate([
    ('Type', '', 'Type 1', 'Type'),
    ('Set', '(X : Type)', 'Type', 'Set X'),
    ('Topology', '(X : Type)', 'Type', 'TopologicalSpace X'),
    ('Element', f'(X : Type) (S : {S} X)', 'Type', '{x : X // x ∈ S}'),
    ('Path', f'(X : Type) (t : {T} X) (x y : X)', 'Type', '@Path X t x y')]):
    type_checks += f'\nnoncomputable def expected_path_type_{i} {binders} : {sort} := {body}\nsame_target {k(name)} expected_path_type_{i}\n'
expected = f'''
namespace PathOracles
noncomputable def underlying {{X : Type}} (S : {S} X) (x : {E} X S) : X := x.val
noncomputable def constant {{X : Type}} (t : {T} X) (x : X) : {P} X t x x :=
  @Path.refl X t x
noncomputable def reverse {{X : Type}} (t : {T} X) (x y : X)
    (p : {P} X t x y) : {P} X t y x := @Path.symm X t x y p
noncomputable def join {{X : Type}} (t : {T} X) (x y z : X)
    (p : {P} X t x y) (q : {P} X t y z) : {P} X t x z :=
  @Path.trans X t x y z p q
noncomputable def twice {{X : Type}} (t : {T} X) (x y : X)
    (p : {P} X t x y) : {P} X t x y :=
  @_root_.{keys['reverse path']} X t y x (@_root_.{keys['reverse path']} X t x y p)

def member : Prop := ∀ (X : {K}) (S : {S} X) (x : {E} X S),
  @_root_.{keys['underlying point']} X S x ∈ S
def reversing : Prop := ∀ (X : {K}) (t : {T} X) (x y : X) (p : {P} X t x y),
  @_root_.{keys['reverse twice']} X t x y p = p
def constants : Prop := ∀ (X : {K}) (t : {T} X),
  ∀ (x : X), @Exists ({P} X t x x) (fun p => p = @_root_.{keys['constant path']} X t x)
def joined : Prop := ∀ (X : {K}) (t : {T} X) (x y z : X)
  (p : {P} X t x y) (q : {P} X t y z),
  @Exists ({P} X t x z) (fun r => r = @_root_.{keys['join paths']} X t x y z p q)
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
path.write_text(source + comparison + type_checks + expected)
subprocess.run([os.environ.get('LAKE', 'lake'), 'env', 'lean', str(path)], cwd=ROOT, check=True)
print('Fourteen canonical path type/wrapper/statement targets and four proofs passed.')

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
