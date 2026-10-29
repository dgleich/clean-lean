# generated: gpt-6 2026-10-29 role=assisted; see PROVENANCE.md
"""Generate proofs of actual Clean propositions, not only shape checks."""
from pathlib import Path
from cleanlang.core import Environment, lean, latex, bibliography
from cleanlang.modules import load_document

ROOT = Path(__file__).resolve().parent
env = Environment()
results = load_document(ROOT/'examples/magnetic.clean', env)
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

proofs = f'''
namespace CleanMagneticProofs
open CleanPapers

-- This bridges the Clean-authored exponential to the independently written Lean definition.
theorem phase_agrees (q : ℝ) : {phase} q = phase q := by
  change Complex.exp (Complex.I * ((2 * Real.pi * q : ℝ) : ℂ)) =
    Complex.exp (2 * (Real.pi : ℂ) * Complex.I * (q : ℂ))
  congr 1
  push_cast
  ring

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
  change {adjacency} A q ^ m = walkFourierSum A m q
  rw [adjacency_agrees]
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
  exact walkProfile_two_one A
theorem inverse_endpoint_counterexample :
    CleanStatements.odd_length_inverse_endpoint_counterexample := by
  change complexify (walkProfile directedSingleEdge 1 1) ≠
    (((1 / 2 : ℝ) : ℂ)) • {adjacency} directedSingleEdge 0
  rw [adjacency_agrees]
  simpa using inverse_v1_length_one_fails
end CleanMagneticProofs

#print axioms CleanMagneticProofs.forward_transform
'''
header = '-- generated: gpt-6 2026-10-29 role=assisted; see PROVENANCE.md\n'
(ROOT/'generated/VerifiedMagnetic.lean').write_text(header+lean(results, env, [])+proofs)
(ROOT/'generated/magnetic.tex').write_text('% generated: gpt-6 2026-10-29 role=assisted; see PROVENANCE.md\n'+latex(results, env))
(ROOT/'generated/magnetic-references.tex').write_text(bibliography(results, env))
# Prove the original paper specimen too, without changing its existing statement.
original_env = Environment()
original = load_document(ROOT/'examples/recent-papers.clean', original_env)[0]
original_proof = '''
theorem magnetic_paper_original_proved : CleanStatements.magnetic_powers_encode_walk_profiles := by
  intro n _ A m q
  exact CleanPapers.magnetic_power_fourier A m q
'''
(ROOT/'generated/VerifiedMagneticOriginal.lean').write_text(header+
    'import CleanPapers.Magnetic\n'+lean([original], original_env, [])+original_proof)
print('Checked 2 definition trees; generated 6 Clean theorem proofs and the original paper proof')

# generated: gpt-6 2026-10-29 role=assisted; LLM-authored portions; see PROVENANCE.md
