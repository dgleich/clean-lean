:::llm gpt-6 2026-11-06 role=assisted

# Proof-valued functions and the explicit arrow binding

This extends the dependent-function acceptance profile to proof domains and
codomains, including constant codomains and ordinary arrow spelling. Authors do
not need new Sort or universe syntax:

```clean
Returns: Function(v: Vertex(n),(v = v))
Equals: function(v: Vertex(n),equality reflexivity(v))
```

The result is a proof of every equality in that family. It has a function type in
Lean's Prop. In contrast, `Function((n = n),Natural)` takes a proof and returns a
natural number; that function type lives in Type. A proof domain alone does not
make a function type a proposition.

## Parsing and the module-declared grant

There is no grammar change. The existing ordinary Apply and BoundTypeApply type
nodes are selected before elaboration. A parenthesized condition in type position
continues to denote its proof type. Evidence remains a transparent library alias.

After type aliases resolve, the selected declaration must be the existing explicit
arrow interface: two type arguments with Lean template `({0}) → ({1})` under the
specified whitespace normalization. That interface already grants native arrow/Pi
emission instead of application of its demonstration wrapper. Its two operands now
accept proof types as well as ordinary types in both the ordinary and bound forms.
A constructor with another template receives no such grant. Names such as Function
or Mapping have no built-in privilege.

Thus `Function(h: (n = n),Natural)` normalizes to the same ordinary arrow as
`Function((n = n),Natural)` when h does not occur in the codomain. The normalized
type can be serialized and read back without losing its admissibility. Binder scope,
freshness, capture-free substitution and selected implicit arguments remain governed
by the dependent-function contract.

## Structural proof-sort classification

The type checker classifies a checked type as a proof type exactly when:

1. It is a checked parenthesized-condition ProofType, including a resolved alias; or
2. It is an ordinary/dependent function under the selected arrow interface and its
   codomain recursively classifies as a proof type.

The second rule does not inspect the domain. In Lean, a Pi with domain in Sort u
and codomain in Sort v lives in Sort (imax u v); when v is zero, imax u 0 is zero.
This applies even to a family quantified over an object type in Type 1.

Every ordinary Type parameter gate uses this classification: constructor type
arguments, legacy polymorphic matching, and dependent-call implicit Type inference.
Consequently `Set(Function(n: Natural,(n = n)))` is rejected, as is passing a
proof-family value to a wrapper whose inferred carrier parameter is explicitly
`X : Type`. The arrow's own two operands are the explicit exception above.
`Set(Function((n = n),Natural))` remains admissible. There is no Prop-to-Type lift,
coercion insertion or proof synthesis.

This is not general universe inference or a solver for the sort of an opaque Means
body. Existing native bindings retain their declared interface and kernel-validation
obligations. Type-valued dependent binders (`T: Type`) remain outside the initial
profile. A proposition value (the foundational type whose Lean meaning is Prop)
is distinct from a proof inhabiting that proposition; the former is not classified
as a proof merely because its native type is written Prop.

## One Lean target

The native target is still the existing arrow or explicit Pi. For example:

```lean
(v : Fin n) → v = v
(n = n) → Nat
(M : @ModuleCat.{0,0} K field.toRing) →
  (x : @ModuleCat.carrier K field.toRing M) → x = x
```

These snippets explain the mapping; the independent oracle retains actual wrapper
applications, binder information, universe levels, instances and all let bindings.
A function body still checks every argument before application, even if it ignores
that argument. The proof-domain constant function in the study deliberately retains
an unused proof binder; Lean's unused-variable warning is expected, not suppressed.
No numerical inference, equality proof or native instance choice is added here.

## Rendering

A dependent function with a proof codomain is described as assigning to each
argument “evidence that” the codomain condition holds, rather than “a value of type”
that condition. Nonproof dependent function descriptions retain their existing
wording. This uses the same structural proof-sort classification as type checking;
it changes prose only, never the emitted Lean expression.

## Acceptance evidence and remaining scope

[ProofFamilies.clean](../studies/dependent-functions/ProofFamilies.clean) defines
finite reflexivity families, proof identity, proof-to-natural functions, and families
over the module category. It contains dependent application statements for arbitrary
Fin n, empty Fin 0, singleton Fin 1, a proof domain and a higher-universe domain.
All statements retain explicit authored arguments and locally named proofs.

`verify_proof_families.py` compares ten independently authored canonical targets and
proves the five generated statements. Five additional native sort assertions inspect
the inferred sorts of the complete declaration types: three Prop results, one Type
result and one Type 1 result. The checks do not erase wrappers or reduce theorem
bodies to prove canonical-target equality.

`tests/test_proof_families.py` covers alpha-equivalent inferred proof lambdas,
application, wrong evidence, constant-arrow round trips, ordinary and dependent
Type-argument rejection, and a renamed/rebound arrow interface. This completes
these selected proof/empty/singleton/higher-universe acceptance cases, not a claim
that all dependent-function or universe interactions have been audited. Broader
naming collisions, general universe parameters and Type-valued binders remain open.
:::
