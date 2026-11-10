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
Its 35 focused cases include synchronized substitution, later competitors,
changed declarations/digits/carriers, lost annotation metadata and beta reduction.
The native checker independently specifies three constructor targets and proves
two coordinate equalities. Two additional canonical targets cover capture-free
dependent functions and quantified conditions. These are narrow checks, not full conformance evidence.

## Reproduce

```sh
python3 studies/literal-retention/verify.py
```

The driver exports pinned comparison-integrated baseline
`9e1ba7e91a9dbc135fed3ad7564107137aa7e9ff`,
applies the first annotation study patch followed by this incremental patch,
regenerates/checks the parser, runs focused and existing regression tests, and
checks the Lean targets using the repository's pinned dependencies.
Use `--historical` to reproduce baseline `027659500545c3290457a62d96389137879cdc6d`
and its recorded choice-module setup error. The repair is part of the explicitly
named new baseline, not an unrecorded extra patch.

## Recorded validation

On 2026-11-10 the pinned driver completed successfully: strict parser generation
and reproducibility check, 82 tests (31 retention cases plus 51 existing parser,
numeral, compact-signature and applied-index tests), three exact Lean target
comparisons, and two coordinate proofs. The test phase took 21.526 seconds. Lean
reported one unused-variable warning. This does not replace a full-suite run.

## Binder and record follow-up

A consumer audit exposed a real scope failure: freshening a function or quantifier
binder with an ordinary textual domain did not register that binder's checked
type. An annotated literal depending on it then failed with an unknown fresh name.
The prototype now records every traversed binder domain and resolves the enclosing
domains in order when a checked annotation needs their semantic scope. It restores
the previous scope on exit. Raw syntax-only substitution remains syntactic; this
applies to all checked domains, not a special case for Natural.

Four additional tests cover lambda and quantifier freshening, capture avoidance
when a free matrix dimension has the same spelling as a bound dimension, and
substitution/projection through a dependent record field. The driver also includes
existing hygienic-conversion, quantified-beta and structure regressions. The final pinned run executed 152 tests in 25.863 seconds with no test failures
and one class-setup error: `test_quantified_beta` cannot load `choice.clean` on
this baseline because of the already documented contextual-family comparison
bug. All 35 retention tests and 23 hygiene tests also pass independently. Strict
parser regeneration/check passed. Five exact native target comparisons and two
coordinate proofs passed after the regression run. The historical driver deliberately
returns exit 1 on that baseline; it now runs independent native
checks before reporting the aggregate failure. The newer default baseline includes the integrated contextual-family repair.

## Authored dependent interfaces

[Interfaces.clean](Interfaces.clean) is an executable specimen for the patched
compiler. It declares the zero adapters explicitly, then authors a record, a
family of vectors and a condition entirely in Clean:

```text
Structure SizedVector():
  Let size: Natural
  Let vector: Vector(size,Complex)
  Constructor: sized vector

Define zero bundle(n: Natural): SizedVector:
  Equals: sized vector(n,(0: Vector(n,Complex)))

Define zero family(): Function(n: Natural,Vector(n,Complex)):
  Equals: function(n: Natural,(0: Vector(n,Complex)))

Condition zero bundle contents(V: SizedVector):
  Holds when: V.vector = (0: Vector(V.size,Complex))
```

The literal is resolved from its declared result carrier; `V.size` is recovered as
an ordinary checked projection. There is no special handling for these names.
`check_interfaces.py` independently writes the native record constructor, dependent
function and condition targets, and proves zero-bundle contents and coordinate
zero for the family. Its condition oracle retains the explicit Proposition wrapper;
a raw `Prop` return type is definitionally equal but fails the exact-target test.

Production still has no `Literal:` attachment: these interfaces must be run through
the pinned study driver. This specimen tests composition of existing structures,
dependent functions and conditions with the proposed literal feature, not a new
syntax or a proof of the topology paper's theorems.

## Composed-stack validation

The default pinned driver completed with exit 0 on 2026-11-10: strict parser
regeneration/check, 162 tests in 38.846 seconds, eight exact native target
comparisons and four proofs. This includes the formerly blocked quantified-beta
suite. Lean emitted only existing unused-variable warnings. The main compiler's
full regression and the separate contextual prototype regression are still live;
these results do not stand in for either full run.

## Remaining requirements

The snapshot uses Python representations and is not a portable encoding or a
complete native environment/instance snapshot. JSON round trips lose Annotation
metadata and explicitly fail replay; faithful versioned serialization is pending.
Only explicit annotations are produced: inferred/defaulted tags are reserved,
not evidence of a working joint constraint solver. Unannotated vector/matrix zero,
general universe/proof argument handling, complete expression-consumer coverage
and the full regression audit remain open. No paper theorem is proved by this work.
:::
