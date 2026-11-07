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
