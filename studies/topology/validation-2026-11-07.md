:::llm gpt-6 2026-11-07 role=assisted

# Selected-field compiler: native validation checkpoint

All 34 native study verifiers in the frozen selected-field snapshot completed
successfully. This is the compiler implementation committed in `3946c7a`; its
19 Python source files are byte-identical to current main at `c499ec9`. The
snapshot predates the clipping study and later prose metadata correction.

The current clipping study separately passed eight exact targets and three proofs;
its five Python checks passed. After the IntervalLabels prose correction, the
zigzag study was rerun on main: 46 exact targets and six proofs passed. The
92-proof corpus was also checked after the compiler change. The four identity
acceptance variants and the isolated operator prototype have separate checks;
the latter is not integrated main-language syntax.

The full Python run for the selected-field snapshot and the current browser
inventory/UI validation remain pending. The selected-field Python process returned
exit status 143 without a terminal unittest summary; its log ends during
`test_import_navigation_and_fresh_targets`. The termination cause has not been
established, and this is not a passing full-suite result. This report does not claim complete
language conformance or proofs of the research-paper targets.

## Native verifier results

Each command was run with the pinned Lean/Mathlib dependencies. The table records
successful process completion, not merely a log substring. The orchestrator
returned exit status zero and an empty failure list.

| Verifier | Result | Seconds |
|---|---|---:|
| `studies/callable-evidence/verify.py` | PASS | 10.35 |
| `studies/dependent-functions/verify.py` | PASS | 12.51 |
| `studies/dependent-functions/verify_closed_universes.py` | PASS | 12.51 |
| `studies/dependent-functions/verify_homology_maps.py` | PASS | 27.42 |
| `studies/dependent-functions/verify_maps.py` | PASS | 12.52 |
| `studies/dependent-functions/verify_proof_families.py` | PASS | 12.02 |
| `studies/dependent-functions/verify_relative_graded.py` | PASS | 17.88 |
| `studies/dependent-functions/verify_scoped_families.py` | PASS | 21.58 |
| `studies/diagram-maps/verify.py` | PASS | 13.32 |
| `studies/dimensions/verify.py` | PASS | 11.05 |
| `studies/inferred-conversion/verify.py` | PASS | 11.49 |
| `studies/magnetic/verify.py` | PASS | 0.18 |
| `studies/shape-pullbacks/verify.py` | PASS | 12.21 |
| `studies/subpath-restrictions/verify.py` | PASS | 27.98 |
| `studies/topology/verify.py` | PASS | 0.11 |
| `studies/topology/verify_bundles.py` | PASS | 11.04 |
| `studies/topology/verify_chain_squares.py` | PASS | 15.03 |
| `studies/topology/verify_compact_image.py` | PASS | 10.25 |
| `studies/topology/verify_evidence.py` | PASS | 11.63 |
| `studies/topology/verify_extreme_images.py` | PASS | 618.34 |
| `studies/topology/verify_homology.py` | PASS | 8.57 |
| `studies/topology/verify_indices.py` | PASS | 6.95 |
| `studies/topology/verify_interlevel.py` | PASS | 8.61 |
| `studies/topology/verify_local_names.py` | PASS | 15.5 |
| `studies/topology/verify_pair_composition.py` | PASS | 8.11 |
| `studies/topology/verify_paths.py` | PASS | 7.69 |
| `studies/topology/verify_relative.py` | PASS | 17.13 |
| `studies/topology/verify_relative_maps.py` | PASS | 13.4 |
| `studies/topology/verify_shifted_perturbations.py` | PASS | 493.62 |
| `studies/topology/verify_spaces.py` | PASS | 13.22 |
| `studies/topology/verify_subspaces.py` | PASS | 5.77 |
| `studies/topology/verify_well_groups.py` | PASS | 450.5 |
| `studies/type-expressions/verify.py` | PASS | 8.01 |
| `studies/zigzag-bases/verify.py` | PASS | 8.88 |

## Artifact and source reconciliation

All 72 shared `.lean` artifacts under studies agree with the current worktree,
ignoring only provenance comment lines. No generated Lean artifacts needed to be
copied back. This byte comparison is not itself a proof: proof and target-check
coverage is determined by each verifier above. The current TeX metadata intentionally
differs where the interval-label description was corrected.

Compiler source SHA-256 values checked against the frozen snapshot:

| File | SHA-256 |
|---|---|
| `cleanlang/__init__.py` | `d30af58de1f667b7c1d6e0ef8d702ae4be70ac524950b8e701074295000be6f7` |
| `cleanlang/__main__.py` | `8c43271aae25ad6314aa135a7bd4f8335506987dceac129dc0a5a470ba57f719` |
| `cleanlang/attribution.py` | `6bbb9007c80a1957dd5b5753a610a0625c4deeaf2cf02c36e2d94fe415584361` |
| `cleanlang/beta_indices.py` | `75d4ea7b791ec43bd63df441310a77271bf7ed8fa0db720b93a41d07e4bb01c9` |
| `cleanlang/binder_keys.py` | `787d6e1db910294575d07a3a014b8f9a862386b59472f77dd613a9754b157519` |
| `cleanlang/conditions.py` | `509fd03421324b40f52294640947e04cb56f8771c35a4295b2c36fa6f32127da` |
| `cleanlang/conversion.py` | `6c70fb6850bb69b734efaadc8214fab6e05ca617c2f088a1611ed9384811150e` |
| `cleanlang/core.py` | `338505201ad43bed62be246b835e87d2537192fda5c49d63d874e4f0139eb883` |
| `cleanlang/dependent_functions.py` | `5c0c6aa65e4c79b70c7d97369512580aca3fd5dea7214cca25d6a2019ac31681` |
| `cleanlang/generated_parser.py` | `72a21ae43303081e9c0ebe50a862fb802205289aa90b00f505a675385b125fb4` |
| `cleanlang/hygiene.py` | `f2bde923cd480a161eaaab7e6bb1fd2466b5bab8f452e7e83965e6fde4bb72b7` |
| `cleanlang/indices.py` | `b72d93b100641606fa9a369bc992750eef0339f922fbf341705f3a0b8f9e59a5` |
| `cleanlang/inferred_conversion.py` | `d1f233c63326cd05a8dc23c008668737bae0f6418503b131c214fa66b4fd9449` |
| `cleanlang/literate.py` | `a04ffc59ad77f63a669a71ac9ece66023a97557c119c691f2fd967dff658b242` |
| `cleanlang/modules.py` | `154890e9e9add926362568a66410b7fe9dda504ce684e9de52c9f29506b00e37` |
| `cleanlang/proof_types.py` | `d20b0788b3d9728ec37d1452418b8cb30d009f984e097f0056438b645e285651` |
| `cleanlang/structures.py` | `bc76dbc0f5bb1a07a43e39218065cba7390d0aa6a812fc9ad1456c9155dcf3c5` |
| `cleanlang/syntax.py` | `cfc959d1a3a9aac0ab3d3932baf6ac1a26419e7c5016e913a1edd5104db1ca06` |
| `cleanlang/type_values.py` | `cfe09a7895d1a652c07c20b573001cb3c101290a4017fe438195b8ad401b4c7f` |

## Superseded failing snapshot

The older callable-evidence snapshot finished 32 of 33 native studies successfully;
diagram maps failed during unnecessary callable-view serialization. Its full Python
run recorded the corresponding setup error. That Python run was stopped after the
new compiler passed all 34 native studies and while the replacement full Python
run remained active. The stopped run is not a passing full-suite result. It was
superseded because its diagnosed failure was fixed, not because an observation
window expired.
:::
