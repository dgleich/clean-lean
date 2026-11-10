-- generated: gpt-6 2026-11-10 role=assisted; proof fragment included by verifier

open CategoryTheory

theorem intersectionThenUnionChecked : CleanStatements.intersection_then_union_vanishes := by
 intro K field H X U V
 letI : Field K := field
 letI : TopologicalSpace X.carrier := X.str
 let F := (AlgebraicTopology.singularHomologyFunctor (ModuleCat.{0} K) H.degree).obj H.coefficients
 let a : TopCat.of (U ∩ V : Set X.carrier) ⟶ TopCat.of U := TopCat.ofHom (ContinuousMap.inclusion Set.inter_subset_left)
 let b : TopCat.of (U ∩ V : Set X.carrier) ⟶ TopCat.of V := TopCat.ofHom (ContinuousMap.inclusion Set.inter_subset_right)
 let c : TopCat.of U ⟶ TopCat.of (U ∪ V : Set X.carrier) := TopCat.ofHom (ContinuousMap.inclusion Set.subset_union_left)
 let d : TopCat.of V ⟶ TopCat.of (U ∪ V : Set X.carrier) := TopCat.ofHom (ContinuousMap.inclusion Set.subset_union_right)
 have square : F.map a ≫ F.map c = F.map b ≫ F.map d := by
  rw [← F.map_comp, ← F.map_comp]
  rfl
 have hc : (F.map c).hom.comp (F.map a).hom = (F.map d).hom.comp (F.map b).hom :=
  congrArg ModuleCat.Hom.hom square
 change ModuleCat.ofHom (((F.map c).hom.coprod (F.map d).hom).comp
   ((F.map a).hom.prod (-(F.map b).hom))) =
  ModuleCat.ofHom (0 : (F.obj (TopCat.of (U ∩ V : Set X.carrier))).carrier →ₗ[K] (F.obj (TopCat.of (U ∪ V : Set X.carrier))).carrier)
 congr 1
 ext x
 have hx := congrArg (fun t : (F.obj (TopCat.of (U ∩ V : Set X.carrier))).carrier →ₗ[K] (F.obj (TopCat.of (U ∪ V : Set X.carrier))).carrier => t x) hc
 change (F.map c).hom ((F.map a).hom x) + (F.map d).hom (-((F.map b).hom x)) = 0
 change (F.map c).hom ((F.map a).hom x) = (F.map d).hom ((F.map b).hom x) at hx
 simp [hx]

-- generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
