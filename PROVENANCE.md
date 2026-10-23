:::llm gpt-6 2026-10-23 role=assisted

# LLM provenance

Clean is a human-directed, LLM-assisted prototype. David Gleich directed the
language design; assistants drafted the implementation, explanations, and examples.
The markers identify assistant-authored material, not ownership of the underlying
mathematics or human adoption of the generated output.

This repository uses the [LLM provenance-tagging skill](https://github.com/dgleich/llm-markdown-and-markup/blob/main/SKILL.md).
Markdown has `:::llm` regions; HTML has transparent `llm` elements. Source files
use syntax-safe `generated:` comments. A trailing source comment describes the
LLM-authored portions of that file and preserves existing source line numbers.
The machine-readable companion [provenance.json](provenance.json) identifies
files that cannot contain comments and distinguishes copied data from authored text.

Markers added on 2026-10-23 are retrospective: the date is the tagging date,
not a claim about when each sentence was written. Earlier model identifiers are
not established here and are omitted. Newly authored sorting/provenance documents
identify gpt-6. Existing Git history is preserved: old commits predate these tags;
only the tagged current tree is the publication snapshot. No human review or
adoption is implied.

## Origin boundaries

- Mathlib's license is upstream content, unmodified and untagged.
- `corpus/catalog.json` mixes assistant curation and adapted Clean statements with
  verbatim upstream `source_excerpt` fields. Those excerpts, declaration names,
  source locations, and revision identifiers remain upstream data. The sidecar
  records this exception rather than labelling the entire JSON object as LLM text.
- Bibliographic facts, titles, author names, citation keys, mathematical source
  identifiers, and quotations retain their cited origins wherever rendered.
  LLM tags apply to drafted explanations and adaptations, not those copied facts.
- Generated Lean/TeX and PDFs inherit the origin of the authored Clean statements
  and their cited sources. Deterministic translation adds no new LLM authorship.
  PDF specimens include a visible provenance notice; source markup and this sidecar
  provide the detailed boundaries. Bibliography renderings remain source data.
- Lockfiles and the toolchain pin are dependency metadata, not generated prose.
- Reader-entered review notes are human content; they stay in browser storage unless
  the reader exports them. They are not part of the published snapshot.

The sidecar is an explicit reviewed inventory, not an authorship detector.
For new files, classify the origin before adding an entry. After regeneration run
`python3 tools/provenance.py --apply`, rebuild the review page if its source files
changed, and run `python3 tools/provenance.py`. The check verifies coverage and
markers; it cannot establish that an authorship assertion is true.
