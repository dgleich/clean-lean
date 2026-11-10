:::llm gpt-6 2026-11-10 role=assisted

# Exact pairs and sequence interiors

[exact_sequences.clean](../../library/algebra/exact_sequences.clean) supplies a
missing interface for discussing Mayer–Vietoris: exactness of two composable
linear maps. The defining mathematical condition is authored in Clean:

```text
Condition exact pair(field,M,N,P,f,g):
  Let K: Type
  Let field: FieldStructure(K)
  Let M,N,P: CoefficientModule(K,field)
  Let f: ModuleMap(K,field,M,N)
  Let g: ModuleMap(K,field,N,P)
  Holds when: module map range(field,M,N,f) = module map kernel(field,N,P,g)
```

A second authored condition infers the ambient parameters from the checked map
types, allowing `Assume exact(f,g)`. Its automatic label is “exactness of f and g.”
The field, modules and intermediate object remain explicit in the determined Lean
application; they are not inferred from an uncontrolled native typeclass choice.
The two new foundational adapters expose `LinearMap.ker` and the zero element of
an explicitly supplied coefficient module. Existing wrappers provide map ranges
and evaluation. The imported Mathlib source is pinned `Mathlib.Algebra.Exact`.

## Sequence indexing and the endpoint

```text
Structure ModuleSequence(K: Type,field: FieldStructure(K)):
  Universe: 1
  Let object: Function(Natural,CoefficientModule(K,field))
  Let arrow: Function(n: Natural,ModuleMap(K,field,(object(n+1)),(object(n))))
  Constructor: module sequence
```

Thus `S.arrow(n)` goes from `S.object(n+1)` to `S.object(n)`.
`exact pair at(field,S,n)` means exactness of

```text
S.object((n+1)+1) -- S.arrow(n+1) --> S.object(n+1) -- S.arrow(n) --> S.object(n).
```

The middle object has degree n+1, not n. The condition
`exact sequence interior(field,S)` requires this for every natural n. There is no
outgoing arrow at degree zero and no implied surjectivity or terminal zero object.
The explicit “interior” name avoids conflating this with an augmented or terminated
exact sequence. The iterated successor spelling follows the declared arithmetic;
Clean does not silently equate independently written arithmetic index expressions.


The separate authored condition `exact sequence ending in zero(field,S)` is
`exact sequence interior(field,S) and onto(S.arrow(0))`. Here `onto(f)` means
that every codomain element has a preimage. It adds exactness at degree zero
without storing a zero object in the sequence record. The explicit zero-map
adapter uses the supplied field instance and Mathlib's zero linear map.
The checked criterion identifies exactness before that map with surjectivity;
interior exactness alone continues to make no endpoint claim.

## Checked statements and Lean correspondence

[ExactSequences.clean](ExactSequences.clean) originally stated two supporting results:
exact maps send every image element to zero, and interior exactness holds at each
adjacent pair. [ExactSequencesVerified.lean](ExactSequencesVerified.lean) includes
proofs of both plus an agreement theorem with Mathlib `Function.Exact`.
Mathlib's `LinearMap.exact_iff` uses kernel = range; the agreement proof accounts
for the reversed equality in the authored range = kernel definition.

The original verifier independently specified nine native targets: kernel, zero, the long
and inferred exact-pair conditions, position/interior conditions, the sequence
constructor and both theorem statements. It compares canonical types and bodies,
including declared wrappers, arguments, natural-number constructors and instances.
This goes beyond merely compiling definitions that might express the wrong maps.
The Python tests independently specify the structure tree and check arrow
orientation, ambient kernel type, authored condition bodies and rejection of
noncomposable maps. No new syntax, axiom, `sorry` or paper-specific opaque adapter
is used.

Reproduce from the repository root:

```sh
lake build Mathlib.Algebra.Exact
LAKE=lake python3 studies/topology/verify_exact_sequences.py
PYTHONPATH=tests:. python3 -m unittest test_exact_sequences -v
```

The first command builds the pinned dependency if its cached object is absent;
it does not update Lean or Mathlib. The verifier also regenerates the Lean and TeX
specimens. The standalone LaTeX wrapper is `exact-sequences-latex.tex`.

## Validation record

On 2026-11-10 the verifier passed nine exact targets, the Mathlib agreement proof
and both statement proofs. The exact-sequence/structure/dependent-function batch
passed 69 tests in 8.200 seconds. The existing 92-proof corpus regenerated and
passed Lean checking. The final PDF compiled twice as one landscape page and was
visually inspected: interior exactness and the middle degree n+1 are explicit.
Only the existing unused-variable and LaTeX package-name warnings remain.
The long full-suite runs predate this new module/test and are not evidence for it.

## Endpoint extension

The current verifier adds six independent targets (zero map, onto, terminal
exactness, and three statements), bringing the total to fifteen. It checks
Mathlib agreement for onto, the exact-zero-map criterion, and proofs that terminal
exactness implies both interior exactness and surjectivity of arrow(0).

Endpoint validation (2026-11-10): all fifteen exact targets, three
agreement/criterion proofs and five statement proofs passed. The focused
exact-sequence/structure/dependent-function batch passed 72 tests in 8.976 seconds;
the existing 92-proof corpus passed Lean checking. The five-result PDF compiled
twice and was visually inspected as one landscape page. No parser changes were
needed. The already-running full suites predate this addition.

## What is still missing for Mayer–Vietoris

These definitions do not construct the Mayer–Vietoris sequence. We still need the
connecting maps, their degree shifts, the appropriate sums of homology modules,
the cover/excision hypotheses and proof of exactness. The generic terminal condition is now explicit; connecting maps and the
actual homology endpoint still need construction. The natural-indexed record is a
foundation for sequences of maps, not a substitute for the actual homological
construction or a claim about all integer-indexed complexes.
:::
