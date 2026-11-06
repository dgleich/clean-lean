:::llm gpt-6 2026-11-06 role=assisted

# Checked dimension names

[Statements.clean](Statements.clean) demonstrates local dimension aliases in
matrix theorems, a literal dimension in an explicitly indexed call, and a dimension
stored alongside a vector in an authored record. The mathematical identities are
standard; the new work is their precise Clean interpretation.

[Statements.lean](Statements.lean) contains translated propositions.
[Verified.lean](Verified.lean) compares five independent native targets and proves
all four statements. [Statements.pdf](Statements.pdf) shows their rendered form.
The native targets preserve every let, dimension argument and inferred instance;
they are compared without unfolding away the distinctions being checked.

Run `LAKE=lake python3 studies/dimensions/verify.py` from the repository root.
The [language contract](../../docs/dimension-indices.md) specifies parsing,
representation, ordered inference, substitution and remaining limitations.
This does not establish any of the pending topology research theorems.
:::
