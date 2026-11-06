:::llm gpt-6 2026-11-06 role=assisted

# Immediately applied functions in dependent indices

This implemented extension permits a checked, immediately applied lambda to
contract while constructing a type index. It enables generic proof operations:

```clean
equality congruence(function(P: TopologicalPair(X),P.ambient),Q,R,h)
```

Here h proves Q = R. The operation is an explicit wrapper for Lean congrArg.
The new equality adapters fix both carrier universes to Lean Type 0; they are not
universe-polymorphic wrappers for arbitrary bundled objects.
Its formal result type is Evidence((f(x) = f(y))). Substitution of the actual
arguments produces applications of the supplied lambda. The resulting Clean type
is Evidence((Q.ambient = R.ambient)). The emitted call still passes the lambda to
the congrArg wrapper; no proof is synthesized or erased.

## Grammar and scope

There is no new spelling or grammar production. The expression parser already
produces Lambda trees for `function(...)`, and dependent-call substitution produces
Apply trees when substituting a function-valued argument in a call-head position.
Parsing is completed without type information. This rule changes the admissible
elaborated indices, not the unique parse tree. It does not add a new direct
lambda-application surface spelling.

The source binder must obey the existing fresh-name and nondependent-result rules.
The lambda body and its actual argument must contain no Lambda, Forall or Exists
nodes after recursive contraction outside binders. This restriction makes
substitution capture-free: there is no binder in the body that could capture an
inserted free reference. Do not traverse or rewrite inside unapplied binders.
Bare lambdas and quantifiers are still forbidden as indices, as are irreducible
applications containing them. Native functions and named local aliases stay opaque.

## Deterministic construction

1. Elaborate the complete original index expression in the fixed explicit
   environment. Check every lambda domain, body and actual argument, including
   arguments that the body does not use. An invalid argument cannot be discarded
   to make a call pass.
2. Traverse the typed source tree bottom-up outside binders. For
   Apply(Lambda(x,T,body),[a]), contract exactly when body and a are binder-free.
   Replace Local(x) by a simultaneously throughout body. A Call whose head is x
   becomes Apply(a,args), with the recursively substituted arguments. Preserve
   other module-call heads and field names. Earlier elaboration ensures x is a
   function when it appears as a call head; fresh binders cannot shadow module
   callables.
3. Re-elaborate the contracted tree in the caller's environment. Its type must
   equal the original determined type. In particular, do not silently introduce
   expected-type literal coercions when contraction exposes a numeric placeholder.
4. Reject any remaining binder in the resulting index. Then use the ordinary
   named/computed-index representation and bounded definition comparison.
   The stored index tree, Lean type annotation and rendering use the contracted
   expression. The surrounding proof/definition call retains its original arguments.

Contraction removes a lambda application and inserts binder-free trees, so it
cannot introduce a new lambda redex. Recursive descent and ordinary field
reduction determine one result. No search, import-order choice, local-alias
unfolding, eta conversion or theorem-based rewriting is performed. Resource
exhaustion remains incomplete analysis, not a uniqueness proof.

This supersedes the blanket rejection of applied lambdas in the computed-index
contract only for this specified subset. It does not enable general binder-bearing
indices, dependent function types or arbitrary definition unfolding.

## Acceptance evidence

`tests/test_applied_indices.py` checks independent trees/types, discarded bad
arguments, freshness, function-valued binder substitution, opaque functions and
unapplied/binder-bearing rejection. `studies/topology/verify_pair_composition.py`
compares the exact elaborated native targets for generic proof adapters and the
Clean-authored identity/composition operations. Native oracles retain the original
lambda arguments, proof arguments, equality transport and wrapper identities.
The accompanying statement proofs check source/target and continuous-map behavior.
:::

:::llm gpt-6 2026-11-06 role=assisted

The later [hygienic producer extension](hygienic-producer-conversion.md) supersedes
the blanket binder-bearing-producer exclusion for selected, applied fields. It
preserves comparison-only emission and the stated native-adapter opacity; residual
binders, lambda-authored locals and unrepresentable substitutions remain bounded.
Dependent function types have their own [implemented initial contract](dependent-function-types.md).
:::
