:::llm gpt-6 2026-11-11 role=assisted

# Empty relative parts of level pairs

Level constructions return `SpacePairData(X)`: two subsets with no nesting proof
attached. Relative homology accepts `TopologicalPair(X)`, which includes that
proof. The two types are deliberately distinct. Passing an expanded level pair
directly to `empty relative part` would therefore be ill-typed.

The [empty pair data module](../../library/topology/empty_pair_data.clean) adds
one Clean-authored condition:

```clean
Condition empty relative data(X,Q):
  Let X: TopologicalSpace
  Let Q: SpacePairData(X)
  Holds when: empty space(subspace(X,Q.relative))
```

Its Lean body is exactly the declared `empty space` applied to the declared
relative `subspace`. No native adapter, implicit conversion, or new syntax is
introduced. The `empty space` adapter ultimately uses `IsEmpty` of the subspace
carrier. This expresses absence of points in the actual subspace type, rather
than only a pointwise set-membership statement.

[Five Clean results](LevelEmptyPairs.clean) state that expanded, perturbed and
shifted level pairs have empty relative data; empty relative data imply nesting;
and certification with an explicit nesting proof preserves emptiness. These
hold for arbitrary real parameters. No radius sign or endpoint ordering is
needed to show that a relative set with no selected endpoints is empty.

The certification statement is:

```clean
Result certification preserves empty relative data:
  Attribution: level_empty; certification; original
  Let X: TopologicalSpace
  Let Q: SpacePairData(X)
  Assume empty: empty relative data(X,Q)
  Assume nesting: nested pair(X,Q)
  Conclude: empty relative part(X,certify pair data(X,Q,nesting))
```

The generated result quantifies over the supplied nesting proof. It does not
silently infer or replace that proof. A proof author can obtain it from the
preceding nesting result and then use the certification result with the
[empty-relative-chain inclusion theorem](empty-chains.md).

## Validation and scope

[The verifier](verify_level_empty_pairs.py) compares six independent canonical
Lean targets: the condition and five statements. It also checks five proofs.
The three geometric proofs eliminate a point of the relative subtype using its
membership property; the two generic proofs establish nesting and preservation
of the same empty carrier.

```sh
LAKE=lake python3 studies/topology/verify_level_empty_pairs.py
```

Generated outputs: [statements](LevelEmptyPairs.lean) and
[canonical comparisons and proofs](LevelEmptyPairsVerified.lean).

These certificates supply the missing level-specific premise for the generic
inclusion-zero result. Assembling the relative-to-ordinary homology maps and
proving their naturality remain pending. The well-group equality and its
closed-cover/excision justification remain unproved.
:::

:::llm gpt-6 2026-11-11 role=assisted

Validation completed: six canonical targets and five proofs pass. Both
elaboration routes produce identical Lean text for the module and five-result
study under matching stable fingerprints; all 92 corpus proofs pass under joint
routing. Evidence is retained under `level_empty_pair_certificates` in
[the compatibility report](../parameterized-literals/compatibility.json).
Reference HTML links/IDs and provenance are checked separately. The ongoing full
regression, active-label validation and browser build are not counted as passed.
:::
