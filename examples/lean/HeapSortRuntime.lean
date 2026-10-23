import Mathlib.Analysis.Asymptotics.Defs
import Mathlib.Data.Nat.Log
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/- Independent executable reference, not output from the Clean compiler.
Counts key comparisons only. No Mathlib sorting implementation is used.
Array access/swap and Nat comparisons are treated as unit-cost primitives;
this is not a bit-complexity or wall-clock theorem. -/
namespace CleanSorting

/-- Sift down in the prefix [0, stop), returning the array and key comparisons.
The fuel supplied by heapSort is one more than the floor binary logarithm.
Out-of-range array primitives are total; heapSort supplies its own valid bounds. -/
def siftDown : Nat → Nat → Nat → Array Nat → Array Nat × Nat
  | 0, _, _, a => (a, 0)
  | fuel + 1, stop, root, a =>
    let left := 2 * root + 1
    let right := left + 1
    if left < stop then
      let child := if right < stop then
        if a[left]! < a[right]! then right else left
        else left
      let comparisons := if right < stop then 2 else 1
      if a[root]! < a[child]! then
        let next := siftDown fuel stop child (a.swapIfInBounds root child)
        (next.1, comparisons + next.2)
      else (a, comparisons)
    else (a, 0)

def buildHeap (fuel stop : Nat) : Nat → Array Nat → Array Nat × Nat
  | 0, a => (a, 0)
  | k + 1, a =>
    let step := siftDown fuel stop k a
    let rest := buildHeap fuel stop k step.1
    (rest.1, step.2 + rest.2)

def extractHeap (fuel : Nat) : Nat → Array Nat → Array Nat × Nat
  | 0, a => (a, 0)
  | k + 1, a =>
    let step := siftDown fuel (k + 1) 0 (a.swapIfInBounds 0 (k + 1))
    let rest := extractHeap fuel k step.1
    (rest.1, step.2 + rest.2)

def heapSort (a : Array Nat) : Array Nat × Nat :=
  let n := a.size
  let fuel := Nat.log 2 n + 1
  let built := buildHeap fuel n (n / 2) a
  let result := extractHeap fuel (n - 1) built.1
  (result.1, built.2 + result.2)

theorem siftDown_comparisons (fuel stop root : Nat) (a : Array Nat) :
    (siftDown fuel stop root a).2 ≤ 2 * fuel := by
  induction fuel generalizing root a with
  | zero => simp [siftDown]
  | succ fuel ih =>
    have hl := ih (2 * root + 1) (a.swapIfInBounds root (2 * root + 1))
    have hr := ih (2 * root + 1 + 1) (a.swapIfInBounds root (2 * root + 1 + 1))
    simp only [siftDown]
    split_ifs <;> simp only [Prod.snd] <;> omega

theorem buildHeap_comparisons (fuel stop k : Nat) (a : Array Nat) :
    (buildHeap fuel stop k a).2 ≤ k * (2 * fuel) := by
  induction k generalizing a with
  | zero => simp [buildHeap]
  | succ k ih =>
    dsimp only [buildHeap]
    have hs := siftDown_comparisons fuel stop k a
    have hr := ih (siftDown fuel stop k a).1
    simpa only [Nat.succ_mul] using Nat.add_le_add hs hr |>.trans_eq (Nat.add_comm _ _)

theorem extractHeap_comparisons (fuel k : Nat) (a : Array Nat) :
    (extractHeap fuel k a).2 ≤ k * (2 * fuel) := by
  induction k generalizing a with
  | zero => simp [extractHeap]
  | succ k ih =>
    dsimp only [extractHeap]
    have hs := siftDown_comparisons fuel (k + 1) 0 (a.swapIfInBounds 0 (k + 1))
    have hr := ih (siftDown fuel (k + 1) 0 (a.swapIfInBounds 0 (k + 1))).1
    simpa only [Nat.succ_mul] using Nat.add_le_add hs hr |>.trans_eq (Nat.add_comm _ _)

theorem heapSort_comparisons (a : Array Nat) :
    (heapSort a).2 ≤ 4 * a.size * (Nat.log 2 a.size + 1) := by
  dsimp only [heapSort]
  have hb := buildHeap_comparisons (Nat.log 2 a.size + 1) a.size (a.size / 2) a
  have he := extractHeap_comparisons (Nat.log 2 a.size + 1) (a.size - 1)
    (buildHeap (Nat.log 2 a.size + 1) a.size (a.size / 2) a).1
  have hdiv := Nat.div_le_self a.size 2
  have hsub := Nat.sub_le a.size 1
  nlinarith [Nat.mul_le_mul_right (2 * (Nat.log 2 a.size + 1)) hdiv,
    Nat.mul_le_mul_right (2 * (Nat.log 2 a.size + 1)) hsub]

theorem heapSort_nlogn_bound (a : Array Nat) (h : 2 ≤ a.size) :
    (heapSort a).2 ≤ 8 * a.size * Nat.log 2 a.size := by
  have hb := heapSort_comparisons a
  have hp := Nat.log_pos (by decide : 1 < 2) h
  nlinarith [Nat.mul_le_mul_left a.size hp]

/-- Uniform in the input values: every family of arrays of length n satisfies
an actual Mathlib Big-O statement for the instrumented algorithm's counter.
The natural log here is floor(log base 2), not the natural logarithm. -/
theorem heapSort_isBigO (inputs : Nat → Array Nat) (sizes : ∀ n, (inputs n).size = n) :
    (fun n => ((heapSort (inputs n)).2 : ℝ)) =O[Filter.atTop]
      (fun n => (n : ℝ) * (Nat.log 2 n : ℝ)) := by
  apply Asymptotics.isBigO_iff.mpr
  refine ⟨8, Filter.eventually_atTop.mpr ⟨2, ?_⟩⟩
  intro n hn
  have hb := heapSort_nlogn_bound (inputs n) (by simpa [sizes] using hn)
  rw [sizes] at hb
  simpa only [Real.norm_eq_abs, Nat.abs_cast, abs_mul, mul_assoc]
    using (show ((heapSort (inputs n)).2 : ℝ) ≤ 8 * (n : ℝ) * (Nat.log 2 n : ℝ) by exact_mod_cast hb)

example : (heapSort #[4, 1, 3, 2]).1 = #[1, 2, 3, 4] := by native_decide
example : (heapSort #[]).2 = 0 := by native_decide
example : (heapSort #[7]).1 = #[7] := by native_decide
example : (heapSort #[2, 2, 1]).1 = #[1, 2, 2] := by native_decide
end CleanSorting

-- generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
