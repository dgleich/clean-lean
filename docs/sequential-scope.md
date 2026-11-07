:::llm gpt-6 2026-11-07 role=assisted

# Sequential Clean declaration visibility

Top-level imports and declarations may occur between Result or Context blocks.
This implements the Clean name-visibility part of decision D45. It does not enable
imports inside those blocks or finish module-owned identities/native elaboration.

## Parsing and scope

The generated module grammar already admits a sequence of module items; no new
production, token or layout interpretation is added. Each import/declaration is
one existing module item, and each Result/Context has its existing indentation
boundary. Therefore allowing a later module item introduces no alternative parse.
Nested imports remain syntax errors. Imported definition modules still cannot
contain Result or Context blocks.

Walk root items in source order. At a Result or Context, retain a deep snapshot of
the current explicit Clean environment. Adjacent statements without an intervening
import/declaration share that snapshot. Before processing the next declaration or
import, invalidate the snapshot for subsequent statements. Later declarations are
added to the loader's environment, never to an earlier snapshot. Repeated imports
retain existing idempotence; duplicate declarations and cycles still fail.

Interpret each result's clauses in its retained environment, plus its local and
inherited Context binders. A nested result inherits its enclosing top-level
Context's snapshot. Attribution resolution uses that environment too: a later
Source or BibTeX import cannot supply an earlier unknown citation key. Result names
remain unique across the whole document, including across intervening imports.
The source nodes retain their original line numbers. Snapshot metadata is not part
of their parsed syntax, equality or representation, so context keys remain stable.

The implementation collects nodes before interpreting results. This can report a
later declaration/import error before an earlier result error; it never allows a
successful later declaration to repair an earlier missing Clean binding. Diagnostic
priority is not an inference or overload-selection rule.

## Rendering and translation

Retain the statement environment on the checked Result, separately from its source
syntax and mathematical data. Emit the statement's already checked expressions and
render its types using this environment. Render its Context clauses and attribution
with the same environment in LaTeX. This matters even when duplicate globals are
forbidden: a later global type `T` must not reinterpret an earlier local `T: Type`.
The public `parse` function over result/context nodes without loader snapshots keeps
using its explicitly supplied environment; it does not synthesize module scope.

Lean output still emits the final collection of native imports and declarations
before the checked statements. The bibliography likewise includes all explicitly
imported sources. Snapshots freeze Clean lookup and type rendering, not the native
Lean environment: later native imports could affect native instance/coercion
elaboration. Full native import isolation and module-owned bound identities remain
open requirements. This feature is not evidence that an earlier native target is
independent of arbitrary later Lean imports. The checked study adds no later native
imports and independently verifies its canonical targets.

## Evidence

Nine new regressions cover later type spelling versus a local carrier, Context
snapshots, unavailable earlier functions and citations, later availability, adjacent
snapshot reuse and independence, document-wide result-name collision, nested import rejection, and combined-document rendering. Existing repeated Clean/BibTeX imports now also pass after a
result. Together with module, bibliography, Context and literate tests, 63 tests pass.
An additional 161 dependent-type, structure, alias and evidence tests pass. The
92-proof corpus, interval-basis proofs and isolated operator prototype also recheck.
The subsequent full Python run completed 725 tests in 6875.593 seconds: 724 passed,
and one failed because the alias/universe rejection test still expected an older
diagnostic string. The compiler rejected the invalid declaration as required.
The stale expectation was corrected and its focused universe test group rerun;
this is not a claim of a second complete 725-test run.

The [study](../studies/sequential-scope/README.md) checks the source item sequence,
expression trees, four exact Lean targets and two proofs. Its absolute-value theorem
uses an explicit scalar-zero wrapper because unresolved numerals still dispatch
by built-in type spellings in main. This is an existing migration gap, not a newly
introduced literal rule. All full module/numeral conformance requirements remain.
:::
