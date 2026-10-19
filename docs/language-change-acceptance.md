# Language change acceptance requirements

Every proposed language change must specify a deterministic parse and a precise, unambiguous translation to Lean. These are hard requirements, not performance goals. A proposal may remain exploratory while these obligations are unresolved, but it cannot be accepted as a fully specified feature or declared conforming. Intermediate commits remain allowed under the repository's linear-history policy.

## Two distinct guarantees

Fix the source, the specification version, and the complete build environment B: imported module contents and their source positions, syntax declarations, Lean and dependency versions, local bindings, universe parameters, expected type when present, and the declared elaboration policy and options. Environment inputs must be explicit and reproducible; machine paths, hash-table iteration order, task scheduling, cache state, and search timing cannot choose meanings.

Write P_B(s) for the set of syntax trees admitted by the grammar, after the specification's stated syntax normalization:

```text
|P_B(s)| = 0  → syntax error
|P_B(s)| = 1  → the unique syntax tree
|P_B(s)| > 1  → syntax ambiguity error
```

A declared precedence or conflict rule can eliminate alternatives before this count. Multiple derivations of the same specified tree count once. A type checker must not select among distinct syntax trees, even if only one would typecheck. Expensive parsing and exploring alternatives are permitted.

For a parsed tree a, write L_B(a) for the canonical Lean targets admitted by the translation and elaboration rules:

```text
|L_B(a)| = 0  → binding/type/elaboration error, with its specified category
|L_B(a)| = 1  → the unique checked Lean target and its type
|L_B(a)| > 1  → semantic ambiguity error
```

A parse can be syntactically valid but untranslatable. Acceptance requires one parse AND one Lean target. L_B(a) describes derivations permitted by the language rules; it does not mean every Lean term inhabiting a type or every mathematically equivalent formulation. The specification must give constructive rules or an explicitly pinned deterministic procedure, not require enumeration of all equivalent mathematics.

No successful result may contain unresolved expression/universe metavariables, unbound references, inserted `sorry`, or new axioms used to conceal a gap. Mathematical statement translation still defines a proposition; it does not prove that proposition.

## What counts as the same target

The target is a fully elaborated Lean expression in a specified environment and local context, together with its inferred type. It is not a pretty-printed Lean string containing unresolved notation or implicit inference requests.

For acceptance comparisons, canonicalization removes source locations and nonsemantic metadata, uses bound-variable indices instead of binder display names, identifies free locals by their declared context position, and renames compiler-generated identities and universe parameter names according to a documented stable identity map. User/imported declaration identities, application structure, binder kinds, universe instantiations, types, inserted coercions, instance arguments, and proof arguments remain explicit. For generated module declarations, compare the associated declaration types and bodies as well as their stable identities; renaming a wrapper cannot hide a changed body.

Bound-variable renaming is allowed. Definitional equality, proof irrelevance, or a theorem proving two terms equal is **not** a substitute for equality of these canonical targets. Such checks can establish additional mathematical correctness, but must not silently merge different translations. A specified normalization/desugaring step may prescribe one representative; it must be part of the translation contract, not an implementation convenience invented by the test runner.

Name resolution, notation selection, implicit arguments, coercions, literals, universe inference, typeclass evidence, defaulting, and generated wrappers all fall under this requirement. Selecting a unique visible notation declaration is insufficient if two permitted elaborations of its arguments remain. `From Lean` adapters obey the same target requirement; the contract must state the pinned Lean elaboration behavior and permitted extensions/options, rather than merely say “Lean handles it.” Undocumented first-success search is not a language rule.

## Failure and resource behavior

The failure stage is ordered: environment/import validation, syntax, binding, then elaboration. Within a stage, implementations may report different individual errors, but must agree on acceptance versus rejection and the specified failure category. Ambiguity is distinct from invalid syntax and from a type error.

If exploration or Lean elaboration runs out of resources, report `incomplete` with the stage. Exhausting a budget cannot prove that no alternative exists. One successful candidate plus an unfinished candidate is not unique success. Faster search, parallel scheduling, or a warm cache must never change one successful target into a different successful target. An incomplete run may become success or a definite error when sufficient resources are provided.

## Required proposal contents

Each proposal must include all of the following, or explicitly remain an unaccepted proposal:

1. The normative grammar delta, lexical mode, layout/continuation rules, and any declaration-conflict rules.
2. Scope and environment inputs, including visibility at every affected source position.
3. A translation rule for every new syntax-tree constructor: parameter binding, expected types, inserted arguments, and resulting Lean structure.
4. A uniqueness argument for both stages. Cite disjoint grammar cases, precedence rules, deterministic elaboration steps, or explicit ambiguity rejection. Examples alone are not a general uniqueness argument.
5. Readable positive specimens with independently authored expected syntax trees AND expected Lean targets/types.
6. Negative specimens distinguishing malformed syntax, syntactic ambiguity, missing names, type errors, semantic ambiguity, and incomplete analysis where applicable.
7. Interaction cases with existing syntax and an inventory of any still-open semantic choices. An unresolved choice on the new feature's path blocks acceptance of that feature, even if unrelated features can proceed.
8. Compatibility impact, implementation status, and the exact acceptance evidence. Review approval is not a substitute for executable validation once an implementation claims conformance.

## Required acceptance checks

| Check | Required observation |
| --- | --- |
| Independent parse oracle | Compare with the reviewed expected tree, not a tree captured from the implementation under test |
| Independent translation oracle | Compare canonical elaborated expression AND type with the reviewed target; include the relevant generated declaration graph |
| Kernel validation | Lean accepts the target under the pinned imports and declared assumptions; no placeholders introduced by translation |
| Unique syntax | A deliberately ambiguous grammar combination is rejected before attempting type-directed selection |
| Unique semantics | Competing notation meanings or permitted inference routes cannot be resolved by incidental enumeration order |
| Hidden inference | Record selected coercions, instances, universes, literal interpretations, and implicit arguments, not just the visible function name |
| Layout invariance | Equivalent allowed spacing, capitalization of keywords, and continuation preserve tree and target after the specified normalization |
| Binding hygiene | Renaming locals preserves the target modulo the documented identity map and cannot cause capture |
| Field ordering | Moving nonparameter fields around an unchanged parameter telescope preserves the target |
| Sequential visibility | A later import cannot repair or alter an earlier declaration; no test permutes imports across affected uses as if equivalent |
| Execution independence | Fresh process, warm cache, and different permitted candidate-enumeration/search schedules yield the same successful target or definite rejection |
| Resource handling | An unfinished alternative forces `incomplete`; a partial search cannot become unique success |
| Intent preservation | Include distinctions that Lean would happily typecheck: matrix-of-functions versus function-from-matrices, and reordered or missing hypotheses |

Not every proposal needs every domain-specific example. Every row must either have evidence or a justified “not affected” entry. Finite tests support the contract; they do not by themselves prove determinism for all inputs. A proposal also needs the rule-level uniqueness argument above.

## Initial acceptance cases and current limits

The [acceptance-case catalog](../tests/acceptance/language-contract.json) records initial specification oracles and gaps. `pending` means neither implemented nor passed; the catalog is not an executable conformance runner. Promoting a case to passing requires the actual source/environment fixture, an expected tree, an independent Lean-target oracle, and the checks above. A human-readable Lean target is only the starting oracle; a future runner must elaborate it in the pinned context and compare canonical target structure.

The current 104 Python tests, 80 corpus proofs, and paper statement-shape checks are useful regression evidence. They do not implement the canonical-target comparison or prove either uniqueness guarantee. The compiler still has known syntax/semantic migration debt. These requirements govern new language proposals and conformance claims immediately; they do not retroactively certify the prototype.
