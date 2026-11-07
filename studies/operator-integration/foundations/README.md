:::llm gpt-6 2026-11-07 role=assisted

# Explicit Mathlib foundations on the composed compiler

These are proposed modules for the isolated operator compiler, not imports accepted
by the production compiler yet. They use ordinary explicit Clean imports and
module declarations; there is no accompanying registry or implicit prelude.
The driver is [../verify_prototype.py](../verify_prototype.py).

| Module | Declared vocabulary |
| --- | --- |
| [Logic](Logic.clean.proposed) | Type, conditions, generic Type-0 equality, conjunction, negation, authored implication |
| [Reals](Reals.clean.proposed) | Real, addition, multiplication, negative, order, authored difference |
| [Sets](Sets.clean.proposed) | Set, union, intersection, subset, membership, authored common part |
| [LinearAlgebra](LinearAlgebra.clean.proposed) | Natural dimensions, real matrices/vectors, product, application, scalar multiplication |

A module owns both its named callable and its operator spelling. For example,
`intersection(A,B)` and `A ∩ B` select the same declaration. The real-valued matrix
module deliberately specializes its carriers; this is not yet a general algebraic
structure/typeclass interface. Sets and equality accept arbitrary Type-0 carriers.
The wrappers expose basic Lean/Mathlib operations. The derived difference, common
part and implication definitions are authored in Clean.

## Readable source and precise target

[Statements.clean.proposed](Statements.clean.proposed) includes:

```clean
Result common part is contained:
  Attribution: mathlib; Set.inter_subset_left; adapted
  Let T: Type
  Let A,B: Set(T)
  Conclude: common part(A,B) ⊆ A
```

The common-part body selects the imported intersection declaration. The result
selects the imported subset declaration. Each emits its retained, root-qualified
native binding, with T supplied as the inferred carrier. The statement's type
binders reference the explicitly declared type abbreviations. The native oracle
checks these constants and argument applications exactly, not merely a simplified
formula equivalent to the result.

For membership assumptions the current supported forms are:

```clean
Assume in A: x ∈ A
Assume in B: x ∈ B
```

or the automatically named Condition calls:

```clean
Assume member(x,A), member(x,B)
```

Both produce the same canonical theorem target. Unlabelled infix assumptions
`Assume x ∈ A, x ∈ B` still reject: automatic naming currently requires a named
Condition call. Supporting operator-generated assumption names needs an explicit
naming/collision rule and implementation; this study does not silently add one.

## Validation

The foundation verifier checks 36 exact native targets: seven type bodies,
eighteen callable bodies, six statements, four inferred matrix/scalar applications,
and the automatically named membership statement. Six proofs establish addition
commutativity, the authored difference equation, intersection commutativity,
common-part containment, intersection membership and matrix-product application.
The difference equation unfolds its Clean definition; it is not an additional
proof of a new subtraction implementation.

Negative and interaction cases cover inconsistent matrix dimensions, a missing
application overload, independent import-order reversal, shared-import
deduplication, numeric-operand rejection and both forms of membership assumptions.
See [../FoundationsVerified.lean](../FoundationsVerified.lean) and
[../Foundations.tex](../Foundations.tex). The [PDF specimen](../FoundationsSpecimen.pdf)
was compiled twice and inspected for missing symbols and overflow. Its current
rendering of `x+(-y)` is `x + −y`; preserving optional authored parentheses or
adding readability parentheses around negative operands remains a presentation
improvement. The mathematical grouping is unchanged. The full composed driver now checks
62 exact targets and ten proofs across the three specimens.

## Remaining scope

These wrappers are a starting foundation slice, not the complete Mathlib library.
Topology structures, continuous maps, homology and the unresolved paper theorems
retain their separate obligations. Generic algebraic structures, universe-
polymorphic equality, literal interpretation and wider corpus migration are still
needed. In particular, numerals are not given an implicit Natural or Real default.
The old broader regression/corpus counts do not apply to this operator compiler.
:::
