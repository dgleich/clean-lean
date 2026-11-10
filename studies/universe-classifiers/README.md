:::llm gpt-6 2026-11-10 role=assisted

# Proposal: explicit closed-universe carrier classifiers

Status: proposed semantics with a checked syntax prototype and native feasibility
examples. **Carrier-classifier elaboration is not implemented**, and this is not a
Clean-to-Lean conformance claim. It is not part of the composed-language stack.

The concrete gap is equality of a universe-1 topology object. Clean's general
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

The current hardcoded carrier-kind checks affect at least:

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

LocalType currently carries no level, and sort_level(LocalType) returns Type 0.
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
The native file compiled with its three proofs. The prototype does not validate
Classifies metadata semantically or elaborate ClassifiedTypeValue; those checks
remain required before any language-acceptance claim.

Reproduce syntax and native feasibility only:

```sh
LAKE=lake python3 studies/universe-classifiers/verify.py
```
:::
