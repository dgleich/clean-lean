:::llm gpt-6 2026-11-11 role=assisted

# Classified values in stored index payloads

This extension composes the classifier prototype with the existing
[retained-value codec](../bound-tree-codec/README.md). Production is unchanged.
Run `python3 studies/universe-classifiers/verify.py --storage` in the pinned
Lean environment to reproduce the composition.

## Schema and reconstruction

The envelope format remains `clean-bound-tree`; its integer version becomes 2.
The exact record schema is version 1's schema except that LocalType has five
fields: `name`, `args`, `lean`, `universe`, and `classifier`. The latter three
are a string, a nonnegative integer (not a boolean), and a string respectively.
The classifier string is a retained native identity, not a name to resolve.
The decoder rejects version 1: it cannot reconstruct missing classifier identity
by looking up a display name. This is an experimental internal format with no
released persisted project files requiring automatic migration.

BoundTypeValue is encoded using the existing tagged containers: its two checked
annotations retain their types and free-reference sets; its classifier snapshot
remains a tuple; its presentation remains a string. No new class-by-name lookup
or executable payload mechanism is introduced. Unknown records and extra/missing
fields reject under the inherited codec rules. Schema decoding does not certify
semantic validity; the retained tree must be elaborated in the explicit environment.

The inherited storage patch makes the encoded `syntax` payload authoritative for
computed, dimension and proof indices. `index_tree` decodes it even if `resolved`
contains a conflicting tree. Decoding does not restore object identity or authorize
stored Lean strings. Re-elaboration validates the classifier snapshot, carrier
level, and local reference scope. A newly imported competing classifier cannot
change the selection of an already retained value.

This construction gives one decoded value per accepted payload and preserves the
existing constructive elaboration rule. It does not prove freshness of arbitrary
captured comparison metadata or the entire native dependency environment.

## Evidence and remaining work

The first composition run passed 33 tests in 12.886 seconds: all 26 classified-value
cases plus seven storage cases. The latter include an independently written JSON
schema, wrong versions and malformed metadata, retained annotation/snapshot
identity, payload-only substitution, conflicting cache rejection by authority,
changed classifier rejection and missing-local rejection.

The native driver has a `--payload-only` mode. It serializes an inferred indexed
application, deletes the cached tree, decodes and elaborates it again, then compares
its native target against the same independently written Lean oracle. It also
round-trips an explicit classified carrier. The native run passed ten exact targets and three proofs after payload-only
replay. The expanded storage/dependent-call/dependent-function/applied-index/quantified
run passed 113 tests in 55.873 seconds. The fresh pinned `--storage` reproduction completed successfully: 286 selected
tests in 116.696 seconds, 29 additional storage/index tests in 26.757 seconds,
strict parser reproducibility and all native suites. Full regression and
integration are not claimed.

Higher carrier-valued fields (with dependent callable binders now handled by the
optional [carrier-binder composition](carrier-binders.md)), complete native
freshness, full regression, and production integration remain unfinished. This
storage experiment neither implements IEEE arithmetic nor proves the topology
or LAProof paper theorems.
:::
