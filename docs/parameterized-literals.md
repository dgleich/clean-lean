:::llm gpt-6 2026-11-10 role=assisted

# Parameterized literals: proposed declaration and inference contract

**Design work, not implemented or accepted as fully specified.** The current
compiler's closed-carrier numeral rule cannot express `(0: Vector(n,Complex))`
or infer that interpretation in `x != 0`. Adding another closed carrier or
replacing zero by a named function in every theorem would not solve that problem.
The intended end state includes ordinary unannotated mathematical uses.

The proposed extension attaches an exact literal to an ordinary declared
constructor. Mathematical meaning remains in explicit Clean modules. It does not
introduce a separate registry, a builtin Vector/Matrix case, or a search for a
convenient dimension variable in the caller's scope.

```clean
Notation complex vector zero(n):
  Let n: Natural
  Returns: Vector(n,Complex)
  Means: fun _ => (0 : Complex)
  Literal: 0
  Render latex: 0_{{{n}}}
```

The constructor remains callable by its English name. The `Literal` field makes
it a candidate for zero at its declared result type. A rectangular matrix zero
constructor can similarly recover both dimensions. It does not assign a meaning
to matrix one: an identity-matrix constructor would be a separate declaration
whose square result pattern must match. See the
[authored specimen](../studies/parameterized-literals/Zero.clean.proposed).

## Proposed syntax and source trees

The additional field is allowed only in a `Notation` or `Define` declaration
with an explicit `Returns` type:

```text
literal_field := case_insensitive("Literal") ":" ASCII_DIGITS
ASCII_DIGITS  := [0-9]+
field tree    := LiteralAttachment(canonical_digits)
```

There is exactly one literal field per declaration. Reject a duplicate, empty
payload, expression payload, sign, Unicode digit, list of digits or field on a
Condition/Type/Result. Comments and layout follow the ordinary lexical rules;
the payload is not native Lean text. Canonicalize leading zeroes for matching,
so `Literal: 00` and `Literal: 0` denote the same digit value. Keep source spelling
separately for diagnostics and rendering. A declaration is registered only after
its body is checked, so its own literal metadata cannot recursively justify that
body's unqualified numerals.

Expression parsing does not change. Bare zero remains `Decimal("0")`; an explicit
annotation retains the existing `NumeralAnnotation` tree and its parsed type.
Neither the selected constructor nor typing success may change that source parse.
The field grammar and duplicate-field rejection must be implemented before the
specimen is accepted; today's compiler rejects `Literal`.

## Proposed declaration eligibility

The result must be a determined Type-0 carrier pattern in the declaration's bound
module environment. Every additional constructor parameter must be recoverable
from a direct occurrence in that result pattern. A direct formal type/value
parameter can be recovered; a computed expression is checked only after its
parameters are recovered elsewhere. Do not invert `n+1`, a function application,
a carrier projection or a proof-producing operation to guess a parameter.
Repeated occurrences must agree under the existing specified type/index comparison.

For example, `Vector(n,Complex)` can determine `n`, and `Matrix(n,n,Complex)` can
check that both dimensions agree. `Vector((n+1),Complex)` alone cannot determine
`n` under this rule. Extra evidence or structure parameters absent from the result
are not found by proof search or instance search. Such an attachment is rejected,
although its ordinary named constructor may still be usable with explicit arguments.
Transparent Clean aliases use their existing declaration-bound expansion; arbitrary
Lean definitional equality does not make two nominal Clean carriers interchangeable.

This rule needs a formal pattern grammar and an eligibility checker. Dependent
function results, carrier projections and arbitrary universe-polymorphic outputs
remain outside this proposed first implementation; they are not silently inferred.
The general literal-family design must not claim those cases are complete.

## Explicit annotations and a constructive Lean target

For `(0: Vector(n,Complex))`, resolve the annotation in the caller scope. Consider
all visible matching exact-literal declarations and existing Numerals attachments.
Match each eligible result pattern to that determined carrier. Recover the ordered
actual parameters, check their declared types and every repeated occurrence, and
reject missing parameters. Distinct valid constructor declarations remain distinct
interpretations even if their Lean bodies are definitionally equal.

For a unique match, retain the constructor's declaration identity, bound result
pattern, ordered actual arguments and digit value in an internal literal binding.
Emit a fully applied root-qualified invocation of that constructor, with the
recovered arguments in declaration order. Schematically:

```text
(0: Vector(n,Complex))
  → BoundLiteral("0", constructor_identity, [checked_n], checked_result_type)
  → @_root_.declared_vector_zero checked_n
```

The ordinary constructor wrapper already fixes its body and result type; no
ambient coercion or fresh native instance search is inserted at the literal use.
This is a constructive target rule, not permission to emit a bare Lean `0` and
let Lean guess the intended carrier. The existing native declaration isolation
obligations still apply to the wrapper's own body.

Binding must survive later shadowing and reject changed constructor identities.
Substitution must preserve caller bindings and avoid capturing a caller's `n`
with the constructor formal also named `n`. The new internal binding must be
handled explicitly by comparison, alpha-renaming, inferred arguments, assumption
names, LaTeX, serialization and retained-call consumers. No fallback string
rendering may conceal an unsupported constructor.

## Unannotated uses: constraint solving still needs specification

The required example is `x != 0` for `x: Vector(n,Complex)`. The declared inequality
callable relates its operand types; its first operand determines the common type,
which determines the zero constructor and its dimension. The compiler must obtain
the same result for `0 != x` and for equivalent nesting. Checking operands strictly
left-to-right and failing on an initially untyped zero is not an acceptable policy.

Candidate *declarations* are finite, but parameter values are not a finite list of
all vectors or dimensions. The intended solver enumerates declaration choices and
solves structural type/index constraints; it does not enumerate natural numbers
or collect guessed dimensions from nearby variables. A candidate with an unresolved
parameter cannot be silently dropped merely because another candidate is complete.
Without an applicable declared default, such a competing candidate must prevent
acceptance and be reported as underdetermined. Resource exhaustion remains a
separate incomplete-analysis result.

Closed-carrier defaults must retain their simultaneous, whole-expression behavior.
A Natural default cannot override a vector type forced by an operand. Defaults
must also account for unresolved candidate families: restricting a candidate to
Natural may reject its result pattern or determine a type parameter, but may not
choose a dimension. Two different constructors for the same preferred carrier
remain ambiguous. Conflicting simultaneous default restrictions remain errors.

The exact constraint calculus, interaction with dependent callable matching and
computed indices, default restriction algorithm and finite resource accounting
are **not yet specified enough to implement**. These are acceptance blockers for
unannotated parameterized literals. The integrated child-pruning search assumes
children are checked independently of parent expected types; this extension would
change that boundary and therefore needs a new equivalence argument or a different
solver. Reusing its current pruning rule unchanged would be unjustified.

## Acceptance obligations

| Input or interaction | Required outcome |
|---|---|
| `(0: Vector(n,Complex))` | Unique constructor application with the caller's n |
| `x != 0` and `0 != x`, x a complex n-vector | Same declared zero interpretation; no operand-order default |
| `(0: Matrix(m,n,Complex))` | Rectangular zero with both actual dimensions |
| Bare `0` with no constraining type/default and unresolved families | Underdetermined/ambiguous; never guess a dimension |
| Two zero constructors for the same matched type | Ambiguity, even if their bodies are definitionally equal |
| Renamed vector carrier and renamed constructor | Same rules; no display-name dispatch |
| Formal and caller both named n | Capture-free caller argument retained |
| Later declaration or shadowing | Bound identity and statement snapshot preserved |
| Computed result index with no direct recovery occurrence | Reject ineligible attachment rather than invert arithmetic |
| Interrupted competing candidate | Incomplete, not successful selection of another candidate |
| Exact zero attachment plus an all-numeral attachment at the same carrier | Competing interpretations; no specificity priority |

Tests must compare independently authored source trees and canonical elaborated
Lean types/bodies, not only definitionally equal terms. They must cover negative cases,
imports, candidate reordering, aliases, proof arguments, rendering and every new
expression consumer. Native example definitions are available in
[NativeExample.lean](../studies/parameterized-literals/NativeExample.lean); their
kernel checks do not establish Clean parsing, inference or target conformance.

The implementation sequence is declaration/annotation binding, then a fully
specified joint inference rule, then the real vector/matrix examples and regression
suite. Finishing only the annotated form must not be reported as completing the
requested ordinary mathematical syntax. General parameterized numeral families
beyond exact digits, universe/sort polymorphism and native import isolation remain
separate obligations, not implicitly solved by zero constructors.
:::
