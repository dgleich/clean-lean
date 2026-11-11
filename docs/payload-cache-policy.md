:::llm gpt-6 2026-11-11 role=assisted

# Stored payloads exclude disposable caches

The working compiler writes clean-bound-tree version 4. This preserves version 3's
semantic record fields but removes `Expr.checked_args` and the `resolved` field
of ComputedIndex, DimensionIndex and ProofIndex from the stored schema. Decoding
restores their dataclass defaults, None. Older envelope versions and payloads
that supply these removed fields reject; there is no implicit migration or cache
fallback. The field inventory remains explicit, including an explicit inventory
of transient fields, so future dataclass changes require review.

`checked_args` is only a traversal-local reuse cache; it cannot supply a freshness
witness after serialization. An index's `resolved` tree is likewise not an
authority: `index_tree` already decodes `syntax` unconditionally. Serializing either
cache duplicates data without adding meaning. Arbitrarily large shared cache
graphs could therefore inflate the JSON encoding of a small semantic value.
The new representation never visits those transient fields.

Checked annotations, index syntax, scopes, local-definition comparison values,
inferred arguments, operator bindings and canonical comparison metadata remain
stored. This change does not discard proof assumptions or weaken scope/classifier
checks. Consumers still re-elaborate stored trees under their explicit environment;
the codec is not a semantic validator or an environment loader.

For a fixed semantic value, changing either disposable cache cannot change its
payload. Exact record tags and recursive tagged containers determine one decoded
value. The decoder rejects removed fields rather than letting supplied cache data
select another meaning. This is a data contract; the broader unique Lean-target
acceptance obligations remain in force.

## Evidence

- A synthetic 24-level shared typed-child cache produces exactly the same bytes
  as the expression without that cache. The index test likewise checks equality
  with conflicting/absent resolved caches, and the decoded caches are None.
- All 115 selected codec, carrier, substitution, hygiene and quantified/applied-index
  tests passed in 28.935 seconds.
- Native replay passed 19 independent exact targets and eight proofs across restored
  indices, classified values, dependent records and classifier/literal interaction.

The active-label diagnostic progressed through subtype equivalence and the two
active-label maps after cache omission; the final active-label-equivalence load
is still running. No completed whole-module speedup or full-suite pass is claimed.
The original diagnostic crashed while its timed stack dump was inside encoding;
that observation alone does not establish the cause of the crash. Existing full
runs remain live and retain their own compiler snapshots.

The version-4 full run uses a separate immutable checkout. Production integration
and the focused/native checks above are complete; full regression and the remaining
active-label/browser performance investigation remain pending. The schema is still
experimental; it is not a released persisted-project format.
:::
