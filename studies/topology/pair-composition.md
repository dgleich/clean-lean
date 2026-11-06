:::llm gpt-6 2026-11-06 role=assisted

# Composing certified pair inclusions

The [module](../../library/topology/pair_composition.clean) authors identities and
composition for the existing PairInclusion record. It uses explicit evidence that
the first target equals the second source:

```clean
Let Q,R: PairInclusion(X)
Assume middle: Q.target = R.source
Let composite = compose pair inclusions(X,Q,R,middle)
```

The result has source Q.source and target R.target. Composition goes first along Q,
then along R. No equality hypothesis is used implicitly to identify type indices.
The implementation transports the first inclusion to the second source using the
supplied equality and then applies subset transitivity. Both ambient and relative
sets are handled this way, retaining the nested-pair data.

The needed field equality is itself authored in Clean:

```clean
Define pair ambient equality(X,P,Q,h):
  Let X: TopologicalSpace
  Let P,Q: TopologicalPair(X)
  Let h: Evidence((P = Q))
  Returns: Evidence((P.ambient = Q.ambient))
  Equals: equality congruence(function(T: TopologicalPair(X),T.ambient),P,Q,h)
```

Equality congruence, reflexivity, subset transitivity and equality transport are
thin native proof adapters over Type 0 carriers, with independently checked targets. The pair operations
are mathematical Equals bodies rather than paper-specific Lean implementations.
Clean can compose these proof terms; it still does not provide a general tactic
or structured-proof language.

The generic congrArg call originally failed because its result type contained an
applied lambda after substituting f. The new
[applied-function index rule](../../docs/applied-function-indices.md) checks the
complete application and then contracts a binder-free lambda body and argument
while forming its type index. It retains the original lambda in the generated
proof call. Wrong arguments cannot be erased by contraction. Remaining binders
and arbitrary local-alias unfolding are still rejected.

The two field-equality helpers also keep the composition constructor's body
binder-free. Consequently the existing computed-record projection rule can expose
its source and target without extending the separate restriction on unfolding
binder-bearing record producers. That is why associativity can pass the same two
middle-equality proofs through nested compositions.

The [six statements](PairComposition.clean) prove the identity/composite endpoints,
source and target identity laws, associativity, and the two continuous maps of an
identity pair inclusion. Record equality proofs use proof irrelevance for the
inclusion certificates. They are not proofs that an arbitrary chosen map of
homology objects respects composition.

Review [generated Lean](PairComposition.lean), [typeset statements](PairComposition.pdf),
and [exact native oracles and proofs](PairCompositionVerified.lean).
Run `LAKE=lake python3 studies/topology/verify_pair_composition.py` to regenerate
and check fifteen exact elaborated targets and six proofs. The oracle preserves
wrapper identities, lambda bodies, proof arguments and equality transport.

A category-of-pairs instance, compatibility of the induced relative maps with this
composition, connecting morphisms, exactness/excision, and the research theorems
remain unfinished. The broader proof language and binder-bearing index extensions
remain separate language work.
:::
