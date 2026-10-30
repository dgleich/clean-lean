# generated: gpt-6 2026-10-30 role=assisted; LLM-authored portions; see PROVENANCE.md
"""Independent canonical Lean targets for conditions and grouped hypotheses."""
from pathlib import Path
import os, subprocess, sys, tempfile
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment, lean
from cleanlang.modules import load_document
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
source='''Import "COMMON"
Source checks:
  Kind: other
  Label: Checks
  Title: Condition target checks
Condition positive(x: Real):
  Holds when: x > 0
  Assumption name: positivity of {x}
Condition imported positive(x: Real):
  From Lean: x > 0
Result two positive values:
  Attribution: checks; two positive values; original
  Let x,y: Real
  Assume positive(x), positive(y)
  Conclude: x > 0 and y > 0
'''.replace('COMMON',str(ROOT/'library/Common.clean'))
with tempfile.TemporaryDirectory() as tmp:
    path=Path(tmp)/'source.clean';path.write_text(source)
    env=Environment();results=load_document(path,env)
    defined=env.definitions['positive']['key']
    imported=env.definitions['imported positive']['key']
    expected=f'''
noncomputable def expected_condition (x : ℝ) : Prop := x > 0
-- Expected binders and conclusion are authored independently; condition references
-- use the separately checked generated constant, without delta reduction.
def expected_result : Prop := ∀ (x y : ℝ),
  ∀ (hx : {defined} x) (hy : {defined} y), x > 0 ∧ y > 0
same_target {defined} expected_condition
same_target {imported} expected_condition
same_target CleanStatements.two_positive_values expected_result
'''
    target=Path(tmp)/'ConditionTargets.lean'
    target.write_text('import Lean\n'+lean(results,env,[])+'\n'+comparison+expected)
    subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(target)],cwd=ROOT,check=True)
print('Three independent canonical condition and statement target/type comparisons passed')
