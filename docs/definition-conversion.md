:::llm gpt-6 2026-11-06 role=assisted

# Authored definition conversion in dependent indices

Implemented bounded extension of computed indices and evidence. An authored
binder-free definition can match its expansion in a dependent type. This resolves
`relative chains(...)` versus its authored cokernel expression without importing
a special relative-map implementation from Lean.

## Source and parsing

No surface grammar changes. The generated parser still produces one tree before
any definition lookup. The existing parenthesized index form remains required:

```clean
Returns: ChainMap(K,field,
  (relative chains(field,H,X,Q.source)),
  (relative chains(field,H,X,Q.target)))
```

Here a body returning a map between the expanded cokernel expressions can satisfy
this signature. A binder-free named Condition similarly supplies a proof type
convertible to its defining condition. No proof of that condition is synthesized.

## Comparison algorithm

Each value index retains its source spelling/tree, original Lean term and LaTeX
rendering. It additionally carries a comparison key. To compute the key under a
fixed explicit environment, recursively process its already checked expression:

1. Named locals, literals and opaque binder nodes retain their terms. A local
   definition is not unfolded, and a theorem assumption is not used as a rewrite.
2. Process operator, unary, application and projection operands in source order.
   Rebuild the typed expression with processed operands. Projections use the
   specified computed-record rules; processing a base may expose a constructor.
3. For a call, process actual arguments first. A local Function uses the existing
   local-call resolution. Otherwise use the uniquely resolved module callable.
4. An authored Equals definition (including an authored Condition) is eligible
   for expansion when its stored body contains no Lambda, Forall or Exists nodes,
   and contains no Local reference to an inferred parameter. Inferred Type or
   dimension parameters that occur only in the signature do not block expansion.
   Call heads still use the normal local-function/module-call resolution.
5. Simultaneously substitute the explicit actual expression trees into the
   eligible body, respecting function-valued call heads. Elaborate and recursively
   process that expression. Use it only if its resulting source type equals the
   original call's declared type. Otherwise retain the callable wrapper. This
   last rule keeps definitions relying on an untyped numeric placeholder opaque;
   it does not silently forget the declared numeric type.
6. A native Means/From Lean adapter, generated constructor, or ineligible authored
   definition remains a call to its selected wrapper with processed arguments.
   Infer and pass arguments using the existing ordered call contract. No native
   Lean body is inspected and no algebraic identities are applied.

The key is the resulting typed compiler term's Lean-template string, including
explicit selected wrapper names and arguments. Compare these keys exactly.
The enclosing constructor's parameter kinds and value types are checked before
index comparison. Thus a comparison is within a declared typed slot, not an
untyped equation solver. ValueIndex and ComputedIndex use the same key equality
and hash rule, allowing an authored identity call to match its value argument.
Diagnostics and substitution still use the original source tree.

This is an ordered algorithm, not a search for a common reduct. No alternative
parses, instance candidates, theorem rewrites or successful Lean compilations
are searched to select a meaning. Existing declarations are immutable; authored
bodies have an acyclic dependency graph because recursion/forward references are
rejected. The eligible bodies introduce no binders. Expansion may duplicate finite
actual expressions and can be expensive. Resource exhaustion remains incomplete
analysis; it must not be reported as either equality or inequality.

## One emitted Lean target

Comparison normalization does **not** rewrite emitted annotations or call bodies.
The translator uses the existing deterministic output rule on the original typed
expression, including all explicit evidence arguments. Its prescribed source
signature remains the Lean signature. Lean checks the definitional conversion
between the body and that signature; no cast, tactic or proof-search term is
inserted. This separates the source check from the source-to-Lean output rule.

The older computed-record projection rule still reduces explicitly projected
constructor fields in emitted expressions. That is a separate, already specified
constructor. This extension changes comparison of indices, not that output rule.

The independently authored relative-map oracle deliberately uses named
`relative chains`/`relative homology` wrappers in the expected signatures and the
generic cokernel/homology operations in the bodies. Canonical elaborated comparison
requires both choices, retaining instances, universes and evidence arguments.
It would detect a translator that silently replaced the signatures with their
fully expanded native expressions.

## Limits and acceptance

Local aliases, native adapters, binder-bearing definitions, bodies explicitly
using inferred parameters, and untyped-literal coercion cases remain opaque.
Commutativity/associativity, extensionality and equality assumptions do not enable
conversion. General Lean definitional equality and universe-polymorphic coercion
remain outside this rule. A definition may therefore be equal in Lean without
being convertible by Clean.

`tests/test_conversion.py` covers expansion, preserved emitted terms, equality/hash
agreement, named-condition evidence, wrong evidence, opaque local/native cases,
numeric types, inferred parameters and algebraic nonconversion. Existing scoped
index and record tests remain applicable. `verify_relative_maps.py` checks eight
canonical native declarations and three proofs. Existing topology oracles guard
against unintended changes to prior targets. The repository pins the Lean/Mathlib
build; this is an implemented bounded contract, not a claim about arbitrary Lean
elaboration environments.
:::
