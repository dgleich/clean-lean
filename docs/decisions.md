:::llm 2026-10-23 role=assisted

# Design decisions

These decisions separate requested behavior from provisional implementation choices. All can be revisited; no remote repository has been created.

| ID | Decision | Basis and status |
| --- | --- | --- |
| D01 | `.clean` extension and Clean name | Provisional user suggestion; no package-name availability claim |
| D02 | Focus on statements and LaTeX, with no proof language | Explicit user direction |
| D03 | Keep the collection and repository local | Explicit user direction |
| D04 | Use CLR topics for algorithms | Explicit user direction; edition unspecified, so no chapter/page claims |
| D05 | Require attribution on every result | Explicit user requirement |
| D06 | Use `let`, named `assume`, and `conclude` | Conversation agreement |
| D07 | Accept both prose and colon type declarations | Explicit user preference |
| D08 | Reject `let x = Type`; permit `let y = value` | Latest agreed resolution |
| D09 | Normalize keyword capitalization only | User requested flexible capitalization; preserve mathematical names |
| D10 | Indentation of at least two spaces, aligned siblings, no tabs | User correction: replaces the original four-space rule. Dedents match enclosing columns; widths may differ between blocks. Implemented |
| D11 | `Define` aliases value-defining `Let` only | Provisional convenience motivated by capitalization examples; can remove |
| D12 | Declare dimensions explicitly | Avoid implicit free variables and unclear quantification |
| D13 | JSON type/function registry plus canonical aliases | Historical; removed by D33, not retained as compatibility |
| D14 | Emit proposition definitions, without axioms or placeholders | Statement-only translation must not claim a proof |
| D15 | TeX package inputs preprocessed fragments | Initial design avoids a second parser and shell escape |
| D16 | Consecutive lets render as period-separated sentences | Concrete interpretation of requested punctuation |
| D17 | Pin Mathlib v4.24.0 and Lean v4.24.0 | Reuse the established Stewart environment, not a latest-version claim |
| D18 | Use specialized Mathlib lemmas for the first 80 examples | Keep initial translation testable; record exact source and scope |
| D19 | Algorithms collection begins with sorting and arithmetic | Available source-backed CLR material; not broad algorithm coverage |
| D20 | New literals in local value definitions default to Natural | Prototype inference rule; annotations/coercions need future design |
| D21 | Prefer English in LaTeX for logic, declarations, and predicates | Explicit user feedback; replaces the initial symbolic membership style |
| D22 | Retain standard mathematical operations and relations in formulas | Powers, multiplication, equality, and inequalities remain mathematical notation; conjunction is written “and” |
| D23 | English result titles generate Lean identifiers automatically | User request: spaces in display titles become underscores only in Lean names; legacy underscored titles render as words |
| D24 | Compact attribution uses source; reference; optional relationship; optional named fields | User agreement; omitted relationship and scope remain unspecified |
| D25 | Shared source declarations and short printed citations | Source details are stored once in explicit modules; full declaration provenance remains in metadata |
| D26 | Shared, nestable contexts introduce declarations and assumptions | Implemented; needed object dependencies and all inherited assumptions are retained in each result |
| D27 | LaTeX contexts may be expanded or explicitly referenced | Implemented; expanded is default, referenced results say “Using Context (1)” rather than relying on implicit scope |
| D28 | Combine reusable Clean modules with Lean-backed definitions | User agreement; an initial import/notation slice is implemented; see `notation-prototype.md`. Lean supplies mathematical meaning; Clean supplies readable names and presentation |
| D29 | Definitions must be inline or explicitly imported, with pinned project dependencies | Design direction; a hidden JSON sidecar must not be the permanent source of mathematical meaning. Exact module syntax remains provisional |
| D30 | Maintain a linear local Git history including intermediate steps | Explicit user direction: commits need not compile or work. Preserve steps without squashing, amending, rebasing, or merge commits; record validation status. Workflow in `AGENTS.md`; no publication authorized |
| D31 | Prototype notation signatures use ordered Let parameters and Returns | Provisional: Python uses these annotations, and generated Lean wrappers independently check Means. Multiword names require explicit calls; rendering is escaped English with placeholders |
| D32 | Prototype imports are relative, definition-only, and isolated per input document | Cycles and name conflicts fail; repeated imports deduplicate. Selective exports, qualification, and type-phrase modules remain future work |
| D33 | Entirely remove the registry, not retain a compatibility path | Explicit user correction: delete mathematical/source/import sidecars and old CLI flags; environment starts empty; migrate every corpus/example to explicit modules |
| D34 | Type, Alias, Phrase, and Source declarations live in Clean modules | Implemented prototype syntax; phrases use explicit regex patterns; provenance index JSON remains data, never a provider of meanings |
| D35 | Emit noncomputable notation wrappers and infer dimension/type parameters | Lean validates mathematical meanings; no executable-code promise. Initial matrix operations specialize to complex scalars; generic typeclasses remain future work |
| D36 | One module-declared mathematical semantic space | Explicit user direction after adversarial review: types, operators, overloads, literals, aliases, and rendering use explicit module declarations. No name-based semantic privileges for Natural, Matrix, Vector, Function, or Proposition. Architectural requirement; current compiler still needs migration |
| D37 | Lean is the authority for type meaning and elaboration | Implementation direction supporting D36: preserve bound declarations and structured applications rather than duplicate mathematical type rules in Python. The compiler retains generic parsing, binding, scope, and the bridge to Lean's foundational sorts; exact declaration syntax remains provisional |

| D38 | Specify syntax and semantics before the next compiler refactor | Explicit user direction; `language-reference.md` drafts grammar, binding, overload/elaboration, statement meaning, rendering, and conformance requirements. New concrete spellings and listed policy choices remain proposals |

| D39 | Plain text authoring must be desirable, not merely parseable | Explicit user requirement: readability is a joint acceptance criterion with semantic precision. `aspirational-syntax.md` collects target specimens; written operator patterns, named syntax groups, and reusable Use contexts are proposals rather than settled syntax |

| D40 | Complete paper statement definitions through explicitly imported Lean modules | Implemented for the three recent-paper specimens: ordered walk sums, graph optimization domains, and SDP coefficient maps. Existing Clean Notation declarations expose them; general Clean binders and top-level Define remain unimplemented. Statements are propositions, not proofs. See `paper-translations.md` for adaptations and totalization choices |

| D41 | Infer Clean expression continuation from open parentheses or a trailing operator | User request. Implemented without backslashes; complete expressions end at newlines. Continuation alignment is not a new scope. Opaque Lean/rendering/metadata fields keep their existing rules |

| D42 | Import bibliography metadata with `Import BibTeX "path.bib"` | User requested BibTeX sources; format-qualified spelling chosen instead of a separate bibimport keyword. Implemented via the optional pinned Pybtex parser. Citation keys become source keys; collisions fail and repeated paths deduplicate. Crossref/xdata inheritance is explicitly deferred; see spec for metadata and rendering choices |

| D43 | Continue expressions when incomplete, not merely after an operator token | User selected 1A. The next-language rule uses parser state; postfix applications can be complete. Refines D41; current heuristic implementation is not full conformance |
| D44 | Reject visible infix/postfix reuse of the same spelling | User selected 2A. Prefix/infix reuse remains legal. Conflicts are declaration/import errors before type checking; postfix parsing rules are specified in the reference |
| D45 | Allow imports between top-level declarations and results | User selected 3C. Sequential visibility (subsequent items only) is the recorded interpretation; no retroactive parsing or name resolution. Nested imports remain outside this slice. Not implemented |
| D46 | Definition fields may be reordered while parameters retain their relative order | User selected 4B. Require Returns and exactly one of Equals or From Lean; both allow explicit block bodies. Both implementations enter one semantic space. Optional attribution/presentation on definitions and a named-call rendering fallback are provisional refinements; result attribution remains mandatory. Not implemented |

| D47 | Unique parse and unique Clean-to-Lean translation are hard acceptance requirements | Explicit user requirement. Parsing may be expensive. Every accepted source has one specified tree and one canonical fully elaborated Lean target under a fixed explicit environment; ambiguity rejects, resource exhaustion remains incomplete. Contract in `language-change-acceptance.md`, mandatory workflow in AGENTS.md, initial pending oracles in `tests/acceptance/language-contract.json`. Current prototype is not certified |

| D48 | Maintain a local Clean-to-Lean HTML reference for Lean users | Explicit user request. `clean-to-lean.html` maps syntax, binding, and elaboration with implemented/accepted/proposed status. AGENTS.md requires updates with language changes. Explanatory Lean snippets do not replace canonical-target acceptance tests |

| D49 | Prefer definitions authored in Clean; track Lean-body fallbacks as language gaps | Explicit user direction. Implemented first `Define Equals` slice and 12 additional result ports; foundational primitives remain imported. Scope, unresolved gaps, and acceptance limits are recorded in `porting-findings.md` |
| D50 | Prototype `Define` supports inline From Lean, but rejects its block form | Temporary implementation boundary, not a change to the accepted grammar. Equals supports inline/block bodies; ordered/grouped/prose parameters, reordered fields, compact optional attribution and default rendering are implemented. Full canonical conformance remains pending |

| D51 | Include the authored name in generated Lean wrapper identifiers | User request. Implemented `cleanType_<stem>_<id>`, `cleanNotation_<stem>_<id>`, and `cleanDefine_<stem>_<id>` with readable space-separated names joined by underscores, safe Unicode encoding, and the existing deterministic 20-hex fingerprint. No Clean grammar or mathematical-body change |

| D52 | Support compact typed headers alongside expanded Notation/Define signatures | User accepted the proposed single-colon form: `Notation cos(x: Real): Real:`. Implemented as normalization to the existing signature, with no mixed header/body type declarations. Expanded forms retain implicit parameters; `::` is not introduced |

## Questions to revisit after reading the specimens

1. Should formalization contributors become a required field distinct from mathematical sources? Source keys are now implemented.
2. Should labels with spaces be allowed, and if so, quoted or parsed up to the colon?
3. Should `Define` stay as an alias, or should only `Let` introduce local values?
4. Should the LaTeX renderer preserve the exact original type phrase rather than using the imported type’s English description?
5. Which quantifier, summation, set-builder, and asymptotic syntax should come next?
6. Which CLR edition and algorithm families should anchor the next collection expansion?
7. Should generic algebraic structures and Lean typeclasses be expressible directly in Clean?
8. Which additional operator precedence and associativity rules need explicit examples? Unary minus already follows `-x^2 = -(x^2)`.

## Publication update — 23 October 2026

The user authorized GitHub publication as `dgleich/clean-lean`, superseding the original local-only restriction (D03 and D30). Preserve the existing chronological history. Publication initially uses private visibility pending a different user preference. Shared LLM-authored documents and code carry provenance markers, with upstream data excluded as documented in `PROVENANCE.md`.


:::

:::llm gpt-6 2026-10-29 role=assisted

## Self-contained magnetic study and explicit functions

The user requires five independent artifacts: reference Lean with proofs, reference
Lean propositions, one Clean source, generated Lean propositions, and generated Lean
with proofs. All include their mathematical definitions and import only Mathlib.
The study must not depend on the earlier paper helper module.

Chosen bounded syntax: `function(x: T, body)` supplies an explicitly typed lambda.
It permits generic imported finite operations to express the study in Clean.
See [its contract](function-expressions.md). The spelling is a recorded implementation
choice to revisit for readability; natural-language sum binders remain proposed.


:::

:::llm gpt-6 2026-10-30 role=assisted

## Conditions and grouped assumptions

The [condition extension](conditions.md) specifies `Condition name(parameters):`,
`Holds when`, and `Assumption name` templates. A condition has a fixed logical result,
so it has no `Returns` annotation. `Assume c(A), c(B)` creates two hypotheses, splitting
commas only outside parentheses. Explicit labels apply to one item. Automatic names
are derived from templates and canonical argument ASTs; collisions are errors.
Hypothesis labels do not enter expression scope. The [executable grammar](../grammar/clean.lark) now generates the parser, superseding
the earlier documentation-only EBNF. See [the generation contract](generated-parser.md).
The magnetic study now imports placeholder `library/Common.clean` for standard vocabulary,
superseding the earlier requirement to inline that vocabulary in its authored Clean file.
Generated Lean files remain standalone apart from Mathlib.
:::


:::llm gpt-6 2026-11-05 role=assisted

## Generated syntax parser

The [executable grammar](../grammar/clean.lark) generates a checked-in standalone
parser with pinned Lark 1.3.1 and interegular 0.3.3. Generation is strict: grammar
and lexer conflicts fail. The [generation contract](generated-parser.md) records
syntax normalization, deterministic artifact generation, layout and semantic boundaries,
and the reservation of logical expression keywords independent of module lookup.
`python3 tools/generate_parser.py --check` detects stale generated code.
:::

:::llm gpt-6 2026-11-05 role=assisted

## Trailing and block comments

Added whitespace-delimited trailing `#` comments and nested whole-line `#|` / `|#`
blocks. Whole-line block delimiters avoid changing indentation halfway through a
line. Embedded Lean and rendering fields remain opaque. Quoted paths and attached
URL fragments preserve hashes. These choices are revisitable; the exact lexical
algorithm is in [the specification](spec.md#comment-lexing-implemented).
:::

:::llm gpt-6 2026-11-05 role=assisted

## Julia-style block comment delimiters

At the user's preference, `#=` / `=#` replace the initial `#|` / `|#` spelling.
These are [Julia's nested comment delimiters](https://docs.julialang.org/en/v1/base/punctuation/).
Clean retains its whole-line delimiter rule; this change adopts the spelling,
not Julia's inline block-comment syntax. No compatibility alias is retained.
Comment masking, source positions, nesting, and the Lean erasure rule are unchanged.
:::

:::llm gpt-6 2026-11-05 role=assisted

## Lean-style comments, including inline blocks

The user's preference supersedes both earlier comment choices: use `--` and nested
`/- … -/`. Blocks may start and end inline. No hash-comment compatibility aliases
remain. Reserve these pairs lexically before mathematical tokens, independent of
imports; separate adjacent arithmetic operators when they would form a delimiter.
The scanner masks comment characters with spaces and retains newlines, so layout
uses actual code columns. Embedded Lean/rendering fields remain opaque. Clean does
not adopt Lean documentation-comment semantics. See the current
[lexical contract](spec.md#comment-lexing-implemented) for exact precedence and scope.
:::

:::llm gpt-6 2026-11-05 role=assisted

## Literate prose and Lean documentation

Adopt the user's `Text:` and triple-quoted forms and Lean's distinction between
free module documentation (`/-!`) and attached declaration documentation (`/--`).
Do not introduce `Section:` or other document-structure keywords. Use literal
LaTeX/Typst in tagged blocks for headings and layout. Default prose is plain text;
this is an implementation decision, not an implicit Markdown dialect. Tags are
case-insensitive. The [literate-text contract](literate-text.md) records exact
boundaries, nesting and attachment, and the first-slice placement/rendering limits.
LaTeX is the implemented document backend; Typst payloads are parsed and preserved,
but LaTeX explicitly rejects them until a Typst renderer exists.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Topology foundation and scoped quantifiers

Use explicit carrier types and topology values in the first topology module.
Define preimages, images, continuity, selection and family intersection in Clean.
Introduce `for every (x: T, P)` and `there exists (x: T, P)` as expression atoms:
parentheses delimit scope and protect their comma from assumption grouping.
Reserve for/every/there/exists case-insensitively. Reject shadowing and non-Prop
bodies. Emit Lean forall and explicit Exists terms with deterministic renaming.
Render quantifier words in English. This is an implementation choice for review;
the earlier unparenthesized prose spelling is not an accepted alias.

The explicit Type binding targets Lean Type 0 and has a Type 1 wrapper.
Universe-polymorphic structures and arbitrary value-indexed constructors remain
pending; a bounded design and acceptance obligations are in the
[topology study](../studies/topology/requirements.md). Do not add topology-specific
binders or paper theorem adapters to evade those gaps. The original comparison
is historical; the study README distinguishes executable foundation from targets.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Parsing value-dependent types

Retain constructor spelling and the existing generated type grammar. Normalize to
neutral Name/Apply/Numeral trees before checking argument roles. Generalize Type
parameter declarations to ordered, explicitly typed values, initially accepting
only earlier named locals as non-natural value indices. Preserve bound local
identities inside nested quantifiers; reject differing indices without transport.
Constructor applications take structural precedence over Phrase rules. Prose
captures retain identifier case; multiple full phrase matches fail before typing.
LaTeX uses module-declared descriptions. No new dependent-type keyword is needed.

This bounded implementation supports type aliases and theorem binders, with
kernel-checked Element and Path specimens. Callable signatures containing these
indices are explicitly rejected pending a constructive argument-substitution rule.
No implicit carrier/topology inference or general expression indices are added.
See the [contract](value-indexed-types.md) and
[study](../studies/topology/README.md).
:::

:::llm gpt-6 2026-11-06 role=assisted

## Dependent calls before authored structures

Implement a structured callable telescope on the named-index path. Infer omitted
type/dimension parameters by exact structural matching and pass them explicitly
to the generated Lean wrapper. Substitute actual named locals for declared value
indices; do not equate different locals through Lean conversion or assumptions.
Computed index arguments need a preceding Let. Non-indexed arguments may be nested
calls. Preserve legacy nondependent calls until their separate inference audit.
Use subtype/path wrappers and independent canonical Lean checks before building
record constructors on this machinery. See [the contract](dependent-calls.md).
:::

:::llm gpt-6 2026-11-06 role=assisted

## First authored record interface

Use Structure headers, typed Let fields and an explicitly named constructor. Fields
are scoped through dot notation, avoiding global accessor-name collisions. Preserve
header/field order; permit dependence only on preceding bindings. A stable field
reference may be a type index or dimension. Require a local name before projecting
from computed records. Function-valued fields support `P.map(x)` with the existing
ordinary Function semantics. Use fixed-carrier Type 0 records first; proof fields,
carrier-type fields and universes need separate extensions. Never replace hypotheses
with unconstrained proposition fields. These implementation choices are recorded in
[structures.md](structures.md) and remain reviewable.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Fixed universes for imported bundles

`Universe: n` on an imported Type or authored Structure fixes its Lean result sort.
See [fixed universes](fixed-universes.md) for the grammar, default normalization,
translation and acceptance checks. TopCat spaces and continuous maps now have an
explicit Clean module, with authored diagrams and five verified statements.
General universe polymorphism and carrier-type record fields remain pending.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Explicit computed indices

[Computed indices](computed-indices.md) extends a value/dimension argument with
an explicitly parenthesized, binder-free expression. It also permits compound
actual value arguments in dependent calls. Substitution works on expression trees;
matching remains structural, with no local-alias unfolding or inversion of
computations. This supersedes the earlier requirement to name every computed
index first. Type-valued arguments remain named carriers.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Explicit evidence and certified records

[Evidence](evidence.md) specifies parenthesized conditions in type position,
ordinary `Evidence` aliases, proof-bearing record fields, and single-identifier
assumption labels usable as explicit proof arguments. This supersedes the earlier
exclusion of proof fields. Matching is structural; direct binder-bearing evidence
requires a named Condition. No implicit proof search or general Sort parameters
are introduced. Certified subset and continuous pair inclusions exercise this map.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Computed record projection

[Computed records](computed-records.md) supersedes the named-base-only restriction.
It specifies constructor-field reduction and explicit, binder-free authored
producer unfolding; other computations retain nominal projections. LaTeX preserves
the authored expression and is excluded from semantic index identity. The interlevel
certificate composition now works in Clean. Implicit/binder-bearing producer
reduction and local-alias conversion remain separate extensions.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Authored definition conversion

[Definition conversion](definition-conversion.md) now permits typed dependent
indices to match eligible binder-free authored expansions. It supersedes the
blanket structural-only rule for those indices. Emitted Lean terms and source
annotations retain their prescribed wrappers; comparison does not rewrite them.
Native adapters, local aliases and the documented ineligible bodies stay opaque.
The relative-map study exercises this rule with named source/target objects and
explicit commutativity evidence, checked against independent native targets.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Immediately applied functions in indices

[Applied-function indices](applied-function-indices.md) permits checked immediate
lambda contraction during dependent index construction when body and argument
are binder-free. Original call arguments remain in emitted Lean; index annotations
use the prescribed contraction. This resolves generic congrArg on record-field
functions without admitting bare lambdas, quantifiers or general local-alias conversion.
There is no grammar change or implicit proof search.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Automatic names for structural condition arguments

[Condition naming](conditions.md#structural-arguments-in-automatic-labels) now
covers projections, field applications and nested quantified arguments. The label
is a deterministic spelling of the elaborated expression's normalized source tree;
existing punctuation encoding and collision rejection are unchanged. No new syntax
or implicit hypothesis is introduced. Native statement checks and independent
binder-name tests cover compactness of P.space.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Local definitions in dependent indices

[Local definition conversion](local-definition-conversion.md) now saves checked,
binder-free comparison values for local definitions. It supersedes the earlier
blanket local-alias restriction. Emitted Lean lets, authored names and inferred
annotations are preserved; ordinary variables and assumed equalities remain opaque.
The relative-homology specimen checks two exact native propositions and two proofs.
Binder-bearing local definitions and general dependent functions remain open.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Typed dimensions

[Dimension indices](dimension-indices.md) migrates declared Natural slots to the
same checked value-index comparison and substitution mechanism. Local dimension
aliases now work; calls explicitly supply their inferred dimensions. Repeated
consistent inference uses the last occurrence in declared traversal order.
Five canonical targets and four proofs cover readable examples. Generic dependent
functions, broader literal inference and the topology research obligations remain open.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Dependent function type staging and graded objects

[Dependent function types](dependent-function-types.md) specifies the selected
bound-domain form and its intended scope, alpha-equivalence and Lean mapping.
Only its generated grammar and syntax normalization are implemented: semantic
elaboration explicitly rejects the new form. No translated-Pi claim is made.
The [working graded-object study](../studies/dependent-functions/README.md) uses
existing ordinary functions, with seven canonical targets and a component proof.
Its separate native graded-map model has four proofs, but is not translated Clean.
:::
