:::llm gpt-6 2026-11-06 role=assisted

# Graded objects and dependent function fields

[Available.clean](Available.clean) is working Clean. It uses the authored
[graded-module record](../../library/algebra/graded_modules.clean) and
[graded singular homology](../../library/topology/graded_homology.clean) to package
all natural homology degrees, with the scalar field itself as coefficients.
The component identity is proved. This is a graded family, not a chain complex or
an exact sequence; no differential or connecting map has been invented.

[Verified.lean](Verified.lean) checks seven canonical native targets and one proof.
[Available.lean](Available.lean) is generated statement output;
[Available.pdf](Available.pdf) is its rendered form. Run
`LAKE=lake python3 studies/dependent-functions/verify.py`.

The implemented map interface is a family of maps whose source and target vary with degree:

```clean
Structure GradedMap(K: Type,field: FieldStructure(K),M: GradedModule(K,field),N: GradedModule(K,field)):
  Let component: Function(p: Natural,
    ModuleMap(K,field,(M.component(p)),(N.component(p))))
  Constructor: graded map
```

This declaration now lives in [graded_maps.clean](../../library/algebra/graded_maps.clean).
Identity and composition use authored Clean lambdas; only the underlying module
identity/composition are explicit Mathlib adapters. [Maps.clean](Maps.clean) states
the two identity laws and associativity. [MapsVerified.lean](MapsVerified.lean)
checks eleven exact native targets and proves all three generated statements.
Run `LAKE=lake python3 studies/dependent-functions/verify_maps.py`.
The earlier [proposed source](Proposed.clean.txt) is retained as the design specimen.
See the [implementation contract](../../docs/dependent-function-types.md) for the
remaining acceptance cases; this is an initial implementation, not full coverage.

[Native.lean](Native.lean) is a separate, handwritten Lean design probe. It defines
graded modules and maps and proves the two identity laws and associativity, plus a
small dependent-vector identity. Run `lake env lean studies/dependent-functions/Native.lean`.
Those four proofs validate the intended target mathematics; they are not proofs of
translated Clean statements and do not discharge any of the research-paper targets.

One further boundary is now reproduced by a test: the computed component
`graded singular homology(K,field,X).component(p)` and its native homology expression
have the same declared type and are definitionally equal in Lean (the component
proof checks this), but Clean's comparison keys still differ. The authored producer
contains a lambda and is deliberately opaque under the current conversion rules.
Building induced maps between these particular graded families will also need
capture-free conversion of such producer fields; dependent function syntax alone
will not resolve that mismatch.

The native probe exposed a practical adapter requirement: composition and its laws
need the module category supplied explicitly, because Lean cannot always recover
it from the bundled Hom values alone. The Clean wrappers retain
that category, its named Mathlib instance and coefficient choice explicitly.
## Validation checkpoint

The initial dependent-map implementation checks eleven canonical Lean targets and
three generated theorem proofs; the existing 92-proof corpus and strict generated
parser check also pass. The 471-test regression run completed with three failures,
all caused by the shared application checker changing an expected error message.
The field-specific diagnostic was restored; 86 focused tests, including all three
cases and the dependent-function interactions, then passed. A separate alias-cycle
follow-up passed 81 focused tests. The full suite was not repeated after these small
follow-ups. An earlier attempt terminated with exit 143 during review-data collection
without a test failure; the completed run above was its serial retry.

The rendered map specimen compiles without overfull boxes; reference-page search,
local links and mobile width checks pass. Broader dependent-family acceptance work
remains listed in the contract, separately from this regression evidence.
:::
