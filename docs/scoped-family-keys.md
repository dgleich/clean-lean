:::llm gpt-6 2026-11-06 role=assisted

# Stable identities for saved family comparisons

The earlier family-index rule materialized a checked normal tree and compared its
Lean template. Adding a caller variable such as `clean_bound_0` changed the compiler's
fresh binder choice, so a saved map type could cease to match the same authored
family. The [saved-family specimen](../studies/dependent-functions/ScopedFamilies.clean)
reproduces this in both graded chain homology and graded relative homology.

## Scope and syntax

There is no new syntax. A typed local stores its original index and comparison key;
later locals cannot change that saved key. The new rule makes newly computed keys
agree with saved keys despite changes to unused caller names. Free caller names,
module identities, native templates and selected instances retain their meaning.
Direct binder expressions in authored indices remain rejected. The existing bounded
normalizer and its shadowing, inferred-parameter, native-body and beta boundaries
are unchanged.

## Owned identities and key construction

For a checked normal expression containing binders, materialize the whole tree as
before, with a private allocation pool active only during comparison. Ordinary
expression-binder allocation and dependent-function-binder allocation both use that
pool. Source emission uses their existing allocators.

Before allocating anything, reserve every identifier token in the explicit module
data, generated native declarations, original checked tree, caller names, caller
Lean expressions and caller types. Type reservation includes stored dependent binder
identities and value-index Lean templates. Reserve newly encountered locals before
each allocation. Select the least unused `clean_comparison_identity_N` in increasing
counter order, reserve it immediately, and record that the pool owns it.

Consequently an owned identity cannot coincide with a free caller or native token.
Every allocation is unique within the active pool, including allocations made while
checking nested dependent domains. No source spelling, guessed prefix, or substring
of an opaque native body grants ownership.

After successful whole-tree elaboration and the unchanged-determined-type check,
tokenize its selected Lean template with the existing identifier tokenizer. Preserve
all punctuation and non-identifier spans exactly. Encode each identifier as:

- `("owned", i)` for an identity allocated during this comparison, where i is its
  first-occurrence ordinal in the final template;
- `("free", spelling)` for every other identifier.

The resulting immutable ScopedKey retains both token kinds. Allocations used only
in intermediate checking do not appear in the key. This is structural comparison
data, not Lean syntax and not a rewritten emitted term. Separate compiler spelling
choices therefore give the same key when their owned identity/reference patterns
are the same. Free and owned tokens cannot collide.

Nested comparisons share the fresh allocation pool but snapshot the ownership set
on entry. An identity allocated before the nested comparison remains free in that
nested key. When an enclosing dependent function type abstracts its own bound
identity, it rewrites only matching free tokens to the existing outer-bound key;
owned tokens remain unchanged. This preserves the distinction between a family's
internal binders and surrounding dependent parameters. ValueIndex equality and
hashing use the immutable key. Binder-free comparisons retain their previous string
keys and outer abstraction rule.

Restore the prior allocation context in a finally block, on success or failure.
Nothing from the private allocation context changes emitted definitions, signatures,
local lets, explicit evidence or later ordinary binder allocation.

## Acceptance and limits

`tests/test_scoped_family_keys.py` independently checks token structure, saved-scope
stability, deliberate free-name collisions, dependent domains, outer abstraction,
nested materialization in a dependent domain, hash consistency and context restoration after an error. Existing family tests
check nested bound-versus-free occurrences, quantifier kinds, aliases, opaque native
bindings and shadowing. The old template rule rejects the new specimen; the current
rule accepts it. Two independent canonical Lean proposition targets retain every
local let and compiler-like user binder; both statements have native proofs.

This closes the recorded saved-key freshness failure. It does not add general
higher-order normalization, conversion inside function bodies, extensionality,
family congruence through opaque outer calls, or a resolved-name representation for
all module bindings. Those remain separate language obligations. Exhaustion still
means incomplete analysis rather than an equality or inequality result.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Validation checkpoint

The new specimen passes two exact canonical proposition comparisons and two proofs.
The previous template rule rejects the same authored file with a dependent-index
mismatch. The final focused run passes 67 tests, including error cleanup and nested
materialization under a dependent domain. No implementation change followed these
checks; later additions were tests and documentation only.

The existing 92-proof corpus, ten graded-relative targets/five proofs, four induced
homology targets/three proofs, and ten proof-family targets/five sort checks/five
proofs also pass. The strict generated-parser check and independent syntax-tree
fixture pass. The PDF compiled twice without overfull boxes and was visually checked;
reference search, links and mobile width checks pass. The first browser build was
terminated with exit 143, and its process was confirmed stopped before retrying.
The retry produced a 93-file browser snapshot with zero translation errors. Its
search, declaration navigation, imports, notes/export, reload, responsive layout
and no-JavaScript fallback checks pass.
:::

:::llm gpt-6 2026-11-06 role=assisted

The full regression suite passed all 519 tests in 1305 seconds. Three additional
scope-interaction tests were added after that run began; all are included in the
67 passing focused tests. No implementation changes followed the start of the
full run. The requirements inventory now records dependent function fields and
graded interfaces as implemented while retaining the actual pyramid/basis,
algorithm, relative-functor and exactness/excision obligations separately.
:::
