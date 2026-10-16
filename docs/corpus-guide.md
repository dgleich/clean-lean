# Reading the theorem collection

Start with `generated/specimen.pdf` to compare the mathematical presentation across subjects. The four `.clean` files in `corpus/` contain exactly 20 statements each. The generated `.lean` files define their propositions without claiming proofs. `corpus/catalog.json` includes the source declaration, immutable GitHub URL, source excerpt, specialization, and validation proof term for each entry.

The catalogue is a syntax test set, not a complete undergraduate syllabus. Most declarations use concrete scalar types and finite graph vertices so the first parser can avoid typeclass machinery. It is particularly useful for assessing named assumptions, grouping, compound propositions, dimension parameters, overloaded multiplication, and source display.

| Area | Initial coverage | Important next stress cases |
| --- | --- | --- |
| Linear algebra | Determinants, trace, transpose, matrix–vector identities | Rank/nullity, linear independence, spectral theorem, eigenvalue perturbation |
| Graph theory | Adjacency, neighborhoods, graph operations, reachability | Paths as objects, trees, degrees, counting, coloring |
| Analysis | Exponential/logarithmic/trigonometric identities, square roots, continuity | Epsilon/delta limits, quantified convergence, derivatives, integrals, compactness |
| CLR-aligned algorithms | Insertion sort, merge sort, sorting invariants, number-theoretic lemmas | Complexity, recurrences, searching, heaps, BFS/DFS, shortest paths, dynamic programming |

The algorithms entries are actual mathematical results, but some are supporting invariants rather than complete algorithm correctness theorems. No result is labelled as a proof of an algorithm's running time. CLR edition and chapter references remain open.

`Continuous.add` has a generated upstream declaration: Mathlib derives it from the adjacent `Continuous.mul` source via `to_additive`. The recorded link intentionally points to the generating declaration.
