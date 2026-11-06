:::llm gpt-6 2026-11-06 role=assisted

# Fixed universe levels

Implemented for imported `Type` declarations and authored `Structure` declarations:

```clean
Type TopologicalSpace():
  Universe: 1
  Means: TopCat.{0}
  Render latex: \mathrm{{Top}}

Structure TopologicalDiagram():
  Universe: 1
  Let source,target: TopologicalSpace
  Let arrow: ContinuousMap(source,target)
  Constructor: topological diagram
```

`Universe` is a case-insensitive metadata keyword. Its value is exactly one
canonical nonnegative ASCII decimal integer: `0` or `[1-9][0-9]*`. Signs,
leading zeros, variables, arithmetic and universe expressions are rejected.
The field occurs at most once, under the existing indentation/metadata rules.
It is legal only on these two declarations; an alias with `Equals` rejects it.
Header/field syntax is unchanged. The generated grammar recognizes the metadata
line; the declaration interpreter validates its value and placement. No parse
choice depends on Lean type checking.

For an imported type, `Universe: n` specifies the codomain of its generated
validation definition as Lean `Type n` (`Type` for zero). For a structure it
specifies the record's declared sort. Parameters and fields retain their written
order and existing translation. This is a fixed level, not an inferred minimum
or universe polymorphism. An opaque imported body whose type does not match the
specified sort fails Lean validation; source-only checking cannot establish it.

Omission preserves existing targets: zero for ordinary imported types and records;
the foundational exact `Means: Type` declaration has level one. The foundational
exact `Means: Prop` keeps its existing `Sort 1` spelling (Lean `Type 0`). Explicitly
writing the default normalizes to the same declaration identity and target as
omission. A nondefault level is part of the type binding's semantic data; the
record sort also participates in its generated identity. Lean's level parameter
lists and level arguments remain part of canonical target comparison.

`Let X: Type` still quantifies over small types, not all universes. Higher-universe
records may contain imported bundled values such as `TopCat.{0}`. Type-valued
carrier fields, projections used as types, universe variables and level inference
remain unsupported. Writing `Universe: 1` does not enable those features.

## Explicit topology module

[`spaces.clean`](../library/topology/spaces.clean) imports the pinned Mathlib
`TopCat` and `ContinuousMap` definitions. `Point(X)` denotes its actual carrier;
`ContinuousMap(X,Y)` uses exactly `X.str` and `Y.str`. The native adapter templates
parenthesize compound type expressions before substitution into larger types.
The map type is Mathlib's bundled continuous function, not its separate category
morphism wrapper. `TopologicalDiagram` and `identity diagram` are authored in Clean.

The module currently repeats the spaces in calls such as
`continuous value(X,Y,f,x)`. This is explicit and checked, but is not the final
readability interface. Inferring value indices from dependent argument types or
allowing bundled maps to be called as `f(x)` needs a separate specified rule.

[`verify_spaces.py`](../studies/topology/verify_spaces.py) compares independently
written native declarations against 24 canonical targets, including levels zero,
one and two, dependent fields, constructors and statement types. It retains
universe levels, instances, projection indices, and argument order. Five theorems
are proved; two incorrectly lowered universe declarations must fail the kernel.
The Python tests cover default normalization, invalid levels, alias rejection and
index mismatch. These checks cover this slice, not the remaining opaque Lean
elaboration or whole-language uniqueness obligations.
:::
