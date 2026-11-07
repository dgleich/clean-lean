:::llm gpt-6 2026-11-07 role=assisted

# Topology checks after binding integration

The working compiler now passes the following migrated native checks. These run
directly against the repository compiler, without applying historical patches.

| Verifier | Exact targets | Proofs |
|---|---:|---:|
| `studies/topology/verify.py` | 17 | 7 |
| `studies/topology/verify_bundles.py` | 43 | 10 |
| `studies/topology/verify_indices.py` | 9 | 4 |
| `studies/topology/verify_spaces.py` | 26 | 5 |
| `studies/topology/verify_subspaces.py` | 22 | 4 |
| `studies/topology/verify_homology.py` | 38 | 5 |
| `studies/topology/verify_compact_image.py` | 2 | 2 |
| `studies/topology/verify_paths.py` | 14 | 4 |
| `studies/topology/verify_evidence.py` | 42 | 4 |
| `studies/topology/verify_local_names.py` | 4 | 2 |
| `studies/topology/verify_pair_composition.py` | 20 | 6 |
| `studies/topology/verify_relative.py` | 24 | 4 |
| `studies/topology/verify_relative_maps.py` | 8 | 3 |
| `studies/topology/verify_chain_squares.py` | 17 | 2 |
| `studies/topology/verify_interlevel.py` | 66 | 12 |
| `studies/topology/verify_well_groups.py` | 24 | 5 |
| `studies/topology/verify_shifted_perturbations.py` | 11 | 6 |
| `studies/topology/verify_extreme_images.py` | 18 | 4 |
| Total | 405 | 89 |

Run each with the repository Python environment and `LAKE` set to the pinned Lake
executable. Each verifier generates its artifacts and invokes Lean. The foundation
proof count includes four foundation results and three Mathlib agreement proofs.

The expectations now refer explicitly to declaration-scoped native type bindings.
Their bodies are checked independently against handwritten Lean adapters. Bundle
oracles retain their explicit declaration-name mapping and canonical structure
comparison. The comparison does not unfold arbitrary definitions or accept merely
definitional equality. Mathematical definitions remain authored in Clean.

The shared `tools/check_basic_targets.py` also passes four normalized statement
trees, four exact identity targets and one independent Real adapter target. It
checks that the four source variants emit identical module declarations, emits
those declarations once at the root, and compares each namespaced statement
against the same explicit wrapper-based target. A merely definitionally equal
alias still fails the comparator as required.

The indexed-type tests now distinguish local carrier identities from module type
identities. The universe test checks that a carrier field is accepted at Universe 1
and rejected at Universe 0. All 23 tests in `test_value_indices` and
`test_universes` pass. These repair nine stale fixtures already imported by the
ongoing 739-test discovery run; that running process cannot validate their edits.
No completed full-suite pass is claimed.

Generated Lean files have been refreshed. The three associated TeX sources are
unchanged after provenance restoration, so their existing PDFs were not rebuilt.
The space study additionally rejects two incorrect universe targets in Lean. Its
expected declarations now explicitly name the Type, topology, space, point and
continuous-map adapters. The subspace study explicitly checks Type, condition and
set adapters alongside field, additive-group, module and subspace adapters.
Independent wrappers use `abbrev` where Lean instance search must unfold them;
the canonical body comparison is unchanged. No mathematical body moved out of
Clean. Seventeen tests in `test_universes` and `test_linear_spaces` pass.

The subspace context's generated identifier changed with the retained binding
identities. Its expanded PDF was rebuilt twice and visually inspected. A separate
referenced-context build was compiled twice and inspected: all four references
resolve to Context (1), with no undefined references or overflow warnings. The
package-path warning is unchanged. The space TeX is unchanged after provenance
restoration.

The homology verifier now checks seven additional type adapters, including the
explicit field structure, space, continuous-map and condition wrappers. Its
coefficient module constructor uses the declared Type wrapper for explicit
carrier arguments; inferred and type-declaration carrier parameters retain the
specified raw Type binders. Thirty-eight exact targets and five proofs pass,
along with all six `test_homology` tests.

The compact-image verifier adds independent exact checks for the compactness
adapter and full statement. It retains the separate mathematical equivalence
proof and the `IsCompact.image` proof, and explicitly imports
`Mathlib.Topology.Continuous` for `continuous_def`. Its comparator receives the
resolved declaration name while expected expressions use root-qualified
references. The homology and compact-image TeX outputs are unchanged after
provenance restoration.

The path study adds five independently written native type bodies and retains
its five callable-body and four statement checks. The evidence study checks six
additional type bodies alongside its structures, constructors, projections,
proof fields, maps and statements. Both keep the original canonical comparators
and proofs. Thirty-two focused `test_evidence` and `test_dependent_calls` tests
pass, including wrong endpoint/topology and proof-argument rejection cases.
Their TeX outputs are unchanged after provenance restoration.

The local-name study checks its two statements and independently authored chain
complex/map type bodies. Its statement expectations retain each local `let` and
the original inferred indices of maps and subspaces. The pair-composition study
checks three additional type bodies and the two proof auxiliaries Lean extracts
from the identity statements. Those auxiliaries have explicit declaration-name
mappings and separate exact type/body checks; proof terms are not erased or
accepted by proof irrelevance. Twenty pair-composition targets and six proofs
pass. Twenty-two focused `test_local_conversion` and `test_applied_indices`
tests pass. An initial command used the nonexistent module name
`test_beta_indices`; the corrected command above completed successfully. Both
TeX outputs are unchanged after provenance restoration.

The relative-chain study checks six additional type adapters and two extracted
categorical-instance proof helpers. Lean shares these helpers with the earlier
absolute-homology adapter; explicit name mappings are accompanied by exact
helper type/body checks. The expected chain-map types now use the declared
adapter, while its independently written body still fixes the category and its
instance. The chain module also compiles independently of topology's transitive
imports. The relative-map study checks its five definitions and three statements
against explicit native type references. Twenty-three focused relative-homology
and conversion tests pass. Both TeX outputs are unchanged after provenance
restoration.

The chain-square study now uses explicit field, chain-complex, chain-map, module
map, space, natural-number and condition adapters in its independently authored
expectations. Seventeen exact structure/projection/definition/statement targets
and two proofs pass. Ten `test_chain_squares` cases pass, including incorrect
ambient-pair, commutativity-evidence and homology-degree rejection. Its TeX is
unchanged after provenance restoration. The well-group native migration is now checked; all five focused Python tests now pass.

The interlevel study adds five independent type-body checks for real numbers,
sets, conditions, spaces and points. Its existing Boolean and continuous-real-map
adapters now preserve declared type references, as do interval endpoints,
selections, pair data and problem records. Sixty-six exact targets and twelve
proofs pass. All eleven `test_interlevel` tests pass, including dependent-field
and source-space checks. The rendered TeX is unchanged after provenance
restoration. This establishes the listed interval and inclusion facts, not the
unproved two-image characterization.

The well-group verifier passes 24 exact targets and five study proofs, plus
fifteen reused supporting proofs from the interlevel and relative-map studies.
The table counts those supporting proofs only in their originating studies.
The shared target module, certificate fields, indexed intersection and membership
statement retain their declared type bindings. Its TeX is unchanged after
provenance restoration. The separate `test_well_groups` run completed: all five tests pass in
290.351 seconds. None of this proves the two-image characterization.

The shifted-perturbation study passes eleven exact targets and six study proofs,
rechecking twenty supporting proofs. Extreme images pass eighteen exact targets
and four study proofs, rechecking twenty-six supporting proofs. As above, reused
proofs are counted in their originating rows only. The extreme-image target count
includes the explicitly unproved two-image equality proposition; it is not a
proof count. Shifted maps and both extreme certificates keep the same fixed target
module. Their TeX outputs, including the candidate statement, are unchanged after
provenance restoration. All five shifted-perturbation Python tests pass in 130.655 seconds. The ongoing
full-discovery log also records all four extreme-image tests as passing; this
does not turn that unfinished suite into a passing full run.

All eighteen verifiers in this topology directory have now completed on the
working compiler. This is a collection of individual runs during the migration,
not a new monolithic all-suite run. It does not validate every separate study in
the repository or the isolated declared-operator stack.

The main compiler still uses the existing built-in operators. The separate
[declared-operator experiment](../operator-integration/topology-migration.md)
remains isolated. Other repository studies still need native-verifier migration. These checks establish neither the missing paper proofs nor
general universe polymorphism or the complete language acceptance contract.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Revalidation after declared operators entered the working compiler

The preceding eighteen-verifier totals describe the pre-operator compiler. They
are not current validation of the whole topology portfolio. Operators now resolve
through explicit imports, including `library/topology/basic.clean` importing
`library/operators.clean`.

Two verifiers have been migrated and rerun against this compiler:

| Verifier | Exact targets | Proofs |
| --- | ---: | ---: |
| `verify.py` | 23 | 7 |
| `verify_indices.py` | 10 | 4 |

The first checks the six imported equality, membership, intersection, conjunction,
equivalence and implication adapters independently, then checks Clean-authored
set constructions and statements using their native identities. The second adds
an equality-adapter oracle and retains that identity in indexed reflexivity
statements. Native `Element` type bodies still use native set membership, as
specified by their `Means` payloads. A native adapter body and an authored Clean
expression must not be conflated in the canonical oracle.

The equality adapter's result type is the declared Proposition wrapper; an oracle
using bare Prop is definitionally equivalent but structurally wrong. The strict
comparison rejected it until the independently authored expectation was corrected.
Both verifiers compare complete canonical native type and value structures; no
comparison was weakened to definitional equality. The eleven proofs include
three agreement proofs with Mathlib constructions and eight statement proofs.

The regenerated one-page foundation and indexed-type specimens compiled twice
and were visually inspected. The foundation specimen retains a 0.12149pt
paragraph overfull warning; no clipping was visible. The other sixteen topology
verifiers and the paper theorem proofs remain outside this revalidation claim.
:::

:::llm gpt-6 2026-11-07 role=assisted

Three further working-compiler verifiers now pass with declared operators:

| Verifier | Exact target checks | Proofs |
| --- | ---: | ---: |
| `verify_paths.py` | 16 | 4 |
| `verify_bundles.py` | 47 | 10 |
| `verify_subspaces.py` | 29 | 4 |

These checks retain independently declared equality, membership, arithmetic,
order and logical adapters in authored expressions. Each adapter's native body
is checked independently as well. Statement assumptions remain native universal
proof binders; authored implication expressions retain the declared implication
adapter. The comparison still checks canonical types and values, including
constructor/projection shapes where relevant.

The bundled-path involution proof first exposes native equality with `change`
before eliminating the dependent record. This is a proof-script adaptation to
the equality wrapper, not a change to the theorem or its comparison criterion.
All eighteen proofs in these three rows passed Lean. The three rendered specimens
compiled twice without box or unresolved-reference warnings; all four pages were
visually inspected.

Five of the eighteen topology verifiers are now revalidated after the operator
migration. Their summed per-verifier counts are 125 exact-target checks and 29
proofs; shared foundational adapters are checked in multiple verifiers, so this
is not a count of 125 distinct imported declarations.

### Next observed gap: equality of bundled spaces

`cleanlang check studies/topology/Spaces.clean` currently rejects an undeclared
`=`. A direct probe confirms that `X=Y` for `X,Y: TopologicalSpace` is rejected.
`TopologicalSpace` wraps `TopCat.{0}` and inhabits Lean `Type 1` (Clean's internal
sort level 2). The imported generic equality takes `T: Type`, meaning a Type-0
carrier, and cannot instantiate to this larger type. This is an explicit library
and universe-interface boundary. The parser is unambiguous; accepting it requires
an explicit eligible declaration, not an implicit fallback to Lean equality.
A space-specific adapter is possible with existing syntax; general
universe-polymorphic operator declarations remain a larger outstanding language
requirement. The remaining thirteen verifiers are not yet validated on this
compiler. The five paper theorems remain unproved where previously documented.
:::

:::llm gpt-6 2026-11-07 role=assisted

The bundled-space gap above is now resolved by the explicit `same space`
condition attached to `=` in `library/topology/spaces.clean`. Its adapter accepts
two TopologicalSpace values directly; generic Type-0 equality is unchanged.
`verify_spaces.py` passes 30 canonical target checks and five proofs on the
working compiler, and confirms two intentionally invalid native universe
assignments are rejected. The regenerated one-page specimen compiled twice
without box or reference warnings and was visually inspected.

Six topology verifiers are now revalidated, summing to 155 per-verifier exact
target checks and 34 proofs (with repeated adapter checks counted in each verifier).
The remaining twelve verifiers are pending. General sort/universe-polymorphic
equality is not implemented: proof equality and other larger carriers still need
eligible declarations or new carrier-signature support. See
[the precise scope](../../docs/large-carrier-equality.md).
:::
