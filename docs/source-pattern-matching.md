:::llm gpt-6 2026-11-07 role=assisted

# Match dependent signatures in declaration scope

This rule repairs dependent-call inference without changing grammar, source trees,
operator selection, or native adapter policy. It supersedes the earlier rule that
avoided repeat substitution only after **all** implicit arguments were inferred.

## Counterexample

```clean
Notation retain with law(n,f,h,z):
  Let T: Type
  Let n: Natural
  Let f: Function(Natural,Natural)
  Let h: Function(x: Natural,Evidence((f(x) = n)))
  Let z: T
  Returns: T
  Means: z
  Render latex: {z}
```

In a caller with natural numbers `n,m`, a real `z`, and evidence
`h: for every(x: Natural,n = m)`, the call is:

```clean
retain with law(m,function(x: Natural,n),function(x: Natural,h(x)),z)
```

While checking its third argument, the implicit type `T` is still undetermined;
the fourth argument will determine it as Real. Substituting the declared `n` and
`f` yields the caller's equation `n = m`. Feeding that already substituted equation
back into the declaration matcher incorrectly changes it to `m = m`. The prior
implementation rejected the valid evidence and accepted the wrong evidence at
this stage. This was a Clean elaboration error, not a failure of Lean's kernel.

## Constructive rule and scope invariant

A match carries an original declaration-scoped pattern, a checked caller-scoped
actual type, the current implicit substitutions, explicit checked actual arguments,
and a map from declaration-scoped dependent binders to shared fresh caller locals.

1. Traverse explicit parameters and structural type arguments in declaration order,
   with the existing structural inference and inconsistency rules.
2. For dependent arrows, match the domains first. Allocate one fresh shared local
   at the actual domain. Avoid names in either type, caller locals, explicit actuals,
   current inference substitutions, and the existing shared-binder map.
3. Rename the actual codomain's bound local to the shared local using the existing
   capture-avoiding substitution. It remains caller-scoped.
4. Keep the pattern codomain in its **original** declaration scope. Extend the
   shared-binder map with its binder, and recurse on that pattern and the renamed
   actual. Do not instantiate the pattern codomain and then re-enter inference.
   Ordinary arrows have no binder to add to the map.
5. At a value/proof-index comparison leaf, instantiate the original pattern once,
   simultaneously applying known implicit substitutions, explicit actuals, and the
   shared-binder map. Compare the result by the existing index/evidence key rules.
   A substituted caller expression is not recursively substituted again.
6. Direct structural implicit type/dimension positions retain their existing
   inference rules. Reject an inferred argument containing a shared comparison
   binder. Remove that temporary caller local on both success and failure.
7. After all arguments, require every declared implicit parameter to be determined.
   Instantiate the result once using the final substitutions and explicit actuals.
   Emit the original ordered Lean application with its selected implicit arguments.

The shared-binder map is local to recursive matching, never emitted or cached as a
new source meaning. It extends the existing simultaneous substitution rule; it
adds no equality proof, cast, coercion, proof search, or inferred higher-order
function. Implicits hidden only inside unsupported computations remain unsupported.

## Uniqueness and evidence

The grammar is unchanged. Matching still follows one ordered traversal; each
structural implicit binding is either the first determined value or must agree
with it. Each comparison leaf has one simultaneous substitution and one existing
comparison rule. The scope invariant prevents already inserted caller names from
becoming fresh declaration variables, independently of how many other implicit
parameters remain undetermined.

[The native study](../studies/partial-codomain-inference/README.md) checks an
independent call tree, five exact native targets, three proofs, and rejection of
incorrect evidence. Six Python regressions cover later type inference, direct
universal evidence, nested functions, and wrong equations. Existing callable,
family-comparison, scope, and conversion checks provide interaction coverage.
These bounded checks do not establish full language conformance or module-owned
binding identity. Full current-suite and topology checks must be reported with
their actual terminal status.
:::
