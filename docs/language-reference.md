# Clean syntax and semantics draft

This draft specifies the next language design: a mathematical statement language elaborated into Lean, with module-declared vocabulary and a shared representation for Lean and LaTeX. It is a contract for the refactor, not a description of features already implemented. The current implementation is described in [spec.md](spec.md).

**Agreed requirements:** explicit imports; one mathematical semantic space; readable `Let`, `Assume`, and `Conclude`; mandatory attribution; explicit context references; Lean as the authority for mathematical types. **Draft choices:** the concrete operator fields below, qualification, overload rules, and the restrictions in this document. These need review before being treated as settled syntax.

Readable source is a first-class requirement. The [aspirational syntax gallery](aspirational-syntax.md) supplies authoring specimens against which this grammar must be judged. Its `Write`, named syntax-group, and reusable-context forms are alternatives to investigate, not constructs silently added to this grammar.

The formal core covers first-order surface notation with dependent argument types, typed declarations, applications, operators, and theorem statements. Proof scripts, arbitrary binding notation, general English parsing, and executable algorithm syntax are outside this draft. There is no Clean evaluator: the meaning of a completed statement is its elaborated Lean proposition.

## 1 Language layers

A translation has five stages:

1. Read layout and declaration headers, resolve explicit imports, and collect visible syntax declarations.
2. Parse expressions into syntax trees using that declared syntax.
3. Resolve names to declarations and bind local variables.
4. Elaborate the bound trees against Lean, producing typed terms and selected notation identities.
5. Generate Lean declarations and LaTeX from the resolved representation.

A stage may report an error; it must not guess a missing mathematical meaning. The mathematical library, Lean version, dependency versions, and elaboration options are part of the build input. Import order must not secretly choose notation meanings or defaults.

The compiler owns layout, lexical binding, declaration structure, module loading, and generic parsing/elaboration machinery. Modules own mathematical type names, notation meanings, operator syntax, overloads, literals, type phrases, and presentation. The bridge necessarily understands Lean's foundational notions of terms, sorts, binding, and checking against `Prop`; it does not recognize a display name such as `Natural` or `Proposition` as a semantic instruction.

## 2 Lexical and layout rules

- UTF-8 input; four spaces per indentation level; tabs are errors. Blank lines and full-line `#` comments do not affect indentation.
- Each clause occupies a physical line, except a conclusion block. Its indented lines form one token sequence; a newline does not imply conjunction.
- Declaration keywords and field labels are case-insensitive. Mathematical names are case-sensitive. Word-operator spellings may have module-declared case-insensitive aliases; the compiler does not hard-code English logical words.
- Object identifiers are a Unicode letter followed by Unicode letters, decimal digits, or underscores. An English name is one or more identifiers separated by spaces. Spaces within an English name normalize to one space. This grammar is a draft restriction, not a promise to support all Lean identifiers.
- String literals use double quotes, with `\"` and `\\` escapes. Keywords are recognized by grammatical position, not prohibited everywhere as object names.
- Decimal literal tokens are maximal nonempty sequences of ASCII digits. Recognition of the token does not supply its type or mathematical meaning. Minus is an operator, not part of the literal token.
- Parentheses, commas, colons, quotation marks, and layout delimit the language. A call has no whitespace application: write `f(x)`, not `f x`.
- Symbolic operators are declared quoted spellings. Lexing uses the longest visible spelling at a position; operators cannot contain layout whitespace or reserved delimiters. Overlapping word names are resolved as complete names before `(` or an explicit delimiter, not by substring replacement.

The raw body of `Means` is a Lean term, not Clean syntax. Its identifiers use the notation's bound parameters and explicitly imported Lean scope. The initial draft keeps this body on one physical line. An attributed source locator and an English rendering field are likewise not parsed as mathematical expressions.

## 3 Declaration grammar

This EBNF describes the proposed operator/type/statement slice. `NEWLINE`, `INDENT`, and `DEDENT` are produced by the layout lexer. `expression` is parameterized by the visible syntax environment; section 4 defines it. Metadata and phrase declaration bodies retain their separate schemas in the prototype documentation; this is not yet a complete grammar for those facilities.

```ebnf
module           = { import }, { declaration | result | context } ;
import           = "Import", string, ["as", identifier], NEWLINE
                 | "Import", "Lean", leanModule, NEWLINE ;
declaration      = notation | typeDeclaration | sourceDeclaration
                 | phraseDeclaration | aliasDeclaration ;
notation         = "Notation", englishName, "(", [nameList], ")", ":",
                   NEWLINE, INDENT, { notationField }, DEDENT ;
notationField    = typedLet
                 | "Returns", ":", expression, NEWLINE
                 | "Means", ":", leanTerm, NEWLINE
                 | "Syntax", ":", fixity, string, NEWLINE
                 | "Precedence", ":", integer, NEWLINE
                 | "Associativity", ":", associativity, NEWLINE
                 | "Render", ":", rendering, NEWLINE ;
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
conclusion       = "Conclude", ":", expression, NEWLINE
                 | "Conclude", ":", NEWLINE, INDENT,
                   expressionLines, DEDENT ;
context          = "Context", englishName, ":", NEWLINE, INDENT,
                   { clause }, (result | context), {result | context}, DEDENT ;
nameList         = identifier, { ",", identifier } ;
```

The file has a declaration prelude before its first result/context. Imports are in the initial import block. Definitions are ordered: signatures can refer to preceding declarations and imports. All fields must be unique except repeated typed `Let` clauses. A notation requires exactly one `Returns`, `Means`, and `Render`. With no `Syntax` field it is callable by its English name. An operator declaration also remains callable by that name.

Every header parameter must be declared exactly once in the `Let` clauses and in header order. Additional `Let` binders before the header parameters are implicit parameters inferred from the typed application. Both colon and `be` forms, and grouped typed lets, have identical binding semantics here and in results. An unused implicit parameter cannot be inferred and must cause an unresolved-parameter error; there is no guessed dimension/type value.

Infix notation requires two header parameters and all three syntax fields. Prefix/postfix notation requires one header parameter, `Syntax`, and `Precedence`, and forbids `Associativity`. Call-only notation forbids precedence/associativity fields. Proposed precedence values are integers from 0 through 100, with larger values binding more tightly; calls bind tighter than all operators.

`Type` is declaration syntax, not a privileged mathematical type name. Its parameters have ordinary imported type expressions; there are no compiler-defined `dimension` or `scalar` parameter kinds. Its `Means` must elaborate to a type/sort expression under those parameters. A module may introduce a readable name for a universe through that same Lean bridge; the exact universe-parameter syntax remains an open item below.

An optional article in `Let x be a ...` is part of a declared phrase form. The compiler must not blindly strip words from arbitrary mathematical names. `Let x = T` is rejected when the right-hand side is a type expression: type naming belongs to `Type ... Equals:`. The punctuation `=` in a local definition introduces a value; in an expression it is an imported operator spelling. These are distinct grammatical positions.

## 4 Expression syntax and operator parsing

Let `S` be the visible syntax environment. A notation syntax record is:

```text
SyntaxRecord(spelling, fixity, precedence, associativity, candidateIDs)
```

All imported overloads sharing a spelling and fixity must agree on precedence and associativity. Otherwise importing the combination is an error before mathematical type checking. Syntax trees cannot depend on which overload eventually fits. A symbol used both as prefix and infix has separate syntax records, selected by syntactic position.

An expression is a name reference, a decimal token, a parenthesized expression, a call with comma-separated expressions, or an application of a prefix/infix/postfix syntax record. The parser records the record's candidate identities without yet choosing a mathematical operation.

For a precedence-climbing parser, an infix operator of precedence `p` parses its right operand with minimum precedence `p+1` when left-associative and `p` when right-associative. Nonassociative operators reject an unparenthesized continuation at that same precedence on either side. Prefix operators parse their operand at their declared binding power. Parentheses override all binding powers. At a shared precedence, incompatible associativity requires explicit parentheses rather than a source-order tie-break.

For example, a standard arithmetic module can assign prefix minus precedence 70 and exponentiation precedence 80, making `-x^2` mean `-(x^2)`. These values and spellings are module declarations, not compiler constants. Chained comparisons require explicit logical conjunction or future declared chain syntax; the parser does not silently convert `a < b < c` into a conjunction.

## 5 Identity and module scope

A declaration has a qualified identity `d`, separate from its display name and generated Lean identifier. A reference stores `d`; it never relies on comparing a rendered name to strings such as `Matrix`, `Function`, or `Natural`. Local binders likewise have unique identities.

A module is checked in an environment made from its own direct imports, their explicit exports, and its preceding declarations. It does not receive the importing document's local environment. Cycles are rejected in this first version. Importing the same canonical file more than once does not duplicate declarations.

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
viable(C, arguments, expectedType) = checked candidate applications

|viable| = 0    => type/overload error
|viable| = 1    => selected application
|viable| > 1    => ambiguity error
```

Aliases to the same declaration identity do not create extra candidates. Distinct declarations remain ambiguous even when their bodies happen to be definitionally equal. Resource exhaustion or unresolved metavariables are reported as incomplete elaboration, not silently treated as evidence that one other candidate is uniquely valid. No specificity ranking or import-order priority is implied by this draft.

A decimal token is handled by imported literal interpretation declarations in the expected type context. Without a unique contextual interpretation or an explicitly imported unique default, it is an error. The compiler does not default to a type spelled `Natural`. The literal-declaration concrete syntax and the exact coercion/typeclass visibility policy remain open; no implementation may silently fill those gaps with name-based rules.

## 8 Declaration and statement meaning

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

A conforming implementation of this draft must demonstrate:

| Property | Required counterexample or check |
| --- | --- |
| Structured type preservation | The matrix-of-functions statement has the intended nested type, not the Lean-accepted matrix-to-scalar type |
| Binding hygiene | Renaming a type/operator preserves behavior; a Lean keyword used as a Clean object/result name still translates |
| Module independence | A missing module dependency cannot be repaired by an unrelated import in the caller |
| Determinism | Permuting independent imports preserves resolved identities and mathematical meaning |
| Overload discipline | Zero and multiple viable overloads are errors; no first-match fallback |
| Literal discipline | An unconstrained numeral with no declared default is rejected |
| Uniform parameters | Fixed dimensions and inferred dimensions produce compatible Lean applications; neither has an ad hoc internal kind |
| Proposition distinction | A hypothesis label cannot masquerade as a proposition expression |
| Presentation grouping | Inverse and transpose of products visibly preserve grouping |
| Extensibility | A new type and operation work through modules without changing compiler branches |

Lean acceptance alone is not a preservation test. Test fixtures must also check the expected proposition/type and selected declaration identities. The 80 existing corpus proofs are regression coverage, not evidence that these general properties hold. A mechanically verified compiler or formal soundness proof is not claimed.

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
