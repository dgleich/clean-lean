# generated: gpt-6 2026-11-05 role=assisted; LLM-authored portions; see PROVENANCE.md
"""Deterministic source modes for comments and literate document payloads."""
from dataclasses import dataclass
import re
import textwrap

SENTINEL = '\ue000'
DIALECTS = {'plain', 'latex', 'typst'}

@dataclass(frozen=True)
class Prose:
    dialect: str
    body: str
    line: int
    attached: bool = False

class Prepared(str):
    def __new__(cls, value, prose):
        obj = super().__new__(cls, value)
        obj.prose = prose
        return obj


def scan(text):
    """Return masked physical lines, prose records, and typed highlight spans.

    Prose is replaced by private tokens consumed by the generated grammar.
    Neither imported vocabulary nor type checking participates in this scan.
    """
    from .core import CleanError
    lines = text.splitlines()
    for n, raw in enumerate(lines, 1):
        if '\t' in raw: raise CleanError(f'line {n}: tabs are not allowed')
        if SENTINEL in raw: raise CleanError(f'line {n}: reserved internal source character')
    output = list(lines)
    regions = [[] for _ in lines]
    records = {}
    openings = []
    row = 0

    def prose(first, last, column, dialect, body, attached=False):
        if dialect not in DIALECTS:
            raise CleanError(f'line {first+1}: unknown text dialect {dialect}')
        body = body.strip('\n')
        record = Prose(dialect, body, first+1, attached)
        records[first+1] = record
        for n in range(first, last+1):
            output[n] = ''
            regions[n] = [(0, len(lines[n]), 'documentation' if attached else 'prose')]
        output[first] = ' '*column + SENTINEL + ('D' if attached else 'T') + str(first+1)

    while row < len(lines):
        raw = lines[row]
        stripped = raw.lstrip(' ')
        column = len(raw)-len(stripped)
        # These modes only start at the first nonspace character of a physical line.
        if not openings:
            header = re.fullmatch(r'Text(?: +([A-Za-z]+))? *: *', stripped, re.I)
            triple = re.fullmatch(r'"""([A-Za-z]*) *', stripped)
            if header:
                end = row+1
                while end < len(lines) and (not lines[end].strip() or len(lines[end])-len(lines[end].lstrip(' ')) > column):
                    end += 1
                bodylines = lines[row+1:end]
                nonblank = [len(s)-len(s.lstrip(' ')) for s in bodylines if s.strip()]
                if not nonblank or min(nonblank) < column+2:
                    raise CleanError(f'line {row+1}: Text requires a body indented by at least two spaces')
                margin = min(nonblank)
                body = '\n'.join(s[margin:] if s.strip() else '' for s in bodylines)
                prose(row, end-1, column, (header[1] or 'plain').lower(), body)
                row = end
                continue
            if triple:
                end = row+1
                while end < len(lines) and lines[end].rstrip(' ') != ' '*column+'"""':
                    if lines[end].strip() and len(lines[end])-len(lines[end].lstrip(' ')) < column:
                        raise CleanError(f'line {end+1}: quoted text dedents before its closing delimiter')
                    end += 1
                if end == len(lines): raise CleanError(f'line {row+1}: unclosed triple-quoted text')
                body = '\n'.join(s[column:] if s.strip() else '' for s in lines[row+1:end])
                prose(row, end, column, (triple[1] or 'plain').lower(), body)
                row = end+1
                continue
            if stripped.startswith(('/--', '/-!')):
                attached = stripped.startswith('/--')
                end = row
                pos = column+3
                depth = 1
                pieces = []
                start = pos
                while depth:
                    if pos >= len(lines[end]):
                        pieces.append(lines[end][start:])
                        end += 1
                        if end == len(lines): raise CleanError(f'line {row+1}: unclosed documentation block')
                        pos = start = 0
                        continue
                    pair = lines[end][pos:pos+2]
                    if pair == '/-': depth += 1; pos += 2
                    elif pair == '-/':
                        depth -= 1
                        if depth == 0:
                            pieces.append(lines[end][start:pos])
                            pos += 2
                            if lines[end][pos:].strip():
                                raise CleanError(f'line {end+1}: documentation must end on its own source line')
                        else: pos += 2
                    else: pos += 1
                body = textwrap.dedent('\n'.join(pieces)).strip()
                prose(row, end, column, 'plain', body, attached)
                row = end+1
                continue
        masked = list(raw)
        quoted = False
        i = 0
        start = 0 if openings else None
        while i < len(raw):
            pair = raw[i:i+2]
            if openings:
                if pair == '/-': openings.append(row+1); i += 2
                elif pair == '-/':
                    openings.pop(); i += 2
                    if not openings:
                        regions[row].append((start, i, 'comment'))
                        masked[start:i] = ' '*(i-start)
                        start = None
                else: i += 1
                continue
            if not quoted and not ''.join(masked[:i]).strip() and re.match(r'(?:Means|From Lean|Render(?: latex)?)\s*:', raw[i:], re.I): break
            if raw[i] == '"': quoted = not quoted; i += 1
            elif not quoted and pair == '--':
                regions[row].append((i, len(raw), 'comment'))
                masked[i:] = ' '*(len(raw)-i)
                break
            elif not quoted and raw[i:i+3] in ('/--', '/-!'):
                raise CleanError(f'line {row+1}: documentation must start on its own source line')
            elif not quoted and pair == '/-': openings.append(row+1); start = i; i += 2
            elif not quoted and pair == '-/': raise CleanError(f'line {row+1}: unmatched block comment terminator')
            else: i += 1
        if openings:
            regions[row].append((start, len(raw), 'comment'))
            masked[start:] = ' '*(len(raw)-start)
        output[row] = ''.join(masked)
        row += 1
    if openings: raise CleanError(f'line {openings[0]}: unclosed block comment')
    return output, records, regions


def lean_documentation(prose, attached=False):
    # Do not allow source text to close the generated Lean documentation token.
    body = prose.body.replace('/-', '/ -').replace('-/', '- /')
    if prose.dialect != 'plain': body = '```'+prose.dialect+'\n'+body+'\n```'
    return ('/--' if attached else '/-!')+'\n'+body+'\n-/\n'


def latex_prose(prose):
    from .core import CleanError, textext
    if prose.dialect == 'typst':
        raise CleanError(f'line {prose.line}: Typst text cannot be rendered by the LaTeX backend')
    return prose.body if prose.dialect == 'latex' else textext(prose.body)+'\n\\par'
