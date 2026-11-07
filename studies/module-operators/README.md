:::llm gpt-6 2026-11-07 role=assisted

# Explicit operator binding prototype

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

The prototype passes thirty-two independent canonical native targets and three proofs,
plus source-tree and dispatch checks. It verifies that renaming Scalar to Matrix
does not activate mathematical behavior based on the new display name; ambiguity
is rejected in either candidate order; missing declarations do not fall back to
built-in meanings; an interrupted candidate is not discarded; invalid arity does
not publish a partial callable; and operator rendering preserves grouping.

[LinearAlgebra.clean.proposed](LinearAlgebra.clean.proposed) adds matrix/vector
and scalar operations using inferred dimensions. [Statements.clean.proposed](Statements.clean.proposed)
states their multiplication/application law. The native fixture checks all selected
dimensions, adapters and application trees. Direct candidate mismatches are distinct
from nested errors, which must propagate even when another candidate succeeds.

This is an intermediate implementation step. It deliberately rejects unresolved
numeric operands. Dependent matching uses the existing bounded callable rule;
proof-family and module-scope interactions still need a wider overload audit. Declared
fixity/precedence, isolated module scope, the full foundation migration, editor
support and broad conformance remain unfinished. The main compiler's behavior and
current validation jobs are unchanged by this study.
:::

:::llm gpt-6 2026-11-07 role=assisted

The authored-body scope regression now captures visible binary bindings when a
definition is checked. If those bindings later change, comparison and producer
reduction retain the checked wrapper instead of reinterpreting its source body.
The independent native fixture checks the original authored addition body. This
conservative guard does not complete module isolation; the draft records the
remaining typed-expression and import-scope requirements.
:::

:::llm gpt-6 2026-11-07 role=assisted

The patch now applies to the declaration-scoped matcher and fresh-subtree
conversion implementation. Its mismatch tags cover direct comparison failures in
the current leaf matcher; nested failures retain their own owner and propagate.
The source-scope fix is preserved rather than replacing the matcher with its older
instantiated-codomain path. `git apply --check` and strict parser generation pass.

[ProofFamilies.clean.proposed](ProofFamilies.clean.proposed) adds a declared
natural equality and an overloaded proof-family application. Its use of `*` for
proof application is a dispatch stress fixture, not recommended mathematical
notation or a declaration in the standard library. Five additional
exact native targets check the adapters, a partially inferred named call, and
operator application. Valid caller evidence survives; the captured equation is
rejected. Candidate reordering preserves the selected application, while two
eligible proof-family declarations are ambiguous in both orders. Existing nested
failure and interrupted-candidate checks continue to pass.

Before the prefix extension below, the bounded total was twenty-one exact targets
and two statement proofs.
Both the already-patched checkout and the default fresh-copy/apply/regenerate
driver pass on the current compiler base.
A first fixture attempt used an arrow adapter spelling outside the existing
recognized template; it was corrected to `(A) → (B)`. A second attempt duplicated
a shared native Natural declaration when combining fixtures. The driver now
requires shared generated declarations to be byte-identical before reusing them.
Neither correction adds a main-compiler fallback or broadens the adapter contract.
The wider module-scope, literals, fixity, and foundation migration gates remain
unfinished.
:::


:::llm gpt-6 2026-11-07 role=assisted

## Prefix extension

[Prefix.clean.proposed](Prefix.clean.proposed) declares scalar and row negation,
logical negation, subtraction and a Clean-authored opposite function. Prefix and
infix minus coexist; existing parse precedence is preserved. The shared selector
checks one operand for a prefix and two for an infix, including the same dependent
mismatch ownership and ambiguity handling. Comparison normalization also uses
the declared prefix wrapper. Prefix bindings join the authored-body scope snapshot.

[check_prefix.py](check_prefix.py) adds eleven exact native targets and a proof,
for a current total of thirty-two targets and three proofs. It checks grouping,
keyword/Unicode negation, inferred dimensions, missing/ambiguous bindings,
reordering, invalid metadata, interrupted inference and scope-change opacity.
The rejected row candidate initially tried to elaborate its unknown dimension
while formatting an error. The patch now reports the already-known constructor
mismatch without evaluating the unmatched pattern. The no-dimension caller case
is a regression. Earlier fixture corrections used the existing typed Type header
and retained the parsed `not` token separately from normalized binding lookup.

These changes remain isolated; the main compiler and its running validation jobs
are unchanged. Numeral interpretation, module scope, declared precedence and
foundation/editor migration remain open.
:::
