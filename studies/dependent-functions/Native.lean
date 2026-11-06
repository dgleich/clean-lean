-- generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
-- Native design probe, not generated from Clean and not a paper theorem.
import Mathlib.Algebra.Category.ModuleCat.Basic
import Mathlib.Data.Real.Basic

set_option autoImplicit false

namespace DependentFunctionProbe
open CategoryTheory

structure GradedModule (K : Type) (field : Field K) : Type 1 where
  component : ℕ → @ModuleCat.{0,0} K field.toRing

@[ext] structure GradedMap {K : Type} {field : Field K}
    (M N : GradedModule K field) : Type where
  component : (p : ℕ) → @ModuleCat.Hom K field.toRing (M.component p) (N.component p)

def identity {K : Type} {field : Field K} (M : GradedModule K field) : GradedMap M M :=
  letI : Field K := field
  ⟨fun p => 𝟙 (M.component p)⟩

def compose {K : Type} {field : Field K} {M N P : GradedModule K field}
    (f : GradedMap M N) (g : GradedMap N P) : GradedMap M P :=
  letI : Field K := field
  ⟨fun p => @CategoryStruct.comp (ModuleCat.{0} K) inferInstance (M.component p) (N.component p) (P.component p) (f.component p) (g.component p)⟩

theorem identity_compose {K : Type} {field : Field K} {M N : GradedModule K field}
    (f : GradedMap M N) : compose (identity M) f = f := by
  letI : Field K := field
  apply GradedMap.ext
  funext p
  exact @Category.id_comp (ModuleCat.{0} K) inferInstance (M.component p) (N.component p) (f.component p)

theorem compose_identity {K : Type} {field : Field K} {M N : GradedModule K field}
    (f : GradedMap M N) : compose f (identity N) = f := by
  letI : Field K := field
  apply GradedMap.ext
  funext p
  exact @Category.comp_id (ModuleCat.{0} K) inferInstance (M.component p) (N.component p) (f.component p)

theorem compose_associative {K : Type} {field : Field K} {M N P Q : GradedModule K field}
    (f : GradedMap M N) (g : GradedMap N P) (h : GradedMap P Q) :
    compose (compose f g) h = compose f (compose g h) := by
  letI : Field K := field
  apply GradedMap.ext
  funext p
  exact @Category.assoc (ModuleCat.{0} K) inferInstance (M.component p) (N.component p) (P.component p) (Q.component p) (f.component p) (g.component p) (h.component p)

-- A small dependent family needs no higher-universe coefficient objects.
def vectorIdentity : (n : ℕ) → (Fin n → ℝ) → (Fin n → ℝ) := fun _ x => x

theorem vector_identity (n : ℕ) (x : Fin n → ℝ) : vectorIdentity n x = x := rfl
end DependentFunctionProbe

-- generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
