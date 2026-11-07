:::llm gpt-6 2026-11-07 role=assisted

# Contextual numeral completion

Status: isolated prototype on top of [explicit numeral bindings](module-numerals.md).
This is a first closed-carrier inference rule, not main-compiler integration or a
complete default/typeclass inference design. Mathematical meaning still comes
from imported Numerals declarations; no name such as Natural is privileged.

## Readable forms

With the explicit Real, Counting and Twin declarations in
[Common.clean.proposed](../studies/module-numerals/Common.clean.proposed), where
Counting wraps Nat and Twin independently wraps Real:

| Authored form | Outcome |
| --- | --- |
| `x + 1`, with `x: Real` | Real numeral constructor |
| `1 + x` | Same constructor; operand order does not set a default |
| `(1 + 2) + x` | Both numerals use Real |
| `x + (1 + 2)` | Both numerals use Real; parentheses are retained in rendering |
| `real sum(1,2)` | Declared parameter types select Real |
| `counting sum(1,2)` | Declared parameter types select Counting |
| `equal(x,1)` | The generic parameter inferred from x constrains the numeral |
| `-1` | The sole applicable prefix declaration selects Real in this example |
| `1 + 2` | Ambiguous: Real and Counting addition both apply |
| `1` | Ambiguous: three declared interpretations |
| `Define one(): Real` with `Equals: 1` | The declared return type selects Real |

This layer alone has no fallback default. The subsequent
[explicit default declaration](numeral-defaults.md) can narrow a fully checked
ambiguous solution set without overriding type constraints. The old special treatment of Natural/Real/Complex, including the broad
NUM compatibility predicate and local-definition Natural fallback, is removed
from this experimental expression layer. Dimension literals inside type syntax
remain a separate migration obligation.

## Syntax and scope

The grammar is unchanged. An ordinary numeral remains `Decimal(digits)` in the
unique source tree. The inference pass validates ASCII digits before choosing any
interpretation. Existing explicit annotations remain fixed; they are not holes.

A hole is a Decimal in an expression position. Traverse callable arguments,
application heads/arguments, projection bases, binary/unary operands, and binder
bodies in source order. Do not scan native payload strings, type-annotation
strings, explicit numeral annotations, or saved binding metadata for holes.
Unknown expression constructors report incomplete analysis. Type annotations and
their computed indices continue to enter their own existing elaboration boundary;
this pass does not claim joint inference across those boundaries.

The candidate domain is the finite set of currently visible, closed module
carriers with their own Numerals attachment. Aliases do not add candidates.
Validate each attachment and retain its native identity snapshot before trials.
Local type binders are not candidate declarations. A bound module interpretation
cannot later be captured by a same-named local.

## Constructive completion rule

For a parsed expression E, fixed explicit environment Γ, local scope Δ, and
optional determined expected type T:

1. Collect its expression-position holes. If there are none, perform ordinary
   checked elaboration and check T when supplied.
2. Form the Cartesian product of the declared carrier domain over those holes.
   Enumeration is sorted by immutable declaration identity for reproducible
   diagnostics; sorting is not a preference rule.
3. For each assignment, replace every hole by a checked BoundNumeral retaining
   its selected carrier/constructor identity. Elaborate the entire expression
   with a fresh local-scope copy and reset binder counter.
4. Reject an assignment only for a type/signature mismatch owned by that trial,
   or because its determined result type differs from T. Eligible operator
   selection still uses the existing input-signature rule. An ambiguous operator
   is not a failed numeral candidate and is never swallowed.
5. Propagate foreign mismatches, invalid declarations, unknown names, other
   semantic errors and incomplete analysis. Even an earlier successful assignment
   cannot hide a later unresolved candidate.
6. After all assignments are accounted for, accept exactly one successful
   assignment. Zero gives “no consistent numeral interpretation”; more than one
   gives “ambiguous numeral interpretation.” Do not select the first success.

Assignment identity, not normalization of native results, is the ambiguity unit.
Distinct permitted carrier assignments remain ambiguous even if a later reduction
could erase their difference. This is an explicit conservative language policy.
The pass does not use return types to resolve an already ambiguous operator or
backtrack over arbitrary Clean errors. More general constraint solving must
preserve or explicitly revise these rules rather than silently widening them.

An expected type is currently supplied by a declared Define return type and by
the elaboration API. Named calls, function applications and operator operands
constrain complete assignments through their checked signatures. This makes the
rule independent of whether informative operands occur on the left or right;
there is no greedy “use the first known operand” step.

The prototype admits at most 4096 candidate assignments per call. This is an
analysis resource bound, not a mathematical or grammar restriction. Exceeding it
raises IncompleteNumeralAnalysis before returning any candidate. The lower-level
completion API accepts an explicit positive limit. Pruning constraints and CLI
budget controls remain future work; long, clearly typed expressions can currently
hit this bound unnecessarily.

## Retention and rendering

The checked atom is `BoundNumeral(digits, carrier, snapshot, "inferred")`.
The first four fields have the same identity/validation rules as an explicit
annotation. The fifth records how the atom was authored, not a new constructor.
Lean emits the same root-qualified constructor and primitive Nat payload as the
corresponding explicit annotation. No overloaded native numeral or coercion is
inserted at the use site.

LaTeX and source printers show an inferred numeral as its digits. Explicit
annotations retain their visible type. Automatic assumption labels normalize
leading zeros in inferred numerals. An explicit annotation can consequently
produce a different label from an inferred numeral denoting the same value;
labels document authored expressions, not semantic equivalence classes.
Substitution, comparison and JSON index reconstruction retain the binding and do
not reopen inference when surrounding declarations change.

## Evidence and remaining obligations

Fresh staged reconstruction passed on 2026-11-07. The [inference verifier](../studies/module-numerals/verify_inference.py) checks
independent native expression, definition and statement targets, four theorem
proofs, left/right and nested context, a renamed Nat carrier, generic calls,
expected return types, scope preservation, reversed candidate order, ambiguity,
resource exhaustion and exception ownership. A delayed failure test checks that
an earlier successful assignment does not terminate the search prematurely.

The isolated stack remains subject to the broader native declaration identity,
import/instance isolation, parameterized numeral carriers and full portfolio
integration obligations. These examples do not establish complete inference for
all dependent type positions or module-declared defaults. Research theorem gaps
are unchanged by numeral inference.
:::
