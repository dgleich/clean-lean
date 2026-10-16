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
  ∀ (edge : ((G).Adj u v)),
  ((G).Adj v u)

/--
source: mathlib
reference: SimpleGraph.adj_comm
relationship: specialized
-/
def adjacency_commutes : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  (((G).Adj u v) ↔ ((G).Adj v u))

/--
source: mathlib
reference: SimpleGraph.irrefl
relationship: specialized
-/
def no_self_edges : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  (¬((G).Adj u u))

/--
source: mathlib
reference: SimpleGraph.ne_of_adj
relationship: specialized
-/
def adjacent_vertices_distinct : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ∀ (edge : ((G).Adj u v)),
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
  ((((G ⊔ H)).Adj u v) ↔ (((G).Adj u v) ∨ ((H).Adj u v)))

/--
source: mathlib
reference: SimpleGraph.inf_adj
relationship: specialized
-/
def intersection_adjacency : Prop :=
  ∀ (n : ℕ),
  ∀ (G H : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((((G ⊓ H)).Adj u v) ↔ (((G).Adj u v) ∧ ((H).Adj u v)))

/--
source: mathlib
reference: SimpleGraph.compl_adj
relationship: specialized
-/
def complement_adjacency : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  (((((G)ᶜ)).Adj u v) ↔ ((u ≠ v) ∧ (¬((G).Adj u v))))

/--
source: mathlib
reference: SimpleGraph.support_mono
relationship: specialized
-/
def support_monotonicity : Prop :=
  ∀ (n : ℕ),
  ∀ (G H : SimpleGraph (Fin n)),
  ∀ (inclusion : (G ≤ H)),
  (((G).support) ⊆ ((H).support))

/--
source: mathlib
reference: SimpleGraph.neighborSet_subset_support
relationship: specialized
-/
def neighbors_in_support : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  (((G).neighborSet u) ⊆ ((G).support))

/--
source: mathlib
reference: SimpleGraph.mem_neighborSet
relationship: specialized
-/
def neighbor_membership : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ((v ∈ ((G).neighborSet u)) ↔ ((G).Adj u v))

/--
source: mathlib
reference: SimpleGraph.notMem_neighborSet_self
relationship: specialized
-/
def not_own_neighbor : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  (¬(u ∈ ((G).neighborSet u)))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_eq
relationship: specialized
-/
def common_neighbors_intersection : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  (((G).commonNeighbors u v) = (((G).neighborSet u) ∩ ((G).neighborSet v)))

/--
source: mathlib
reference: SimpleGraph.mem_commonNeighbors
relationship: specialized
-/
def common_neighbors_membership : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v w : Fin n),
  ((w ∈ ((G).commonNeighbors u v)) ↔ (((G).Adj u w) ∧ ((G).Adj v w)))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_symm
relationship: specialized
-/
def common_neighbors_symmetry : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  (((G).commonNeighbors u v) = ((G).commonNeighbors v u))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_subset_neighborSet_left
relationship: specialized
-/
def common_neighbors_left : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  (((G).commonNeighbors u v) ⊆ ((G).neighborSet u))

/--
source: mathlib
reference: SimpleGraph.commonNeighbors_subset_neighborSet_right
relationship: specialized
-/
def common_neighbors_right : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  (((G).commonNeighbors u v) ⊆ ((G).neighborSet v))

/--
source: mathlib
reference: SimpleGraph.Reachable.refl
relationship: specialized
-/
def reachability_reflexive : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u : Fin n),
  ((G).Reachable u u)

/--
source: mathlib
reference: SimpleGraph.Reachable.symm
relationship: specialized
-/
def reachability_symmetric : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ∀ (path : ((G).Reachable u v)),
  ((G).Reachable v u)

/--
source: mathlib
reference: SimpleGraph.Reachable.trans
relationship: specialized
-/
def reachability_transitive : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v w : Fin n),
  ∀ (first : ((G).Reachable u v)),
  ∀ (second : ((G).Reachable v w)),
  ((G).Reachable u w)

/--
source: mathlib
reference: SimpleGraph.Adj.reachable
relationship: specialized
-/
def edge_implies_reachability : Prop :=
  ∀ (n : ℕ),
  ∀ (G : SimpleGraph (Fin n)),
  ∀ (u v : Fin n),
  ∀ (edge : ((G).Adj u v)),
  ((G).Reachable u v)

end CleanStatements
