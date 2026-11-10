:::llm gpt-6 2026-11-10 role=assisted

# Reuse stable native arguments during comparison

Status: isolated optimization; production remains unchanged.
The fixed baseline is `a759a317cf1fe4a54b6fb791c09668100f49425a`.
This study addresses the cost of comparing dependent indices, a practical obstacle
to loading the topology interfaces and completing the full regression suite.

A bounded diagnostic of the earlier lazy-reservation checkout spent 12.524 of
14.651 profiled seconds cumulatively in `_normal_form`, and 12.452 seconds in
contextual `emit`; these times overlap. The sample ended during loading and is
not a full-load benchmark. Existing validation jobs were not interrupted.

A complete depth-eight native-call fixture provides clearer evidence: production
normalizes the eight `retain` calls 36 times during one comparison. The prototype
normalizes them eight times and produces the same comparison key as the original
native expression. This is an operation-count regression, not a general timing
or total topology-load claim.

## Restricted rule

The original public entry still re-elaborates source trees in the current scope.
The root of a comparison is still normalized. During subsequent comparison-only
materialization, a freshly normalized child may skip another normalization only
when it belongs to this recursively defined class:

- a local whose current binding has no stored `local_normal` expression;
- an unannotated decimal leaf;
- a native/constructor Call or retained ModuleCall whose checked arguments all
  belong to this class, which is not an authored Equals definition and which,
  for an ordinary Call, is not a local binding.

All other trees take the existing path. In particular this rule does not cover
operators, annotated numerals, projections, applications, authored definitions,
local aliases, lambdas or quantifiers. Native-call children may contain ordinary
local references, but cannot hide an authored binder expansion under this rule.

The predicate is private to the synchronous comparison traversal. It is called
only on checked children returned by that traversal's normalizer. Merely storing
`checked_args` on a public Expr does not establish freshness. There is no cache,
no environment-version shortcut, and no persistence across comparisons.

## Why this preserves meaning

For a local with no normal expression, and for a decimal, the existing normalizer
returns the same expression. By induction, arguments of a qualifying native call
remain unchanged. Its native body is opaque to Clean normalization, it is not a
local function application, and there is no authored Equals body to unfold.
The existing fresh-call reuse rule therefore returns that same checked call.
Skipping this repeated normalization changes no arguments, types or comparison
terms. It does not alter emitted Lean source.

Materialization still checks every native/retained identity, every raw call
shell, and the explicit and inferred argument template. It still restores the
comparison pool after success or failure. Source binding and initial elaboration
retain their normal scope checks. Fixed environment and local scope during one
synchronous traversal remain preconditions; concurrent mutation is not added as a
supported operation. This argument covers the stated class only, not arbitrary
idempotence of normalization.

## Reproduce

```sh
LAKE=lake python3 studies/stable-comparison-arguments/verify.py
```

The driver uses the standard pinned-checkout helper and applies only this study's
one-file patch. It runs the six new operation-count/freshness tests with the
existing contextual, binder, conversion and proof-index checks. It also invokes
the independent native contextual/choice target verifiers.

New tests check the operation count and exact comparison string, authored alias
expansion, current scope after public metadata mutation, retained-identity
rejection, unchanged emitted source and metadata, and a local stored expression.
The initial fixture incorrectly called the internal authored-definition helper
without its required flag; that fixture was corrected before validation.

The pinned reproduction passed on 2026-11-10: 114 tests in 24.703 seconds,
ten exact native targets and five proofs. Existing unused-variable warnings were
nonfatal. The same six new tests on production had only the operation-count
failure (36 instead of eight); the five semantic/freshness checks passed there too.
The fixed-batch time is not evidence of a general speedup under concurrent work.

Broader regression and full active-label load time remain unverified. The separate
lazy-reservation and assumption-block prototypes are not implicitly included by
this driver. No production integration or whole-language conformance is claimed.
:::
