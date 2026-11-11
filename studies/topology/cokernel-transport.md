:::llm gpt-6 2026-11-11 role=assisted

# Cokernel transport along a supplied equality

The empty-relative-part result proves that the actual chain inclusion is zero.
Its cokernel is still expressed using that actual inclusion. This module supplies
the comparison with the cokernel of the zero map, retaining the equality proof
as an explicit argument.

[The module](../../library/algebra/chain_cokernel_transport.clean) introduces one
native adapter, `chain cokernel transport(field,C,D,f,g,h)`, for
`(CategoryTheory.Limits.cokernelIsoOfEq h).hom`. Here `h` has type
`Evidence(f = g)`. The adapter installs the explicitly supplied field instance.
The reverse transport is authored in Clean by applying the same adapter to
`equality symmetry(f,g,h)`; it does not select an arbitrary inverse.

Four definitions are authored in Clean: reverse transport, vanishing quotient
reduction, and the forward and backward induced homology maps. Reduction first
transports from the cokernel of `f` to the cokernel of zero, then uses the existing
zero-quotient reduction. The backward homology map is induced by the canonical
cokernel projection and does not require a proof that `f` vanishes.

```clean
Define chain cokernel reverse transport(field,C,D,f,g,h):
  Let K: Type
  Let field: FieldStructure(K)
  Let C,D: ModuleChainComplex(K,field)
  Let f,g: ChainMap(K,field,C,D)
  Let h: Evidence((f = g))
  Returns: ChainMap(K,field,(chain cokernel(field,C,D,g)),(chain cokernel(field,C,D,f)))
  Equals: chain cokernel transport(field,C,D,g,f,equality symmetry(f,g,h))
```

This uses existing declaration, application, equality and evidence syntax. Every
application has a declared binding. Proof arguments remain in the generated Lean
expression; neither inference nor proof irrelevance substitutes another proof
at the translation boundary. Lean proof irrelevance may subsequently be used by
the kernel when checking the separately authored proofs.

## Checks

[The seven statements](CokernelTransport.clean) cover both transport inverse
laws, preservation of the cokernel projection, both reduction inverse laws when
`f = 0`, and both induced homology inverse laws. The local quotient and homology
object abbreviations remain local lets in the generated statements.

[The verifier](verify_cokernel_transport.py) independently specifies five
definition targets and seven statement targets and compares their canonical Lean
types and bodies. It also checks seven proofs. Definitionally equivalent targets
are not accepted as substitutes by the canonical comparator.

```sh
LAKE=lake python3 studies/topology/verify_cokernel_transport.py
```

Generated files: [statements and definitions](CokernelTransport.lean),
[targets and proofs](CokernelTransportVerified.lean).

## Remaining topology work

These are generic chain-complex results. The level-set modules must still supply
empty-relative-part certificates, apply the inclusion-zero result, and connect
the homology of the ambient singular chain complex to the ordinary-homology
interface. Naturality for a square of vanishing maps and the complete natural
identification remain to be assembled. Neither the well-group formula nor the
closed-cover/excision argument follows from these inverse laws alone.
:::

:::llm gpt-6 2026-11-11 role=assisted

Validation completed: twelve canonical targets and seven proofs pass in the
pinned Lean environment. Legacy and joint elaboration produce identical Lean
text for the module and its seven-result study, under matching stable input
fingerprints. All 92 corpus proofs pass under joint routing. Evidence is stored
under `cokernel_equality_transport` in
[the compatibility report](../parameterized-literals/compatibility.json).
The separate full regression, active-label validation and browser rebuild were
confirmed running; these module checks do not establish their completion.
:::
