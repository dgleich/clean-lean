-- generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
import Lean
noncomputable abbrev cleanType_Small_1783dae1e02581b79538  : Type 1 :=
  Type
noncomputable abbrev cleanType_Large_a116f8704c688f03bbd3  : Type 2 :=
  Type 1
noncomputable abbrev cleanType_Higher_a6fe02048cd2a7087030  : Type 3 :=
  Type 2

abbrev expectedSmall : Type 1 := Type
abbrev expectedLarge : Type 2 := Type 1
abbrev expectedHigher : Type 3 := Type 2

open Lean Elab Command
private def canonical : Expr → Expr
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj n i (canonical b)
  | e => e
elab "same_basic_target " a:ident b:ident : command => do
  let env ← getEnv
  let some (.defnInfo x) := env.find? a.getId | throwError "Missing actual target"
  let some (.defnInfo y) := env.find? b.getId | throwError "Missing expected target"
  unless x.levelParams == y.levelParams &&
      Expr.equal (canonical x.type) (canonical y.type) &&
      Expr.equal (canonical x.value) (canonical y.value) do
    throwError "Canonical type or value differs"
same_basic_target cleanType_Small_1783dae1e02581b79538 expectedSmall
same_basic_target cleanType_Large_a116f8704c688f03bbd3 expectedLarge
same_basic_target cleanType_Higher_a6fe02048cd2a7087030 expectedHigher

-- generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
