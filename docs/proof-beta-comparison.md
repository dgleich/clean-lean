:::llm gpt-6 2026-11-07 role=assisted

# Scoped beta comparison for proof conditions

This implemented slice allows proof arguments to match after an immediately
applied function is substituted into a quantified condition. Grammar and authored
syntax trees do not change. The remaining global acceptance checks are recorded
below; this is not a declaration of complete language conformance.

```text
there exists(x: A,(function(y: A,y ∈ S))(x))
there exists(x: A,x ∈ S)
```

These denote compatible proof types. Their authored syntax and emitted Lean terms
remain distinct: the first still contains the lambda application. The comparison
key alone uses its beta contraction. This matters when an imported interface takes
`condition: Function(A,Proposition)` and evidence of `there exists(x: A,condition(x))`.
A caller may supply an authored function and the ordinary existence proof.

## Deterministic comparison rule

Apply this pass to a checked proof-condition expression before computing its
existing scoped comparison key. Keep its original expression, syntax, rendering,
and captured scope as the proof type's emission metadata.

1. Traverse the condition in source-tree order. Descend into `Forall` and `Exists`
   bodies with a fresh internal bound identity of the checked domain type. Reuse
   the established fresh-identity and whole-tree key mechanisms; no bound identity
   may capture a fixed caller local.
2. Traverse call arguments, application heads/arguments, projections, unary and
   binary operands. Leave type-value annotations and unapplied lambda bodies
   unchanged. This pass does not unfold named/native functions or apply eta rules.
3. After processing an application's children, if its head is a literal lambda
   with exactly one argument, recheck the whole application and its argument.
   Substitute that checked argument into the body using the existing hygienic,
   simultaneous expression/type substitution procedure. Rename introduced binders
   as necessary; preserve free caller references. Bodies and arguments may contain
   functions and quantifiers.
4. Elaborate the substituted body in the same caller scope. Require an unchanged
   determined type. Continue the same traversal on the resulting tree so newly
   exposed literal applications contract as well. Recheck the whole rebuilt
   condition and require its type to remain unchanged.
5. Feed this comparison expression to the existing scoped index-key procedure.
   Store that key on the original proof index. Do not replace an emitted proof
   argument or select a different proof term.

Every traversal branch and contraction is selected by the existing syntax tree;
types validate that choice, never choose a parse. Beta contraction performs no
recursive definition evaluation. Only checked lambda applications are reduced;
unknown functions remain opaque. The existing proof-scope conflict checks still
apply. A failure to finish comparison is incomplete analysis, not proof of an
incompatible type or success through another candidate.

The ordinary computed-index beta rule is unchanged. This extension belongs to
proof-condition comparison, including nested quantifiers. It does not add general
reduction under an unapplied lambda, extensional function equality, unrestricted
definitional equality, or a rule that discards unused arguments before checking them.

## Foundation and native mapping

`library/logic/choice.clean` explicitly imports the existing evidence, function and
set foundations. It wraps `Classical.choose` and `Classical.choose_spec`, with an
explicit condition function and existence proof. Carriers are in Lean `Type 0`.
`choose element` and `chosen element belongs` are authored Clean definitions using
those wrappers and a membership condition. The latter is a proof-producing function.

Classical choice is noncomputable. It supplies a witness from existence evidence;
it does not implement a search algorithm or a user-selected ordering. Translation
is nevertheless precise: the target is the specified constant applied to the
explicit condition and proof, including the inferred carrier. No new axiom is
introduced by Clean; the imported Lean classical foundation remains part of the
explicit trusted environment.

A condition may itself be universally quantified. This is needed to select an
equivalence together with a property of every label. The native study includes
that interaction, as well as ordinary membership and an explicit applied condition.

## Acceptance evidence

Ten focused tests check the independent source tree, existential and nested
universal scopes, preservation of emitted applications, free-variable hygiene,
functions returning functions, binder-bearing actuals, mismatched condition/domain
rejection, and authored set helpers. Seven independent canonical Lean target/type
comparisons and three kernel proofs pass in `studies/choice/verify.py`. They retain
the applied condition in the expected existential statement; definitional equality
alone is not the oracle.

The final hygienic rule passes 276 focused tests. Existing postfix acceptance
passes eight exact targets and five proofs; the 92-statement proof corpus was
regenerated and kernel-checked. The final-rule full suite remains pending. The
global native-binding, literal/operator, and module-scope acceptance work remains
separate. The one-page choice PDF was compiled twice and inspected; reference
links, search, mobile width, no-JavaScript behavior and strict parser regeneration
checks pass.
:::


:::llm gpt-6 2026-11-10 role=assisted

## Open contextual-family comparison regression

The current compiler fails to compare an authored function alias with the same
explicit function when either is an argument beneath another call. A minimal
reproduction uses these declarations, with explicit operators/evidence imports:

```clean
Notation sample(f: Function(Real,Real)): Real:
  Means: f 0
  Render latex: sample({f})
Define constant(x: Real): Function(Real,Real):
  Equals: function(y: Real,x)
Define sampled(x: Real): Real:
  Equals: sample(constant(x))
```

The proof conditions `sample(constant(a)) = a`, `sampled(a) = a`, and
`sample(function(z: Real,a)) = a` should compare compatibly under authored
unfolding and alpha-renaming. The normalizer expands the named function, sees a
binder in the expanded argument, and preserves the original argument at the
call-reconstruction boundary. The explicit-lambda version retains a different
key. The emitted terms themselves are correct.

`tests/test_contextual_family_comparison.py` records four focused regressions:
the two positive comparisons **fail**, while preservation of distinct free
variables and distinct emitted source forms passes. The failures are intentional
recorded defects, not skipped or expected-failure tests. The test fixture adds no
mathematical axiom and does not replace the intended statement.

`tools/check_contextual_family_targets.py` passes three independent exact native
type/body comparisons and two Lean equality proofs between those propositions.
The latter proofs use native definitional equality; they establish that these
particular propositions agree, not that arbitrary native definition unfolding
should become a Clean comparison rule. Clean must still treat the imported
`sample` body as opaque, using only congruence at that application.

This is the same boundary reached while loading `library/logic/choice.clean`:
`chosen element belongs` compares an explicit predicate application to a condition
using the authored `choose element`. It fails before quantified-beta tests can run.
The failed load was reproduced in a clean exported checkout of `eb159c3`, separately
from the running production regression.

A repair must specify comparison congruence for hidden function expansions without
publishing them as authored dependent-index arguments. Removing the hidden-binder
guard globally is not an accepted repair: it protects computed indices that cannot
represent binders and keeps source/native-adapter scope boundaries intact. Required
interaction checks include dependent result indices, proof-valued arguments,
shadowing, retained declaration identity, local aliases, alpha/capture cases,
changed types and incomplete comparison. No repair is implemented in this commit;
the production compiler remains unchanged.
:::


:::llm gpt-6 2026-11-10 role=assisted

A subsequent [isolated contextual-key prototype](../studies/contextual-family-comparison/README.md)
passes the expanded six-case regression and 96 related tests without removing the
ordinary hidden-binder guard. It constructs comparison-only call shells from
checked declaration identities and arguments. Exact target checks and choice
proofs pass in that checkout. Production integration and broader acceptance are
pending; the earlier four-case failure report above remains historical evidence.
:::

:::llm gpt-6 2026-11-10 role=assisted

## Integrated contextual call congruence

The working compiler now implements the contextual comparison rule. The failure
reports above describe the pre-integration state; the historical study remains
pinned and reproducible. This repair changes comparison keys, not parsing,
overload selection or emitted theorem expressions.

Given a successfully elaborated expression in a fixed explicit environment:

1. Establish a scoped comparison identity pool and elaborate the original tree
   within it. A synchronous freshness witness permits reuse only for a binder-free
   tree; stored checked-argument metadata alone does not provide that witness.
2. Apply the existing ordered normalizer and require the determined type to remain
   unchanged. Its hidden-binder argument barrier remains in force.
3. For a selected module call/operator, validate its declaration identity and
   recursively compute comparison templates for the freshly checked explicit
   arguments. A local callable or other expression retains its checked template.
4. Reconstruct the selected native application using its declared template and
   ordered checked implicit arguments. Before inserting expanded child templates,
   require reconstruction with the original arguments to match the checked target
   exactly. Reject stale identities, changed types and mismatched templates.
5. Insert child comparison templates only into that validated application. Preserve
   its implicit arguments; never feed the templates back into elaboration,
   inference, overload selection or emitted source expressions. Abstract owned
   binder identities by the existing ScopedKey rule and restore the caller's pool
   on success or failure.

Each step is fixed by the checked tree, declaration telescope and existing
normalization order. There is no search for a different overload or native-body
unfolding. This is a limited congruence rule for supported call positions, not
complete Lean definitional equality. Comparison of additional dependent implicit
or projection/application contexts and resource accounting still require audit.
Independent target checks are needed because successful comparison alone does not
establish that emitted Lean is unchanged or uniquely specified.
:::

:::llm gpt-6 2026-11-10 role=assisted

Integration validation: 108 focused tests passed in 22.686 seconds, followed by
three minimal canonical-target comparisons and two equivalence proofs, and seven
choice canonical targets with three proofs. The 92-proof corpus regenerated and
Lean checked successfully; its tracked artifact is unchanged. The isolated stack
already passed all eighteen topology verifiers with 37 unchanged Lean artifacts.
The working compiler still requires a fresh full regression; the old production
run's 29 failures and 27 errors describe the prior compiler and loaded tests.
:::
