:::llm gpt-6 2026-11-10 role=assisted

# Numeral search for interval and subpath definitions

Status: integrated slice; full conformance and broad validation remain pending.
The implementation changes the numeral search's resource boundary and adds an authored
finite-vertex order. Grammar, precedence, layout, and editor spellings are unchanged.

The active-label study first fails because `lower(i) ≤ upper(i)` has finite-vertex
operands and no declared order adapter. The prototype adds this to the explicit
zigzag module, which already supplies `vertex number`:

```clean
Condition vertex at most(u,v):
  Let n: Natural
  Let u,v: Vertex(n)
  Infix: ≤
  Holds when: vertex number(n,u) ≤ vertex number(n,v)
  Render latex: {u}\le {v}
```

Here `n` is recovered by the existing dimension rule. The body's operands are
natural numbers, so it selects the already imported natural order rather than
recursing into the new vertex order. The Lean target retains both declarations
and the vertex-coordinate projections. Native checks compare these exact wrappers
and prove reflexivity and transitivity. No meaning is selected by the display name
`Vertex` or by treating the operator token as a built-in relation.

The next failure is in `subpath vertex`: its body contains repeated numeric `1`s
in natural additions and proof arguments. Flat enumeration multiplies all numeral
carrier choices before checking any surrounding expression and exceeds 4096
assignments. This is correctly reported as incomplete analysis, but prevents
ordinary authored definitions from being used.

## Search rule

Keep the existing numeral atoms, explicit adapters, expected-type rule and final
simultaneous-default rule. Replace flat whole-expression enumeration by the
following fixed traversal:

1. Parse once. Identify expression children in the existing AST order: call
   arguments; application callee then arguments; binary operands left then right;
   the unary operand; and the object of a projection.
2. A subtree without numeral holes is checked normally in the current caller
   scope. Its errors are not hidden by a failing sibling. It contributes one
   unchanged candidate; checking it does not rewrite the source tree.
3. At ordinary expression nodes, recursively compute **every** successful child
   assignment. Form their Cartesian product, reconstruct the parent with those
   bound numeral atoms, and check each parent candidate normally. Keep all
   successful assignments, even when they have the same result type. Do not
   choose a default or select one successful meaning here.
4. Treat a lambda, universal condition, or existential condition as an atomic
   search region. Enumerate and check all its hole assignments as a complete
   binder expression, so its body is never checked in a scope missing its bound
   variable. Decomposition beneath binders is not implemented.
5. A numeric leaf enumerates the explicit closed-carrier constructors in their
   existing stable order. Explicitly annotated and retained numeral atoms keep
   their selected declarations.
6. Reject only mismatches owned by this numeral search. Foreign mismatches,
   incomplete analyses, and other elaboration errors propagate. Restore the
   preceding search owner on every exit.
7. At the root, apply the declared expected type, then compute all default
   restrictions from the complete root solution set simultaneously. Ambiguity,
   conflicting defaults, and absence of solutions retain their existing outcomes.
   Emit the selected root expression, marking defaulted occurrences visibly.

The configurable limit now caps the number of local assignment combinations at
**each visited search node**, after child filtering. Atomic binder regions retain
a flat limit. A local product above the limit yields incomplete analysis before
checking that product; it cannot be accepted by choosing a default. This is an
explicit resource-policy change, not a claim to preserve the former raw global
4096-assignment cutoff. There is no new unbounded fallback or first-success rule.

## Why this can preserve the successful targets

The current expression checker elaborates child expressions without a parent
expected type; the expected-type constraint is applied at the completion root.
Thus a child assignment rejected by that checker cannot become valid by being
embedded in a parent. Conversely, a successful whole-expression assignment must
supply successful assignments to each child. The traversal retains all those
assignments and reconstructs the whole expression before accepting it. Binder
regions use the original exhaustive check in their own scope.

This argument relies on the current compositional checker boundary. A future
bidirectional expected-type mechanism must revisit it. Finite tests do not prove
all current consumers honor that boundary; comprehensive binding/cache/capture
interaction checks remain required. Defaults are particularly important: in
`r = 1+1` with real `r`, the inner sum must retain its real interpretation even
though the module's default numeral carrier is Natural.

## Evidence and limits

Eight focused tests pass, including comparison with a separately written flat
exhaustive oracle for small expressions, parent-driven carrier selection before
defaults, joint-default conflicts, owner/error propagation, binder scope, and a
natural sum containing nine numeral occurrences. Three independent canonical
Lean checks pass for the vertex-order declaration, its application, and that
long sum. Three proofs establish vertex-order reflexivity/transitivity and the
long sum's value at zero.

Run `python3 studies/numeral-pruning/verify.py` with the project dependencies and
pinned `lake` (`LAKE` can provide its path). It exports the pinned integration
revision, applies the patch, and runs those checks. This leaves production files
unchanged. `--active-labels` additionally runs the larger active-label test group;
that group is not claimed passing by the focused results above.

The historical active-label diagnostics and their terminal outcomes are recorded
in the integration checkpoint below. Current active-label/interval study
translation, native oracle migration, general performance and full regression
remain pending. The implementation does not solve vector/matrix numerals or
parameterized literal carriers. Paper-theorem proof gaps are unchanged.
:::

:::llm gpt-6 2026-11-10 role=assisted

## Integration checkpoint

The working compiler now applies the search rule above, and the zigzag module
contains the Clean-authored vertex order. Thirteen focused tests pass directly:
the original eight plus an independent exhaustive comparison across 29 additional
small expressions, root expected-type filtering for three carriers, unknown-name
propagation from a second sibling, the atomic binder resource boundary, and
restoration of an existing search owner. Three canonical Lean targets and three
proofs also pass directly. The 92-proof corpus also passes directly. The production full regression and
topology checks have been started; their final results are pending.

The earlier combined numeral-pruning/projection experiment terminated with 48
tests in 1560.663 seconds and one error from a nonexistent test module. Its actual
active-label/structure cases passed, but its command did not. The superseded
pruning-only diagnostic was stopped explicitly, without a passing result. These
historical runs do not validate the current production compiler.

The pinned patch driver below remains a historical eight-test reproduction and
must not reapply its patch to the integrated compiler. Run the working tests and
`tools/check_pruned_numeral_targets.py` directly for current evidence. The added
five tests are production acceptance checks, not part of that historical patch.
:::
