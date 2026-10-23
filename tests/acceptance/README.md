:::llm 2026-10-23 role=assisted

# Language acceptance cases

These cases support the hard [language change acceptance contract](../../docs/language-change-acceptance.md). The catalog is a set of specification oracles, not an executable test runner or a list of passing tests. The original general-language cases remain `pending`. The authored-definition slice is `partial`: its executable checks cover three expression trees and three canonical Lean targets/types, while its remaining obligations are recorded explicitly.

A language-change implementation must supply a concrete environment and complete source fixture for each applicable case, parse it, compare the reviewed expected tree, elaborate the independently authored Lean target and the implementation's target under the same pinned environment, and compare canonical target structures and types. It must also run Lean kernel validation and the ambiguity/resource cases required by the contract. Fragments in this initial catalog must be expanded into complete fixtures before execution. Do not derive expected output by snapshotting the implementation under test.

Record the check command, environment fingerprint, observed outcome, and any incomplete analysis when executable coverage is added. A JSON-validation check only checks the catalog's format; it does not establish parser or translator conformance. Likewise, the existing paper proposition-equality checks establish useful shape equivalences but do not replace canonical expression comparisons.

New cases should cover both a feature's intended use and combinations that could accidentally admit another parse or Lean meaning. Consult `AGENTS.md` before accepting a language change or claiming that its implementation satisfies this contract.

The bounded runner is `python3 verify_definitions.py` followed by
`lake env lean generated/VerifiedDefinitions.lean`. It compares independently
specified bodies under the pinned environment. It normalizes only metadata and
binder names and uses `Expr.equal`, not `Expr.eqv` (which ignores binder
annotations), `rfl`, or a definitional-equality procedure. The runner currently
requires matching universe parameter lists; it does not claim general canonical
universe renaming support. Its two negative guards detect a lost binderInfo check
and an accidental reduction-based comparison.
