:::llm gpt-6 2026-11-11 role=assisted

# Higher computed and projected carriers

[CarrierRecords.clean](CarrierRecords.clean) authors a record that contains a
Type-1 carrier and an element of that carrier:

```clean
Structure SpacePackage():
  Universe: 2
  Let carrier: LargeTypes
  Let point: carrier
  Constructor: pack space
```

A topology space can be packaged by passing `type(TopologicalSpace : LargeTypes)`
and the space itself to `pack space`. For an arbitrary P, `P.point` has type
`P.carrier`. The native structure has a carrier field in the declared classifier
wrapper and a point field whose type is that carrier. The fixed record universe
must accommodate both fields; the existing universe-bound check remains active.

## Constructive representation

No grammar changes. Existing type projections and parenthesized carrier expressions
first elaborate to a value. Its resolved type must be a declared classifier C at
level k. Normalize using the existing authored-expression rules. An explicit type
value yields its checked carrier; a local carrier yields LocalType; other cases
produce `ComputedCarrier('$carrier', (index,), universe=k, classifier=native(C))`.
The index retains the checked expression using the existing index storage rules.
There is no fallback to Type 0 for an unrecognized computed carrier.

The representation is a distinct immutable Type subclass. Its sort is k+1, its
source spelling is the index's source spelling, and its native carrier is the
checked index expression. Source and LaTeX never display `$carrier` or classifier
metadata. Alpha/comparison keys include the level and classifier identity as well
as the index key. A plain internal Type named `$carrier`, without metadata, rejects
in rendering, universe checking and annotation validation.

Substitution in dependent functions, declaration result types and record fields
substitutes the index, elaborates the resulting expression, verifies the retained
classifier identity and level, and extracts its carrier again. This can reduce a
constructor projection to a named carrier. It cannot silently change classifier or
universe. Generic call matching compares computed carriers through this structural
path. Checked annotations revalidate computed carriers in their current scope and
reject a stored native target that differs from fresh elaboration. This is a
local consistency check, not a complete native dependency snapshot.

For a dependent record projection, each required preceding field whose type has
classifier metadata is treated as a carrier. The rule no longer tests whether
that field's type happens to be named Type. Ordinary value fields keep the existing
index rule. Record field order and dependency closure remain unchanged.

## Stored representation

The composition uses clean-bound-tree version 3. It adds the explicit
ComputedCarrier record with exactly `name`, `args`, `universe`, and `classifier`.
The name must be `$carrier`; args must be a singleton tuple containing a ValueIndex;
universe is a nonnegative integer excluding booleans; classifier is a nonempty
string. Versions 1 and 2 reject. The decoder reconstructs data, not a certification
of its mathematical meaning: checked replay under the explicit environment remains
required. This is an experimental internal format, not a released project format.

## Validation and remaining boundaries

The expanded suite passed 164 tests in 60.484 seconds, including Type-0 and
old-version cases. A final stale-native-target guard was then added; all fourteen
focused tests passed in 5.125 seconds. Fresh pinned reproduction is running. Four independently
specified Lean targets check the constructor, authored package function and two
statements. Both statements are proved by reflexivity. See
[CarrierRecordTargets.lean](CarrierRecordTargets.lean).

Reproduce with `python3 studies/universe-classifiers/verify.py --computed-carriers`.
This includes carrier binders and version-3 storage. Production remains unchanged.
The prototype does not establish full native dependency freshness or arbitrary
record-parameter inference. General higher type constructors, complete regression
and production integration remain separate obligations. The topology package
example proves projection/reflexivity laws, not a homology or well-group theorem.
:::
