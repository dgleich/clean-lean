:::llm gpt-6 2026-11-07 role=assisted

# Topology checks after binding integration

The working compiler now passes the following migrated native checks. These run
directly against the repository compiler, without applying historical patches.

| Verifier | Exact targets | Proofs |
|---|---:|---:|
| `studies/topology/verify.py` | 17 | 7 |
| `studies/topology/verify_bundles.py` | 43 | 10 |
| `studies/topology/verify_indices.py` | 9 | 4 |
| Total | 69 | 21 |

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
The main compiler still uses the existing built-in operators. The separate
[declared-operator experiment](../operator-integration/topology-migration.md)
remains isolated. Larger topology, homology and well-group native verifiers still
need migration. These checks establish neither the missing paper proofs nor
general universe polymorphism or the complete language acceptance contract.
:::
