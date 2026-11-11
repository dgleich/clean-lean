# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Assemble the study's implemented definitions into one readable Clean document.

This deliberately expands only the three named study imports, not arbitrary
Clean modules. Library imports retain their explicit, relative paths. Proposed
IEEE statements are included as literal prose, never as assumed results.
"""
from pathlib import Path

HERE = Path(__file__).resolve().parent
PARTS = {name: HERE / name for name in ('Models.clean', 'Bounds.clean', 'CSR.clean')}


def reading_source():
    seen = set()

    def expand(path):
        lines = []
        for line in path.read_text().splitlines():
            target = next((name for name in PARTS if line == f'Import "{name}"'), None)
            if target is None:
                lines.append(line)
            elif target not in seen:
                seen.add(target)
                lines.extend(['', f'-- Begin definitions from {target}',
                              expand(PARTS[target]), f'-- End definitions from {target}', ''])
        return '\n'.join(lines)

    header = ('-- generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md\n'
              '-- Reading edition: regenerate with studies/laproof/build_reading.py.\n'
              '-- Implemented mathematics only; numbered paper theorems remain proposed.\n')
    draft = (HERE / 'Paper.clean.proposed').read_text().strip()
    appendix = ('\n\nText:\n'
                '  UNTRANSLATED DRAFT APPENDIX: the four paper theorems and FMA corollary.\n'
                '  Everything in this Text block is literal reading material.\n'
                '  Its imports are not loaded, its definitions are not registered,\n'
                '  and its results are not generated Lean statements or proofs.\n'
                '  The missing IEEE754 interface is a real completion obligation.\n'
                '  Source: Paper.clean.proposed; edit that file and regenerate.\n\n')
    appendix += '\n'.join('  ' + line if line else '' for line in draft.splitlines())
    return header + expand(HERE / 'Paper.clean') + appendix + '\n\n-- generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md\n'


if __name__ == '__main__':
    target = HERE / 'Paper-expanded.clean'
    target.write_text(reading_source())
    print(target)

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
