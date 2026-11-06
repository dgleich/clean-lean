# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Independent elaborated quantifier target checks, including universes."""
from pathlib import Path
import os, subprocess, sys, tempfile
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment, Expressions
from cleanlang.modules import load_module
env=Environment();load_module(ROOT/'library/topology/basic.clean',env)
cases=[
 ('for every (X: Type, for every (x: X, x=x))', '∀ (X : Type), ∀ (x : X), x=x'),
 ('for every (n: Natural, there exists (x: Vector(n,Real), x=x))',
  '∀ (n : ℕ), @Exists (Fin n → ℝ) (fun x => x=x)'),
 ('for every (x: Real, x=x)', '∀ (x : ℝ), x=x'),
 ('there exists (x: Real, x=x)', '@Exists ℝ (fun (x : ℝ) => x=x)'),
 ('for every (x: Real, there exists (y: Real, x=y))',
  '∀ (x : ℝ), @Exists ℝ (fun (y : ℝ) => x=y)'),
 ('there exists (x: Real,x=x) and for every (x: Real,x=x)',
  '(@Exists ℝ (fun (x : ℝ) => x=x)) ∧ (∀ (x : ℝ), x=x)'),
]
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
lines=['import Lean','import Mathlib.Data.Real.Basic',comparison]
for i,(source,expected) in enumerate(cases):
 actual=Expressions(env,{}).parse(source)
 lines += [f'def actual_{i} : Prop := {actual.lean}',
           f'def expected_{i} : Prop := {expected}',
           f'same_target actual_{i} expected_{i}']
with tempfile.TemporaryDirectory() as tmp:
 path=Path(tmp)/'QuantifierTargets.lean';path.write_text('\n'.join(lines))
 subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Six independent canonical quantifier target/type comparisons passed')

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
