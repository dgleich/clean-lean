# Clean Mathematics

Local, declarative syntax highlighting for `.clean` mathematical statements and
definitions. No language server or semantic validation is included.

From the checkout root:

```sh
code --extensionDevelopmentPath="$PWD/editors/vscode" .
```

Use a theme of your choice. Keyword spelling is case-insensitive; mathematical
names and metadata remain as written. The shared grammar treats rendering,
attribution, and inline Lean bodies as separate lexical regions.

See `editors/README.md` in the checkout for installation in VS Code, Emacs, and
Vim, validation commands, and current limitations. This extension is local only.
