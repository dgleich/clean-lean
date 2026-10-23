:::llm gpt-6 2026-10-23 role=assisted

# Sorting examples and proof status

The [insertion-sort specimen](../examples/proposed/insertion-sort.clean) and
[heapsort specimen](../examples/proposed/heap-sort.clean) define their algorithms
instead of importing Mathlib sorting functions. They are proposed authored syntax,
not inputs accepted by the current compiler. The review browser labels them accordingly.

Insertion sort includes sortedness, multiplicity preservation, and a work bound
of `n*n + n + 1`. Its counter charges list matches and key comparisons as described
in the source. Inserting into a list of length k costs at most `2*k + 1`;
the outer recurrence costs at most `1 + T(k) + 2*k + 1`, with `T(0)=1`.
Summing yields the stated quadratic bound, assuming the recursively sorted list
preserves length. These are proposed statements and a mathematical derivation,
not yet Lean proofs. CLR guides the algorithm; no edition-specific theorem number
is claimed.

The [independent Lean heapsort reference](../examples/lean/HeapSortRuntime.lean)
implements bottom-up heap construction and repeated extraction, returning both
an array and its key-comparison count. It proves:

- each fuel-bounded sift uses at most twice its fuel in comparisons;
- the full program uses at most `4*n*(Nat.log 2 n + 1)` comparisons;
- for `n ≥ 2`, the count is at most `8*n*Nat.log 2 n`;
- for every family of inputs of size n, the count satisfies Mathlib's
  `=O[Filter.atTop]` relation against `n * Nat.log 2 n`.

This is comparison complexity, not a proof about allocation, bit complexity,
or wall-clock runtime. The program uses fuel `Nat.log 2 n + 1`. Sortedness,
permutation preservation, and a formal proof that the fuel suffices for the
usual heap invariant remain to be established. Concrete execution checks cover
empty, singleton, duplicate, and unsorted inputs; they do not replace those proofs.
The runtime proofs use no `sorry` or added axioms. This file is handwritten Lean,
not compiler output or evidence that the proposed Clean syntax has been implemented.

Run `lake env lean examples/lean/HeapSortRuntime.lean` to check the reference.

## Language gaps and decisions to revisit

The specimens explore colonless typed headers, recursive definitions, list and
natural-number patterns, tuple expressions, conditional expressions, branch-local
bindings, and `Decreases`. No language change is accepted by these examples alone.
Before implementation, each construct needs a precise grammar, layout and scope
rules, a unique elaborated Lean mapping, and independent acceptance oracles.
In particular, constructor-pattern resolution, termination evidence, branch-local
scope, tuple type inference, and overloaded comparison resolution remain pending.

The intended Lean concepts are `def` with structural recursion, `match`, `if`,
`let`, `Prod`, and explicit foundational array operations. These descriptions
are not canonical target rules. The Big-O relation currently appears only in
the Lean reference; the Clean specimen states the explicit numeric bound rather
than inventing unapproved asymptotic notation. This keeps the open syntax decisions
visible for the next specification review.
