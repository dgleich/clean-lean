:::llm gpt-6 2026-11-10 role=assisted

# Inferring value parameters from dependent operand types

Status: implemented slice in the working compiler, with focused and native
validation below. Full conformance remains unproven. This is separate from general
universe-polymorphic carrier signatures.

## The concrete missing interface

The relative-homology study compares two `CoefficientModule(K,field)` values and
two `ModuleChainComplex(K,field)` values. These carriers inhabit Lean Type 1, so
the current Type-0 generic equality is ineligible. A concrete declared equality
would suffice, except that binary operators must have exactly two explicit
operands. The field structure must therefore be inferred from their types:

```clean
Condition same module(M,N):
  Let K: Type
  Let field: FieldStructure(K)
  Let M,N: CoefficientModule(K,field)
  Infix: =
  From Lean: M = N
  Render latex: {M}={N}
```

This declaration is now supported. Previously, `field` was rejected because only
Type and Natural parameters could be implicit. Adding `field` to
the header would produce a three-argument function, which cannot be attached to
binary `=`. A concrete module equality needs no new universe inference: its
carrier and universe are already declared. General sort-polymorphic equality,
including equality of proofs, remains separate work.

## Declaration and scope rule

There is no grammar or layout delta. Existing signature syntax parses once;
parameter classification happens after parsing. Header names are explicit
parameters. Typed `Let` names absent from the header are implicit parameters,
all of which must precede explicit parameters. Each parameter type is resolved
in the preceding telescope; forward references and recursive parameter types
are rejected. Multiple names in one Let share a type resolved before introducing
any of those names. Keyword capitalization and continuation are unchanged.

The extension permits a non-Type, non-Natural implicit parameter only
when it has a direct, recoverable occurrence as an index in an explicit operand's
type. An occurrence beneath an arbitrary function application is insufficient.
For example, matching `CoefficientModule(K,field)` against
`CoefficientModule(F,f)` supplies the checked carrier F and the checked value f.
Matching `Family(transform(field))` is not permission to invert `transform`.
Parameters occurring only in a return type or native body remain errors.

## Inference and target construction

1. Elaborate the explicit operands under the existing expression rules. Preserve
   their checked types, source binding identities, and retained module calls.
2. Traverse each formal/actual operand-type pair in header order, visiting type
   arguments left to right. A direct implicit occurrence records a candidate
   from the corresponding actual type index. Record the original checked term;
   do not reconstruct its meaning from a display name or normalized spelling.
3. Process inferred parameters in telescope order. Substitute previously checked
   candidates into the declared parameter type and check the recorded value
   against that type. Missing candidates, captured binder variables, or invalid
   types reject this declaration as a candidate. A value hidden behind an opaque
   native reduction cannot be recovered by asking Lean to guess it.
4. Repeated occurrences must agree under the existing specified Clean type/index
   comparison. For newly supported value parameters, preserve the first occurrence in the
   specified traversal as the emitted term; this is source-order selection of a representation of an agreed
   index, not selection among distinct operator meanings. No proof-irrelevance
   rule, coercion, or typeclass search is added. Different field structures must
   not be identified merely because they have the same type.
5. Recheck all operand types with the complete substitution. Substitute it into
   the result. Emit the declaration's root-qualified constant with every implicit
   and explicit argument supplied in telescope/header order.

For the example, with generated names replaced by readable schematic identifiers:

```lean
noncomputable def sameModule {K : Type} {field : FieldStructureWrapper K}
    (M N : CoefficientModuleWrapper K field) : PropositionWrapper := M = N

-- For M, N : CoefficientModuleWrapper F f:
@sameModule F f M N
```

No native metavariable is left for K or field. The existing fixed native adapter
elaboration contract still applies to its body. Named `same module(M,N)` and the
selected `M=N` application have the same target; only their presentation differs.
All eligible operator declarations must still be checked, with multiple distinct
permitted targets rejected. An incomplete competing check cannot become success.

## Determinism and consumer obligations

The parser receives no new productions and no type-directed syntax choice. The
inference traversal, dependency order, comparison rule and representative rule
above are fixed. They specify a single explicit argument vector per eligible
declaration. Existing overload ambiguity rules govern the union of candidates.
Resource exhaustion remains incomplete analysis.

The implementation must preserve inferred values in declaration snapshots,
`inferred_args`, authored conversion, binder substitution, dependent callable
matching, bound-call closure, and fresh-scope rechecking. Both local and computed
actual indices need their checked trees and types. The declaration checker requires a direct value-index occurrence; the dependent
matcher recovers that index, rechecks its term/type, and emits the checked term.
Inferred-argument reification preserves the recovered value type instead of
forcing it to Natural. Rendering must keep authored operands readable;
inferred fields are already stated by their operand types and are not additional
assumptions. Operator spelling and LaTeX precedence remain unchanged.

## Acceptance coverage and remaining requirements

- Independent signature tree and canonical declaration/application/type oracles
  for module equality and chain-complex equality; kernel checks of relative
  homology's four statements and proofs.
- A computed field argument, a retained module call, and a dependent callable
  operand; capture avoidance and source-name collision checks.
- Repeated equal indices and conflicting field values; wrong dependent types;
  an absent implicit parameter; an index appearing only under a noninvertible
  function; a return-only implicit parameter; a later declaration unavailable at
  the use site.
- A second eligible equality with a distinct native target must remain ambiguous;
  reversing overload storage order and changing caches must preserve outcomes.
- Bound definitions must keep the inferred value after later imports/defaults;
  fresh public checks must not trust poisoned cached argument metadata.
- Existing Type/Natural inference, explicit proof arguments, numeral completion,
  renderer/editor behavior, and the full regression suite must be revalidated.

The list above is the full required coverage, not a blanket claim of passing.
Current evidence:

- `tests/test_inferred_values.py`: eleven passing tests cover the signature/tree
  oracle, explicit application spelling, equal/conflicting field indices,
  same-named caller locals, computed values and first-occurrence preservation,
  dependent callable operands and escaping binders, absent/non-direct indices,
  competing overloads, changed public scope and poisoned inference metadata,
  wrong recovered types, retained calls after a competing declaration, and the
  existing fresh-binder restriction.
- `tools/check_inferred_value_targets.py`: five independent canonical checks of
  declaration types/bodies and computed/callable applications, plus two proofs.
- `studies/topology/verify_relative.py`: 28 independent targets and four proofs,
  including both concrete equality adapters; the standalone chain module also
  compiles. Its PDF compiled twice and was visually inspected. A long attribution
  produces an underfull-box warning; no unresolved references occur.
- 55 focused tests pass, including the eleven above and existing family, scope,
  hygiene and space-equality checks. All 92 curated corpus proofs pass Lean.

The complete regression run is pending. Comprehensive consumer interactions,
layout variants for the new signatures, explicit incomplete-analysis injection,
and native import/instance isolation are not fully validated by this checkpoint.
The former same-module declaration failure is resolved; general sort/universe
polymorphism, including generic proof equality, remains unfinished. The old
Type/Natural representative-selection behavior is unchanged; the first-occurrence
rule applies to the newly supported value parameters.
:::

:::llm gpt-6 2026-11-10 role=assisted

The [condition-inference slice](../studies/inferred-conditions/README.md) is now
integrated. A formal proof-condition index that is exactly a local implicit
parameter recovers the actual checked condition, including quantified conditions.
The caller's scope and declared parameter type are rechecked; repeated occurrences
must agree, the first agreed representation is emitted explicitly, and computed
formal conditions are not inverted. The explicit `logic/proof_equality.clean`
module declares equality of evidence. Standard implication is now authored in
Clean as universal quantification over evidence, using the existing callable view.
No grammar, layout, highlighting, display-name dispatch or proof search is added.
Full conformance and the remaining native isolation/universe obligations stay open.
:::
