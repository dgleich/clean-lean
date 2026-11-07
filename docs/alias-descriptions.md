:::llm gpt-6 2026-11-07 role=assisted

# Transparent alias descriptions

Implemented presentation slice; the full-suite run remains pending.

```text
Type Selected(A: Type,S: Set(A)):
  Equals: Element(A,S)
  Describe: a selected element of ${S}$
  Describe plural: selected elements of ${S}$
```

An `Equals` type alias accepts only `Equals`, `Describe`, and `Describe plural`.
The existing type-header, layout, field-label, and template grammars apply without
new tokens or productions. Field labels are case-insensitive, each field occurs
at most once, and templates may reference only declared parameters. Format specs,
conversions, unknown placeholders, `Means`, `Render latex`, and `Universe` are
rejected in an alias declaration. Literal template braces are doubled, as for
existing type descriptions. `Equals` remains mandatory for this alias form.

## Unique interpretation

First parse the existing declaration header and fields. Resolve and check its
parameters in declaration order. Compile each named template placeholder to that
parameter's unique ordinal. Resolve `Equals` using the existing transparent-alias
rule. Description fields do not create a Lean declaration, alter alias expansion,
select an overload, change inference, or contribute a proof or universe.

For a typed `Let`, resolve its type exactly as before. After any explicit Phrase
mapping or simple Alias name mapping, inspect only the outer authored constructor.
If it is a transparent alias with description metadata, instantiate that metadata
with the already checked actual arguments and freeze it on the statement clause.
Type actuals use their expanded mathematical type rendering; value actuals use
their checked expression rendering. Do not globally associate prose with the
expanded type: distinct aliases of that type may have distinct descriptions.
Do not inherit the wording of an inner alias.

Choose `Describe` for one declared name and `Describe plural` for multiple names.
If that field is absent, use the existing description of the expanded
semantic type. Do not infer a plural by modifying a singular phrase. Nested aliases
and aliases in function signatures still normalize normally; this feature customizes
the prose of typed statement/context `Let` clauses, not every displayed type.

## Contexts and scope

Presentation never creates semantic dependencies. Record, conservatively, all
caller-local identifiers occurring in the authored alias arguments. When context
parameters are pruned, retain frozen descriptions only if those dependencies have
already been retained in scope; otherwise use the expanded type's description.
The original explicitly referenced context retains its full descriptions.

For example, if `Tagged(A,S)` expands to `A`, a result using only `x: Tagged(A,S)`
may omit `S` from its generalized parameters. Its repeated statement must not say
“an element marked by S” after omitting S. The fallback solves this without adding
an otherwise unused Lean quantifier. The conservative rule may discard a description
even when its template does not mention the omitted argument; this is deterministic.

## Acceptance evidence and boundaries

The [study](../studies/alias-descriptions/Statements.clean) gives two distinct
aliases of one subtype plus a plural declaration. Three independently authored
canonical Lean statement targets and three proofs pass. Ten focused tests cover
separate alias wording, exact generated Lean preservation, plurality, invalid
metadata, phrase expansion, outer-alias selection and context pruning. Existing
context tests also pass. Grammar generation is unchanged; no mathematical meaning
is assigned to the alias display name.

The global suite, browser snapshot refresh, and general binding/elaboration
conformance remain separate obligations. This feature does not resolve native
adapter uniqueness or the unfinished interval-label theorem.
:::
