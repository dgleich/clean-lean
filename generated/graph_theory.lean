import Mathlib.Data.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.Combinatorics.SimpleGraph.Basic
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Data.List.Sort
import Mathlib.Data.Nat.GCD.Basic

noncomputable def cleanType_469c53b6dafb7a218246  : Type :=
  ℕ

noncomputable def cleanType_107b6641a486642ad8e1  : Type :=
  ℝ

noncomputable def cleanType_2d7f06a08f8ab1e3f46d  : Type :=
  ℂ

noncomputable def cleanType_ae4a13d2f060407bce35  : Sort 1 :=
  Prop

noncomputable def cleanType_61d617e3f5143c327dd3 (p0 : Nat) (p1 : Nat) (p2 : Type) : Type :=
  Matrix (Fin p0) (Fin p1) p2

noncomputable def cleanType_b5a130b68abf7f0646e8 (p0 : Nat) (p1 : Type) : Type :=
  Fin p0 → p1

noncomputable def cleanType_460956e39f5b9ffca091 (p0 : Nat) : Type :=
  Fin p0

noncomputable def cleanType_7bde0ce024ce143f369b (p0 : Nat) : Type :=
  SimpleGraph (Fin p0)

noncomputable def cleanType_530f2b2df99696550311 (p0 : Type) : Type :=
  List (p0)

noncomputable def cleanType_6e300741358eee425e81 (p0 : Type) : Type :=
  Set (p0)

noncomputable def cleanType_9d746dbeb0e035328deb (p0 : Type) (p1 : Type) : Type :=
  (p0) → (p1)

noncomputable def cleanNotation_7c95186c3948254b956e {n : ℕ} (x0 : SimpleGraph (Fin n)) (x1 : Fin n) (x2 : Fin n) : Prop :=
  (x0).Adj x1 x2

noncomputable def cleanNotation_954dec16190ec6a37dd0 {n : ℕ} (x0 : SimpleGraph (Fin n)) : SimpleGraph (Fin n) :=
  (x0)ᶜ

noncomputable def cleanNotation_0624f3ebbf6554a04047 {n : ℕ} (x0 : SimpleGraph (Fin n)) (x1 : SimpleGraph (Fin n)) : SimpleGraph (Fin n) :=
  x0 ⊔ x1

noncomputable def cleanNotation_5a5227c120f070958445 {n : ℕ} (x0 : SimpleGraph (Fin n)) (x1 : SimpleGraph (Fin n)) : SimpleGraph (Fin n) :=
  x0 ⊓ x1

noncomputable def cleanNotation_587d371eac8330440de6 {n : ℕ} (x0 : SimpleGraph (Fin n)) (x1 : Fin n) : Set (Fin n) :=
  (x0).neighborSet x1

noncomputable def cleanNotation_c53e656ac6b9efb817db {n : ℕ} (x0 : SimpleGraph (Fin n)) : Set (Fin n) :=
  (x0).support

noncomputable def cleanNotation_32b2b617f7e2adc8d649 {n : ℕ} (x0 : SimpleGraph (Fin n)) (x1 : SimpleGraph (Fin n)) : Prop :=
  x0 ≤ x1

noncomputable def cleanNotation_947639a9d52df05827e1 {n : ℕ} (x0 : SimpleGraph (Fin n)) (x1 : Fin n) (x2 : Fin n) : Prop :=
  (x0).Reachable x1 x2

noncomputable def cleanNotation_39ef10558c6b507db5c6 {n : ℕ} (x0 : SimpleGraph (Fin n)) : Prop :=
  (x0).Connected

noncomputable def cleanDefine_0253f99c1ce46363e2b4 {n : ℕ} (x0 : SimpleGraph (Fin n)) (x1 : Fin n) (x2 : Fin n) : Set (Fin n) :=
  ((cleanNotation_587d371eac8330440de6 (x0) (x1)) ∩ (cleanNotation_587d371eac8330440de6 (x0) (x2)))

noncomputable def cleanDefine_edd7f35c97587928e66d {n : ℕ} (G : SimpleGraph (Fin n)) (u : Fin n) (v : Fin n) : Prop :=
  (¬(cleanNotation_7c95186c3948254b956e (G) (u) (v)))


open scoped Matrix

-- Named hypothesis binders document assumptions even when not dependent.
set_option linter.unusedVariables false

namespace CleanStatements

/--
source: mathlib
reference: SimpleGraph.adj_symm
relationship: specialized
-/
def adjacency_symmetry : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ∀ (edge : (cleanNotation_7c95186c3948254b956e (G) (u) (v))),
  (cleanNotation_7c95186c3948254b956e (G) (v) (u))

/--
source: mathlib
reference: SimpleGraph.adj_comm
relationship: specialized
-/
def adjacency_commutes : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanNotation_7c95186c3948254b956e (G) (u) (v)) ↔ (cleanNotation_7c95186c3948254b956e (G) (v) (u)))

/--
source: mathlib
reference: SimpleGraph.irrefl
relationship: specialized
-/
def no_self_edges : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  (¬(cleanNotation_7c95186c3948254b956e (G) (u) (u)))

/--
source: mathlib
reference: SimpleGraph.ne_of_adj
relationship: specialized
-/
def adjacent_vertices_distinct : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ∀ (edge : (cleanNotation_7c95186c3948254b956e (G) (u) (v))),
  (u ≠ v)

/--
source: mathlib
reference: SimpleGraph.sup_adj
relationship: specialized
-/
def union_adjacency : Prop :=
  ∀ (n : ℕ),
  ∀ (G H : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanNotation_7c95186c3948254b956e ((cleanNotation_0624f3ebbf6554a04047 (G) (H))) (u) (v)) ↔ ((cleanNotation_7c95186c3948254b956e (G) (u) (v)) ∨ (cleanNotation_7c95186c3948254b956e (H) (u) (v))))

/--
source: mathlib
reference: SimpleGraph.inf_adj
relationship: specialized
-/
def intersection_adjacency : Prop :=
  ∀ (n : ℕ),
  ∀ (G H : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanNotation_7c95186c3948254b956e ((cleanNotation_5a5227c120f070958445 (G) (H))) (u) (v)) ↔ ((cleanNotation_7c95186c3948254b956e (G) (u) (v)) ∧ (cleanNotation_7c95186c3948254b956e (H) (u) (v))))

/--
source: mathlib
reference: SimpleGraph.compl_adj
relationship: specialized
-/
def complement_adjacency : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanNotation_7c95186c3948254b956e ((cleanNotation_954dec16190ec6a37dd0 (G))) (u) (v)) ↔ ((u ≠ v) ∧ (¬(cleanNotation_7c95186c3948254b956e (G) (u) (v)))))

/--
source: mathlib
reference: SimpleGraph.support_mono
relationship: specialized
-/
def support_monotonicity : Prop :=
  ∀ (n : ℕ),
  ∀ (G H : SimpleGraph (Fin n)),
  ∀ (inclusion : (cleanNotation_32b2b617f7e2adc8d649 (G) (H))),
  ((cleanNotation_c53e656ac6b9efb817db (G)) ⊆ (cleanNotation_c53e656ac6b9efb817db (H)))

/--
source: mathlib
reference: SimpleGraph.neighborSet_subset_support
relationship: specialized
-/
def neighbors_in_support : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  ((cleanNotation_587d371eac8330440de6 (G) (u)) ⊆ (cleanNotation_c53e656ac6b9efb817db (G)))

/--
source: mathlib
reference: SimpleGraph.mem_neighborSet
relationship: specialized
-/
def neighbor_membership : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((v ∈ (cleanNotation_587d371eac8330440de6 (G) (u))) ↔ (cleanNotation_7c95186c3948254b956e (G) (u) (v)))

/--
source: mathlib
reference: SimpleGraph.notMem_neighborSet_self
relationship: specialized
-/
def not_own_neighbor : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  (¬(u ∈ (cleanNotation_587d371eac8330440de6 (G) (u))))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_eq
relationship: specialized
-/
def common_neighbors_intersection : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanDefine_0253f99c1ce46363e2b4 (G) (u) (v)) = ((cleanNotation_587d371eac8330440de6 (G) (u)) ∩ (cleanNotation_587d371eac8330440de6 (G) (v))))

/--
source: mathlib
reference: SimpleGraph.mem_commonNeighbors
relationship: specialized
-/
def common_neighbors_membership : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v w : Fin n),
  ((w ∈ (cleanDefine_0253f99c1ce46363e2b4 (G) (u) (v))) ↔ ((cleanNotation_7c95186c3948254b956e (G) (u) (w)) ∧ (cleanNotation_7c95186c3948254b956e (G) (v) (w))))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_symm
relationship: specialized
-/
def common_neighbors_symmetry : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanDefine_0253f99c1ce46363e2b4 (G) (u) (v)) = (cleanDefine_0253f99c1ce46363e2b4 (G) (v) (u)))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_subset_neighborSet_left
relationship: specialized
-/
def common_neighbors_left : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanDefine_0253f99c1ce46363e2b4 (G) (u) (v)) ⊆ (cleanNotation_587d371eac8330440de6 (G) (u)))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_subset_neighborSet_right
relationship: specialized
-/
def common_neighbors_right : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanDefine_0253f99c1ce46363e2b4 (G) (u) (v)) ⊆ (cleanNotation_587d371eac8330440de6 (G) (v)))

/--
source: mathlib
reference: SimpleGraph.Reachable.refl
relationship: specialized
-/
def reachability_reflexive : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  (cleanNotation_947639a9d52df05827e1 (G) (u) (u))

/--
source: mathlib
reference: SimpleGraph.Reachable.symm
relationship: specialized
-/
def reachability_symmetric : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ∀ (path : (cleanNotation_947639a9d52df05827e1 (G) (u) (v))),
  (cleanNotation_947639a9d52df05827e1 (G) (v) (u))

/--
source: mathlib
reference: SimpleGraph.Reachable.trans
relationship: specialized
-/
def reachability_transitive : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v w : Fin n),
  ∀ (first : (cleanNotation_947639a9d52df05827e1 (G) (u) (v))),
  ∀ (second : (cleanNotation_947639a9d52df05827e1 (G) (v) (w))),
  (cleanNotation_947639a9d52df05827e1 (G) (u) (w))

/--
source: mathlib
reference: SimpleGraph.Adj.reachable
relationship: specialized
-/
def edge_implies_reachability : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ∀ (edge : (cleanNotation_7c95186c3948254b956e (G) (u) (v))),
  (cleanNotation_947639a9d52df05827e1 (G) (u) (v))

/--
source: mathlib
reference: SimpleGraph.adj_comm
relationship: adapted
-/
def nonadjacency_symmetry : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanDefine_edd7f35c97587928e66d (G) (u) (v)) ↔ (cleanDefine_edd7f35c97587928e66d (G) (v) (u)))

/--
source: mathlib
reference: SimpleGraph.irrefl
relationship: adapted
-/
def nonadjacency_reflexive : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  (cleanDefine_edd7f35c97587928e66d (G) (u) (u))

/--
source: mathlib
reference: SimpleGraph.compl_adj
relationship: adapted
-/
def complement_from_nonadjacency : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((cleanNotation_7c95186c3948254b956e ((cleanNotation_954dec16190ec6a37dd0 (G))) (u) (v)) ↔ ((u ≠ v) ∧ (cleanDefine_edd7f35c97587928e66d (G) (u) (v))))

end CleanStatements
