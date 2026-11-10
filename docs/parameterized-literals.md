:::llm gpt-6 2026-11-10 role=assisted

# Parameterized literals: proposed declaration and inference contract

**Not implemented in production or accepted as fully specified.**
An [isolated typed-literal prototype](../studies/literal-annotations/README.md)
now tests declaration selection and annotation targets, with explicit representation
and inference gaps. The current
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

The result-pattern calculus below specifies direct recovery for determined
carriers. Its conversion from checked Clean types and its production eligibility
checker remain unimplemented. Dependent function results, carrier projections and
arbitrary universe-polymorphic outputs remain outside this proposed first
implementation; they are not silently inferred. The general literal-family
design must not claim those cases are complete.

### Determined-carrier pattern calculus

The pattern language is an internal semantic representation, not new authored
syntax. All names below are declaration or local binding identities, never display
names. Normalize permitted transparent aliases using the existing bound type
expansion before constructing a pattern. Preserve nominal carrier identities.

```text
pattern ::= Constructor(identity, pattern*)
          | Parameter(formal_identity)
          | Fixed(checked_closed_term)
          | Check(bound_expression_identity, formal_identity*)
```

`Constructor` represents a declared carrier application with its ordered slots;
its identity determines each slot's sort. A `Parameter` occupies one complete
slot. `Fixed` contains no declaration formal. `Check` represents an index
expression whose formal dependencies are explicit; evaluating it substitutes
already recovered actuals into its bound expression. It is never an inverse
operation. This first calculus requires a Constructor at the result root. A bare
formal result type, function result type or projected result carrier needs an
additional specified rule and is not accepted by this calculus.

The checked declaration supplies a distinct-identity parameter telescope
`p₁:T₁, …, pₖ:Tₖ`, with each type depending only on earlier formals. Every formal
must occur as a Parameter somewhere in the result; occurrences solely inside
Check do not count. Every Parameter and Check dependency must refer to that
telescope. No undeclared formal, missing direct occurrence or duplicate formal
identity is eligible. Structural slot validation and telescope well-formedness
are declaration-checking prerequisites, not tasks delegated to a literal use.

Matching takes a fully determined caller carrier—no inference metavariables—and
has the following fixed phases:

1. Traverse corresponding Constructor nodes depth-first, left-to-right. Different
   identities or arities refute the match. At the first direct occurrence of each
   formal, record the actual slot term, including its caller binding identity.
   Later occurrences add equality obligations; they do not replace that first
   representative. Fixed adds an equality obligation. Check saves a deferred
   obligation without evaluating or recovering anything.
2. In declaration telescope order, check each recovered term against its formal
   type after capture-free substitution of the earlier recovered terms. All
   parameters must be checked, including parameters absent from a native body.
3. Discharge the repeated and fixed equations with the existing specified
   type/index comparison, in traversal order. Evaluate each deferred Check by
   substituting its ordered dependencies, then compare its determined result
   with the corresponding actual slot. Check obligations are discharged in
   traversal order after the other equations.
4. On success return the recovered terms in declaration telescope order, not
   result traversal order. These are the arguments of the literal constructor's
   fully explicit native call. The first occurrence rule fixes the representative
   even when two actual spellings compare equal.

A disproved equation or ill-typed recovered argument refutes that candidate.
An incomplete comparison, unsupported conversion or exhausted computation remains
incomplete analysis; it cannot refute a competing constructor. Invalid environment
errors propagate. This deterministic order also fixes which diagnostic is reported
first; it gives no interpretation priority to declarations.

For example, a pattern with slots `Check(successor,n), Parameter(n)` can recover n
from its second slot before checking the first. The single-slot pattern
`Check(successor,n)` is ineligible: it cannot recover n by arithmetic inversion.
A matrix pattern with two `Parameter(n)` slots checks squareness without guessing
an alternative dimension. Formal n and caller n are different identities, so
matching retains the caller's term rather than capturing it.

An [executable design model](../studies/parameterized-literals/pattern_model.py)
implements these phases over a deliberately separate symbolic representation.
Its twenty tests cover positive, negative, dependent-telescope and incomplete
cases. It is not a production eligibility checker, a Clean AST adapter, a proof
of the comparison oracle, or canonical Lean-target evidence. Joint inference
below still needs a separate calculus; this matcher only consumes determined
carriers and must not be used to discard unresolved families.

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

### Executable joint-constraint experiment

The [symbolic constraint model](../studies/parameterized-literals/constraint_model.py)
now exercises one proposed selection policy. It consumes a finite, exhaustive list
of declaration-choice rows. It is not connected to Clean parsing or elaboration,
and does not yet specify how dependent Clean signatures generate those rows.
It therefore does not discharge the blockers above.

Each row contains:

- The ordered identities of its selected literal/callable declarations. Distinct
  choices remain distinct interpretations even if native bodies coincide.
- A carrier term for each source literal position, in AST order.
- All arguments needed by its emitted constructor applications, in declaration
  telescope order, including implicit arguments and evidence.
- Structural equations relating the selected signatures, actual operand types,
  annotations and root expected type.

The model distinguishes type metavariables and index metavariables, rigid binding
atoms, and rigid declared carrier constructors applied to ordered slot terms.
Metavariable identities must be fresh per declaration occurrence and row; source
spellings are not identities. A caller dimension such as n is a rigid binding
atom, never an unknown natural number to search for. Computed indices must arrive
as already determined rigid terms: this model neither inverts arithmetic nor
implements the production comparison relation for those indices.

For each row, ordinary sorted first-order unification substitutes metavariables,
checks occurrences, and decomposes equal carrier constructors. Different rigid
heads, arities, sorts or rigid atoms refute the row. Variables may remain after
unification; that is a partial solution, not a reason to discard a candidate.
This experiment assumes every row was validated for names, declaration identity,
parameter eligibility and scope before solving. Arbitrary elaboration failures
cannot be reclassified as unification mismatches.

Defaults are computed from the same complete pre-default solution set. For each
literal position, do nothing if every surviving row gives the same determined
carrier. Otherwise, if any surviving carrier can unify with the explicit default,
add that carrier-equality restriction at the position. Apply all such restrictions
simultaneously to every row. A row is removed only when the added equations refute
it. If no row remains, report conflicting defaults. No restriction may choose a
free dimension, and two constructors at the same preferred carrier remain distinct.

After defaults, unresolved metavariables in any remaining carrier or required
emitted argument produce underdetermination. With all arguments determined, more
than one row is ambiguity; exactly one yields its selected declaration identities
and ordered arguments. Incomplete declaration enumeration or a resource-limit
failure is reported before accepting any candidate. The model caps row count and
per-row equation steps separately; a production resource-accounting rule is still
needed for row construction and delayed dependent checks.

For `x != 0`, the equality signature contributes a common carrier variable T,
`T = Vector(caller_n,Complex)` from x, and `T = Vector(literal_n,Complex)` from a
vector-zero candidate. Unification recovers literal_n = caller_n. Reversing the
operand order changes equation order but not the resulting determined argument.
For bare zero, an unconstrained literal_n remains unresolved. A declared Natural
default may rule out that vector family in favor of an actual Natural candidate;
it cannot manufacture a vector dimension when no default-compatible row exists.

Eighteen independent row tests cover these cases, rectangular/square dimensions,
conflicting simultaneous defaults, distinct declaration identities, evidence
arguments, occurs/sort checks and incomplete analysis. Together with the earlier
pattern model, 38 design tests pass. These are not canonical Lean-target checks.
Production row extraction, computed-index comparison, dependent proof constraints,
retained bindings, all expression consumers and actual `x != 0` translation remain
required. The current child-independent pruning algorithm is still not justified
for these contextual rows and must not be reused unchanged.

## Retained literal representation: proposed next step

The annotation prototype establishes selection and native calls, but its ModuleCall
desugaring loses the authored literal. A distinct internal BoundLiteral form is
needed before claiming full preservation. The following is a logical record, not
an implemented AST or finalized serialization schema:

```text
BoundLiteral(
  canonical_digits,
  original_digit_spelling,
  constructor_binding,
  ordered_formal_actuals,
  checked_carrier_annotation,
  origin = explicit | inferred | defaulted)
```

`constructor_binding` must identify the selected declaration, its literal attachment,
formal telescope, result pattern and native wrapper declaration. It is a snapshot,
not a request to search current declarations again. `ordered_formal_actuals` includes
**all** implicit and explicit actuals in declaration order, with their checked
binding trees. The annotation retains its determined carrier and free caller
identities. Display names alone cannot identify a constructor, type or dimension.

Replay validates the saved binding and parameter telescope, checks each recovered
argument in order, and checks the instantiated result against the saved carrier.
It emits the saved root-qualified constructor applied explicitly to all ordered
arguments. If a body or binding changed, report an error; do not choose another
literal candidate. Adding an unrelated competing literal does not change a stored
selection, although parsing the same new source may now be ambiguous. The existing
prototype already demonstrates that stability through ordinary retained calls.

Substitution must traverse both the ordered actual trees and the carrier annotation
with the same capture-free mapping, using the annotation's captured identities.
Then recheck agreement of the constructor result and substituted carrier. Neither
substitution nor beta comparison runs literal candidate selection or defaults.
The explicit vector-zero case substituting caller n by caller m must therefore
emit exactly the declared zero constructor applied to m, even if a new competitor
was imported in the meantime.

For surface spelling, explicit/defaulted literals retain a type annotation using
the existing numeral-annotation syntax. Inferred literals spell the original digits
without an inserted annotation. After substitution, use the deterministic spelling
of the substituted checked carrier rather than stale source names. Leading-zero
spelling may remain in presentation; matching and native application use canonical
digits. LaTeX should follow the existing explicit/inferred/defaulted numeral policy;
the constructor's Render field remains the rendering of its ordinary named call.
This rendering choice is proposed and recorded for later review.

Comparison uses the instantiated native call under existing bounded conversion,
not the digit spelling, origin tag or LaTeX. Free-reference collection must include
both actuals and annotation references, excluding the constructor's bound formals.
Automatic assumption names use the literal's deterministic source spelling and
continue to reject naming collisions. A closed retained literal contains no
unresolved numeral holes; a stored actual containing one is invalid binding data.

Persistence must round-trip the binding, ordered actuals, typed annotation and scope
identities. JSON encoding that silently converts an Annotation subclass to a plain
string is insufficient. The current resolved in-memory tree is not evidence that
its diagnostic syntax JSON preserves every binding. A versioned encoding and
round-trip oracle remain acceptance blockers; no fallback may reselect the literal.

### Consumer audit required before integration

The source audit identifies these paths. Each must implement the new constructor
or explicitly reject it at a documented boundary; silently returning an unchanged
unknown node is not coverage.

| Consumer | Required treatment |
|---|---|
| `core.Expressions`, `numerals`, proposed exact-literal elaborator | Validate and replay the saved selection; emit one fully explicit target |
| `bound_calls` | Freeze/revalidate the complete literal binding without a new lookup |
| `syntax` expression/condition spelling | Preserve deterministic literal and annotation spelling |
| `conditions` automatic naming | Use that spelling; retain duplicate/encoded-name collision checks |
| `annotations` references/replace/resolve | Visit actuals and captured carrier references; preserve identities |
| `dependent_functions` names/occurrence/type keys | Include true free identities; never expose constructor formals |
| `hygiene` | Simultaneously substitute actuals and carrier under fresh binders |
| `indices` substitution and persistence | Retain the binding and serialize it faithfully |
| `proof_types` | Preserve literal origin in stored proof conditions and captured scopes |
| `beta_indices`, `quantified_beta` | Traverse/recheck actuals while preserving the literal binding |
| `conversion` and the contextual-key prototype | Compare the fixed native application without reselecting meaning |
| `inferred_conversion` reification/value names | Reify the stored binding and its free values without source guessing |
| `numeral_inference` | Treat a complete BoundLiteral as selected, not a fresh candidate hole |
| `structures`, `carrier_types`, `type_values` | Handle or explicitly reject literal values in projections/carrier positions |

The [annotation study's additional tests](../studies/literal-annotations/test_annotations.py)
check stability under a new competitor, dimension substitution, an authored body's
saved selection, and rejection of deleted/changed call targets. A separate check
records the current named-call spelling as a **known limitation**, not the desired
final result. These checks use the existing ModuleCall machinery and do not establish
BoundLiteral support in the consumers above.

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
