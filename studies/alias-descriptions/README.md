:::llm gpt-6 2026-11-07 role=assisted

# Readable transparent aliases

`Statements.clean` describes the same subtype as “selected elements” and “eligible
elements.” The generated Lean statements retain the underlying subtype exactly.
This study exercises singular/plural prose without changing mathematical meaning.
See [the contract](../../docs/alias-descriptions.md) for scope and fallback rules.

Run `LAKE=lake python3 studies/alias-descriptions/verify.py`: three independent
canonical statement comparisons and three proofs pass with the pinned toolchain.
`Generated.lean` contains statements; `Verified.lean` adds oracles and proofs.
The PDF was compiled twice and inspected. No overfull boxes or unresolved
references remain. Ten focused Python tests and twelve existing context tests pass;
the 92-statement corpus was regenerated and kernel-checked. Reference links,
search, mobile width and no-JavaScript rendering are checked separately.

The full-suite run is pending. The review browser snapshot is not yet rebuilt.
No claim of full language conformance follows from these focused checks.
:::
