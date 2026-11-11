:::llm gpt-6 2026-11-11 role=assisted

# Quoting source binders and references

User-written statement objects, statement local definitions, and declaration
parameters now use quoted Lean identifiers in both their binding sites and their
generated references. For example:

```clean
Result keyword local:
  Attribution: local; local definition; original
  Let example: Real
  Let match = identity keyword(example)
  Conclude: match = example
```

Its native binders are `«example»` and `«match»`; its source names, source trees,
automatic condition naming and LaTeX labels remain example and match. The
[complete specimen](../studies/identifier-quoting/Keywords.clean) additionally
covers declaration parameters, a named condition, an explicitly authored Lean
List wrapper, dependent carrier and dimension parameters, and a record field.

## Constructive rule and scope

There is no grammar change. Given a validated source identifier s, emit the
lexical identifier `«s»`. Quoting preserves exactly the Lean Name component s;
it does not introduce a suffix or depend on a keyword table. Source identifier
validation excludes the quote delimiters and line breaks; the shared emission
helper also rejects those delimiters and empty names. Consequently the emitted
spelling identifies exactly one name and cannot close its own quote.

Keep environment keys and source AST references as s. At binding time, store the
native expression `«s»` for an object or declaration parameter. Emit the same
spelling in its universal, implicit, explicit or local-definition binder. Source
references resolve through the existing lexical environment, so they obtain that
same stored native spelling. Local-definition comparison values are still frozen
in their earlier scope; only the local reference target changes spelling. No
source substitution, scope policy or overload selection rule changes.

Declaration parameters of type constructors, Notation, Define and Condition use
this rule for their generated signatures and authored Clean bodies. Structure
parameters/fields and assumption labels already used quoted emission. Compiler-
generated lambda/quantifier/comparison binder identities retain their existing
fresh-name rules. Result titles use the preceding result-identifier contract.

Opaque `Means` and `From Lean` bodies are authored Lean code. They are not rewritten.
An ordinary raw reference x still names the binder `«x»` in Lean; an author using
a Lean keyword in an opaque payload must write its valid Lean spelling explicitly,
as in `Means: List «example»`. Invalid native payloads still fail native checking.

This produces one binding/reference spelling from the fixed parsed source and
scope. It preserves normalized-name collision rejection and does not use Lean
elaboration success to select among names. The broader fixed-environment target
acceptance obligations remain; this lexical rule is not a claim of full conformance.

## Evidence and remaining limits

Six focused Python tests check preserved source trees, matching local binders and
uses, declaration-body references, unchanged opaque payloads and LaTeX names, and
invalid quote delimiters. The initial 68-test dependent-call/operator/classifier
slice passes. Nine independently written canonical native targets cover the five
statements and four declarations; five supporting proofs check the statements.
The first proof script used `intros` without unfolding the named propositions and
failed; explicit introductions correct that harness without changing the emitted
targets or the canonical comparator.

Run `python studies/identifier-quoting/verify.py` under the pinned Lean/Mathlib
installation. [Verified.lean](../studies/identifier-quoting/Verified.lean) is generated
by that checker. Integration passes strict parser reproduction, 475 selected
Python tests, 57 exact native targets, 30 supporting proofs and all 92 corpus
proofs (`/tmp/clean-binder-integration.log`, `Failures: []`). An additional
69-test binding/module/universe slice passes. Both LAProof editions also pass
seven supporting proofs each. Full discovery remains pending; vector-zero
inference is unchanged.

Since generated declaration identifiers hash emitted bodies, quoting ordinary
parameter names also changes some generated binding hashes. Regenerate dependent
artifacts; do not hand-edit references or weaken retained binding identity checks.
The underlying mathematical binder names and terms remain the same in Lean.
:::
