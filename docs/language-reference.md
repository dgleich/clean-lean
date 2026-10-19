# Clean syntax and semantics draft

This draft specifies the next language design: a mathematical statement language elaborated into Lean, with module-declared vocabulary and a shared representation for Lean and LaTeX. It is a contract for the refactor, not a description of features already implemented. The current implementation is described in [spec.md](spec.md).

**Agreed requirements:** explicit imports; one mathematical semantic space; readable `Let`, `Assume`, and `Conclude`; mandatory result attribution; explicit context references; Lean as the authority for mathematical types. **Agreed parsing choices (2026-10-19):** infer continuation from incomplete expressions; reject overlapping infix/postfix spellings; allow imports between top-level declarations; allow definition fields in any order while retaining parameter order. These rules are normative for the next language, not claims about the current prototype. **Draft choices:** the concrete operator fields below, qualification, overload rules, and the restrictions in this document. These need review before being treated as settled syntax.

Readable source is a first-class requirement. The [aspirational syntax gallery](aspirational-syntax.md) supplies authoring specimens against which this grammar must be judged. Its `Write`, named syntax-group, and reusable-context forms are alternatives to investigate, not constructs silently added to this grammar.

The formal core covers first-order surface notation with dependent argument types, typed declarations, applications, operators, and theorem statements. Proof scripts, arbitrary binding notation, general English parsing, and executable algorithm syntax are outside this draft. There is no Clean evaluator: the meaning of a completed statement is its elaborated Lean proposition.

For readers familiar with Lean, the maintained [Clean to Lean HTML reference](clean-to-lean.html) presents readable mappings and feature status. The rules here and the acceptance contract remain authoritative.

## Hard acceptance contract

For fixed source and an explicit, pinned environment, every accepted input has exactly one specified syntax tree and exactly one fully elaborated Lean target and type. These are hard requirements for every language change. Parsing may be expensive; neither parsing nor elaboration may choose meaning through incidental search order. A syntactically valid tree that has no unique permitted Lean translation is rejected at binding/elaboration, not assigned a guessed meaning.

The normative [language change acceptance requirements](language-change-acceptance.md) define syntax/semantic ambiguity, canonical target equality, explicit environment inputs, resource handling, proposal obligations, and required acceptance evidence. “Unique Lean expression” includes inferred arguments, coercions, instances, universes, and proof arguments. It is stronger than deterministic pretty-printing, successful Lean typechecking, or equality of two propositions in Lean. Existing implementations and earlier accepted design choices remain subject to these obligations; this document does not certify their conformance.

## 1 Language layers

A translation has five stages:

1. Read module items in source order. At each item, resolve its imports or parse its header using the syntax environment established by preceding items.
2. Parse expressions into syntax trees using that declared syntax.
3. Resolve names to declarations and bind local variables.
4. Elaborate the bound trees against Lean, producing typed terms and selected notation identities.
5. Generate Lean declarations and LaTeX from the resolved representation.

Stages 1–4 proceed item by item; there is no whole-file hoisting of later imports or declarations. An item retains the environment at its source position. A stage may report an error; it must not guess a missing mathematical meaning. The mathematical library, Lean version, dependency versions, and elaboration options are part of the build input. Import order must not secretly choose notation meanings or defaults.

The compiler owns layout, lexical binding, declaration structure, module loading, and generic parsing/elaboration machinery. Modules own mathematical type names, notation meanings, operator syntax, overloads, literals, type phrases, and presentation. The bridge necessarily understands Lean's foundational notions of terms, sorts, binding, and checking against `Prop`; it does not recognize a display name such as `Natural` or `Proposition` as a semantic instruction.

## 2 Lexical and layout rules

- UTF-8 input; each indentation increase is at least two spaces; tabs are errors everywhere, including blank lines, comments, and continuations. Siblings align; dedents return to an enclosing column. Block widths need not match across the file. Blank lines and full-line `#` comments do not affect indentation.
- Inline Clean expressions continue across physical newlines while parentheses remain open or the expression parser requires a further operand. A complete postfix application does not require an operand. Outside parentheses, a continued line begins at least two columns beyond the first physical line of the clause; parenthesized continuation indentation is visual and does not introduce scope. A complete inline expression ends at the physical newline; a leading operator on the next line cannot reopen it. Explicit expression blocks have separate boundaries, specified below.
- Declaration keywords and field labels are case-insensitive. Mathematical names are case-sensitive. Word-operator spellings may have module-declared case-insensitive aliases; the compiler does not hard-code English logical words.
- Object identifiers are a Unicode letter followed by Unicode letters, decimal digits, or underscores. An English name is one or more identifiers separated by spaces. Spaces within an English name normalize to one space. This grammar is a draft restriction, not a promise to support all Lean identifiers.
- String literals use double quotes, with `\"` and `\\` escapes. Keywords are recognized by grammatical position, not prohibited everywhere as object names.
- Decimal literal tokens are maximal nonempty sequences of ASCII digits. Recognition of the token does not supply its type or mathematical meaning. Minus is an operator, not part of the literal token.
- Parentheses, commas, colons, quotation marks, and layout delimit the language. A call has no whitespace application: write `f(x)`, not `f x`.
- Symbolic operators are declared quoted spellings. Lexing uses the longest visible spelling at a position; operators cannot contain layout whitespace or reserved delimiters. Overlapping word names are resolved as complete names before `(` or an explicit delimiter, not by substring replacement.

### Lexical modes and block ownership

The containing production selects the lexical mode before its contents are scanned:

- **Clean expression:** typed declarations, assumptions, `Returns`, `Equals`, and `Conclude`. Only these contents use Clean operator parsing and inferred continuation.
- **Lean expression:** `From Lean` and the older notation/type `Means` bridge. Clean does not interpret their operators, comments, or keywords. `Means` remains single-line in this slice; `From Lean` has explicit inline and block forms.
- **Metadata or rendering:** attribution, bibliographic fields, and rendering fields use their own schemas. Punctuation in their values never starts Clean expression continuation. For example, an attribution field named `returns` remains metadata, even if its text ends with `+` or `(`.

At a clause/field boundary, the enclosing grammar recognizes a keyword and its required header shape. Inside an expression, the same spelling is an identifier where the expression grammar permits one. Thus the following is valid syntax if `Returns` is a declared object:

```text
Conclude: Returns =
  Returns
```

A keyword-shaped identifier alone must not be mistaken for a new clause. Conversely, `Let z: Real` cannot supply a missing operand: that token sequence is not a valid expression. Inferred continuation never authorizes swallowing a separate clause.

### Layout and continuation

The layout scanner keeps a stack of indentation columns, initially `[0]`. Outside continued expressions and opaque bodies, an increase of at least two columns pushes one level and emits `INDENT`. Equal indentation emits no layout transition. A decrease must match a column already on the stack and emits one `DEDENT` per popped level. At end of file all remaining levels close. An increase of one space or a dedent to an unknown column is an error. The grammar determines which constructs admit an indented body; layout alone does not authorize nesting. Blank lines and full-line Clean comments do not change this stack.

For an **inline Clean expression**, the parser can be in a completed state, a state requiring an operand, or a state with open parentheses. At a physical newline:

1. A completed expression with no open parentheses emits `NEWLINE`.
2. Open parentheses or a required operand suppress `NEWLINE` and request continuation under the indentation rule above. This includes an operand after a prefix or infix operator, an argument after a comma inside a call, and the right-hand side after the local-definition delimiter `=`.
3. An otherwise invalid token sequence is an error, not a reason to continue until it becomes plausible. An empty field value after `:` does not infer continuation; only fields with an explicit block alternative may begin a value on the next line. A local-definition delimiter `=` is different: it explicitly starts an expression requiring an operand.

An **explicit Clean expression block** starts after a field's empty `:` line. Its first content line establishes a body column at least two greater than the field column. All content lines up to the first dedent below that body column belong to one expression; physical newlines within that region separate tokens, never imply conjunction or introduce additional clauses. Extra indentation within the region is visual. A dedent closes the block even if its expression is incomplete, in which case parsing fails. Sibling fields must align with the field header. Blank/comment lines do not choose or end the body column.

An **explicit Lean expression block** has the same indentation boundary, but its contents are captured as Lean source with newlines and relative indentation preserved after removing the body column. Only blank lines are ignored when locating its boundary; Lean comments are part of its source. `#` within it is not a Clean comment. Nested Lean indentation does not create Clean scopes. An inline Lean body extends to the physical newline and does not use Clean continuation inference.

Metadata and rendering remain single-line values, except where their own schema explicitly defines a block (such as expanded attribution). Tabs remain forbidden in every mode. An unclosed delimiter, a missing operand, or an empty required body at end of input is an error. `NEWLINE` in the grammar denotes a logical newline, except in the opaque Lean productions where it denotes a physical newline. The scanner and expression parser cooperate using the current syntax environment; a blind preprocessing pass based on the final character of a line is not conforming.

## 3 Declaration grammar

This EBNF describes the proposed operator/type/statement slice. `NEWLINE`, `INDENT`, and `DEDENT` are produced by the layout lexer. `expression` is parameterized by the visible syntax environment; section 4 defines it. Metadata and phrase declaration bodies retain their separate schemas in the prototype documentation; this is not yet a complete grammar for those facilities.

```ebnf
module           = { import | declaration | result | context } ;
import           = "Import", string, ["as", identifier], NEWLINE
                 | "Import", "Lean", leanModule, NEWLINE
                 | "Import", "BibTeX", string, NEWLINE ;
declaration      = definition | notation | typeDeclaration | sourceDeclaration
                 | phraseDeclaration | aliasDeclaration ;
definition       = "Define", englishName, declarationSignature,
                   NEWLINE, INDENT, { definitionField }, DEDENT ;
declarationSignature = "(", [nameList], ")", ":"
                     | "(", [typedParameterList], ")", ":", typeExpression, ":" ;
typedParameterList = typedParameter, { ",", typedParameter } ;
typedParameter   = identifier, ":", typeExpression ;
(* typeExpression uses the existing constructor/alias/prose type grammar. *)
definitionField  = typedLet | attribution | presentationField
                 | "Returns", ":", expressionValue
                 | "Equals", ":", expressionValue
                 | "From", "Lean", ":", leanValue ;
expressionValue  = expression, NEWLINE
                 | NEWLINE, INDENT, expressionLines, DEDENT ;
leanValue        = leanLine, NEWLINE
                 | NEWLINE, INDENT, leanLines, DEDENT ;
presentationField = "Render", ["latex"], ":", rendering, NEWLINE ;
notation         = "Notation", englishName, declarationSignature,
                   NEWLINE, INDENT, { notationField }, DEDENT ;
notationField    = typedLet
                 | "Returns", ":", expression, NEWLINE
                 | "Means", ":", leanTerm, NEWLINE
                 | "Syntax", ":", fixity, string, NEWLINE
                 | "Precedence", ":", integer, NEWLINE
                 | "Associativity", ":", associativity, NEWLINE
                 | presentationField ;
fixity           = "prefix" | "infix" | "postfix" ;
associativity    = "left" | "right" | "none" ;
typeDeclaration  = "Type", englishName, "(", [typedParameters], ")", ":",
                   NEWLINE, INDENT, typeBody, DEDENT ;
typeBody         = "Means", ":", leanTerm, NEWLINE, { presentationField }
                 | "Equals", ":", expression, NEWLINE ;
typedParameters  = identifier, ":", expression,
                   { ",", identifier, ":", expression } ;
result           = ("Result" | "Theorem"), englishName, ":", NEWLINE,
                   INDENT, attribution, { clause }, conclusion, DEDENT ;
clause           = typedLet | localDefinition | assumption ;
typedLet         = "Let", nameList, (":" | "be"), expression, NEWLINE ;
localDefinition  = ("Let" | "Define"), identifier, "=", expression, NEWLINE ;
assumption       = "Assume", englishName, ":", expression, NEWLINE ;
conclusion       = "Conclude", ":", expressionValue ;
context          = "Context", englishName, ":", NEWLINE, INDENT,
                   { clause }, (result | context), {result | context}, DEDENT ;
nameList         = identifier, { ",", identifier } ;
```

`Import BibTeX` introduces only bibliographic source metadata, using the citation-key and collision rules specified in [the prototype specification](spec.md#bibtex-sources). Its position follows this draft’s interleaved, sequential import rule, superseding the prototype’s prelude restriction. It neither introduces expression names nor changes mathematical overload resolution.

Imports, definitions, results, and contexts may interleave at module level. An import takes effect immediately after its own item and only for subsequent items. Signatures and bodies may refer to preceding declarations and imports, never later ones. Imports inside a result, definition body, or context are not part of this slice. All fields must be unique except repeated typed `Let` clauses. An expanded notation requires exactly one `Returns`, `Means`, and `Render`; a compact notation supplies the return type in its header instead of a `Returns` field. With no `Syntax` field it is callable by its English name. An operator declaration also remains callable by that name.

An expanded `Define` requires exactly one `Returns` field (a compact `Define` supplies the return type in its header) and exactly one implementation field: either `Equals` or `From Lean`, never both. Other fields may appear anywhere among its typed `Let` clauses. First collect the fields, then check the `Let` clauses in their relative source order. A parameter type can use earlier parameters only. The return type and implementation are resolved in the complete parameter scope, regardless of where their fields appear. The definition’s own name becomes available only after the definition has been checked; recursion is outside this slice. Empty and duplicate fields are errors. `Render` and `Render latex` are alternatives for one presentation field, not separately repeatable fields.

Definitions may carry one attribution and one presentation field; neither is required by this slice. This is a recorded provisional policy: the established mandatory-attribution requirement continues to apply to results. With no presentation field, a definition renders as a named application with its arguments. The optional-definition-attribution policy and presentation default can be revisited independently of parsing. `Returns` inference is deferred.

After compact-signature normalization, for both `Define` and the existing `Notation` bridge, every header parameter must be declared exactly once in the `Let` clauses and in header order. Additional `Let` binders before the header parameters are implicit parameters inferred from the typed application. Both colon and `be` forms, and grouped typed lets, have identical binding semantics here and in results. An unused implicit parameter cannot be inferred and must cause an unresolved-parameter error; there is no guessed dimension/type value.

Infix notation requires two header parameters and all three syntax fields. Prefix/postfix notation requires one header parameter, `Syntax`, and `Precedence`, and forbids `Associativity`. Call-only notation forbids precedence/associativity fields. Proposed precedence values are integers from 0 through 100, with larger values binding more tightly; calls bind tighter than all operators.

`Type` is declaration syntax, not a privileged mathematical type name. Its parameters have ordinary imported type expressions; there are no compiler-defined `dimension` or `scalar` parameter kinds. Its `Means` must elaborate to a type/sort expression under those parameters. A module may introduce a readable name for a universe through that same Lean bridge; the exact universe-parameter syntax remains an open item below.

An optional article in `Let x be a ...` is part of a declared phrase form. The compiler must not blindly strip words from arbitrary mathematical names. `Let x = T` is rejected when the right-hand side is a type expression: type naming belongs to `Type ... Equals:`. The punctuation `=` in a local definition introduces a value; in an expression it is an imported operator spelling. These are distinct grammatical positions.

## 4 Expression syntax and operator parsing

Let `S` be the visible syntax environment. A notation syntax record is:

```text
SyntaxRecord(spelling, fixity, precedence, associativity, candidateIDs)
```

All imported overloads sharing a spelling and fixity must agree on precedence and associativity. Otherwise importing the combination is an error before mathematical type checking. Syntax trees cannot depend on which overload eventually fits. A symbol used both as prefix and infix has separate syntax records, selected by syntactic position. A spelling may not be visible as both infix and postfix: the declaration or import introducing that combination is rejected, even if no expression uses it. Prefix/postfix reuse is permitted because the parser’s operand position distinguishes it. Type-directed overload selection cannot repair a grammatical conflict.

An expression is a name reference, a decimal token, a parenthesized expression, a call with comma-separated expressions, or an application of a prefix/infix/postfix syntax record. The parser records the record's candidate identities without yet choosing a mathematical operation.

For a precedence-climbing parser, an infix operator of precedence `p` parses its right operand with minimum precedence `p+1` when left-associative and `p` when right-associative. Nonassociative operators reject an unparenthesized continuation at that same precedence on either side. Prefix operators parse their operand at their declared binding power. Parentheses override all binding powers. Infix operators at a shared precedence with incompatible associativity require explicit parentheses rather than a source-order tie-break.

A postfix operator of precedence `p` is consumed in a precedence-climbing call with minimum precedence `m` exactly when an operand has been parsed and `p ≥ m`. It wraps the current left tree and consumes no right operand. The parser then resumes its operator loop at minimum `m`. Consecutive postfix operators apply in source order: `x!!` means `(x!)!` when tokenization yields two `!` tokens. Postfix and infix operators at equal precedence group in their source order where the infix right-binding rule permits: a left-associative infix of precedence `p` makes `x + y!` parse as `(x + y)!` when `!` also has precedence `p`. Give `!` higher precedence to obtain `x + (y!)`. Operator lexing remains longest-match, so a separately declared `!!` token is different from two `!` tokens.

A completed postfix expression is a completed expression for the newline rule. For example, `Let count = n!` ends at its newline; `Let count = -` requires continuation when `-` is prefix; and `Let count = n +` requires continuation when `+` is infix.

For example, a standard arithmetic module can assign prefix minus precedence 70 and exponentiation precedence 80, making `-x^2` mean `-(x^2)`. These values and spellings are module declarations, not compiler constants. Chained comparisons require explicit logical conjunction or future declared chain syntax; the parser does not silently convert `a < b < c` into a conjunction.

## 5 Identity and module scope

A declaration has a qualified identity `d`, separate from its display name and generated Lean identifier. A reference stores `d`; it never relies on comparing a rendered name to strings such as `Matrix`, `Function`, or `Natural`. Local binders likewise have unique identities.

Each module item is checked in an environment made from that module’s preceding imports, their explicit exports, and preceding declarations. An import later in the module cannot repair an earlier unknown name or add candidates to an earlier overload set. Moving an import across a use is therefore not semantics-preserving; permuting independent imports before all affected uses is. It does not receive the importing document's local environment. Cycles are rejected in this first version. Importing the same canonical file more than once does not duplicate declarations.

Draft export rule: a module exports its own declarations, not imported names automatically. A public signature retains qualified references to all its dependencies, even when their display names are not exported. Thus an importing module can use a declaration without acquiring unrelated spellings. A future explicit re-export form is required for convenience modules such as `standard.clean`; its spelling is not settled here. This differs from the current prototype's flattened environment.

An unqualified name must resolve uniquely, except for an explicitly declared notation overload set. Importing two unrelated ordinary declarations with the same name is an error; import order never picks a winner. Draft qualification is `Import "sorting.clean" as sorting`, followed by `sorting::insertion sort(xs)`. Qualified English-name calls are permitted; qualifying symbolic operators is deferred, since every operator has a callable declaration name.

The Lean backend uses escaped or generated identifiers based on identities. A legal Clean name such as `match` must not fail because it happens to be a Lean keyword. Renaming a readable name while retaining its binding relationships preserves meaning up to renaming of generated declarations.

## 6 Resolved representation

The minimum bound expression representation is:

```text
BoundExpr = Local(binderID)
          | Reference(declarationID)
          | Decimal(digits, literalCandidateIDs)
          | Apply(callee, argumentTrees)
          | Notation(candidateIDs, argumentTrees)
```

Every node retains a source span. A checked expression additionally records its elaborated Lean term and type, the selected declaration, inferred arguments/evidence, and the presentation tree. Types are expressions in this same representation: `Matrix(2,2,Function(Real,Real))` is a nested application, not a formatted string.

Type aliases are bound aliases, expanded by capture-avoiding substitution or represented by checked Lean definitions. Notation applications refer to generated checked declarations; type applications must do the same or use an equivalent structural elaboration. A wrapper that is checked once and then bypassed by unchecked string expansion does not satisfy this contract.

## 7 Elaboration judgments

Write `E` for the resolved module environment and `Γ` for local bindings. The judgments are:

```text
E ; Γ ⊢ e ⇒ t : T        e synthesizes Lean term t of type T
E ; Γ ⊢ e ⇐ T ⇒ t        e checks against expected Lean type T
E ⊢ module ⇒ exports    module checks and exposes declarations
```

These are language contracts, not a proposed Python imitation of Lean's type checker. `T` is an elaborated Lean expression. Type equality/compatibility, implicit arguments, coercions, and constraints must be checked by the pinned Lean environment under the chosen language policy. Unknown or unresolved constraints do not constitute success.

For a local object binding `x : T` in `Γ`, a reference to its binder identity elaborates to that Lean local of type `T`. For an application, the elaborator checks each argument against the callee's dependent parameter type, substituting earlier elaborated arguments structurally into later parameter types.

For a notation node with finite visible candidate set `C`, elaboration attempts each candidate's typed application in the same context, including the expected result type when available. Constraints from enclosing expressions may be propagated; candidates must not be committed greedily before relevant expected-type information is available.

```text
viable(C, arguments, expectedType) = fully resolved candidate applications admitted by the specified rules

|viable| = 0    => type/overload error
|viable| = 1    => selected application
|viable| > 1    => ambiguity error
```

The candidate count alone is not sufficient: every accepted application must itself have exactly one canonical target under the full elaboration policy. Distinct permitted coercions, instance evidence, implicit arguments, or universe instantiations are part of that obligation. The rules must specify their resolution or require an explicit disambiguation; they cannot silently inherit a heuristic not included in the language contract.

Aliases to the same declaration identity do not create extra candidates. Distinct declarations remain ambiguous even when their bodies happen to be definitionally equal. Resource exhaustion or unresolved metavariables are reported as incomplete elaboration, not silently treated as evidence that one other candidate is uniquely valid. No specificity ranking or import-order priority is implied by this draft.

A decimal token is handled by imported literal interpretation declarations in the expected type context. Without a unique contextual interpretation or an explicitly imported unique default, it is an error. The compiler does not default to a type spelled `Natural`. The literal-declaration concrete syntax and the exact coercion/typeclass visibility policy remain open; no implementation may silently fill those gaps with name-based rules.

## 8 Declaration and statement meaning

A `Define` collects and checks its ordered parameter telescope and explicit return type. An `Equals` expression is parsed in the Clean mode and elaborated against that return type. A `From Lean` body is elaborated as a Lean term against the same return type, in the complete parameter scope and the Lean environment available at this declaration. Both produce the same kind of callable declaration identity. Lean adapters may fix arguments, choose instances, or wrap representations, but must satisfy the declared signature; they cannot leave unresolved names or metavariables. Attribution and rendering do not change that meaning.


A notation declaration checks its parameter telescope, return type, and Lean `Means` term together. Free Lean identifiers in `Means` must resolve in its declared Lean imports and parameter scope. It produces a Lean-backed declaration with no proof of a surrounding result. Mathematical definitions may be noncomputable; that does not make a proposition proved.

A type declaration checks its telescope and `Means` as a type/sort expression. The display names of its parameters have no semantic category: a dimension is an ordinary parameter whose imported type determines its meaning.

Statement clauses elaborate in source order. Let `F(clauses, Q)` denote the Lean proposition produced from a checked conclusion `Q : Prop`:

```text
F([], Q)                         = Q
F(Let x : T :: rest, Q)           = ∀ x : T, F(rest, Q)
F(Let x = v :: rest, Q)           = let x : type(v) := v; F(rest, Q)
F(Assume label : P :: rest, Q)    = ∀ h_label : P, F(rest, Q)
```

Grouped typed lets expand to successive binders sharing the same type expression, which is resolved before introducing the group. Each assumed expression is checked against Lean `Prop`; each generated `h_label` is a proof of that proposition.

**Draft statement-only rule:** assumption labels occupy a label namespace, not the expression namespace. Thus `Assume h: x = x; Conclude: h` is rejected, rather than treating the proof as a proposition or silently expanding its label. This leaves room for a future proof language with explicit proof references. A separately declared object whose type is a proposition universe is different: it can denote a proposition in expression position. English assumption labels are allowed up to the colon.

Attribution is mandatory metadata; it neither inserts hypotheses nor proves a claim. A `Result`/`Theorem` statement produces a named proposition definition. The word `Theorem` does not authorize emitting an unproved Lean theorem, an axiom, or `sorry`.

Context handling first computes the inherited declaration projection: keep all inherited assumptions, all local clauses, and the transitive dependencies of those clauses and the conclusion; omit unused inherited object/value declarations. Then apply `F` in original declaration order. This projection is the defined context behavior, not a claimed logical equivalence to quantifying over arbitrary unused, possibly empty types. Expanded LaTeX prints the projection; referenced LaTeX explicitly cites the context and must disclose the same projected binders. Neither mode changes `F`.

## 9 Rendering semantics

Both Lean and LaTeX backends consume the same resolved declaration identities and application structure. Rendering must not redo overload resolution or interpret a display name mathematically.

A structural rendering has nodes such as `Text`, `Argument`, `Call`, `Infix`, `Prefix`, `Postfix`, `Superscript`, and `Group`. Each argument occurrence references a resolved child expression; it is not substituted as an untyped string. The renderer uses its own structural binding rules to add visible parentheses when embedding a child would otherwise change grouping. Rendered binding power is not assumed equal to the source operator's binding power: division may become a fraction, for example.

Required examples:

```text
inverse(A*B)                      renders as (AB)⁻¹
transpose(A*B)                    renders as (AB)ᵀ
Matrix(2,2,Function(Real,Real))    renders as matrices of real functions
```

Invisible TeX braces do not count as visible grouping. English logical connectives are rendered as words. Consecutive declarations form period-separated sentences. Contexts are either expanded or explicitly referenced; no implicit context mode exists.

The concrete structural rendering syntax is still open. Existing raw `Render latex` templates cannot be advertised as satisfying this contract without additional structural information. English descriptions and custom mathematical symbols also involve author assertions about meaning: structural guarantees preserve identity and grouping, but cannot prove that arbitrary prose or TeX faithfully explains a Lean term. Such escape hatches must be distinguished from validated structural rendering.

## 10 Conformance requirements

The [acceptance contract](language-change-acceptance.md) applies to every proposed change. Its initial [case catalog](../tests/acceptance/language-contract.json) is explicitly pending, not a claim of executable conformance coverage. The requirements below are additional concrete cases. A conforming implementation of this draft must demonstrate:

| Property | Required counterexample or check |
| --- | --- |
| Structured type preservation | The matrix-of-functions statement has the intended nested type, not the Lean-accepted matrix-to-scalar type |
| Binding hygiene | Renaming a type/operator preserves behavior; a Lean keyword used as a Clean object/result name still translates |
| Module independence | A missing module dependency cannot be repaired by an unrelated import in the caller |
| Determinism | Permuting independent imports before all affected uses preserves resolved identities and mathematical meaning |
| Sequential imports | A later import cannot fix an earlier reference or change its parse; the same reference after the import can resolve |
| Continuation | A postfix application ends at newline; prefix/infix operators requiring an operand continue; keyword-shaped identifiers remain valid expression tokens |
| Field ownership | `returns: text +` inside attribution stays metadata; `From Lean` block contents are never tokenized as Clean |
| Operator conflicts | Importing one spelling as infix and postfix fails before any use or type checking |
| Definition fields | Reordering Returns/implementation/presentation around an unchanged parameter sequence preserves meaning; reversing dependent parameters fails |
| Overload discipline | Zero and multiple viable overloads are errors; no first-match fallback |
| Literal discipline | An unconstrained numeral with no declared default is rejected |
| Uniform parameters | Fixed dimensions and inferred dimensions produce compatible Lean applications; neither has an ad hoc internal kind |
| Proposition distinction | A hypothesis label cannot masquerade as a proposition expression |
| Presentation grouping | Inverse and transpose of products visibly preserve grouping |
| Extensibility | A new type and operation work through modules without changing compiler branches |

Lean acceptance alone is not a preservation test. Test fixtures must also check independently specified syntax trees, canonical fully elaborated target structures and types, and selected declaration identities. Definitional equality checks of expected propositions are useful but insufficient for the unique-target requirement. The 80 existing corpus proofs are regression coverage, not evidence that these general properties hold. A mechanically verified compiler or formal soundness proof is not claimed.

## 11 Authoring conformance

Semantic correctness and readable source are joint requirements. The language must support compact statements, natural typed declarations, English titles and labels, and visible shared dependencies without forcing theorem authors to expose Lean implementation details. Equivalent `be` and colon declarations must share one binding rule. Parser convenience is not a reason to impose a less readable spelling.

The [aspirational syntax specimens](aspirational-syntax.md) are part of design review. Before freezing operator-field syntax, compare the numeric-field form in section 3 with written patterns and named syntax groups. The final choice must still produce the same explicit syntax records and checked notation declarations. A new syntax requires both a source specimen and a precise elaboration rule.

## 12 Decisions required before implementation

1. Approve or revise `Syntax`, `Precedence`, and `Associativity`, including whether authors should use named precedence groups instead of integers.
2. Settle literal declarations, explicit defaults, universe parameters, and which imported Lean coercions/typeclass instances participate in elaboration.
3. Choose the structural rendering declaration syntax and policy for unchecked raw TeX.
4. Settle explicit re-export syntax and review `alias::name` qualification. The proposed local-export rule requires migrating convenience modules.
5. Confirm label-only assumptions for this statement language, rather than giving labels a special proposition-reference meaning.

The next implementation slice should exercise declared scalar/matrix/matrix-vector multiplication and nested type applications against this contract. The five confirmed review failures remain outstanding until corresponding tests pass under the new representation.

## Implementation checkpoint: authored definitions

The current prototype implements the subset described in
[the current spec](spec.md#authored-definitions-current-implementation-slice).
This does not narrow the normative grammar above: positional imports, explicit
Lean body blocks, expanded definition attribution, and the complete elaboration
uniqueness procedure remain pending. The new structural checks cover three
monomorphic expression-body targets, not all legal definitions.

The prototype wrapper naming rule is specified in [readable generated identifiers](spec.md#readable-generated-lean-identifiers). This is a deterministic target-identity spelling change; it adds no Clean parse alternative or scope rule.

## Compact declaration signatures (implemented)

`Notation cos(x: Real): Real:` and `Define square(x: Real): Real:` are
alternatives to the expanded signature. The final colon opens the declaration
block; earlier colons annotate parameter and return types. The first balanced
closing parenthesis ends the header parameter list. A suffix consisting only of
`:` selects the expanded form; `: typeExpression :` selects the compact form.
This lexical distinction precedes any type checking and also works for zero
parameters. Commas split parameters only at depth zero within the outer list.
Empty entries, trailing commas, and grouped parameter names are not allowed in
compact headers. Parenthesized type constructors may nest. Keyword capitalization
and existing parenthesis-continuation/layout rules apply.

Every compact parameter must be typed, and its return type must appear in the
header. Compact declarations reject all body `Let` and `Returns` fields, even
if they repeat the same type. The expanded form retains its required body
signature; it cannot contain typed header parameters. `::` is not a new spelling.
For implicit type/dimension parameters use the expanded form; no implicit
parameter syntax is introduced by this alternative.

Normalize a compact header to its name-only header, one typed `Let` for each
parameter in source order, and one `Returns` field. Preserve the other body
fields. Then apply the existing declaration rules without branching on original
spelling. Parameter types see preceding parameters; the result and implementation
see the complete parameter scope. Names, declaration kind, resolved parameter
order/types/implicitness, return type, implementation, and rendering determine the
same normalized declaration regardless of compact or expanded spelling. There
are no new candidate meanings or type-directed parse choices. The emitted Lean
signature/body, generated identifier, and target are identical under identical
explicit environments. The existing general elaboration-conformance gaps remain.
