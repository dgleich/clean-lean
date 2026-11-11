:::llm gpt-6 2026-11-11 role=assisted

# Literal, classifier and dependent-carrier integration

The working compiler now includes the previously isolated literal, assumption-block,
classifier, type-value, storage and dependent-carrier implementations. This is an
integration milestone, not a claim that the complete language acceptance contract
or the topology research theorems are finished. Selected native checks pass; full regression remains in progress.

## Installed behavior

- Explicit exact literals retain their declared constructor, arguments, spelling,
  checked annotation and binding identity. Named multiline Assume blocks use the
  existing one-expression rule, without inserting an implicit conjunction.
- Closed classifier declarations support explicit `type(T : C)` and unique
  unannotated `type(T)` selection. Inferred carriers use their formal classifier.
- Dependent functions may bind types. Higher computed/projected carriers preserve
  their level and classifier through substitution and dependent record fields.
- Version-3 index payloads preserve checked annotations and carrier metadata.
  Stored payloads are authoritative over cached trees, and replay re-elaborates
  them. Old payload versions reject; this remains an experimental internal format.
- Traversal-local lazy name reservation and stable checked arguments preserve
  collision checking while avoiding repeated work inside a single comparison.

The detailed constructive rules remain in the specification and the linked study
reports. Their older “isolated” status paragraphs describe historical checkpoints;
this report supersedes that deployment status for the installed features.

## Combination repairs

The literal and classifier changes both extended grammar metadata and expression
consumers. Integration retains both Literal and Classifies fields, including the
whole-document field lexer; retains both BoundLiteral and BoundTypeValue handling
in substitution, numeral-hole scanning and expression elaboration; and keeps the
classifier-based structural signature rule alongside literal declaration checks.
The parser was regenerated with strict conflict checks, then reproduced exactly.

A new interaction test demonstrated a semantic failure: with two visible Type-0
classifiers, a literal constructor parameter explicitly declared as Type was
reified using a fresh visibility search. A declared literal such as `(0: List(Real))`
therefore failed despite its fixed constructor signature. Constructor argument
recovery, retained argument creation and replay now all reify under each formal
parameter's declared classifier. This is the same fixed-environment rule already
used for inferred carriers in authored bodies and result indices. It does not
allow expected types to choose the meaning of fresh `type(T)` syntax.

The second interaction test stores and replays an exact literal nested inside a
lambda that binds a higher-level carrier. Both tests are in
[tests/test_classifier_literal_interactions.py](../tests/test_classifier_literal_interactions.py).

## Validation and provenance

A fresh combined checkout based on aaf9443 passed strict parser generation and
reproduction, then 431 selected tests in 77.590 seconds. Those include the migrated
study tests, dependent structures/functions, type expressions, index storage,
contextual comparisons, topology statements, assumption blocks and editor scopes.
The source changes and migrated tests were installed in the working compiler.
Historical study drivers and their isolated fixtures remain historical inputs;
they are not silently relabelled as production validation.

The full discovery run uses the same isolated combined checkout, which is now
kept immutable. Native checks run directly against the working compiler and include
carrier functions/records, payload replay, composed syntax, Mayer–Vietoris maps and
the 92-entry corpus. The native run passed 32 exact targets and 12 supporting proofs; all 92 corpus
proof fixtures compile. One codec invocation initially failed to import its
fixture module; rerunning with the explicit fixture path passed its three targets
and two proofs, included in those totals. Full discovery remains pending. Older full runs predate this
integration and cannot prove its correctness. In particular, the earlier run that
used the working directory is no longer an immutable baseline after these edits;
its eventual result must retain that limitation. It has not been stopped or
restarted merely because it is slow.

New source/test files carry provenance comments and are inventoried in
provenance.json. Generated artifacts are regenerated and checked, not hand-edited.
No paper theorem is promoted from a statement to a proof by this integration.

## Reproduce

Run `LAKE=lake python3 tools/check_language_integration.py` in the pinned parser
and Lean environment. It checks the current compiler directly and applies no
study patches. Add `--full` for complete discovery. The fixture path for the
historical codec oracle is explicit. Generated files may be refreshed by the
native checks; run the repository provenance tool afterward.

## Remaining scope

Full-suite results, complete native-target acceptance beyond the selected cases,
editor/browser regeneration,
complete native dependency freshness and resource accounting remain obligations.
General higher record/type-constructor parameter handling, unannotated joint
operator/literal inference and other explicitly rejected forms retain their own
gaps. Existing topology wrappers and proved supporting laws remain separate from
the missing homology/excision/well-group research constructions; LAProof's IEEE
and C verification obligations are also unchanged.
:::
