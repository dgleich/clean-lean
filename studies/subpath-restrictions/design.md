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

## Implemented callable evidence checkpoint

The callable-evidence prototype is now integrated. Its
[contract](../../docs/callable-evidence.md), [native study](../callable-evidence/README.md)
and focused tests are directly available. Historical patches are preserved in
Git history. The integration follows the preceding compiler's passing 584-test
run; it is not a completed conformance claim for the new feature.

The scoped proof index retains the checked condition tree, captured local
expressions and owned comparison key. Authored universal quantification and
implication expose callable views while emission preserves the original evidence
term and named condition type. Function comparison recurses under fresh binders.
Implicit rebinding of a captured proof local is rejected. Opaque native conditions
and automatic callable views of negation remain unsupported.

The combined focused/regression run passes 197 tests, including 26 callable cases.
Twenty-one independent exact native comparisons and fifteen proofs pass. Cases
cover generic projected proof fields, nested proof-family arguments, inferred
carriers, name-resolution precedence, wrong arity without fallback and captured
scopes. The three-page LaTeX specimen compiles twice and was inspected. Its proof
field description explicitly includes the carrier.

The motivating subpath interface has also been checked in a separate prototype:

```clean
Assume hs: subpath sources preserved(n,a,m,h,d)
Assume ht: subpath targets preserved(n,a,m,h,d)
```

These named assumptions are accepted directly by the subpath shape-map and
restriction definitions. Three independently authored exact targets and one
inclusion proof pass. The native targets retain the two named condition types
and pass hs and ht unchanged to the constructor. This check assumes endpoint
preservation; it does not replace the earlier unconditional endpoint proofs or
establish the unfinished interval-basis theorem.

The main compiler's ASTs match the isolated snapshot frozen for full regression
and the 33-study native portfolio. Both runs are pending. The existing review
browser describes the preceding 107-file snapshot; a refresh for the new study
is pending. Remaining work includes completing full validation and the consumer
acceptance audit, validating the reusable subpath modules and finishing the arrow
statement. The [source study](README.md) now records the current intermediate
checkpoint; its expanded native run remains pending. The contract and acceptance catalog describe implemented behavior but
are not themselves evidence that these remaining gates passed.
:::

:::llm gpt-6 2026-11-07 role=assisted

## Subpath arrow checkpoint

The reusable modules and arrow statement now pass nineteen exact native targets
and six proofs. Requested-field selection during comparison avoids expanding
irrelevant diagram fields while preserving emitted Lean projections. This
supersedes the preceding paragraph's pending subpath-arrow validation status.
The generated Lean, proof-bearing Lean and inspected one-page PDF are included.
The new compiler snapshot is running the full tests and native portfolio; the
review browser is being rebuilt for the current sources. Those wider checks are
still pending. Interval-basis restriction and the paper's extension theorem
remain unfinished mathematics.
:::
