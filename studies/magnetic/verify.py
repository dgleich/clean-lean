# generated: gpt-6 2026-10-29 role=assisted; see PROVENANCE.md
"""Generate proofs of actual Clean propositions, not only shape checks."""
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from cleanlang.core import Environment, lean, latex, bibliography
from cleanlang.modules import load_document

env = Environment()
results = load_document(ROOT/'studies/magnetic/Statements.clean', env)
phase = env.definitions['magnetic phase']['key']
adjacency = env.definitions['magnetic adjacency']['key']
laplacian = env.definitions['magnetic Laplacian']['key']
# Independent AST expectations for the two composite matrix definitions.
assert env.definitions['magnetic adjacency']['tree'] == [
    'Operator', '+',
    ['Operator', '*', ['Call', 'magnetic phase', [['Local', 'q']]],
     ['Call', 'complex matrix', [['Local', 'A']]]],
    ['Operator', '*', ['Call', 'magnetic phase', [['Unary', '-', ['Local', 'q']]]],
     ['Call', 'complex matrix', [['Call', 'real transpose', [['Local', 'A']]]]]]]
assert env.definitions['magnetic Laplacian']['tree'] == [
    'Operator', '-', ['Call', 'magnetic degree matrix', [['Local', 'A']]],
    ['Call', 'magnetic adjacency', [['Local', 'A'], ['Local', 'q']]]]

words = env.definitions['direction words']['key']
product = env.definitions['word product']['key']
profile = env.definitions['walk profile']['key']
fourier = env.definitions['walk Fourier sum']['key']
filter_key = env.data['functions']['filter']['lean'].split()[0]
proofs = f'''
namespace CleanMagneticProofs
open MagneticReference

-- This bridges the Clean-authored exponential to the independently written Lean definition.
theorem phase_agrees (q : ℝ) : {phase} q = phase q := by
  change Complex.exp (Complex.I * ((2 * Real.pi * q : ℝ) : ℂ)) =
    Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (q : ℂ))
  congr 1
  push_cast
  ring

theorem words_agree (m : ℕ) : ({words} m).Perm (words m) := by
  change (List.replicate m [true, false]).sections.Perm (words m)
  induction m with
  | zero => simp [words, List.sections]
  | succ m ih =>
    simp only [List.replicate_succ, List.sections, List.map_cons, List.map_nil, words]
    apply (ih.flatMap_right (fun s => [true :: s, false :: s])).trans
    simpa only [← List.map_eq_flatMap] using
      (List.flatMap_append_perm (words m) (fun s => [true :: s])
        (fun s => [false :: s])).symm

theorem product_agrees {{n : ℕ}} (A : Mat n) (w : List Bool) :
    {product} A w = wordProduct A w := rfl

theorem profile_agrees {{n : ℕ}} (A : Mat n) (m k : ℕ) :
    {profile} A m k = walkProfile A m k := by
  have filters (l : List (List Bool)) :
      {filter_key} (fun w => w.count true = k) l =
        l.filter (fun w => w.count true = k) := by
    unfold {filter_key}
    apply List.filter_congr
    intro w hw
    apply Bool.eq_iff_iff.mpr
    simp only [decide_eq_true_eq]
  change (({filter_key} (fun w => w.count true = k) ({words} m)).map (wordProduct A)).sum = _
  rw [filters]
  exact (((words_agree m).filter (fun w => w.count true = k)).map (wordProduct A)).sum_eq

theorem fourier_agrees {{n : ℕ}} (A : Mat n) (m : ℕ) (q : ℝ) :
    {fourier} A m q = walkFourierSum A m q := by
  change {phase} (-(q * m)) • (∑ k ∈ Finset.range (m + 1),
    {phase} (2 * q * k) • complexify ({profile} A m k)) = _
  simp_rw [phase_agrees, profile_agrees]
  rfl

theorem adjacency_agrees {{n : ℕ}} (A : Mat n) (q : ℝ) :
    {adjacency} A q = magneticMatrix A q := by
  change {phase} q • complexify A +
    {phase} (-q) • complexify A.transpose = _
  rw [phase_agrees, phase_agrees]
  rfl

theorem laplacian_agrees {{n : ℕ}} (A : Mat n) (q : ℝ) :
    {laplacian} A q = magneticLaplacian A q := by
  change complexify (Matrix.diagonal (magneticDegree A)) - {adjacency} A q = _
  rw [adjacency_agrees]
  rfl

theorem forward_transform : CleanStatements.magnetic_powers_encode_walk_profiles := by
  intro n A m q
  change {adjacency} A q ^ m = {fourier} A m q
  rw [adjacency_agrees, fourier_agrees]
  exact magnetic_power_fourier A m q

theorem adjacency_hermitian : CleanStatements.magnetic_adjacency_is_Hermitian := by
  intro n A q
  change ({adjacency} A q).IsHermitian
  rw [adjacency_agrees]
  exact magneticMatrix_hermitian A q

theorem laplacian_hermitian : CleanStatements.magnetic_Laplacian_is_Hermitian := by
  intro n A q
  change ({laplacian} A q).IsHermitian
  rw [laplacian_agrees]
  exact magneticLaplacian_hermitian A q

theorem zero_potential : CleanStatements.zero_potential_symmetrizes_adjacency := by
  intro n A
  change {adjacency} A 0 = complexify (A + A.transpose)
  rw [adjacency_agrees]
  exact magneticMatrix_zero A

theorem mixed_walk : CleanStatements.two_step_mixed_walk_profile := by
  intro n A
  change {profile} A 2 1 = A * A.transpose + A.transpose * A
  rw [profile_agrees]
  exact walkProfile_two_one A
theorem inverse_endpoint_counterexample :
    CleanStatements.odd_length_inverse_endpoint_counterexample := by
  change complexify ({profile} directedSingleEdge 1 1) ≠
    (((1 / 2 : ℝ) : ℂ)) • {adjacency} directedSingleEdge 0
  rw [adjacency_agrees, profile_agrees]
  simpa using inverse_v1_length_one_fails
end CleanMagneticProofs

#print axioms CleanMagneticProofs.forward_transform
'''
header = '-- generated: gpt-6 2026-10-29 role=assisted; LLM-authored portions; see PROVENANCE.md\n'
study=ROOT/'studies/magnetic'
translated=lean(results, env, [])
assert all(name.startswith('Mathlib.') for name in env.lean_imports)
assert all(d['implementation']=='equals' for name,d in env.definitions.items() if name != 'Hermitian')
(study/'Generated.lean').write_text(header+translated)
reference=(study/'Reference.lean').read_text()
imports=list(dict.fromkeys(line for text in (reference,translated)
    for line in text.splitlines() if line.startswith('import ')))
def body(text):
    return '\n'.join(line for line in text.splitlines() if not line.startswith('import '))
(study/'Verified.lean').write_text(header+'\n'.join(imports)+'\n'+body(reference)+'\n'+body(translated)+proofs)
(study/'generated/magnetic.tex').write_text('% generated: gpt-6 2026-10-29 role=assisted; LLM-authored portions; see PROVENANCE.md\n'+latex(results, env))
(study/'generated/magnetic-references.tex').write_text(bibliography(results, env))
print('Generated standalone Lean statements and proofs from the Clean study and its Common library')
