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
| D10 | Four-space indentation, newline clauses, no tabs | Provisional concrete interpretation of Python-style layout |
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

## Questions to revisit after reading the specimens

1. Should formalization contributors become a required field distinct from mathematical sources? Source keys are now implemented.
2. Should labels with spaces be allowed, and if so, quoted or parsed up to the colon?
3. Should `Define` stay as an alias, or should only `Let` introduce local values?
4. Should the LaTeX renderer preserve the exact original type phrase rather than using the imported type’s English description?
5. Which quantifier, summation, set-builder, and asymptotic syntax should come next?
6. Which CLR edition and algorithm families should anchor the next collection expansion?
7. Should generic algebraic structures and Lean typeclasses be expressible directly in Clean?
8. Which additional operator precedence and associativity rules need explicit examples? Unary minus already follows `-x^2 = -(x^2)`.
