:::llm gpt-6 2026-11-10 role=assisted

# Comparing retained definitions after later operator declarations

Status: working compiler correction, with focused validation; broader validation
is pending. No new syntax is introduced.

The well-group study exposed two inconsistent comparison paths. An earlier
`nested pair(X,Q)` condition means `Q.relative ⊆ Q.ambient`. Later imports add
module and chain-complex equality operators. The condition's stored body already
retains its original subset operator, yet a plain named call was treated as
opaque after the overload environment changed. Record projection had the same
restriction. Separately, direct operator operands could expose hidden lambdas
where named calls kept them opaque. These differences caused equivalent evidence
types to disagree before Lean emission.

## Constructive correction

For an authored declaration with a checked retained body, named calls and retained
module calls may both use that body after an operator-environment change. All
internal callable identities are still validated when elaborating the retained
body. A changed identity is an error. A body without retained bindings remains
opaque after such a change. This applies to comparison expansion, authored
producer-field comparison, and the existing binder-free record-projection rule.
It does not enable native-body unfolding, implicit-parameter projection reduction,
or new caller-shadowing behavior.

When normalizing a binary or prefix operator operand, elaborate the authored
operand and compute its comparison form. If normalization introduces or retains
a binder, use the original checked operand for call reconstruction, just as the
named-call path already does. Otherwise use the normalized operand. This keeps
a hidden lambda from becoming a new authored actual argument. Whole-tree index
comparison and its binder identities remain governed by their existing rules.

For example, under explicit topology imports:

```clean
Define selected(): Set(Real):
  Equals: set of(function(x: Real,x=x))

Condition included(S,T):
  Let S,T: Set(Real)
  Holds when: S ⊆ T
```

The comparison keys for `included(selected(),S)` and `selected() ⊆ S` agree;
`S ⊆ selected()` still differs. A later competing Real equality does not alter
the retained equality inside `selected`. It does make a newly authored `x=x`
ambiguous when both meanings are eligible. Existing source order remains semantic:
we do not move imports across declarations or rebind earlier expressions.

The emitted named condition remains a call to its declared Lean constant. This
comparison rule does not replace emitted theorem statements with normalized
bodies. Record projection still uses its separately specified source-level
constructor reduction when eligible, now without an unnecessary dependency on
unrelated later operators.

## Parse and target uniqueness

The grammar, layout, precedence and lexical modes are unchanged. For a fixed
source environment, the retained-body presence test, identity validation,
substitution and operand binder test are deterministic. Existing overload
ambiguity and incomplete-analysis rules remain in force. No type-directed parse
selection or first-success operator search is added. No additional native
metavariable, proof, coercion or universe is selected by these rules.

## Evidence and limits

`tests/test_retained_conversion_scope.py` checks five cases: named condition
comparison after a competing declaration, authored record projection and its
emitted field term, refusal to expand an unretained body, rejection of a changed
retained identity, and named/operator agreement across the binder boundary with
a distinct reversed-subset negative. Together with inference, family, scope,
hygiene and space-equality checks, 60 focused tests pass.

The previous full run (before this correction) finished with 693 tests, 44 failures
and 70 errors. The current full run is pending. Passing focused checks is not a
claim of complete compiler conformance. Relative maps passes ten canonical targets and three proofs; five independent
inferred-value targets and two proofs also pass, as do all 92 corpus proofs.
Well groups now passes 30 canonical targets, five new proofs and fifteen
supporting proofs. Its independently authored expected terms retain the declared
operators and numeral constructor. The full regression remains pending.
:::
