:::llm gpt-6 2026-11-10 role=assisted

# Versioned retained-value encoding

This isolated experiment preserves checked annotations instead of letting JSON
silently turn their string subclass into plain text. It does not change production
storage. The input/output is a complete retained value (tree, index or captured
expression), not just an index's historical `syntax` string.

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
patches, checks strict parser regeneration, runs the 13 codec and 35 retention
tests and checks the native targets. Production remains unchanged.

Current ComputedIndex/ProofIndex constructors still write the old lossy JSON tree
to `syntax` while retaining a checked `resolved` tree in memory. This experiment
encodes the **whole index**, including `resolved`; dropping that field and decoding
only the old string is still unsupported. Integrating a versioned storage boundary,
legacy-data policy, complete validation of decoded records, resource accounting,
full consumer coverage and export/import of the explicit environment remain work.
No persistent project-file format or paper-theorem proof is claimed here.
:::
