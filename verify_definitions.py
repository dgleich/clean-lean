"""Independent structural target checks for a bounded Define slice (Lean 4.24.0).
No reduction, unfolding, proof irrelevance, or definitional equality is used.
Run: python3 verify_definitions.py && lake env lean generated/VerifiedDefinitions.lean
"""
from pathlib import Path
from cleanlang.core import Environment, lean
from cleanlang.modules import load_module

ROOT = Path(__file__).resolve().parent
env = Environment()
for module in ('analysis', 'linear_algebra'):
    load_module(ROOT / 'library' / (module + '.clean'), env)
# Authored independently of the translator's output; preserve even binder explicitness.
cases = [
    ('square', ['Operator', '^', ['Local', 'x'], ['Decimal', '2']],
     'noncomputable def expected_square (a : ℝ) : ℝ := a ^ (2 : ℕ)'),
    ('commutator', ['Operator', '-', ['Operator', '*', ['Local', 'A'], ['Local', 'B']],
                   ['Operator', '*', ['Local', 'B'], ['Local', 'A']]],
     'noncomputable def expected_commutator {k : ℕ} (X Y : Matrix (Fin k) (Fin k) ℂ) : Matrix (Fin k) (Fin k) ℂ := X * Y - Y * X'),
    ('matrix square', ['Operator', '*', ['Local', 'A'], ['Local', 'A']],
     'noncomputable def expected_matrix_square {k : ℕ} (X : Matrix (Fin k) (Fin k) ℂ) : Matrix (Fin k) (Fin k) ℂ := X * X'),
]
checks = r'''
open Lean Elab Command
-- Strip only metadata and binder display names. Retain binderInfo, universes,
-- constants, implicit/instance/proof applications, and every other constructor.
private def canonical : Expr → Expr
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj n i (canonical b)
  | e => e
private def sameTarget (a b : Name) : CommandElabM Bool := do
  let env ← getEnv
  let some (.defnInfo x) := env.find? a | throwError "Missing definition {a}"
  let some (.defnInfo y) := env.find? b | throwError "Missing definition {b}"
  return x.levelParams == y.levelParams &&
    Expr.equal (canonical x.type) (canonical y.type) &&
    Expr.equal (canonical x.value) (canonical y.value)
elab "assert_same_target " a:ident b:ident : command => do
  unless ← sameTarget a.getId b.getId do
    throwError "Canonical target mismatch: {a} versus {b}"
elab "assert_different_target " a:ident b:ident : command => do
  if ← sameTarget a.getId b.getId then
    throwError "Comparator failed to distinguish {a} from {b}"
-- Guard against accidentally weakening the comparator to Expr.eqv/isDefEq.
def explicit_binder (x : Nat) := x
def implicit_binder {x : Nat} := x
def reduced_identity (x : Nat) := (fun y => y) x
assert_different_target explicit_binder implicit_binder
assert_different_target explicit_binder reduced_identity
'''
out = ['import Lean', lean([], env, []), checks]
for name, expected_tree, expected_lean in cases:
    actual = env.definitions[name]
    assert actual['tree'] == expected_tree, (name, actual['tree'], expected_tree)
    out.extend([expected_lean, f'assert_same_target {actual["key"]} expected_{name.replace(" ", "_")}'])
# The compact cosine signature has an independent normalized signature and Lean target.
cosine = env.data['functions']['cos']
assert cosine['signature_tree'] == ['Signature','cos', [['Parameter','x0','Real','explicit']], 'Real']
out.extend(['noncomputable def expected_cos (a : ℝ) : ℝ := Real.cos a',
            f"assert_same_target {cosine['lean'].split()[0]} expected_cos"])
(ROOT/'generated/VerifiedDefinitions.lean').write_text('\n'.join(out)+'\n')
print('Checked 3 expression trees; wrote 4 canonical Lean target checks and 2 comparator guards')
