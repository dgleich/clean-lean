:::llm gpt-6 2026-11-07 role=assisted

# Explicit equality for bundled topological spaces

A bundled space is a mathematical value, but its type is larger than the type of
an individual point. `TopologicalSpace` wraps `TopCat.{0}` and inhabits Lean
`Type 1`. Its points inhabit `Type 0`. Our current generic declaration introduces
`Let T: Type`, which binds a Type-0 carrier; its equality cannot compare the
bundled spaces themselves.

The existing declaration syntax can supply the missing foundational operation:

```clean
Condition same space(X: TopologicalSpace, Y: TopologicalSpace):
  Infix: =
  From Lean: X = Y
  Render latex: {X}={Y}
```

Its native adapter has the form below, with generated declaration identifiers
omitted for readability:

```lean
noncomputable def sameSpace
    (X Y : TopologicalSpaceWrapper) : PropositionWrapper := X = Y
```

Here the `=` in `From Lean` is native Lean syntax; the declared Clean operator
selects this adapter when both operands have the imported TopologicalSpace type.
The generic small-carrier equality remains available for points and continuous
maps. No universe promotion, display-name dispatch or first-success precedence
is added. Reversing the overload list preserves the selected result. Removing
this attachment makes `X=Y` fail instead of falling back to native equality.
A mixed space/point equality also fails.

The syntax tree remains `Operator("=", Local("X"), Local("Y"))`. Elaboration
checks all visible declarations under the existing overload rule; the generic
Type-0 declaration is ineligible here. The selected term applies the root-qualified
same-space adapter to the two checked values. This is a library declaration under
existing language rules, not a new parser or universe-inference rule.

The adapter is a useful concrete Mathlib wrapper, not a replacement for general
universe-polymorphic signatures. General carrier and operator universe parameters,
including constraints and unambiguous inference, remain unfinished language work.
Other large carriers must have their own eligible declarations until that work is
specified and implemented. Equality between proof values is another observed gap:
with an assumption `h: n=n`, the valid parse `h=h` has no eligible declaration.
The generic carrier restriction excludes both Lean Prop and Type 1; general
sort-polymorphic equality requires a more expressive carrier signature. We do not claim that all equality is now supported.

Validation passed in both the isolated checkout and the working compiler: 30
exact native targets, five space/continuous-map proofs, three overload-selection
tests and two deliberate Lean universe rejections. The expected adapter bodies and statement terms are
authored independently. The one-page specimen compiled twice and was visually
inspected. The adapter is now in `library/topology/spaces.clean`.
:::
