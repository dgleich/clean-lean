:::llm gpt-6 2026-11-10 role=assisted

# Contextual function-family comparison experiment

**Historical isolated prototype; the repair is now integrated in the working compiler.**
The validation narrative below records the experiment before integration. See the
[integrated rule](../../docs/proof-beta-comparison.md#integrated-contextual-call-congruence). The production defect
and minimal source are documented in
[proof-beta-comparison.md](../../docs/proof-beta-comparison.md#open-contextual-family-comparison-regression).
The expanded production regression has six tests: four positive comparison/hash
assertions currently fail, while free-variable separation and emission preservation
pass. The same six tests pass in this experiment.

The patch is based on `47a7452043ae9fc506ece3fd6d0c8dbc49085189`. Reproduce with:

```sh
LAKE=lake python3 studies/contextual-family-comparison/verify.py
```

The driver uses the shared pinned-checkout helper and applies the stored patch;
it does not patch the working checkout. The patch includes the compiler experiment,
two additional regression cases, and migrated independent choice-study expectations.
The latter retain the explicit Type/Set/Proposition, membership and equality
wrappers; no generated body is copied into its expected counterpart.

## Experimental comparison rule

Parsing, overload resolution and emitted Lean are unchanged. This experiment
replaces only the construction of comparison keys after successful elaboration.
It does not remove the ordinary normalizer's hidden-binder argument guard.

1. Establish the existing comparison identity pool in the caller scope. Reserve
   the environment, source tree and caller identities. Re-elaborate the complete
   original expression inside that pool, unless it has a synchronous fresh-check
   witness and its tree contains no binders. Public/stored expressions never
   obtain that witness merely by possessing checked-argument metadata.
2. Run the existing ordered normalizer on the checked expression and require its
   determined type to stay unchanged. For a non-call result, retain its checked
   Lean template. This adds no reduction inside an unapplied lambda/quantifier.
3. For a checked call or selected operator, validate its declaration identity.
   Recursively construct comparison templates for its checked explicit arguments.
   These expanded argument templates are **not** passed to call elaboration,
   dependent inference, substitution or operator selection as authored arguments.
4. Reconstruct the selected native call shell from its recorded declaration and
   ordered checked implicit arguments. Render type arguments through the existing
   renderer and inferred dependent values through the existing reifier. Before
   using any expanded child, require the shell with the original argument targets
   to equal the already checked call target exactly. A mismatch is an error, not
   permission to choose another overload or silently preserve an incompatible key.
5. Fill that validated shell with the child comparison templates. Preserve its
   implicit arguments; this experiment does not infer new arguments from expanded
   children. Abstract the owned binder identities with the existing ScopedKey
   rule. If no owned identity occurs, retain the string-key representation. Restore
   the previous pool on every exit, including errors and nested comparisons.

This is congruence at a fixed checked native application, not evaluation of a
`Means` body. Authored definitions may expand by the existing normalizer; native
adapters remain opaque. Ordinary expression emission and stored proof indices
continue to retain the original source calls and lambdas.

## Evidence and limits

The final isolated revision passes 102 focused tests covering contextual families,
quantified beta, applied indices, retained scopes, binding identities, nested
families, fresh condition checking, inferred conditions/values and scoped keys.
It passes three exact native target checks and two native equivalence proofs for
the minimal regression. The migrated choice verifier passes seven exact targets
and three proofs. Its original expectations failed on wrapper identity and target
lookup, independently of this comparison repair.

An initial prototype rechecked every source tree and doubled two call-count
expectations (16 rather than 8; 6 rather than 3). The final prototype preserves the
synchronous witness for binder-free source trees and both unchanged tests pass.
This is bounded operation-count evidence, not a claim about overall performance.

Production integration, full-suite and topology/corpus validation remain pending.
The production full run is still active on the earlier compiler. The experiment
also needs a broader audit of dependent implicit arguments, projection/application
contexts outside the selected call cases, stale metadata and resource accounting.
No completion or full language-conformance claim follows from these focused tests.
:::


:::llm gpt-6 2026-11-10 role=assisted

## Additional contract and corpus validation

Six focused contract checks now cover public-entry rejection of stale checked
argument metadata, original-expression preservation, validation of the native call
shell, comparison-pool restoration after both success and failure, and rejection
of changed retained declaration identities. All six pass in the isolated compiler.
The pinned driver rerun passes all 108 tests in 22.482 seconds, followed by
ten exact native checks and five Lean proofs.

The isolated compiler regenerated all 92 corpus proof fixtures and Lean checked
them successfully. The resulting VerifiedCorpus.lean is identical to the working
artifact after removing provenance-marker lines; the comparison repair did not
change those emitted statements or proofs. Existing unused-variable/simp warnings
remain nonfatal. This is corpus evidence, not a claim that every native target is
unchanged for every accepted Clean input.

Both full regressions remain live: one on the unchanged production compiler and
one on the isolated comparison prototype. A separate batch is checking all eighteen
topology verifiers. The first 11 passed, including the extreme-image study; the
batch has not yet finished. No slow job was restarted or counted as passed because
an observation interval expired.
:::


:::llm gpt-6 2026-11-10 role=assisted

## Completed topology batch

All eighteen topology verifier processes exited successfully on the isolated
prototype. All 37 checked-in Lean artifacts in the topology directory are unchanged
relative to production after removing provenance-marker lines and outer whitespace.
[The validation record](topology-validation.json) preserves each command, exit code,
duration, normalized artifact hash and the prototype patch hash. The 92-proof corpus
also passes with unchanged emitted output under the same comparison.

These checks exercise the existing topology examples and their independent expected
targets. They do not prove the outstanding interlevel, BigSteps or Mayer–Vietoris
paper theorems. Both full regressions remain active, and the repair remains isolated.
:::
