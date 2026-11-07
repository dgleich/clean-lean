:::llm gpt-6 2026-11-07 role=assisted

# Explicit numeral defaults

Status: isolated prototype, following [contextual completion](numeral-inference.md).
Defaults remain explicit module declarations; no builtin type name or implicit
prelude supplies one.

```clean
Import "Common.clean.proposed"
Default numerals: Counting

Result default addition:
  Attribution: local; default addition; original
  Conclude: 1 + 2 = 3
```

Counting is the study's declared Nat wrapper. The same mechanism works with any
eligible closed carrier owning a Numerals constructor. A Real-typed `x + 1`
still selects Real, even with Counting as the default.

## Parsing and scope

Add a top-level declaration:

```text
default_numerals_line := "Default" "numerals" ":" type_ref
normalized node      := DefaultNumerals(type_tree)
```

The two keywords are case-insensitive, separated by whitespace, and have word
boundaries. The colon is mandatory. The declaration has no indented block and
cannot occur inside a Type, Result or Context block. Its carrier uses the same
neutral type grammar as explicit numeral annotations. Parentheses support the
existing inferred logical-line continuation; a multiword callable such as
`default numerals(x)` does not become a directive in a continued expression.
Default has no special interpretation in ordinary expression positions.

Document recognition uses a distinct DEFAULT_NUMERALS_LINE and a distinct
`default_numerals_stmt` node. Its payload is independently parsed before binding.
It cannot overlap existing top-level declaration prefixes. Strict generation and
fragment tests reject keyword concatenation such as `Defaultnumerals`.

Resolve the type in the current module scope with no local value bindings.
Require a closed module carrier with a Numerals attachment. Aliases canonicalize
before selection. Store the pair of canonical carrier name and immutable native
identity snapshot; do not store just a display name.

Defaults are exported by Clean imports. Identical canonical bindings agree,
including through aliases or repeated imports. Different bindings conflict;
there is no last-import-wins behavior and no override priority. Reject a
conflicting declaration before changing the selected default. This deliberately
makes configuration monotone. A base vocabulary module should therefore omit a
default when clients need to choose different conventions; small optional modules
can import that vocabulary and declare the chosen default.

A declaration affects subsequent definitions and result snapshots only. It does
not retroactively resolve an earlier ambiguous result. There is no local/default
reset or Context override in this step. Such a feature would require an explicit
scope rule rather than silently changing this import policy.

## Selection rule

First run the complete finite assignment analysis described in
[numeral inference](numeral-inference.md). Validate the saved default identity,
but do not use it to skip candidates, bypass the analysis budget, suppress an
operator ambiguity, or swallow an unresolved alternative.

Let V be the set of successful carrier assignments after signature and expected
result-type constraints have been checked.

1. If V is empty, report no consistent interpretation. If V has one member,
   select it without defaulting; ordinary type information already suffices.
2. For each hole, compute its set of carriers across the original V.
3. A default restriction applies to that hole exactly when its set has more than
   one carrier and includes the declared default. Restrict all such holes
   simultaneously to the default carrier.
4. Keep only assignments in V satisfying every restriction. One survivor is
   selected. Multiple survivors remain ambiguous. No survivors means the default
   conflicts across ambiguous positions; require an annotation instead of
   choosing a position, a majority, or an import-order preference.

A hole whose viable carriers exclude the default is not forced to use it. A hole
already fixed by type information is also unaffected. All restrictions are derived
from the same V; deriving later restrictions after earlier filtering could make
source order change the result.

For example, hypothetical overloads accepting `(Real, Counting)` and
`(Counting, Real)` admit two assignments to a two-numeral call. Defaulting to
Counting cannot choose either assignment: applying the default to both ambiguous
positions would require `(Counting, Counting)`, which is not valid. The prototype
reports this conflict in either operand order.

These rules specify one selected assignment or a classified error. The selected
native target is exactly the target of that checked assignment; defaulting adds
no coercion or overloaded Lean literal. Identity and native import/instance
isolation obligations of the underlying adapter layer remain in force.

## Retention and mathematical presentation

Atoms whose ambiguity was resolved by the default retain
`BoundNumeral(digits, carrier, snapshot, "defaulted")`. Already-bound atoms never
reopen default selection. A subsequent scope with a different convention can
reuse the retained atom only if its original constructor identity still exists
unchanged. JSON index reconstruction preserves this information.

Source printers and automatic labels retain the authored numeral spelling;
labels normalize leading zeros. Lean emits the same constructor application as
an explicitly typed numeral. LaTeX displays a visible type annotation for a
**defaulted** atom. This keeps an extracted theorem from silently losing the
convention that selected its domain. Atoms determined without the default remain
ordinary digits. A later context-based presentation mode could avoid repeated
annotations, but must state and reference its convention explicitly.

VS Code/TextMate, Vim and Emacs lexical rules recognize the directive separately
from mathematical identifiers and preserve end-of-line comments. Portable browser
and native Vim scope checks run in the verifier; native Emacs execution is not
available in the current environment.

## Validation boundary

Fresh staged reconstruction passed on 2026-11-07. [The verifier](../studies/module-numerals/verify_defaults.py) checks independent
native expression/statement targets and four proofs, grammar and layout cases,
import confluence and conflicts, alias identity, sequential scope, expected-type
precedence, simultaneous selection, stale bindings, exception ownership and the
public CLI's emitted Lean file. The fixture is
[Defaults.clean.proposed](../studies/module-numerals/Defaults.clean.proposed).

Main-compiler integration, parameterized numeral carriers, broader dependent type-position inference, constraint
pruning and full native import/identity/instance isolation remain pending. This
policy does not resolve any unproved research theorem.
:::
