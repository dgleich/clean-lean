:::llm gpt-6 2026-11-10 role=assisted

# Versioned retained-value encoding

This isolated experiment preserves checked annotations instead of letting JSON
silently turn their string subclass into plain text. It does not change production
storage. The codec accepts complete retained values (trees, indices or captured
expressions). A subsequent storage patch uses it for the expression payload inside
each computed, dimension or proof index.

## Version 1 data contract

The envelope has exactly `format`, `version` and `value`. Format is
`clean-bound-tree`; version is integer 1 (boolean true is not a version). The
encoder emits UTF-8-compatible JSON text with sorted keys and compact separators.

- Strings, integers, booleans and null preserve their distinct JSON kinds.
- Lists are arrays. Tuples use `{tag: Tuple, items: [...]}`; tuple/list identity is
  required for type arguments, scopes and comparison keys.
- An Annotation has exactly `tag`, `source`, `type` and `names`. Its type is encoded
  structurally; names are unique strings in sorted order. Decoding reconstructs
  the immutable Annotation, including its checked type and free references.
- Records have exactly `tag` and `fields`. Allowed tags and their exact field
  names are fixed in `SCHEMA` in [codec.py](codec.py): Type, LocalType, ValueIndex,
  ComputedIndex, DimensionIndex, ProofIndex, ProofType, DependentFunctionType,
  Expr and ScopedKey. A dataclass field change requires a schema/version decision;
  it is not automatically incorporated. Proof/dependent-function types reconstruct
  through their explicit constructors and check their discriminator/arity.
- No arbitrary class lookup, imports named by data, evaluation or pickle is used.
  Unknown fields/tags/versions, duplicate JSON keys, non-finite JSON constants,
  unsupported host values and cyclic host graphs reject. Shared acyclic values
  are encoded by value; mutable object identity is not an encoded property.

The codec preserves record data. It does **not** certify that a decoded Expr or
Type is well typed, that stored native text belongs to the environment, or that a
record represents a currently valid declaration. Re-elaborating the restored tree
under the explicit environment is mandatory. Stored typed-child metadata is not a
freshness witness. Native definitions, imports, instances and complete environment
snapshots are not serialized or authorized by this payload.

A fixed schema and recursively tagged cases give one reconstructed value for each
accepted payload. Canonical encoding provides one byte spelling for an encodable
value tree; the decoder also accepts harmless JSON whitespace/key-order variations.
This data-level uniqueness does not establish the full Clean-to-Lean acceptance
contract. Literal declaration snapshots still use the earlier prototype's repr
strings and are checked against the pinned environment; cross-version snapshot
compatibility and full native binding closure remain open.

## Interaction coverage

Thirteen focused tests check an independently written annotation schema,
module/local carrier distinction, retained literal spelling, computed-index
substitution, proof indices and captured scopes, quantified annotations, dependent
function types, scoped comparison keys, later overloads, changed constructors,
container distinction, malformed payloads and cycles. The literal selection is
replayed after decoding: adding an overload does not select it retroactively,
while changing the retained constructor rejects.

The native checker restores and re-elaborates the serialized values, then compares
three independently specified targets (vector zero, substituted dimension and a
quantified condition) and proves a coordinate equality and quantified reflexivity.
It does not validate a stored Lean string merely by copying it into an oracle.

The pinned run completed with exit 0 on 2026-11-10: strict parser generation and
reproducibility checks, 48 tests in 6.101 seconds, three exact restored targets and
two proofs. The only Lean diagnostic was an existing unused-variable warning.

## Reproduce and remaining integration

```sh
LAKE=lake python3 studies/bound-tree-codec/verify.py
```

The pinned driver exports compiler 9e1ba7e, applies the annotation and retention
patches, installs the codec and applies `storage.patch`. It checks strict parser
regeneration, codec/retention/storage/applied-index/quantified-beta tests, then
replays the native specimens with their `resolved` fields removed. Production
remains unchanged. `--whole-values-only` reproduces the first experiment without
the storage patch or payload-only replay.

## Index payload authority

ComputedIndex, DimensionIndex and ProofIndex constructors now encode their checked
expression tree in `syntax` with the version-1 envelope. `index_tree` decodes that
payload unconditionally. The existing `resolved` field remains available for
inspection, but it no longer overrides stored expression meaning. Six tests cover
restoration without that field, literal and dimension substitution, quantified
proof annotations, type-valued indices, conflicting cached trees and rejection of
legacy/unknown-version payloads. A future cache optimization must validate that it
represents this same payload; cache state must not select a different expression.

Old raw-list JSON is rejected, even when it looks parseable. No compatibility
fallback may recover a lost checked annotation by re-resolving its display text.
This is an experimental internal format change; there are no released persisted
project files to migrate. Two existing applied-index oracles now use the codec and
explicitly expect Annotation values, retaining their independently written tree
shapes and native target checks.

The final storage-driver run completed with exit 0 on 2026-11-10: strict parser
regeneration/check, 76 tests in 12.980 seconds, three exact targets and two proofs
replayed with the index caches removed. The existing unused-variable warning is
nonfatal. No production compiler file changed in this experiment.

This representation boundary is still not an environment loader or a semantic
validator for arbitrary decoded records. The checked replay paths, native binding
snapshot coverage, consistency of other captured/comparison metadata, resource
accounting, complete consumer coverage and production integration remain work.
No persistent project-file format or paper-theorem proof is claimed here.
:::
