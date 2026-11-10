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


:::llm gpt-6 2026-11-10 role=assisted

## Additional explicit-fixture migration

The dependent-assumption, postfix-application, compact-signature and module-layout
fixtures now import their operator declarations explicitly. The sibling-lambda
scope test imports operators locally, preserving the separate types-only tests
that intentionally reject undeclared mathematics. No expected names, source trees,
collision checks, dependent types or negative assertions were weakened.

A focused run of `test_dependent_functions`, `test_postfix_applications`,
`test_function_expressions`, `test_compact_signatures` and `test_layout` passes
69 tests in 3.754 seconds. These are fixture changes only. The longer regression
started before this migration and is still live; its earlier failures remain
part of that run's evidence.

Two investigated failures are not resolved by importing operators:

- The projected-condition naming fixture concludes `P = P` for a universe-1
  InterlevelProblem. The declared general equality has a Type-0 parameter, so it
  cannot instantiate that carrier. General universe support remains a language
  gap; no weaker conclusion or ad hoc test-only equality was substituted.
- Loading `library/logic/choice.clean` fails at `chosen element belongs`. Its
  produced evidence index contains an applied lambda around `choose witness`,
  while the declared index uses the Clean-authored `choose element`. Conversion
  rejects their expected correspondence. The quantified-beta tests cannot run
  until that conversion problem is resolved. A fresh isolated reproduction
  confirms the failure; it is not counted as obsolete test expectations.

These findings distinguish explicit-import debt from remaining semantic work.
They do not establish correctness of all dependent-function or universe cases.
:::
