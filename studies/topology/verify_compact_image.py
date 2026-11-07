# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Generate the Clean target and kernel-check its equivalence and proof."""
from pathlib import Path
import os
import ast
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from cleanlang.core import Environment, lean, latex
from cleanlang.modules import load_document

here = Path(__file__).resolve().parent
env = Environment()
results = load_document(here / "CompactImage.clean", env)
source = lean(results, env, ["Lean", "Mathlib.Topology.Continuous"])
(here / "CompactImage.lean").write_text(source)
(here / "CompactImage.tex").write_text(latex(results, env))
# Exact adapter and statement checks supplement the mathematical equivalence.
comparison = next(ast.literal_eval(n.value) for n in
    ast.parse((ROOT / 'tools/check_basic_targets.py').read_text()).body
    if isinstance(n, ast.Assign) and any(isinstance(t, ast.Name) and
        t.id == 'COMPARISON' for t in n.targets))
k = lambda name: '_root_.' + env.data['types'][name]['native_binding']
f = lambda name: '_root_.' + env.data['functions'][name]['native_binding']
K, P, S, T = (k(name) for name in ['Type', 'Proposition', 'Set', 'Topology'])
compact, continuous, image = (f(name) for name in
    ['compact in', 'continuous between', 'image'])
exact = f"""
noncomputable def expected_compact_adapter {{X : Type}} (S : {S} X) (t : {T} X) : {P} :=
  @IsCompact X t S
same_basic_target {compact.removeprefix('_root_.')} expected_compact_adapter
noncomputable def expected_compact_statement : Prop :=
  ∀ (X Y : {K}) (t : {T} X) (u : {T} Y) (f : X → Y) (S : {S} X),
    @{continuous} X Y f t u → @{compact} X S t →
    @{compact} Y (@{image} X Y f S) u
same_basic_target CleanStatements.continuous_image_of_a_compact_set expected_compact_statement
"""
proofs = r"""
namespace CompactImageProofs

-- Independently written mathematical target in native Mathlib vocabulary.
def nativeStatement : Prop :=
  ∀ (X Y : Type) (t : TopologicalSpace X) (u : TopologicalSpace Y)
    (f : X → Y) (S : Set X),
    @Continuous X Y t u f → @IsCompact X t S → @IsCompact Y u (f '' S)

-- This is a mathematical equivalence check, not a canonical Expr oracle.
theorem statement_agrees :
    CleanStatements.continuous_image_of_a_compact_set ↔ nativeStatement := by
  constructor
  · intro h X Y t u f S hf hS
    exact h X Y t u f S ((@continuous_def X Y t u f).mp hf) hS
  · intro h X Y t u f S hf hS
    exact h X Y t u f S ((@continuous_def X Y t u f).mpr hf) hS

theorem continuous_image_of_a_compact_set :
    CleanStatements.continuous_image_of_a_compact_set := by
  apply statement_agrees.mpr
  intro X Y t u f S hf hS
  letI : TopologicalSpace X := t
  letI : TopologicalSpace Y := u
  exact hS.image hf

end CompactImageProofs
"""
(here / "CompactImageVerified.lean").write_text(source + comparison + exact + proofs)
subprocess.run([os.environ.get("LAKE", "lake"), "env", "lean",
                str(here / "CompactImageVerified.lean")], cwd=ROOT, check=True)
print("Checked two exact compact-image targets, the theorem and native-statement equivalence.")

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
