:::llm gpt-6 2026-11-07 role=assisted

# Topology implementation and acceptance audit

This is an audit checkpoint, not a completion claim. The maintained specification
and executable fixtures are authoritative; historical milestone paragraphs and
catalog entries must not be read as a current all-green report.

## Implemented language and module interfaces

| Requirement | Concrete implementation and acceptance evidence | Remaining boundary |
|---|---|---|
| Named fields and constructors | `library/algebra/module_diagrams.clean`, `library/diagrams/interval_bases.clean`; structure, diagram-map and zigzag studies | Carrier-type fields are integrated with bounded universes; general universe polymorphism remains unsupported |
| Dependent callable signatures and indices | Dependent-function, computed-index and inferred-conversion studies; explicit stored implicit arguments | General higher-order conversion and normalization inside binder bodies are not claimed |
| Named conditions usable as evidence | Callable-evidence study: 21 exact targets and 15 proofs; captured scopes and local/module resolution have negative tests | Opaque native conditions do not acquire callable views; broader validation is pending |
| Definition bodies authored in Clean | Topology images/preimages/continuity, relative quotient constructions, well-group intersections, diagram pullbacks, subpaths and clipping | Imported foundations remain explicit; mathematical constructions listed below are still missing |
| Deterministic parsing | Generated grammar with strict LALR/lexer checks, independent source trees, explicit layout and metadata interpreters | Module-declared arbitrary operator syntax is not implemented; handwritten layout and metadata rules still need their own tests |
| Precise selected Lean targets | Canonical native declaration comparisons retain arguments, universes, instances and proof terms; the new basic-identity checker tests four legal source variants | General operator/literal/native-adapter contract and resource-outcome integration remain open acceptance obligations |
| Readable statements and LaTeX | Local names, explicit contexts, conditions and descriptive type metadata; subpath and clipping PDFs compiled twice and inspected | The offline browser refresh and its inventory/UI checks are pending |

The basic identity checker is `LAKE=lake python3 tools/check_basic_targets.py`.
It verifies the normalized statement tree, including attribution, binding and
conclusion, then compares generated declaration types and bodies with independently
written identity statements over the selected Real wrapper, whose body is separately
checked against `ℝ`. Local renaming, keyword case, prose type spelling,
indentation, continuation, grouping and comments cannot change that target.
A definitionally equal alias is deliberately rejected by the canonical comparator.
This is a concrete acceptance slice, not a proof of general elaboration uniqueness.

The acceptance catalog retains historical pending lists where follow-up cases now
implement part of an older obligation. Follow-up links do not erase the newer
case's own limitations or substitute for its outstanding validation.

## Current validation evidence

The [working-compiler binding migration](binding-migration.md) adds 269 exact
native targets and 60 proofs, including two universe rejection checks. Focused
Python validation is scoped in that report. Broader discovery
is still in progress; the older counts below retain their historical scope.


- The pre-callable compiler passed 584 Python tests. That count does not validate
  later compiler changes.
- The first callable-evidence snapshot finished its 33-study native run with 32
  passes and one failure: `studies/diagram-maps/verify.py`. Unnecessary callable
  classification reached an internal application that lacked a supported source
  spelling. Its full Python run also recorded a diagram-map setup error and is
  now stopped as superseded; it must not be reported as passing.
- The newer selected-field snapshot has passed the diagram-map study's 15 exact
  targets and six proofs. Its complete native portfolio has now passed all 34
  studies; see the [durable validation record](validation-2026-11-07.md). Its full
  Python run terminated with status 143 during review collection, without a final
  unittest summary. It is not a passing result.
- Before the latest codomain fix, main passed the subpath study's 19 exact targets
  and six proofs, and the initial clipping study's eight exact targets and three proofs.
  The corrected label-rendering regeneration passes the zigzag study's 46 exact
  targets and six proofs. The 92-proof corpus was checked after the compiler change.
- The known-codomain substitution fix passes 108 focused regressions. The expanded
  clipping study passes 14 exact native targets, three proofs, and seven Python
  checks, including the authored restricted-label record. A new frozen full-suite
  run is pending. The 92-proof corpus recheck and rebased operator prototype
  (16 targets, two proofs) pass; earlier portfolio results do not validate
  this later compiler change.
- Chained application is now implemented. The isolated implementation passes 227
  focused regressions; main passes eight exact targets, five proofs, nine postfix
  tests, parser reproducibility and the 92-proof corpus recheck. The frozen full suite was superseded by a corrected obsolete syntax assertion
  and the generic subtype refactor; a new complete run is still required. This
  does not validate general native-binding uniqueness.
- The active-label study has authored maps and a support record, but its instrumented
  verifier crashed during translation (status 139). That source was superseded by a generic subtype construction, which passes ten
  exact checks, three proofs and five Python tests. The refactored interval
  translation and earlier verifier remain active; the native-oracle arithmetic support and existence theorem now pass separately.
  Full generated interval-target comparison remains pending.
- The browser build using the pre-postfix compiler was stopped as superseded.
  A new build, source-hash validation and UI checks remain pending.

## Mathematical constructions still missing

| Requested theorem | What is real now | What is still missing |
|---|---|---|
| Big Steps, Theorem 9 | Indexed records and ordinary set/function definitions can express its inputs and support predicates | Filtered complex, lazy reduction, the actual algorithm run and its invariants; the two sides must be computed independently |
| Interlevel, Theorem 1 | Explicit diagrams, interval bases, subpath restrictions, endpoint clipping, surviving-label support and restricted label records, and a checked generic basis-reindexing wrapper | Full generated-target comparison for the native-checked surviving active-label equivalence; basis reindexing and compatibility, pyramid construction, exact-diamond basis flips and extension proof |
| Interlevel, Theorem 3 | Actual singular-homology, submodule, perturbation and shifted-image foundations | Assemble the level-set specialization and prove the two-extreme-perturbation formula with justified cover hypotheses |
| Interlevel, Theorem 4 | A translated two-image candidate over actual relative objects; checked supporting inclusion maps | Reverse inclusion and the cover/excision audit; no proof is claimed by translating the candidate |
| Mayer–Vietoris | Graded objects, maps and ordinary/relative chain foundations | Connecting maps, sequence/exactness interface, excision and the long-exact-sequence construction |

These missing mathematical objects are not supplied by opaque names or assumptions
of the desired conclusion. Conversely, a missing paper proof does not establish a
parser defect. Each new construction should first be attempted with the existing
Clean definitions, conditions, structures and explicit foundation modules; a
failure to express it must be recorded as a language gap with a concrete specimen.
:::
