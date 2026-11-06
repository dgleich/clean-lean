:::llm gpt-6 2026-11-06 role=assisted

# Maps between module diagrams

[The module](../../library/algebra/diagram_maps.clean) defines maps between two
module diagrams on the same directed shape. Each vertex has a linear map, and
every edge has a commuting square. This adds the compatibility data needed when
comparing diagram constructions; it does not define the pyramid or basis restriction.

The core interface uses the existing dependent-function and evidence syntax:

```clean
Structure ModuleDiagramMap(K: Type,field: FieldStructure(K),V: Type,E: Type,Q: DiagramShape(V,E),X: ModuleDiagram(K,field,V,E,Q),Y: ModuleDiagram(K,field,V,E,Q)):
  Let component: Function(v: V,ModuleMap(K,field,(X.object(v)),(Y.object(v))))
  Let commutes: Evidence((diagram maps commute(K,field,V,E,Q,X,Y,component)))
  Constructor: diagram map
```

The condition states, for each edge e, that applying the edge map in X and then
the vertex map at its target equals applying the vertex map at its source and
then the edge map in Y. Composition uses the existing Mathlib module-category
composition wrapper. No new native mathematical body or syntax was added:
the condition, component families and record assembly are all authored in Clean.

The vertex and edge types are arbitrary Type 0 types, not assumed finite.
There are no extra path relations in the directed shape. This is an authored
record interface, not a claim that a Mathlib Functor or Category instance has
been generated automatically.

`diagram identity components` and `diagram composite components` construct the
actual vertex maps. `certified diagram identity` and `certified diagram composition`
assemble the records with explicit commutation evidence. Clean does not synthesize
that evidence. The native study proves the identity and composite conditions
universally and constructs an identity map, so the evidence is not an unproved
extra mathematical assumption.

[Statements.clean](Statements.clean) contains six results. The verifier checks
15 exact native targets (record, constructor, two projections, five definitions
and six propositions) and proves all six statements, including pointwise map
extensionality. Distinct commutation proofs do not create distinct maps with the
same components. The composition proof applies both commuting squares to an
element; it does not assume its conclusion.

```sh
LAKE=lake python3 studies/diagram-maps/verify.py
```

[Generated.lean](Generated.lean) contains generated definitions/statements;
[Verified.lean](Verified.lean) also contains independent native oracles and proofs.
The exact oracle for a component of an explicit certified constructor uses the
component-family application selected by Clean's specified producer-projection
rule. It does not compare merely definitionally equal projections.

The negative tests reject reversed composition, wrong endpoint diagrams, wrong
shape indices and missing evidence. Existing parser, binder scope, universe and
instance rules determine all targets; no display-name dispatch or registry is used.
:::

:::llm gpt-6 2026-11-06 role=assisted

Validation: 15 exact native target comparisons and six Lean proofs pass. A
51-test focused run covers the new module and interacting dependent-function,
constant-arrow and Condition behavior; all seven diagram-map tests pass again
after the display-template correction. The 92 corpus proof fixtures pass. The
PDF compiles twice without overfull boxes and was inspected. The compiler is
unchanged from the preceding 529-test full regression run. The combined review
browser snapshot is being rebuilt; its final freshness check remains pending.
:::
