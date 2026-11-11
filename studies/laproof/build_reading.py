# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Assemble the study's implemented definitions into one readable Clean document.

This deliberately expands only the three named study imports, not arbitrary
Clean modules. Library imports retain their explicit, relative paths. Proposed
IEEE statements remain separate and are never converted into assumed results.
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
    return header + expand(HERE / 'Paper.clean') + '\n\n-- generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md\n'


if __name__ == '__main__':
    target = HERE / 'Paper-expanded.clean'
    target.write_text(reading_source())
    print(target)

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
