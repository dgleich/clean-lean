import Mathlib.Data.Real.Basic
import Lean
noncomputable abbrev cleanType_Real_8457e8182afcbbac5a10  : Type :=
  Real
noncomputable def cleanNumeral_Real_de7b7f340e0e395f8201 (digits : Nat) : _root_.cleanType_Real_8457e8182afcbbac5a10 :=
  (fun n : Nat => (n : Real)) digits
noncomputable abbrev cleanType_Counting_6ad264a0777258751e84  : Type :=
  Nat
noncomputable def cleanNumeral_Counting_1d6c17104a2bceaded1f (digits : Nat) : _root_.cleanType_Counting_6ad264a0777258751e84 :=
  (fun n : Nat => n) digits
noncomputable abbrev cleanType_Renamed_84068564a30b1c6504c2  : Type :=
  Real
noncomputable def cleanNumeral_Renamed_fd30268b0094a9fe1234 (digits : Nat) : _root_.cleanType_Renamed_84068564a30b1c6504c2 :=
  (fun n : Nat => (n : Real)) digits

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

def expected_carrier_0 : Type := Real
same_basic_target cleanType_Real_8457e8182afcbbac5a10 expected_carrier_0

noncomputable def expected_adapter_0 (n : Nat) : _root_.cleanType_Real_8457e8182afcbbac5a10 := (fun n : Nat => (n : Real)) n
same_basic_target cleanNumeral_Real_de7b7f340e0e395f8201 expected_adapter_0

theorem adapter_zero_0 : _root_.cleanNumeral_Real_de7b7f340e0e395f8201 (nat_lit 0) = 0 := by simp [_root_.cleanNumeral_Real_de7b7f340e0e395f8201]

def expected_carrier_1 : Type := Nat
same_basic_target cleanType_Counting_6ad264a0777258751e84 expected_carrier_1

noncomputable def expected_adapter_1 (n : Nat) : _root_.cleanType_Counting_6ad264a0777258751e84 := (fun n : Nat => n) n
same_basic_target cleanNumeral_Counting_1d6c17104a2bceaded1f expected_adapter_1

theorem adapter_zero_1 : _root_.cleanNumeral_Counting_1d6c17104a2bceaded1f (nat_lit 0) = 0 := by simp [_root_.cleanNumeral_Counting_1d6c17104a2bceaded1f]

def expected_carrier_2 : Type := Real
same_basic_target cleanType_Renamed_84068564a30b1c6504c2 expected_carrier_2

noncomputable def expected_adapter_2 (n : Nat) : _root_.cleanType_Renamed_84068564a30b1c6504c2 := (fun n : Nat => (n : Real)) n
same_basic_target cleanNumeral_Renamed_fd30268b0094a9fe1234 expected_adapter_2

theorem adapter_zero_2 : _root_.cleanNumeral_Renamed_fd30268b0094a9fe1234 (nat_lit 0) = 0 := by simp [_root_.cleanNumeral_Renamed_fd30268b0094a9fe1234]

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
