:::llm gpt-6 2026-11-07 role=assisted

# Scoped callable evidence — integration draft

Status: implemented only in the isolated prototype linked from the
[subpath study](../studies/subpath-restrictions/design.md). This document proposes
the integration contract. It does not claim that the repository compiler supports
these rules, or that the prototype has completed the language acceptance audit.

## Source syntax and one parse

No expression production, keyword, precedence or layout rule changes. In the
fixed explicit module environment, `h(x)` still parses as
`["Call", "h", [["Local", "x"]]]`. A projected call uses the existing Apply tree.
Types still use the existing neutral ComputedIndex syntax for parenthesized
expressions. In particular, Evidence is a module-declared transparent alias:

```clean
Type Evidence(condition: Proposition):
  Equals: (condition)
```

A syntax-only condition serializer preserves Forall, Exists and Lambda nodes,
including nodes inside type annotations. It does not classify an expression as a
condition, consult imports or select a type. Existing binder-free index spelling
remains available separately. Argument type checking determines whether the
scoped condition-index rule below applies. No successful type check selects
between distinct parses.

```clean
Assume h: for every (x: Natural,x = x)
Let n: Natural
Let p = h(n)
```

Existing assumption naming rules remain in force. A usable evidence local must
have a single identifier as its label; this proposal does not add references to
multiword assumption labels. Existing local function application takes one
argument at a time. A nested universal can be used by saving the intermediate
result, such as `Let k = h(n)` followed by `Let p = k(m)`.

## Scoped condition indices

A checked expression C of the foundational condition type has a scoped index
containing its source tree, emitted Lean term, display term, comparison key and
captured local-expression environment. ProofType(C) emits the original Lean
term for C as its type. Neither a callable view nor comparison normalization
replaces that emitted term.

The scoped representation is also used for condition-valued arguments to type
constructors. This permits `Evidence((for every (x: Natural,x=x)))` through the
ordinary alias rule. It does not permit binders in other computed value indices.
An ordinary index whose type is a function, number, set or record retains its
existing binder restriction. Universe and carrier gates remain unchanged.

Substitution is simultaneous and capture-avoiding. It substitutes through bound
variable domains, condition bodies and type annotations, renaming binders in
inserted actual expressions before re-elaboration. Existing checked contraction
of immediately applied binder-free lambdas is retained. Higher-order beta
reduction with binders in the body remains outside this draft.

Captured free locals are not silently rebound. If an active substitution scope
contains a different Lean term or type for a used captured local, that local
must be an explicit member of the substitution mapping. Otherwise elaboration
rejects a captured-proof-scope conflict. Unused captured names do not trigger
this check. Conflicting names are inspected in sorted order for deterministic
diagnostics. This is a rejection boundary, not permission to resolve a conflict
by choosing whichever scope happens to be visited first.

## Deriving a callable view

For a proof type, derive the view from its checked Clean condition in its captured
scope. Use the existing deterministic authored conversion policy, including its
implicit-argument reification and hygiene rules. Only already selected authored
definitions may expand. Do not inspect opaque native Means bodies, invoke Lean
elaboration to discover a function type, or try candidate reductions until one
happens to fit the intended call.

After this conversion, the exposed head determines the view:

| Checked condition head | Callable view |
| --- | --- |
| `for every (x: T,C)` | Dependent function from T to evidence of C |
| `P → Q` | Function from evidence of P to evidence of Q |
| Any other head | No callable view from this rule |

The universal binder gets a fresh owned identity. Its domain is checked in the
captured outer scope and its body is checked with that binder in scope. Applying
the function substitutes the checked actual for that identity. The body may itself
be universal, existential, conjunctive or any other supported condition; its
being a result does not make it callable. For example, evidence of an existential
condition can be returned and saved without choosing a witness.

Equality, conjunction, disjunction, existential quantification and negation do
not acquire callable views merely because they are conditions. Negation is a
possible later extension. If authored conversion cannot expose a head within its
specified boundaries, that condition has no callable view under this rule. An
incomplete analysis due to resource exhaustion is not a successful negative
classification and must not enable a fallback target.

## Resolution, matching and the exact Lean term

Resolution retains the existing function-local rule: a local with a callable
view takes precedence over a same-named module callable. A local without a
callable view does not displace a module callable in call position. There is no
first-success fallback after selecting a callable local: the wrong argument type
or arity is an error, even if a module callable with that name could accept it.

If H is the selected Lean term for local h and A is the selected Lean term for
its argument a, the target of `h(a)` is exactly ordinary application `(H A)`.
The result type is the checked codomain with the actual substituted. The target
of a projected application similarly applies the selected projection term. No
eta expansion, cast, replacement evidence, proof search or instance inference
is introduced by this feature.

Passing evidence to a function-typed parameter emits the same original evidence
term. Matching exposes callable views at each function-type boundary. For known
types, compare domains and then codomains under a shared fresh binder, recursively;
this applies to higher-order and nested dependent functions as well. It is type
equality through the specified views, not subtyping or function extensionality.
Existing declared implicit-argument matching may infer its usual parameters,
but no shared comparison binder may escape into an inferred argument. Application
of a known local function performs no new parameter inference.

For a named authored condition, Lean may unfold its definition to check ordinary
application. That kernel conversion is not an alternative emitted target. Exact
native comparisons must still retain the original named condition as the
assumption's type and the original evidence term as the argument.

## Required acceptance evidence

The isolated study records independent native targets for direct and named
universals, nested calls, projected proof fields, function/proof domains, captured
free variables and type scopes, implications and local evidence aliases. The
additional collision and nested-function cases must also have exact native
oracles, not only successful translation tests.

Negative cases must cover wrong domains and equations, opaque native conditions,
noncallable condition heads, captured-scope conflicts, escaping comparison
binders, ambiguous arrow bindings and forbidden non-condition indices. Preserve
all existing universe restrictions. Tests must check alpha-renamed binders and
compiler-like source names without normalizing unrelated free names away.

Before integration, update the normative spec, decisions, acceptance catalog and
Clean-to-Lean HTML reference together. Complete the expression-consumer audit,
run the full regression suite and kernel checks, and refresh the review browser.
The prototype's focused tests and native fixtures do not by themselves prove
conformance with this contract.
:::
