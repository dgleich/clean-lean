# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Independent closed targets for computed natural dimensions and substitution."""
from pathlib import Path
import os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Expressions,Expr,Type
from cleanlang.modules import load_module,notation
E=Environment();load_module(ROOT/'library/types.clean',E)
notation('Notation next size(n):',['Let n: Natural','Returns: Natural','Means: Nat.succ n','Render latex: {n}+1'],E)
notation('Notation keep vector(n,x):',['Let n: Natural','Let x: Vector((next size(n)),Real)',
          'Returns: Vector((next size(n)),Real)','Means: x','Render latex: {x}'],E)
next_key=E.data['functions']['next size']['lean'].split()[0]
keep_key=E.data['functions']['keep vector']['lean'].split()[0]
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
  unless x.levelParams == y.levelParams && Expr.equal (canonical x.type) (canonical y.type) &&
    Expr.equal (canonical x.value) (canonical y.value) do
    throwError "Canonical type or body differs"
'''
lines=['import Lean',*('import '+m for m in E.lean_imports),*E.notation_definitions.values(),comparison,
       'noncomputable def expected_next (n : ℕ) : ℕ := Nat.succ n',
       f'same_target {next_key} expected_next',
       f'noncomputable def expected_keep (n : ℕ) (x : Fin ({next_key} n) → ℝ) : Fin ({next_key} n) → ℝ := x',
       f'same_target {keep_key} expected_keep']
local={'m':Expr('m','m',Type('Natural'))}
t=E.type('Vector((next size(m)),Real)',local);local['v']=Expr('v','v',t)
actual=Expressions(E,local).parse('keep vector(m,v)')
lines += [f'noncomputable def actual_call (m : ℕ) (v : {E.render_type(t,"lean")}) : {E.render_type(actual.type,"lean")} := {actual.lean}',
          f'noncomputable def expected_call (m : ℕ) (v : Fin ({next_key} m) → ℝ) : Fin ({next_key} m) → ℝ := @{keep_key} m v',
          'same_target actual_call expected_call']
with tempfile.TemporaryDirectory() as tmp:
    path=Path(tmp)/'ComputedTargets.lean';path.write_text('\n'.join(lines))
    subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Three canonical computed-dimension targets passed.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
