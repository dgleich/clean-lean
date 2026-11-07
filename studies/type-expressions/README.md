:::llm gpt-6 2026-11-07 role=assisted

# Explicit types as constructor arguments

[Statements.clean](Statements.clean) uses `type(Real)`, `type(Vector(n,Real))`
and a dependent vector-family type as explicit constructor arguments. The Box
record stores a value of its declared carrier. The file imports only the shared
types module; no topology module is needed. Every packing definition is authored
in Clean. This is a language acceptance specimen, not a theorem from the research
papers.

```clean
Define vector box(n,v):
  Let n: Natural
  Let v: Vector(n,Real)
  Returns: Box(Vector(n,Real))
  Equals: pack(type(Vector(n,Real)),v)
```

The [type-expression contract](../../docs/type-expressions.md) specifies the unique
AST, Type 0 gate, structural substitution, comparison and Lean mapping. Concrete
types use the same source grammar as annotations. Inferred compound carriers can
now enter authored expansion, too. Named Type locals continue to work.

Run `LAKE=lake python3 studies/type-expressions/verify.py` from the repository.
[Generated.lean](Generated.lean) contains the generated definitions and statements.
[Verified.lean](Verified.lean) adds independently authored native oracles and three
proofs. Eight exact comparisons cover five packing definitions and three propositions.
Only declared generated-name linkage, binder names and metadata are normalized;
target comparison does not accept arbitrary definitionally equal alternatives.

The real and vector field equations emit x=x and v=v under the existing explicit
constructor-projection rule. The function-family statement retains its two packing
calls and its equality assumption. The native oracle records these different
emission cases explicitly. The proofs contain no axioms or sorry.

Main integration validation: 116 focused Python tests pass, including nineteen
new type-expression cases. Eight exact targets, three proofs, all 92 corpus proof
fixtures and the strict generated-parser check pass. The shared-types-only specimen
compiles without a topology import. The PDF compiles twice and was inspected;
reference search, local links and mobile width pass. VS Code/browser keyword
highlighting and native Vim highlighting pass. Emacs syntax is updated, but Emacs
is unavailable for a native runtime check.

The earlier full run loaded an obsolete certificate-opacity assertion; its
replacement passes the fifteen-test conversion module. A fresh full run of the
final source, native-study regeneration and browser refresh are pending. The
separate integration-copy run remains useful regression evidence but predates the
final operator rejection guard and the specimen's reduced import list.

Computed types as carrier arguments, Type-valued local definitions, universe polymorphism and
application of named universal evidence are separate unfinished features. The
subpath prototype exercises the new syntax, but interval clipping and basis
restriction are not established by this specimen.
:::
