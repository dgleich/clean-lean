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
Only full-line `#` comments belong to Clean. No inline comment toggle is enabled.

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
