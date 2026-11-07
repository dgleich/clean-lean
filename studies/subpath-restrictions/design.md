:::llm gpt-6 2026-11-07 role=assisted

# Finite subpath restrictions and callable assumptions

Status: an isolated prototype passes sixteen exact Lean-target comparisons and
four Clean statement proofs. Integration is pending while the preceding compiler
snapshot completes its full regression and browser builds. This document records
the construction and the language gap; it does not claim the paper's interval-basis
restriction or extension theorem has been proved.

A zigzag with n edges has vertices Fin(n+1). A subpath starts at a and has m edges,
with evidence h that a+m ≤ n. Its edge map and vertex map add a to the index.
The vertex construction explicitly transports along natural-number associativity
before widening its bound. It works when m=0, including the final singleton
vertex when a=n. Both orientations of every edge are covered.

The five native adapters are Fin.natAdd, Fin.castLE, Fin.cast, Nat.add_assoc and
Nat.add_le_add_right. The edge map, vertex map, restricted directions, endpoint
conditions, shape-map constructor and diagram restriction are authored in Clean.
The native adapters perform finite-index operations; they do not contain the
subpath construction or its endpoint proofs.

## Current authored interface

```clean
Define restricted zigzag(field,n,a,m,h,d,hs,ht,Z):
  Let K: Type
  Let field: FieldStructure(K)
  Let n,a,m: Natural
  Let h: Evidence((a+m ≤ n))
  Let d: Function(Vertex(n),Boolean)
  Let hs: SubpathSources(n,a,m,h,d)
  Let ht: SubpathTargets(n,a,m,h,d)
  Let Z: Zigzag(K,field,n,d)
  Returns: Zigzag(K,field,m,(subpath directions(n,a,m,h,d)))
  Equals: pull back diagram(field,
    zigzag shape(m,subpath directions(n,a,m,h,d)),zigzag shape(n,d),
    subpath shape map(n,a,m,h,d,hs,ht),Z)
```

SubpathSources and SubpathTargets are transparent type aliases for dependent
functions returning evidence of the corresponding endpoint equation. They are
not new records. SubpathShapeMap similarly abbreviates the existing shape-map
type. Type aliases currently accept Equals but not Describe fields; readable
prose descriptions for these aliases remain a rendering gap.

The four checked statements assert source preservation, target preservation,
existence of an inclusion without assuming endpoint certificates, and the object
formula for restriction. The first two have arithmetic proofs; the third constructs
the inclusion using those proofs; the fourth follows by unfolding the authored
restriction. Exact comparisons cover twelve definitions and four propositions.
The comparison checks canonical elaborated types and bodies, retaining constants,
implicit arguments and proof arguments; it does not merely ask for definitional
equality. The isolated run used the type-expression integration compiler; it must
be repeated with the final repository compiler when the study is integrated.

For arrows, a restricted edge is the parent arrow composed with source and target
module transports. A bare equality to the parent arrow generally has different
endpoint types. An arrow statement must retain those transports. That statement
and its exact target remain to be added.

## Desired use of named assumptions

This should eventually be expressible without a separate proof-family alias:

```clean
Assume sources: subpath sources preserved(n,a,m,h,d)
Assume targets: subpath targets preserved(n,a,m,h,d)
```

The constructor should accept sources and targets where it expects their
corresponding dependent proof families. For an edge e, sources(e) should produce
evidence of its source equation. Lean already supports both operations: the
condition unfolds to a forall, which is the type of a dependent function producing
proofs. This introduces neither a proof search nor a choice of proof.

Current Clean rejects the constructor call: its ProofType for a named condition
is not recognized as a dependent callable type. Merely changing the function-type
predicate is insufficient. ProofType currently stores a general computed index,
and that representation deliberately rejects binders. Nested universal conditions
therefore require a scoped proof-type representation as well.

## Proposed semantic work, not implemented

Keep the existing expression parse. A call to a local universal assumption uses
the existing Call tree, and a projected callable proof uses the existing Apply
tree. No new punctuation or overloaded declaration keyword is needed.

A proposed elaboration rule is to derive a callable view from a proof type:

1. Preserve the original proof type and its emitted Lean expression.
2. Inspect only its checked Clean condition representation. Expand authored
   condition definitions hygienically using their already selected arguments.
   Do not inspect opaque Means bodies or choose a view by trying native elaboration.
3. If the exposed head is a universal quantifier, its domain is the argument type.
   Its body, with the bound variable substituted, is the resulting proof type.
   Preserve the binder's owned identity and captured free variables.
4. Applying the evidence emits ordinary Lean application of the original term.
   Passing it as a dependent function emits the original evidence term. No eta
   expansion, proof replacement or native cast is inserted.
5. Repeat the same rule for nested universal results. A condition whose head is
   equality, conjunction or existential quantification is not callable by this rule.

This view must also be used by dependent argument matching, substitution through
call heads and constructor fields. Matching compares domains and then codomains
under a shared fresh binder. It must never infer a free argument by allowing that
binder to escape. Neither the callable view nor a later local declaration may
change the saved proof's meaning.

Before this can be an accepted language change, specify the scoped proof-type
representation, its substitution/comparison keys, the exact authored head-expansion
boundary and the interaction with local/module callable name collisions. Existing
function locals take precedence over module callables; extending that to callable
evidence needs an explicit rule and rejection tests. The rule must be shared by
all expression consumers, not implemented only in constructor checking.

Required acceptance examples include direct and named universal assumptions,
nested dependent quantification, projected proof fields, constructor arguments,
renamed binders and free-variable collisions, and named conditions with inferred
carrier arguments. Negative examples include the wrong domain, wrong equation,
nonuniversal evidence, opaque native conditions, and escaping bound variables.
Each positive needs an independent tree and exact native target; the subpath
constructor must accept the original assumption term with no replacement proof.

## Remaining mathematical work

The subpath construction is a prerequisite for restricting interval bases. It does
not yet clip intervals, discard empty intersections, reindex surviving basis
vectors or prove that they form a basis at each restricted vertex. The pyramid,
interlevel extension and paper theorem remain separate unfinished mathematics.
:::


:::llm gpt-6 2026-11-07 role=assisted

## Isolated implementation checkpoint

The [prototype patch](callable-evidence-prototype.patch) records the experimental
compiler, tests and a reproducible native study without changing the compiler
being validated in the main repository. It applies to the compiler at commit
6ca37dd. This is an intermediate implementation, not an accepted or integrated
language change. Apply it only to an isolated copy when reproducing the experiment.

The experiment stores a checked condition tree, captured local expressions and
an owned comparison key in a scoped proof index. A source-derived callable view
exposes authored universal quantification and implication as function types.
Emission retains the original proof type and uses the original evidence term.
No proof search, replacement proof, eta expansion or native cast is introduced.
Negation does not yet receive a callable view, and opaque native conditions are
not inspected. Existing immediate-lambda contraction is retained; substitution
renames binders in inserted actual expressions before checking the result.

The patch includes studies/callable-evidence/Statements.clean and its standalone
verify.py. With the patch applied, run
`LAKE=lake python3 studies/callable-evidence/verify.py` from the isolated checkout.
Fourteen independent exact native comparisons and ten proofs pass. Cases include
direct and named universal evidence, generic projected proof fields, proof-family
arguments, nested quantification, captured free variables and type scopes,
implication application and saving an assumption as a local value. The verifier
regenerates Lean and TeX artifacts; these will be tracked directly on integration.

The generated parser matches its unchanged grammar under strict LALR and lexer
checks. The combined focused/regression run passes 186 tests. Sixteen focused callable
cases, including an additional syntax-only serializer round-trip test, also pass.
The old assertion that quantified assumptions cannot be saved as values has been
replaced; a separate exact native target now covers that operation. Three older
negative tests exposed changed diagnostic precedence. The revised non-condition
index test supplies a correctly typed lambda and still requires binder rejection.
Higher-order lambda applications whose bodies contain binders remain rejected;
their tests now check the specific application-boundary diagnostic.

The specimen compiles twice and its two-page rendering was inspected. The proof
field's prose description explicitly includes its carrier; the initial generic
fallback omitted that information and was corrected in the specimen.

One necessary extension surfaced during the experiment: Evidence is a transparent
alias taking a condition as a value argument. Supporting a direct universal
condition therefore requires scoped condition-valued type indices as well as
proof types. The prototype permits these only when the argument's checked type
is Proposition. Other computed indices still reject binders. Type syntax spelling
preserves these binders without consulting an environment; the semantic check
selects the permitted index representation. This boundary needs to enter the
formal specification and acceptance catalog before integration.

Remaining work includes the full substitution and expression-consumer audit,
local/module call-name collision tests, further canonical comparison under binder
renaming, formal acceptance documentation, full-suite validation and integration.
The experiment has not established conformance. General captured-scope
substitution must not be inferred safe merely from the passing examples.
:::
