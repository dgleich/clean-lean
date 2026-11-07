:::llm gpt-6 2026-11-07 role=assisted

# Operators inside saved conditions and type annotations

[BoundOperators.clean.proposed](BoundOperators.clean.proposed) composes the isolated
carrier/binding/annotation work with explicitly declared prefix and infix operators.
It preserves operator selection through generic specialization and later declarations.
It imports Mathlib foundations explicitly and introduces no registry or built-in
operator fallback. Main Clean remains unchanged.

## Source and scope rules

Condition declarations may use the existing `Infix:` or `Prefix:` field in this
composed prototype. They use the same token, arity and ambiguity rules as notation
and definition declarations; a Condition still returns a condition. Invalid arity
must not publish a partial callable. Parsing remains the shared field grammar.

Check an authored body and resolve its operator heads before publishing that
declaration's own operator metadata. For example, the specimen's authored
`another sum` uses the earlier `sum` binding in its body, then adds a second `+`
candidate. Fresh natural addition becomes ambiguous, but the checked body retains
its original target. Defining an operator does not make its body recursive.

When storing a condition, index, annotation or resolved body, each operator node
records the uniquely selected adapter and its exact target template. Its semantic
representation is ModuleCall with an additional `(fixity, source token)` presentation
tag. Substitution changes the operands, never the chosen adapter. Re-elaboration
validates the template and checks the selected adapter's arguments directly; it does
not search the current overload table. This still instantiates the adapter's inferred
arguments from the substituted operand types under its declared signature.

The presentation tag retains prefix/infix source spelling, grouping and precedence.
It is preserved by hygiene, beta reduction, index/proof substitution, projection
reduction and source/assumption-label serialization. It cannot choose mathematical
meaning. Named calls to an operator declaration use the same precedence-aware
renderer, so `negation(implication(P,Q))` retains the same grouping as `not (P → Q)`.
Rendering recomputes from the original operand presentations rather than wrapping
already-grouped text a second time. A right-nested named sum is parenthesized; a
left-nested sum follows the existing left-associative display rule.
Reordering overload candidates changes neither a stored target nor the
fresh ambiguity diagnostic policy.

Ordinary unannotated calls retain the earlier conservative body-opacity rule after
operator-scope changes. A stored module call may use its resolved body across such
changes, since that body's operator heads and annotations are already retained.
This distinction is internal; it does not introduce a new authored calling syntax.

## Implication is defined in Clean

The specimen authors implication as:

```clean
Condition implication(p: Proposition,q: Proposition):
  Infix: →
  Holds when: for every (h: (p), q)
```

Its resolved body gives a saved proof type a callable view. The verifier also loads
a separate environment where the same arrow token is backed by conjunction instead.
That condition has no callable view. The token alone therefore does not authorize
proof application. Equality and negation remain explicit foundational Lean adapters;
implication and the study's mathematical helper definitions are authored in Clean.

## Evidence

Run `LAKE=lake python3 studies/carrier-fields/verify_bound_operators.py`. The driver
copies tracked files, applies the four carrier/binding/annotation patches followed by
[composed-operators.patch](composed-operators.patch), and regenerates/checks the
parser strictly. Do not additionally apply the standalone module-operator patch.
The composition patch includes its changes with the binding-aware adaptations.

The new fixture has seven independent exact targets and three proofs:

- Generic equality remains selected when a later natural-equality overload exists.
- Prefix negation retains its adapter and grouping around authored implication.
- The native body of implication matches its independently authored forall target.
- The authored second addition retains the earlier addition in its body.
- Three statement targets retain their evidence, explicit lets and quantified types.

Negative/interaction cases cover fresh ambiguity, candidate reordering, a later
competing prefix, changed selected templates, invalid Condition operator arity,
source-label spelling, named/operator rendering equivalence, and a non-callable
alternative meaning for the arrow token. The initial composition exposed missing
parentheses in the named negation form; the shared renderer fixes that discrepancy.
The generated fixture is [BoundOperatorsVerified.lean](BoundOperatorsVerified.lean).
The [PDF](BoundOperators.pdf) and [TeX](BoundOperators.tex) show the statements and
named/operator grouping checks. Implication renders in English as “implies.”
The driver also runs the standalone operator acceptance selection (32 targets/three
proofs) and carrier/operator fixture (five targets/three proofs): 44 targets and nine
proofs altogether. The fresh-copy run passed all three fixtures and strict parser
checks. The final English renderings and type descriptions were checked again with
the seven-target fixture; the PDF compiled twice and its one-page layout was inspected.
These drivers include syntax, dispatch and negative checks.

## Remaining gates

This is isolated composition evidence, not the full foundation migration. Existing
ordinary modules and the broad Python corpus still use undeclared built-in operators;
they cannot be validated with this compiler until explicit foundation imports and
literal policies are migrated. No fallback was added to make those modules pass.
Numeral/default interpretation, declaration-owned type identity, declared fixity,
editor support, full corpus/study checks and integration remain required. The previous
annotation-stack regressions cover that stack without the operator migration; they
must not be counted as passing against this composed compiler.
:::
