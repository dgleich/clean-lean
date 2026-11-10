:::llm gpt-6 2026-11-10 role=assisted

# Project only the fields needed by a dependent type

Status: implemented slice in the working compiler; broad conformance remains
pending. The pinned experiment below remains available for historical reproduction. No source grammar, layout, keyword or operator changes.
The intended Lean expression and its type are unchanged.

A record projection currently substitutes every preceding field before reaching
the requested field. Each substitution can normalize proof conditions and
project still more fields. In the active-label investigation this repeats enough
work to obscure whether the larger definitions finish checking.

For example, selecting `c.count` needs neither `c.carrier` nor `c.value`:

```clean
Structure Choice():
  Universe: 1
  Let carrier: Type
  Let value: carrier
  Let count: Natural
  Constructor: choice
```

Selecting `c.value` still needs `c.carrier`, since it determines the value's type.
A proof field can need several earlier fields transitively. Skipping all preceding
fields would therefore be incorrect.

## Constructive projection rule

The complete structure telescope is still checked when declared, and the base
expression must still have that checked structure type. Constructor checking,
module binding validation, and the constructor/authored-producer reduction rules
are not relaxed.

For a remaining projection of field `f`:

1. Start with the structure parameters mapped to their actual type/value indices,
   as before. Find `f` in the ordered checked field telescope.
2. Set the required field set to `{f}`. Traverse from `f` backward. When a field
   is required, include each earlier field whose binding occurs in its checked
   type. Use the existing scope-aware type/index occurrence traversal, including
   dependent function domains/codomains, local carriers, and retained condition
   expressions. Earlier-only field references make this a finite closure.
3. Traverse the resulting required fields in their original declaration order.
   Substitute parameters and required predecessor projections into each checked
   field type using the existing substitution rules. Type-valued fields still
   supply checked carriers; value/proof fields still supply checked indices.
4. Emit `f` through the same root-qualified Lean projection, with the same actual
   structure parameters and the same base expression. Do not normalize or rewrite
   that emitted projection merely to avoid checking its type.

Unrelated preceding fields are not instantiated at this use site. They are not
removed from the declaration or constructor. The closure is recomputed from the
checked telescope on each projection; this adds no cache shared across caller
scopes. Changed caller bindings must still change the resulting projection/type.

The source still has exactly the existing Projection syntax tree. For a fixed
checked telescope, backward dependency closure and forward substitution have fixed
orders and no search choices. Omitting a predecessor with no occurrence in the
required types should not alter the substituted target type. The focused checks
below support this rule; they do not establish all declaration-identity and native
import-isolation obligations for the compiler.

## Validation and performance evidence

`python3 studies/projection-dependencies/verify.py` exports the pinned
condition-inference revision and applies this patch alone. It does **not** apply
numeral pruning or the proposed vertex-order declaration. With project dependencies
and the pinned `lake` available (`LAKE` can supply its path), it passes:

- 55 focused projection, structure and binding tests, including five new cases.
- Four independent canonical Lean application/type checks: an independent count,
  a carrier-dependent value, a transitive proof dependency, and a function/value
  dependent proof field.
- Two native agreement proofs for the count and carrier-dependent projections.

The new tests retain transitive dependencies, check changed caller scopes, and
verify that an independent later field no longer instantiates earlier field types.
The native expected types and projections are authored independently; comparisons
are structural, not just definitional equality.

A separate bounded profile used the numeral-pruning/vertex-order experiment to
reach the active-label modules. Before projection closure, its 45-second sample
expired inside `subtype restriction equivalence`. With closure, that declaration
completed in about three seconds inside the sampled run and the profile progressed
to `restore active label` before the same sample ended. These are exploratory
profiles with instrumentation overhead, not comparable end-to-end benchmarks or
proof that the whole active-label load now completes.

Both the initial pruning-only load and a combined projection experiment are still
under investigation. The combined test command also named a nonexistent legacy
`test_carrier_fields` module; that command cannot count as a passing suite even
if its active-label cases finish. The separate 55-test driver above uses existing
modules and completes successfully. Full active-label/interval translation,
additional capture/annotation interactions, topology/corpus reruns and production
regression remain required before a broader conformance claim.
:::

:::llm gpt-6 2026-11-10 role=assisted

The patch is now integrated independently of numeral pruning and vertex order.
Do not reapply the historical patch to the current compiler. The 55 focused tests
also pass directly in the working checkout. Native, corpus, topology and complete
regression checks are being renewed for this revision. The prior production run
finished normally: 745 tests in 1513.821 seconds, with 33 failures and 46 errors.
That result describes the preceding condition-inference revision, not this change.
:::

:::llm gpt-6 2026-11-10 role=assisted

Working-compiler validation completed: 55 focused tests, four canonical targets,
two agreement proofs, and the 92-proof generated corpus passed. The complete
regression finished normally with 750 tests in 345.098 seconds, 33 failures and
46 errors. These counts do not establish general conformance; the test suite
still fails. All 18 topology verifiers also passed on this revision.
:::
