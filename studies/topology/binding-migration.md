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
| Total | 237 | 53 |

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

The main compiler still uses the existing built-in operators. The separate
[declared-operator experiment](../operator-integration/topology-migration.md)
remains isolated. Relative homology and the larger interlevel and well-group native verifiers still
need migration. These checks establish neither the missing paper proofs nor
general universe polymorphism or the complete language acceptance contract.
:::
