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

The applied-component comparison gap is now resolved by
[hygienic producer conversion](../../docs/hygienic-producer-conversion.md).
[graded_homology_maps.clean](../../library/topology/graded_homology_maps.clean)
authors the induced graded map in Clean. [HomologyMaps.clean](HomologyMaps.clean)
states its component formula and identity/composition laws;
[HomologyMapsVerified.lean](HomologyMapsVerified.lean) checks four exact native targets
and proves all three statements. Run
`LAKE=lake python3 studies/dependent-functions/verify_homology_maps.py`.
Unapplied binder-bearing families, inferred body parameters and broader higher-order
conversion remain outside this bounded extension.

The native probe exposed a practical adapter requirement: composition and its laws
need the module category supplied explicitly, because Lean cannot always recover
it from the bundled Hom values alone. The Clean wrappers retain
that category, its named Mathlib instance and coefficient choice explicitly.
## Proof families

[ProofFamilies.clean](ProofFamilies.clean) exercises proof codomains, proof domains,
empty/singleton finite domains and a family over the Type 1 module category.
[ProofFamiliesVerified.lean](ProofFamiliesVerified.lean) checks ten exact targets,
five inferred declaration sorts and five theorem proofs. Run
`LAKE=lake python3 studies/dependent-functions/verify_proof_families.py`.
The [sort contract](../../docs/proof-valued-functions.md) explains why a function
returning proofs is rejected by an ordinary Type parameter, while a function taking
a proof and returning a natural number is allowed. No new author-facing keyword is
needed. General universe inference and Type-valued dependent binders remain open.

## Closed universes

[ClosedUniverses.clean](ClosedUniverses.clean) demonstrates a Type 1 module holder,
a Type 0 holder of a proof over modules, and authored operations on higher-universe
values and functions. [ClosedUniversesVerified.lean](ClosedUniversesVerified.lean)
checks fourteen exact targets, four native sorts and three theorem proofs. Run
`LAKE=lake python3 studies/dependent-functions/verify_closed_universes.py`.
The [closed-level contract](../../docs/closed-universe-checking.md) now rejects the
previously accepted Type 1-to-Type 0 carrier mismatch in Clean. General universe
parameters and Type-valued dependent binders remain open.

## Initial dependent-arrow validation checkpoint

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
local links and mobile width checks pass. The rebuilt review browser contains 85
files with zero translation errors; navigation, search, notes/export, responsive
layout and no-JavaScript fallback checks pass. Broader dependent-family acceptance work
remains listed in the contract, separately from this regression evidence.
## Applied producer validation checkpoint

The full regression run for the producer-conversion implementation passed all 484
tests in 904 seconds. The subsequent cache adjustment passed the 69 focused
conversion/dependent-function tests; its four induced-map canonical targets and
three proofs, plus two local-name targets and two proofs, were checked again.
The full suite was not repeated after that cache-only follow-up.

The 92-proof corpus, strict generated grammar, eleven graded-map targets/three
proofs, eight relative-map targets/three proofs and fifteen pair-composition
targets/six proofs pass. The new PDF compiles twice without overfull boxes; the
reference-page search, links and mobile layout pass. Native composition initially
exhausted the default heartbeat budget; the documented finite larger budget then
completed successfully. No proof placeholder was introduced. The refreshed review
browser contains 87 files with zero translation errors; search, target navigation,
imports, notes/export, responsive layout and no-JavaScript fallback checks pass.
## Proof-family validation checkpoint

The full regression run passed all 492 tests in 913 seconds. The later proof-family
prose adjustment passed 55 focused tests; the completed alias/sort cases passed
nine focused tests. The native verifier was rerun after the prose change and passed
ten exact targets, five declaration-sort checks and five theorem proofs. The unused
proof binder in the proof-to-natural definition produces an expected Lean warning.
The full suite was not repeated after those rendering/test-only follow-ups.

The 92-proof corpus, existing induced-homology targets and strict generated parser
check pass. The PDF compiles twice and has been visually checked. The reference
page passes search, links and mobile-width checks. The rebuilt review browser has
88 files and zero translation errors; its UI and no-JavaScript checks pass.

The separate [closed-universe negative probe](../../docs/proof-valued-functions.md#confirmed-remaining-universe-boundary)
was accepted by Clean and rejected by Lean at this earlier checkpoint. The
closed-universe implementation above now rejects it in Clean before emission.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Closed-universe validation checkpoint

The full regression run completed 503 tests in 915 seconds with one error: an
older computed-index test declared a record containing a topological space at the
default Type 0. The corresponding native study already uses Universe 1. Correcting
that test fixture to declare Universe 1 passed 77 focused tests; no implementation
change was needed. The full suite was not repeated after this fixture-only fix.
The final closed-universe, proof-family, structure and module checks separately
passed 100 focused tests, including one added after the full run started.

The new study passes fourteen exact targets, four native sort assertions and three
proofs. The 92-proof corpus, ten proof-family targets/five sorts/five proofs, four
induced-homology targets/three proofs, and 31 homology targets/five proofs pass.
Strict parser generation also passes. The new PDF compiled twice and was visually
checked; reference-page search, local links and mobile width checks pass.
The refreshed review browser contains 89 files and zero translation errors; search,
declarations, target navigation, imports, notes/export, reload, responsive layout
and no-JavaScript fallback checks pass.
:::
