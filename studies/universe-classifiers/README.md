:::llm gpt-6 2026-11-10 role=assisted

# Proposal: explicit closed-universe carrier classifiers

Status: isolated syntax and declaration-metadata prototype with checked native
declaration targets, generic calls, first-class type values and native feasibility examples. **Generic implicit/explicit carrier arguments and first-class values are prototyped; the full classifier
feature is not conforming or integrated.** It is not part of the composed-language stack.

The original concrete gap was equality of a universe-1 topology object. Clean's general
carrier binder currently means Type 0, so a bundled space or homology theory
cannot instantiate it. Adding a special equality for each record would conceal
the missing generic capability. Conversely, treating every Universe: 1 object as
a type would be wrong: a topological space bundle is a value, not a classifier.

## Proposed declaration and meaning

```clean
Type LargeTypes():
  Universe: 2
  Classifies: 1
  Means: Type 1
  Render latex: \operatorname{{Types}}_1
```

`Universe: 2` says where the declared classifier itself lives. `Classifies: 1`
says that its elements are types living in Type 1. Its name is arbitrary. An
ordinary type declaration with Universe: 1 and no Classifies field is not a
classifier, regardless of its display name.

For this initial closed-universe design:

1. `Classifies: k` accepts the same canonical nonnegative integer grammar as
   Universe; no leading zeros except zero itself. Runtime integer exhaustion is
   incomplete analysis, not acceptance.
2. A classifier must be a closed, zero-parameter Type declaration with explicit
   Universe k+1 and Means equal to the primitive `Type k` spelling (`Type` is also
   accepted for k=0). Whitespace may separate Type and the level. Arbitrary Lean
   aliases or expressions in Means do not certify classifier status. Numerals
   and literal adapters cannot be attached to the classifier itself.
3. A transparent Clean type alias inherits the resolved classifier identity and
   level. An alias does not create a second native classifier. A new Type/Means
   declaration does create a distinct identity even if its Lean body is equal.
4. Existing Type must migrate to an explicit Classifies: 0 declaration. Carrier
   recognition must use resolved metadata, not the visible name `Type` or a
   heuristic based on a declaration's universe alone.

This is not general Lean universe polymorphism: levels are closed integers, not
runtime natural arguments or unconstrained universe metavariables.

## Binding and exact inference

`Let A: LargeTypes` in a generic declaration introduces a carrier parameter at
level 1. Later `Let x: A` uses that local carrier, retaining its level and binding
identity. Inference of A from an actual argument x uses x's checked carrier type
and requires that carrier's level to equal 1 exactly. No implicit universe lift
or coercion is introduced. All matching declared overloads must still be
considered; two permitted targets remain an ambiguity.

The existing distinction between declaration parameters and statement binders is
preserved explicitly: a generic classifier parameter lowers to the primitive
`(A : Type k)`; an ordinary statement binder retains its declared classifier
wrapper. A local carrier reference lowers to the corresponding bound Lean
variable. A dependent record field is handled by the same classifier metadata;
its element field retains the selected carrier level. Record sort checking uses
the actual field sorts, not a blanket Type-0 assumption for local types.

For example `equal large` can take `{A : Type 1}` and two values of A. That permits
equality of bundled topology objects. Equality of two *types* A,B : Type 1 needs
a different generic carrier binder at level 2, because the carrier Type 1 itself
lives in Type 2. The first native draft incorrectly used level-1 equality there;
Lean rejected it. The checked example now distinguishes these levels explicitly.

## First-class type expressions

The syntax prototype extends the reserved expression form with an optional
explicit classifier:

```text
type value := TYPE_VALUE "(" type_ref [":" type_ref] ")"
```

`type(TopologicalSpace : LargeTypes)` has source tree
`[ClassifiedTypeValue, TopologicalSpace, LargeTypes]`. The first reference must
resolve to a carrier type; the second to a classifier. Their closed levels must
agree. The result's Clean type is the selected classifier and its Lean term is
the resolved native carrier expression, with no coercion or lift inserted.

For the unannotated `type(T)` form, collect all visible resolved classifier
identities at T's checked level. Exactly one is required. Zero is a missing
classifier error; more than one is semantic ambiguity, resolved by the annotated
form. Transparent aliases are deduplicated by resolved identity. Import order
cannot select a classifier. The existing source tree for this form is unchanged;
its selected identity must be retained during elaboration and serialization.

The colon is at the outer type-value parentheses; commas and binder colons inside
nested type references retain their ordinary roles. A second outer colon or
comma is invalid. The syntax prototype passes strict generated-parser checks;
it does not use successful type checking to choose a parse. `Classifies` is a
metadata field, not an expression operator or mathematical function.

## Constructive native correspondence

For each well-formed classifier at level k, emit its declared native abbreviation
with result sort Type(k+1) and body Type k. Generic carrier binders use the primitive
Type k; statement bindings use the chosen native classifier abbreviation. Every
local carrier records its closed level. Type references, dependent callable
arguments and structures preserve those identities and levels through capture
and substitution. First-class carrier values emit the selected native type term;
the selected classifier determines their checked type, not an extra runtime term.

These rules determine one target provided the underlying inline binding and
native-adapter contracts are satisfied. They do not discharge those existing
contracts or permit changing a classifier's metadata during a traversal.

[Targets.lean](Targets.lean) checks the proposed layers natively, including a
universe-2 record containing a universe-1 carrier and an element of it. It proves
three reflexivity results. These are handwritten feasibility examples, **not**
independent expected targets compared with an implemented translator.
[Example.clean.proposed](Example.clean.proposed) is an authored design specimen,
not a compilable complete module or a claim that its imports are available.

## Required implementation audit

The complete migration must cover at least the following consumers (the new
carrier patch addresses only part of this audit):

| Consumer | Required change |
|---|---|
| modules.py | Declaration kinds, implicit/explicit signatures and classifier validation |
| core.py | Local type recognition, sort calculation, required carrier level, inference and type-value expressions |
| carrier_types.py | Local/module distinction and first-class carrier values |
| structures.py | Dependent carrier fields, constructor parameters and universe bounds |
| dependent_functions.py | Binder domains and dependent substitution |
| conversion.py / contextual_keys.py | Inferred carrier reification, comparison identities and typed scope |
| inferred_conversion.py / hygiene.py | Capture-avoiding carrier substitution with closed levels |
| retained literal and codec prototypes | Checked annotations and LocalType payloads must preserve level and classifier identity |

Production LocalType carries no level, and sort_level(LocalType) returns Type 0.
The carrier patch now retains a level and classifier identity, and uses them in
local sort calculation, dependent type keys and checked substitution.
Changing only the equality module or the type-value parser therefore cannot fix
this gap. The codec's versioned record schema must change deliberately; old
payloads must not silently default a higher carrier to level zero.

Acceptance still requires independently authored source trees and canonical
native targets for arbitrary classifier names, aliases, local/module shadowing,
implicit inference, dependent records/callables, typed literals and serialization.
Negative cases must include wrong levels, an ordinary bundle used as a classifier,
multiple classifier candidates, insufficient record universes and stale metadata.
Editor/browser coverage and full regression are also pending.

Validation on 2026-11-10: the pinned reproduction passed strict parser generation,
reproducibility checking and 45 syntax/existing type-value tests in 24.085 seconds.
The native file compiled with its three proofs. That initial run covered syntax only. The metadata extension below adds
declaration validation; elaborating ClassifiedTypeValue remains pending.

## Declaration metadata implementation

The isolated `metadata.patch` validates Classifies before installing a declaration.
It rejects parameters, missing/wrong successor universes, noncanonical levels,
nonprimitive or mismatched native bodies, and Numerals on classifiers. Invalid
classifier metadata leaves both the type table and native declarations unchanged.
`classifier_metadata(env, spelling)` resolves a closed type reference through
transparent aliases and returns `(native_binding, classified_level)`, or None for
an ordinary type. It does not classify by display name or universe alone. Distinct
native declarations retain distinct identities; aliases resolve to the same one.
This query does not yet select candidates for unannotated type expressions.

The extension adds negative and identity tests plus three independently written
native declaration oracles at classified levels 0, 1 and 2. Exact comparisons check
both elaborated declaration types and bodies. The metadata extension alone does not validate generic carrier bindings. The
subsequent carrier extension below addresses implicit calls; first-class type
expressions, structures and stored local types remain pending. In both cases,
the working compiler is unchanged. The expanded pinned reproduction passed
76 selected tests in 29.745 seconds, strict parser generation/reproducibility,
three exact declaration targets and the three native feasibility proofs.
Full unittest discovery is running separately in the isolated metadata checkout;
its result remains pending.

## Implicit carrier arguments and topology objects

`carriers.patch` follows the syntax and metadata patches; `carrier-fixtures.patch`
migrates the selected historical regression fixtures to explicit classifier metadata. It migrates the library's
Type declaration to explicit Classifies: 0, recognizes local carrier variables
through resolved metadata, and retains their closed level and native classifier
identity. Their comparison keys include both fields. Substituting a carrier checks
its required level; substituting a type-valued expression also checks classifier
identity. Implicit generic calls match a checked operand's carrier at exactly the
declared level, with no automatic lift. Native implicit binders use primitive
Type k, and inferred native arguments are the checked carrier expressions.

[CarrierExample.clean](CarrierExample.clean) is a compilable specimen **in this
isolated patch stack**. It imports the real topology module, authors a generic
`retain` operation directly in Clean for any Type-1 carrier, composes it in Clean as `retain twice`,
and states that retaining a bundled topology object twice preserves that object.
`equal large` is generic over carriers; it is not a special equality for TopCat.
[CarrierTargets.lean](CarrierTargets.lean) checks five independent canonical
native types/bodies and proves the resulting theorem by reflexivity. This is
translator evidence for that path, not just a handwritten Lean feasibility test.

A whole-document test exposed a gap in the earlier syntax-only prototype:
Classifies had been added to FIELD but not FIELD_LINE. The carrier patch updates
the document token and tests loading a complete classifier module. Strict parser
regeneration remains required. Fifteen dedicated carrier tests pass, including repeated-argument agreement,
classifier-preserving substitution and reifying higher local binders. Tests also
cover exact-level rejection, alias
resolution, ordinary bundles rejected as carrier binders, local higher-carrier
arguments, level/identity-sensitive keys and substitution.

Remaining boundaries include higher computed
carriers, first-class type-value elaboration, classifier candidate ambiguity,
carrier-valued dependent function binders, record fields/constructors and codec
schema migration. Some legacy Type-name checks remain in those paths. The
prototype explicitly rejects higher computed carriers and carrier-valued dependent
function binders; passing this specimen does not make those paths supported.
The first expanded run had four failures and 27 errors: manual LocalType fixtures
lacked classifier identity, and the type-identity foundation omitted Classifies.
The fixture patch supplies those fields without weakening assertions. All 72
checks in the affected groups then passed in 14.740 seconds. The 92 generated
corpus proof fixtures also compile with this stack. The fresh expanded reproduction then passed 217 selected tests in 66.927 seconds,
strict parser/reproducibility checks and native checks. Three additional carrier
checks were subsequently added; all 15 dedicated carrier tests passed in 0.292
seconds. The fully Clean-authored retain specimen was independently regenerated
and passed its five exact targets and proof. Unrestricted regression is running
on the earlier specimen/test snapshot; its result remains pending.
The fixture patch now covers thirteen files: the four regression files with
manual LocalType values and nine standalone study foundations declaring Type.
It supplies closed level zero and the selected classifier identity, and adds
explicit Universe/Classifies fields to the foundations. No mathematical assertion
or rejection expectation is removed. The additional linear-space, value-index and
standard-operator groups pass 29 tests in 7.219 seconds.

Native validation on the migrated stack additionally passes 38 exact foundation
targets/six proofs, 17 saved-expression targets/three proofs, and 12 dispatch
targets/one proof. These checks cover retained meanings, generic carrier calls,
ambiguity/order independence and incomplete-analysis rejection. The verifier now
includes all three native suites and the extra regression groups. A fresh pinned
reproduction passed all 249 selected tests in 81.525 seconds. The acceptance
catalog separates this checked implicit-carrier specimen from the still-pending
explicit type-value expression, and the native driver also checks its independent
source conclusion tree.

Three older historical verifiers remain unsuitable as green current-compiler
evidence without further migration. Native-type-bindings and qualified-globals
fail for a missing explicit equality operator on both the working compiler and
this stack. The older carrier-fields bound-operator verifier produces the same
six canonical/missing-target errors on the metadata-only baseline and this stack;
its inline native expectations predate the integrated wrapper targets. These
failures were not hidden or converted to passing checks. The contemporary saved-
expression verifier above has independent wrapper-aware targets and passes.
Unrestricted regression is still pending on the earlier fixture snapshot; none
of these selected results claims a complete full-suite pass.
No production compiler integration or full language conformance is claimed.

Lexical Classifies highlighting is provided for VSCode/TextMate, Vim, Emacs and
the browser tokenizer. Native TextMate and Vim checks and five browser checks
pass. The Emacs test is authored but native execution remains unavailable because
the local runtime fails its own startup check. The complete browser snapshot has
not been regenerated. Highlighting does not enable the syntax in production.

## Explicit carrier arguments

`explicit-carriers.patch` extends the same declaration rule to explicit generic
parameters. [ExplicitCarrierExample.clean](ExplicitCarrierExample.clean) authors
identity and composition directly in Clean:

```clean
Define retain large(A,x):
  Let A: LargeTypes
  Let x: A
  Returns: A
  Equals: x
```

The declaration lowers to `(A : Type 1) (x : A) : A`. Calling it with a local
`A: LargeTypes` checks that classifier identity first, then checks the later
argument against the supplied carrier. A different classifier at the same level
is not silently converted. A transparent alias of LargeTypes is accepted because
it resolves to the same identity. This mechanism works at level zero with any
classifier name; it no longer depends on the spelling Type to recognize an
explicit generic argument. Notation/Define parameter types now resolve through
the explicit environment, so the word Type alone supplies no hidden foundation.

Implicit and explicit generic parameters share one lowering rule: primitive
Type k, with the corresponding Lean binder visibility. The declaration's return
type and ordinary theorem binders retain their declared wrappers. This deliberately
changes the canonical domain of old explicit Type parameters from the native
classifier abbreviation to primitive Type. The two dispatch body oracles affected
by this rule are migrated in `explicit-oracles.patch`; their initial two exact-
target failures are recorded, not bypassed with definitional equality.

The callable telescope is processed in order. Explicit carrier arguments bind
their resolved checked carrier before later argument types are compared. Grouped
Let parameters share a type resolved before introducing the group. Implicit
parameters still precede explicit arguments in the declaration telescope. Compact
and expanded signatures use the same processing. No new grammar production or
parse-time type selection is introduced.

Eleven dedicated tests cover levels 0–2, arbitrary names, aliases, mixed explicit/
implicit parameters, grouped carriers, normalization, missing foundations and
wrong carrier/classifier arguments. With existing dependent-call, record and
small type-expression groups, 98 tests passed in 22.582 seconds. The independent
native driver checks two conclusion trees, six exact declaration/theorem targets
and two reflexivity proofs. It distinguishes primitive generic binders from
wrapped statement binders in its handwritten oracles. The fresh pinned stack
passed 260 selected tests in 91.449 seconds. The 92 generated corpus proofs also
compile after the explicit-binder change. Unrestricted discovery is running in
a separate checkout of this stack; its result remains pending.

This implements explicit **locally supplied carrier values**. Constructing a
higher carrier value with `type(T : C)`, reifying an inferred higher module type
as a source expression, and carrier-valued dependent fields/callables remain
pending. Their absence can still block conversion of an authored body that uses
an inferred carrier in an explicit value position. Record/type-constructor
parameter handling and the storage schema need their own full audit. This is
still an isolated prototype, not production conformance.

## Current first-class value boundary

The later [first-class value implementation](type-values.md) implements explicit
and uniquely selected unannotated carrier expressions, retained classifier identity
and inferred-carrier reification. Earlier “pending” descriptions above record the
preceding prototype stages. Review [TypeValueExample.clean](TypeValueExample.clean),
its exact native targets and the rendered PDF for the current checked example.
Storage/schema migration, higher carrier fields/callables, full regression and
production integration remain pending.

Reproduce the isolated stack and selected checks:

```sh
LAKE=lake python3 studies/universe-classifiers/verify.py
# Add --full for unrestricted unittest discovery after selected checks.
```
:::
