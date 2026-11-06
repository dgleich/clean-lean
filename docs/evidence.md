:::llm gpt-6 2026-11-06 role=assisted

# Explicit evidence and certified records

Implemented bounded extension of [computed indices](computed-indices.md) and
[structures](structures.md). A condition in type position denotes its evidence:

```clean
Let h: (S ⊆ T)
```

This maps to Lean `h : S ⊆ T`. A proposition is the condition, whereas a value
of this type is evidence that the condition holds. It is not a Boolean flag.
The ordinary imported alias from `library/logic/evidence.clean` permits:

```clean
Type Evidence(condition: Proposition):
  Equals: (condition)

Structure SubsetInclusion(X: Type):
  Let source,target: Set(X)
  Let containment: Evidence((source ⊆ target))
  Constructor: certified inclusion
```

There is no built-in dispatch on the word Evidence. Alias expansion uses the
existing structural type-alias rule. A record contains an actual Lean proof
field; its constructor requires that proof explicitly.

## Grammar and unique interpretation

The generated grammar factors `type_ref` into `named_type_ref | computed_index`.
A named constructor begins with a type identifier; a computed form begins with
`(`. The existing expression grammar determines the entire inner tree before
typing. Root `(expression)` normalizes to `ComputedIndex(expression-tree)`, just
as it does in a value-index slot. Parentheses never cause a search for a second
parse or a prose type-phrase interpretation.

At the root of a type annotation, the expression must have the module-declared
Proposition type. Its Lean term is then the type itself; its LaTeX description is
“evidence that …”. In a constructor argument, the declared slot still determines
whether the expression supplies a value index. This is a specified contextual
interpretation of one tree, not a type-directed choice of parse. Noncondition root
expressions fail. Evidence types cannot instantiate parameters declared `Type`:
those denote Lean Type 0, not arbitrary Sorts.

Expression indices and proof types currently exclude explicit quantifiers and
lambdas. A named Condition call is permitted even if its definition uses binders.
Thus users can name such a condition and pass evidence for that call. General
binder-bearing proof-type substitution remains pending.

## Assumption scope and translation

`Assume h: condition` retains its existing Lean universal binder. If the source
label `h` is a single valid identifier, it also introduces a local evidence value
for subsequent clauses. Referencing it emits exactly the existing quoted Lean
binder name, with no implicit proof search or generated axiom. Multiple assumptions
are processed left-to-right, so later entries may reference earlier evidence.
Forward references and existing duplicate-name collisions fail.

```clean
Assume inclusion: S ⊆ T
Let Q = certified inclusion(X,S,T,inclusion)
```

The corresponding Lean fragment is:

```lean
∀ (inclusion : S ⊆ T),
  let Q := certifiedInclusion X S T inclusion
  -- subsequent conclusion
```

Multiword and punctuation-bearing labels remain readable labels. Their encoded
Lean names are not extra source identifiers. A direct binder-bearing assumption
still works as an ordinary hypothesis; referencing its proof as a term fails
with a request to introduce a named Condition. A proof local sharing a name with
a module callable follows the existing nonfunction-local rule: bare `h` selects
the local, while `h(...)` resolves the module callable.

Matching is structural on condition expressions and dependent indices. It does
not unfold named Conditions, identify local aliases, or use logical equivalence.
A proof of `T ⊆ S` cannot satisfy `S ⊆ T`. Record projection substitutes all earlier
fields into its proof type. Callable elaboration passes the selected proof term
explicitly in the declared argument position. No new instance search policy,
coercion, universe inference, or tactic mechanism is introduced.

## Wrappers and acceptance

`library/topology/inclusions.clean` imports `Set.inclusion`; `pairs.clean` imports
bundled subspaces and `ContinuousMap.inclusion` with the topology explicitly taken
from the supplied TopCat object. Definitions of pair inclusions and the two maps
around their square are authored in Clean. These are foundations for relative
homology, not a construction of relative homology or a proof of the paper results.

`tests/test_evidence.py` checks independent trees, proof scope, wrong evidence,
aliases, record projections and rejected Type arguments. The topology study's
`verify_evidence.py` independently defines native records, functions and statement
types; canonical comparison preserves proof arguments, instances and universes.
It also kernel-checks four proofs, including commutativity of the pair inclusion
square. The fixed Lean/Mathlib environment remains the repository lockfile.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Authored definition conversion

[Definition conversion](definition-conversion.md) now permits typed dependent
indices to match eligible binder-free authored expansions. It supersedes the
blanket structural-only rule for those indices. Emitted Lean terms and source
annotations retain their prescribed wrappers; comparison does not rewrite them.
Native adapters, local aliases and the documented ineligible bodies stay opaque.
The relative-map study exercises this rule with named source/target objects and
explicit commutativity evidence, checked against independent native targets.
:::
