:::llm gpt-6 2026-11-05 role=assisted

# Literate text and declaration documentation

This is the normative contract for the implemented first slice. Clean has no
`Section:`, `Chapter:`, or `Title:` document declarations. Authors put document
structure inside prose, for example `\section{Matrices}` in a LaTeX block.

## Authored forms and normalized nodes

```clean
Text:
    An ordinary paragraph, published in the paper.

Text latex:
    \section{Matrix products}
    We consider $n \times n$ matrices.

"""latex
\section{Matrix products}
We consider $n \times n$ matrices.
"""

/-! An ordinary paragraph, published in the paper. -/

/-- Explains the following declaration and appears in its Lean documentation. -/
Define square(x: Real): Real:
    Equals: x*x
```

`Text:` and untagged triple quotes select `plain`. An optional `plain`, `latex`, or
`typst` tag is case-insensitive; `Text` is also case-insensitive. Unknown tags are
errors. `Text latex:` and `"""latex` normalize to the same `Prose(latex, body)` node
when their normalized bodies agree. Untagged forms and `/-! … -/` normalize to
`Prose(plain, body)`. Source positions and the authored spelling are not mathematical
meaning. `/-- … -/` creates attached plain documentation, not a free prose node.
Documentation delimiters do not accept a language tag in this slice.

Plain prose is literal text, not a Markdown parser. Paragraph breaks survive;
LaTeX-special characters are escaped. Use a tagged block for headings, equations,
figures, or other backend syntax. A LaTeX body is not a formatting template:
`{x}` is literal, and braces are never interpolated by Clean.

## Lexical algorithm and boundaries

The scanner examines physical lines in source order before expression continuation
and layout. Tabs are forbidden in all modes. Private character U+E000 is reserved
for internal tokens and rejected in authored input, including prose.

At the first nonspace character of a physical line, outside an ordinary comment:

1. `Text [tag]:` on its own line selects an indentation-delimited payload. Blank
   lines and subsequent lines indented beyond the header belong to the payload;
   the next nonblank line at or before the header's column ends it. At least one
   nonblank payload line is required, and every nonblank payload line must be
   indented by at least two additional ASCII spaces. Remove the minimum indentation
   among nonblank payload lines. Preserve relative indentation and internal blank
   lines; remove leading/trailing blank lines. The header has no trailing comment.
2. `"""[tag]` on its own line selects a quoted payload. The tag directly follows
   the quotes, with no separating space. The closing delimiter is a line containing
   only `"""` at exactly the opener's indentation, optionally followed by spaces.
   Remove the opener's indentation from payload lines; a nonblank payload line
   may not dedent before the closer. Remove leading/trailing blank lines. An empty
   quoted payload is allowed. There are no escapes or nesting: use `Text:` if a
   literal closing-delimiter line must occur in the payload.
3. `/--` or `/-!` selects a documentation payload, closed by the matching `-/`.
   A single-line form is allowed. Nested `/- … -/` pairs count for delimiter
   matching and remain literal payload text. The closing line may have only spaces
   after its delimiter; the next declaration starts on a later physical line.
   Normalize with common-indent removal followed by trimming boundary whitespace.
   A missing closer is an error at the opener. Other inline occurrences of these
   documentation openers are errors rather than discarded comments.

Inside `Text:` and triple-quoted payloads, everything except the specified closing
boundary is literal: `--`, `/-`, quotes, apparent declarations, percent signs, and
hashes do not initiate Clean syntax. Inside documentation blocks only nested block
delimiters are recognized. Inside an ordinary block comment, apparent documentation
is simply nested comment text and is discarded. Existing single-line embedded
Lean/rendering fields keep their own payload syntax.

Each extracted payload becomes one private prose/documentation token at its header
column. Consumed lines remain blank so subsequent diagnostics keep their physical
line numbers. The generated grammar, not a binding or type checker, decides where
those tokens are permitted. A prose block cannot finish an incomplete expression.

## Placement, attachment, and imports

Free prose is allowed at top level and among a context's clauses and child
results/contexts. It is not a result clause, a mathematical definition body, or an
assumption. Existing context declarations must precede child results; prose does
not change that boundary. Imports and mathematical declarations still precede
results. Prose may appear before, between, and after them without changing their scope. A document
containing only prose is valid.

`/-- … -/` attaches to exactly the next declaration at the same indentation, across
blank lines and ordinary comments. At top level it may document `Define`, `Notation`,
`Condition`, a non-erased `Type`, `Result`, or `Theorem`. Inside a context it may
document a result. Orphaned documentation, consecutive documentation blocks,
documentation separated from its target by prose, and documentation on imports,
contexts, sources, or erased aliases are errors. Each accepted target must have
one generated Lean declaration to receive the docstring.

Importing a module imports its mathematical declarations and their documentation.
Its free prose is retained as Lean module documentation but is not inserted into
the importing paper. The import is not a textual paper include. The paper's own
prose retains authored order, including between results. Attached definition
explanations appear as prose at their authored position; definitions themselves
still have no general LaTeX renderer. Attached result explanations appear inside
the rendered result. This limitation is unchanged mathematical rendering work,
not an invitation to interpret prose as a definition.

## Constructive Lean and rendering map

Prose and documentation add no mathematical term, binders, assumptions, universes,
or declarations. Erasing them must preserve all canonical elaborated mathematical
targets and their types, as well as generated mathematical identifiers.

- A free prose node emits one Lean `/-! … -/` documentation command. Imported module
  prose precedes generated helper definitions; the paper's prose remains ordered
  among its generated result statements. Tagged bodies are fenced with their
  language tag for Lean's documentation display.
- Attached definition documentation emits `/-- … -/` before that definition.
  Attached result documentation is combined with the existing attribution docstring
  into a single `/-- … -/` before its proposition definition.
- For Lean comment-delimiter safety, every literal `/-` becomes `/ -` and every
  literal `-/` becomes `- /` in generated documentation. This fixed transformation
  prevents payload text from becoming Lean commands. The stored Clean body is intact.
- Plain prose is escaped by the existing LaTeX text escaper and ends a paragraph.
  LaTeX prose is emitted verbatim. A Typst body is preserved in the parsed document
  and Lean documentation; LaTeX rendering fails explicitly on it. There is no
  Typst document renderer yet, and no automatic TeX-to-Typst conversion.

The generated parser has dedicated prose and attached-documentation productions.
Lexical modes, delimiters, normalization, and placement specify one document tree;
no imported vocabulary chooses its shape. The mapping above specifies one set of
Lean documentation commands alongside the unchanged mathematical terms. General
Clean elaboration uniqueness obligations remain those of the existing acceptance
contract; this extension does not discharge them.

## Checks and remaining work

`tests/test_literate.py` supplies independent payload/tree expectations, equivalent
spellings, placement errors, import behavior, source locations, rendering order,
comment interactions, and delimiter-safety cases. `tools/check_literate_targets.py`
checks canonical Lean terms/types and retrieves emitted declaration docstrings.
The specimen `examples/literate.clean` builds a LaTeX paper fragment and Lean file.

Pending: Typst rendering, Markdown interpretation, prose-to-declaration references,
inline bound Clean mathematics, general definition rendering, documentation dialect
tags on `/--`. No `Section:` construct
is proposed as a workaround. Prose is informal even when adjacent statements have
been checked; it is not a machine-checked proof.
:::
