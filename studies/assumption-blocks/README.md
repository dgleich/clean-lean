:::llm gpt-6 2026-11-10 role=assisted

# Named assumption blocks: isolated prototype

Status: implemented in a reproducible isolated checkout, **not production**.
The baseline is `8763d4689eb1aabbac58aa1de44208b072024d1b`. The working compiler
is left unchanged while its existing full-suite validation remains active.

The topology signed-square example exposed this missing authored form:

```clean
Assume commutes:
  module composition(field,L,M,P,f,h) =
  module composition(field,L,N,P,g,k)
```

It has the same assumption name, proposition, scope and Lean binder as the inline
form. It is usable inside either a Result or a Context. The prototype makes no
change to ordinary named or automatically named inline assumption lists.

## Precise grammar and normalization

The generated document grammar permits an optional expression block after an
assumption logical line in those two positions:

```text
assumption clause := ASSUME_LINE NL [INDENT expression_line+ DEDENT]
```

The line token remains the existing case-insensitive `Assume`, followed by one
or more spaces and nonempty text. With children present, that text must be exactly
an existing valid assumption name followed by a colon, with no expression after
it. A bare `Assume:` block is not introduced. The normal assumption-name grammar
still controls names; no arbitrary header text becomes a valid label.

The existing lexical pass removes comments and processes parenthesized/operator
continuations before layout. The empty named header opens an expression region
for that pass, just as `Conclude:` does. Tabs remain forbidden; a new indentation
level must add at least two spaces; dedents must match an established level.
Remaining child logical lines are joined with one space in source order. They
must parse as exactly one labelled assumption under the existing assumption
parser. A top-level comma list in a named block is rejected. Commas inside calls
or binders are unaffected. Line breaks insert neither conjunctions nor commas;
word boundaries can still form a multiword name under the ordinary expression
grammar. Extra indentation without an existing continuation reason is rejected.

After validation, the normalized node is the existing assumption node containing
`Assume <name>: <expression>` and no child clauses. Its source line is the header
line. This is the source location for the hypothesis and block-level semantic
diagnostics; this prototype does not add a span map for individual body tokens.
Contexts inherit the same normalized assumption and preserve its original header
line. Existing duplicate-label and local-name collision checks apply unchanged.
An empty header without a body is invalid, as is a complete inline expression
followed by an indented body.

## Uniqueness and Lean correspondence

There is one layout nesting, one source-ordered concatenation, and one generated
parse of the labelled assumption. The single-item restriction is checked before
binding or type inference. No type-directed choice between block and inline
parses is made. Strict LALR and lexer conflict checks must pass when regenerating
the parser; no priority or first-success fallback is added.

The constructive translation rule is to use precisely the existing inline
assumption rule on that normalized node. Thus its selected proposition and named
Lean hypothesis binder are the same as for the inline spelling in the same
explicit environment, including every implicit argument and instance already
determined there. This preserves the existing translation obligations; it does
not establish general elaboration uniqueness for the rest of Clean.

## Reproduction and acceptance

```sh
LAKE=lake python3 studies/assumption-blocks/verify.py
```

Use the pinned parser development dependencies. The driver exports the pinned
baseline through `tools/study_checkout.py`, applies the three-file patch, and
regenerates the parser. It never patches the production compiler or hand-edits
generated parser tables. `test_generated_parser` also checks reproducible output.

The new tests independently specify hypothesis trees and header locations and
exercise indentation widths, keyword case, comments, context inheritance,
operator continuation, bound-variable commas, duplicate names, nonpropositions,
inline-plus-block rejection and rejection of top-level assumption lists. The
native check compares three layout variants with an independently authored Lean
proposition and proves it using its assumption. Existing generated-parser,
layout and condition tests run alongside these cases.

Validation on 2026-11-10: the pinned reproduction passed strict parser generation,
66 Python tests in 26.467 seconds, three layout variants compared to one independent
exact native target, and one kernel-checked proof. The initial test draft had an
invalid attribution and incorrectly expected a syntactically valid multiword-name
expression to fail parsing; both test expectations were corrected before this run.
No production behavior was changed by those corrections.

A broader `python -m unittest discover -s tests -v` run has started in the fixed
prototype checkout. At recording time its process was confirmed live; it had no
final result. That run is not passing evidence and does not include the separate
study tests unless explicitly invoked as above.

Full-suite validation, editor/browser treatment of a block header, and production
integration remain pending. The production topology specimen stays inline until
integration. A separate unlabelled block/list design is not silently introduced.
:::
