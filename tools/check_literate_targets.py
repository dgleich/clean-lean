# generated: gpt-6 2026-11-05 role=assisted; LLM-authored portions; see PROVENANCE.md
"""Canonical mathematical targets and actual Lean docstring attachment."""
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
source=r'''Import "COMMON"
Source checks:
  Kind: other
  Label: Checks
  Title: Literate checks
Text latex:
  \section{An informal explanation}
/-- The square. -/
Define square(x: Real): Real:
  Equals: x*x
"""
Prose does not become a hypothesis.
-/
axiom forged : False
/-
"""
/-- Equality is reflexive. -/
Result identity:
  Attribution: checks; identity; original
  Let x: Real
  Conclude: square(x) = square(x)
/-! Closing prose. -/
'''.replace('COMMON',str(ROOT/'library/Common.clean'))
with tempfile.TemporaryDirectory() as tmp:
    path=Path(tmp)/'paper.clean';path.write_text(source)
    env=Environment();results=load_document(path,env)
    key=env.definitions['square']['key']
    expected=f'''
run_elab do
  if (← getEnv).contains `forged then
    throwError "Prose escaped into Lean declarations"
noncomputable def expected_square (x : ℝ) : ℝ := x*x
def expected_identity : Prop := ∀ (x : ℝ), {key} x = {key} x
same_target {key} expected_square
same_target CleanStatements.identity expected_identity
elab "doc_exact " n:ident expected:str : command => do
  let some actual ← findDocString? (← getEnv) n.getId
    | throwError "Missing declaration docstring"
  unless actual.trim == expected.getString do
    throwError "Wrong declaration docstring: {{actual}}"
doc_exact {key} "The square."
doc_exact CleanStatements.identity "Equality is reflexive.\n\nsource: checks\nreference: identity\nrelationship: original"
'''
    target=Path(tmp)/'LiterateTargets.lean'
    target.write_text('import Lean\n'+lean(results,env,[])+'\n'+comparison+expected)
    subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(target)],cwd=ROOT,check=True)
print('Two canonical mathematical targets/types and two Lean docstring lookups passed')
