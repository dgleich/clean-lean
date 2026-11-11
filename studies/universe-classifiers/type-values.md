:::llm gpt-6 2026-11-11 role=assisted

# First-class carrier values: isolated implementation

The classifier stack now elaborates both `type(T)` and `type(T : C)`. This is
an isolated implementation, not production integration or full classifier
conformance. [TypeValueExample.clean](TypeValueExample.clean) uses the actual
Mathlib-backed TopologicalSpace type, an explicit classifier, and an authored
carrier-returning definition. Its three statements have checked Lean proofs.

## Selection and one native target

The generated grammar still produces `['TypeValue', T]` for the unannotated form
and `['ClassifiedTypeValue', T, C]` for the annotated form. No type-directed parse
selection is introduced. Both references use the existing type-reference grammar.

1. Resolve T as a checked carrier type. Proof types cannot be carrier values.
2. For an explicit C, resolve it and require a closed declared classifier. Its
   Classifies level must equal T's closed Type level exactly.
3. Without C, enumerate visible closed type declarations, resolve transparent
   aliases, and collect classifier identities at T's level. Deduplicate aliases
   by native identity. Exactly one identity is required. Zero is a missing
   classifier error; multiple identities are semantic ambiguity. Expected types,
   declaration order and first-success search do not choose a classifier.
4. The Lean term is the rendered checked T, with no inserted coercion or universe
   lift. Its checked Clean type is the selected classifier. A declaration returning
   that classifier retains its native wrapper as its result type. This distinction
   is checked against independently written native declarations, not merely Lean
   definitional equality.

Two concrete type heads claiming one native classifier identity but resolving to
different checked types are an inconsistent environment, not an order-dependent
choice. Classifier validation checks the primitive native Type body, its closed
level, successor universe and native declaration integrity.

## Retention and substitution

Elaboration produces the internal form:

```text
[BoundTypeValue, checked_carrier_annotation, checked_classifier_annotation,
 classifier_snapshot, presentation]
```

The classifier annotation is closed. The snapshot is a tuple of native binding,
classified level, declared universe, native body template and native declaration.
Presentation is `implicit` or `explicit`; it affects source/LaTeX spelling, never
selection. Replay checks the stored snapshot against the selected declaration and
rechecks the carrier's level. It does not rerun unannotated candidate selection.
Thus adding a competing classifier makes new `type(T)` expressions ambiguous but
does not reinterpret an already bound value. Changing/removing the selected
classifier or its native declaration rejects replay.

Carrier annotations retain checked types and free local references. Substitution
changes those references using the existing capture-avoiding annotation rules;
it preserves the closed classifier annotation and snapshot. Aliases in fresh
carrier spellings normalize to their checked carrier, preserving existing
assumption-name duplicate detection. Classifier aliases resolve to the canonical
classifier identity. Explicit and implicit source spellings remain distinct.

For an inferred generic carrier used as a value in an authored body, reification
receives the formal parameter's declared classifier. It constructs the corresponding
explicit type value; it does not guess from visible candidates. This allows
`retain inferred(X)` to unfold through `retain in(A,x)` even with two visible
level-1 classifiers. Direct explicit arguments still require the selected
classifier identity; inference does not grant an automatic explicit-argument cast.

The same rule applies when dependent-call substitution places an inferred carrier
in a value index, computed index or dependent callable type: first reify that
carrier with its formal classifier, then perform the existing capture-avoiding
substitution. Explicit arguments and inner scope bindings take precedence over
inferred bindings. Direct carrier-type substitution keeps the checked Type. This
avoids accidentally rerunning visible-classifier selection for `Indexed(A)` or
`Vector((marker(A)),Real)`. It does not add higher projected-carrier support.

The snapshot protects the classifier contract. It does not replace the existing
native-type/adapter environment contracts for the referenced carrier or establish
freshness under arbitrary coherent mutation of the entire environment.

## Consumer coverage and rendering

| Consumer | Implemented behavior |
|---|---|
| Expression elaboration and numeral-hole scanning | Recognize raw and retained forms; carrier references have their own type checking |
| Module-call binding | Close type values and validate retained snapshots |
| Callable comparison and authored-body normalization | Recheck retained values; reify inferred carriers with their formal classifier |
| Carrier extraction | Recover the checked carrier from a retained type value |
| Dependent indices, beta contraction and projection substitution | Preserve the classifier while substituting carrier annotations |
| Free-reference scanning and hygiene | Track carrier references; never treat snapshot text as local names |
| Assumption labels and source serializers | Emit `type(T)` or `type(T : C)` without internal snapshot data |
| LaTeX | Implicit values render as T; explicit values render as `(T : C)` to retain the authored distinction |

All existing TypeValue consumers were audited and updated where needed. The
unchanged explicit parameter rule maps generic domains to primitive Type k;
ordinary theorem binders retain their declared wrappers.

## Validation and boundaries

Twenty-six focused tests pass, covering unique/ambiguous selection, aliases,
order independence, expected-type independence, wrong levels, ordinary bundles,
stale metadata, changed native declarations, source names, LaTeX, computed indices,
substitution, named carrier definitions and inferred-carrier reification. The
final focused run passed 26 tests in 8.236 seconds. Three added cases reject
missing local carriers, omitted free references and nonclosed classifier
annotations. Two more cover direct and computed result indices with an inferred
carrier and competing visible classifiers. The earlier scope/conversion run
passed 83 tests; its seven native targets and three proofs also passed. The
expanded first-class/type-expression/conversion groups passed 79 tests before
the final named-carrier case was added. The complete selected reproduction is
tracked by [verify.py](verify.py): the fresh pinned reproduction passed 281
selected tests in 98.132 seconds, including strict parser reproducibility. That
run predates the five scope/result-index cases; a fresh reproduction is running.

[TypeValueTargets.lean](TypeValueTargets.lean) checks ten independent exact
native targets and proves all three example statements. The final native run
includes independent declarations for the indexed type and generic tag function,
plus an application whose result index contains the inferred topology carrier. One oracle explicitly
supplies the outer equality's carrier, rather than allowing Lean to select a
definitionally equal carrier-returning definition. This preserves the specified
canonical argument choice. [TypeValueSpecimen.pdf](TypeValueSpecimen.pdf) was
compiled twice and visually checked as a single landscape page with no overflow
or unresolved references; only the existing `latex/clean` package-name warning
remains after the second run.

Stored payload support is **not complete**. The retained form requires checked
annotations; a plain JSON round trip discards those annotations and is rejected.
The versioned bound-tree codec and LocalType level/identity schema still need
migration before payload-only replay can be claimed. The `.resolved` in-memory
index path is covered; it is not evidence for persisted round trips.

Higher computed/projected carriers, carrier-valued dependent function binders,
full higher-carrier record/type-constructor handling, and type-valued local
Let definitions remain unsupported or incomplete. The local-definition rejection
now recognizes all declared classifiers, rather than only the name Type.
General universe polymorphism, full regression and production integration remain
separate unfinished obligations. No missing mathematical paper theorem is proved
by these language checks.
:::
