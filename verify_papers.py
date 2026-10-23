"""Regenerate translated paper statements and independent statement-shape checks.

The checks prove equality to separately authored propositions, not the paper results.
Run lake build CleanPapers.Definitions before checking the generated files.
"""
import json
from pathlib import Path
from cleanlang.core import Environment, lean, latex, bibliography
from cleanlang.modules import load_document

env = Environment()
results = load_document(Path('examples/recent-papers.clean'), env)
translated = lean(results, env, [])
Path('generated/RecentPapers.lean').write_text(translated)
checks = Path('tests/lean/paper_statement_checks.lean.inc').read_text()
Path('generated/CheckedPaperStatements.lean').write_text(translated + '\n' + checks)
Path('generated/recent-papers.tex').write_text(latex(results, env))
Path('generated/paper-references.tex').write_text(bibliography(results, env))
Path('generated/recent-papers.metadata.json').write_text(json.dumps([
    {'name': r.name, 'title': r.title, 'attribution': r.attribution,
     'resolved_attribution': env.sources.resolve(r.attribution)} for r in results
], ensure_ascii=False, indent=2) + '\n')
print(f'Generated {len(results)} paper statements and independent shape checks')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
