:::llm gpt-6 2026-11-07 role=assisted

# Checked annotations with free local references

[AnnotatedTypes.clean.proposed](AnnotatedTypes.clean.proposed) exercises a callable
inside a vector dimension, a TypeValue expression, and a quantified condition whose
inner proof domain depends on its outer vector binder. A caller's local `count`
function must not replace the module function used by the definitions.

This experiment extends the carrier, bound-call and proof-binding patches. The
previous explicit rejection of calls inside annotations is removed by preserving
checked type objects and their local dependencies. It is not enabled in main.

## Representation and translation rule

The source parser is unchanged. When resolving a stored type annotation, check it in
its original lexical environment and retain three components: display spelling,
checked semantic Type, and the names of its free local references. Module-call heads
inside that Type already retain their explicit target templates. They are not free
local references. Type-variable occurrences count as local only when their binding
has type Type; ordinary value occurrences come from the semantic index tree.

Computed and proof indices now retain a resolved tree in addition to their diagnostic
JSON spelling. The resolved tree is authoritative for substitution, comparison and
re-elaboration. JSON spelling alone is not a serialization of the resolved semantic
object. Existing syntax-only indices without a resolved tree retain their explicit
legacy path; normal checked factories populate the resolved tree.

Substitution operates on the stored Type and only the recorded free local references.
It updates the reference set from inserted actual arguments, without discovering new
bindings by reparsing display text. An annotation's local references are rebound to
the checked locals in the current elaboration scope before Lean emission. Thus an
outer quantified variable can receive a fresh Lean binder while an inner proof domain
still refers to precisely that variable. Module template validation remains recursive.

The prototype stores these components in an immutable string-compatible Annotation
object so existing display and token-scanning consumers retain their source interface.
Equality and hashing include the semantic Type and reference set; equal display strings
alone do not establish semantic equality. Deep copies preserve the resolved metadata.
Fresh-name reservation visits the stored semantic types as well as source tokens.
The token cache retains only plain text, never semantic annotation equality.

Authored bodies containing TypeValue expressions or binders can now have resolved
bodies for comparison. Ordinary unannotated calls keep the existing conservative
shadowing rule. This does not expand the source language's comparison/equality policy
into arbitrary Lean definitional equality.

## Checked cases and initial failure

The first annotation experiment preserved a proof domain's old generated local name
but failed to reconnect it when the enclosing quantifier got a new Lean binder. The
nested test exposed the free reference. Rebinding the recorded free locals before
rendering repairs it; the native oracle explicitly requires the inner `p : v=v` to
refer to the outer `v`.

The first fresh-copy regression run also found that record projection reduction did
not recognize ModuleCall constructor/producer nodes after authored binder bodies
became closed. Those consumers now preserve module heads and use resolved bodies.
The affected graded-homology conversion tests pass.

Run `LAKE=lake python3 studies/carrier-fields/verify_annotations.py`. It applies all
four isolated patches to a fresh copy and regenerates/checks the parser strictly.
The annotation fixture has five independent exact targets and three proofs:

- A TypeValue containing a module call in a vector dimension under caller shadowing.
- An authored helper application and its comparison normal form, checked separately. The
  diagnostic marker is itself authored in Clean and returns zero. The bounded
  comparison retains its typed wrapper: an untyped numeral body is not substituted
  for a determined Natural result. The native proof establishes its value separately.
- A nested quantified condition with a dependent proof domain.
- The theorem statement generated from the Clean specimen.

Negative and interaction checks reject a local condition with the wrong dimension,
reject a changed nested module template, distinguish equal display text with different
semantic types, and exercise repeated substitution, immutability and deep copying.
[AnnotatedTypesVerified.lean](AnnotatedTypesVerified.lean) contains the native evidence.
The driver also runs the proof-binding fixture (eight targets/eight proofs), carrier
fixture (21 targets/six proofs), 221 selected regressions, 40 proof/evidence tests and 13 fresh-name/token-cache tests.

## Remaining integration requirements

This removes the nested-call annotation rejection in this isolated stack. It does not
establish the complete native declaration-identity contract: generic type-head identity,
module-owned exports, and universe polymorphism remain separate requirements. Compose
with module operators and audit all remaining annotation reification paths, including
source-only inferred-type recovery, before integration. Full corpus/study validation
is also required. The complete isolated compiler run passed all 34 exact targets,
17 proofs and 274 regression tests. The marker fixture was then changed from a diagnostic native adapter to an authored
constant definition. Its normal-form oracle retains the typed marker wrapper under
the existing determined-type comparison rule; a zero-literal oracle was rejected.
The final authored-marker fixture then passed its five targets and three proofs. This evidence is bounded; it is not a claim of language conformance.
:::
