:::llm gpt-6 2026-11-06 role=assisted

# Dependent function types: grammar and implementation contract

**Status:** dependent arrows now have an initial semantic implementation: scoped
binding identities, alpha-equivalent comparison and hashing, capture-free application,
free Type/Natural argument inference, inferred dependent lambdas, record fields,
and English/LaTeX rendering. The [graded-map study](../studies/dependent-functions/Maps.clean)
translates authored identity/composition and checks eleven canonical native targets
and three proofs. This is not yet a claim of full acceptance-contract coverage:
proof-valued domains/codomains, all naming collisions, and additional native
empty/singleton-domain and universe interaction oracles remain pending.

## Authored form and explicit module binding

```clean
Let f: Function(n: Natural, Vector(n,Real))
Let g: Function(p: Natural,
  ModuleMap(K,field,(M.component(p)),(N.component(p))))
```

The colon distinguishes a bound domain from an ordinary type argument. The latter
remains `Function(Natural,Real)`. The head is a normal, case-sensitive type name;
Function is not a new keyword. A spelling such as Mapping is equally parseable.
The semantic gate is the existing explicit arrow binding: after aliases
resolve, the selected constructor must have two type parameters and Lean template
`({0}) → ({1})`, modulo the already specified whitespace normalization. No other
constructor acquires binder semantics merely because it has two parameters.
No registry, name-based Function dispatch or import-order selection is introduced.

This interface grants the arrow constructor, rather than applying the generated
closed-universe demonstration wrapper to a type family. The dependent target is
Lean's Pi constructor with explicit domain and codomain. Domain/codomain universes
come from their existing declared types: a domain in Sort u and a codomain in
Sort v produce Sort (imax u v), which is Prop when v is zero and otherwise uses
max u v. No new universe parameter is guessed. Record Universe annotations remain explicit.

## Generated grammar and one tree

The type fragment is:

```ebnf
named_type_ref = TYPE_ID [ "(" [type_arguments | bound_type_arguments] ")" ] ;
bound_type_arguments = TYPE_ID ":" type_ref "," type_ref ;
```

The bound form has exactly one binder, domain and codomain. More binders are nested:
`Function(n: Natural,Function(x: Vector(n,Real),Vector(n,Real)))`.
The colon is not valid in an ordinary type-argument list. The existing strict LALR
and contextual-lexer checks pass without precedence hacks or conflict resolution.
The parser never consults types to decide which tree to construct.

The independent normalized tree for the first example is:

```text
["BoundTypeApply", "Function", "n",
  ["Name", "Natural"],
  ["Apply", "Vector", [["Name", "n"], ["Name", "Real"]]]
```

`type_spelling` preserves the bound colon and recurses through both types. Canonical
spacing is `Head(name: Domain,Codomain)`. Typed Let and compact declaration headers
have an outer type-text envelope; that envelope now preserves colons *inside*
parentheses. The structural type parser remains responsible for their placement
and arity. A colon outside parentheses still delimits the declaration header.
This envelope is not an alternative interpretation of malformed type syntax.

Existing parenthesized continuation, comments, tabs prohibition and indentation
rules apply. No new document block, token keyword, operator precedence or comma
separator is added. Keywords retain their existing capitalization rules.

## Scope and elaboration

1. Resolve the head to its one explicit arrow declaration. Resolve the domain
   before binding the new name. The binder must satisfy the expression-identifier
   rules (so reserved expression words are not binders), and be fresh against visible locals,
   type/alias names and callable names, just as for function expressions.
2. Give the binder a fresh local identity of the resolved domain type. It scopes
   only over the codomain. Nested binders extend that scope; shadowing is rejected.
   Restore the surrounding environment even on failure. Carry the existing alias
   expansion trail through domains, codomains and nested type arguments, so a cycle
   crossing a bound arrow is rejected as a cyclic alias.
3. Resolve the codomain using the ordinary type checker, including typed dimension
   and value indices. The result carries the binder identity, its domain and its
   resolved codomain. No source-name substitution into an opaque Lean body is used.
4. If the codomain has no free occurrence of this binder, normalize to the ordinary
   arrow type. Thus `Function(x: Real,Real)` and `Function(Real,Real)` agree. Otherwise
   retain a dependent-function type. Dependency is a free-reference property of the
   checked type, including value-index call heads, nested domains and codomains;
   it is not a substring search for the binder's spelling.
5. Type-valued binders such as `Function(T: Type,...)` are outside this initial
   profile. This is a bounded implementation step toward general dependent
   functions, not a decision to exclude type families from Clean permanently.
   Explicit value binders, including existing evidence types, keep their ordinary
   binding semantics. No instance binder or implicit function argument is inferred.

## Alpha-equivalence and capture-free substitution

Source binder names are presentation, not type identity. Build comparison keys by
abstracting each bound identity to a de Bruijn position. Recursively process the
domain outside that binder's scope, then the codomain inside it. Free local and
module identities remain distinct. Value-index comparison retains all its selected
wrapper/instance/universe information; only references to this known bound local
are abstracted. Do not erase indices, replace all occurrences of a source word,
or use pretty-printed Lean equality as an alpha-equivalence test.

For example, `Function(p: Natural,Vector(p,Real))` must compare equal to the same
form using q, but not to `Function(q: Natural,Vector(n,Real))` with free outer n.
Equality and hashing must share the same abstracted key. Nested binding and a free
local with a compiler-like name need independent acceptance tests.

At application, substitute the checked argument for this bound identity throughout
the codomain, including nested domains, value indices and function-valued call
heads. Reuse the existing typed index reconstruction rules; preserve Natural index
kind. Freshen nested bound identities before inserting an argument that might
otherwise be captured. No theorem equality, coercion search or proof synthesis is
part of this substitution. Recheck the resulting type in the caller's scope.

When matching a dependent callable's formal function type against an actual one,
align their bound identities to a fresh shared comparison identity, match domains
first, then codomains under that alignment. Infer only the already permitted free
Type/Natural parameters using the declared traversal order. A function's bound
variable is never an inferred argument. Normalize constant codomains to ordinary
arrows before this matching. Instantiating a returned function type substitutes
free parameters and freshens its binders; it does not replace constructor identity
or invoke function extensionality.

## Functions, fields, and one emitted Lean expression

Both `f(x)` and `P.field(x)` must use the same application operation. For an ordinary
arrow it returns the fixed codomain; for a dependent arrow it returns the substituted
codomain. Arity is one, with currying represented by nested function types.

The existing `function(x: T,body)` expression keeps its current emitted lambda.
If the inferred body type depends on x, its result type becomes the dependent arrow
through the uniquely selected explicit arrow binding. If not, it remains the
ordinary arrow. Unresolved numeric body types stay errors. This is inferred-body
analysis, not expected-type lambda inference.

The type target is exactly `(fresh : ⟦Domain⟧) → ⟦Codomain⟧`, with default explicit
binder information and capture-free bound occurrences. Allocate deterministic fresh
names in binder preorder, avoiding every visible emitted local and selected module
identifier. Abstract comparison identities are separate from those display names.
A constant codomain emits the ordinary arrow after the normalization above.
Applications remain applications of the original function term: do not silently
beta-reduce the emitted program because its result type was substituted.

An authored structure field uses this same type target. A constructor takes that
function as an ordinary explicit argument. Projecting the field substitutes header
parameters and earlier fields before applying it. Top-level callable signatures,
local definitions, aliases, automatic Condition labels, Lean emission and LaTeX
must all handle the new type constructor; parser support alone does not discharge
these requirements.

## Rendering and acceptance work

Use an English statement description: “a function assigning to each x of type D a
value of type C,” with the existing mathematical type renderings substituted.
The compact type rendering is the dependent product `\prod_{x:D} C`; the text
explains it when used in a declaration. Source binder names survive rendering.
Rendering never supplies a missing scope or selects the Lean target.

The parser tests cover nested types, commas within domains, header and Let envelopes,
lambda domains, multiline layout, malformed syntax and ordinary-arrow compatibility.
Semantic tests independently exercise alpha identity/hash, nested capture avoidance,
free versus bound dimensions, compiler-name freshness, applications at 0 and 1,
implicit Type/Natural inference, dependent fields, aliases and label serialization.
The native graded-map checks retain instances, universes, wrapper applications and
binder information. Three generated statements have kernel-checked proofs.

Implementation detail: checked index comparison templates retain their existing
representation. Fresh compiler identities avoid identifiers in all loaded native
declarations and visible emitted local terms/types. Comparison tokenizes these
templates and abstracts only the allocated identities; it never substitutes a
source binder spelling in an opaque native body. Substitution traverses source ASTs
and rechecks affected indices. Unaffected indices retain their already checked
values. A temporary shared binder aligns callable codomains; inferred parameters
containing that binder are rejected before it leaves scope.

Pending acceptance work includes broader proof-domain/codomain, empty/singleton
native family, universe, and automatic-label collision oracles. Type-valued binders
remain explicitly unsupported. Applied fields of explicit authored producers now use the
[hygienic conversion extension](hygienic-producer-conversion.md); unapplied
binder-bearing families remain opaque in index comparison. Neither this feature nor the graded-map laws prove the topology
paper theorems.
:::
