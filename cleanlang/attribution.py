"""Compact attribution syntax and shared bibliographic metadata."""
import json
import re
from pathlib import Path

RELATIONSHIPS = {'direct', 'specialized', 'adapted', 'original'}


def compact(text):
    parts, current = [], []
    quoted = escaped = False
    for char in text:
        if escaped:
            if char not in ('"', '\\'): current.append('\\')
            current.append(char); escaped = False
        elif quoted and char == '\\': escaped = True
        elif char == '"': quoted = not quoted
        elif char == ';' and not quoted:
            parts.append(''.join(current).strip()); current = []
        else: current.append(char)
    if quoted or escaped: raise ValueError('Unterminated quoted attribution value')
    parts.append(''.join(current).strip())
    if len(parts) < 2 or not all(parts) or text.rstrip().endswith(';'):
        raise ValueError('Expected Attribution: source; reference [; relationship] [; field: value]')
    data = {'source': parts[0], 'reference': parts[1]}
    for i, part in enumerate(parts[2:]):
        if ':' not in part:
            if i != 0 or part.lower() not in RELATIONSHIPS:
                raise ValueError('Expected a relationship immediately after the reference, or field: value')
            key, value = 'relationship', part.lower()
        else:
            key, value = part.split(':', 1)
            key, value = key.strip().lower(), value.strip()
            if key == 'relationship': value = value.lower()
        if not re.fullmatch(r'[a-z_]+', key) or not value:
            raise ValueError('Expected nonempty field: value')
        if key in data: raise ValueError('Duplicate attribution field: ' + key)
        data[key] = value
    return data


def normalize(data):
    data = dict(data)
    for alias in ('location', 'declaration'):
        if alias in data:
            if 'reference' in data: raise ValueError('Use only one reference, location, or declaration field')
            data['reference'] = data.pop(alias)
    missing = {'source', 'reference'} - data.keys()
    if missing: raise ValueError('attribution missing ' + ', '.join(sorted(missing)))
    if any(not str(v).strip() for v in data.values()): raise ValueError('Attribution fields must be nonempty')
    if 'relationship' in data:
        data['relationship'] = data['relationship'].lower()
        if data['relationship'] not in RELATIONSHIPS: raise ValueError('Unknown attribution relationship')
    return data


class Sources:
    def __init__(self):
        self.entries = {}
        self.references = {}
        self.loaded_bibtex = set()

    def import_bibtex(self, path):
        """Read bibliography data only; never load mathematical declarations."""
        path = Path(path).resolve()
        if path in self.loaded_bibtex:
            return
        try:
            from pybtex.database import parse_string
            from pybtex.exceptions import PybtexError
            from pybtex.richtext import Text
        except ImportError as e:
            raise ValueError('BibTeX imports require the bibtex extra: pip install -e ".[bibtex]"') from e
        import hashlib
        raw = path.read_text(encoding='utf-8')
        try:
            data = parse_string(raw, 'bibtex')
            pending = {}
            for key, entry in data.entries.items():
                if key in self.entries:
                    raise ValueError('Duplicate source: '+key)
                fields = dict(entry.fields)
                # Cross-reference inheritance needs a separate, explicit policy.
                if 'crossref' in fields or 'xdata' in fields:
                    raise ValueError('BibTeX crossref/xdata inheritance is not yet supported: '+key)
                if not fields.get('title', '').strip():
                    raise ValueError('BibTeX source missing title: '+key)
                plain = lambda value: Text.from_latex(value).render_as('text')
                source = {name: plain(value) for name, value in fields.items()}
                for role, people in entry.persons.items():
                    source[role] = ' and '.join(plain(str(person)) for person in people)
                # Keep links byte-for-byte rather than treating them as prose TeX.
                for name in ('url', 'doi'):
                    if name in fields:
                        source[name] = fields[name]
                source.update(kind='book' if entry.type == 'book' else 'other', label=key)
                source['bibtex'] = {
                    'key': key, 'entry_type': entry.type, 'fields': fields,
                    'persons': {role: [str(p) for p in people] for role, people in entry.persons.items()},
                    'file': path.name, 'sha256': hashlib.sha256(raw.encode('utf-8')).hexdigest(),
                }
                pending[key] = source
        except PybtexError as e:
            raise ValueError(f'{path}: invalid BibTeX: {e}') from e
        # A failed import must not register a partial bibliography.
        self.entries.update(pending)
        self.loaded_bibtex.add(path)

    def declare(self, key, source, directory):
        if key in self.entries:
            raise ValueError('Duplicate source: '+key)
        if source.get('kind') not in ('lean', 'book', 'other'):
            raise ValueError('Source kind must be lean, book, or other: '+key)
        for required in ('title', 'label'):
            if not source.get(required): raise ValueError('Source missing '+required+': '+key)
        if 'references' in source:
            self.references[key] = json.loads((directory / source['references']).read_text())
        self.entries[key] = source
    def resolve(self, data):
        key, ref = data['source'], data['reference']
        if key not in self.entries: raise ValueError('Unknown attribution source: ' + key)
        source = self.entries[key]
        resolved = {'source_key': key, 'source': source, 'reference': ref}
        if source['kind'] == 'lean':
            if ref not in self.references.get(key, {}):
                raise ValueError('Unknown declaration for ' + key + ': ' + ref)
            if source.get('revision') and self.references[key][ref].get('revision') != source['revision']:
                raise ValueError('Source revision mismatch for ' + key + ': ' + ref)
            resolved['declaration'] = ref
            resolved.update(self.references[key][ref])
        elif source.get('url'):
            resolved['url'] = source['url']
        return resolved
