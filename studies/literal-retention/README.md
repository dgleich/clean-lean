:::llm gpt-6 2026-11-10 role=assisted

# Retaining annotated literals through substitution

This second isolated experiment preserves `(0: Vector(n,Complex))` as a literal
rather than replacing its authored spelling with a constructor call. Substituting
n with m updates both its constructor argument and its checked carrier annotation.
Production is unchanged. The first experiment remains independently reproducible.

The internal BoundLiteral record retains raw/canonical digits, the selected
constructor and declaration snapshot, all formal actuals in telescope order,
a checked Annotation and an origin flag. Replay checks the saved declaration,
arguments and result carrier; it does not select among newly introduced candidates.
Comparison lowers the retained selection to its ordinary checked constructor call.
Automatic assumption names canonicalize leading zeros; authored spelling retains them.

The experiment updates expression elaboration/binding, source and condition
spelling, free-name collection, hygiene/index substitution, beta reduction,
quantified traversal, numeral-hole discovery and comparison normalization.
Its 31 focused cases include synchronized substitution, later competitors,
changed declarations/digits/carriers, lost annotation metadata and beta reduction.
The native checker independently specifies three constructor targets and proves
two coordinate equalities. These are narrow checks, not full conformance evidence.

## Reproduce

```sh
python3 studies/literal-retention/verify.py
```

The driver exports pinned baseline `027659500545c3290457a62d96389137879cdc6d`,
applies the first annotation study patch followed by this incremental patch,
regenerates/checks the parser, runs focused and existing regression tests, and
checks the Lean targets using the repository's pinned dependencies.

## Recorded validation

On 2026-11-10 the pinned driver completed successfully: strict parser generation
and reproducibility check, 82 tests (31 retention cases plus 51 existing parser,
numeral, compact-signature and applied-index tests), three exact Lean target
comparisons, and two coordinate proofs. The test phase took 21.526 seconds. Lean
reported one unused-variable warning. This does not replace a full-suite run.

## Remaining requirements

The snapshot uses Python representations and is not a portable encoding or a
complete native environment/instance snapshot. JSON round trips lose Annotation
metadata and explicitly fail replay; faithful versioned serialization is pending.
Only explicit annotations are produced: inferred/defaulted tags are reserved,
not evidence of a working joint constraint solver. Unannotated vector/matrix zero,
general universe/proof argument handling, complete expression-consumer coverage
and the full regression audit remain open. No paper theorem is proved by this work.
:::
