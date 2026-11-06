:::llm gpt-6 2026-11-06 role=assisted

# Actual singular homology interfaces

[`Homology.clean`](Homology.clean) now states three checked results about actual
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
| `HomologyClass(K,field,H,X)` | The actual carrier of that homology module |
| `induced homology value(field,H,X,Y,g,x)` | The functor's map of `TopCat.ofHom g`, applied to `x` |
| `induced homology map(field,H,X,Y,g)` | Clean-authored lambda applying the preceding operation |

The native functor lives in `Mathlib.AlgebraicTopology.SingularHomology.Basic`.
`ModuleCat.Abelian` and `ModuleCat.Colimits` supply its categorical prerequisites.
Each adapter explicitly installs the passed `Field K` before elaborating the
functor; its ring projection therefore agrees with the coefficient module's index.
The pinned category, coproduct, preadditive and homology instances become parts
of the elaborated terms. Independent target checks compare those full terms,
including universe levels and instances. This is not a general assertion that
all arbitrary imported Lean bodies have unique elaborations.

The implementation adds no expression syntax. It exercises existing named value
indices, Type-1 records, dependent fields, constructors, lambdas and explicit
imports. The syntax and substitution contracts therefore remain those documented
in `docs/dependent-calls.md`, `docs/structures.md` and `docs/fixed-universes.md`.
The new mathematical vocabulary is entirely module-declared.

## Verified evidence and remaining work

`verify_homology.py` independently compares 17 canonical declarations: imported
module/class types, the module constructor, theory record/constructor/projections,
object/action adapters, the authored lambda, continuous-map identity/composition,
and all three statement types. It proves identity and composition via Mathlib's
`CategoryTheory.Functor.map_id` and `map_comp`, and lambda application by reduction.
Tests reject mismatched fields, theories and ambient spaces.

This is absolute, ordinary singular homology, with small spaces and modules and
natural-number degrees. It does not construct relative homology, reduced homology,
a connecting map, exactness, excision, a well group, or a basis. No statement here
settles the closed-cover/excision issue in the interlevel study.

A specific remaining compiler/interface gap is visible now: after
`Let M = homology module(field,H,X)`, Clean does not identify
`ModuleElement(K,field,M)` with `HomologyClass(K,field,H,X)`. Its named-index matching
is structural and does not unfold a local alias or invoke Lean conversion.
Computed index expressions and/or explicit transparent type/definition aliases
need a deterministic specification before generic module maps and subspace ranges
can compose through this interface. Do not hide this by declaring the two source
types equal or claiming a complete homology algebra API. The current induced map
exposes an ordinary function; the native construction is linear, but a generic
Clean linear-map/range interface remains to be added.
:::
