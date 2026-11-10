:::llm 2026-10-23 role=assisted

# Editing Clean mathematics

The editor files provide **lexical highlighting**, not a second Clean parser.
They neither validate statements nor certify a unique Lean target. Keywords are
case-insensitive; mathematical names are preserved. Mathematical vocabulary comes
from modules, so there is no hardcoded list of privileged types/functions.
Attribution, rendering, and inline Lean bodies receive separate colors; Clean
operators inside those fields are not interpreted as Clean expressions.

## VS Code

From the repository root, open a development window with the local extension:

```sh
code --extensionDevelopmentPath="$PWD/editors/vscode" .
```

Open any `.clean` file; the language name is **Clean Mathematics**. This is a
self-contained declarative extension with no activation code, server, dependency
installation, or network service. It sets spaces and a two-space editing default;
the language still accepts any valid indentation width of at least two spaces.
The basic indentation rule is a convenience, not a formatter. It does not attempt
to infer mathematical continuation or rewrite existing indentation.

For persistent local use, copy `editors/vscode` into your VS Code user extension
folder with a distinct folder name such as `clean-local.clean-mathematics-0.1.0`
and reload the editor. Keep the source directory in this repository authoritative;
copy again after changing the grammar. This project does not install or publish
an extension automatically.

The portable grammar is
[`vscode/syntaxes/clean.tmLanguage.json`](vscode/syntaxes/clean.tmLanguage.json).
VS Code's [TextMate grammar documentation](https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide)
explains how token scopes map to themes. The offline browser uses this grammar's
single-line match/capture rules as well. Grammar changes should preserve that
supported subset or deliberately extend the browser tokenizer.

## Emacs

Add to your init file, substituting your checkout location:

```elisp
(add-to-list 'load-path "/path/to/clean/editors/emacs")
(require 'clean-math-mode)
```

`.clean` buffers select `clean-math-mode`. It enables font-lock, spaces rather
than tabs, and a two-column tab width. Indentation remains under author control;
there is no speculative structural formatter. Use `M-x clean-math-mode` in an
already open buffer.

## Vim / Neovim

Add to `.vimrc` (or the equivalent Vimscript configuration for Neovim):

```vim
set runtimepath^=/path/to/clean/editors/vim
filetype plugin on
syntax enable
```

For Neovim's Lua configuration, use
`vim.opt.runtimepath:prepend('/path/to/clean/editors/vim')` before enabling filetype
plugins/syntax. `.clean` files select `cleanmath`, with spaces and a two-space
shift width. In an existing buffer use `:setfiletype cleanmath`.

## Boundaries and checks

TextMate, Emacs, and Vim use different highlighting engines. Native Emacs/Vim
rules mirror the same lexical categories, but are maintained separately. They are
not guaranteed byte-for-byte identical. None provides semantic diagnostics,
completion, rename, go-to-definition, proof checking, or a formatter. A future
language server should get those capabilities from the authoritative compiler;
a Tree-sitter parser would need its own conformance work and is not added here.
Full-line and trailing `--` comments and nested `/- … -/` blocks are supported.
Blocks may occur inline. VS Code enables line and block comment toggling. Embedded
Lean/rendering fields keep their own syntax. The browser uses the compiler's exact
comment spans before applying portable TextMate match rules. Native editor rules
remain lexical approximations, particularly when comments precede opaque fields.
Emacs rescans the buffer prefix to recover block nesting; incremental highlighting
and performance tuning remain future work.

`Text:` bodies and triple-quoted bodies are displayed as prose; `/--` and `/-!`
have documentation highlighting. The offline browser uses exact scanner regions.
Editor grammars remain lexical approximations; source validation remains authoritative.

Checks:

```sh
# Python highlighter preserves source text and escapes markup:
python3 -m unittest discover -s tests -v
# Optional tokenizer test dependencies, isolated outside the checkout:
npm install --prefix /tmp/clean-highlight-check vscode-textmate@9.3.2 vscode-oniguruma@2.0.1
NODE_PATH=/tmp/clean-highlight-check/node_modules node tools/check_textmate.cjs
vim -Nu NONE -n -es -S tools/check_vim.vim
emacs --batch -Q -l tools/check_emacs.el
```

At this checkpoint the real TextMate/Oniguruma scope checks and Vim runtime checks
passed. Emacs is not installed in the development container, so its supplied ERT
check has **not run**. Neovim was not separately exercised. VS Code's tokenizer
was exercised through TextMate/Oniguruma; the full VS Code application was not
available. No language grammar or compiler behavior changed in this work.

Compact signatures such as `Notation cos(x: Real): Real:` are highlighted as a
declaration name followed by a signature region. This coarse lexical region does
not parse dependent types; compiler checks decide whether the signature is valid.

:::llm gpt-6 2026-11-06 role=assisted

The staged `Function(n: Natural,Vector(n,Real))` spelling needs no new lexical
category. Representative TextMate and Vim checks pass for the typed declaration;
an Emacs ERT case is supplied but remains unrun because Emacs is unavailable.
Highlighting does not imply semantic support: the type checker still rejects the
bound function-type form while its semantic implementation is pending.
:::

:::llm gpt-6 2026-11-10 role=assisted

## Display of the pending language prototypes

VS Code/TextMate, Vim and Emacs rules recognize `Literal:` metadata and named
assumption labels, including a header such as `Assume zero contents:`. Digits and
punctuation in `(0: Vector(V.size,Complex))` use the existing lexical rules;
mathematical type names are not hardcoded. A colon inside a condition argument
must not turn the argument into an assumption label. Comment and literate-text
boundaries still take precedence.

These display rules also cover experimental files. They do **not** imply that the
production parser accepts literal metadata or indented assumption blocks. See the
[combined prototype status](../studies/composed-language/README.md). No new
experimental auto-indent rule or formatter is enabled by this highlighting change.

Validation on 2026-11-10: native TextMate/Oniguruma and Vim checks passed, along
with eleven browser-highlighter checks (four new cases and seven existing
text-preservation, comment, escaping and prose regressions). The Emacs rules and ERT specimen were
updated, but native Emacs validation remains pending: an unpacked temporary Emacs
28.2 runtime crashed during a minimal startup check before loading this mode.
That environment failure is not evidence that the mode works or fails. The runtime
was kept outside the repository; no user editor configuration was modified.

The offline browser consumes the TextMate match/capture rules. Its tokenizer was
checked directly; this does not regenerate the full `docs/review.html` snapshot,
whose repository-wide collection remains a separate pending task.

```sh
NODE_PATH=/path/to/node_modules node tools/check_textmate.cjs
vim -Nu NONE -n -es -S tools/check_vim.vim
emacs --batch -Q -l tools/check_emacs.el
PYTHONPATH=tests:. python3 -m unittest test_editor_prototypes -v
```
:::
