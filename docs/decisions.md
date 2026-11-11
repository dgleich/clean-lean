:::llm 2026-10-23 role=assisted

# Design decisions

:::llm gpt-6 2026-11-07 role=assisted

Implementation update: [operators and numerals are now integrated into the working compiler](operator-numeral-integration.md). Earlier isolated-status descriptions below describe the development stages. The curated subject libraries now explicitly import their operators and numeral default. Broader library/test migration and full language-contract conformance remain unfinished.
:::


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
| D45 | Allow imports between top-level declarations and results | User selected 3C. Sequential visibility (subsequent items only) is the recorded interpretation; no retroactive parsing or name resolution. Nested imports remain outside this slice. Clean visibility snapshots implemented; native import isolation remains open (sequential-scope.md) |
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
The initial semantic implementation now supports bound value domains, alpha-equivalent
types, capture-free substitution, dependent application/lambda inference and graded
map fields. The study includes eleven exact native graded-map targets and three
proofs. Inference rejects any bound local escaping into a free implicit argument.
Type-valued binders remain unsupported; the contract records the remaining proof,
universe and naming acceptance cases. The earlier ordinary-function graded objects
still have seven canonical targets and their component proof.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Applied producer fields and induced graded homology

[Hygienic producer conversion](hygienic-producer-conversion.md) extends comparison
through explicit authored function-producing definitions and applied fields.
Capture-free substitution includes type annotations and nested binders. Residual
binder-bearing comparison values and shadowed module bindings stay opaque.
Computed-object field calls now serialize using the existing grammar.
The induced graded-homology map is authored in Clean, with four exact native targets
and three functor-law/component proofs. General higher-order conversion, inferred
body parameters, and unapplied family comparison remain outside this profile.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Proof-valued function sorts

[Proof-valued functions](proof-valued-functions.md) extends the explicit arrow
interface to proof operands in both ordinary and bound forms. Proof-sort checking
now follows the codomain of ordinary/dependent arrows, and every Type-parameter
gate rejects these proof families. No lift or general native-sort inference is added.
Ten exact targets, five native sort assertions and five proofs cover finite,
empty/singleton, proof-domain and higher-universe domain examples. General universe
inference and Type-valued binders remain outside the current profile.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Closed universe parameter and field bounds

[Closed-universe checking](closed-universe-checking.md) now enforces the declared
Type 0 carrier bounds in constructor arguments and both callable inference paths.
It computes closed imax levels for ordinary/dependent arrows from declared metadata.
Structures check their fields against the stated result universe before publication.
No target, lift or universe is chosen implicitly. The formerly accepted module-carrier
counterexample is rejected by Clean. Fourteen exact native targets, four sort checks
and three proofs cover supported higher-universe values, arrows and proof fields.
General universe polymorphism and Type-valued binders remain separate work.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Authored families in dependent indices

[Family index comparison](family-index-comparison.md) now materializes a residual
binder-bearing normal tree in one checked scope for its comparison key. Authored
family aliases can agree without changing emitted names or introducing direct
binder syntax in indices. Native bodies, binder-body normalization and general
higher-order conversion remain outside this rule. The graded relative-homology
study checks ten exact targets and five proofs; its constructions are authored in
Clean over generic chain-homology adapters.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Stable saved family keys

[Scoped family keys](scoped-family-keys.md) replaces residual binder-template
comparison with immutable owned/free identity tokens. A private, globally fresh
comparison pool covers expression and dependent type binders; nested comparisons
preserve external binding references and restore allocation context on failure.
Unrelated later locals no longer invalidate saved family indices. Emitted Lean and
existing conversion boundaries remain unchanged. Two exact saved-map propositions
and two proofs cover graded chain and relative homology.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Constant dependent arrows and zigzag bases

[Constant dependent arrows](constant-dependent-arrows.md) specifies symmetric
comparison and callable matching when a checked dependent codomain becomes
constant, while retaining the declared Lean Pi binder. Opaque binder-bearing
producer projections retain their checked form unless a field can be selected.
The [zigzag study](../studies/zigzag-bases/README.md) supplies actual module
diagrams and interval-basis data, with a constructed constant-zigzag example.
Inferred type-parameter helpers avoid new type-as-value syntax. General pyramid
basis extension, higher-order conversion and universe polymorphism remain pending.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Diagram maps use existing syntax

The [diagram-map study](../studies/diagram-maps/README.md) authors a dependent
vertex-map family, its edge-square commutation condition, and certified identity
and composition records. No grammar, inference or emission rule changed. The
existing constructor/projection reduction rule selects component families from
explicit certified producers; exact native oracles preserve that target choice.
Evidence is explicit, with universal identity/composition conditions proved in
Lean. Fifteen exact targets and six proofs cover this interface; it is not an
automatically generated category instance or a pyramid construction.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Shape maps and explicit endpoint transport

The [shape-pullback study](../studies/shape-pullbacks/README.md) uses existing
dependent proof fields, equality adapters and module-declared calls. Shape identity,
composition and diagram reindexing are authored in Clean; the only new native
primitives are Eq.symm, Eq.trans and module-family transport via Mathlib eqToHom.
No grammar, inference or emission rule changed. Twenty-four independent exact
targets and nine proofs cover the interface, including pullback composition.

Short calls infer Type parameters but keep field/shape values explicit. They
retain the existing inferred-body opacity boundary: projected modules from short
and explicit forms may compare differently as computed Clean indices, even when
Lean reduces them to the same module. A negative regression records this open
conversion gap. Arbitrary shape pullbacks do not preserve interval support; actual
subpath restriction needs a chosen inclusion and explicit label reindexing.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Checked inferred arguments in authored conversion

[Inferred-argument conversion](inferred-argument-conversion.md) specifies how
already selected implicit arguments enter hygienic comparison expansion. Named
Type values, type annotations (including dependent types), and natural dimensions
have deterministic source reification. Emitted calls retain the signature
matcher's selected arguments. Compound types used as values remain opaque; this
is not a new type-expression syntax. Native acceptance and full regression status
are recorded in the inferred-conversion study.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Explicit type expressions under development

The [integration draft](type-expressions.md) chooses `type(T)` as an explicit,
case-insensitive expression atom containing existing type syntax. It addresses
concrete carrier arguments needed for finite zigzag restrictions. The initial prototype
was isolated while the previous compiler snapshot completed validation. The draft
records the reserved-word change, Type 0 gate, structural substitution and all
expression-consumer obligations. It is not yet repository-supported syntax.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Explicit type expressions

[Type expressions](type-expressions.md) adds `type(T)` as a case-insensitive
expression atom containing existing type syntax, with one TypeValue tree and the
resolved Type 0 Lean target. `type` is reserved in expression names. The explicit
foundational Type binding moves into the shared types module. Hygienic substitution,
owned binder comparison, automatic condition naming and editor highlighting cover
the new node. Local type definitions and arbitrary computed types remain rejected.
The earlier compound-type-as-value opacity boundary is superseded; full validation
status is recorded in the type-expression study.
:::


:::llm gpt-6 2026-11-07 role=assisted

## Callable evidence integration draft

The [draft contract](callable-evidence.md) keeps existing Call/Apply syntax and
adds scoped condition indices with source-derived callable views for universal
quantification and implication. Named native condition bodies remain opaque.
Function matching recurses under shared fresh binders; it emits the original
proof term without casts or replacement evidence. Captured locals may only be
replaced explicitly. The prototype rejects accidental scope rebinding.

This work is isolated in the subpath study's patch while the preceding compiler
snapshot completes validation. It is not yet repository-supported syntax or a
conformance claim. The 197-test focused run, 21 exact native targets and 15 proofs
are evidence for the draft; full regression, native portfolio and final acceptance
integration remain pending.
:::


:::llm gpt-6 2026-11-07 role=assisted

## Callable evidence prototype integrated

After the preceding compiler passed all 584 tests, the callable-evidence prototype
was integrated with its native fixtures and regression tests. The normative rule
is [scoped callable evidence](callable-evidence.md). The isolated snapshot remains
frozen for the full regression and native portfolio; those checks are still pending.
The historical patch remains in Git history rather than as a second implementation
in the working tree. No full-conformance claim is made by this integration.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Inspect substitution arguments only in call-head position

Callable-evidence classification can unfold authored conditions. Hygienic
substitution now requests that view only for a formal used as a Call head,
including in a type annotation; plain value substitution needs no function view.
All arguments still participate in fresh-name reservation. This implements the
existing positional substitution rule without changing syntax or selected Lean
terms. The subpath arrow performance problem remains open; this optimization is
not evidence that its native validation has completed.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Select the requested producer field during comparison

Normalize a checked producer projection by selecting its field through authored
Equals wrappers before expanding sibling fields. The existing whole-base route
repeatedly unfolded transported diagram arrows even when only the object family
was needed. Selection reuses checked implicit arguments and hygienic substitution;
its exact ordering and type gates are specified in the hygienic-conversion document.
No expression cache is added and emitted Lean projections stay unchanged. The
subpath oracle now passes nineteen canonical targets and six proofs; the prior
slow executions are superseded, not recorded as successful. Full-suite validation
of this change remains pending.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Explicit binary-operator migration prototype

Use Infix metadata to connect an ordinary named notation to an existing binary
symbol in the isolated prototype. Keep parsing independent of overload matching;
require exactly one matching declaration and propagate unfinished candidates.
Do not retain built-in fallback behavior for missing binary bindings. The
[module-operator draft](module-operators.md) records the remaining literal,
dependent-signature, precedence and module-scope gates. This is not main syntax
or a completed one-semantic-space migration.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Dependent operator candidates

Extend the isolated Infix prototype using the existing dependent-call matcher.
Tag direct signature mismatches with the current candidate attempt, discard only
those mismatches, and propagate nested or unfinished analysis. Preserve successful
checked results through unique-candidate selection. Matrix/vector and scalar
operations use declared signatures, with explicit inferred dimensions and no
Matrix/Vector display-name dispatch. Fifteen exact targets and two proofs pass;
literals, declared fixity, module-owned scope and the wider dependent-overload
audit remain integration gates.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Guard operator-dependent authored expansion

The isolated prototype records visible binary-operator declaration identities
before publishing an authored definition's own binding. If the visible set changes,
retain its wrapper during comparison and producer reduction. Do not re-expand an
already checked body under newly ambiguous operator meanings. The scope snapshot
is insensitive to candidate order. This is a conservative opacity boundary;
stable typed binding identities and independent module imports remain required.
Sixteen exact targets and two proofs pass, including the original authored body.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Keep instantiated codomains in the caller's scope

The restricted-interval-label construction exposed a second substitution of
already-instantiated proof-family codomains. Once implicit arguments are known,
use known-type comparison under the shared fresh binder; do not substitute the
declaration's parameters again. Preserve caller names in inserted functions and
compound type arguments. Keep unresolved inference as an explicit remaining audit
boundary. Clipped label records and their ordering evidence are authored in Clean;
only natural-order operations and Fin order views are foundational Lean adapters.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Chained applications use one postfix fold

Use one shared name production and fold argument-list/field suffixes from left to
right. A multiword reference requires its first argument list in the same atom's
suffix chain. A separate multiword grammar conflicted with assumption-label names
and was rejected by strict generation. Preserve old Call trees for named calls;
use existing Apply trees for returned functions. Check one determined function
argument per Apply, retaining its exact term and dependent result substitution.
Proof-index spelling may preserve applied functions containing binders, without
adding reduction inside their bodies. The [contract](postfix-applications.md)
records the acceptance evidence and remaining boundaries.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Keep alias descriptions outside semantic types

Freeze the outer authored alias's instantiated prose on each typed statement
clause. Keep its type fully expanded, including for equality, inference and Lean
emission. Distinct aliases of the same type may describe it differently. Missing
singular/plural wording falls back rather than inheriting an inner alias's label.
If context pruning drops a presentation dependency, use expanded-type prose;
never introduce Lean binders to preserve a description. The conservative scope
rule and exact-target checks are specified in alias-descriptions.md.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Compare substituted conditions without changing their emitted terms

Classical witness extraction exposed a beta redex under an existential binder.
Selecting a witness with a universally quantified property also requires an
applied function body containing binders. Use the existing hygienic substitution
for checked literal applications in proof-condition comparison. Keep unapplied
lambda bodies opaque and retain the authored Lean term. Do not broaden ordinary
computed indices or use extensional equality. Explicit choice wrappers expose
Lean's noncomputable foundation; set-specific helpers are authored in Clean.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Keep checked-subtree reuse inside a fresh traversal

Retain typed call arguments as nonsemantic metadata, trusted only when comparison
has just elaborated the call in its current scope. Public entries and stored local
definitions do not carry that freshness witness. Compare complete argument terms,
types, inferred metadata and presentation before retaining a checked call; changed
arguments take the ordinary recheck path. The freshness audit and preservation
argument are in fresh-checked-subtrees.md. This replaces repeated work without
adopting the rejected cross-scope tree-only reuse rule.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Keep inference patterns in declaration scope throughout matching

The earlier instantiated-codomain safeguard was conditional on all implicit
parameters being known. An unrelated later implicit parameter exposed the same
capture bug: valid caller evidence was rejected and incorrect evidence accepted.
Keep expected patterns in declaration scope, carry dependent-binder renamings
separately, and substitute at comparison leaves exactly once. Actual codomains
remain caller-scoped. Preserve structural inference order, escape rejection, and
emitted calls. The normative rule and independent regression are linked from
[source-pattern-matching.md](source-pattern-matching.md).
:::

:::llm gpt-6 2026-11-07 role=assisted

## Cache comparison-pool environment tokens without semantic reuse

Reuse only the frozen identifier union of an exactly equal immutable snapshot of
all environment string leaves, including dictionary keys. Rescan trees and locals;
keep mutable pool allocation state private. The preservation argument and bounded
validation are in [comparison-token-cache.md](comparison-token-cache.md). This
optimization changes no syntax or translation rule and does not discharge the
remaining broad conformance checks.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Extend the isolated operator migration to prefixes

Use `Prefix: -` or `Prefix: not` (also `¬`) on one-operand declarations, parallel
to Infix. Keep the existing source grammar and share exhaustive candidate selection;
no mathematical unary fallback is allowed in the prototype. Include prefix bindings
in authored-body scope guards and route comparison normalization through them.
Constructor mismatch diagnostics must not elaborate uninferred indices. The full
contract remains in module-operators.md; this does not enable metadata in main
or close numeral, declared-fixity, scope and foundation migration gates.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Carry synchronous freshness into proof-condition comparison

Retain binary operands as nonsemantic checked children, and pass an internal
freshness witness from immediate proof-condition elaboration into comparison.
Public calls and stored local values still recheck current scope. Beta preparation
preserves freshness only by retaining checked input or checking its replacement.
The audited call sites and preservation argument are in
[fresh-condition-comparison.md](fresh-condition-comparison.md). No source syntax,
normalization rule, emitted term or cross-invocation cache is added.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Retain statement environments across later declarations

Implement D45's sequential Clean visibility by retaining an environment snapshot
at each top-level Result/Context and sharing it until the next declaration/import.
Use it for statement checking and rendering, including attribution. A later global
type name must not replace an earlier local carrier during output. Preserve the
existing final native-import/declaration collection; do not claim native isolation
from these snapshots. The full constructive rule and remaining boundary are in
[sequential-scope.md](sequential-scope.md).
:::

:::llm gpt-6 2026-11-07 role=assisted

## Prototype closed-universe carrier fields before wider universe inference

Use ordinary ordered `Let carrier: Type` fields with explicit `Universe: 1` (or
another sufficient declared closed universe). Admit existing field-reference syntax
in type positions through one neutral parse. Retain checked projected carriers as
scoped dependent type indices and keep explicit carrier access. The isolated
prototype and exact targets are linked from [carrier-fields.md](carrier-fields.md).
Main integration and full consumer/universe audits remain open; no automatic carrier
coercion or general universe inference is introduced.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Preserve resolved callable heads in stored computed indices

Prototype an internal module-call identity distinct from applications of local function
parameters. Substitution must not resolve a module head again in caller locals. The
[isolated repair](../studies/carrier-fields/BoundCalls.md) specifies the constructive
rule, consumer changes and remaining structural type/proof-index gaps. No new source
syntax is introduced. This experiment does not replace the broader module-owned
identity requirement or authorize dropping unsupported annotations from the final language.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Resolve callable heads in saved proof conditions

Extend the isolated bound-call representation to ProofIndex storage. Resolve bodies
of quantified conditions in lexical scopes extended by checked binder types. Preserve
module targets through proof substitution and callable views; retain local function
parameters as substitutable references. The [proof-binding study](../studies/carrier-fields/ProofBindings.md)
specifies the rule and native evidence. Structural annotation storage remains required
before integration; unsupported annotation calls are not an approved final limitation.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Preserve semantic types inside stored annotations

The isolated [annotation extension](../studies/carrier-fields/AnnotatedTypes.md) stores
checked Type objects and free local references alongside display spelling. Substitute
those semantic objects and reconnect their locals before emission; never reconstruct
their meaning from display text in a different scope. Computed/proof indices retain an
authoritative resolved tree. Source JSON alone is not a semantic serialization. This
removes the earlier nested-call rejection in the isolated stack, while module/type-head
identity, operator composition and full conformance remain open.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Freeze operator selection before declaration publication

In the [composed operator prototype](../studies/carrier-fields/BoundOperators.md),
retain the selected adapter/template in saved expressions and keep source fixity/token
as presentation metadata. Check and bind an authored body before adding its own
operator candidate. Condition uses the same optional Infix/Prefix fields and arity
validation as other callables. Callable proof views follow authored mathematical
meaning, not the operator token: implication is a Clean forall definition. This remains
isolated pending foundation/literal migration and declaration-identity conformance.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Gate integration on local versus module type identity

Record the reproducible [type-identity failure](../studies/type-identity/README.md)
before modifying the semantic representation. Preserve lexical type parameters
and declaration-scoped module types as distinct identities through matching,
substitution and emission. A rendering-only patch or a prohibition on colliding
display names would not repair stored module references. Exact identity allocation,
alias-template substitution and serialization remain design work; this decision
does not claim the full repair is specified or implemented.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Prototype local carrier references and semantic alias substitution

Use a distinct local type representation carrying the selected Lean binder in the
[isolated repair](../studies/type-identity/Prototype.md). Resolve locals before
module aliases; substitute only local type parameters. Store checked alias bodies
and parameter telescopes rather than recovering their meaning from formatted
source strings. Retain semantic annotations when reifying inferred types. This
repairs the demonstrated counterexamples without claiming full module-owned
identity, opaque native-template hygiene or main integration.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Bind opaque native type adapters once

Prototype references to root-qualified generated type abbreviations rather than
inlining their Means bodies. Check each adapter body independently as well as its
uses. Abbreviation transparency preserves Mathlib instance synthesis. Keep the
existing declared arrow protocol structural so its proof and higher-sort arguments
do not pass through a Type-0-only helper. The [native binding study](../studies/native-type-bindings/README.md)
records the constructive rule, capture regression and oracle migration boundary.
This does not establish native import isolation or finish the callable/record
reference audit.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Qualify all generated callable and record references

In the isolated [global-binding repair](../studies/qualified-globals/README.md),
keep declaration-table keys bare and emit `_root_` references for their uses,
including constructor bodies and dependent field types. Expose the callable key
as metadata instead of recovering it from rendered text. Preserve local call
semantics. Deliberate collisions must not change authored definition bodies or
statement targets. Operator composition and source-binder escaping remain separate
integration obligations.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Compose operator selection with binding identity

The isolated [operator integration study](../studies/operator-integration/README.md)
combines declared operators with the seven binding repairs. A concrete module type
cannot match a same-spelled local carrier. Known sort mismatches reject only the
candidate; incomplete checks and foreign dependent mismatches propagate. Selection
requires exactly one applicable declaration, independent of candidate order.
Retained ModuleCalls keep their selected root-qualified target and presentation.
The neutral grammar still determines the parse before candidate checking.
Twenty-six exact targets and four proofs cover this slice. Production integration,
explicit foundation migration, numeric literals and broader operator/corpus
oracles remain pending; earlier built-in regression counts do not apply here.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Integrate binding repairs

The working compiler now implements the seven repairs through qualified globals.
[Binding integration](binding-integration.md) records their constructive rules and
validation boundaries: carrier-field type projections, retained module/proof calls,
semantic annotations, distinct local type parameters, checked alias bodies,
declaration-scoped native type abbreviations and root-qualified generated globals.
These supersede earlier statements above that the repairs are only isolated.
Canonical target changes require explicit oracle migration. Declared operators
and numeric-literal policy remain separate, unfinished integration work. Full
regression/study validation and general identity/import isolation remain open.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Use the existing freshness witness for retained module calls

[Retained-call comparison](fresh-bound-call-comparison.md) now uses the same
unchanged-argument guard as ordinary calls. Validate retained declaration identity
on both paths. Public inputs do not gain freshness from stored metadata, and
incomplete analysis still propagates. This is an implementation correction under
the existing parse and Lean-target rules, not permission for broader semantic
memoization or first-success inference. Full stress validation remains pending.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Preserve exact binding oracles and structural index diagnostics

After binding integration, map expected native type/callable identifiers explicitly
and check adapter bodies independently. Keep local types distinct from module
heads and retained ModuleCall targets explicit in tree expectations. Run the
existing no-binders check before closing noncondition index call heads so the
specified rejection is not obscured by an internal closure diagnostic. See
[binding oracle migration](binding-oracle-migration.md). This changes no accepted
source form or canonical target rule.
:::

:::llm gpt-6 2026-11-07 role=assisted

The [module numeral draft](module-numerals.md) proposes a carrier-owned Numerals
adapter and explicitly typed integer atoms as a first migration step. It is not
accepted as conforming. Its isolated study now checks the grammar, ASCII validation and declaration-owned
native adapters and explicitly annotated applications. Bound numeral atoms retain
the selected identity through substitution and comparison; the draft specifies
the consumer and rendering rules. Full integration and complete native isolation
remain pending, as does broader type-position numeral inference; defaults have
an isolated prototype below. The historical display-name-based
Natural default is not the final architecture.
:::

:::llm gpt-6 2026-11-07 role=assisted

The [contextual numeral completion rule](numeral-inference.md) defines exhaustive
closed-carrier assignment for expression-position numerals. It parses once,
checks all assignments, accepts exactly one, and propagates incomplete analysis
and unowned errors. Declared return types constrain definition bodies. Inferred
numerals retain their selected constructor while rendering without an explicit
type annotation. This is isolated implementation evidence; default integration, type-position
migration, native isolation and main integration remain open.
:::

:::llm gpt-6 2026-11-07 role=assisted

The [explicit numeral default rule](numeral-defaults.md) adds the top-level
`Default numerals: Counting` declaration. Imports combine equal canonical
bindings idempotently and reject conflicts. Completion checks every assignment
before applying simultaneous default restrictions; it never overrides determined
types or incomplete analysis. Defaulted atoms retain their constructor and render
with visible type annotations. This is isolated implementation, with main
integration and broader native/type-position obligations still pending.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Retain checked numeral children when closing operators

The [current-base integration](../studies/current-operator-integration/README.md)
combines declared operators and numeral completion with the current binding repairs.
Operator closure recursively binds checked children, never the raw source digits.
An unresolved Decimal at the closure boundary is an error; it must be elaborated
first. This preserves the selected constructor across subsequent default scopes.
The combined patch is reviewable separately while explicit library migration is
pending; it does not change the working compiler yet.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [inferred value parameter proposal](inferred-value-parameters.md) records a
newly exposed topology requirement: binary equality of parameterized Type-1
modules/chain complexes needs the field structure inferred from operand types.
Current implicit parameters remain restricted to Type and Natural. The proposal
keeps existing syntax and specifies direct-index recovery, telescope type checks,
repeated-index agreement, deterministic representation selection and explicit Lean
arguments. It is not implemented or accepted as conforming; its canonical and
interaction checks are pending in the acceptance catalog. This does not add
general universe/sort polymorphism or implicit proof search.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [inferred-value parameter rule](inferred-value-parameters.md) now has a working
implementation. A typed Let absent from a callable header may bind a value when
it precedes explicit operands and occurs directly in an operand's type index.
The matcher recovers the first agreed index in the specified traversal, checks
its dependent type, rechecks the full operand telescope and supplies every Lean
argument explicitly. It does not invert computed patterns or search for proofs.
Type/Natural inference retains its previous representation rule. Existing fresh
binder restrictions remain in force. Syntax productions, layout and highlighting
are unchanged; the acceptance catalog records the new semantic slice and its
remaining conformance obligations. Explicit same-module and same-chain-complex
operators now use this capability in the algebra modules.
:::

:::llm gpt-6 2026-11-10 role=assisted

[Retained comparison after later operators](retained-comparison-scope.md) corrects
three retained-body scope gates and aligns direct operator operands with named
calls at the hidden-binder boundary. A checked retained body remains available
after later operator declarations for named calls and eligible record projection;
identity validation and existing shadowing/opacity rules still apply. A normalized
operand containing a binder is not published as a new authored call argument.
No grammar or native unfolding rule changes. Focused evidence and outstanding
full validation are recorded in the report and acceptance catalog.
:::

:::llm gpt-6 2026-11-10 role=assisted

[Condition-index inference](../studies/inferred-conditions/README.md) extends the
specified direct-index rule to a proof type whose formal condition is exactly a
retained local implicit parameter. The actual condition is rechecked with the
binder-aware proof-index rules, must have the declared type, and is supplied
explicitly in the Lean target. Repeated occurrences agree and retain the first
representation; computed formal conditions are not inverted. The isolated patch
adds an explicit proof-equality module and authors implication as a universal
condition over evidence, using existing syntax. No display-name or arrow-token
semantic dispatch is added. Production integration and broader regression remain
pending; focused and canonical results are recorded in the study.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [condition-inference slice](../studies/inferred-conditions/README.md) is now
integrated. A formal proof-condition index that is exactly a local implicit
parameter recovers the actual checked condition, including quantified conditions.
The caller's scope and declared parameter type are rechecked; repeated occurrences
must agree, the first agreed representation is emitted explicitly, and computed
formal conditions are not inverted. The explicit `logic/proof_equality.clean`
module declares equality of evidence. Standard implication is now authored in
Clean as universal quantification over evidence, using the existing callable view.
No grammar, layout, highlighting, display-name dispatch or proof search is added.
Full conformance and the remaining native isolation/universe obligations stay open.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [local numeral-search experiment](../studies/numeral-pruning/README.md)
proposes exhaustive child-assignment pruning before parent combinations. It
preserves all viable child interpretations and applies defaults only to complete
root solutions. Binder regions remain atomic. The resource boundary becomes a
fixed limit on local combinations at each search node; unfinished checks still
propagate as incomplete. The study specifies the compositionality assumptions
and unresolved interaction checks. It also authors finite-vertex order using
natural coordinate order. Neither change is integrated; source grammar and
highlighting are unchanged.
:::

:::llm gpt-6 2026-11-10 role=assisted

[Projection dependency closure](../studies/projection-dependencies/README.md)
proposes instantiating only the transitive predecessors needed by a selected
field's checked type. The full structure declaration is still validated; required
carriers, value indices and proof dependencies are substituted in declaration
order. The emitted root-qualified projection is unchanged, and no cross-scope
cache is added. The pinned isolated driver checks 55 tests, four canonical targets
and two proofs independently of numeral pruning. Production integration and
broader annotation/capture/native-isolation obligations remain open.
:::

:::llm gpt-6 2026-11-10 role=assisted

[Projection dependency closure](../studies/projection-dependencies/README.md) is
now integrated. Projection instantiates the selected field and the transitive
predecessors occurring in its checked type, in declaration order. The full
structure telescope remains checked at declaration time; required carrier,
function, value and proof dependencies are retained. The emitted projection and
its argument order are unchanged. No shared caller-scope cache or grammar change
is introduced. Fifty-five focused checks pass on the working compiler. Broader
native/topology/corpus validation and full regression remain pending.
:::

:::llm gpt-6 2026-11-10 role=assisted

## Traversal-local operator operands

A checked condition may reuse its checked operand expressions only during the
same synchronous elaboration in the same environment and local scope. This is
an internal witness, not a property inferred from an Expr having metadata.
Public comparison/index entry points and stored expressions do not acquire it.
For fresh infix/prefix comparison, normalize the checked operands; preserve the
original operand if normalization exposes a hidden binder; then rerun the normal
overload selection on the resulting operands. For nonfresh input, elaborate the
source operands before that process. No operator selection is bypassed.

For fresh condition binding, recursively close checked Call, ModuleCall, Operator
and Unary arguments. A selected operator becomes a retained ModuleCall carrying
its checked name, declaration identity and presentation. Validate retained and
selected identities against the current declaration before retaining them.
Other constructors use the existing checked binding path; entering a binder does
not inherit a witness for a different scope. Public binding still checks source
operators. No cross-call cache is introduced.

The syntax tree, overload policy and emitted Lean term are unchanged. This rule
changes repeated checking, not the set or priority of interpretations. The
existing deterministic traversal and overload-ambiguity checks still apply;
incomplete analyses propagate. Seven freshness tests and 75 related binding,
proof and inference tests pass in isolation. Three independent canonical Lean
condition/evidence targets pass. Full working-checkout validation is pending.
:::

:::llm gpt-6 2026-11-10 role=assisted

## Local exhaustive numeral completion

The [numeral-search rule](../studies/numeral-pruning/README.md#search-rule) is now
integrated. For ordinary expression nodes, enumerate every successful child
assignment in fixed AST order, then check all combinations at the parent. Never
apply child defaults. Child checking receives no contextual expected type under
the current checker; a future bidirectional checker must revisit this pruning
argument. The complete root receives expected-type filtering and simultaneous
default restrictions. Keep every successful assignment, even at the same type.

Binder bodies remain atomic exhaustive regions with their own scope. The fixed
resource limit caps each visited node's local Cartesian product after filtering,
not the raw global assignment count. Exceeding it is incomplete analysis, never
permission to choose a default. Hole-free children are still checked; an invalid
sibling cannot suppress unknown-name or incomplete errors. Only search-owned
signature mismatches eliminate assignments; other errors propagate, and the
previous owner is restored on every exit. The emitted result is a fully rechecked
whole expression. Source parsing, precedence, declared carrier identities and
operator-selection ambiguity rules are unchanged.

The zigzag module separately declares vertex order through natural coordinates.
Its exact wrapper target is checked along with a nine-numeral expression.
Thirteen focused tests, three canonical targets and three proofs pass directly;
broader regression and study validation remain pending. Parameterized literal
carriers and full native environment isolation are not solved by this change.
:::

:::llm gpt-6 2026-11-10 role=assisted

[Parameterized exact literals](parameterized-literals.md) are a proposed next
step for ordinary vector/matrix zero. The design attaches `Literal: 0` to a named
constructor and specifies an explicit-annotation target as a fully applied call
with parameters recovered from its result pattern. It does not add a registry or
special-case type names. The joint constraint/default calculus for unannotated
uses remains an acceptance blocker. This is not implemented or claimed fully
specified; the current closed-carrier numeral rules are unchanged.
:::


:::llm gpt-6 2026-11-10 role=assisted

The proposed [parameterized-literal result-pattern calculus](parameterized-literals.md#determined-carrier-pattern-calculus)
now defines direct parameter recovery, first-occurrence representatives,
telescope-order checking and deferred computed-index obligations. An isolated
symbolic model passes twenty tests. This is design evidence only: production
pattern construction, declaration checking, binding and joint inference remain
unimplemented. No existing Clean syntax or literal interpretation changes.
:::


:::llm gpt-6 2026-11-10 role=assisted

The [contextual family-key experiment](../studies/contextual-family-comparison/README.md)
specifies a proposed comparison-only congruence step: validate the original checked
call shell, retain inferred arguments, and insert child comparison templates without
re-elaborating expanded children as dependent actuals. The ordinary hidden-binder
guard and emitted Lean remain unchanged. This is an isolated prototype, not an
integrated rule; full validation and consumer/resource audits remain pending.
:::


:::llm gpt-6 2026-11-10 role=assisted

The [parameterized-literal selection experiment](parameterized-literals.md#executable-joint-constraint-experiment)
now models finite declaration rows, sorted structural unification, unresolved
competitors and simultaneous defaults. Eighteen new symbolic tests pass. This
clarifies a proposed selection policy; production row extraction, dependent
constraints, resource accounting and canonical target checks remain blockers.
No production literal behavior changes.
:::


:::llm gpt-6 2026-11-10 role=assisted

An [isolated typed-literal experiment](../studies/literal-annotations/README.md)
adds the Literal declaration field and selection for determined annotations. It
regenerates the parser with strict checks and validates explicit vector/matrix
constructor targets. It currently desugars to ordinary retained ModuleCall nodes,
so literal-surface preservation, the full binding snapshot, unannotated inference,
consumer coverage and broader validation remain pending. This is not integrated
or a conformance claim for the full parameterized-literal proposal.
:::


:::llm gpt-6 2026-11-10 role=assisted

The [retained-literal proposal](parameterized-literals.md#retained-literal-representation-proposed-next-step)
now distinguishes saved constructor selection from literal-surface preservation.
It requires all ordered actuals, a checked carrier annotation, origin/spelling,
synchronized substitution and a faithful versioned encoding. A consumer audit is
recorded. The first annotation experiment tests retained-call behavior only. A
[second isolated experiment](../studies/literal-retention/README.md) implements an
in-memory BoundLiteral, preserving annotated spelling and updating constructor
actuals and the checked carrier together during substitution. Its replay checks
the saved declaration rather than reselecting. Portable serialization, a complete
environment snapshot, joint inference and full consumer coverage remain blockers;
production behavior is unchanged.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [retained-literal scope experiment](../studies/literal-retention/README.md#binder-and-record-follow-up)
requires every freshened function/quantifier binder to enter the substitution
scope with its checked domain, including ordinary textual domains. Body annotations
and constructor actuals use that same fresh binder; an unrelated free actual must
remain free. The isolated implementation now checks this rule through dependent
function, quantified condition and record-field examples. Production integration
and the wider acceptance obligations remain pending.
:::

:::llm gpt-6 2026-11-10 role=assisted

The working compiler now uses the [contextual call congruence rule](proof-beta-comparison.md#integrated-contextual-call-congruence).
After fresh checking and ordered normalization, it validates a fixed native call
shell and inserts comparison templates for its explicit arguments. Implicit
arguments and declaration identity stay fixed; the templates are never elaborated
as authored arguments. The existing hidden-binder barrier and emitted expressions
remain unchanged. This resolves the recorded choice-helper comparison boundary;
full regression and broader dependent-context audits remain separate obligations.
:::

:::llm gpt-6 2026-11-10 role=assisted

`library/logic/type_equality.clean` now supplies explicit equality/inequality
conditions on Type-0 carriers. This uses existing condition, Type-parameter and
operator rules; it adds no parser production, universe inference rule or native
special case. See [the carrier-equality contract](type-expressions.md#explicit-carrier-equality-module).
Generic equality on arbitrary higher-universe values remains unsupported.
:::

:::llm gpt-6 2026-11-10 role=assisted

An [isolated reservation optimization](../studies/lazy-comparison-reservation/README.md)
defers the environment-token scan until the first comparison binder allocation.
The fixed-environment comparison contract is unchanged: all environment, tree and
local tokens must be reserved before choosing the first fresh name. For a pool
that allocates no binder, the scan is unnecessary. The study records the equivalence
argument and collision/count tests; production remains eager pending integration.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [retained-value codec experiment](../studies/bound-tree-codec/README.md#version-1-data-contract)
uses a versioned envelope and closed explicit record tags to preserve checked
annotations, local/module type distinctions, retained indices and captured scopes.
It is an isolated data representation, not a new source grammar or an environment
loader. Decoding grants no freshness or validity: restored trees must be checked
against the explicit environment. Integration into index storage remains pending.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [isolated index-storage boundary](../studies/bound-tree-codec/README.md#index-payload-authority)
now stores versioned checked-tree payloads for computed, dimension and proof
indices. Tree retrieval decodes the payload rather than trusting the optional
`resolved` cache; old raw-list JSON and unsupported versions reject. This makes
payload authority deterministic and preserves checked annotations after cache
removal. Production integration and complete decoded-record validation remain open.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [exact-sequence foundation](../studies/topology/exact-sequences.md) uses existing
explicit modules, dependent records, callable signatures and conditions. `exact(f,g)`
is an authored condition with field and module parameters recovered from map types.
`ModuleSequence.arrow(n)` has domain object(n+1) and codomain object(n); `exact pair
at(field,S,n)` checks the two arrows around object(n+1). `exact sequence interior`
quantifies those pairs and deliberately makes no degree-zero endpoint assertion.
This adds no new syntax or builtin equality/zero/sequence rule. The actual
Mayer–Vietoris construction and proof remain separate mathematical obligations.
:::

:::llm gpt-6 2026-11-10 role=assisted

The separate authored condition `exact sequence ending in zero(field,S)` is
`exact sequence interior(field,S) and onto(S.arrow(0))`. Here `onto(f)` means
that every codomain element has a preimage. It adds exactness at degree zero
without storing a zero object in the sequence record. The explicit zero-map
adapter uses the supplied field instance and Mathlib's zero linear map.
The checked criterion identifies exactness before that map with surjectivity;
interior exactness alone continues to make no endpoint claim.
:::

:::llm gpt-6 2026-11-10 role=assisted

Binary coefficient-module products are explicit imports from
`library/algebra/module_products.clean`. `module product(field,M,N)` has carrier
M × N and is rendered as the binary direct sum. `left inclusion` and `right
projection` have that same declared product as their middle module. Native bodies
install only the supplied field and use Mathlib's product module and linear maps.
The range/kernel and onto conditions remain authored Clean definitions. This
adds no syntax or automatic coercion; the actual Mayer–Vietoris maps remain open.
:::

:::llm gpt-6 2026-11-10 role=assisted

Module-map pairing and merging are explicit Mathlib adapters with different
signatures: pairing shares a domain; merging shares a codomain and adds the two
images. `signed pair(f,g)` is authored in Clean as pairing f with the negative
of g. Its implicit field and module arguments come from checked map types.
The signed-square result uses the supplied equality h ∘ f = k ∘ g to prove
[h,k] ∘ (f,−g) = 0. It asserts composition-to-zero, not exactness. Independent
native targets cover the adapters, authored body and theorem statement.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [named-assumption block prototype](../studies/assumption-blocks/README.md)
specifies one labelled expression beneath `Assume name:` in a Result or Context.
It normalizes to the existing inline assumption before semantic processing;
physical lines do not imply conjunction or a list. Top-level comma lists in this
named block reject; nested call/binder commas retain their ordinary meaning.
The pinned prototype regenerates the strict parser and checks independent trees
and a native target. Production integration remains pending. The study documents
layout, header diagnostic locations, uniqueness and the exact desugaring rule.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [inclusion-induced topology maps](../studies/topology/mayer-vietoris-maps.md)
are authored in `mayer_vietoris_maps.clean` using existing subset, continuous-map,
homology and module-product interfaces. The target is homology of the union,
not implicitly the ambient space. The checked statement asserts composition of
the signed intersection map with the union map is zero for arbitrary subsets.
It does not assert exactness, a connecting map, or excision without hypotheses.
The four new native primitives provide explicit set-containment evidence;
all four mathematical map/module constructions are Clean definitions.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [stable comparison-argument prototype](../studies/stable-comparison-arguments/README.md)
restricts repeated-normalization reuse to freshly checked native-call trees whose
leaves are plain locals without normal expressions or decimals. Authored definitions,
binders, projections, applications and operators remain on the existing path.
The root is still rechecked and normalized, and every materialized call still
validates its declaration identity and native template. The private reuse witness
is synchronous and does not survive the comparison. Production remains unchanged.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [combined language study](../studies/composed-language/README.md) applies the
literal, storage, comparison and named-assumption prototypes together on one
pinned baseline. It regenerates the strict parser and includes cross-feature
examples of retained vector zeros in named/inherited assumption blocks with
dependent record dimensions. These checks validate only the isolated composition;
production integration, full-suite results, stored-record semantic validation and
the remaining universe/native-environment obligations are still pending.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [closed-universe classifier proposal](../studies/universe-classifiers/README.md)
distinguishes the universe of an ordinary object from a declaration whose elements
are carrier types. `Classifies: k` and `type(T : C)` have an isolated syntax prototype;
declaration validation is now prototyped, while carrier elaboration remains pending.
The proposal specifies exact closed levels,
explicit native correspondence, alias identity and ambiguity between classifier
candidates. It audits the current Type-0 assumptions across inference, local types,
dependent fields/callables, conversion and storage. Native feasibility examples
are not translator conformance evidence. General universe polymorphism remains
outside this proposed closed-level mechanism.
:::

:::llm gpt-6 2026-11-10 role=assisted

The closed-universe classifier study now includes isolated declaration validation
and a resolved metadata query. Classifies requires a closed declaration, explicit
successor Universe, the corresponding primitive Type body and no Numerals.
Transparent aliases preserve the native classifier identity; ordinary types do
not become classifiers because of their name or universe. Three independent
native declaration targets cover levels 0–2. Carrier binding, type-value
elaboration, inference, storage and production integration remain pending.
:::

:::llm gpt-6 2026-11-10 role=assisted

The classifier study now prototypes generic implicit carrier arguments at closed
higher universes. Local carriers retain level and classifier identity; matching
requires the exact declared level, substitution checks it, and comparison keys
preserve it. A checked topology specimen uses generic retain/equality operations
and a Clean-authored composition, with five exact native targets and a reflexivity
proof. A document-token omission for Classifies was discovered and repaired.
Explicit carrier arguments, higher computed carriers, type values, dependent
carrier fields/callables and storage migration remain incomplete; this is isolated
validation, not production integration or full classifier conformance.
:::

:::llm gpt-6 2026-11-10 role=assisted

Classifier fixture migration remains isolated from the production compiler. Four
manual LocalType regression fixtures now supply their level and classifier identity;
nine study foundations explicitly declare Classifies: 0. Existing assertions are
preserved. Wrapper-aware foundation, saved-expression and dispatch oracles pass
on the migrated stack. Older native-type/qualified-global scripts lack explicit
equality imports, and the older bound-operator script has pre-wrapper oracles;
these failures also occur on their checked baselines and are not classifier passes.
Full regression on the latest fixture set remains unestablished.
:::

:::llm gpt-6 2026-11-10 role=assisted

The classifier prototype now accepts explicit local carrier arguments. Callable
parameter types resolve through declared metadata, including arbitrarily named
level-zero classifiers. Both explicit and implicit generic parameters lower to
primitive Type k; ordinary theorem binders and declared return types retain their
native wrappers. Explicit arguments must have the selected classifier identity,
and later arguments must inhabit the supplied carrier. This changes the canonical
domain of old explicit Type parameters; two independent dispatch oracles are
migrated accordingly. First-class higher type expressions, inferred higher-type
reification, dependent carrier fields/callables and storage remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

The classifier study now elaborates type(T : C) and type(T) in isolation. Explicit
selection requires a closed declared classifier at T's exact level; unannotated
selection enumerates and alias-deduplicates all visible classifiers at that level,
requiring exactly one without expected-type or order-based selection. BoundTypeValue
retains checked carrier/classifier annotations, a classifier declaration snapshot,
and presentation. Replay validates that identity without reselection; substitution
changes only the carrier annotation. Reification of an inferred carrier uses its
formal declared classifier. Explicit LaTeX retains the classifier annotation.
See studies/universe-classifiers/type-values.md for the constructive mapping,
consumer audit and native oracles. Plain JSON replay without checked annotations
rejects; codec migration, higher carrier fields/callables and integration remain
pending. These language checks do not prove missing paper theorems.
:::

:::llm gpt-6 2026-11-11 role=assisted

Classifier prototype refinement: dependent-call substitution reifies inferred
carrier arguments with their formal declared classifier before substituting into
value indices, computed indices and dependent callable types. Explicit actuals
and inner scope bindings override inferred bindings; direct carrier positions
retain Type substitution. Visible competing classifiers do not change this rule.
Retained carrier annotations must account for all free references, and those
references must remain in scope; the retained classifier annotation is closed.
These checks are implemented in the isolated type-values patch, not production.
:::

:::llm gpt-6 2026-11-11 role=assisted

The isolated classifier/storage composition uses clean-bound-tree version 2.
LocalType encodes its universe and classifier identity explicitly; version 1
rejects without an environment-based migration fallback. BoundTypeValue retains
its checked annotations and tuple snapshot through the existing tagged encoding.
Stored index payloads are authoritative over cached trees and must be re-elaborated.
See studies/universe-classifiers/storage.md for the schema and validation boundary.
This does not change production storage or claim full environment freshness.
:::

:::llm gpt-6 2026-11-11 role=assisted

The optional classifier/carrier-binder composition accepts existing dependent
function syntax with a declared classifier domain. A type binder retains the
classifier identity and level in LocalType; application substitutes only a
matching checked carrier. Function domains retain their declared wrappers, and
alpha comparison, fresh binder allocation and capture avoidance use the existing
rules. Callable signatures containing DependentFunctionType always use structural
dispatch, even without value indices. No grammar or token change is introduced.
See studies/universe-classifiers/carrier-binders.md for the constructive rule,
independent syntax/native evidence and remaining limits. Production is unchanged.
:::

:::llm gpt-6 2026-11-11 role=assisted

The optional computed-carrier composition extends existing carrier-expression
semantics to every declared closed classifier level. ComputedCarrier explicitly
stores its checked index, level and classifier identity. Substitution elaborates
the substituted index and checks that identity before extracting the carrier;
annotation validation also rejects a stale stored native target. Record projection
detects preceding carrier fields by classifier metadata, not the name Type.
Version-3 payloads encode this record explicitly; older versions reject. See
studies/universe-classifiers/computed-carriers.md for the exact constructive rule,
schema and independent native checks. Production and general record-parameter
inference remain outside this isolated extension.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Current compiler integration

The working compiler now implements the literal/assumption/classifier/carrier
rules described in the preceding isolated-study updates, including version-3
stored index payloads. Their earlier deployment labels are historical. See
[language-integration.md](language-integration.md) for installed scope, conflict
resolutions, validation evidence and remaining obligations.

Literal constructor arguments recovered from target types use each formal
parameter's declared classifier when reified, both on initial selection and on
retained replay. They do not rerun visible-classifier selection. A type annotation
on fresh type(T) still cannot select among competing classifiers. The independent
cross-feature regression and payload tests fix this distinction explicitly.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Payload schema version 4

Version 4 supersedes version 3 in the working compiler. The stored Expr schema
omits checked_args, and stored computed/dimension/proof indices omit resolved.
Those fields are disposable caches and decode to None. All other semantic fields
remain; older versions and explicitly supplied removed fields reject. Encoding
never traverses the omitted caches. See [payload-cache-policy.md](payload-cache-policy.md)
for the deterministic representation rule, tests and remaining performance limits.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Reuse immediately checked index operands

Index construction may reuse operands immediately elaborated in the same explicit
module environment and local scope. The internal freshness witness is passed only
by substituted-index construction and the checked value-index type-argument path.
Dimension validation, retained callable identities, and comparison normalization
remain mandatory. Public index construction defaults to rechecking the source;
stored metadata and disposable caches never provide this witness. No parse,
inference rule, persisted schema, or intended Lean target changes. See
[active-label-performance.md](active-label-performance.md) for validation status.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Already-normalized native operator children

Within one contextual-comparison traversal, a freshly normalized native operator
or prefix application is stable when its retained binding identity still matches,
its declaration is not Clean-authored with `Equals`, and every checked child is
stable. Freshly checked numeral leaves are stable too. Such a subtree goes directly
to comparison emission without another normalization traversal. Emission still
checks the binding and exact native call template. Local definitions, authored
calls, unchecked expressions, and restored caches do not establish stability.
Public comparison re-elaborates its source under the current explicit environment.
This is a work-reuse rule, not a grammar, inference, or Lean-target change.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Actual-index reuse within one dependent call

A dependent call can retain a constructed explicit-argument index for later
occurrences of the same formal parameter within that call. Reuse requires an
empty shared-binder scope, exactly the entry local names and objects, and the same
comparison pool with unchanged owned identities. The original objects are held
strongly for the call's lifetime. Construction must also leave the pool unchanged
before an entry is stored. Temporary binder scopes and pool allocations bypass
reuse. Substitution-dependent and computed formal indices are not cached by this
rule. Declaration data remain fixed during synchronous matching; the cache is
local to that invocation and is discarded on return or error.

The first occurrence still performs full public index construction. A subsequent
call, even with identical source spelling, constructs its indices afresh. Nothing
is persisted or inferred from stored caches. Grammar, ambiguity rejection and
intended Lean targets are unchanged. See [active-label-performance.md](active-label-performance.md)
for focused and native validation status.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Classified record and type-constructor parameters

Generic carrier parameters of records, native type constructors and aliases are
selected by their declared classifier metadata, including higher closed levels
and renamed classifiers. The formal slot fixes the level; visible-classifier
search is not used. Generic binders emit Type k, and arguments and stored fields
retain explicit universe checks. Existing grammar is unchanged. See the
[classified-parameter contract](classified-parameters.md) for syntax trees,
constructive translation, arrow compatibility boundary and validation limits.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Quoted native result identifiers

Emit every normalized result identifier as a quoted Lean identifier, preserving
its Name and namespace rather than renaming keywords. This fixes accepted titles
such as `Result example`. Title parsing, normalization/collision rejection and
LaTeX display remain unchanged. See [result-identifiers.md](result-identifiers.md)
for the constructive lexical rule, native oracles and remaining binder audit.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Quoted source binders and references

User-written statement binders, local definitions and declaration parameters now
emit the same quoted Lean identifier at binding and reference sites. Scope keys,
source trees, normalized names and LaTeX labels are unchanged. Opaque native
payloads are not rewritten. See [binder-identifiers.md](binder-identifiers.md) for
the constructive rule, identifier audit, native checks and hash migration note.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Comparison reuse within one synchronous scope

Nested comparisons may reuse checked results within their shared binder pool,
under fixed declarations, exact semantic source/type/local snapshots and unchanged
owned identities. No allocation-producing comparison is stored. Cache eviction
and the atomic-expression exclusion affect work only. Public comparisons retain
fresh validation. See [comparison-reuse.md](comparison-reuse.md) for the precise
preconditions, unchanged target rule, tests and pending performance evidence.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Explicit standard zero constructors

The linear algebra module imports four module-declared exact zero attachments
for real/complex vectors and rectangular matrices. Determined annotations select
them by the existing retained-literal rule; no type-name dispatch or new syntax
is introduced. [Standard zeros](standard-zeros.md) records constructive targets,
ambiguity checks and the still-open unannotated inference requirement.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Joint literal inference remains experimental

The source-to-row adapter under `studies/parameterized-literals` now exercises
real declarations and retained native targets. Production inference is unchanged.
The experiment preserves the rule that expected results cannot resolve an
operator input-signature tie and gathers caller representatives before enumerating
candidate declarations. Its [construction and remaining obligations](../studies/parameterized-literals/README.md#rows-from-actual-clean-declarations)
are a proposed extension, not an accepted full language rule.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental default-origin trace

Joint selection records the literal positions restricted by the simultaneous
pre-default solution analysis. The experimental materializer preserves these
positions as `defaulted` retained nodes and marks context-forced holes `inferred`.
The native constructor is unchanged by this presentation metadata. The
[trace contract](../studies/parameterized-literals/README.md#retaining-default-origins)
and replay checks do not change production inference or resolve the remaining
general dependent-constraint obligations.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Declaration-time callable signatures

The compiler now retains the checked parameter types, their visibility and
classifier identities, and the result type when a notation, definition, condition
or structure constructor is declared. This is internal metadata, not new syntax.
The experimental joint-literal adapter consumes it; production call elaboration
and retained-literal serialization are unchanged.

For each typed Let group, resolve its type in the preceding scope exactly once,
then bind every name in the group to that checked type. Capture parameters in
scope insertion order. In notation declarations, header parameters are explicit
and preceding non-header parameters implicit; generated constructors make all
parameters explicit. A classifier descriptor is the existing resolved native
classifier identity and universe level, or absent for a value parameter. The
result is the already checked Returns type (or constructed structure type).

For example, with a declared Type-0 classifier Small, `Let Small,T: Small`
binds both names as types. Separate `Let Small: Small` and `Let T: Small`
bind a type and then a value of that type. Re-reading the grouped declaration
as successive independent type strings is incorrect. The corresponding Lean
binder shapes are `(Small T : Type)` and `(Small : Type) (T : Small)`;
these are explanatory expansions, not the actual named wrapper targets.

Consumers require the captured descriptor and validate its source signature,
native binding/template/declaration and classifier metadata. Missing or changed
metadata is an error (incomplete analysis in the experimental adapter), never a
request to reinterpret source text. This does not deeply freeze retained type
graphs or support arbitrary environment mutation: declarations remain fixed
during checking. The descriptor is not a persistence or security boundary.

There is no new parse choice or Lean target choice: capture records the output
of the existing declaration rules, and row variables use its native identity,
parameter name and expression path. The experiment still needs general dependent
constraints, candidate validity checking and production integration. Constructor
telescopes can now be inspected uniformly; general constructor row materialization
is not claimed.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental constructor inference

The joint-literal study now builds constructor rows from checked signatures and
existing nominal structure identities. Known caller locals/retained numerals
supply checked index comparison keys and representatives collected before
candidate enumeration. This preserves local alias spelling without using spelling
as semantic equality. The constructive rule, examples and unresolved dependent
cases are recorded in the [study contract](../studies/parameterized-literals/README.md#constructor-rows-and-caller-index-values).
There is no grammar or production elaboration change; general joint inference
remains experimental.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental literal-valued indices

Selected scalar numerals can supply checked representatives for dependent
constructor indices in the joint-inference study. Scalar row values use checked
index-comparison keys. Representatives are added only after unique selection,
in source-hole order after caller evidence; enumeration does not choose spelling.
Explicit annotated numerals also count as known index evidence. See the
[construction and native mapping](../studies/parameterized-literals/README.md#literal-valued-dimensions).
No grammar or production-inference change is implied.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental checked caller expressions

Hole-free caller expressions now supply checked index equations and source
representatives in the joint-literal experiment, including declared calls,
operators and projections. Unsupported checked indices report incomplete analysis;
known values no longer receive unconstrained placeholder variables. Existing
conversion rules decide equality, and enumeration cannot choose representatives.
See the [construction and unresolved-call boundary](../studies/parameterized-literals/README.md#checked-computed-arguments).
Production parsing and inference are unchanged.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental forward deferred constraints

The symbolic inference model has forward-only ground-input obligations. All must
finish before defaults and declaration selection; unresolved checks block analysis
instead of disappearing as mismatches. Results are equations, never inverse
function rules. The [scheduler contract](../studies/parameterized-literals/README.md#forward-deferred-constraint-model)
specifies batching, incomplete-result precedence and budget boundaries. This is
not yet connected to the Clean adapter and introduces no language syntax.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental deferred call reconstruction

The study adapter now creates forward checks for calls whose chosen children have
concrete retained trees. Checks use fixed module identities, validate explicit
values and inferred arguments, and propagate checked result indices. Candidate
checks do not register caller representatives; selected witnesses are rechecked
with correct default-origin metadata. The [construction and limitations](../studies/parameterized-literals/README.md#deferred-calls-in-the-clean-adapter)
define this supported fragment. General candidate validity and production
integration are still pending; no new parse rule is introduced.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Natural dimensions follow declared prefix meanings

Dimension checking no longer rejects a checked Natural value merely because its
source/comparison tree contains unary `-`. Existing input-signature resolution
must yield one declared callable, and its result must be Natural. Missing meanings,
ambiguous overloads and Real results still fail. Store and substitute the resulting
checked index without extra token-based mathematics. The [dimension contract](dimension-indices.md#module-declared-prefix-values-in-dimensions)
specifies the unchanged parse and constructive native mapping. The standard
module still has no Natural prefix-minus declaration.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental projections with literal holes

The joint-literal adapter resolves field declarations through a known nominal
structure and substitutes its symbolic parameters into the checked field type.
Concrete projection witnesses are checked forward; operator ambiguity is audited
inside the base even when projection reduction removes it from the resulting term.
The [construction and boundaries](../studies/parameterized-literals/README.md#projections-from-literal-bearing-records)
cover source traversal and native reduction. Field-value-dependent result types
and unresolved carriers remain incomplete. Parsing and production elaboration
are unchanged.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental constructor field evidence

The literal-inference adapter retains field fragments for direct nominal
constructors and substitutes required preceding-field values into projection
types. Projection values follow the checked constructor reduction rule; nested
constructor evidence is preserved. Opaque record producers do not receive this
evidence. The [construction and remaining bounds](../studies/parameterized-literals/README.md#constructor-field-evidence-for-dependent-projections)
extend the experimental projection slice, with no grammar or production change.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Optional snapshot failure disables reuse within its pool

After the first unavailable semantic snapshot, the transient comparison pool stops
attempting reuse, clears prior entries, and suppresses storage by in-flight outer
comparisons. Ordinary checking continues; a new public comparison has a fresh
pool. This changes optional optimization effort only. The unchanged target rule,
mutation checks and profiling limits are documented in the
[comparison contract](comparison-reuse.md#stop-repeated-unavailable-snapshot-attempts).
:::

:::llm gpt-6 2026-11-11 role=assisted

## Shared graph traversal for reserved names

Fresh-name reservation scans each reachable environment container once and caches
an immutable set of distinct text leaves. Multiplicity, order and sharing do not
change the identifier-token union. Every later scan rereads mutable contents;
identities are traversal bookkeeping only, never semantic cache keys. Grammar,
scope and constructive Lean mapping remain unchanged. See the
[union-preservation argument and validation limits](comparison-token-cache.md).
:::

:::llm gpt-6 2026-11-11 role=assisted

## Fresh operator comparison reuse

A freshly checked prefix or infix expression may be reused within its synchronous
comparison traversal when all normalized operands remain unchanged and the selected
binding identity still matches. Changed operands trigger ordinary selection;
public comparisons re-elaborate source and cannot trust stored operand caches.
There is no grammar or target-rule change. The constructive preservation argument
and validation boundaries are in the [comparison contract](comparison-reuse.md#reusing-a-freshly-checked-operator).
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental computed formal indices

The joint-inference study forward-checks computed callable and field type indices
from concrete candidate argument witnesses after their symbolic inputs are solved.
Selected witnesses preserve literal origins during retained emission. It does not
invert arithmetic or infer missing implicit evidence, and changes no grammar or
production elaboration. See the [constructive mapping and remaining obligations](../studies/parameterized-literals/README.md#forward-evaluation-of-computed-formal-indices).
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental constructor parameter witnesses

Direct constructor fragments now retain parameter arguments alongside field
arguments. A projected computed field type uses these checked witnesses, and a
nested constructor-valued projection carries its own parameter evidence forward.
Opaque record producers gain no such evidence. There is no grammar or production
change. See the [construction and native oracles](../studies/parameterized-literals/README.md#constructor-parameters-in-computed-projection-types).
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental evidence from checked constructors

A hole-free checked direct constructor can supply parameter/field evidence inside
an experimental literal-inference region. Its source arguments are rechecked;
optional child evidence neither creates holes nor changes caller representative
priority. Classifier and unsupported index children remain without value evidence,
and opaque producers are not unfolded. See the [construction and boundaries](../studies/parameterized-literals/README.md#known-constructors-inside-literal-bearing-expressions).
No grammar or production elaboration rule changes.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental checked parameter reconstruction

Selected experimental row parameters now pass through a ground witness resolver
with explicit representative priority, semantic agreement checks, cycle/resource
failure and nominal type assembly. No declaration-selection or grammar rule
changes. A forward-plan model is present but is not yet wired into pre-selection
parameterized literal/call checks. See the [operational rules and integration boundary](../studies/parameterized-literals/README.md#checked-ground-witness-reconstruction).
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental demanded candidate values

Parameterized literals inside dependent calls can now be reconstructed and checked
before selection when their values are demanded by type indices. Ordinary equations
and a conservative demand fixed point determine forward obligations; missing
parameters block defaults with incomplete analysis. Operator auditing uses the
same checks without expected-result constraints. Selected replay preserves origins.
The [operational mapping and stricter experimental boundary](../studies/parameterized-literals/README.md#demanded-candidate-values-before-selection)
record the remaining general-validity gaps. No grammar or production change.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental candidate implicit-argument checks

A reconstructed candidate call must have checked inferred implicit arguments equal
to its solved symbolic arguments. Missing or unresolved arguments are incomplete;
a checked mismatch cannot pass merely because the output value is equal. Dynamic
call/projection readiness includes child/base recovery parameters. The
[operational rule and independent targets](../studies/parameterized-literals/README.md#checking-inferred-arguments-during-candidate-reconstruction)
extend the experimental adapter without changing grammar or production elaboration.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental computed formal-index reconstruction

Computed formal indices can now recover checked literal-valued arguments before
substitution. Readiness follows ground symbolic inputs; substitution produces a
checked output equation, and selected replay verifies the same output and literal
origins. Nominal record parameters may be recovered from a checked type even when
its producer is opaque; unknown field values may not. See the
[constructive mapping and limits](../studies/parameterized-literals/README.md#computed-indices-from-reconstructed-arguments).
This changes the experimental adapter only. Classifier-dependent indices and
production inference remain pending; no grammar change is introduced.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental exact literals with computed result indices

Literal result templates now use forward checked index substitution. Literal
value readiness includes the full result carrier as well as its parameters;
candidate reconstruction and retained emission use the same path-based template
conversion. Carrier contradictions can reject unrelated candidates, but unresolved
computed indices cannot be discarded or solved by defaults. See the
[constructive rule and examples](../studies/parameterized-literals/README.md#computed-result-types-of-exact-literals).
This is experimental; production inference and general candidate validity remain
open. There is no grammar change or implicit mathematical operator behavior.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental determined-literal validity phase

After forward saturation, check each literal application whose parameters and
result carrier are ground, before defaults and selection. Use the existing
retained application/telescope checker; unavailable competing checks remain
incomplete. The operator audit uses the same phase with input constraints only.
Unresolved symbolic families retain the existing policy and are not claimed
universally valid. See the [phase rule and integration gap](../studies/parameterized-literals/README.md#checking-determined-literal-applications-before-selection).
No grammar or production compiler change is made.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental determined-application validity

The post-saturation validity phase now covers calls and projections as well as
literals. Reconstruction plans retain their symbolic result type; determined
applications must elaborate to that type and agree with any solved value index.
Missing checking blocks selection. See the [constructive extension and tests](../studies/parameterized-literals/README.md#checking-determined-calls-and-projections-before-selection).
Unresolved symbolic families and production integration remain open. No syntax
or parsing rule changes.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental type-formal index substitution

Computed index plans may now reconstruct inferred Type-0 carrier formals using
the classifier captured in the checked callable signature. Symbolic formal identity
selects that classifier; ambient classifier search does not. Missing evidence is
incomplete. See the [rule, readable specimen and remaining boundaries](../studies/parameterized-literals/README.md#computed-indices-depending-on-inferred-types).
Higher universes, explicit classifier operands and general symbolic validity
remain open. No parsing or production inference rule changes.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental explicit carrier operands

Checked Type-0 carrier expressions now supply symbolic type terms to dependent
call constraints. Their declared classifier remains part of the operand type;
wrong classifiers are rejected. Static index substitution and direct-constructor
parameter evidence preserve checked carrier expressions. See the
[constructive rules and specimens](../studies/parameterized-literals/README.md#explicit-carrier-operands-in-dependent-inference).
Higher classifiers and general symbolic validity remain open. The parser and
production inference are unchanged.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Fresh projection-base comparison reuse

A comparison traversal may reuse its freshly elaborated projection base for
producer inspection and base normalization in the same fixed scope. It must not
reuse stored payloads across public calls or suppress failed checking. The selected
Lean expression and parsing rules do not change. See the
[rule and measured validation scope](comparison-token-cache.md#projection-base-reuse-2026-11-11).
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental local function inference

Unary local Function calls now constrain literal arguments by their checked
domain and substitute arguments into dependent codomains. Local functions shadow
same-named module callables; nonfunction locals do not. Reconstruction retains
the local call and validates nested selected module calls. See the
[constructive rule and independent expectations](../studies/parameterized-literals/README.md#local-function-calls-in-joint-inference).
General Apply/binder regions and production integration remain open; no syntax
change is introduced.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental inference through application expressions

Apply expressions now combine checked callee domains or inferred nominal Function
carriers with argument constraints. Reconstruction retains the callee expression;
operator auditing and native-choice checks traverse both sides. Checked dependent
callee types use forward substitution. See the
[constructive rule and limitations](../studies/parameterized-literals/README.md#function-valued-expressions-and-application).
Inferred dependent heads, binder regions and production integration remain open.
The existing grammar and parse are unchanged.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental outer binder inference

Materialization of an outer quantifier/lambda chain checks each body under a fresh
local scope and a known body expectation where available. Retained body annotations
are rebound by whole-binder re-elaboration; temporary checking names do not choose
the final Lean binder. See the [scope rule and precise coverage boundary](../studies/parameterized-literals/README.md#outermost-quantifier-and-lambda-inference).
Embedded binders in joint candidate regions and production integration remain
open. This uses the existing grammar without adding syntax.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental symbolic scope admissibility

The constraint model records allowed binder identities on metavariables and free
binder dependencies on rigid atoms. Every unification boundary checks all retained
substitutions, including aliases, for escaping dependencies. Failure is a mismatch;
resource exhaustion is incomplete. See the [constructive model rule and missing lowering work](../studies/parameterized-literals/README.md#scope-admissibility-in-the-symbolic-constraint-model).
The Clean adapter does not yet assign this metadata to embedded binder regions or
abstract dependent function scopes. No syntax or production change is claimed.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental checked binder dependency metadata

Outer binder bodies now attach lexical binder permissions to generated variables
and checked comparison dependencies to rigid terms. Dependency collection includes
implicit arguments and types, not just source spelling; authored normalization can
remove unused dependencies. See the
[construction and witness-rebinding boundary](../studies/parameterized-literals/README.md#checked-binder-dependencies-in-outer-inference-scopes).
Embedded binder abstraction and production integration remain open. No grammar
change is introduced.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental scope availability of retained witnesses

Witness resolution now checks retained-expression availability for every requested
scope, including memo hits. Semantic equality alone does not justify moving a
source expression outside a binder. Missing availability is incomplete; preferred
representation failure does not select another spelling. See the
[resolver contract and Clean-backed example](../studies/parameterized-literals/README.md#availability-of-retained-representatives-across-scopes).
The adapter checks both source dependencies and destination-scope reification for
value indices. Embedded binder constraints and production integration remain open.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental checked dependent function arguments

Fixed checked Type-0 dependent function types now form alpha-canonical rigid atoms
in the experimental inference adapter. Codomain dependency collection opens a
fresh local and discharges only that local; outer dependencies remain. Free
symbolic formals still require unsupported binder constraints. See the
[constructive rule and example](../studies/parameterized-literals/README.md#checked-dependent-functions-as-rigid-carriers).
No grammar or production behavior changes; embedded binder inference remains open.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental inferred dependent function application

Module-call and projection fragments can retain fixed checked dependent signatures
as row-local metadata. Applying such a head constrains its domain and substitutes
the argument value into the codomain with the existing forward index rules. The
retained signature must agree with the symbolic head type; metadata cannot select
a different target. See the
[constructive rule and remaining limitations](../studies/parameterized-literals/README.md#applying-inferred-expressions-with-fixed-dependent-signatures).
Producer-dependent symbolic signatures and embedded lambda inference remain open.
No grammar or production change is claimed.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental dependent signature substitution

Dependent function templates with producer formals now use forward TypePlans:
checked representative substitution yields a rigid alpha-canonical type key.
Inferred applications retain template and formal evidence in their own candidate
row. Assigned candidate checks distinguish owned compiler signature mismatches
from incomplete checking and restore the enclosing trial on every exit. See the
[construction, examples, and unresolved cases](../studies/parameterized-literals/README.md#forward-substitution-into-dependent-function-signatures).
No inverse inference from an opaque type key, embedded lambda support, or
production integration is claimed. Existing grammar is unchanged.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental chained callable signatures

Application results now retain checked callable descriptors through both ordinary
and dependent function layers. Subsequent domain and codomain conversion use the
accumulated formal map; only a dependent layer adds a binding for its argument.
Source grouping remains the existing left-associated postfix grammar. See the
[constructive chain rule and examples](../studies/parameterized-literals/README.md#chained-callable-signatures).
No production or grammar change is claimed; embedded lambda inference remains open.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental symbolic binder representation

The standalone constraint model now distinguishes explicit lexical references,
de Bruijn bound references, and binder nodes. Abstraction preserves outer
references and refuses opaque/contextual dependencies it cannot close. Structural
unification admits scope-independent unknowns under binders while rejecting escape
into metavariable solutions. See the
[constructive rules and precise boundary](../studies/parameterized-literals/README.md#explicit-symbolic-binder-abstraction).
These nodes have no Clean lowering yet and accept no new source syntax. Contextual
metavariables and embedded lambda inference remain open; native regression checks
must not be described as conformance evidence for this representation.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental binder opening and instantiation

The standalone model can instantiate a well-scoped binder with a root-well-scoped
argument and open it using a fresh lexical identity. Nested binder domains and
bodies have distinct depth rules; free argument references remain free. Freshness
includes opaque dependencies and metavariable permission sets. Domain typing is
a separate obligation. See the
[constructive operations and validation boundary](../studies/parameterized-literals/README.md#opening-and-instantiating-symbolic-binders).
No Clean lowering or new source syntax is claimed; contextual metavariables and
embedded lambda inference remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental checked binder-type bridge

A separate codec now maps checked Type-0 dependent types with direct bound indices
to symbolic binders and back. It preserves retained caller-index syntax and checks
constructor telescopes during reconstruction. Typed instantiation checks the
argument domain before substitution. See the
[construction and explicit limits](../studies/parameterized-literals/README.md#checked-binder-type-bridge).
This bridge has independent native targets but is not used by production or joint
inference. The subsequent computed-index bridge below extends this initial slice.
Contextual metavariables and embedded lambda inference remain pending. No new
source syntax is accepted.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental computed bound-index representation

The checked type bridge now represents selected calls, applications, and projections
under binders as retained IndexExpression nodes. Reconstruction checks the selected
operation, operands, result type, and inferred arguments. These nodes are not
assumed injective by structural unification; unequal representations require checked
conversion and remain incomplete in the standalone model. See the
[constructive rules, native targets, and remaining limits](../studies/parameterized-literals/README.md#retained-computed-expressions-under-type-binders).
No production or grammar change is claimed. Embedded lambda inference and broader
bound annotation/literal lowering remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental bound carrier annotations

The binder-type bridge structurally traverses carrier annotations in checked type
values. It retains the selected closed classifier and presentation, reconstructs
free-reference metadata in the destination binder scope, and rechecks the classifier
snapshot and carrier universe. See the
[constructive mapping and limits](../studies/parameterized-literals/README.md#type-values-containing-bound-indices).
The existing source grammar is unchanged. This extends the experimental computed
index representation; it does not integrate joint inference into production.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental bound literal payloads

The checked binder-type bridge exposes retained literal arguments and carrier types
structurally. It preserves the selected declaration snapshot, digits, telescope
visibility and presentation. Reconstruction invokes checked literal replay and
compares inferred arguments and the result carrier. See the
[construction and remaining limits](../studies/parameterized-literals/README.md#literal-payloads-containing-bound-indices).
This changes neither the source grammar nor production literal selection. It does
not license injective decomposition of literal expressions during unification.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental outer parameters under binders

The checked type bridge can replace explicitly mapped caller parameters with
sorted symbolic variables before binder abstraction. It traverses computed formal
references rather than hiding them in opaque atoms. Solving structural binder
constraints can recover outer type/index parameters; checked reconstruction must
validate the result. Scope escape is rejected and computed operations are not
assumed injective. See the
[construction and boundaries](../studies/parameterized-literals/README.md#outer-parameter-constraints-under-dependent-binders).
This connects the representation to the standalone model, not the production or
Clean-row inference path. Contextual metavariables remain unimplemented.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental dependent argument inference

The Clean row experiment derives outer parameter equations from a checked dependent
callable argument using matching binder and nominal type structure. Separate formal
and caller scopes prevent identifier capture. It does not reverse computed operations
or add candidate-provided representatives. The complete substituted function type
remains subject to the existing forward checked obligation. See the
[constructive rule, example and limits](../studies/parameterized-literals/README.md#recovering-parameters-from-dependent-callable-arguments).
This extends the row experiment; production integration, inferred callable arguments
and embedded lambda inference remain pending. No source grammar changes.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental dependent caller-type evidence

Caller evidence collection visits supported dependent domains/bodies and nominal
arguments in fixed type order before candidate enumeration. It stages checked outer
indices/carriers and excludes freshly opened inner references, preserving existing
first-witness priority and scope checks. Candidate matching cannot register these
representatives. See the
[construction and limits](../studies/parameterized-literals/README.md#caller-evidence-inside-dependent-function-types).
This extends experimental row reconstruction, not the production language or grammar.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental dependent producer candidate checking

Before deriving dependent argument constraints, available producer syntax is checked
under the existing owned candidate trial. Only that trial's certified signature
mismatch rejects a row; foreign mismatches and unavailable checking remain incomplete.
The candidate's child equations and full forward type checks are retained, and no
subexpression default is applied. See the
[example and precise boundary](../studies/parameterized-literals/README.md#dependent-arguments-produced-by-candidate-calls).
Production integration and producers lacking reconstructible candidate syntax remain
pending. The source grammar is unchanged.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental deferred producer parameter recovery

When a producer has captured callable metadata but no reconstructed syntax, the row
experiment can defer recovery of consumer parameters until the producer return type's
referenced formals are ground. Checked substitution and structural binder constraints
recover eligible parameters; child equations and full forward checks remain mandatory.
No computed operation is inverted and no producer is independently defaulted. See the
[constructive obligation and examples](../studies/parameterized-literals/README.md#deferred-parameter-recovery-from-producer-return-types).
This is experimental row support; production integration and embedded lambda inference
remain pending. No source grammar changes.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental recovered producer evidence

Deferred parameter recovery can supply checked closed-subtree witnesses from a
substituted producer return type. Matching visits domains before bodies and arguments
left to right; witness plans follow existing index/type plans in captured order.
The resolver preserves prior witness priority, validates scope and semantic agreement,
and reports missing evidence as incomplete. Selected evidence is rechecked before
retention. See the
[constructive rule and oracle](../studies/parameterized-literals/README.md#checked-evidence-for-recovered-producer-parameters).
This is experimental reconstruction support, not production integration or new syntax.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Fresh application comparison children

Apply elaboration retains its checked head followed by arguments in transient
metadata. Only a synchronous traversal's freshness witness permits reuse. Public
comparison rechecks the complete saved application in the current scope, rejects
incompatible changed argument types, and propagates unavailable checking. Metadata
is neither serialized nor used as a semantic snapshot field. Source grammar and
Lean targets are unchanged. See the
[implementation boundary and validation](comparison-token-cache.md#fresh-application-child-reuse).
:::

:::llm gpt-6 2026-11-11 role=assisted

## Nested fresh projection bases

A non-reduced projection retains its checked base as a one-element transient
child tuple. Within the same synchronous comparison traversal, a fresh projection
may reuse that base for producer inspection and recursive normalization. Public
entry must elaborate the stored base tree in the current scope, ignoring saved
children; missing fields and unavailable checks propagate. Constructor reductions
retain their existing behavior. No parsing, target selection, emitted expression,
serialization or semantic snapshot rule changes. See the
[boundary and validation](comparison-token-cache.md#nested-fresh-projection-bases).
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental contextual pattern inversion

The inference study can now abstract and reapply a ground contextual pattern with
an ordered dependent telescope and distinct explicit local arguments. Domain and
sort checks, simultaneous capture-free renaming, structural abstraction and
scope checks determine the result; opaque dependencies, unresolved terms,
non-pattern arguments and exhausted resources remain incomplete. This is model
infrastructure, not a source-language feature or an implemented lambda inference
rule. See the [constructive contract and tests](../studies/parameterized-literals/README.md#contextual-pattern-inversion-groundwork).
Joint-row integration, complete-expression Lean targets and production integration
are required before claiming embedded lambda support. No grammar change.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental contextual constraint fixed point

The model now saturates ordinary Row equations and Deferred checks together with
typed contextual family occurrences. Ground occurrences determine agreed closures;
checked applications constrain other outputs, possibly unlocking further families
or forward checks. Every ready check is evaluated, unavailable checking dominates
batch mismatches, and no defaults or candidate selection occur. See the
[constructive rule](../studies/parameterized-literals/README.md#shared-contextual-constraints-and-forward-checks).
This remains experimental model infrastructure. Source binder/Builder integration,
whole-expression Lean oracles and production inference are pending. No grammar or
emission change is accepted by this entry.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental contextual selection and callable targets

Contextual candidates must saturate completely before the ordinary selector applies
simultaneous defaults. Incomplete competitors block selection; distinct surviving
candidates remain ambiguous. A private association token is read only after
uniqueness and cannot choose an interpretation. Type-valued contextual closures
can be rechecked and converted through an explicitly declared function identity
and the checked binder codec. See the
[selection contract and independent native targets](../studies/parameterized-literals/README.md#contextual-candidate-selection-and-checked-callable-types).
These are experimental callable-type targets. Source lambda-body integration,
whole-call native oracles and production inference remain pending. No grammar change.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental selected scoped-body reconstruction

A joint selection can be projected into an opened source binder and reconstructed
without another selection/default pass. Fresh local rows, selected arguments,
default markers, witness retention and operator input ambiguity are rechecked;
the complete binder is re-elaborated to bind retained annotations hygienically.
Scoped bodies use explicit source-path lexical identities. An explicit adapter
checks three complete calls containing lambda arguments with independent Lean
oracles. See the [contract and scope](../studies/parameterized-literals/README.md#retaining-selected-scoped-bodies).
This does not yet automate nested-lambda row construction in the source Builder.
Contextual source integration, recursive body enumeration and production inference
remain pending. No grammar change.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental automatic direct scoped consumers

The experimental Builder reads a direct module consumer's checked explicit
signature, opens literal-bearing scoped arguments, and selects the Cartesian
product of child rows once. Earlier hole-free checked values may specialize later
parameter/return types. Unknown dependencies, implicit consumers, local callable
consumers and unsupported evidence views remain incomplete. Child row namespaces
prevent accidental sharing of inference variables; reconstruction preserves those
namespaces and rechecks the complete call and consumer identity. See the
[constructive rule, examples and native checks](../studies/parameterized-literals/README.md#automatic-direct-scoped-consumers-in-the-experimental-builder).
This is bounded experimental source integration. General contextual recovery,
recursive scoped bodies and production inference remain pending. No grammar change.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Recursive preparation of experimental scoped consumers

The direct scoped-call experiment now recursively prepares argument calls and
binder bodies, preserving one outer selection/default pass. Whole lambda types
must already be determined by checked explicit signatures; binder rows represent
the body. Child row products retain source-path namespaces and are reconstructed
only after uniqueness is established. Budgets decrease on recursion; exhaustion
is incomplete analysis. The [constructive rule and examples](../studies/parameterized-literals/README.md#recursive-scoped-expression-preparation-experimental)
specify the supported boundary. No grammar or production inference change.
Implicit/contextual signature recovery and unsupported enclosing operators remain
pending, as do mathematical topology proofs independently of this inference work.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental local scoped application

Scoped-expression preparation now accepts local callable heads and explicit
applications with checked hole-free heads. Local/explicit application remains
unary; curried calls use `h(n)(f)`, unlike a module notation's declared arity.
Domains constrain prepared arguments before the single enclosing selection.
Dependent codomains may use checked hole-free arguments; unresolved heads or
result dependencies remain incomplete. Reconstruction rechecks the head type and
whole application. See the [constructive rule and examples](../studies/parameterized-literals/README.md#local-scoped-consumers-and-explicit-application-experimental).
No grammar change or production integration is claimed.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Experimental joint application heads

A scoped `Apply` may recursively prepare a literal-bearing `Call` or `Apply` head
when checked explicit signatures determine its result type without selecting any
arguments. Head rows and argument rows enter the same enclosing product and one
outer selection. Reconstruction projects the trace into the head, checks its type
and rechecks the whole application. Source paths distinguish heads from arguments;
recursion decreases the budget. The [constructive rule](../studies/parameterized-literals/README.md#joint-preparation-of-function-producing-heads-experimental)
supersedes the prior blanket hole-free-head restriction. Value-dependent unresolved
results, implicit signature recovery and production integration remain pending.
No grammar change.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Packaged joint completion boundary

The joint solver now has an installable, explicit API:
`cleanlang.joint_inference.complete(tree, env, locals, expected=None, limit=4096,
use_default=True)` (the last two arguments are keyword-only). It returns a checked
retained expression or propagates its precise analysis failure; incomplete analysis
never triggers a legacy-solver fallback. Source parsing and default production
elaboration are unchanged. This relocates the maintained solver from the study to
the package, with one implementation and native drivers using the public API.
See the [API contract and validation](../studies/parameterized-literals/README.md#installable-joint-completion-api).
Default routing still requires compatibility validation and outstanding inference
coverage; packaging alone is not conformance evidence.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Structural refutation before joint row products

The packaged joint solver may discard a completed child fragment only when its
structural equation conjunction is refuted (`NoSolution`). Adding parent equations
cannot make that conjunction satisfiable. Undecided conversion (`Incomplete`)
retains the fragment; pruning performs no defaults, callback evaluation or selection
and uses no parent expected result. This prevents already-impossible child choices
from inflating later Cartesian products. Surviving rows receive the unchanged full
analysis. See the [rule, corpus comparison and topology gaps](../studies/parameterized-literals/README.md#document-compatibility-and-structural-contradiction-pruning).
No syntax change; default production routing remains unchanged.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Closed nominal universes in joint inference

The joint solver's nominal `Carrier` encoding accepts every declared closed positive
Lean Sort level. Its symbolic `type` category does not mean Lean Type 0: declaration
identity and arguments retain the concrete carrier and its universe. Ground
reconstruction still checks the declared telescope. There is no universe inference,
cumulative coercion or default universe. Higher classifier inference and higher
local/dependent carrier boundaries remain separately incomplete. See the
[rule, topology compatibility and independent native targets](../studies/parameterized-literals/README.md#closed-higher-universe-nominal-carriers).
This removes the nominal Type-0 restriction, with no syntax or default-routing change.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Direct lambda heads with determined codomains

Joint preparation may discover a common ordinary function type for a directly
applied lambda only when every viable body row has the same ground checked
codomain, with no retained reference to that lambda's own bound local. Saturation
performs no defaulting or selection; incomplete rows block discovery. The original
body alternatives then participate in the outer product and selection. Emission
retains the lambda application and audits body operator ambiguity. See the
[constructive rule and independent checks](../studies/parameterized-literals/README.md#direct-lambda-application-with-a-common-determined-codomain).
Unknown/competing/dependent codomains remain incomplete. No syntax or default
production-routing change.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Joint completion at the translator error boundary

The explicit `numeral_inference.complete_joint` entry point preserves retained
results while mapping joint analysis outcomes to compiler error categories. It
never falls back to legacy inference. Incomplete analysis remains distinct from
inconsistency; exhaustive ambiguity counts and simultaneous default conflicts use
structured exception data. Solver failures cannot acquire a surrounding trial's
mismatch ownership. Assigned expressions retain normal checking behavior. See the
[error mapping and migration checks](../studies/parameterized-literals/README.md#translator-facing-joint-error-boundary).
Default routing remains unchanged. No grammar or Lean-emission rule changes.
:::

:::llm gpt-6 2026-11-11 role=assisted

## Expected nullary nominal results of direct lambdas

When a direct lambda application is checked against a closed nullary nominal
carrier C, prepare its body under C and its function under the explicit domain
arrow to C. All body and argument alternatives still enter one enclosing solve.
Do not infer a constant indexed codomain from an application expectation: indexed,
local and dependent expectations continue through independent common-codomain
discovery and the enclosing result check. Operator-input ambiguity remains an error
regardless of expected result. See the [rule and checks](../studies/parameterized-literals/README.md#expected-scalar-results-for-directly-applied-lambdas).
No syntax or default-routing change.
:::


:::llm gpt-6 2026-11-11 role=assisted

## Determined dependent codomains of direct lambda heads

This extends the earlier binder-independent direct-lambda rule: it also accepts
a common ground checked codomain that
refers to its own binder. Construct its function type with the ordinary dependent
function abstraction rule (`dependent_functions.inferred_type`), preserving the
source binder identity and checked codomain. Do not replace that family by a
constant type inferred from the application's expected result.

For an ordinary body row, recover the codomain through that row's checked
representatives and computed-index plans after saturation, without selection or
defaulting. This supports both `Vector(k,Complex)` and `Vector((k+1),Complex)`.
Nested scoped bodies retain their existing reconstruction boundary. All viable
body rows must agree on the codomain; an unresolved or competing family remains
incomplete. Retain every viable row for the enclosing solve and operator audit.

Application substitutes an already checked hole-free actual argument into the
family using the existing dependent-call rule. An argument with unresolved
literal interpretations still reports incomplete analysis; this change does not
infer a family from a sampled result or add contextual value recovery. Recheck
the retained head type and final application type before emission. No syntax,
parse-tree, implicit-coercion or production-routing changes are introduced.
:::
