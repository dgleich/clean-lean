:::llm gpt-6 2026-11-06 role=assisted

# Goal: usable Clean mathematics backed by Mathlib

The user requested a new implementation goal on 2026-11-06. The immediate scope
is the syntax and explicit Mathlib interfaces required by the topology study,
including the proposed readable interlevel-problem interface. This is not a claim
that all of Mathlib will be wrapped or that the five research targets are proved.

## Work sequence and completion evidence

1. **Dependent callable signatures.** Import and author functions and conditions
   with named values in their argument/result types. Check subtype projections,
   constant/reversed/composed paths, wrong ambient indices, binder hygiene, and
   independently elaborated wrapper and statement targets.
2. **Authored structures.** Specify and implement finite nonrecursive structures,
   ordered dependent fields, constructors and accessors. State universe and proof
   field policies explicitly. Include readable source, negative cases, independent
   target comparisons and a real mathematical bundle. Recursive inductives are a
   distinct extension and cannot be silently implied by this milestone.
3. **Foundational Mathlib modules.** Explicit wrappers for bundled spaces/maps,
   field/module data, subspaces, and the available homology objects/maps. Select
   precise pinned upstream definitions, record implicit structures and universe
   requirements, and avoid paper-specific Lean adapter implementations.
4. **Readable authored definitions.** Define intervals with endpoint choices,
   interlevel problem data, shifted images and well-group constructions in Clean
   when their prerequisites exist. The two-image characterization must remain a
   theorem, never the definition of the well group.
5. **Study integration.** Replace proposed interfaces with actual typed sources
   where mathematically justified. Update the Clean-to-Lean reference, GitHub
   comparison, editor/review tooling for new lexical forms, and generated artifacts.
   Record remaining mathematical proof obligations separately and accurately.

Every language slice must meet the syntax/target acceptance contract, and any
remaining general compiler conformance gaps must stay visible. An unavailable
upstream construction requires an explicit implementation or a recorded blocker;
an opaque name or an axiom is not completion. The record/constructor spelling is
an implementation decision still to be specified; the recent conversational
`interlevel problem(...)` example does not establish a constructor grammar.

No dependency version changes are part of this goal. Preserve linear intermediate
commits and the established publication provenance. The first concrete work item
is dependent callable substitution, followed by records rather than inventing
special syntax for each topology definition.
:::

:::llm gpt-6 2026-11-06 role=assisted

## First implemented slice

Named-index dependent calls are implemented in the bounded profile described in
[dependent-calls.md](dependent-calls.md). The explicit paths module supplies subtype
projection, constant paths, reversal, composition, and Clean-authored reversal twice.
Validation: 252 Python tests; five independent canonical wrapper targets and four
statement targets; four path proofs; old quantifier/function/index checks; compact
image proof; 92 corpus proofs; generated-parser checks; LaTeX compilation and browser
checks. General expression indices and dependent function-valued results remain
open. The next work item is authored structures with constructor/accessor semantics.
The overall goal remains active; this is not completion of the topology port.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Second implemented slice

The [structure contract](structures.md) now has an implementation: fixed-carrier
nonrecursive records, ordered dependent fields, named constructors, scoped projections,
function-field calls, and projected value/dimension indices. Endpoint shifting and
bundled path reversal are authored in Clean. The six-result bundle study passes
31 canonical record/constructor/projection/definition/statement comparisons and
six Lean proofs. All 283 Python tests and the 92-proof corpus pass, as do the
existing path/index/quantifier/function oracles, VS Code/TextMate, Vim and browser
checks. The LaTeX specimen compiles and was inspected. Emacs remains unavailable;
its grammar and regression test were updated but not executed.

The next concrete work is proof-bearing bundles and explicit foundational algebra
and topology interfaces. Records containing their own carrier types need a precise
universe/type-projection extension. Proof fields need explicit assumption binding
and constructor evidence, not automatic proof search. Expected-type numeral elaboration in the new structural call path remains open. General
expression indices and alias transport remain open. Homology constructions and
research theorem proofs remain separately tracked in the topology requirements.
The overall goal remains active.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Third implemented slice

[Explicit algebra foundations](../studies/topology/mathlib-foundations.md) now
provide Mathlib field/additive/module structures, a Clean-authored linear-space
bundle, and Submodule interfaces preserving the scalar and ambient structure.
Membership, inclusion and intersections over admissible index sets are authored
in Clean. Four results have proofs, supported by 19 independent canonical target
checks. All 293 Python tests, the 92-proof corpus, reference/browser checks and
LaTeX validation pass. The typeset specimen has been inspected.

A direct check of the pinned Mathlib confirms the next universe requirement:
`TopCat.{0}` and `ModuleCat.{0,0} K` live in Type 1. Their existing compiled caches
were fetched without changing dependency revisions. The next language slice must
support explicit universe levels for imported bundled types and then expose actual
continuous-map and homology objects/maps. Linear-map ranges, relative homology,
proof-bearing authored structures, and the paper-specific constructions remain
open. This algebra milestone supplies ingredients for well groups, not their
characterization theorem. The overall goal remains active.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Fourth implemented slice

[Fixed universes](fixed-universes.md) let imported Type declarations and authored
Structure declarations specify `Universe: n`. This exposes actual Mathlib TopCat
spaces and bundled continuous maps through
[`spaces.clean`](../library/topology/spaces.clean). A Clean-authored diagram stores
its spaces and a dependent continuous-map field. Five statement proofs and 24
independently authored canonical target checks cover wrappers, constructors,
fields, theorem statements, and levels zero through two. Two incorrectly lowered
sorts are rejected by Lean. All 300 Python tests and the 92-proof corpus pass.
TextMate, Vim, browser/reference search and mobile layout checks pass; the PDF
compiles without overflow and was inspected. Emacs runtime remains unavailable.

The next work remains actual homology objects/maps, linear-map ranges and the
paper-specific constructions. Proof-bearing authored records and carrier-type
fields still need separate semantics. Calling bundled maps as `f(x)` or inferring
space indices is also a readability gap: the present explicit interfaces repeat
spaces in calls. Fixed levels do not implement universe polymorphism. The overall
goal remains active, and none of the research theorem proofs is claimed complete.
:::
