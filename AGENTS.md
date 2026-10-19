# Working on Clean

## Scope and design

- Keep this repository local. Do not create a remote, push, or publish without an explicit user request.
- Read `docs/spec.md` and `docs/decisions.md` before changing language behavior. Record new decisions and unresolved choices there; distinguish implemented behavior from proposals.
- The agreed architecture is explicit Clean definitions modules backed by Lean definitions. All mathematical vocabulary must come from explicit Clean imports. Do not reintroduce registry files, implicit default modules, or compatibility loaders. See `docs/notation-prototype.md` for current syntax and limits.
- Mathematical semantics must be module-declared, including operator overloads, literal interpretation, and type/function notation. Do not dispatch on display names such as Natural, Matrix, or Vector. Use a generic Lean-backed binding/elaboration mechanism; the current name-based paths are migration debt, not an approved architecture.
- Treat handwritten Clean readability as a first-class acceptance criterion. Review `docs/aspirational-syntax.md` alongside the formal grammar; changes need readable source specimens as well as unambiguous semantics. Do not treat proposed gallery syntax as already implemented or approved.
- Preserve mandatory attribution, readable English names, case-insensitive keywords, and explicit context references in LaTeX. Rendering must not change mathematical meaning.
- Statement translation does not constitute a proof. Never use `sorry` or axioms to make validation pass. Keep the limitations of the CLR-aligned corpus explicit.

## Hard language acceptance requirements

- Every proposed language change must satisfy [the language change acceptance contract](docs/language-change-acceptance.md): one specified syntax tree and one specified, fully elaborated Lean target for every accepted input under a fixed explicit environment. These are hard requirements, not aspirations or performance preferences.
- Add or update the grammar, lexical/layout rules, scope rules, and a constructive Clean-to-Lean rule for every affected syntax constructor. State why the parse and translation are unique; examples and passing tests alone are insufficient. Open policy choices affecting the feature block a claim that it is fully specified.
- Parsing may be expensive and may explore alternatives. Reject distinct valid parses as syntax ambiguity; never use type-checking success to choose a syntax tree. Reject distinct permitted Lean targets as semantic ambiguity unless an explicit normative rule selects one. Do not use incidental import order, iteration order, scheduling, cache state, or first-success heuristics to choose meaning.
- Uniqueness includes implicit arguments, coercions, instances, universes, literal/default interpretation, proof arguments, and From Lean adapters. A unique notation name or Lean code that merely compiles does not meet this requirement.
- Add independently authored expected trees and Lean-target/type oracles, negative/ambiguity cases, and interaction cases using [the acceptance catalog](tests/acceptance/language-contract.json) and its documented procedure. Compare canonical elaborated structures, not only pretty-printed output or definitional equality. Mark unimplemented checks pending; never describe them as passing.
- Resource exhaustion or an unresolved competing candidate means incomplete analysis, not success or a proven error. Report it separately. Document the fixed build environment and all intended inference policies.
- Before declaring an implementation conforming, run the applicable acceptance checks and Lean kernel validation, and record remaining gaps. Intermediate/failing commits are still permitted; this requirement gates conformance claims, not recording work in Git.

## Git workflow

- Inspect `git status` and the relevant diff before editing and before committing. Preserve unrelated user changes; never reset, discard, or overwrite them.
- Maintain a linear history that records intermediate steps, including experiments and unfinished implementations. Commit meaningful steps locally during authorized work; commits do not have to compile or pass tests. Describe the actual state and never claim unfinished features are complete.
- Prefer small chronological commits that preserve how the work evolved. Implementation, tests, documentation, and regenerated artifacts may land in successive commits; identify pending work in commit bodies when relevant.
- Use the configured Git identity. Do not change identity, amend existing commits, rewrite history, force-push, or switch branches with unrelated changes without explicit authorization.
- Work on the current branch by default. Preserve a single linear history; do not create merge commits, squash intermediate steps, or rebase recorded work. Ask before introducing a branching workflow.
- Review staged files and `git diff --cached --check` before committing. Report the commit and validation performed; state any checks that could not run.
- Exclude credentials, dependency checkouts, caches, virtual environments, and TeX build logs. Keep dependency lockfiles. Never add the Stewart book PDF.

## Validation and generated files

Checks document progress; they are not commit gates. Record known failures or checks not run for intermediate commits. Complete relevant validation before declaring a feature finished. The checks below apply across the work, not necessarily to every intermediate commit.

- For parser, translator, or rendering changes, run `python3 -m unittest discover -s tests -v` and check affected examples with the CLI.
- When Lean semantics or corpus entries change, regenerate `generated/VerifiedCorpus.lean` with `python3 verify_corpus.py` and run `lake env lean generated/VerifiedCorpus.lean`. Check changed standalone Lean examples too.
- For LaTeX changes, compile the affected specimen twice and check for errors, unresolved references, and layout problems.
- Keep the small generated Lean, TeX, metadata, and specimen PDFs tracked as reviewable examples. Regenerate them from source; do not hand-edit generated output. Generated files need not change for documentation-only work.
- `library/*.clean` are authored definition modules. `build_corpus.py` owns the curated corpus and source index. Change that generator when changing its output.
- Do not update Lean/Mathlib versions incidentally. Dependency upgrades require explicit rationale and renewed corpus validation.
