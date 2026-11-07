:::llm gpt-6 2026-11-07 role=assisted

# Binding repairs integrated into the working compiler

The working compiler now includes the seven repairs previously exercised in
isolated studies: carrier fields, retained module calls, retained proof bindings,
semantic annotations, local type identity, native type abbreviations and
root-qualified generated globals. Declared operators remain an isolated experiment.
This is an intermediate integration; broad conformance is not established.

## Source and translation rules

A Universe-1 structure may contain a Type-0 carrier field. Later fields and
external type-position projections use its checked carrier identity. For example,
`P.carrier` is a type selected by the declared record projection, not an implicit
coercion. See the [carrier-field grammar and rules](carrier-fields.md).

A local type parameter is distinct from a module type or alias with the same
spelling. Local references retain their selected native binder. Only local type
parameters participate in parameter substitution; a module type head cannot be
replaced through a same-spelled local substitution. Alias expansion uses checked
semantic bodies and parameter telescopes rather than re-resolving printed text.

Saved computed indices and conditions retain the selected module calls. Local
function parameters remain substitutable, while later locals cannot replace a
module callable. Quantifier annotations retain their checked types and free local
references, which reconnect to the renamed binder when instantiated.

Opaque native type adapters are emitted once as reducible abbreviations. Uses
refer to their root-qualified declaration bindings instead of copying the Means
body into a caller scope. The declared arrow interface remains structural,
including proof-valued arguments. Generated callables, constructors, record types
and projections also use absolute native references. Local applications stay local.
The earlier study documents give each constructive rule and acceptance boundary.

These changes intentionally alter canonical native targets. An older oracle that
expects an inline Real or Nat body may no longer match even though the resulting
propositions are definitionally equal. Do not weaken exact comparison to hide the
change: migrate expected declarations and independently check their wrapper bodies.

## Main-tree evidence

- Strict parser generation and generated-file check pass.
- The existing 274 focused binding/quantifier/dependent-call regressions pass.
- Seven local/module type collision gates now live in `tests/test_binding_identity.py`
  and pass separately.
- Native type-binding and global-reference verifiers pass on the working compiler:
  23 exact targets and twelve proofs, including deliberate generated-name collisions.
- The regenerated 92-proof corpus passes the Lean kernel.
- The historical composed-operator driver still reconstructs its pinned compiler
  and passes 77 exact targets and seventeen proofs. That is separate prototype
  evidence, not evidence that declared operators are integrated into main.

A full discovery run is active, with periodic stack traces enabled. It began
before the seven newly extracted identity tests were added; those tests were run
separately. Its completion is pending and must not be reported as passing. The
older five-patch full discovery process is also still active. Neither run validates
all later changes merely by remaining alive.

The exact main-tree commands for the native checks are:

```sh
LAKE=/home/claude/.elan/bin/lake python studies/native-type-bindings/verify_bindings.py "$PWD"
LAKE=/home/claude/.elan/bin/lake python studies/qualified-globals/verify_bindings.py "$PWD"
python verify_corpus.py
lake env lean generated/VerifiedCorpus.lean
```

The two binding drivers also write temporary native files in the compiler root;
their retained review artifacts are in the respective study directories.

## Outstanding integration work

Broader tests and study verifiers still need review and native-oracle migration.
Older generated study files remain historical evidence until regenerated and
checked on this compiler. General universe polymorphism, source-binder escaping,
complete declaration-owned identities/serialization and native import/instance
isolation are not established. The existing name-based mathematical dispatch is
migration debt: the declared-operator/literal/foundation work must replace it.
The separate topology and research theorem obligations remain unchanged.

Historical patch drivers now use the [pinned reconstruction helper](study-reproduction.md).
The patches remain reviewable history rather than runtime compatibility code.
:::
