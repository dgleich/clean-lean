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
