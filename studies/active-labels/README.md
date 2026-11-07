:::llm gpt-6 2026-11-07 role=assisted

# Active labels at a restricted vertex

This construction connects clipped interval labels to basis reindexing. The old
index type consists of labels active at the embedded vertex `a+v`. The new index
type consists of surviving labels active at the restricted vertex `v`. The new
index is a nested subtype: a label, evidence of survival, and evidence of activity.

The authored Clean maps preserve the underlying label and construct the required
membership evidence. Their inputs include an `ActiveLabelSupport` record with
three explicit obligations:

- An original active label survives the subpath restriction.
- The resulting surviving label is active at the restricted vertex.
- A restricted active label was active at the original embedded vertex.

The constructor for the equivalence additionally accepts the two inverse proofs.
The intended verifier proves these with subtype extensionality, constructs the
support record from the numerical interval bounds, and proves existence of the
value-preserving equivalence **without assuming a support record or inverse laws**.
Thus those data are explicit definition inputs, not extra hypotheses of the final
existence theorem. No paper-specific mathematical definition is imported from Lean.

`library/logic/elements.clean` exposes only subtype value, membership evidence,
and construction from a value with evidence. The interval sets, maps, support
record, and equivalence assembly live in `library/diagrams/active_labels.clean`.
The new type aliases keep authored signatures shorter. Their expansion is precise;
the current language rejects `Describe` metadata on transparent aliases, so prose
rendering of these aliases remains a readability gap.

Validation is in progress. Grammar/layout checks pass for all new declarations,
and the support record and both maps have loaded. The full equivalence assembly
has not yet returned a translation result. The instrumented verifier terminated
with exit status 139 (segmentation fault) during translation; no native checks or
proofs completed in that run. Its cause is not established. The separate plain
translation job remains active. Python verifier/test files compile. `verify.py` specifies eleven independent canonical
body/type comparisons and one constructor-type comparison, plus four proof
obligations. Its expected expressions retain the native wrapper applications and
proof arguments. These planned checks are not a passing result until the verifier
terminates successfully. No kernel proof or completed basis restriction is claimed
at this checkpoint. Reindexing the actual bases and proving compatibility of the
restricted vectors are subsequent work.
:::
