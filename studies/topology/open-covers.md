:::llm gpt-6 2026-11-11 role=assisted

# Open subsets and certified covers

The [module](../../library/topology/open_covers.clean) supplies the previously
missing `OpenSubset(X)` input of the proposed Mayer–Vietoris statement. It uses
existing syntax and explicit imports: no implicit topology, invented sequence,
or assumed exactness is introduced.

```clean
Structure OpenSubset(X: TopologicalSpace):
  Let carrier: Set(Point(X))
  Let openness: Evidence((open in(carrier,space topology(X))))
  Constructor: open subset

Condition covers space(X,U,V):
  Let X: TopologicalSpace
  Let U,V: OpenSubset(X)
  Holds when:
    for every (x: Point(X), x ∈ U.carrier or x ∈ V.carrier)

Structure OpenCover(X: TopologicalSpace):
  Let left,right: OpenSubset(X)
  Let covering: Evidence((covers space(X,left,right)))
  Constructor: open cover
```

`OpenSubset` is a Clean record, not an opaque name for an unspecified object.
`open overlap(X,U,V)` constructs another such record in Clean. Its only new
native import is evidence from Mathlib's `IsOpen.inter`; the underlying set
intersection and bundled topology wrappers already exist. Coverage is defined
pointwise in Clean and independently proved equivalent to
`U.carrier ∪ V.carrier = Set.univ` in Lean. Empty subsets and empty spaces are
permitted, as in the usual definition of an open cover; no nonemptiness is implied.

The [statements](OpenCovers.clean) assert the stored openness, the carrier of the
intersection, and coverage of every point. [verify_open_covers.py](verify_open_covers.py)
generates [OpenCovers.lean](OpenCovers.lean) and
[OpenCoversVerified.lean](OpenCoversVerified.lean). Its eight independently authored
canonical targets check two constructors, the coverage condition, the intersection
proof adapter, the Clean intersection definition, and the three result statements.
The proofs establish those three results and the union characterization. Constructor
comparisons use the generated record identities with independently written fields;
they do not claim a separate Mathlib `Opens` type has the same canonical identity.

Run from the repository root:

```sh
LAKE=/home/claude/.elan/bin/lake python3 studies/topology/verify_open_covers.py
```

The [proposed theorem](Targets.clean.proposed) now takes `C: OpenCover(X)` and
explicit coefficients and uses the existing terminal exactness condition. Its
geometric `mayer vietoris sequence` definition is still missing. Constructing the
chain-level cover sequence, excision, the connecting map identification, and degree
zero/augmentation remain separate obligations. The open-cover checks do not prove
Mayer–Vietoris or the interlevel well-group formulas.
:::


:::llm gpt-6 2026-11-11 role=assisted

Validation: the native driver passes all eight canonical comparisons and four
proofs. A fresh legacy/joint comparison of the three statements generates identical
Lean with matching unchanged source fingerprints (recorded under `open_cover_module`
in [the compatibility report](../parameterized-literals/compatibility.json)). The
existing 92 corpus proofs also pass after regeneration. Reference HTML IDs/local
paths and provenance checks pass. No parser or elaborator implementation changed.
:::
