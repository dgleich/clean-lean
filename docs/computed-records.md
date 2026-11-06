:::llm gpt-6 2026-11-06 role=assisted

# Computed records and field reduction

Implemented extension of [structures](structures.md), [computed indices](computed-indices.md)
and [evidence](evidence.md). The common grammar already uniquely parses
`endpoints(a,b).lower` as a Projection of a Call. No new spelling or parse choice
is introduced. Type checking no longer rejects a projection solely because its
base is a computation.

## Readable use

```clean
Define certify pair inclusion(X,S,T,s,t,a,b):
  Let X: TopologicalSpace
  Let S,T: SpacePairData(X)
  Let s: Evidence((S.relative ⊆ S.ambient))
  Let t: Evidence((T.relative ⊆ T.ambient))
  Let a: Evidence((S.ambient ⊆ T.ambient))
  Let b: Evidence((S.relative ⊆ T.relative))
  Returns: PairInclusion(X)
  Equals: pair inclusion(X,certify pair data(X,S,s),certify pair data(X,T,t),a,b)
```

Here `certify pair data` is an authored definition applying `topological pair`
to the two fields and nesting proof. Checking a and b requires computing the fields
of those constructed pairs. The generated Lean body retains the two calls and
passes the four proofs explicitly. Only the projected expressions used to determine
the dependent argument types reduce. No tactic, proof search, or inferred transport
is inserted.

## Deterministic elaboration rule

For a parsed `Projection(base,field)`:

1. Elaborate the entire base first. Every constructor argument must type-check,
   even if the selected field would not use it. Require an authored record type and
   a field declared by that record. Field lookup uses that nominal identity.
2. A named local or chain of fields on a named local stays opaque. Its Lean term
   remains the explicit generated projection, with record parameters in order.
3. For a computation that is exactly the record's generated constructor call,
   select the actual argument at `number-of-header-parameters + field-position`.
   The selected expression supplies the normalized Lean term, type and semantic tree.
4. Otherwise, if the base is a call to an authored `Equals` definition, all its
   parameters are explicit, and its body has no Lambda/Forall/Exists nodes,
   simultaneously substitute actual expression trees for its formals. Project
   the same field from that instantiated body and apply these rules again.
   Function-valued formals used as call heads substitute as applications; a
   nonfunction formal does not shadow a module callable. This preserves the
   existing call-resolution rule. Substitution is simultaneous, not sequential.
5. All other well-typed computations stay opaque. Generate the nominal Lean
   projection on the computed base. Earlier dependent fields are represented as
   computed indices, so later fields substitute those expressions into their types.

Rule 4 deliberately does not unfold native Means/From Lean adapters, definitions
with implicit parameters, or binder-bearing bodies. Such bases can still be
projected; their fields do not reduce through the adapter. Named local definitions
remain opaque even when their right-hand side was a constructor. No general delta
normalizer, algebraic simplifier, or local-alias conversion is implied.

Constructors and definitions are installed only after their fields/bodies have
been checked. The authored dependency graph is acyclic; the transparent bodies
are binder-free and first order except calls through opaque function arguments.
Unfolding descends that finite graph and finite actual argument trees. A cyclic
or forward declaration remains rejected. Resource exhaustion is incomplete
analysis, never permission to emit an unchecked fallback target.

The rules specify one normal form for each encountered projection. Parent nodes
retain normalized child trees, including unary expressions and function-field
applications. A computed index uses this normalized semantic tree and Lean term.
Its LaTeX spelling is excluded from index identity: rendering choices cannot
change whether two proof types match. All remaining structural matching rules are
unchanged. In particular, distinct opaque computations are not equated merely
because Lean could prove or reduce them to the same value.

## Rendering and exact Lean target

LaTeX keeps the authored projected expression, such as the lower field of shifted
endpoints. Lean uses the reduction prescribed above. Thus a source assertion
`shifted endpoints(I,s).lower = I.lower+s` renders the operation being tested,
while its Lean proposition contains `I.lower+s = I.lower+s`. The independent
canonical oracle explicitly expects that reduced body; a mere rfl proof would not
establish that the translator chose the specified target.

For an opaque identity adapter `opaque endpoints(I)`, Lean retains the adapter
call under the generated lower-field projection. The canonical oracle requires
that distinction, although the resulting equality is also provable by rfl.

## Acceptance and remaining limits

`tests/test_structures.py` covers independent parse trees, constructor and authored
reduction, dependent fields, function fields, opaque adapters, named locals and
rejection of invalid discarded arguments. `tests/test_interlevel.py` checks actual
composed certification and rejects exchanged proofs. The bundle and interlevel
verifiers compare independent native targets and kernel-check the statements.
The acceptance catalog records both cases under the pinned Lean/Mathlib build.

Implicit-parameter and binder-bearing producer reduction, arbitrary local aliases,
and general definitional equality remain open. No claim of a general Lean
normalization engine is made.
:::
