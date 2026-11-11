:::llm gpt-6 2026-11-11 role=assisted

# Standard vector and matrix zeros

The explicit module [matrix_zeros.clean](../library/algebra/matrix_zeros.clean)
provides four ordinary constructors with exact `Literal: 0` attachments:
real/complex vector zeros and real/complex rectangular matrix zeros.
[linear_algebra.clean](../library/linear_algebra.clean) imports that module.
Neither the parser nor literal selection dispatches on these English names.

```clean
Let m,n: Natural
Conclude: (0: Matrix(m,n,Complex)) = complex matrix zero(m,n)
```

The annotation determines the carrier. Existing exact-literal matching recovers
both dimensions in their declared order and retains the selected constructor
identity. The target is a fully explicit call to that wrapper. The wrapper itself
has native body `fun _ _ => (0 : Complex)` and return type
`Matrix (Fin m) (Fin n) Complex`, through the declared type abbreviations. Vector
wrappers have one index; real wrappers use Real. These are foundational native
adapters, not Clean-authored proofs or new compiler primitives.

The declarations attach only zero. A rectangular matrix one is not silently
interpreted as an identity matrix. Scalar zero keeps its imported Numerals
constructor. A competing exact zero for the same determined carrier is ambiguous,
even when its native body is definitionally equal. The attachments do not gain
priority through import order, a name convention or Lean elaboration.

[typed_zeros.clean](../examples/typed_zeros.clean) contains four reviewable
statements. Five Python tests check shapes, recovered parameter order, scalar
interpretations, ambiguity and unsupported matrix one. The
[native verifier](../tools/check_standard_zero_targets.py) independently compares
four constructor types/bodies and four theorem propositions, then proves the four
interpretation statements. Its generated artifact is
[StandardZeros.lean](../generated/StandardZeros.lean). All eight comparisons and
four proofs pass under the pinned environment. The final integration run
(`/tmp/clean-standard-zeros-integration.log`) also passes strict parser reproduction,
501 Python tests, 65 exact native targets, 34 supporting proofs and all 92 corpus
proofs, ending with `Failures: []`. Full discovery remains incomplete; these scoped
results do not establish general inference or whole-language conformance.

## Remaining unannotated inference obligation

These declarations are a prerequisite, not a replacement for `x != 0` when x is
a vector. The production numeral search still enumerates closed scalar carriers
and cannot jointly infer an exact constructor's parameters from an operator
signature. The original similarity and BibTeX examples are unchanged and continue
to expose that failure. Do not rewrite them with annotations to claim completion.

The next compiler step must connect the joint declaration-choice constraint model
to checked Clean signatures, retain unresolved competing families, apply defaults
simultaneously, and produce one retained constructor application for each accepted
parse. Parent constraints must be available before pruning child interpretations.
See the [parameterized-literal contract](parameterized-literals.md) for the
unresolved joint-inference specification and acceptance requirements. There is no
new grammar in this library step, and no claim of general numeral inference.
:::
