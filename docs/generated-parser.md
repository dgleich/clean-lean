:::llm gpt-6 2026-11-05 role=assisted

# The generated Clean parser

[grammar/clean.lark](../grammar/clean.lark) is executable syntax: it generates
[cleanlang/generated_parser.py](../cleanlang/generated_parser.py). The compiler uses
that generated parser for document structure, declaration signatures, type constructors,
object clauses, condition/assumption lists, and expressions. The old handwritten
expression parser, signature scanner, assumption-list splitter, and context/module
block recognizers have been replaced.

Use this source when reviewing or changing syntax. Do not edit the generated Python.
The previous `conditions.ebnf` fragment has been retired; condition productions are
part of the executable grammar and their semantic contract remains in
[conditions.md](conditions.md).

## Generate and check

From the repository root:

```sh
python3 -m pip install -e '.[parser,bibtex]'
python3 tools/generate_parser.py
python3 tools/generate_parser.py --check
python3 -m unittest discover -s tests -v
```

The optional `parser` development extra pins Lark 1.3.1 and interegular 0.3.3.
Ordinary Clean translation needs neither package: the checked-in parser includes
its standalone runtime. BibTeX remains a separate optional dependency.

Generation uses Lark's **strict LALR(1)** mode and lexical collision checks. A
shift/reduce conflict, reduce/reduce conflict, or competing terminal pattern is a
build failure. The generator also requires a finite-state analysis for every terminal;
unsupported regex analysis cannot silently count as disjointness. No silent first-choice or default-shift rule is permitted. See the
[Lark generator documentation](https://lark-parser.readthedocs.io/en/stable/tools.html)
and [strict-mode guide](https://lark-parser.readthedocs.io/en/stable/how_to_use.html).
The standalone runtime retains Lark's upstream MPL-2.0 license notice. Its code is
not attributed to an LLM; provenance distinguishes the upstream runtime from tables
derived from the authored Clean grammar.

The generator fixes the Python hash seed and renumbers parser states by a
breadth-first traversal with sorted starts and sorted transition symbols. This
changes state identifiers only, not the accepted grammar or semantic actions.
The generated file records the grammar's SHA-256. `--check` reconstructs and compares
the complete artifact, including runtime and tables, byte for byte. A default unit
test checks the source fingerprint even without development dependencies. With the
parser extra installed, tests also regenerate and exercise intentionally conflicting
grammars and token patterns.

## Stages and boundaries

1. **Layout and continuation.** The existing explicit scanner rejects tabs, validates
   indentation increases of at least two spaces and matching dedents, and joins
   incomplete expressions while preserving source locations. Its rules remain in
   `core._expression_lines` and `normalize_layout`; they are not generated. They do
   not resolve mathematical names or types. A small layout adapter supplies INDENT
   and DEDENT tokens to the generated parser.
2. **Generated document grammar.** Parse imports, declarations, contexts, result
   blocks, expression blocks, and clause ownership. Context declarations must precede
   children; every result has one final conclusion. A logical-line lexical mode keeps
   opaque fields intact. Newlines remain significant outside explicit continuation.
3. **Generated fragment grammars.** Validate each signature, type constructor,
   expression, assumption list, import, alias, and field payload. The document adapter
   retains these parse trees. No symbol environment selects an expression parse.
   Raw Lean bodies, LaTeX, source metadata, and rendering/name templates are deliberately
   opaque fields, subsequently checked by their respective interpreters.
4. **Syntax normalization.** Remove grouping-only nodes; fold the grammar's left
   associative chains and right recursive implication/power productions into the
   existing AST. Normalize logical/operator aliases. This pure transformation is
   specified by `syntax.expression_tree` and independently tested.
5. **Binding and translation.** Existing explicit modules resolve names and type
   phrases, check scopes and dimensions, construct definitions and hypothesis names,
   and emit Lean/LaTeX. Imported prose type patterns and attribution/BibTeX/template
   mini-languages retain their own existing interpreters. Lean still checks emitted
   targets. Generating syntax does not generate the mathematical semantics.

The document and fragment grammars are entry points in one grammar file, rather
than independent handwritten recognizers. The logical-line stage identifies block
ownership; the fragment stage validates its contents. Both must succeed. Source
positions are remapped through layout normalization and retained in errors and AST
nodes. An import error identifies the imported file.

## Lexical and compatibility choices

Fragment input receives one ignored ASCII space as its explicit end boundary.
Keyword lookaheads use that boundary instead of unsupported regex end/word anchors;
the adapter removes it if an opaque token consumes it. It is never part of a Lean
body, template, name, or mathematical expression. Full documents already end in a newline.

Expression words `and`, `or`, `not`, and `function` are case-insensitive reserved
keywords. They cannot be variable names or words within a callable name. This resolves
the old environment-dependent ambiguity between, for example, a call named
`not positive` and negation of `positive(x)`. Such declarations now fail syntactically;
no registered name can change precedence. Type constructors, metadata, and result
or context titles have their own lexical contexts, so `Function(Real,Real)` and an
English result title containing “and” still work.

Other keywords are reserved only in their clause position: a condition named
`condition` can still be called, including after comma continuation. Identifiers and
mathematical names remain case-sensitive. Operator keywords cannot split a longer
identifier such as `notable`. Multiword calls are parsed as names before binding;
an unknown call has a unique syntax tree and subsequently fails name resolution.

Commas separate assumptions at list level; nested calls, types, and lambdas own their
commas through parentheses. Colons inside lambda/type arguments cannot become
assumption labels. Operator precedence and associativity are grammar productions.
The existing type checker still rejects ill-typed comparisons; this migration does
not introduce mathematical comparison-chain sugar.

Unmatched or missing delimiters, an empty context, a missing/followed conclusion,
and malformed headers are now generated-parser syntax errors. Some diagnostics
therefore differ from the earlier handwritten parser. Existing valid corpus and
study targets are preserved. No new mathematical notation is introduced by this migration.

## What this establishes

The fixed generated grammar has one LALR action for every accepted token/state pair,
with strictly checked lexical choices. Parsing does not consult types to resolve
alternatives. Grammar changes that violate those conditions fail generation. If a
future syntax needs generalized parsing, that requires an explicit ambiguity policy
and acceptance work; disabling strict mode is not an acceptable shortcut.

`tests/test_generated_parser.py` supplies independent precedence, signature, document,
assumption, and lambda trees; negative syntax cases; opaque-field boundaries; token
boundaries; source locations; regeneration checks; and resource-failure classification.
Memory/recursion exhaustion is reported as **incomplete syntax analysis**, not a
successful unique parse or proof that no parse exists.

This establishes the generated-syntax boundary, not whole-language Lean elaboration
conformance. Existing obligations for module-defined type phrases, implicit arguments,
coercions, typeclass search, universes, and `From Lean` remain documented in the
[acceptance contract](language-change-acceptance.md). The independent canonical target
checks for definitions, lambdas, and conditions, plus the corpus and magnetic proof
checks, continue to exercise the unchanged translation layer.
:::

:::llm gpt-6 2026-11-05 role=assisted

The `--` and nested inline `/- … -/` comment masking pass is a deterministic lexical stage before the generated parser and
before layout/continuation. See [comment lexing](spec.md#comment-lexing-implemented).
The grammar consumes the masked source; comment text never participates in parser
conflict resolution or Lean elaboration. No parser-table change is needed for this
lexical extension. Comment erasure/target invariance and error cases are exercised
in `tests/test_layout.py`.
:::

:::llm gpt-6 2026-11-05 role=assisted

Literate payloads use the explicit source-mode scanner in `cleanlang/literate.py`.
It emits private prose/documentation tokens with immutable payload records before
layout. The generated grammar owns placement and attachment; typed elaboration
does not choose those parses. See [the lexical and semantic contract](literate-text.md).
:::

:::llm gpt-6 2026-11-05 role=assisted

Shared prose productions expose both header and local-clause token categories in
some LALR states. Their `Define` spellings are disjoint lexically: a definition
header contains no `=`, while a local `Define name = expression` line requires it.
Fragment productions still validate exact names, signatures, and expressions.
This eliminates a strict lexer collision without priority or first-match rules.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Structures and projections

The generated grammar now recognizes Structure headers, Constructor metadata,
postfix dot fields, function-field application, and field references in type
arguments. A trailing dot continues an expression under the existing layout rule.
Dot syntax is lexical; no type information selects its parse. Existing named calls
are unchanged. Strict LALR/lexer generation remains required. See the
[structure contract](structures.md) for normalized trees and semantic restrictions.
:::

:::llm gpt-6 2026-11-06 role=assisted

`Universe` is now a metadata-line keyword, alongside Constructor and Render.
The generated strict grammar fixes the line's syntactic role; Type/Structure
interpreters alone permit it and validate its canonical integer value. It adds
no expression operator or ambiguity resolution rule. See
[fixed universe levels](fixed-universes.md).
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

Root type annotations now admit the existing parenthesized expression production,
with `named_type_ref` factored out to avoid duplicate derivations in type arguments.
The neutral tree remains `ComputedIndex`; its root interpretation is evidence for
a condition. Strict LALR generation and lexer collision checks remain enabled.
See [evidence](evidence.md) for the contextual semantic rule and restrictions.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Bound type-argument grammar

The parser now distinguishes `Head(x: Domain,Codomain)` as BoundTypeApply from
ordinary type application. The colon is preserved inside parenthesized type-text
envelopes, then validated by the structural type grammar. Strict LALR and lexer
checks still pass without conflict defaults. No new keyword or lexical highlighting
category is required. Semantic elaboration remains explicitly disabled; see the
[dependent-function contract](dependent-function-types.md).
:::
