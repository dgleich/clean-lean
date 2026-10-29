# generated: gpt-6 2026-10-29 role=assisted; LLM-authored portions; see PROVENANCE.md
"""Compare independently authored elaborated lambda targets; requires pinned Lean."""
from pathlib import Path
import os
import subprocess
import sys
import tempfile
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment, Expressions, Expr, Type
from cleanlang.modules import load_module

env=Environment();load_module(ROOT/'library/types.clean',env)
cases=[
    ('function(x: Real,x)',{},'', 'fun (x : ℝ) => x'),
    ('function(x: Real,a+x)',{'a':Expr('a','a',Type('Real'))},'(a : ℝ)',
     'fun (x : ℝ) => a + x'),
    ('function(f: Function(Real,Real),function(x: Real,f(x)))',{},'',
     'fun (f : ℝ → ℝ) => fun (x : ℝ) => f x'),
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
for i,(source,locals,params,expected) in enumerate(cases):
    actual=Expressions(env,locals).parse(source)
    typ=env.render_type(actual.type,'lean')
    # Expected type is authored independently, not obtained from the actual expression.
    expected_type='(ℝ → ℝ) → ℝ → ℝ' if i==2 else 'ℝ → ℝ'
    lines += [f'noncomputable def actual_{i} {params} : {typ} := {actual.lean}',
              f'noncomputable def expected_{i} {params} : {expected_type} := {expected}',
              f'same_target actual_{i} expected_{i}']
with tempfile.TemporaryDirectory() as tmp:
    path=Path(tmp)/'FunctionTargets.lean';path.write_text('\n'.join(lines))
    subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Three independent canonical function target/type comparisons passed')
