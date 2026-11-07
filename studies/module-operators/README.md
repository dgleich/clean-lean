:::llm gpt-6 2026-11-07 role=assisted

# Explicit binary operator binding prototype

This study tests the [module-operator migration draft](../../docs/module-operators.md).
It is isolated: `Operators.clean.proposed` is not accepted by the main compiler,
and `prototype.patch` is not an enabled compatibility layer or a second registry.

Run from the repository root:

```sh
LAKE=lake python3 studies/module-operators/verify_prototype.py
```

The driver copies tracked files to a temporary directory, applies the patch,
regenerates and strictly checks the parser, and then checks the proposed module.
The main worktree is not modified. The generated native fixture is retained for
review as [PrototypeVerified.lean](PrototypeVerified.lean). To regenerate it, pass
an already patched compiler directory as the driver's positional argument and
copy its checked OperatorAcceptance.lean file after success. The dependency checkout is reused through a
read-only-use symlink; Lean runs only on the generated fixture in the temporary
copy. The patch intentionally omits generated_parser.py; the pinned generator
produces it from the patched grammar.

The prototype passes five independent canonical native targets and one proof,
plus source-tree and dispatch checks. It verifies that renaming Scalar to Matrix
does not activate mathematical behavior based on the new display name; ambiguity
is rejected in either candidate order; missing declarations do not fall back to
built-in meanings; an interrupted candidate is not discarded; invalid arity does
not publish a partial callable; and operator rendering preserves grouping.

This is an intermediate implementation step. It deliberately rejects unresolved
numeric operands and dependent operator signatures. Unary operators, declared
fixity/precedence, isolated module scope, the full foundation migration, editor
support and broad conformance remain unfinished. The main compiler's behavior and
current validation jobs are unchanged by this study.
:::
