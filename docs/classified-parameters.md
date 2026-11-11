:::llm gpt-6 2026-11-11 role=assisted

# Classifier-declared record and type parameters

Record and type-constructor parameters now use declared classifier metadata,
matching the existing function-parameter model. This allows a record parameter
whose value is a carrier in a higher closed universe:

```clean
Type LargeTypes():
  Universe: 2
  Classifies: 1
  Means: Type 1
  Render latex: Types

Structure Package(A: LargeTypes):
  Universe: 1
  Let point: A
  Constructor: package

Type Packaged(A: LargeTypes):
  Equals: Package(A)
```

With the explicit topology import, `Package(TopologicalSpace)` is a valid type;
`Package(Real)` rejects because Real inhabits Type 0. The complete readable
[example](../studies/universe-classifiers/ParameterizedRecords.clean) includes
constructor projection, an authored unpack function, a parameterized native List
wrapper, an alias, attribution, and a theorem proved by reflexivity.

## Constructive syntax and meaning

No grammar production changes. The existing structure header has exactly the tree
`['StructureHeader','Package',[['A','LargeTypes']]]`. Parameter annotations use the
existing type grammar; constructor arguments in `Package(TopologicalSpace)` use
the existing type-argument grammar. `type(T : C)` remains expression syntax for a
carrier value, as used in `package(type(TopologicalSpace : LargeTypes),X)`.

Resolve each parameter annotation in telescope order under the explicit module
and preceding parameters. If its resolved type declares `Classifies: k`, store
that formal classifier in `parameter_types` and mark the slot as a carrier slot.
Do not recognize a classifier from its spelling. Renamed classifiers and aliases
therefore work; an ordinary type does not become a classifier merely by being
called Type. Natural and ordinary value slots retain their existing rules.

For each carrier argument, resolve its type tree once in the caller scope and
require closed Lean sort Type k using that slot's declared classifier. Do not
search visible classifiers or select by import order. Two visible classifiers at
the same level cannot make this slot ambiguous. Fresh unannotated `type(T)` still
uses its existing unique-visible-classifier rule and can be ambiguous. Alias
instantiation validates the formal slots before substituting the resolved body.

Emit the generic carrier binder as `(A : Type k)`; fields and subsequent parameters
refer to that same bound A. The record's declared `Universe: r` remains fixed,
and every stored field must fit it. The example translates schematically to:

```lean
structure Package (A : Type 1) : Type 1 where
  point : A
noncomputable def package (A : Type 1) (point : A) : Package A :=
  Package.mk point
noncomputable def unpack (A : Type 1) (P : Package A) : A := P.point
```

Production names retain generated stable identifiers; these short names are
explanatory. Parameterized native wrappers likewise emit explicit `Type k`
binders and their declared result universe. There is no universe inference or
implicit lift. The established generic Type-0 arrow handling remains its existing
special case; a newly declared higher-level arrow parameter retains its explicit
level restriction. This change does not add general universe polymorphism or
change the existing record-field binder mapping.

These rules determine one parameter kind, one closed level and one native binder
from the parsed declaration and fixed environment. Existing signature substitution,
constructor application, scope and retained-binding rules determine the remaining
term. This local argument does not establish global language conformance or resolve
all native-environment freshness obligations.

## Evidence and limits

Ten focused tests cover an independent header tree, higher parameters and
projection, wrong universes, parameterized aliases/native constructors, renamed
small classifiers, classifier aliases, competing classifiers, field-universe rejection, higher
arrow level checks, and rejection of the name Type without classifier metadata. A 111-test earlier focused run also covered structures,
computed carriers, type expressions and dependent calls. The final broader
integration run remains pending at this checkpoint.

Four independently authored canonical Lean targets check the constructor, unpack
function, native List wrapper and theorem statement; the theorem has a kernel-checked
proof. Reproduce with `python studies/universe-classifiers/check_parameter_targets.py`
in the pinned Lean/Mathlib environment. These checks compare elaborated types and
terms, not merely definitional equality. No topology paper theorem is proved by
this record extension. Full regression and broader native freshness remain pending.
:::

:::llm gpt-6 2026-11-11 role=assisted

The first 464-test integration run had one failure: the classifier-rejection
fixture assumed undeclared Type. Its explicit classifier setup is now fixed.
The first native carrier run also rejected the old wrapper-binder oracle for
Indexed; this is the intended mapping change to a generic Type-1 parameter.
The checker now requires `--classified-parameters` for the production oracle,
while historical study drivers retain their prior expectation by default.
The independent canonical comparator is unchanged. The corrected metadata and
parameter tests pass 21 cases, and 44 module/alias/universe compatibility tests
pass. Final selected/native validation and full discovery remain pending.
:::
