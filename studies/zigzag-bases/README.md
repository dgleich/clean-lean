:::llm gpt-6 2026-11-06 role=assisted

# Zigzags with actual interval-basis data

This study builds prerequisites for the pyramid basis-extension theorem in
[Homology and Robustness of Level and Interlevel Sets](https://mrzv.org/publications/robustness-interlevelsets/manuscript/).
Section 2.2 supplies the mathematical motivation. Theorem 1 is **not proved here**.

A zigzag has `n` edges and `n+1` vertices. A Boolean selects each edge's orientation.
A module diagram stores its module at every vertex and a linear map along every
edge. An interval label has ordered lower and upper endpoints. An interval basis
contains actual Mathlib bases at vertices, indexed by the active labels, together
with vectors for all labels, zero outside their intervals, and edge-compatibility
evidence. Label types need not be finite. These records assert no general existence
or finite-dimensionality theorem.

Compatibility is required for labels active at the source. Such vectors map to
the same labelled target vector, which is zero when the label has ended. A label
born at the target imposes no impossible requirement that zero map to a nonzero
basis vector. Endpoint membership determines support, including both endpoints.

[Statements.clean](Statements.clean) states six results: the two edge orientations,
the constant diagram's arrow, exact vector support, the edge action, and existence
of an interval basis on a constant zigzag given a basis of its module. The last
construction works for arbitrary edge directions and for zero edges. It assigns
every label the whole vertex interval and reindexes the supplied basis at each
vertex. This is a constructed example, not an assumed certificate.

[Generated.lean](Generated.lean) contains generated statements.
[Verified.lean](Verified.lean) additionally contains independent native target
oracles and proofs. Regenerate and kernel-check with:

```sh
LAKE=lake python3 studies/zigzag-bases/verify.py
```

The verifier checks 46 canonical elaborated targets: four structures, their
constructors and fields, twenty constructions/wrappers and six propositions.
Only generated-name linkage and binder metadata are normalized for comparison.
Native oracle bodies are separately authored. No theorem is discharged by an axiom
or placeholder proof.

Definitions of the pyramid, its diamonds, restrictions and compatible extensions
remain future work. Connecting maps, exactness and the geometric hypotheses also
remain necessary before a proof of the paper's basis-extension theorem.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Reading the Clean definitions

The core diagram interface stores the dependency explicitly:

```clean
Structure ModuleDiagram(K: Type,field: FieldStructure(K),V: Type,E: Type,Q: DiagramShape(V,E)):
  Universe: 1
  Let object: Function(V,CoefficientModule(K,field))
  Let arrow: Function(e: E,ModuleMap(K,field,(object(Q.source(e))),(object(Q.target(e)))))
  Constructor: module diagram
```

For an edge `e`, its map's domain and codomain come from the modules at that
edge's endpoints. They are not separate arguments for the author to keep aligned.
The full module includes display metadata and imports. Its constant construction
uses existing lambda syntax:

```clean
Equals: module diagram(K,field,V,E,Q,
  function(v: V,M),function(e: E,module identity(field,M)))
```

The interval-basis record similarly makes its vertex bases depend on the active
label set. This is why dependent functions are needed here. The support and
compatibility declarations are named `Condition`s; evidence fields assert those
conditions for this particular record.

The [typeset specimen](Statements.pdf) uses landscape pages because the current
renderer does not automatically wrap long nested quantified displays. It uses
English quantifiers and conjunctions. Automatic mathematical line breaking is a
remaining presentation improvement, not a change to the theorem statements.
:::
