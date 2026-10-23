"""Apply or check reviewed file classifications; never infer authorship of new files."""
import argparse
import json
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def marked(path, text, entry):
    model = entry.get('model', '')
    info = ' '.join(x for x in (model, '2026-10-23', 'role=assisted') if x)
    if entry['mode'] == 'markdown':
        return text if text.startswith(':::llm ') else f':::llm {info}\n\n' + text
    if entry['mode'] == 'html':
        if '<llm ' in text:
            return text
        attrs = f' model="{model}"' if model else ''
        text = text.replace('<body>', f'<body>\n<llm{attrs} date="2026-10-23" role="assisted" style="display:contents">', 1)
        text = text.replace('</body>', '</llm>\n</body>', 1)
        # Review notes are authored by the reader, not the page generator.
        text = re.sub(r'(<textarea\b[^>]*>.*?</textarea>)', r'<human>\1</human>', text, flags=re.S)
        return text
    if entry['mode'] == 'comment':
        marker = f'generated: {info}; LLM-authored portions; see PROVENANCE.md'
        if marker in text:
            return text
        prefix, suffix = entry['comment']
        # A file-scope trailing comment preserves source positions and shebangs.
        return text.rstrip('\n') + '\n\n' + prefix + marker + suffix + '\n'
    return text


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--apply', action='store_true')
    args = parser.parse_args()
    entries = json.loads((ROOT/'provenance.json').read_text())['files']
    tracked = set(subprocess.check_output(['git', 'ls-files'], cwd=ROOT, text=True).splitlines())
    missing = tracked - entries.keys() - {'provenance.json'}
    problems = [f'Unclassified: {p}' for p in sorted(missing)]
    changed = 0
    for name, entry in entries.items():
        path = ROOT/name
        if not path.exists():
            problems.append(f'Missing file: {name}')
            continue
        if entry['mode'] not in ('markdown', 'html', 'comment'):
            continue
        old = path.read_text()
        new = marked(path, old, entry)
        if old != new:
            if args.apply:
                path.write_text(new)
                changed += 1
            else:
                problems.append(f'Missing marker: {name}')
    print(f'Provenance: {len(entries)} classified files, {changed} marked, {len(problems)} problems')
    for problem in problems:
        print(problem)
    raise SystemExit(bool(problems))


if __name__ == '__main__':
    main()

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
