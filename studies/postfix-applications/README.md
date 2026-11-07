:::llm gpt-6 2026-11-07 role=assisted

# Applying returned functions

This study exercises `f(x)(y)`, field application followed by another application,
and directly applied function expressions. The specification is
[postfix applications](../../docs/postfix-applications.md).

`Statements.clean` contains five readable examples. `verify.py` compares their
complete native targets against independent expected declarations. Three further
oracles check a supplied dependent proof argument and congruence applications
whose function bodies contain a quantifier or another lambda. The latter retain
their applications; no new binder-body reduction is claimed.

Run `LAKE=lake python3 studies/postfix-applications/verify.py`. Eight canonical
comparisons and five Lean proofs pass in the main tree. The isolated implementation
passed 227 focused Python checks, including syntax trees,
grouping, precedence, multiword-name errors, arity/domain failures, spelling and
LaTeX grouping. The main tree also passes its nine postfix tests. The one-page PDF was compiled twice and inspected.
Broader validation is tracked separately.
No new axioms or `sorry` are used.
:::
