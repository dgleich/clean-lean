:::llm gpt-6 2026-11-07 role=assisted

# Callable identities in saved proof conditions

The [Clean specimen](ProofBindings.clean.proposed) demonstrates module conditions,
local condition parameters, quantified assumptions and specialization of a quantified
proof. The same source names may appear in different scopes without changing which
condition an earlier definition requires. This is an isolated extension of the
[bound-call experiment](BoundCalls.md), not main compiler behavior.

## Failure and repair

Before this extension, `retain proof(x,h)` was accepted with `h : c(x)` for a caller's
local `c : Function(Real,Proposition)`, even though `retain proof` required the module
condition `c(x)` defined as `x=x`. Stored proof conditions used their own serialization
path, bypassing the computed-index binding repair.

The extension resolves callable heads when constructing a ProofIndex. Module heads
retain their explicit target template; local heads become applications of a local
reference. Existing simultaneous substitution preserves these heads through proof
substitution and callable-view construction. A changed module template is rejected.
The proof comparison key remains computed from the checked condition; no proof is
invented, erased, or selected to repair a mismatch.

For a quantifier or lambda in a proof condition, first check its domain in the current
scope. Extend a fresh lexical scope with the binder's checked type, then resolve the
body there. This determines whether a body call refers to a local function parameter
or a module declaration. A binder does not enter its own domain, escape its body, or
change sibling scope. The parsed tree is unchanged: only the stored semantic tree
contains ModuleCall or explicit local Apply nodes.

In this three-patch stage, type annotations are still source strings. This experiment rejects calls nested in
those annotations rather than pretending their bindings are closed. The restriction
is a known integration gap to remove with structural type storage, not an accepted
restriction on the final language. It applies to binder domains as well as TypeValue
expressions. General type-name binding, module-owned native identity, operator
composition and whole-language closure remain open.

## Evidence

Run `LAKE=lake python3 studies/carrier-fields/verify_proof_bindings.py`. The driver
copies tracked source, applies the carrier, bound-call and proof-binding patches,
and regenerates/checks the parser strictly. It checks:

- Eight independently authored exact native targets: four applications and four
  theorem-statement targets from the Clean specimen.
- Eight native proofs in [ProofBindingsVerified.lean](ProofBindingsVerified.lean).
- Wrong local conditions rejected for direct, universal and specialized proofs.
- Exact parsed and stored bound trees, a quantifier-bound function parameter,
  repeated proof substitution and changed-template rejection.
- The carrier study's 21 targets, six proofs and 221 regression tests, plus 40
  quantified-condition/proof/evidence tests.

The direct native and regression runs pass, and the fresh-copy driver passed the
same checks. This does not establish full-suite or operator-composition conformance.
The subsequent [checked-annotation extension](AnnotatedTypes.md) removes the nested-call
annotation rejection by preserving semantic types and free local references. Main
source remains unchanged while the remaining closure boundaries are resolved.
:::
