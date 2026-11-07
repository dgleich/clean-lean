-- generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
-- Native payload probe only: this does not implement Clean numeral syntax.
import Lean
open Lean Elab Command

def payloadZero : Nat := nat_lit 0
def payloadOne : Nat := nat_lit 1
def payloadMany : Nat := nat_lit 123
def payloadLarge : Nat := nat_lit 100000000000000000000000000000000000000

elab "check_nat_payload " name:ident value:num : command => do
  let env ← getEnv
  let some (.defnInfo actual) := env.find? name.getId | throwError "Missing payload"
  unless actual.type == .const ``Nat [] && actual.value == .lit (.natVal value.getNat) do
    throwError "Expected a primitive Nat literal"

check_nat_payload payloadZero 0
check_nat_payload payloadOne 1
check_nat_payload payloadMany 123
check_nat_payload payloadLarge 100000000000000000000000000000000000000

-- Overloaded native numeral syntax is a different canonical target.
def ordinaryNumeral : Nat := 123
/-- error: Expected a primitive Nat literal -/
#guard_msgs in
check_nat_payload ordinaryNumeral 123

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
