# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Generate foundation targets and proofs; never assume a pending paper theorem."""
from pathlib import Path
import sys
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment, lean, latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
env=Environment();rs=load_document(here/'Foundations.clean',env)
text=lean(rs,env,[])
(here/'Generated.lean').write_text(text)
pre=env.definitions['inverse image']['key']
image=env.definitions['image']['key']
continuous=env.definitions['continuous between']['key']
proofs=f'''
namespace TopologyFoundationProofs

-- Agreement with independently named Lean constructions.
theorem inverse_image_agrees {{X Y : Type}} (f : X → Y) (S : Set Y) :
    {pre} f S = f ⁻¹' S := rfl

theorem image_agrees {{X Y : Type}} (f : X → Y) (S : Set X) :
    {image} f S = f '' S := rfl

theorem continuity_agrees {{X Y : Type}} (f : X → Y)
    (t : TopologicalSpace X) (u : TopologicalSpace Y) :
    {continuous} f t u ↔ @Continuous X Y t u f := by
  letI : TopologicalSpace X := t
  letI : TopologicalSpace Y := u
  change (∀ S : Set Y, IsOpen S → IsOpen (f ⁻¹' S)) ↔ Continuous f
  exact continuous_def.symm

theorem inverse_image_intersection : CleanStatements.inverse_image_intersection := by
  intro X Y f S T
  rfl

theorem image_membership : CleanStatements.image_membership := by
  intro X Y f S y
  rfl

theorem continuous_composition : CleanStatements.continuous_composition := by
  intro X Y Z t u v f g hf hg
  change ∀ S : Set Z, @IsOpen Z v S → @IsOpen X t ((g ∘ f) ⁻¹' S)
  intro S hS
  exact hf (g ⁻¹' S) (hg S hS)

theorem family_intersection_membership : CleanStatements.family_intersection_membership := by
  intro I X sets x
  rfl

end TopologyFoundationProofs
'''
(here/'Verified.lean').write_text(text+proofs)
(here/'Foundations.tex').write_text(latex(rs,env))
print('Generated four foundation statements, four proofs, and three agreement proofs.')

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
