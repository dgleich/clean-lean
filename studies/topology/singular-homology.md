:::llm gpt-6 2026-11-06 role=assisted

# Actual singular homology interfaces

[`Homology.clean`](Homology.clean) now states five checked results about actual
Mathlib singular homology. [`HomologyVerified.lean`](HomologyVerified.lean) contains
the generated statements, independent native target oracles, and proofs. These
are functor laws, not the research paper's characterization theorems.

```clean
Let K: Type
Let field: FieldStructure(K)
Let H: HomologyTheory(K,field)
Let X,Y: TopologicalSpace
Let f: ContinuousMap(X,Y)
Let x: HomologyClass(K,field,H,X)
Let h = induced homology map(field,H,X,Y,f)
Conclude: h(x) = induced homology value(field,H,X,Y,f,x)
```

`H` bundles a coefficient module and a natural-number degree. Its classes at `X`
are rendered as `H(X)`, denoting homology with that fixed degree and coefficient
choice. The induced action is rendered as `f_*`. No degree, coefficient or field
structure is inferred from a display name. Calling the returned ordinary function
as `h(x)` already works; calling the bundled continuous map as `f(x)` is still a
separate readability gap.

## Pinned native meanings

All imports use Lean/Mathlib v4.24.0, Mathlib revision
`f897ebcf72cd16f89ab4577d0c826cd14afaafc7`. No dependency was upgraded.

| Clean declaration | Native meaning |
| --- | --- |
| `CoefficientModule(K,field)` | `@ModuleCat.{0,0} K field.toRing`, in Type 1 |
| `ModuleElement(K,field,M)` | `@ModuleCat.carrier K field.toRing M`, in Type 0 |
| `coefficient module(K,field,V,L)` | `ModuleCat.of` with exactly `L.addition` and `L.action` |
| `HomologyTheory(K,field)` | Authored structure with coefficients and degree |
| `homology module(field,H,X)` | `((singularHomologyFunctor (ModuleCat K) H.degree).obj H.coefficients).obj X` |
| `HomologyClass(K,field,H,X)` | Transparent Clean alias for `ModuleElement(K,field,(homology module(field,H,X)))` |
| `homology linear map(field,H,X,Y,g)` | The native functor map of `TopCat.ofHom g`, as a generic ModuleMap |
| `induced homology value(field,H,X,Y,g,x)` | Clean-authored application of that generic module map |
| `homology image(field,H,X,Y,g)` | Clean-authored range of that generic module map |
| `induced homology map(field,H,X,Y,g)` | Clean-authored lambda applying the preceding operation |

The native functor lives in `Mathlib.AlgebraicTopology.SingularHomology.Basic`.
`ModuleCat.Abelian` and `ModuleCat.Colimits` supply its categorical prerequisites.
Each adapter explicitly installs the passed `Field K` before elaborating the
functor; its ring projection therefore agrees with the coefficient module's index.
The pinned category, coproduct, preadditive and homology instances become parts
of the elaborated terms. Independent target checks compare those full terms,
including universe levels and instances. This is not a general assertion that
all arbitrary imported Lean bodies have unique elaborations.

The initial interfaces have now been extended with explicit computed indices.
See [the syntax contract](../../docs/computed-indices.md). They also exercise
Type-1 records, dependent fields, constructors, lambdas and explicit imports.
The new mathematical vocabulary is entirely module-declared.

## Verified evidence and remaining work

`verify_homology.py` independently compares 31 canonical declarations: imported
module/class types, the module constructor, theory record/constructor/projections,
object/action adapters, the authored lambda, continuous-map identity/composition,
generic module maps/ranges, computed dependent record fields, and all five
statement types. It proves identity and composition via Mathlib's
`CategoryTheory.Functor.map_id` and `map_comp`, and lambda application by reduction. Range membership and the class stored in
a dependent record also have proofs.
Tests reject mismatched fields, theories and ambient spaces.

This is absolute, ordinary singular homology, with small spaces and modules and
natural-number degrees. It does not construct relative homology, reduced homology,
a connecting map, exactness, excision, a well group, or a basis. No statement here
settles the closed-cover/excision issue in the interlevel study.

The carrier interoperability gap from the initial milestone is now resolved for
explicit computations: HomologyClass is a transparent type alias and the induced
value and homology image are authored through generic module operations. No new
paper-specific native adapter was needed. A ClassInSpace record additionally
exercises a field whose homology module is computed from its preceding space field.

Local aliases still remain distinct: after `Let M = homology module(field,H,X)`,
`ModuleElement(K,field,M)` does not automatically unfold M. Use the transparent
HomologyClass alias or the same explicit computed index when types must agree.
Generic module maps and their ranges are now available; relative homology,
exactness/excision and the research targets remain separate unfinished work.
:::

:::llm gpt-6 2026-11-06 role=assisted

## Relative object construction

[Relative singular chains and homology](relative-homology.md) now constructs the
relative chain complex as the cokernel of the inclusion-induced singular chain
map, and applies the homology functor in the selected degree. The definitions are
authored in Clean over generic native chain adapters. Sixteen exact target checks
and four kernel checks pass. Relative induced maps, exactness/excision and the
research theorem proofs remain unfinished; the report distinguishes definition
checks from mathematical theorems and records the computed-index conversion gap.
:::
