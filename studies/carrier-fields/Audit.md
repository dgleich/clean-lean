:::llm gpt-6 2026-11-07 role=assisted

# Carrier consumer audit: callable capture and remaining closure gates

The isolated carrier prototype passes 21 exact native targets, six proofs, and
221 selected regression tests. The carrier/operator composition passes five exact
targets and three proofs. Neither establishes complete scope conformance.

| Consumer | Evidence | Remaining limitation |
|---|---|---|
| Type parsing and rendering | Neutral projection tree, parenthesized carrier alias, six-statement PDF | Main syntax remains unchanged |
| Field telescopes | Carrier, topology and point projections; constructor checks | Fixed Type-0 carrier only |
| Dependent function fields | `Function(space: PointedSpace,space.carrier)`; alpha-renamed binder; wrong-domain rejection; family evaluation proof | Type-valued dependent binders remain unsupported |
| Universe checking | Higher-domain arrow accepted in Universe 1; rejected as a Type-0 generic argument | Existing [closed-arrow rule](../../docs/closed-universe-checking.md), not general universe inference |
| Automatic names and source reification | Existing naming and hygiene regressions pass | No general declaration-identity coverage |
| Module operators | Equality, double negation, alias, wrong carrier, reordered candidates and ambiguity | Numerals/fixity and module scope migration remain open |
| Computed-index substitution | Counterexample below | **Fails: module call head can be captured by a caller local** |

## Counterexample

[CapturedCarrier.clean.proposed](CapturedCarrier.clean.proposed) defines a module
function `c(P)` returning `P.carrier`, then defines `retain(P,x)` with input and
output type `c(P)`. A theorem introduces an unrelated local function also named
`c`, and `x` of this local `c(P)` type. Its call `retain(P,x)` must be rejected:
there is no equality between the two carrier functions.

The base carrier prototype accepts it. The subsequent isolated
[bound-call repair](BoundCalls.md) rejects it while preserving valid local parameters. Native Lean rejects the generated application:
`x` has local type `c P`, but `retain` requires the module definition's carrier.
This is a translator type-checking failure, not a proved false theorem: the Lean
kernel rejects the output.

Reproduce with an isolated patched checkout whose parser has been regenerated:

```sh
python3 studies/carrier-fields/check_capture.py /path/to/patched-checkout
cd /path/to/patched-checkout
lake env lean CarrierCapture.lean
```

The first command currently fails its acceptance assertion and writes the native
counterexample; the second independently reports the type mismatch. A future fix
must make Clean reject the wrong argument while preserving positive local-callable
substitution and same-spelling nonfunction parameters.

`indices.substitute_index` currently reconstructs a source `Call` and elaborates it
in caller locals. Source spelling alone does not preserve whether the original head
was a module declaration or a function parameter. The required fix is binding-aware
substitution: preserve the resolved declaration identity of a module head, and only
substitute a function head bound to the definition's parameter. Audit dimensions,
proof indices and authored-body normalization alongside carrier indices, since they
share substitution machinery. Simply hiding caller locals would also hide locals
needed by the call arguments and is insufficient.

This report records the base prototype failure. The separate repair is not yet
integrated: structural annotations, integration of the [proof-binding extension](ProofBindings.md),
and the wider closure audit remain required.
:::
