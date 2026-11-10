:::llm gpt-6 2026-11-10 role=assisted

# Binary sums of coefficient modules

Mayer–Vietoris needs a term containing two homology modules. The explicit
[module-products module](../../library/algebra/module_products.clean) supplies
that foundational operation over the same specified field. Its underlying carrier
is the Cartesian product, with the usual componentwise module structure. For two
modules this also realizes their direct sum, hence the LaTeX spelling `M ⊕ N`.
It is not an infinite direct-sum construction.

The initial three adapters expose `ModuleCat.of`, `LinearMap.inl` and `LinearMap.snd`:

```clean
Let M,N: CoefficientModule(K,field)
Conclude: exact(left inclusion(field,M,N),right projection(field,M,N))
```

Here the inclusion sends x to (x,0) and the projection sends (x,y) to y.
Their common middle module is `module product(field,M,N)`. The existing authored
Clean condition `exact` means range equals kernel, and the existing `onto`
condition says every codomain element has a preimage. Neither is replaced with
an opaque assertion about the desired result. The second supporting theorem
states that the projection is onto, with witness (0,y).

These are foundational linear-algebra imports. A general facility for constructing
linear maps from a Clean-authored function and proofs of its laws is a separate
interface obligation; arbitrary functions do not become module maps here.
The field is an explicit argument, installed locally in each native adapter.
No syntax, default imports, registry entry, or name-specific elaboration is added.

## Acceptance evidence

[ModuleProducts.clean](ModuleProducts.clean) contains the initial two statements and the signed-square result below.
The [verifier](verify_module_products.py) generates their Lean declarations and
initially checked five independently written native targets: the product, inclusion,
projection and both proposition definitions. The oracle preserves the declared
product wrapper in both map types. It also proves range = kernel by inspecting
pairs and proves surjectivity by giving a preimage. No axiom or `sorry` is used.

The Python tests independently specify the product call tree, the map endpoints,
and rejection of a different middle module or a nonmodule argument. Reproduce:

```sh
LAKE=lake python3 studies/topology/verify_module_products.py
PYTHONPATH=tests:. python3 -m unittest test_module_products test_exact_sequences -v
```

Validation on 2026-11-10: five exact native targets and both supporting proofs
passed. The product/exact-sequence Python batch passed 15 tests in 1.085 seconds.
The existing 92-proof corpus also passed Lean checking. Only the existing unused
variable warning appeared in the new native study. Full-suite jobs started before
these additions remain running and do not validate the new files.

## Signed squares authored in Clean

The module now also wraps `LinearMap.prod`, `LinearMap.coprod` and negation of
linear maps. Their mathematical roles are distinct: pairing requires a common
domain, while merging requires a common codomain. Merge sends (x,y) to h(x)+k(y).
The paper-relevant sign convention is an authored definition:

```clean
Define signed pair(f,g):
  Let K: Type
  Let field: FieldStructure(K)
  Let L,M,N: CoefficientModule(K,field)
  Let f: ModuleMap(K,field,L,M)
  Let g: ModuleMap(K,field,L,N)
  Returns: ModuleMap(K,field,L,(module product(field,M,N)))
  Equals: pair module maps(field,L,M,N,f,negative module map(field,L,N,g))
```

The field and three modules are inferred from the checked map types, preserving
explicit native arguments. The new statement assumes h ∘ f = k ∘ g and concludes
that `[h,k] ∘ (f,−g)` is the zero map. Its proof uses linearity and cancellation;
it does not assume exactness or identify the maps with particular homology maps.
Composition-to-zero is weaker than exactness, so this is only one ingredient in
the intended topology construction.

The extended verifier passes ten independently authored exact targets and three
proofs; the focused Python batch passes twenty tests (2026-11-10). These include
the authored signed-pair tree, inferred result type, composition endpoints, and
rejection of mismatched pairing domains and merging codomains.

A source-layout limitation surfaced: an empty `Assume commutes:` header followed
by an indented expression is rejected. The specimen uses the supported inline
assumption. An assumption-block grammar extension remains open; changing its
spelling must not alter the proposition or let types choose a parse.

This is not the Mayer–Vietoris map. Constructing that map requires the actual
inclusion-induced homology maps and their signs; the connecting map, cover/excision
hypotheses and exactness proof also remain outstanding. Nor does this study yet
provide the full product universal property, both other structural maps, or
infinite families. The distinction keeps the reusable foundation separate from
paper-specific mathematical obligations.
:::
