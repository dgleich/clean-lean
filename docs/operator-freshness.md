:::llm gpt-6 2026-11-10 role=assisted

# Reusing checked operator operands within one traversal

The previous binding/comparison paths elaborated an operator's nested calls three
times even when the condition had just been checked. The depth-eight `retain`
fixture now makes eight calls rather than 24. This removes redundant work without
changing syntax, overload choice or the emitted Lean proposition.

The normative rule is in [the spec](spec.md), under “Traversal-local operator
operands”; [the Lean reference](clean-to-lean.html#fresh-operator-operands) gives
the mapping. The witness is a private synchronous call convention. Having
`checked_args` on a stored Expr does not establish freshness.

- Comparison reuses fresh child expressions, normalizes them with the existing
  hidden-binder barrier, and still reruns operator selection.
- Binding closes fresh call children and verifies selected/retained declaration
  identities. Constructors outside the checked-call subset use the original path.
- Public comparison and proof-index entry points retain scope rechecking and do
  not trust mutable metadata from a previous traversal.

Validation so far: 82 focused tests in the isolated revision, including seven
freshness cases, and three independent canonical Lean evidence targets. The
three targets also pass directly in the working checkout. They check equality,
prefix negation and a nested disjunction. The test source now explicitly imports
`proof_equality.clean`, which supplies the operators it uses; implicit imports
were not restored.

The 92-proof corpus also passed directly on the working revision. The production
full regression and 18 topology verifiers are running; their terminal results
must be recorded before claiming wider validation.
A separate bounded active-label profile combines the change with the still
unintegrated numeral-pruning/vertex-order experiment; it is diagnostic evidence,
not a production acceptance result or a proof of overall speedup. The 45-second
sample reached `restore active label`, as the earlier projection-only sample did;
it does not demonstrate a broad active-label speedup.
:::

:::llm gpt-6 2026-11-10 role=assisted

The working-revision validation finished: all 18 topology verifiers passed, and
the full regression ran 753 tests in 359.046 seconds with 33 failures and 42
errors. The preceding revision had 750 tests, 33 failures and 46 errors. Three
new freshness cases were added and the four existing freshness cases now run
successfully with their explicit operator import. The suite as a whole still
fails; these counts are not a full conformance claim.
:::
