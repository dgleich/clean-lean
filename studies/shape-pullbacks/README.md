:::llm gpt-6 2026-11-06 role=assisted

# Changing diagram shapes

A shape map sends vertices and edges to vertices and edges, and supplies proofs
that both endpoints are preserved. Pulling a module diagram back along that map
places the old module at each selected vertex and the old map along each selected
edge. Here “pullback” means reindexing a diagram, not constructing a categorical
pullback limit.

```clean
Let f: DiagramShapeMap(V,E,W,F,Q,R)
Let M: ModuleDiagram(K,field,W,F,R)
Let N = pull back diagram(field,Q,R,f,M)
```

N is a diagram on Q. Its module at v is `M.object(f.vertices(v))`. Its edge map
first transports to the selected source module, applies `M.arrow(f.edges(e))`,
and then transports back from the selected target module. This is necessary when
endpoint preservation is proved rather than true by definitional equality.

The declarations use existing syntax:

```clean
Let vertices: Function(V,W)
Let edges: Function(E,F)
Let sources: Function(e: E,Evidence((vertices(Q.source(e)) = R.source(edges(e)))))
Let targets: Function(e: E,Evidence((vertices(Q.target(e)) = R.target(edges(e)))))
```

Identity and composition of shape maps are authored in Clean, including their
endpoint proofs. The pullback's objects and arrows are also authored in Clean.
The new foundational adapters are `Eq.symm`, `Eq.trans`, and Mathlib's `eqToHom`
applied to the equality of modules induced by an equality of vertex indices.
The module-category instance, scalar field and universe levels are explicit.
No diagram-specific or paper-specific construction is hidden in a native body.

The modules are [equality chains](../../library/logic/equality_chains.clean),
[module transport](../../library/algebra/module_transport.clean),
[shape maps](../../library/diagrams/shape_maps.clean), and
[pullbacks](../../library/diagrams/pullbacks.clean).

[Statements.clean](Statements.clean) contains nine results. The verifier checks
24 independently authored native targets: six record/constructor/projection
targets, nine definitions/adapters, and nine propositions. It proves every statement,
including the full diagram equations for identity pullback and composite pullback.
The composite law uses equality-transport composition, not just pointwise object
agreement. No new parser, inference, conversion or emission rule was required.

```sh
LAKE=lake python3 studies/shape-pullbacks/verify.py
```

[Generated.lean](Generated.lean) contains generated definitions and statements.
[Verified.lean](Verified.lean) adds the independent exact-target oracles and proofs.
[Statements.pdf](Statements.pdf) presents the statements with mathematical names.
Negative tests reject missing endpoint evidence, a wrong target shape and transport
with its equality evidence reversed. Types retain all explicit shape and field indices.

## Short forms and comparison boundary

`shape identity(Q)`, `compose shapes(Q,R,S,f,g)` and
`pull back diagram(field,Q,R,f,M)` infer their Type parameters using the existing
call rules. Shapes and the scalar field stay explicit. The fully explicit
implementations remain available as `identity shape map`, `composite shape map`
and `diagram pullback`.

These short forms have checked native targets. The later
[inferred-argument conversion rule](../../docs/inferred-argument-conversion.md)
allows their named Type parameters to participate in authored expansion. A projected
module from the short pullback now compares equally to the explicit implementation
and its selected underlying object. The later explicit type-expression rule
also allows compound types to enter authored expansion. The separate
[inferred-conversion study](../inferred-conversion/README.md) checks the new rule.

## What remains for interval-basis restriction

A general shape map need not preserve interval support. For example, a three-vertex
path can map to a single edge with vertex images 0, 1, 0; orient its two edges
0→1 and 2→1. The preimage of the singleton interval at vertex 0 is {0,2}, which is
not an interval in the original path. Thus this generic pullback does not by itself
restrict an interval basis with the same interval labels.

An actual subpath restriction needs its inclusion, the clipped label intervals,
removal of empty intervals, and explicit basis reindexing. The pyramid, its chosen
subdiagrams and the extension theorem remain separate constructions and proofs.
No change-of-shape operation is being used to assert those missing facts.
:::

:::llm gpt-6 2026-11-06 role=assisted

Validation: 24 exact native targets and nine proofs pass for this study. The
zigzag-basis and diagram-map studies also pass after the shared display metadata
update (another 61 exact targets and twelve proofs). All 60 focused Python tests,
92 corpus proof fixtures and the strict generated-parser check pass. The three
updated specimens compile twice without overflow or unresolved references and
were visually checked. The full Python suite passes: 551 tests in 1335.236 seconds.
The refreshed review snapshot contains 105 files with zero translation errors;
source hashes, inventory, search/navigation, notes export/reload, responsive layout
and no-JavaScript behavior were checked.
:::
