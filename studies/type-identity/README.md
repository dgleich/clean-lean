:::llm gpt-6 2026-11-07 role=assisted

# Local and module type identity

Status: **failing acceptance gate**, not an implemented repair. This study exposes
a silent change in statement meaning in main Clean and in the four-patch carrier,
bound-call, proof-binding and checked-annotation prototype.

```text
Let Real: Type
Let x: Real
Conclude: x = x
```

The independently authored Lean target is:

```lean
∀ (Real : Type) (x : Real), x = x
```

The current translator instead emits:

```lean
∀ (Real : Type) (x : ℝ), x = x
```

Both statements compile. Proving reflexivity or checking compilation alone
therefore misses the error. `check_identity.py --native` first checks that the
generated statement and independent expected statement compile, then compares
their canonical elaborated types and values with the repository's exact-target
checker. Binder names are ignored; the distinction between a bound type variable
and the constant `Real` is not ignored.

## Reproduction

Run from the repository root:

```sh
python studies/type-identity/check_identity.py --native
python studies/type-identity/check_identity.py --compiler /path/to/prototype
```

The compiler path selects Python implementation files; the fixtures and pinned
Lean environment come from this repository. `LAKE` can override the Lake binary.
These commands are acceptance gates: a nonzero result is a real outstanding
failure, not a successful expected-failure test. No `sorry`, axiom or swallowed
Lean failure is used. The fixtures use main Clean's existing equality operation;
they do not claim to exercise the declared-operator migration.

The six Python checks cover local/module inequality, local Lean rendering, local
precedence over a module alias, rejection of a local-carrier value supplied to a
concrete-real function, and preservation of module types by both dependent and
structure substitution. All six currently fail on main and the four-patch stack.
The exact native target also fails on both compilers, after its compilation
control succeeds. A neutral type-parse check passes on the four-patch stack.
The native check is optional because it invokes Lean; skipping it is not a pass.

## Required repair boundary

No new source grammar is needed. The existing bare type reference must retain
the declaration selected during checking. For a fixed lexical environment:

1. Resolve a bare reference to an in-scope type parameter before looking up a
   module name or module alias. Resolve constructor applications under their
   separately specified arity rules; do not infer a constructor from a local's
   spelling.
2. Represent a local type reference separately from a module type constructor.
   A local reference retains its binder identity and selected Lean binder.
   A module reference retains its declaration identity and selected native
   interpretation. Equal display names do not imply equal semantic objects.
3. Substitute local references by binding identity. Module type heads remain
   unchanged. Recurse through constructor arguments, dependent domains and
   codomains, record fields, proof conditions and checked annotations.
4. Render the selected binding directly. Do not consult the current module table
   using a local type's display name, or rediscover a local using the spelling of
   an already resolved module type.
5. Expand type aliases by semantic substitution into their declaration-scoped
   templates. Formatting actual types into strings and reparsing them in caller
   scope is another possible capture boundary and requires its own tests.

These are requirements for a repair, not a claim that a new internal identity
representation is already complete. In particular, adding a `LocalType` subclass
without updating every reconstruction and substitution path is insufficient.
Generated Lean names must also avoid capturing constants in opaque native
adapters. The exact identifier-allocation and serialization rules remain to be
worked out before claiming the full identity requirement is specified.

## Consumers and follow-up gates

Audit `Environment.type`, rendering, universe classification, function-type
recognition, notation signature patterns, dependent matching, structure field
substitution, carrier normalization, annotation free references, inferred-argument
reification and hygiene. Existing tests that construct `Type("T")` as an informal
local placeholder must be changed to express an actual local identity, rather
than retaining spelling-based substitution for compatibility.

Add interaction gates for local names matching module aliases, same-named
parameters in separate declarations, nested binder renaming, aliases receiving
already resolved module types, stored `type(...)` expressions, record fields,
implicit arguments and declared operators. Preserve the earlier binding and
annotation native tests. Passing this small regression file alone will not
establish full identity conformance or authorize prototype integration.
:::
