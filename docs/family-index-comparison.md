:::llm gpt-6 2026-11-06 role=assisted

# Comparing authored families as indices

A named graded object and an authored alias of it must be usable at the same
index. The graded relative-homology specimen exposed a missing case: unfolding
both names produces a record containing a function, and the earlier public
normalizer deliberately kept such records opaque.

## Syntax and scope

No grammar production changes. Authored `Define … Equals:` bodies may already
contain functions. Direct computed-index expressions containing Lambda, Forall or
Exists remain rejected. This change concerns only comparison of already checked
indices whose permitted authored expansion exposes a binder.

The independent tree for `graded relative homology(K,field,H,X,P)` is a Call with
five Local arguments, in that order. Imports explicitly determine the callable,
its parameters and its result type. Parsing does not consult conversion or native
elaboration to choose between trees.

## Constructive comparison rule

After the original expression has been checked and immediate permitted lambda
applications contracted, construct its index key as follows:

1. Run the existing ordered internal definition normalizer. It follows only
   supported authored bodies, constructor projections, local comparison values,
   and the existing restricted immediate-lambda contraction. Preserve its existing
   guards against inferred-body parameters and shadowed module bindings.
2. If the resulting tree is binder-free, use its existing selected Lean template.
3. Otherwise, elaborate that entire checked tree once in the original caller
   scope, using the ordinary expression elaborator. Require the resulting type to
   equal the original determined type. Use the resulting Lean template as the key.
   A changed type is an error, not permission to choose a different target.

The whole-tree step is essential: separately elaborated fragments may have reused
compiler binder names. A single traversal allocates fresh compiler identities in
scope, using the existing deterministic `clean_bound_N` allocator and dependent
arrow allocator. Source binder spellings do not enter term identities; bound uses
refer to their allocated identity. Free caller names remain free. Domain annotations
are checked before extending the binder's scope, including dependent annotations.
The fixed environment and traversal order select one template; no textual rewriting
of opaque Lean bodies is used to identify bound names.

These keys participate in the existing ValueIndex equality and hash contract. They
are comparison data only. The resulting expanded tree is never supplied as an
actual argument to a dependent callable. Internal call reconstruction continues to
use the earlier binder-opaque public normalizer; this prevents a hidden expansion
from becoming an illegal authored computed index. The local-definition cache policy
is unchanged: it does not freeze an expanded binder-bearing tree for later scopes.

This is bounded conversion, not full native definitional equality. The normalizer
does not descend into lambda/quantifier bodies to simplify their contents, introduce
eta/extensionality, consult assumed equalities, or inspect Means/From Lean bodies.
Opaque outer calls can still distinguish arguments whose equality would require
propagating family expansion through that call. Resource exhaustion is incomplete
analysis, never an inequality verdict. General higher-order conversion and resolved
module identities remain separate work.

## Exact emission and evidence

The new key does not replace emitted definitions, argument order, explicit evidence,
instances or type annotations. Graded relative maps retain named graded relative
objects in their signatures and call the authored graded chain-homology map in their
bodies. Existing explicit-producer projection emission still applies: selecting a
field may expose the producer body according to that earlier rule.

The tests in `tests/test_family_comparison.py` cover aliases, alpha-renamed and nested
binders, dependent domains, free-versus-bound distinctions, caller names resembling
compiler identities, hash consistency, opaque native bodies, module shadowing and
continued rejection of directly authored binder indices.

[RelativeGraded.clean](../studies/dependent-functions/RelativeGraded.clean) exercises
the rule in actual topology interfaces. Its independent native verifier compares ten
canonical targets and proves five statements. The higher-level constructions are
Clean definitions; the only new native binding is the generic chain identity map.
:::
