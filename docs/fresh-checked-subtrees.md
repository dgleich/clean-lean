:::llm gpt-6 2026-11-07 role=assisted

# Reusing freshly checked call subtrees

This implementation preserves the existing comparison and emission rules. It adds
no syntax, inference policy, proof selection, or cross-invocation expression cache.
The interval stress check remains incomplete; the full suite is still pending.

Module-call expressions retain their checked argument expressions in a private,
nonsemantic `checked_args` tuple. That metadata alone is not evidence of freshness.
Public comparison entry points ignore it and resolve arguments in the current
caller scope. This is essential when a previously checked expression is supplied
under changed bindings.

## Freshness audit

| Entry/path | Rule |
| --- | --- |
| Public `comparison_normal_form` and `index_comparison` | Start without a freshness witness; re-elaborate arguments in the current scope |
| Immediate checked proof-condition paths | Use the additional audited witness in [fresh-condition-comparison.md](fresh-condition-comparison.md) |
| The traversal's `normal(tree)` helper | Elaborates the tree synchronously, then marks that result fresh |
| Arguments of a fresh module call with typed-child metadata | They were checked during that same elaboration and may be traversed as fresh |
| Missing typed-child metadata | Elaborate source arguments again; selected record fields can take this path |
| Stored local-definition expansion | Does not inherit freshness from the current local reference |
| Reduced application or projected field | Conservative default: no freshness witness is passed onward |
| Local function call | Keeps the existing local-call handling; no module-call reuse branch |

Normalization and elaboration are synchronous under one fixed semantic environment.
They do not load modules or mutate declaration meanings during the traversal.
Dependent matching may introduce temporary fresh locals, but restores those scopes
before returning. Comparison-identity pools may allocate new owned identities;
they do not rebind existing locals or declaration meanings. No concurrent mutation
of an environment or expression graph during comparison is part of this compiler
model. Changes *between* public comparison invocations are covered by rechecking.

A fresh call is reused only after every normalized argument matches its previously
checked argument in source tree, emitted Lean term, checked type, rendered Lean
type, inferred-argument metadata, presentation and precedence. If any comparison
fails, or metadata is absent, run the ordinary module-call checker. The existing
rule preventing hidden binders from being published as authored arguments remains
in effect. Typed-child metadata is excluded from expression equality and display.

## Preservation argument

The two freshness-producing paths establish checked expressions in the current
scope. Recursion through their typed children preserves that property; stored
values and synthesized reductions do not automatically acquire it. Normalizing a
child either preserves the information used to check the parent or forces the
parent's ordinary recheck. Thus reuse retains an already selected term/type; it
cannot use source-tree equality to carry a term from an earlier caller scope.
The fixed-environment assumption and pool ownership remain explicit parts of this
argument, not hidden cache keys.

The rejected `stable-call.patch` used only unchanged argument trees at arbitrary
entries. This implementation does not adopt that rule. It also does not perform
module-global memoization, fresh-identity reuse across pools, or new reduction.

## Evidence

Five focused regressions cover changed caller values/types, nested calls under a
changed scope, ignored retained metadata at public entry, and recheck complexity.
The twelve-call case produces the current target/type after rebinding. The old
implementation performs 78 module-call checks; the new one requires at most 12.
This is a deterministic operation-count check, independent of machine timing.

The main focused run passes 285 tests. Choice passes seven exact targets and three
proofs, postfix passes eight targets and five proofs, and the generic subtype
construction passes ten targets and three proofs. These checks compare native
terms/types and retain explicit argument and proof choices. An additional 56 scoped-family/evidence tests pass. The current full-suite run
is recorded separately in the topology log.

The isolated generic-module diagnostic made 8,900 fresh-bound allocations, compared
with 33,998 before this change. Concurrent elapsed times were 16.25s and 49.89s;
those measurements are not a controlled benchmark or evidence that interval
translation has completed. The historical experiment patch remains available for
review, but this rule is now implemented in main.
:::
